Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACVXFVNrHJcNxcm3+ieOM8f3GzKtTgu38HndWd19ehVDZBev_g@mail.gmail.com>
References: <1458055076-2175-1-git-send-email-vkuznets@redhat.com>
	<CACVXFVMs-fOaNVUyedg66T83MiOc7a+op3LeHVt6ogVBQnYdeQ@mail.gmail.com>
	<87oaae4cej.fsf@vitty.brq.redhat.com>
	<20160316223804.GA6217@localhost.lm.intel.com>
	<87egb94agz.fsf@vitty.brq.redhat.com>
	<20160317163946.GC6217@localhost.lm.intel.com>
	<CACVXFVNrHJcNxcm3+ieOM8f3GzKtTgu38HndWd19ehVDZBev_g@mail.gmail.com>
Date: Wed, 30 Mar 2016 21:07:19 +0800
Message-ID: <CACVXFVO37O2Yp60E82U_YWCe2yUqsEn1ojMb6kpTDmhBk94dQA@mail.gmail.com>
Subject: Re: [PATCH RFC] block: fix bio merge checks when virt_boundary is set
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, linux-block@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Sagi Grimberg <sagig@mellanox.com>,
	Mike Snitzer <snitzer@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Cathy Avery <cavery@redhat.com>
Content-Type: multipart/mixed; boundary=001a114da67e626da1052f43d376
List-ID: <linux-block@vger.kernel.org>

--001a114da67e626da1052f43d376
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 18, 2016 at 10:59 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Fri, Mar 18, 2016 at 12:39 AM, Keith Busch <keith.busch@intel.com> wrote:
>> On Thu, Mar 17, 2016 at 12:20:28PM +0100, Vitaly Kuznetsov wrote:
>>> Keith Busch <keith.busch@intel.com> writes:
>>> > been combined. In any case, I think you can get what you're after just
>>> > by moving the gap check after BIOVEC_PHYS_MERGABLE. Does the following
>>> > look ok to you?
>>> >
>>>
>>> Thanks, it does.
>>
>> Cool, thanks for confirming.
>>
>>> Will you send it or would you like me to do that with your Suggested-by?
>>
>> I'm not confident yet this doesn't break anything, particularly since
>> we moved the gap check after the length check. Just wanted to confirm
>> the concept addressed your concern, but still need to take a closer look
>> and test before submitting.
>
> IMO, the change on blk_bio_segment_split() is correct, because actually it
> is a sg gap and the check should have been done between segments
> instead of bvecs. So it is reasonable to move the check just before populating
> a new segment.

Thinking of the 1st part change further, looks it is just correct in concept,
but wrong from current implementation. Because of bios/reqs merge,
blk_rq_map_sg() may end one segment in any bvec in theroy, so I guess
that is why each non-1st bvec need the check to make sure no sg gap.
Looks a very crazy limit, :-)

>
> But for the 2nd change in bio_will_gap(), which should fix Vitaly's problem, I
> am still not sure if it is completely correct. bio_will_gap() is used
> to check if two
> bios may be merged. Suppose two bios are continues physically, the last bvec
> in 1st bio and the first bvec in 2nd bio might not be in one same segment
> because of segment size limit.

How about the attached patch?


>
> The root cause might be from blkdev_writepage(), and I guess these small
> bios are from there.
>
> thanks,
> Ming Lei



-- 
Ming Lei

--001a114da67e626da1052f43d376
Content-Type: text/x-patch; charset=US-ASCII; name="0001-block-loose-check-on-sg-gap.patch"
Content-Disposition: attachment;
	filename="0001-block-loose-check-on-sg-gap.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_imev85yl0

RnJvbSA1ZjYwYWUxZDY4NmYwMjU0NDVmZGYwOWY1NDZkNGQwNTVkMjU1Y2U5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5nIExlaSA8bWluZy5sZWlAY2Fub25pY2FsLmNvbT4KRGF0
ZTogRnJpLCAxOCBNYXIgMjAxNiAxMjo0MTo1MyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGJsb2Nr
OiBsb29zZSBjaGVjayBvbiBzZyBnYXAKCklmIHRoZSBsYXN0IGJ2ZWMgb2YgdGhlIDFzdCBiaW8g
YW5kIHRoZSAxc3QgYnZlYyBvZiB0aGUgbmV4dApiaW8gYXJlIGNvbnRpbmVvdXMgcGh5c2ljYWxs
eSwgYW5kIHRoZSBsYXR0ZXIgY2FuIGJlIG1lcmdlZAp0byBsYXN0IHNlZ21lbnQgb2YgdGhlIDFz
dCBiaW8sIHdlIHNob3VsZCB0aGluayB0aGV5IGRvbid0CnZpb2xhdGUgc2cgZ2FwKG9yIHZpcnQg
Ym91bmRhcnkpIGxpbWl0LgoKVml0YWx5IHJlcG9ydGVkIGxvdHMgb2YgdW5tZXJnZWFibGUgc21h
bGwgYmlvcyBhcmUgb2JzZXJ2ZWQKd2hlbiBydW5uaW5nIG1rZnMubnRmcyBvbiBIeXBlci1WIHZp
cnR1YWwgc3RvcmFnZSwgYW5kIHBlcmZvcm1hbmNlCmJlY29tZXMgcXVpdGUgbG93LCBzbyB0aGlz
IHBhdGNoIGlzIGZpZ3VyZWQgb3V0IGZvciBmaXggdGhlCnBlcmZvcm1hbmNlIGlzc3VlLgoKUmVw
b3J0ZWQtYnk6IFZpdGFseSBLdXpuZXRzb3YgPHZrdXpuZXRzQHJlZGhhdC5jb20+CkNjOiBLZWl0
aCBCdXNjaCA8a2VpdGguYnVzY2hAaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBNaW5nIExlaSA8
bWluZy5sZWlAY2Fub25pY2FsLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIHwgMjIg
KysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIGIvaW5j
bHVkZS9saW51eC9ibGtkZXYuaAppbmRleCA3ZTVkN2UwLi4zOTYyNTI3IDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L2Jsa2Rldi5oCisrKyBiL2luY2x1ZGUvbGludXgvYmxrZGV2LmgKQEAgLTEz
OTQsNiArMTM5NCwyNSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgYnZlY19nYXBfdG9fcHJldihzdHJ1
Y3QgcmVxdWVzdF9xdWV1ZSAqcSwKIAlyZXR1cm4gX19idmVjX2dhcF90b19wcmV2KHEsIGJwcnYs
IG9mZnNldCk7CiB9CiAKKy8qCisgKiBDaGVjayBpZiB0aGUgdHdvIGJ2ZWNzIGZyb20gdHdvIGJp
b3MgY2FuIGJlIG1lcmdlZCB0byBvbmUgc2VnbWVudC4KKyAqIElmIHllcywgbm8gbmVlZCB0byBj
aGVjayBnYXAgYmV0d2VlbiB0aGUgdHdvIGJpb3Mgc2luY2UgdGhlIDFzdCBiaW8KKyAqIGFuZCB0
aGUgMXN0IGJ2ZWMgaW4gdGhlIDJuZCBiaW8gY2FuIGJlIGhhbmRsZWQgaW4gb25lIHNlZ21lbnQu
CisgKi8KK3N0YXRpYyBpbmxpbmUgYm9vbCBiaW9zX3NlZ3NfbWVyZ2VhYmxlKHN0cnVjdCByZXF1
ZXN0X3F1ZXVlICpxLAorCQlzdHJ1Y3QgYmlvICpwcmV2LCBzdHJ1Y3QgYmlvX3ZlYyAqcHJldl9s
YXN0X2J2LAorCQlzdHJ1Y3QgYmlvX3ZlYyAqbmV4dF9maXJzdF9idikKK3sKKwlpZiAoIUJJT1ZF
Q19QSFlTX01FUkdFQUJMRShwcmV2X2xhc3RfYnYsIG5leHRfZmlyc3RfYnYpKQorCQlyZXR1cm4g
ZmFsc2U7CisJaWYgKCFCSU9WRUNfU0VHX0JPVU5EQVJZKHEsIHByZXZfbGFzdF9idiwgbmV4dF9m
aXJzdF9idikpCisJCXJldHVybiBmYWxzZTsKKwlpZiAocHJldi0+Ymlfc2VnX2JhY2tfc2l6ZSAr
IG5leHRfZmlyc3RfYnYtPmJ2X2xlbiA+CisJCQlxdWV1ZV9tYXhfc2VnbWVudF9zaXplKHEpKQor
CQlyZXR1cm4gZmFsc2U7CisJcmV0dXJuIHRydWU7Cit9CisKIHN0YXRpYyBpbmxpbmUgYm9vbCBi
aW9fd2lsbF9nYXAoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsIHN0cnVjdCBiaW8gKnByZXYsCiAJ
CQkgc3RydWN0IGJpbyAqbmV4dCkKIHsKQEAgLTE0MDMsNyArMTQyMiw4IEBAIHN0YXRpYyBpbmxp
bmUgYm9vbCBiaW9fd2lsbF9nYXAoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsIHN0cnVjdCBiaW8g
KnByZXYsCiAJCWJpb19nZXRfbGFzdF9idmVjKHByZXYsICZwYik7CiAJCWJpb19nZXRfZmlyc3Rf
YnZlYyhuZXh0LCAmbmIpOwogCi0JCXJldHVybiBfX2J2ZWNfZ2FwX3RvX3ByZXYocSwgJnBiLCBu
Yi5idl9vZmZzZXQpOworCQlpZiAoIWJpb3Nfc2Vnc19tZXJnZWFibGUocSwgcHJldiwgJnBiLCAm
bmIpKQorCQkJcmV0dXJuIF9fYnZlY19nYXBfdG9fcHJldihxLCAmcGIsIG5iLmJ2X29mZnNldCk7
CiAJfQogCiAJcmV0dXJuIGZhbHNlOwotLSAKMS45LjEKCg==
--001a114da67e626da1052f43d376--
