Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7758 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdHVV4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 17:56:46 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 09/20] blk-mq: introduce BLK_MQ_F_SHARED_DEPTH
Date: Tue, 22 Aug 2017 21:55:57 +0000
Message-ID: <1503438955.2508.30.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-10-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-10-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gKwkv
Kg0KPiArCSAqIGlmIHRoZXJlIGlzIHEtPnF1ZXVlX2RlcHRoLCBhbGwgaHcgcXVldWVzIHNoYXJl
DQo+ICsJICogdGhpcyBxdWV1ZSBkZXB0aCBsaW1pdA0KPiArCSAqLw0KPiArCWlmIChxLT5xdWV1
ZV9kZXB0aCkgew0KPiArCQlxdWV1ZV9mb3JfZWFjaF9od19jdHgocSwgaGN0eCwgaSkNCj4gKwkJ
CWhjdHgtPmZsYWdzIHw9IEJMS19NUV9GX1NIQVJFRF9ERVBUSDsNCj4gKwl9DQo+ICsNCj4gKwlp
ZiAoIXEtPmVsZXZhdG9yKQ0KPiArCQlnb3RvIGV4aXQ7DQoNCkhlbGxvIE1pbmcsDQoNCkl0IHNl
ZW1zIHZlcnkgZnJhZ2lsZSB0byBtZSB0byBzZXQgQkxLX01RX0ZfU0hBUkVEX0RFUFRIIGlmIGFu
ZCBvbmx5IGlmDQpxLT5xdWV1ZV9kZXB0aCAhPSAwLiBXb3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8g
bGV0IHRoZSBibG9jayBkcml2ZXIgdGVsbCB0aGUNCmJsb2NrIGxheWVyIHdoZXRoZXIgb3Igbm90
IHRoZXJlIGlzIGEgcXVldWUgZGVwdGggbGltaXQgYWNyb3NzIGhhcmR3YXJlDQpxdWV1ZXMsIGUu
Zy4gdGhyb3VnaCBhIHRhZyBzZXQgZmxhZz8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg==
