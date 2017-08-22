Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49673 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbdHVUmD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 16:42:03 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 10/20] blk-mq-sched: introduce helpers for query,
 change busy state
Date: Tue, 22 Aug 2017 20:41:14 +0000
Message-ID: <1503434472.2508.19.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-11-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-11-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gK3N0
YXRpYyBpbmxpbmUgYm9vbCBibGtfbXFfaGN0eF9pc19kaXNwYXRjaF9idXN5KHN0cnVjdCBibGtf
bXFfaHdfY3R4ICpoY3R4KQ0KPiArew0KPiArCXJldHVybiB0ZXN0X2JpdChCTEtfTVFfU19ESVNQ
QVRDSF9CVVNZLCAmaGN0eC0+c3RhdGUpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIHZv
aWQgYmxrX21xX2hjdHhfc2V0X2Rpc3BhdGNoX2J1c3koc3RydWN0IGJsa19tcV9od19jdHggKmhj
dHgpDQo+ICt7DQo+ICsJc2V0X2JpdChCTEtfTVFfU19ESVNQQVRDSF9CVVNZLCAmaGN0eC0+c3Rh
dGUpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgYmxrX21xX2hjdHhfY2xlYXJf
ZGlzcGF0Y2hfYnVzeShzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCkNCj4gK3sNCj4gKwljbGVh
cl9iaXQoQkxLX01RX1NfRElTUEFUQ0hfQlVTWSwgJmhjdHgtPnN0YXRlKTsNCj4gK30NCg0KSGVs
bG8gTWluZywNCg0KQXJlIHRoZXNlIGhlbHBlciBmdW5jdGlvbnMgbW9kaWZpZWQgaW4gYSBsYXRl
ciBwYXRjaD8gSWYgbm90LCBwbGVhc2UgZHJvcA0KdGhpcyBwYXRjaC4gT25lIGxpbmUgaGVscGVy
IGZ1bmN0aW9ucyBhcmUgbm90IHVzZWZ1bCBhbmQgZG8gbm90IGltcHJvdmUNCnJlYWRhYmlsaXR5
IG9mIHNvdXJjZSBjb2RlLg0KDQpUaGFua3MsDQoNCkJhcnQu
