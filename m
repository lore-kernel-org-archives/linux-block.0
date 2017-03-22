Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57462 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750812AbdCVVnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2017 17:43:53 -0400
From: Josef Bacik <jbacik@fb.com>
To: Ming Lin <mlin@kernel.org>
CC: "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        Ratna Manoj Bolla <manoj.br@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jianshu.ljs@alibaba-inc.com" <jianshu.ljs@alibaba-inc.com>,
        "LIU, Fei" <james.liu@alibaba-inc.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        "xiongwei.jiang@alibaba-inc.com" <xiongwei.jiang@alibaba-inc.com>
Subject: Re: [Nbd] [RFC PATCH 1/1] nbd: replace kill_bdev() with
 __invalidate_device()
Date: Wed, 22 Mar 2017 21:43:27 +0000
Message-ID: <D98734E2-B906-48F8-9EA2-E4F5DBFBD93F@fb.com>
References: <1490050729-3578-1-git-send-email-mlin@kernel.org>
 <1490050729-3578-2-git-send-email-mlin@kernel.org>
 <CAF1ivSb2nwBAKjbsFhca3cvJk=-B_gtu-ZdqkyAetJSer5CuYw@mail.gmail.com>
In-Reply-To: <CAF1ivSb2nwBAKjbsFhca3cvJk=-B_gtu-ZdqkyAetJSer5CuYw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

SGV5IHNvcnJ5IEkganVzdCBnb3QgYmFjayBmcm9tIExTRiwgSeKAmWxsIGxvb2sgYXQgdGhpcyBp
biB0aGUgbW9ybmluZy4gIFRoYW5rcywNCg0KSm9zZWYNCg0KT24gMy8yMi8xNywgNDo0OCBQTSwg
Ik1pbmcgTGluIiA8bWxpbkBrZXJuZWwub3JnPiB3cm90ZToNCg0KT24gTW9uLCBNYXIgMjAsIDIw
MTcgYXQgMzo1OCBQTSwgTWluZyBMaW4gPG1saW5Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IEZyb206
IFJhdG5hIE1hbm9qIEJvbGxhIDxtYW5vai5ickBnbWFpbC5jb20+DQo+DQo+IFdoZW4gYSBmaWxl
c3lzdGVtIGlzIG1vdW50ZWQgb24gYSBuYmQgZGV2aWNlIGFuZCBvbiBhIGRpc2Nvbm5lY3QsIGJl
Y2F1c2UNCj4gb2Yga2lsbF9iZGV2KCksIGFuZCByZXNldHRpbmcgYmRldiBzaXplIHRvIHplcm8s
IGJ1ZmZlcl9oZWFkIG1hcHBpbmdzIGFyZQ0KPiBnZXR0aW5nIGRlc3Ryb3llZCB1bmRlciBtb3Vu
dGVkIGZpbGVzeXN0ZW0uDQo+DQo+IEFmdGVyIGEgYmRldiBzaXplIHJlc2V0KGkuZSBiZGV2LT5i
ZF9pbm9kZS0+aV9zaXplID0gMCkgb24gYSBkaXNjb25uZWN0LA0KPiBmb2xsb3dlZCBieSBhIHN5
c191bW91bnQoKSwNCj4gICAgICAgICBnZW5lcmljX3NodXRkb3duX3N1cGVyKCktPi4uLg0KPiAg
ICAgICAgIC0+X19zeW5jX2Jsb2NrZGV2KCktPi4uLg0KPiAgICAgICAgIC1ibGtkZXZfd3JpdGVw
YWdlcygpLT4uLi4NCj4gICAgICAgICAtPmRvX2ludmFsaWRhdGVwYWdlKCktPi4uLg0KPiAgICAg
ICAgIC1kaXNjYXJkX2J1ZmZlcigpICAgaXMgZGlzY2FyZGluZyBzdXBlcmJsb2NrIGJ1ZmZlcl9o
ZWFkIGFzc3VtZWQNCj4gdG8gYmUgaW4gbWFwcGVkIHN0YXRlIGJ5IGV4dDRfY29tbWl0X3N1cGVy
KCkuDQo+DQo+IFttbGluOiBwb3J0ZWQgdG8gNC4xMS1yYzJdDQo+IFNpZ25lZC1vZmYtYnk6IFJh
dG5hIE1hbm9qIEJvbGxhIDxtYW5vai5ickBnbWFpbC5jb20NCj4gLS0tDQo+ICBkcml2ZXJzL2Js
b2NrL25iZC5jIHwgOCArKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbmJkLmMg
Yi9kcml2ZXJzL2Jsb2NrL25iZC5jDQo+IGluZGV4IGNiNGNjZmMuLmE2YTM2NDMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvYmxvY2svbmJkLmMNCj4gKysrIGIvZHJpdmVycy9ibG9jay9uYmQuYw0K
PiBAQCAtMTI1LDcgKzEyNSw4IEBAIHN0YXRpYyBjb25zdCBjaGFyICpuYmRjbWRfdG9fYXNjaWko
aW50IGNtZCkNCj4NCj4gIHN0YXRpYyBpbnQgbmJkX3NpemVfY2xlYXIoc3RydWN0IG5iZF9kZXZp
Y2UgKm5iZCwgc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikNCj4gIHsNCj4gLSAgICAgICBiZF9z
ZXRfc2l6ZShiZGV2LCAwKTsNCj4gKyAgICAgICBpZiAoYmRldi0+YmRfb3BlbmVycyA8PSAxKQ0K
PiArICAgICAgICAgICAgICAgYmRfc2V0X3NpemUoYmRldiwgMCk7DQo+ICAgICAgICAgc2V0X2Nh
cGFjaXR5KG5iZC0+ZGlzaywgMCk7DQo+ICAgICAgICAga29iamVjdF91ZXZlbnQoJm5iZF90b19k
ZXYobmJkKS0+a29iaiwgS09CSl9DSEFOR0UpOw0KPg0KPiBAQCAtNjAzLDYgKzYwNCw4IEBAIHN0
YXRpYyB2b2lkIG5iZF9yZXNldChzdHJ1Y3QgbmJkX2RldmljZSAqbmJkKQ0KPg0KPiAgc3RhdGlj
IHZvaWQgbmJkX2JkZXZfcmVzZXQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikNCj4gIHsNCj4g
KyAgICAgICBpZiAoYmRldi0+YmRfb3BlbmVycyA+IDEpDQo+ICsgICAgICAgICAgICAgICByZXR1
cm47DQo+ICAgICAgICAgc2V0X2RldmljZV9ybyhiZGV2LCBmYWxzZSk7DQo+ICAgICAgICAgYmRl
di0+YmRfaW5vZGUtPmlfc2l6ZSA9IDA7DQo+ICAgICAgICAgaWYgKG1heF9wYXJ0ID4gMCkgew0K
PiBAQCAtNjY2LDcgKzY2OSw4IEBAIHN0YXRpYyBpbnQgbmJkX2NsZWFyX3NvY2soc3RydWN0IG5i
ZF9kZXZpY2UgKm5iZCwgc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikNCj4gIHsNCj4gICAgICAg
ICBzb2NrX3NodXRkb3duKG5iZCk7DQo+ICAgICAgICAgbmJkX2NsZWFyX3F1ZShuYmQpOw0KPiAt
ICAgICAgIGtpbGxfYmRldihiZGV2KTsNCj4gKw0KPiArICAgICAgIF9faW52YWxpZGF0ZV9kZXZp
Y2UoYmRldiwgdHJ1ZSk7DQo+ICAgICAgICAgbmJkX2JkZXZfcmVzZXQoYmRldik7DQo+ICAgICAg
ICAgLyoNCj4gICAgICAgICAgKiBXZSB3YW50IHRvIGdpdmUgdGhlIHJ1biB0aHJlYWQgYSBjaGFu
Y2UgdG8gd2FpdCBmb3IgZXZlcnlib2R5DQo+IC0tDQo+IDEuOC4zLjENCg0KSGkgSm9zZWYsDQoN
CkFueSBjb21tZW50cz8NCg0KVGhhbmtzLA0KTWluZw0KDQoNCg==
