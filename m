Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323ABC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 01:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6A9218CD
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 01:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8UxZmeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfB0BVY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:21:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43888 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfB0BVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 20:21:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so16002846wre.10;
        Tue, 26 Feb 2019 17:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjjAaXPqi8GayCAqIMUeuJBC0yn/3Txg9bC1YYFc5WU=;
        b=O8UxZmePwKXoHyR5eNGdPT379+BKhfrv7KUmneyHd/VG5F9xHhXoa/N3Y8u5O8b8z6
         YRqmSSdxmB6WC/Oao67SQyLLc7oyIEQl08XQJBeTkdL3Zbr+x4NXArLLOq2TXciV9ksq
         PoyCzgCCnkwTs7NcM8mquoiqoLoSjGhwM06ROP2kHUZscqIpw2xL2IB9J4U8wSVftRpJ
         7PCEeWmy2o7kasfjBf6gQwhZ6U0Usql4CXeuaum79iO+lKQUvVF+NSKac6Y0GXlCXXQS
         WZAZo79APyyYsDrq4cuF/sCB5mxzUIcPCUvO4TtTNPf6Ffvr/kIbVACXnsVRgEpcXqgL
         yvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjjAaXPqi8GayCAqIMUeuJBC0yn/3Txg9bC1YYFc5WU=;
        b=b8RZFU9lP+7USofcql6drQ0xkFkZaXtddPrUIyeurKj/7lQmXc2W4wFjKVJEYnIblK
         OGoarUxbh69woHSvL2fb1kR86ZKwQyzTxPFXwSkqNek4XA9k2gDQKoBU4ITP2FjKiDjV
         L7AWq1oxNNu05dVmi/HGK773+g6UKuO3QDbUqZ93HqIWKkF//IwnCxQkyJO8IzSEaMjY
         bwg3h8+EUtmNQHgWezkQjpwRXEh0iTtmluwzBIXkMCW0maRSp2SD3PvbtSaDUL6E9tM6
         aIuXXLaRipdYr0B77OQW6VvfWcnT5d9GX/2M6YWlMVMYBZOJP5TiY+Y9N7Nwg9Pyh//O
         qKVg==
X-Gm-Message-State: APjAAAVc+2mxS5VrXkH5L/eT4DX5yt+NnJr4M9jJht0izkcTyRb06pWF
        ARxRSSLGu+Ij3ltwOSuS0RvnHDQrVIo8yKV0NZepOrZBLrs=
X-Google-Smtp-Source: APXvYqyJIhcRib0sxTOoNAwevD8gFTmdZrlsKDj9NCrTKKGfTcfYdwd+/lmH/Jl8sg4E+tUjHIFHntg5wygoq/Kaz/c=
X-Received: by 2002:a05:6000:10c1:: with SMTP id b1mr308226wrx.275.1551230481389;
 Tue, 26 Feb 2019 17:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20190211190049.7888-1-axboe@kernel.dk> <20190211190049.7888-13-axboe@kernel.dk>
 <20190220225856.GB28313@ming.t460p> <b143e8c3-33d5-5f09-c441-98b3bf326d81@kernel.dk>
 <20190226034613.GA676@sol.localdomain> <aa1184bb-b482-0637-21e4-1ddb0e7aea90@kernel.dk>
 <1652577e-787b-638e-625d-c200fb144a9d@kernel.dk>
In-Reply-To: <1652577e-787b-638e-625d-c200fb144a9d@kernel.dk>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 27 Feb 2019 09:21:09 +0800
Message-ID: <CACVXFVNOFA8_p+hVvaCffWAQ7+dgn++0b4Wn3naJzyNZN=CoFg@mail.gmail.com>
Subject: Re: [PATCH 11/19] block: implement bio helper to add iter bvec pages
 to bio
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        "open list:AIO" <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        jannh@google.com, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 11:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/25/19 9:34 PM, Jens Axboe wrote:
> > On 2/25/19 8:46 PM, Eric Biggers wrote:
> >> Hi Jens,
> >>
> >> On Thu, Feb 21, 2019 at 10:45:27AM -0700, Jens Axboe wrote:
> >>> On 2/20/19 3:58 PM, Ming Lei wrote:
> >>>> On Mon, Feb 11, 2019 at 12:00:41PM -0700, Jens Axboe wrote:
> >>>>> For an ITER_BVEC, we can just iterate the iov and add the pages
> >>>>> to the bio directly. This requires that the caller doesn't releases
> >>>>> the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.
> >>>>>
> >>>>> The current two callers of bio_iov_iter_get_pages() are updated to
> >>>>> check if they need to release pages on completion. This makes them
> >>>>> work with bvecs that contain kernel mapped pages already.
> >>>>>
> >>>>> Reviewed-by: Hannes Reinecke <hare@suse.com>
> >>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>>> ---
> >>>>>  block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
> >>>>>  fs/block_dev.c            |  5 ++--
> >>>>>  fs/iomap.c                |  5 ++--
> >>>>>  include/linux/blk_types.h |  1 +
> >>>>>  4 files changed, 56 insertions(+), 14 deletions(-)
> >>>>>
> >>>>> diff --git a/block/bio.c b/block/bio.c
> >>>>> index 4db1008309ed..330df572cfb8 100644
> >>>>> --- a/block/bio.c
> >>>>> +++ b/block/bio.c
> >>>>> @@ -828,6 +828,23 @@ int bio_add_page(struct bio *bio, struct page *page,
> >>>>>  }
> >>>>>  EXPORT_SYMBOL(bio_add_page);
> >>>>>
> >>>>> +static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
> >>>>> +{
> >>>>> + const struct bio_vec *bv = iter->bvec;
> >>>>> + unsigned int len;
> >>>>> + size_t size;
> >>>>> +
> >>>>> + len = min_t(size_t, bv->bv_len, iter->count);
> >>>>> + size = bio_add_page(bio, bv->bv_page, len,
> >>>>> +                         bv->bv_offset + iter->iov_offset);
> >>>>
> >>>> iter->iov_offset needs to be subtracted from 'len', looks
> >>>> the following delta change[1] is required, otherwise memory corruption
> >>>> can be observed when running xfstests over loop/dio.
> >>>
> >>> Thanks, I folded this in.
> >>>
> >>> --
> >>> Jens Axboe
> >>>
> >>
> >> syzkaller started hitting a crash on linux-next starting with this commit, and
> >> it still occurs even with your latest version that has Ming's fix folded in.
> >> Specifically, commit a566653ab5ab80a from your io_uring branch with commit date
> >> Sun Feb 24 08:20:53 2019 -0700.
> >>
> >> Reproducer:
> >>
> >> #define _GNU_SOURCE
> >> #include <fcntl.h>
> >> #include <linux/loop.h>
> >> #include <sys/ioctl.h>
> >> #include <sys/sendfile.h>
> >> #include <sys/syscall.h>
> >> #include <unistd.h>
> >>
> >> int main(void)
> >> {
> >>         int memfd, loopfd;
> >>
> >>         memfd = syscall(__NR_memfd_create, "foo", 0);
> >>
> >>         pwrite(memfd, "\xa8", 1, 4096);
> >>
> >>         loopfd = open("/dev/loop0", O_RDWR|O_DIRECT);
> >>
> >>         ioctl(loopfd, LOOP_SET_FD, memfd);
> >>
> >>         sendfile(loopfd, loopfd, NULL, 1000000);
> >> }
> >>
> >>
> >> Crash:
> >>
> >> page:ffffea0001a6aab8 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> >> flags: 0x100000000000000()
> >> raw: 0100000000000000 ffffea0001ad2c50 ffff88807fca49d0 0000000000000000
> >> raw: 0000000000000000 0000000000000000 00000000ffffffff
> >> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> >
> > I see what this is, I'll cut a fix for this tomorrow.
>
> Folded in a fix for this, it's in my current io_uring branch and my for-next
> branch.

Hi Jens,

I saw the following change is added:

+ if (size == len) {
+ /*
+ * For the normal O_DIRECT case, we could skip grabbing this
+ * reference and then not have to put them again when IO
+ * completes. But this breaks some in-kernel users, like
+ * splicing to/from a loop device, where we release the pipe
+ * pages unconditionally. If we can fix that case, we can
+ * get rid of the get here and the need to call
+ * bio_release_pages() at IO completion time.
+ */
+ get_page(bv->bv_page);

Now the 'bv' may point to more than one page, so the following one may be
needed:

int i;
struct bvec_iter_all iter_all;
struct bio_vec *tmp;

mp_bvec_for_each_segment(tmp, bv, i, iter_all)
      get_page(tmp->bv_page);

Thanks,
Ming Lei
