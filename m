Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtpbgeu1.qq.com ([52.59.177.22]:40789 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeEPDnd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 May 2018 23:43:33 -0400
From: "=?utf-8?B?6IOh5rW3?=" <huhai@kylinos.cn>
To: "=?utf-8?B?YXhib2U=?=" <axboe@kernel.dk>
Cc: "=?utf-8?B?bGludXgtYmxvY2s=?=" <linux-block@vger.kernel.org>,
        "=?utf-8?B?aGNo?=" <hch@lst.de>
Subject: blk-mq: for sync case, whether it is mq or sq make_request instances, we should send the request directly
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Date: Wed, 16 May 2018 11:43:26 +0800
Message-ID: <tencent_1673E9D0031A9B033DE36EDB@qq.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

QXV0aG9yOiBodWhhaSA8aHVoYWlAa3lsaW5vcy5jbj4NCkRhdGU6ICAgV2VkIE1heSAxNiAx
MDozNDoyMiAyMDE4ICswODAwDQoNCiAgICBibGstbXE6IGZvciBzeW5jIGNhc2UsIHdoZXRo
ZXIgaXQgaXMgbXEgb3Igc3EgbWFrZV9yZXF1ZXN0IGluc3RhbmNlcywgd2Ugc2hvdWxkIHNl
bmQgdGhlIHJlcXVlc3QgZGlyZWN0bHkNCiAgICANCiAgICBGb3Igc3EgbWFrZV9yZXF1ZXN0
IGluc3RhbmNlcywgd2Ugc2hvdWxkIGlzc3VlIHN5bmMgcmVxdWVzdCBkaXJlY3RseSB0b28s
IA0KICAgIG90aGVyd2lzZSBpdCB3aWxsIGJyZWFrIGRvd24gdGhlIHNlbWFudGljcyBvZiBz
eW5jIHJlcXVlc3QsIA0KICAgIHRoZSBjdXJyZW50IGNvZGUgbG9naWMgaXMgdG8gc2VuZCBz
eW5jaHJvbm91cyByZXF1ZXN0cyBhc3luY2hyb25vdXNseS4NCiAgICANCiAgICBTaWduZWQt
b2ZmLWJ5OiBodWhhaSA8aHVoYWlAa3lsaW5vcy5jbj4NCg0KZGlmZiAtLWdpdCBhL2Jsb2Nr
L2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMNCmluZGV4IDU2MjlmMTguLmZjZjJmMTYgMTAw
NjQ0DQotLS0gYS9ibG9jay9ibGstbXEuYw0KKysrIGIvYmxvY2svYmxrLW1xLmMNCkBAIC0x
NzcxLDcgKzE3NzEsNyBAQCBzdGF0aWMgYmxrX3FjX3QgYmxrX21xX21ha2VfcmVxdWVzdChz
dHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgc3RydWN0IGJpbyAqYmlvKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgYmxrX21xX3RyeV9pc3N1ZV9kaXJlY3RseShkYXRhLmhjdHgsIHNhbWVf
cXVldWVfcnEsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmNv
b2tpZSk7DQogICAgICAgICAgICAgICAgfQ0KLSAgICAgICB9IGVsc2UgaWYgKHEtPm5yX2h3
X3F1ZXVlcyA+IDEgJiYgaXNfc3luYykgew0KKyAgICAgICB9IGVsc2UgaWYgKGlzX3N5bmMp
IHsNCiAgICAgICAgICAgICAgICBibGtfbXFfcHV0X2N0eChkYXRhLmN0eCk7DQogICAgICAg
ICAgICAgICAgYmxrX21xX2Jpb190b19yZXF1ZXN0KHJxLCBiaW8pOw0KICAgICAgICAgICAg
ICAgIGJsa19tcV90cnlfaXNzdWVfZGlyZWN0bHkoZGF0YS5oY3R4LCBycSwgJmNvb2tpZSk7
