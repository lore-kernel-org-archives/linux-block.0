Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "decui@microsoft.com" <decui@microsoft.com>, "hare@suse.com"
	<hare@suse.com>, "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jth@kernel.org" <jth@kernel.org>
Subject: Re: [PATCH] genhd: Do not hold event lock when scheduling workqueue
 elements
Date: Tue, 7 Feb 2017 02:56:50 +0000
Message-ID: <1486436195.2791.1.camel@sandisk.com>
References: <1484732896-22941-1-git-send-email-hare@suse.de>
	 <1485822639.2669.16.camel@sandisk.com>
	 <532c55c4-15da-d2f9-401c-36bc4343756b@suse.com>
	 <MWHPR03MB2669B8A45A07846AF0A06E46BF4F0@MWHPR03MB2669.namprd03.prod.outlook.com>
	 <MWHPR03MB26699D4657FB67A535972208BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
In-Reply-To: <MWHPR03MB26699D4657FB67A535972208BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE3LTAyLTA3IGF0IDAyOjIzICswMDAwLCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiBB
bnkgbmV3cyBvbiB0aGlzIHRocmVhZD8NCj4gDQo+IFRoZSBpc3N1ZSBpcyBzdGlsbCBibG9ja2lu
ZyBMaW51eCBmcm9tIGJvb3RpbmcgdXAgbm9ybWFsbHkgaW4gbXkgdGVzdC4gOi0oDQo+IA0KPiBI
YXZlIHdlIGlkZW50aWZpZWQgdGhlIGZhdWx0eSBwYXRjaD8NCj4gSWYgc28sIGF0IGxlYXN0IEkg
Y2FuIHRyeSB0byByZXZlcnQgaXQgdG8gYm9vdCB1cC4NCg0KSXQncyBpbnRlcmVzdGluZyB0aGF0
IHlvdSBoYXZlIGEgcmVwcm9kdWNpYmxlIHRlc3RjYXNlLiBJZiB5b3UgY2FuIHRlbGwgbWUgaG93
IHRvDQpyZXByb2R1Y2UgdGhpcyBJJ2xsIGhhdmUgYSBsb29rIGF0IGl0IHRvZ2V0aGVyIHdpdGgg
SGFubmVzLg0KDQpCYXJ0LgpXZXN0ZXJuIERpZ2l0YWwgQ29ycG9yYXRpb24gKGFuZCBpdHMgc3Vi
c2lkaWFyaWVzKSBFLW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAmIERpc2NsYWltZXI6CgpU
aGlzIGUtbWFpbCBhbmQgYW55IGZpbGVzIHRyYW5zbWl0dGVkIHdpdGggaXQgbWF5IGNvbnRhaW4g
Y29uZmlkZW50aWFsIG9yIGxlZ2FsbHkgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiBvZiBXREMgYW5k
L29yIGl0cyBhZmZpbGlhdGVzLCBhbmQgYXJlIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBv
ZiB0aGUgaW5kaXZpZHVhbCBvciBlbnRpdHkgdG8gd2hpY2ggdGhleSBhcmUgYWRkcmVzc2VkLiBJ
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBhbnkgZGlzY2xvc3VyZSwgY29w
eWluZywgZGlzdHJpYnV0aW9uIG9yIGFueSBhY3Rpb24gdGFrZW4gb3Igb21pdHRlZCB0byBiZSB0
YWtlbiBpbiByZWxpYW5jZSBvbiBpdCwgaXMgcHJvaGliaXRlZC4gSWYgeW91IGhhdmUgcmVjZWl2
ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlh
dGVseSBhbmQgZGVsZXRlIHRoZSBlLW1haWwgaW4gaXRzIGVudGlyZXR5IGZyb20geW91ciBzeXN0
ZW0uCg==
