Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:33940 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932726AbdBVOlp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 09:41:45 -0500
MIME-Version: 1.0
In-Reply-To: <yq1efyq25y2.fsf@oracle.com>
References: <CAOi1vP8M91kiF-FnT=EoJgTxfstMEsC-nhLY5KtRkrKROjWPWA@mail.gmail.com>
 <yq1efyq25y2.fsf@oracle.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 22 Feb 2017 15:41:43 +0100
Message-ID: <CAOi1vP-amFyFHbPV3FhG3F1Tp+df6V7a4mcP8LLWY0GZx+JsFw@mail.gmail.com>
Subject: Re: blk_integrity_revalidate() clears BDI_CAP_STABLE_WRITES
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: multipart/mixed; boundary=001a113cf800ce427d05491f7e5d
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--001a113cf800ce427d05491f7e5d
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 22, 2017 at 5:41 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Ilya" == Ilya Dryomov <idryomov@gmail.com> writes:
>
> Ilya,
>
> Ilya> could you please explain blk_integrity_revalidate() and
> Ilya> its GENHD_FL_UP check in particular?  We have the queue,
> Ilya> bi->profile can't be NULL after blk_integrity_register(), and
> Ilya> since the latter "must" be used for registering the profile with
> Ilya> the block layer, wouldn't the following be sufficient for
> Ilya> blk_integrity users?
>
> IIrc, the FL_UP check fixed a registration problem in the nvme driver.

Did it have something to do with a NULL disk->queue?

>
> The rationale behind revalidate was that we need to handle devices which
> lose the integrity capability at runtime (i.e. a integrity-enabled DM
> device is extended with a non-cable drive forcing the feature to be
> turned off). The clearing of the integrity profile is more important in
> that case than zapping the stable pages flag. But that was the original
> reason for not just ORing BDI_CAP_STABLE_WRITES.
>
> I don't have a huge problem with keeping stable pages on if a device
> suddenly stops being integrity capable. However, I'd like to understand
> your use case a bit better.

Well, blk_integrity_revalidate() doesn't clear the profile, it just
clears the stable pages flag.  Whoever calls blk_integrity_unregister()
to clear the profile can also clear the stable pages flag -- why not
let blk_integrity_unregister() clear the flag like I suggested?

>
> Ilya> The alternative seems to be to set up a bogus
> Ilya> blk_integrity_profile (nop_profile won't do -- this one would have
> Ilya> to be truly bogus w/ NULL *_fn) under BLK_DEV_INTEGRITY ifdefs and
> Ilya> hope that nothing breaks.
>
> Can you point me to the relevant code on your end?

This code doesn't exist yet -- it's just something I thought I'd have
to do if my patch or something along those lines isn't accepted.  There
is the nop_profile with stub *_fn callbacks, which is used by nvme and
nvdimm to make bio_integrity_enabled() return true, so that per-interval
buffers are allocated in bio_integrity_prep().  "I want some space for
per-interval metadata, but no integrity checksums" is use case there.

In the rbd case, we don't want that.  We just want to set the stable
pages flag and make sure it's not reset by blk_integrity code.  So, if
blk_integrity_revalidate() isn't fixed, rbd will need to set up a bogus
profile with NULL *_fn callbacks to make bio_integrity_enabled() return
false.  This is obviously fragile, because blk_get_integrity() will no
longer return NULL...

We are setting BDI_CAP_STABLE_WRITES in rbd_init_disk(), see commit
bae818ee1577 ("rbd: require stable pages if message data CRCs are
enabled").  The CRCs are generated in write_partial_message_data() and
verified in read_partial_msg_data().

I'm attaching the patch I had in mind.

Thanks,

                Ilya

--001a113cf800ce427d05491f7e5d
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-block-get-rid-of-blk_integrity_revalidate.patch"
Content-Disposition: attachment;
	filename="0001-block-get-rid-of-blk_integrity_revalidate.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_izh2ip3f0

RnJvbSAyNGEwY2Y4YmM0MzdhNjViMzk4NmU5YWIyNWNmMmYwNWU2YmJkNWQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWlsLmNvbT4KRGF0
ZTogTW9uLCAyMCBGZWIgMjAxNyAxODo1MDo1MCArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIGJsb2Nr
OiBnZXQgcmlkIG9mIGJsa19pbnRlZ3JpdHlfcmV2YWxpZGF0ZSgpCgpDb21taXQgMjU1MjBkNTVj
ZGI2ICgiYmxvY2s6IElubGluZSBibGtfaW50ZWdyaXR5IGluIHN0cnVjdCBnZW5kaXNrIikKaW50
cm9kdWNlZCBibGtfaW50ZWdyaXR5X3JldmFsaWRhdGUoKSwgd2hpY2ggY2xlYXJzIHRoZSBzdGFi
bGUgcGFnZXMKYml0IGlmIG5vIGJsa19pbnRlZ3JpdHkgcHJvZmlsZSBpcyByZWdpc3RlcmVkLiAg
SXQncyBjYWxsZWQgZnJvbQpyZXZhbGlkYXRlX2Rpc2soKSBhbmQgcmVzY2FuX3BhcnRpdGlvbnMo
KSwgbWFraW5nIGl0IGltcG9zc2libGUgdG8gc2V0CkJESV9DQVBfU1RBQkxFX1dSSVRFUyBmb3Ig
ZHJpdmVycyB0aGF0IHN1cHBvcnQgcGFydGl0aW9ucyBhbmQgZG9uJ3QgdXNlCmJsa19pbnRlZ3Jp
dHkuICBPbmUgc3VjaCBkcml2ZXIgaXMgcmJkLCB3aGVyZSB0aGUgY2VwaCBtZXNzZW5nZXIgaXMK
cmVzcG9uc2libGUgZm9yIGdlbmVyYXRpbmcvdmVyaWZ5aW5nIENSQ3MuCgpTaW5jZSBibGtfaW50
ZWdyaXR5X3t1bix9cmVnaXN0ZXIoKSAibXVzdCIgYmUgdXNlZCBmb3IgKHVuKXJlZ2lzdGVyaW5n
CnRoZSBpbnRlZ3JpdHkgcHJvZmlsZSB3aXRoIHRoZSBibG9jayBsYXllciwgbW92ZSBCRElfQ0FQ
X1NUQUJMRV9XUklURVMKc2V0dGluZyB0aGVyZS4gIFRoaXMgd2F5IGRyaXZlcnMgdGhhdCBjYWxs
IGJsa19pbnRlZ3JpdHlfcmVnaXN0ZXIoKSBhbmQKdXNlIGludGVncml0eSBpbmZyYXN0cnVjdHVy
ZSB3b24ndCBpbnRlcmZlcmUgd2l0aCBkcml2ZXJzIHRoYXQgZG9uJ3QKYnV0IHN0aWxsIHdhbnQg
c3RhYmxlIHBhZ2VzLgoKRml4ZXM6IDI1NTIwZDU1Y2RiNiAoImJsb2NrOiBJbmxpbmUgYmxrX2lu
dGVncml0eSBpbiBzdHJ1Y3QgZ2VuZGlzayIpClNpZ25lZC1vZmYtYnk6IElseWEgRHJ5b21vdiA8
aWRyeW9tb3ZAZ21haWwuY29tPgotLS0KIGJsb2NrL2Jsay1pbnRlZ3JpdHkuYyAgICAgfCAxOSAr
Ky0tLS0tLS0tLS0tLS0tLS0tCiBibG9jay9wYXJ0aXRpb24tZ2VuZXJpYy5jIHwgIDEgLQogZnMv
YmxvY2tfZGV2LmMgICAgICAgICAgICB8ICAxIC0KIGluY2x1ZGUvbGludXgvZ2VuaGQuaCAgICAg
fCAgMiAtLQogNCBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1pbnRlZ3JpdHkuYyBiL2Jsb2NrL2Jsay1pbnRlZ3Jp
dHkuYwppbmRleCBkNjljNWM3OWY5OGUuLjMxOWYyZTRmNGE4YiAxMDA2NDQKLS0tIGEvYmxvY2sv
YmxrLWludGVncml0eS5jCisrKyBiL2Jsb2NrL2Jsay1pbnRlZ3JpdHkuYwpAQCAtNDE3LDcgKzQx
Nyw3IEBAIHZvaWQgYmxrX2ludGVncml0eV9yZWdpc3RlcihzdHJ1Y3QgZ2VuZGlzayAqZGlzaywg
c3RydWN0IGJsa19pbnRlZ3JpdHkgKnRlbXBsYXRlCiAJYmktPnR1cGxlX3NpemUgPSB0ZW1wbGF0
ZS0+dHVwbGVfc2l6ZTsKIAliaS0+dGFnX3NpemUgPSB0ZW1wbGF0ZS0+dGFnX3NpemU7CiAKLQli
bGtfaW50ZWdyaXR5X3JldmFsaWRhdGUoZGlzayk7CisJZGlzay0+cXVldWUtPmJhY2tpbmdfZGV2
X2luZm8uY2FwYWJpbGl0aWVzIHw9IEJESV9DQVBfU1RBQkxFX1dSSVRFUzsKIH0KIEVYUE9SVF9T
WU1CT0woYmxrX2ludGVncml0eV9yZWdpc3Rlcik7CiAKQEAgLTQzMCwyNiArNDMwLDExIEBAIEVY
UE9SVF9TWU1CT0woYmxrX2ludGVncml0eV9yZWdpc3Rlcik7CiAgKi8KIHZvaWQgYmxrX2ludGVn
cml0eV91bnJlZ2lzdGVyKHN0cnVjdCBnZW5kaXNrICpkaXNrKQogewotCWJsa19pbnRlZ3JpdHlf
cmV2YWxpZGF0ZShkaXNrKTsKKwlkaXNrLT5xdWV1ZS0+YmFja2luZ19kZXZfaW5mby5jYXBhYmls
aXRpZXMgJj0gfkJESV9DQVBfU1RBQkxFX1dSSVRFUzsKIAltZW1zZXQoJmRpc2stPnF1ZXVlLT5p
bnRlZ3JpdHksIDAsIHNpemVvZihzdHJ1Y3QgYmxrX2ludGVncml0eSkpOwogfQogRVhQT1JUX1NZ
TUJPTChibGtfaW50ZWdyaXR5X3VucmVnaXN0ZXIpOwogCi12b2lkIGJsa19pbnRlZ3JpdHlfcmV2
YWxpZGF0ZShzdHJ1Y3QgZ2VuZGlzayAqZGlzaykKLXsKLQlzdHJ1Y3QgYmxrX2ludGVncml0eSAq
YmkgPSAmZGlzay0+cXVldWUtPmludGVncml0eTsKLQotCWlmICghKGRpc2stPmZsYWdzICYgR0VO
SERfRkxfVVApKQotCQlyZXR1cm47Ci0KLQlpZiAoYmktPnByb2ZpbGUpCi0JCWRpc2stPnF1ZXVl
LT5iYWNraW5nX2Rldl9pbmZvLmNhcGFiaWxpdGllcyB8PQotCQkJQkRJX0NBUF9TVEFCTEVfV1JJ
VEVTOwotCWVsc2UKLQkJZGlzay0+cXVldWUtPmJhY2tpbmdfZGV2X2luZm8uY2FwYWJpbGl0aWVz
ICY9Ci0JCQl+QkRJX0NBUF9TVEFCTEVfV1JJVEVTOwotfQotCiB2b2lkIGJsa19pbnRlZ3JpdHlf
YWRkKHN0cnVjdCBnZW5kaXNrICpkaXNrKQogewogCWlmIChrb2JqZWN0X2luaXRfYW5kX2FkZCgm
ZGlzay0+aW50ZWdyaXR5X2tvYmosICZpbnRlZ3JpdHlfa3R5cGUsCmRpZmYgLS1naXQgYS9ibG9j
ay9wYXJ0aXRpb24tZ2VuZXJpYy5jIGIvYmxvY2svcGFydGl0aW9uLWdlbmVyaWMuYwppbmRleCA3
YWZiOTkwNzgyMWYuLjAxNzFhMmZhYWQ2OCAxMDA2NDQKLS0tIGEvYmxvY2svcGFydGl0aW9uLWdl
bmVyaWMuYworKysgYi9ibG9jay9wYXJ0aXRpb24tZ2VuZXJpYy5jCkBAIC00OTcsNyArNDk3LDYg
QEAgaW50IHJlc2Nhbl9wYXJ0aXRpb25zKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBzdHJ1Y3QgYmxv
Y2tfZGV2aWNlICpiZGV2KQogCiAJaWYgKGRpc2stPmZvcHMtPnJldmFsaWRhdGVfZGlzaykKIAkJ
ZGlzay0+Zm9wcy0+cmV2YWxpZGF0ZV9kaXNrKGRpc2spOwotCWJsa19pbnRlZ3JpdHlfcmV2YWxp
ZGF0ZShkaXNrKTsKIAljaGVja19kaXNrX3NpemVfY2hhbmdlKGRpc2ssIGJkZXYpOwogCWJkZXYt
PmJkX2ludmFsaWRhdGVkID0gMDsKIAlpZiAoIWdldF9jYXBhY2l0eShkaXNrKSB8fCAhKHN0YXRl
ID0gY2hlY2tfcGFydGl0aW9uKGRpc2ssIGJkZXYpKSkKZGlmZiAtLWdpdCBhL2ZzL2Jsb2NrX2Rl
di5jIGIvZnMvYmxvY2tfZGV2LmMKaW5kZXggM2M0NzYxNGE0YjMyLi5iOTRlMmE0OTc0YTEgMTAw
NjQ0Ci0tLSBhL2ZzL2Jsb2NrX2Rldi5jCisrKyBiL2ZzL2Jsb2NrX2Rldi5jCkBAIC0xNDIyLDcg
KzE0MjIsNiBAQCBpbnQgcmV2YWxpZGF0ZV9kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrKQogCiAJ
aWYgKGRpc2stPmZvcHMtPnJldmFsaWRhdGVfZGlzaykKIAkJcmV0ID0gZGlzay0+Zm9wcy0+cmV2
YWxpZGF0ZV9kaXNrKGRpc2spOwotCWJsa19pbnRlZ3JpdHlfcmV2YWxpZGF0ZShkaXNrKTsKIAli
ZGV2ID0gYmRnZXRfZGlzayhkaXNrLCAwKTsKIAlpZiAoIWJkZXYpCiAJCXJldHVybiByZXQ7CmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2dlbmhkLmggYi9pbmNsdWRlL2xpbnV4L2dlbmhkLmgK
aW5kZXggNzZmMzk3NTRlN2IwLi43NmQ2YTFjZDQxNTMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvZ2VuaGQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2dlbmhkLmgKQEAgLTcyMiwxMSArNzIyLDkg
QEAgc3RhdGljIGlubGluZSB2b2lkIHBhcnRfbnJfc2VjdHNfd3JpdGUoc3RydWN0IGhkX3N0cnVj
dCAqcGFydCwgc2VjdG9yX3Qgc2l6ZSkKICNpZiBkZWZpbmVkKENPTkZJR19CTEtfREVWX0lOVEVH
UklUWSkKIGV4dGVybiB2b2lkIGJsa19pbnRlZ3JpdHlfYWRkKHN0cnVjdCBnZW5kaXNrICopOwog
ZXh0ZXJuIHZvaWQgYmxrX2ludGVncml0eV9kZWwoc3RydWN0IGdlbmRpc2sgKik7Ci1leHRlcm4g
dm9pZCBibGtfaW50ZWdyaXR5X3JldmFsaWRhdGUoc3RydWN0IGdlbmRpc2sgKik7CiAjZWxzZQkv
KiBDT05GSUdfQkxLX0RFVl9JTlRFR1JJVFkgKi8KIHN0YXRpYyBpbmxpbmUgdm9pZCBibGtfaW50
ZWdyaXR5X2FkZChzdHJ1Y3QgZ2VuZGlzayAqZGlzaykgeyB9CiBzdGF0aWMgaW5saW5lIHZvaWQg
YmxrX2ludGVncml0eV9kZWwoc3RydWN0IGdlbmRpc2sgKmRpc2spIHsgfQotc3RhdGljIGlubGlu
ZSB2b2lkIGJsa19pbnRlZ3JpdHlfcmV2YWxpZGF0ZShzdHJ1Y3QgZ2VuZGlzayAqZGlzaykgeyB9
CiAjZW5kaWYJLyogQ09ORklHX0JMS19ERVZfSU5URUdSSVRZICovCiAKICNlbHNlIC8qIENPTkZJ
R19CTE9DSyAqLwotLSAKMi40LjMKCg==
--001a113cf800ce427d05491f7e5d--
