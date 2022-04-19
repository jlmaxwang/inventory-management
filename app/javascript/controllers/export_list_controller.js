import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "list", "searchInput" ]

  connect() {
    console.log(this.element);
    console.log(this.formTarget);
    console.log(this.listTarget);
    console.log(this.searchInputTarget);
  }
}
