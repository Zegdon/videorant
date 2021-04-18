import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { UsersComponent } from './users/users.component';
import { CustomerComponent } from './customer/customer.component';
import { ItemComponent } from './item/item.component';
import { RentMakeComponent } from './rent-make/rent-make.component';
import { DelayComponent } from './delay/delay.component';

@NgModule({
  declarations: [
    AppComponent,
    UsersComponent,
    CustomerComponent,
    ItemComponent,
    RentMakeComponent,
    DelayComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
