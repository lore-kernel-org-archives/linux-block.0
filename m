Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EB7C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 15:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36CE21D40
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 15:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAqh+e28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgKLPit (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 10:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbgKLPis (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 10:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605195526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zgjZ6uAMP0CPhiOgr06Yl8Eq2fpEZG2FwaFBfXxgEAA=;
        b=dAqh+e289CO42DFRSqCd+57/z9SARgn23weRZg01BSNp6JxF8wCRaIF2fbLj7QGZhrVwzj
        4MQJO9FAxXznxEuxa/ZLjTze9UCTNcdve7hsXZsUs/RHN9EweOObW9A7I1BZXjPffTGiJl
        ApwpOUeCWN563in3U4kS2QrIDmCnsyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-z9Q3yDSJPjiGZz_YUWl4HA-1; Thu, 12 Nov 2020 10:38:44 -0500
X-MC-Unique: z9Q3yDSJPjiGZz_YUWl4HA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 674A7101F01D;
        Thu, 12 Nov 2020 15:38:42 +0000 (UTC)
Received: from starship (unknown [10.35.206.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7535C5B4C2;
        Thu, 12 Nov 2020 15:38:38 +0000 (UTC)
Message-ID: <fbe9f98d6fa9ecd5f53fd284216c740d2d4a723a.camel@redhat.com>
Subject: Re: [PATCH 0/2] RFC: Issue with discards on raw block device
 without O_DIRECT
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
        Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>,
        Max Reitz <mreitz@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        qemu-block@nongnu.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Date:   Thu, 12 Nov 2020 17:38:36 +0200
In-Reply-To: <20201112111951.GB27697@quack2.suse.cz>
References: <20201111153913.41840-1-mlevitsk@redhat.com>
         <03b01c699c9fab64736d04891f1e835aef06c886.camel@redhat.com>
         <20201112111951.GB27697@quack2.suse.cz>
Content-Type: multipart/mixed; boundary="=-Hwz/1yE9HW9dKC8yVEhP"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--=-Hwz/1yE9HW9dKC8yVEhP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-11-12 at 12:19 +0100, Jan Kara wrote:
> [added some relevant people and lists to CC]
> 
> On Wed 11-11-20 17:44:05, Maxim Levitsky wrote:
> > On Wed, 2020-11-11 at 17:39 +0200, Maxim Levitsky wrote:
> > > clone of "starship_production"
> > 
> > The git-publish destroyed the cover letter:
> > 
> > For the reference this is for bz #1872633
> > 
> > The issue is that current kernel code that implements 'fallocate'
> > on kernel block devices roughly works like that:
> > 
> > 1. Flush the page cache on the range that is about to be discarded.
> > 2. Issue the discard and wait for it to finish.
> >    (as far as I can see the discard doesn't go through the
> >    page cache).
> > 
> > 3. Check if the page cache is dirty for this range,
> >    if it is dirty (meaning that someone wrote to it meanwhile)
> >    return -EBUSY.
> > 
> > This means that if qemu (or qemu-img) issues a write, and then
> > discard to the area that shares a page, -EBUSY can be returned by
> > the kernel.
> 
> Indeed, if you don't submit PAGE_SIZE aligned discards, you can get back
> EBUSY which seems wrong to me. IMO we should handle this gracefully in the
> kernel so we need to fix this.
> 
> > On the other hand, for example, the ext4 implementation of discard
> > doesn't seem to be affected. It does take a lock on the inode to avoid
> > concurrent IO and flushes O_DIRECT writers prior to doing discard thought.
> 
> Well, filesystem hole punching is somewhat different beast than block device
> discard (at least implementation wise).
> 
> > Doing fsync and retrying is seems to resolve this issue, but it might be
> > a too big hammer.  Just retrying doesn't work, indicating that maybe the
> > code that flushes the page cache in (1) doesn't do this correctly ?
> > 
> > It also can be racy unless special means are done to block IO from happening
> > from qemu during this fsync.
> > 
> > This patch series contains two patches:
> > 
> > First patch just lets the file-posix ignore the -EBUSY errors, which is
> > technically enough to fail back to plain write in this case, but seems wrong.
> > 
> > And the second patch adds an optimization to qemu-img to avoid such a
> > fragmented write/discard in the first place.
> > 
> > Both patches make the reproducer work for this particular bugzilla,
> > but I don't think they are enough.
> > 
> > What do you think?
> 
> So if the EBUSY error happens because something happened to the page cache
> outside of discarded range (like you describe above), that is a kernel bug
> than needs to get fixed. EBUSY should really mean - someone wrote to the
> discarded range while discard was running and userspace app has to deal
> with that depending on what it aims to do...
I double checked this, those are the writes/discards according to my debug
prints (I print start and then start+len-1 for each request)
I have attached the patch for this for reference.

ZERO: 0x00007fe00000 00007fffefff (len:0x1ff000)
       fallocate 00007fe00000 00007fffefff
WRITE: 0x00007ffff000 00007ffffdff (len:0xe00)
       write 00007ffff000 00007ffffdff
ZERO: 0x00007ffffe00
0000801fefff (len:0x1ff200)
       fallocate 00007ffffe00 0000801fefff
FALLOCATE failed with error 16
qemu-img: error while writing at byte 2147483136: Device or resource busy


Best regards,
     Maxim Levitsky

> 
> 								Honza


--=-Hwz/1yE9HW9dKC8yVEhP
Content-Disposition: attachment; filename="hacks.diff"
Content-Type: text/x-patch; name="hacks.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

Y29tbWl0IGNlODk3MjUwYmFiZTM1MjdmNDUxYzFjNTRjODZiNjI2NTlhMmMyOWUKQXV0aG9yOiBN
YXhpbSBMZXZpdHNreSA8bWxldml0c2tAcmVkaGF0LmNvbT4KRGF0ZTogICBUaHUgT2N0IDE1IDE3
OjAyOjU4IDIwMjAgKzAzMDAKCiAgICBoYWNrcwoKZGlmZiAtLWdpdCBhL2Jsb2NrL2ZpbGUtcG9z
aXguYyBiL2Jsb2NrL2ZpbGUtcG9zaXguYwppbmRleCBjNjM5MjZkNTkyLi45MWNhNjkwNTA1IDEw
MDY0NAotLS0gYS9ibG9jay9maWxlLXBvc2l4LmMKKysrIGIvYmxvY2svZmlsZS1wb3NpeC5jCkBA
IC0xNDQwLDYgKzE0NDAsMTIgQEAgc3RhdGljIHNzaXplX3QgaGFuZGxlX2Fpb2NiX3J3X2xpbmVh
cihSYXdQb3NpeEFJT0RhdGEgKmFpb2NiLCBjaGFyICpidWYpCiAKICAgICB3aGlsZSAob2Zmc2V0
IDwgYWlvY2ItPmFpb19uYnl0ZXMpIHsKICAgICAgICAgaWYgKGFpb2NiLT5haW9fdHlwZSAmIFFF
TVVfQUlPX1dSSVRFKSB7CisKKyAgICAgICAgICAgIGxvbmcgdW5zaWduZWQgaW50IHNpemUgPSBh
aW9jYi0+YWlvX25ieXRlcyAtIG9mZnNldDsKKyAgICAgICAgICAgIGxvbmcgdW5zaWduZWQgaW50
IG9mZiA9IGFpb2NiLT5haW9fb2Zmc2V0ICsgb2Zmc2V0OworCisgICAgICAgICAgICBwcmludGYo
IiAgICAgICB3cml0ZSAlMDEybHggJTAxMmx4XG4iLCBvZmYsIG9mZitzaXplLTEpOworCiAgICAg
ICAgICAgICBsZW4gPSBwd3JpdGUoYWlvY2ItPmFpb19maWxkZXMsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgKGNvbnN0IGNoYXIgKilidWYgKyBvZmZzZXQsCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgYWlvY2ItPmFpb19uYnl0ZXMgLSBvZmZzZXQsCkBAIC0xNTgxLDEwICsxNTg3LDE1IEBA
IHN0YXRpYyBpbnQgdHJhbnNsYXRlX2VycihpbnQgZXJyKQogc3RhdGljIGludCBkb19mYWxsb2Nh
dGUoaW50IGZkLCBpbnQgbW9kZSwgb2ZmX3Qgb2Zmc2V0LCBvZmZfdCBsZW4pCiB7CiAgICAgZG8g
eworCisgICAgICAgIHByaW50ZigiICAgICAgIGZhbGxvY2F0ZSAlMDEybHggJTAxMmx4XG4iLCBv
ZmZzZXQsIG9mZnNldCtsZW4tMSk7CisKICAgICAgICAgaWYgKGZhbGxvY2F0ZShmZCwgbW9kZSwg
b2Zmc2V0LCBsZW4pID09IDApIHsKICAgICAgICAgICAgIHJldHVybiAwOwogICAgICAgICB9CiAg
ICAgfSB3aGlsZSAoZXJybm8gPT0gRUlOVFIpOworCisgICAgcHJpbnRmKCJGQUxMT0NBVEUgZmFp
bGVkIHdpdGggZXJyb3IgJWRcbiIsIGVycm5vKTsKICAgICByZXR1cm4gdHJhbnNsYXRlX2Vycigt
ZXJybm8pOwogfQogI2VuZGlmCmRpZmYgLS1naXQgYS9xZW11LWltZy5jIGIvcWVtdS1pbWcuYwpp
bmRleCBjMmM1NmZjNzk3Li42NGQzYjg0NzI4IDEwMDY0NAotLS0gYS9xZW11LWltZy5jCisrKyBi
L3FlbXUtaW1nLmMKQEAgLTE4MDMsNiArMTgwMyw3IEBAIHN0YXRpYyBpbnQgY29udmVydF9pdGVy
YXRpb25fc2VjdG9ycyhJbWdDb252ZXJ0U3RhdGUgKnMsIGludDY0X3Qgc2VjdG9yX251bSkKICAg
ICAgICAgfQogCiAgICAgICAgIHMtPnNlY3Rvcl9uZXh0X3N0YXR1cyA9IHNlY3Rvcl9udW0gKyBu
OworICAgICAgICBwcmludGYoIk5FWFRfU1RBVFVTOiAlbHhcbiIsIHMtPnNlY3Rvcl9uZXh0X3N0
YXR1cyA8PCA5KTsKICAgICB9CiAKICAgICBuID0gTUlOKG4sIHMtPnNlY3Rvcl9uZXh0X3N0YXR1
cyAtIHNlY3Rvcl9udW0pOwpAQCAtMTg3OCw2ICsxODc5LDEwIEBAIHN0YXRpYyBpbnQgY29yb3V0
aW5lX2ZuIGNvbnZlcnRfY29fcmVhZChJbWdDb252ZXJ0U3RhdGUgKnMsIGludDY0X3Qgc2VjdG9y
X251bSwKICAgICByZXR1cm4gMDsKIH0KIAorc3RhdGljIHZvaWQgdGVzdF9wcmludChjb25zdCBj
aGFyKiBvcCwgdW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBsZW4pCit7CisgICAg
cHJpbnRmKCIlczogMHglMDEybHggJTAxMmx4IChsZW46MHglbHgpXG4iLCBvcCwgc3RhcnQsIHN0
YXJ0ICsgbGVuLTEsIGxlbik7Cit9CiAKIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGNvbnZlcnRf
Y29fd3JpdGUoSW1nQ29udmVydFN0YXRlICpzLCBpbnQ2NF90IHNlY3Rvcl9udW0sCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBuYl9zZWN0b3JzLCB1aW50OF90
ICpidWYsCkBAIC0xOTExLDYgKzE5MTYsOCBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBjb252
ZXJ0X2NvX3dyaXRlKEltZ0NvbnZlcnRTdGF0ZSAqcywgaW50NjRfdCBzZWN0b3JfbnVtLAogICAg
ICAgICAgICAgICAgIChzLT5jb21wcmVzc2VkICYmCiAgICAgICAgICAgICAgICAgICFidWZmZXJf
aXNfemVybyhidWYsIG4gKiBCRFJWX1NFQ1RPUl9TSVpFKSkpCiAgICAgICAgICAgICB7CisgICAg
ICAgICAgICAgICAgdGVzdF9wcmludCgiV1JJVEUiLCBzZWN0b3JfbnVtIDw8IEJEUlZfU0VDVE9S
X0JJVFMsIG4gPDwgQkRSVl9TRUNUT1JfQklUUyk7CisKICAgICAgICAgICAgICAgICByZXQgPSBi
bGtfY29fcHdyaXRlKHMtPnRhcmdldCwgc2VjdG9yX251bSA8PCBCRFJWX1NFQ1RPUl9CSVRTLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbiA8PCBCRFJWX1NFQ1RPUl9CSVRT
LCBidWYsIGZsYWdzKTsKICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkgewpAQCAtMTkyNSw2
ICsxOTMyLDggQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gY29udmVydF9jb193cml0ZShJbWdD
b252ZXJ0U3RhdGUgKnMsIGludDY0X3Qgc2VjdG9yX251bSwKICAgICAgICAgICAgICAgICBhc3Nl
cnQoIXMtPnRhcmdldF9oYXNfYmFja2luZyk7CiAgICAgICAgICAgICAgICAgYnJlYWs7CiAgICAg
ICAgICAgICB9CisgICAgICAgICAgICB0ZXN0X3ByaW50KCJaRVJPIiwgc2VjdG9yX251bSA8PCBC
RFJWX1NFQ1RPUl9CSVRTLCBuIDw8IEJEUlZfU0VDVE9SX0JJVFMpOworCiAgICAgICAgICAgICBy
ZXQgPSBibGtfY29fcHdyaXRlX3plcm9lcyhzLT50YXJnZXQsCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzZWN0b3JfbnVtIDw8IEJEUlZfU0VDVE9SX0JJVFMsCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuIDw8IEJEUlZfU0VDVE9SX0JJVFMs
Cg==


--=-Hwz/1yE9HW9dKC8yVEhP--

