Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60365 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753960AbeFTNqU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jun 2018 09:46:20 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] blk-mq-debugfs: Off by one in blk_mq_rq_state_name()
Date: Wed, 20 Jun 2018 13:46:17 +0000
Message-ID: <31b2ca0fdd96e61bd57f8cda0f5f1b9c1afbb1d3.camel@wdc.com>
References: <20180620104503.nrwlfak3gyxjg7s2@kili.mountain>
In-Reply-To: <20180620104503.nrwlfak3gyxjg7s2@kili.mountain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTIwIGF0IDEzOjQ1ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBJZiBycV9zdGF0ZSA9PSBBUlJBWV9TSVpFKCkgdGhlbiB3ZSByZWFkIG9uZSBlbGVtZW50IGJl
eW9uZCB0aGUgZW5kIG9mDQo+IHRoZSBibGtfbXFfcnFfc3RhdGVfbmFtZV9hcnJheVtdIGFycmF5
Lg0KPiANCj4gRml4ZXM6IGVjNmRjZjYzYzU1YyAoImJsay1tcS1kZWJ1Z2ZzOiBTaG93IG1vcmUg
cmVxdWVzdCBzdGF0ZSBpbmZvcm1hdGlvbiIpDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50
ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9i
bGstbXEtZGVidWdmcy5jIGIvYmxvY2svYmxrLW1xLWRlYnVnZnMuYw0KPiBpbmRleCBmZmE2MjIz
NjY5MjIuLjFjNDUzMmU5MjkzOCAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmxrLW1xLWRlYnVnZnMu
Yw0KPiArKysgYi9ibG9jay9ibGstbXEtZGVidWdmcy5jDQo+IEBAIC0zNTYsNyArMzU2LDcgQEAg
c3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IGJsa19tcV9ycV9zdGF0ZV9uYW1lX2FycmF5W10gPSB7
DQo+ICANCj4gIHN0YXRpYyBjb25zdCBjaGFyICpibGtfbXFfcnFfc3RhdGVfbmFtZShlbnVtIG1x
X3JxX3N0YXRlIHJxX3N0YXRlKQ0KPiAgew0KPiAtCWlmIChXQVJOX09OX09OQ0UoKHVuc2lnbmVk
IGludClycV9zdGF0ZSA+DQo+ICsJaWYgKFdBUk5fT05fT05DRSgodW5zaWduZWQgaW50KXJxX3N0
YXRlID49DQo+ICAJCQkgQVJSQVlfU0laRShibGtfbXFfcnFfc3RhdGVfbmFtZV9hcnJheSkpKQ0K
PiAgCQlyZXR1cm4gIig/KSI7DQo+ICAJcmV0dXJuIGJsa19tcV9ycV9zdGF0ZV9uYW1lX2FycmF5
W3JxX3N0YXRlXTsNCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3Nj
aGVAd2RjLmNvbT4NCg0KDQoNCg==
