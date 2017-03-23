Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51302 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754890AbdCWRvc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2017 13:51:32 -0400
From: Josef Bacik <jbacik@fb.com>
To: Ming Lin <mlin@kernel.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        Ratna Manoj Bolla <manoj.br@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jianshu.ljs@alibaba-inc.com" <jianshu.ljs@alibaba-inc.com>,
        "xiongwei.jiang@alibaba-inc.com" <xiongwei.jiang@alibaba-inc.com>,
        "james.liu@alibaba-inc.com" <james.liu@alibaba-inc.com>
Subject: Re: [RFC PATCH 1/1] nbd: replace kill_bdev() with
 __invalidate_device()
Date: Thu, 23 Mar 2017 17:51:07 +0000
Message-ID: <8AA3DAC1-5E9C-438E-904B-D4C708A4F624@fb.com>
References: <1490050729-3578-1-git-send-email-mlin@kernel.org>
 <1490050729-3578-2-git-send-email-mlin@kernel.org>
In-Reply-To: <1490050729-3578-2-git-send-email-mlin@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

WWVhaCBJIHRoaW5rIHRoaXMgaXMgb2ssIEnigJlsbCB0aHJvdyBpdCBvbiBteSBxdWV1ZSBmb3Ig
Zml4ZXMgZm9yIHRoaXMgY3ljbGUuICBUaGFua3MsDQoNCkpvc2VmDQoNCk9uIDMvMjAvMTcsIDY6
NTggUE0sICJNaW5nIExpbiIgPG1saW5Aa2VybmVsLm9yZz4gd3JvdGU6DQoNCkZyb206IFJhdG5h
IE1hbm9qIEJvbGxhIDxtYW5vai5ickBnbWFpbC5jb20+DQoNCldoZW4gYSBmaWxlc3lzdGVtIGlz
IG1vdW50ZWQgb24gYSBuYmQgZGV2aWNlIGFuZCBvbiBhIGRpc2Nvbm5lY3QsIGJlY2F1c2UNCm9m
IGtpbGxfYmRldigpLCBhbmQgcmVzZXR0aW5nIGJkZXYgc2l6ZSB0byB6ZXJvLCBidWZmZXJfaGVh
ZCBtYXBwaW5ncyBhcmUNCmdldHRpbmcgZGVzdHJveWVkIHVuZGVyIG1vdW50ZWQgZmlsZXN5c3Rl
bS4NCg0KQWZ0ZXIgYSBiZGV2IHNpemUgcmVzZXQoaS5lIGJkZXYtPmJkX2lub2RlLT5pX3NpemUg
PSAwKSBvbiBhIGRpc2Nvbm5lY3QsDQpmb2xsb3dlZCBieSBhIHN5c191bW91bnQoKSwNCiAgICAg
ICAgZ2VuZXJpY19zaHV0ZG93bl9zdXBlcigpLT4uLi4NCiAgICAgICAgLT5fX3N5bmNfYmxvY2tk
ZXYoKS0+Li4uDQogICAgICAgIC1ibGtkZXZfd3JpdGVwYWdlcygpLT4uLi4NCiAgICAgICAgLT5k
b19pbnZhbGlkYXRlcGFnZSgpLT4uLi4NCiAgICAgICAgLWRpc2NhcmRfYnVmZmVyKCkgICBpcyBk
aXNjYXJkaW5nIHN1cGVyYmxvY2sgYnVmZmVyX2hlYWQgYXNzdW1lZA0KdG8gYmUgaW4gbWFwcGVk
IHN0YXRlIGJ5IGV4dDRfY29tbWl0X3N1cGVyKCkuDQoNClttbGluOiBwb3J0ZWQgdG8gNC4xMS1y
YzJdDQpTaWduZWQtb2ZmLWJ5OiBSYXRuYSBNYW5vaiBCb2xsYSA8bWFub2ouYnJAZ21haWwuY29t
DQotLS0NCiBkcml2ZXJzL2Jsb2NrL25iZC5jIHwgOCArKysrKystLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Jsb2NrL25iZC5jIGIvZHJpdmVycy9ibG9jay9uYmQuYw0KaW5kZXggY2I0Y2NmYy4uYTZhMzY0
MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYmxvY2svbmJkLmMNCisrKyBiL2RyaXZlcnMvYmxvY2sv
bmJkLmMNCkBAIC0xMjUsNyArMTI1LDggQEAgc3RhdGljIGNvbnN0IGNoYXIgKm5iZGNtZF90b19h
c2NpaShpbnQgY21kKQ0KIA0KIHN0YXRpYyBpbnQgbmJkX3NpemVfY2xlYXIoc3RydWN0IG5iZF9k
ZXZpY2UgKm5iZCwgc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikNCiB7DQotCWJkX3NldF9zaXpl
KGJkZXYsIDApOw0KKwlpZiAoYmRldi0+YmRfb3BlbmVycyA8PSAxKQ0KKwkJYmRfc2V0X3NpemUo
YmRldiwgMCk7DQogCXNldF9jYXBhY2l0eShuYmQtPmRpc2ssIDApOw0KIAlrb2JqZWN0X3VldmVu
dCgmbmJkX3RvX2RldihuYmQpLT5rb2JqLCBLT0JKX0NIQU5HRSk7DQogDQpAQCAtNjAzLDYgKzYw
NCw4IEBAIHN0YXRpYyB2b2lkIG5iZF9yZXNldChzdHJ1Y3QgbmJkX2RldmljZSAqbmJkKQ0KIA0K
IHN0YXRpYyB2b2lkIG5iZF9iZGV2X3Jlc2V0KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYpDQog
ew0KKwlpZiAoYmRldi0+YmRfb3BlbmVycyA+IDEpDQorCQlyZXR1cm47DQogCXNldF9kZXZpY2Vf
cm8oYmRldiwgZmFsc2UpOw0KIAliZGV2LT5iZF9pbm9kZS0+aV9zaXplID0gMDsNCiAJaWYgKG1h
eF9wYXJ0ID4gMCkgew0KQEAgLTY2Niw3ICs2NjksOCBAQCBzdGF0aWMgaW50IG5iZF9jbGVhcl9z
b2NrKHN0cnVjdCBuYmRfZGV2aWNlICpuYmQsIHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYpDQog
ew0KIAlzb2NrX3NodXRkb3duKG5iZCk7DQogCW5iZF9jbGVhcl9xdWUobmJkKTsNCi0Ja2lsbF9i
ZGV2KGJkZXYpOw0KKw0KKwlfX2ludmFsaWRhdGVfZGV2aWNlKGJkZXYsIHRydWUpOw0KIAluYmRf
YmRldl9yZXNldChiZGV2KTsNCiAJLyoNCiAJICogV2Ugd2FudCB0byBnaXZlIHRoZSBydW4gdGhy
ZWFkIGEgY2hhbmNlIHRvIHdhaXQgZm9yIGV2ZXJ5Ym9keQ0KLS0gDQoxLjguMy4xDQoNCg0KDQo=
