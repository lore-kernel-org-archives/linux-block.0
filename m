Return-Path: <prvs=5127bfa28=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V8 0/7] blk-mq support for ZBC disks
Date: Tue, 12 Dec 2017 01:18:50 +0000
Message-ID: <1513041528.2330.13.camel@wdc.com>
References: <20171109065707.17210-1-damien.lemoal@wdc.com>
	 <1511567307.2137.5.camel@wdc.com>
	 <a2216fbb-bc19-2ec1-e4cb-b3688fff0049@kernel.dk>
In-Reply-To: <a2216fbb-bc19-2ec1-e4cb-b3688fff0049@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

SmVucywNCg0KT24gRnJpLCAyMDE3LTExLTI0IGF0IDE2OjU0IC0wNzAwLCBKZW5zIEF4Ym9lIHdy
b3RlOg0KPiBPbiAxMS8yNC8yMDE3IDA0OjQ4IFBNLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4g
PiBbRnVsbCBxdW90ZSBkZWxldGVkXQ0KPiA+IA0KPiA+IEhpIEplbnMsDQo+ID4gDQo+ID4gQW55
IGNvbW1lbnQgcmVnYXJkaW5nIHRoaXMgc2VyaWVzID8NCj4gPiBJIHVuZGVyc3RhbmQgdGhhdCB0
aGlzIHdvdWxkIGJlIGZvciB0aGUgNC4xNiBtZXJnZSB3aW5kb3csIHNvIG5vIGh1cnJ5LA0KPiA+
IGJ1dCBJIHdvdWxkIGxpa2UgdG8ga25vdyBpZiBJIG5lZWQgdG8gZ28gYmFjayB0byB0aGUgZHJh
d2luZyBib2FyZCBmb3INCj4gPiBaQkMgYmxrLW1xL3Njc2ktbXEgc3VwcG9ydCBvciBpZiB0aGlz
IGlzIGFuIGFjY2VwdGFibGUgc29sdXRpb24uDQo+IA0KPiBJJ2xsIGdpdmUgaXQgYSB0aG9yb3Vn
aCBsb29rLW92ZXIgb24gTW9uZGF5Lg0KDQpXb3VsZCB5b3UgaGF2ZSBhbnkgY29tbWVudCBvbiB0
aGUgc2VyaWVzID8NCkkgdW5kZXJzdGFuZCB5b3UgYXJlIGJ1c3kgc28gcGxlYXNlIGZlZWwgZnJl
ZSB0byBsZXQgbWUga25vdyBpZiB0aGVyZSBpcw0KYW55dGhpbmcgSSBjYW4gZG8gdG8gZmFjaWxp
dGF0ZSB5b3VyIHJldmlldy4NCg0KVGhhbmsgeW91Lg0KDQotLSANCkRhbWllbiBMZSBNb2FsDQpX
ZXN0ZXJuIERpZ2l0YWw=
