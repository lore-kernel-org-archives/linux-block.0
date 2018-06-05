Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk> <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
 <20180604182017.GA1351649@devbig577.frc2.facebook.com> <CA+55aFwOjtyPODy2U9vBQjxjXYq=veRzvMS2Uwdt8f1erRXe1A@mail.gmail.com>
 <f35436ab-bdac-5277-d0d2-b8432c620aff@kernel.dk> <20180604190428.GA30325@kmo-pixel>
In-Reply-To: <20180604190428.GA30325@kmo-pixel>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Jun 2018 17:42:04 -0700
Message-ID: <CA+55aFyv5v7S_Qj0WwxE0foK69p+WVeDrq1ZKD9EJfP20sJboQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-block <linux-block@vger.kernel.org>, NeilBrown <neilb@suse.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/mixed; boundary="0000000000006fa25b056dda5297"
List-ID: <linux-block@vger.kernel.org>

--0000000000006fa25b056dda5297
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 4, 2018 at 12:04 PM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> However, that's not correct as is because mddev_delayed_put() calls
> kobject_put(), and the kobject isn't initialized when the mddev is first
> allocated, it's initialized when the gendisk is allocated... that isn't hard to
> fix but that's getting into real refactoring that I'll need to put actual work
> into testing.

Well, it also removes the bioset_exit() calls entirely.

How about just the attached?

It simply does it as two different cases, and adds the bioset_exit()
calls to mddev_delayed_delete().

Hmm?

                 Linus

--0000000000006fa25b056dda5297
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ji0yl1ug0>
X-Attachment-Id: f_ji0yl1ug0

IGRyaXZlcnMvbWQvbWQuYyB8IDIzICsrKysrKysrKystLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZC9tZC5jIGIvZHJpdmVycy9tZC9tZC5jCmluZGV4IGZjNjkyYjcxMjhiYi4uNmEyNDk0
MDY1YWIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL21kL21kLmMKKysrIGIvZHJpdmVycy9tZC9tZC5j
CkBAIC01MTAsMTEgKzUxMCw2IEBAIHN0YXRpYyB2b2lkIG1kZGV2X2RlbGF5ZWRfZGVsZXRlKHN0
cnVjdCB3b3JrX3N0cnVjdCAqd3MpOwogCiBzdGF0aWMgdm9pZCBtZGRldl9wdXQoc3RydWN0IG1k
ZGV2ICptZGRldikKIHsKLQlzdHJ1Y3QgYmlvX3NldCBicywgc3luY19iczsKLQotCW1lbXNldCgm
YnMsIDAsIHNpemVvZihicykpOwotCW1lbXNldCgmc3luY19icywgMCwgc2l6ZW9mKHN5bmNfYnMp
KTsKLQogCWlmICghYXRvbWljX2RlY19hbmRfbG9jaygmbWRkZXYtPmFjdGl2ZSwgJmFsbF9tZGRl
dnNfbG9jaykpCiAJCXJldHVybjsKIAlpZiAoIW1kZGV2LT5yYWlkX2Rpc2tzICYmIGxpc3RfZW1w
dHkoJm1kZGV2LT5kaXNrcykgJiYKQEAgLTUyMiwxMCArNTE3LDYgQEAgc3RhdGljIHZvaWQgbWRk
ZXZfcHV0KHN0cnVjdCBtZGRldiAqbWRkZXYpCiAJCS8qIEFycmF5IGlzIG5vdCBjb25maWd1cmVk
IGF0IGFsbCwgYW5kIG5vdCBoZWxkIGFjdGl2ZSwKIAkJICogc28gZGVzdHJveSBpdCAqLwogCQls
aXN0X2RlbF9pbml0KCZtZGRldi0+YWxsX21kZGV2cyk7Ci0JCWJzID0gbWRkZXYtPmJpb19zZXQ7
Ci0JCXN5bmNfYnMgPSBtZGRldi0+c3luY19zZXQ7Ci0JCW1lbXNldCgmbWRkZXYtPmJpb19zZXQs
IDAsIHNpemVvZihtZGRldi0+YmlvX3NldCkpOwotCQltZW1zZXQoJm1kZGV2LT5zeW5jX3NldCwg
MCwgc2l6ZW9mKG1kZGV2LT5zeW5jX3NldCkpOwogCQlpZiAobWRkZXYtPmdlbmRpc2spIHsKIAkJ
CS8qIFdlIGRpZCBhIHByb2JlIHNvIG5lZWQgdG8gY2xlYW4gdXAuICBDYWxsCiAJCQkgKiBxdWV1
ZV93b3JrIGluc2lkZSB0aGUgc3BpbmxvY2sgc28gdGhhdApAQCAtNTM0LDEyICs1MjUsMTUgQEAg
c3RhdGljIHZvaWQgbWRkZXZfcHV0KHN0cnVjdCBtZGRldiAqbWRkZXYpCiAJCQkgKi8KIAkJCUlO
SVRfV09SSygmbWRkZXYtPmRlbF93b3JrLCBtZGRldl9kZWxheWVkX2RlbGV0ZSk7CiAJCQlxdWV1
ZV93b3JrKG1kX21pc2Nfd3EsICZtZGRldi0+ZGVsX3dvcmspOwotCQl9IGVsc2UKLQkJCWtmcmVl
KG1kZGV2KTsKKwkJCXNwaW5fdW5sb2NrKCZhbGxfbWRkZXZzX2xvY2spOworCQkJcmV0dXJuOwor
CQl9CiAJfQogCXNwaW5fdW5sb2NrKCZhbGxfbWRkZXZzX2xvY2spOwotCWJpb3NldF9leGl0KCZi
cyk7Ci0JYmlvc2V0X2V4aXQoJnN5bmNfYnMpOworCisJYmlvc2V0X2V4aXQoJm1kZGV2LT5iaW9f
c2V0KTsKKwliaW9zZXRfZXhpdCgmbWRkZXYtPnN5bmNfc2V0KTsKKwlrZnJlZShtZGRldik7CiB9
CiAKIHN0YXRpYyB2b2lkIG1kX3NhZmVtb2RlX3RpbWVvdXQoc3RydWN0IHRpbWVyX2xpc3QgKnQp
OwpAQCAtNTIzNCw2ICs1MjI4LDkgQEAgc3RhdGljIHZvaWQgbWRkZXZfZGVsYXllZF9kZWxldGUo
c3RydWN0IHdvcmtfc3RydWN0ICp3cykKIHsKIAlzdHJ1Y3QgbWRkZXYgKm1kZGV2ID0gY29udGFp
bmVyX29mKHdzLCBzdHJ1Y3QgbWRkZXYsIGRlbF93b3JrKTsKIAorCWJpb3NldF9leGl0KCZtZGRl
di0+YmlvX3NldCk7CisJYmlvc2V0X2V4aXQoJm1kZGV2LT5zeW5jX3NldCk7CisKIAlzeXNmc19y
ZW1vdmVfZ3JvdXAoJm1kZGV2LT5rb2JqLCAmbWRfYml0bWFwX2dyb3VwKTsKIAlrb2JqZWN0X2Rl
bCgmbWRkZXYtPmtvYmopOwogCWtvYmplY3RfcHV0KCZtZGRldi0+a29iaik7Cg==
--0000000000006fa25b056dda5297--
