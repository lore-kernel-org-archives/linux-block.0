Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23763 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeCKDIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Mar 2018 22:08:20 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jaco@uls.co.za" <jaco@uls.co.za>
CC: "pieterk@uls.co.za" <pieterk@uls.co.za>
Subject: Re: disk-io lockup in 4.14.13 kernel
Date: Sun, 11 Mar 2018 03:08:16 +0000
Message-ID: <1520737695.8740.4.camel@wdc.com>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
         <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
         <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
In-Reply-To: <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE4LTAzLTEwIGF0IDIyOjU2ICswMjAwLCBKYWNvIEtyb29uIHdyb3RlOg0KPiBP
biAyMi8wMi8yMDE4IDE4OjQ2LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gT24gMDIvMjIv
MTggMDI6NTgsIEphY28gS3Jvb24gd3JvdGU6DQo+ID4gPiBXZSd2ZSBiZWVuIHNlZWluZyBzcG9y
YWRpYyBJTyBsb2NrdXBzIG9uIHJlY2VudCBrZXJuZWxzLg0KPiA+IA0KPiA+IEFyZSB5b3UgdXNp
bmcgdGhlIGxlZ2FjeSBJL08gc3RhY2sgb3IgYmxrLW1xPyBJZiB5b3UgYXJlIG5vdCB5ZXQgdXNp
bmcNCj4gPiBibGstbXEsIGNhbiB5b3Ugc3dpdGNoIHRvIGJsay1tcSArIHNjc2ktbXEgKyBkbS1t
cT8gSWYgdGhlIGxvY2t1cCBpcw0KPiA+IHJlcHJvZHVjaWJsZSB3aXRoIGJsay1tcSwgY2FuIHlv
dSBzaGFyZSB0aGUgb3V0cHV0IG9mIHRoZSBmb2xsb3dpbmcNCj4gPiBjb21tYW5kOg0KPiA+IA0K
PiA+IChjZCAvc3lzL2tlcm5lbC9kZWJ1Zy9ibG9jayAmJiBmaW5kIC4gLXR5cGUgZiAtZXhlYyBn
cmVwIC1hSCAuIHt9IFw7KQ0KPiANCj4gTG9va3MgbGlrZSB0aGUgbG9ja3VwcyBhcmUgZmFyIG1v
cmUgZnJlcXVlbnQgd2l0aCBldmVyeXRoaW5nIG9uIG1xLiANCj4gSnVzdCB0byBjb25maXJtOg0K
PiANCj4gQ09ORklHX1NDU0lfTVFfREVGQVVMVD15DQo+IENPTkZJR19ETV9NUV9ERUZBVUxUPXkN
Cj4gDQo+IA0KPiBQbGVhc2UgZmluZCBhdHRhY2hlZCB0aGUgb3V0cHV0IGZyb20gdGhlIHJlcXVl
c3RlZC4NCj4gDQo+IGh0dHA6Ly9kb3dubG9hZHMudWxzLmNvLnphL2xvY2t1cC9sb2NrdXAtMjAx
ODAzMTAtMjIzMDM2LyBjb250YWlucw0KPiBhZGRpdGlvbmFsIHN0dWZmLCBzdXJyb3VuZGluZyB0
aGF0Lg0KDQpUaGFua3MsIHRoYXQgaGVscHMuIEluIGJsb2NrX2RlYnVnLnR4dCBJIHNlZSB0aGF0
IG9ubHkgZm9yIC9kZXYvc2RtIGENCnJlcXVlc3QgZ290IHN0dWNrOg0KDQokIGdyZXAgJ2J1c3k9
W14wXScgYmxvY2tfZGVidWcudHh0ICANCi4vc2RtL2hjdHgwL3RhZ3M6YnVzeT05DQoNCkJ1dCBJ
IGNhbid0IHNlZSBpbiB0aGUgb3V0cHV0IHRoYXQgaGFzIGJlZW4gc2hhcmVkIHdoaWNoIEkvTyBz
Y2hlZHVsZXIgaGFzDQpiZWVuIGNvbmZpZ3VyZWQgbm9yIHdoaWNoIFNDU0kgTExEIGlzIGludm9s
dmVkLiBDYW4geW91IHBsZWFzZSBhbHNvIHNoYXJlDQp0aGF0IGluZm9ybWF0aW9uLCBlLmcuIGJ5
IHByb3ZpZGluZyB0aGUgb3V0cHV0IG9mIHRoZSBmb2xsb3dpbmcgY29tbWFuZHM6DQoNCmNhdCAv
c3lzL2Jsb2NrL3NkbS9xdWV1ZS9zY2hlZHVsZXINCmZpbmQgL3N5cyAtbmFtZSBzZG0gIyBwcm92
aWRlcyB0aGUgUENJIElEDQpsc3BjaQ0KDQpUaGFua3MsDQoNCkJhcnQu
