Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32475C4360F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 13:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01299222D4
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 13:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438685AbfBNNEr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:04:47 -0500
Received: from smtpbg65.qq.com ([103.7.28.233]:14569 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731725AbfBNNEq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 08:04:46 -0500
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: hcmviN0nPXItigZ3Hv9NWkmTtdhyR6hpasMWKZio9zA7c8rGKWpNNG+54lVoG
        xqZDZtm5UAiknzAbTzLhBtgV2iFZotTvcif+zhhzWtGe3fKINYfj+ItK4+NdpHB9fiL5743
        9LdnviTqC3a6pS5fVxg9DWsqtHBSW/aqOUNfykoJzN7+YHBd0ZTJxqxBJmUPRjyQh0D0Y1Z
        UTqFjPDWONFp9NEKvTWMUUqbeOAg44jkEQnvgbTnRpu8uxS++QiXhnp8U2imVOZ/S4Jqhf3
        CRhXjtIit5BkGLu5Bsq/BO9io=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 121.238.200.209
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1550149456t76125
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?VGhvbWFzIEdsZWl4bmVy?=" <tglx@linutronix.de>,
        "=?utf-8?B?S2VpdGggQnVzY2g=?=" <keith.busch@intel.com>
Cc:     "=?utf-8?B?Qmpvcm4gSGVsZ2Fhcw==?=" <helgaas@kernel.org>,
        "=?utf-8?B?SmVucyBBeGJvZQ==?=" <axboe@kernel.dk>,
        "=?utf-8?B?U2FnaSBHcmltYmVyZw==?=" <sagi@grimberg.me>,
        "=?utf-8?B?bGludXgtcGNp?=" <linux-pci@vger.kernel.org>,
        "=?utf-8?B?TEtNTA==?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?bGludXgtbnZtZQ==?=" <linux-nvme@lists.infradead.org>,
        "=?utf-8?B?TWluZyBMZWk=?=" <ming.lei@redhat.com>,
        "=?utf-8?B?bGludXgtYmxvY2s=?=" <linux-block@vger.kernel.org>,
        "=?utf-8?B?Q2hyaXN0b3BoIEhlbGx3aWc=?=" <hch@lst.de>
Subject: Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu, 14 Feb 2019 21:04:16 +0800
X-Priority: 3
Message-ID: <tencent_6460D33741AF25B57E7BE493@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20190213105041.13537-1-ming.lei@redhat.com>
        <20190213105041.13537-2-ming.lei@redhat.com>
        <20190213150407.GB96272@google.com>
        <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
        <20190213213149.GB8027@localhost.localdomain>
        <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de>
        <20190213223711.GC8027@localhost.localdomain>
        <alpine.DEB.2.21.1902140949280.1659@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902140949280.1659@nanos.tec.linutronix.de>
X-QQ-ReplyHash: 2901456492
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Thu, 14 Feb 2019 21:04:19 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SSdsbCB0ZXN0IG5leHQgd2VlaywgYnV0IDQuMTkgaGFzIHRoZSBzYW1lIHByb2JsZW0sIGhv
dyB0byBmaXggdGhhdCBmb3IgNC4xOT8NCg0KSHVhY2FpDQogDQotLS0tLS0tLS0tLS0tLS0t
LS0gT3JpZ2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tOiAgIlRob21hcyBHbGVpeG5l
ciI8dGdseEBsaW51dHJvbml4LmRlPjsNCkRhdGU6ICBUaHUsIEZlYiAxNCwgMjAxOSAwNDo1
MCBQTQ0KVG86ICAiS2VpdGggQnVzY2giPGtlaXRoLmJ1c2NoQGludGVsLmNvbT47DQpDYzog
ICJCam9ybiBIZWxnYWFzIjxoZWxnYWFzQGtlcm5lbC5vcmc+OyAiSmVucyBBeGJvZSI8YXhi
b2VAa2VybmVsLmRrPjsgIlNhZ2kgR3JpbWJlcmciPHNhZ2lAZ3JpbWJlcmcubWU+OyAibGlu
dXgtcGNpIjxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgIkxLTUwiPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+OyAibGludXgtbnZtZSI8bGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnPjsgIk1pbmcgTGVpIjxtaW5nLmxlaUByZWRoYXQuY29tPjsgImxpbnV4LWJs
b2NrIjxsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc+OyAiQ2hyaXN0b3BoIEhlbGx3aWci
PGhjaEBsc3QuZGU+OyAiSHVhY2FpIENoZW4iPGNoZW5oY0BsZW1vdGUuY29tPjsNClN1Ympl
Y3Q6ICBSZTogW1BBVENIIFYzIDEvNV0gZ2VuaXJxL2FmZmluaXR5OiBkb24ndCBtYXJrICdh
ZmZkJyBhcyBjb25zdA0KIA0KT24gV2VkLCAxMyBGZWIgMjAxOSwgS2VpdGggQnVzY2ggd3Jv
dGU6DQoNCkNjKyBIdWFjYWkgQ2hlbg0KDQo+IE9uIFdlZCwgRmViIDEzLCAyMDE5IGF0IDEw
OjQxOjU1UE0gKzAxMDAsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gPiBCdHcsIHdoaWxl
IEkgaGF2ZSB5b3VyIGF0dGVudGlvbi4gVGhlcmUgcG9wcGVkIHVwIGFuIGlzc3VlIHJlY2Vu
dGx5IHJlbGF0ZWQNCj4gPiB0byB0aGF0IGFmZmluaXR5IGxvZ2ljLg0KPiA+IA0KPiA+IFRo
ZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGZhaWxzIHdoZW46DQo+ID4gDQo+ID4gICAgICAg
ICAvKg0KPiA+ICAgICAgICAgICogSWYgdGhlcmUgYXJlbid0IGFueSB2ZWN0b3JzIGxlZnQg
YWZ0ZXIgYXBwbHlpbmcgdGhlIHByZS9wb3N0DQo+ID4gICAgICAgICAgKiB2ZWN0b3JzIGRv
bid0IGJvdGhlciB3aXRoIGFzc2lnbmluZyBhZmZpbml0eS4NCj4gPiAqLw0KPiA+IGlmIChu
dmVjcyA9PSBhZmZkLT5wcmVfdmVjdG9ycyArIGFmZmQtPnBvc3RfdmVjdG9ycykNCj4gPiAg
ICAgcmV0dXJuIE5VTEw7DQo+ID4gDQo+ID4gTm93IHRoZSBkaXNjdXNzaW9uIGFyaXNlZCwg
dGhhdCBpbiB0aGF0IGNhc2UgdGhlIGFmZmluaXR5IHNldHMgYXJlIG5vdA0KPiA+IGFsbG9j
YXRlZCBhbmQgZmlsbGVkIGluIGZvciB0aGUgcHJlL3Bvc3QgdmVjdG9ycywgYnV0IHNvbWVo
b3cgdGhlDQo+ID4gdW5kZXJseWluZyBkZXZpY2Ugc3RpbGwgd29ya3MgYW5kIGxhdGVyIG9u
IHRyaWdnZXJzIHRoZSB3YXJuaW5nIGluIHRoZQ0KPiA+IGJsay1tcSBjb2RlIGJlY2F1c2Ug
dGhlIE1TSSBlbnRyaWVzIGRvIG5vdCBoYXZlIGFmZmluaXR5IGluZm9ybWF0aW9uDQo+ID4g
YXR0YWNoZWQuDQo+ID4NCj4gPiBTdXJlLCB3ZSBjb3VsZCBtYWtlIHRoYXQgd29yaywgYnV0
IHRoZXJlIGFyZSBzZXZlcmFsIGlzc3VlczoNCj4gPiANCj4gPiAgICAgMSkgaXJxX2NyZWF0
ZV9hZmZpbml0eV9tYXNrcygpIGhhcyBhbm90aGVyIHJlYXNvbiB0byByZXR1cm4gTlVMTDoN
Cj4gPiAgICAgICAgbWVtb3J5IGFsbG9jYXRpb24gZmFpbHMuDQo+ID4gDQo+ID4gICAgIDIp
IERvZXMgaXQgbWFrZSBzZW5zZSBhdCBhbGwuDQo+ID4gDQo+ID4gUmlnaHQgbm93IHRoZSBQ
Q0kgYWxsb2NhdG9yIGlnbm9yZXMgdGhlIE5VTEwgcmV0dXJuIGFuZCBwcm9jZWVkcyB3aXRo
b3V0DQo+ID4gc2V0dGluZyBhbnkgYWZmaW5pdGllcy4gQXMgYSBjb25zZXF1ZW5jZSBub3Ro
aW5nIGlzIG1hbmFnZWQgYW5kIGV2ZXJ5dGhpbmcNCj4gPiBoYXBwZW5zIHRvIHdvcmsuDQo+
ID4gDQo+ID4gQnV0IHRoYXQgaGFwcGVucyB0byB3b3JrIGlzIG1vcmUgYnkgY2hhbmNlIHRo
YW4gYnkgZGVzaWduIGFuZCB0aGUgd2FybmluZw0KPiA+IGlzIGJvZ3VzIGlmIHRoaXMgaXMg
YW4gZXhwZWN0ZWQgbW9kZSBvZiBvcGVyYXRpb24uDQo+ID4gDQo+ID4gV2Ugc2hvdWxkIGFk
ZHJlc3MgdGhlc2UgcG9pbnRzIGluIHNvbWUgd2F5Lg0KPiANCj4gQWgsIHllcywgdGhhdCdz
IGEgbWlzdGFrZSBpbiB0aGUgbnZtZSBkcml2ZXIuIEl0IGlzIGFzc3VtaW5nIElPIHF1ZXVl
cyBhcmUNCj4gYWx3YXlzIG9uIG1hbmFnZWQgaW50ZXJydXB0cywgYnV0IHRoYXQncyBub3Qg
dHJ1ZSBpZiB3aGVuIG9ubHkgMSB2ZWN0b3INCj4gY291bGQgYmUgYWxsb2NhdGVkLiBUaGlz
IHNob3VsZCBiZSBhbiBhcHByb3ByaWF0ZSBmaXggdG8gdGhlIHdhcm5pbmc6DQoNCkxvb2tz
IGNvcnJlY3QuIENoZW4sIGNhbiB5b3UgcGxlYXNlIHRlc3QgdGhhdD8NCg0KPiAtLS0NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hv
c3QvcGNpLmMNCj4gaW5kZXggMDIyZWExZWU2M2Y4Li5mMmNjZWJlMWM5MjYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L3BjaS5jDQo+IEBAIC01MDYsNyArNTA2LDcgQEAgc3RhdGljIGludCBudm1lX3BjaV9t
YXBfcXVldWVzKHN0cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0KQ0KPiAgKiBhZmZpbml0eSks
IHNvIHVzZSB0aGUgcmVndWxhciBibGstbXEgY3B1IG1hcHBpbmcNCj4gICovDQo+ICBtYXAt
PnF1ZXVlX29mZnNldCA9IHFvZmY7DQo+IC0JaWYgKGkgIT0gSENUWF9UWVBFX1BPTEwpDQo+
ICsJaWYgKGkgIT0gSENUWF9UWVBFX1BPTEwgJiYgZGV2LT5udW1fdmVjcyA+IDEpDQo+ICBi
bGtfbXFfcGNpX21hcF9xdWV1ZXMobWFwLCB0b19wY2lfZGV2KGRldi0+ZGV2KSwgb2Zmc2V0
KTsNCj4gIGVsc2UNCj4gIGJsa19tcV9tYXBfcXVldWVzKG1hcCk7DQo+IC0tDQo+



