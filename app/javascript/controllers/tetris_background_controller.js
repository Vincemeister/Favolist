import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["board"];

  async connect() {
    this.initBoard();
    this.images = await this.loadImages();
    this.startFallingBlocks();
    window.addEventListener("resize", () => this.initBoard());
  }


  initBoard() {
    this.board = this.boardTarget.getContext("2d");
    this.board.canvas.width = window.innerWidth;
    this.board.canvas.height = window.innerHeight;
  }

  startFallingBlocks() {
    const images = this.loadImages();

    setInterval(() => {
      const randomImage = images[Math.floor(Math.random() * images.length)];
      console.log("Random image:", randomImage);
      this.spawnBlock(randomImage);
    }, 1000);
  }

  
  loadImages() {
    const imagesData = this.data.get("images");
    const productImages = JSON.parse(imagesData);

    const loadedImages = productImages.map(src => {
      const img = new Image();
      img.src = src;
      return img;
    });

    console.log("Loaded images:", loadedImages);
    console.log("Loaded images array length:", loadedImages.length); // Add this line
    return loadedImages;
  }



  spawnBlock(image) {
    console.log("spawnBlock called with image:", image);

    if (!image || !image.complete) {
      if (image) {
        image.onload = () => {
          this.spawnBlock(image);
        };
      }
      return;
    }


    const blockSize = 50;
    const x = Math.floor(Math.random() * (this.board.canvas.width - blockSize));

    const block = {
      img: image,
      x: x,
      y: -blockSize,
      width: blockSize,
      height: blockSize,
      speed: 1,
    };

    const fall = () => {
      block.y += block.speed;
      this.board.clearRect(0, 0, this.board.canvas.width, this.board.canvas.height);
      this.board.drawImage(block.img, block.x, block.y, block.width, block.height);

      if (block.y < this.board.canvas.height) {
        requestAnimationFrame(fall);
      }
    };

    fall();
  }

}
