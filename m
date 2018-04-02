Return-Path: <prvs=6236fbcb6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "kernel-team@fb.com" <kernel-team@fb.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Date: Mon, 2 Apr 2018 22:49:43 +0000
Message-ID: <e2b9b49876c9979cdadef1a04904b5899cf34b1a.camel@wdc.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
	 <20180402190120.GD388343@devbig577.frc2.facebook.com>
	 <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
	 <20180402211047.GF388343@devbig577.frc2.facebook.com>
	 <afef8f4812b357deeadc0999f4c85d7b0049b738.camel@wdc.com>
	 <20180402220136.GI388343@devbig577.frc2.facebook.com>
	 <6d6985b8d95317aa5572809f1b987c45e932c5b2.camel@wdc.com>
	 <20180402221657.GL388343@devbig577.frc2.facebook.com>
In-Reply-To: <20180402221657.GL388343@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTA0LTAyIGF0IDE1OjE2IC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBBRkFJSywNCj4gdGhlcmUncyBvbmUgbm9uLWNyaXRpY2FsIHJhY2UgY29uZGl0aW9uIHdoaWNo
IGhhcyBhbHdheXMgYmVlbiB0aGVyZS4NCj4gV2UgaGF2ZSBhIGxhcmdlciByYWNlIHdpbmRvdyBm
b3IgdGhhdCBjYXNlIGJ1dCBkb24ndCB5ZXQga25vdyB3aGV0aGVyDQo+IHRoYXQncyBwcm9ibGVt
YXRpYyBvciBub3QuICBJZiB0aGF0IGFjdHVhbGx5IGlzIHByb2JsZW1hdGljLCB3ZSBjYW4NCj4g
ZmlndXJlIG91dCBhIHdheSB0byBzb2x2ZSB0aGF0IGJ1dCBzdWNoIGVmZm9ydCAvIGFkZGVkIGNv
bXBsZXhpdHkNCj4gZG9lc24ndCBzZWVtIGp1c3RpZmllZCB5ZXQuICBObz8NCg0KSGVsbG8gVGVq
dW4sDQoNClNvbWUgaW1wb3J0YW50IGJsb2NrIGRyaXZlcnMgc3lzdGVtYXRpY2FsbHkgcmV0dXJu
IEJMS19FSF9SRVNFVF9USU1FUg0KZnJvbSB0aGVpciB0aW1lb3V0IGhhbmRsZXIsIGUuZy4gdGhl
IHZpcnRpby1zY3NpIGluaXRpYXRvciBkcml2ZXIuIFdoYXQNCndpbGwgdGhlIGNvbnNlcXVlbmNl
IGJlIGZvciB0aGVzZSBkcml2ZXJzIGlmIGEgYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QoKQ0KY2Fs
bCBpcyBpZ25vcmVkPyBXaWxsIHRoZSByZXF1ZXN0IGZvciB3aGljaCB0aGUgY29tcGxldGlvbiB3
YXMgaWdub3JlZA0KZ2V0IHN0dWNrPw0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQo=
