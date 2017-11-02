Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:14223 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdKBMQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Nov 2017 08:16:46 -0400
From: "Zouming (IT)" <zouming.zouming@huawei.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: wangzhoumengjian <wangzhoumengjian@huawei.com>
Subject: [bug report after v4.5-rc1]block: When the scsi device has a
 timeout IO, the scsi device is stuck when it is deleted
Date: Thu, 2 Nov 2017 12:16:35 +0000
Message-ID: <32770656ECCC174D9F733890F5D00C0D99557B3A@dggemm511-mbs.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

MS5SZXBlYXQgc3RlcHM6IA0KKDEpIHNlbmQgSU8gb24gdGhlIGRldmljZSAvZGV2L3NkeC4gDQoo
MikgU2ltdWxhdGUgYW4gSU8gbG9zdA0KKDMpIFVzZSB0aGUgY29tbWFuZCBiZWZvcmUgdG8gwqBk
ZWxldGUgc2NzaSBkZXZpY2XCoCBiZWZvcmUgSU8gdGltZW91dA0KwqAgwqAgwqAgZWhjbyAxID4g
L3N5cy9jbGFzcy9zZHgvZGV2aWNlL2RlbGV0ZSANCg0KMi5UaGUgc3RhY2sgb2YgZGVsZXRlIHRo
ZWFkIGlzIGJlZm9yZTogDQpbPGZmZmZmZmZmODEwOTk5ZWY+XSBtc2xlZXArMHgyZi8weDQwIA0K
WzxmZmZmZmZmZjgxMmY3OGI0Pl0gX19ibGtfZHJhaW5fcXVldWUrMHhhNC8weDE3MCANCls8ZmZm
ZmZmZmY4MTJmN2JmZD5dIGJsa19jbGVhbnVwX3F1ZXVlKzB4MTNkLzB4MTUwIA0KWzxmZmZmZmZm
ZjgxNDczZDJhPl0gX19zY3NpX3JlbW92ZV9kZXZpY2UrMHg0YS8weGQwIA0KWzxmZmZmZmZmZjgx
NDczZGQ2Pl0gc2NzaV9yZW1vdmVfZGV2aWNlKzB4MjYvMHg0MCANCls8ZmZmZmZmZmY4MTQ3M2Uw
NT5dIHNkZXZfc3RvcmVfZGVsZXRlX2NhbGxiYWNrKzB4MTUvMHgyMCANCls8ZmZmZmZmZmY4MTI3
ZmRjND5dIHN5c2ZzX3NjaGVkdWxlX2NhbGxiYWNrX3dvcmsrMHgxNC8weDYwIA0KWzxmZmZmZmZm
ZjgxMGE4ODFhPl0gcHJvY2Vzc19vbmVfd29yaysweDE3YS8weDQ0MCANCls8ZmZmZmZmZmY4MTBh
OTRlNj5dIHdvcmtlcl90aHJlYWQrMHgxMjYvMHgzYzAgDQpbPGZmZmZmZmZmODEwYjA5OGY+XSBr
dGhyZWFkKzB4Y2YvMHhlMCANCls8ZmZmZmZmZmY4MTZiNGYxOD5dIHJldF9mcm9tX2ZvcmsrMHg1
OC8weDkwwqAgDQoNCjMuVGhlIHJlYXNvbiBpcyBiZWZvcmU6IA0KwqAgKDEpIFdoZW4gdGhlIHNj
c2kgZGV2aWNlIGlzIGRlbGV0ZWQsIGludm9rZcKgYmxrX2NsZWFudXBfcXVldWUgZnVudGlvbiB0
byANCsKgIMKgIMKgIMKgIHNldCB0aGUgZmxhZyBvZiByZXF1ZXN0X3F1ZXVlIGR5aW5nLCBhbmQg
d2FpdCBhbGwgSU8gYmFjay4gDQoNCsKgICgyKSB3aGVuIElPIHRpbW91dCx0aGUgdGltZW91dCB3
b3JrcXVldWUgaW52b2tlIGJsa190aW1lb3V0X3dvcmvCoGZ1bmN0aW9uIHRvIGFib3J0IElPLCAN
CsKgIMKgIMKgIMKgYnV0IGl0IHdpbGwgbm90IGFib3J0IHRoZSBJTyBiZWNhdXNlIGl0IGNhbGwg
wqBibGtfcXVldWVfZW50ZXIgZnVudGlvbsKgIA0KwqAgwqAgwqAgwqBqdWRnZSB0aGUgcmVxdWVz
dF9xdWV1ZSBpcyBkeWluZyBhbmQgcmV0dXJuIGRpcmVjdCB3aXRob3V0IGRvaW5nIGFueXRoaW5n
LiANCg0K
