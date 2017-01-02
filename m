Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hare@suse.de" <hare@suse.de>, "arnd@arndb.de" <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"baolin.wang@linaro.org" <baolin.wang@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"riteshh@codeaurora.org" <riteshh@codeaurora.org>, "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>, "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"zhang.chunyan@linaro.org" <zhang.chunyan@linaro.org>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
Date: Mon, 2 Jan 2017 11:58:35 +0000
Message-ID: <1483358298.3592.52.camel@sandisk.com>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
	 <20161228085503.GA340@lst.de>
	 <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
	 <2360959.cyJgAELf50@wuerfel> <68863f25-7faa-88b5-78bb-21027f772ab6@suse.de>
In-Reply-To: <68863f25-7faa-88b5-78bb-21027f772ab6@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE3LTAxLTAyIGF0IDEyOjA2ICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
DQo+IEhtbS4gQnV0IHRoYXQgd291bGQgYW1vdW50IHRvIGltcGxlbWVudCB5ZXQgYW5vdGhlciBx
dWV1aW5nIG1lY2hhbmlzbQ0KPiB3aXRoaW4gdGhlIGRyaXZlci9tbWMgc3Vic3lzdGVtLCB3b3Vs
ZG4ndCBpdD8NCj4gDQo+IFdoaWNoIGlzLCBpbmNpZGVudGFsbHksIHRoZSBzYW1lIG1ldGhvZCB0
aGUgUy8zOTAgREFTRCBkcml2ZXIgdXNlcw0KPiBub3dhZGF5czsgcmVwb3J0IGFuIGFyYml0cmFy
eSBxdWV1ZSBkZXB0aCB0byB0aGUgYmxvY2sgbGF5ZXIgYW5kIHF1ZXVlDQo+IGFsbCByZXF1ZXN0
cyBpbnRlcm5hbGx5IHRvIGJldHRlciBzYXR1cmF0ZSB0aGUgZGV2aWNlLg0KPiANCj4gSG93ZXZl
ciBJJ2QgcmVhbGx5IGxpa2UgdG8gZ2V0IHJpZCBvZiB0aGlzLCBhbmQgdHdlYWsgdGhlIGJsb2Nr
IGxheWVyIHRvDQo+IGhhbmRsZSB0aGVzZSBjYXNlcy4NCg0KSGVsbG8gSGFubmVzLA0KDQpTdWNo
IGZ1bmN0aW9uYWxpdHkgd2lsbCBiZSBhZGRlZCB0byB0aGUgYmxrLW1xIGNvcmUgYXMgcGFydCBv
ZiB0aGUNCmluaXRpYXRpdmUgdG8gYWRkIGJsay1tcSBJL08gc2NoZWR1bGluZyBzdXBwb3J0LiBP
bmUgaW1wbGVtZW50YXRpb24gaGFzIGJlZW4NCnByb3Bvc2VkIGJ5IEplbnMgKGh0dHA6Ly9naXQu
a2VybmVsLmRrL2NnaXQvbGludXgtYmxvY2svbG9nLz9oPWJsay1tcS1zY2hlZCkNCmFuZCBhbm90
aGVyIGltcGxlbWVudGF0aW9uIGhhcyBiZWVuIHByb3Bvc2VkIGJ5IG15c2VsZiAoaHR0cHM6Ly9s
a21sLm9yZy9sa20NCmwvMjAxNi8xMi8yMi8zMjIpLg0KDQpCYXJ0Lg==
