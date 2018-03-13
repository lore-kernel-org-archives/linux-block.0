Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4269 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbeCMOK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 10:10:29 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jaco@uls.co.za" <jaco@uls.co.za>
CC: "pieterk@uls.co.za" <pieterk@uls.co.za>
Subject: Re: disk-io lockup in 4.14.13 kernel
Date: Tue, 13 Mar 2018 14:10:25 +0000
Message-ID: <1520950225.2921.0.camel@wdc.com>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
         <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
         <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
         <1520737695.8740.4.camel@wdc.com>
         <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
         <1520744455.8740.9.camel@wdc.com>
         <0d5c21c2-4fea-5870-e971-f90556fb4141@uls.co.za>
In-Reply-To: <0d5c21c2-4fea-5870-e971-f90556fb4141@uls.co.za>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE4LTAzLTEzIGF0IDExOjMwICswMjAwLCBKYWNvIEtyb29uIHdyb3RlOg0KPiBP
biAxMS8wMy8yMDE4IDA3OjAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gRGlkIEkgc2Vl
IGNvcnJlY3RseSB0aGF0IC9kZXYvc2RtIGlzIGJlaGluZCBhIE1QVCBTQVMgY29udHJvbGxlcj8g
WW91IG1heQ0KPiA+IHdhbnQgdG8gY29udGFjdCB0aGUgYXV0aG9ycyBvZiB0aGlzIGRyaXZlciBh
bmQgQ2MgdGhlIGxpbnV4LXNjc2kgbWFpbGluZw0KPiA+IGxpc3QuIFNvcnJ5IGJ1dCBJJ20gbm90
IGZhbWlsaWFyIHdpdGggdGhlIG1wdDNzYXMgZHJpdmVyIG15c2VsZi4NCj4gDQo+IFlvdSBkaWQg
c2VlIGNvcnJlY3RseSwgYWxsIGRyaXZlcyBhcmUgYmVoaW5kIHRoZSBNUFQgU0FTLiAgSWYgdGhl
cmUgaXMNCj4gaW4gZmFjdCBhIHByb2JsZW0gd2l0aCB0aGUgZHJpdmVyIChvciB0aGUgY29udHJv
bGxlciBpdHNlbGYgZm9yIHRoYXQNCj4gbWF0dGVyKSBpdCB3b3VsZCBleHBsYWluIHRoaW5ncy4g
IEl0IHdvdWxkIGFsc28gZXhwbGFpbiB3aHkgd2UgZG9uJ3Qgc2VlDQo+IHRoaXMgcHJvYmxlbSBv
biBvdGhlciBob3N0cy4NCg0KWW91IG1heSB3YW50IHRvIGhhdmUgYSBsb29rIGF0IHRoZSBmb2xs
b3dpbmcgcmVwb3J0LCBzb21ldGhpbmcgSSByYW4gaW50bw0KbXlzZWxmIHllc3RlcmRheTogaHR0
cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtc2NzaSZtPTE1MjA4NzkwNDAyNDE0Ni4NCg0KQmFydC4N
Cg0KDQoNCg==
