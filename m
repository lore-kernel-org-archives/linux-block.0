Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@osandov.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
Date: Thu, 20 Apr 2017 22:05:33 +0000
Message-ID: <F1D4091B-6AA1-46D0-A99E-0A891DE4939E@raithlin.com>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
 <20170420200706.GA24823@vader.DHCP.thefacebook.com>
 <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
 <20170420202039.GB24823@vader.DHCP.thefacebook.com>
 <808e7f83-9f55-29cf-7472-c09daea665bd@kernel.dk>
 <0E9E52B3-977A-4159-83B3-758564FF67AD@raithlin.com>
 <6617fde7-4866-4a2d-6cf5-dc8b2c678186@kernel.dk>
 <D356CC80-F509-4427-B999-641636131E8D@raithlin.com>
 <ca5bec05-ba3c-55db-6f3d-ef0965a79737@kernel.dk>
 <0C2FFC52-512F-4031-8E6F-487FA651A31B@raithlin.com>
 <6214fe06-c636-c565-9b2c-fab7cf2e6d19@kernel.dk>
 <F8C6A572-C589-4FF9-8DB2-66D6CC045EA1@raithlin.com>
 <16225338-232a-ef39-0b9d-1281e0a66367@kernel.dk>
In-Reply-To: <16225338-232a-ef39-0b9d-1281e0a66367@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

DQo+IFlvdSBjYW4sIGJ1dCBpdCB3b24ndCBkbyBtdWNoIGdvb2Qgc2luY2UgdjMgaXMgYWxyZWFk
eSBhcHBsaWVkLiBBbnkNCj4gZnVydGhlciBjaGFuZ2VzIG11c3QgYmUgaW5jcmVtZW50YWwuDQoN
CkJUVyBnZXR0aW5nIGEgY29tcGlsZSBlcnJvciBmcm9tIHRoZSBLeWJlciBjb2RlIGluIGZvci00
LjEyL2Jsb2NrIGR1ZSB0byB0aGUgZmFjdCB3ZSBub3cgcmV0dXJuIGEgc2lnbmVkIGZyb20gdGhl
IGJ1Y2tldCBmdW5jdGlvbuKApg0KDQpiYXRlc3N0ZUB1YnVudHU2NC1iYXRlc3N0ZTp+L2tlcm5l
bC9saW51eCQgbWFrZSAtaiAyIGFsbA0KICBDSEsgICAgIGluY2x1ZGUvY29uZmlnL2tlcm5lbC5y
ZWxlYXNlDQogIENISyAgICAgaW5jbHVkZS9nZW5lcmF0ZWQvdWFwaS9saW51eC92ZXJzaW9uLmgN
CiAgQ0hLICAgICBpbmNsdWRlL2dlbmVyYXRlZC91dHNyZWxlYXNlLmgNCiAgQ0hLICAgICBpbmNs
dWRlL2dlbmVyYXRlZC90aW1lY29uc3QuaA0KICBDSEsgICAgIGluY2x1ZGUvZ2VuZXJhdGVkL2Jv
dW5kcy5oDQogIENISyAgICAgaW5jbHVkZS9nZW5lcmF0ZWQvYXNtLW9mZnNldHMuaA0KICBDQUxM
ICAgIHNjcmlwdHMvY2hlY2tzeXNjYWxscy5zaA0KICBDSEsgICAgIGluY2x1ZGUvZ2VuZXJhdGVk
L2NvbXBpbGUuaA0KICBDQyAgICAgIGJsb2NrL2t5YmVyLWlvc2NoZWQubw0KYmxvY2sva3liZXIt
aW9zY2hlZC5jOiBJbiBmdW5jdGlvbiDigJhreWJlcl9xdWV1ZV9kYXRhX2FsbG9j4oCZOg0KYmxv
Y2sva3liZXItaW9zY2hlZC5jOjI5NTo1NzogZXJyb3I6IHBhc3NpbmcgYXJndW1lbnQgMiBvZiDi
gJhibGtfc3RhdF9hbGxvY19jYWxsYmFja+KAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5
cGUgWy1XZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdDQogIGtxZC0+Y2IgPSBibGtf
c3RhdF9hbGxvY19jYWxsYmFjayhreWJlcl9zdGF0X3RpbWVyX2ZuLCBycV9zY2hlZF9kb21haW4s
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gYmxvY2svYmxrLW1xLmg6NDowLA0KICAgICAgICAg
ICAgICAgICBmcm9tIGJsb2NrL2Jsay5oOjYsDQogICAgICAgICAgICAgICAgIGZyb20gYmxvY2sv
a3liZXItaW9zY2hlZC5jOjI3Og0KYmxvY2svYmxrLXN0YXQuaDoxMzg6MTogbm90ZTogZXhwZWN0
ZWQg4oCYaW50ICgqKShjb25zdCBzdHJ1Y3QgcmVxdWVzdCAqKeKAmSBidXQgYXJndW1lbnQgaXMg
b2YgdHlwZSDigJh1bnNpZ25lZCBpbnQgKCopKGNvbnN0IHN0cnVjdCByZXF1ZXN0ICop4oCZDQog
YmxrX3N0YXRfYWxsb2NfY2FsbGJhY2sodm9pZCAoKnRpbWVyX2ZuKShzdHJ1Y3QgYmxrX3N0YXRf
Y2FsbGJhY2sgKiksDQogXg0KICBDQyAgICAgIGJsb2NrL2NvbXBhdF9pb2N0bC5vDQpjYzE6IHNv
bWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCg0KDQoNCg==
