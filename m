Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB365C2BA2B
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF7E221F4
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 21:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587073630;
	bh=O0jTG9Ra02LYjnv/dN6oNAbka5Sxf7aAlBRHqJ5EXbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pL1WkQ8HKqNkBdK3M2mUFQKVaRlSmgCW5MtAawOKTssKNrNbIF6p/LzDWq3hWojlz
	 02V+blPyipjnrt3sUT3H3k9WWG4bZ7nSzSQLE1X1sa/wkszf2n/P3Kw2i2r8iio6fj
	 DfBP3aB3yjaO4gKQi2PjMF+KYWjy1Aw8Vc0QB9pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgDPVrK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725272AbgDPVrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 17:47:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3094C061A0C;
        Thu, 16 Apr 2020 14:47:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x26so27276pgc.10;
        Thu, 16 Apr 2020 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XvuuXLOHymS1FHJTnlaugvb+awNBupqGn5YXTPlOV04=;
        b=JQsFRvFTQpe6O9KKf/gIp/reL/H5Zv2kxLe0BNS4q09IJnHVo9Sa0ZNl13CEA0k37V
         d+v0DMEAdvNT9fZA3BMYhP7LELpRotTWq4jhyziuDW4S17xz6FTMWR1fEuKwttgF8EOv
         WNvLsV+HTRdox3u9N89vZ4JY2IwyjbvI3PEhOC6QRlGuDvdztpiWVdSIu2AeyrQwO9MX
         EiHunmJxtlTO8H0AVOvkiwVGm4vJj1bzDlBOSx8cohUjEgXxCM/rVkQ2hUTopHjRnmKp
         eLu8vwkUZTWoc0zS3Kxe8aUAHAa5DrFRhrwERrpqaL4c6utQ0ZFQsYHrlA34KNcCvc4C
         u+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XvuuXLOHymS1FHJTnlaugvb+awNBupqGn5YXTPlOV04=;
        b=LbLixvNkaHc511lrp29SRK2SG5mCFyTlEVApNH5n/9UqNiUC40zg3QX+8w76JUXf7Q
         etL7K3Iyiusxh1H54Vp2xPwllu1G4zeAeIAQPk/10SClCdpBGpVqU1rnqg0xq9IM3kHJ
         yssZVJ3Uw2wqZFCOe8FaCoUC0FX6vHI+OuVdopPsIXOAi00JMRaSM200iuGmu9eNS1vQ
         JFfr70HpVPZNqpv/rhu68S9H8eZ4Man2rWIK3KpBqjlB3an9fuIoAeIdT2fEdi1oeG7O
         0e70XWiTDbnLMZat7yFtLXcvWh3s7/pRlYB3a721Z6dJo8JkwwAnEMxNf0g0he954nyZ
         igog==
X-Gm-Message-State: AGi0PuY/YMzjPgaAQUJSXMmdnS5d6QEFgg89NlF3lwv0OlDZiJucgx2f
        FWuNOGHGuYNjujLAXLlagpg=
X-Google-Smtp-Source: APiQypKOs1IuYNZdetQ0Nuw1n9JSd3g9dMF6iUARx3tOTe2CEOtTRyQv5fapFQ/OjQ6uQ108y/Kijg==
X-Received: by 2002:aa7:9087:: with SMTP id i7mr34447768pfa.76.1587073627289;
        Thu, 16 Apr 2020 14:47:07 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id h15sm5859923pfe.92.2020.04.16.14.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:47:06 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:47:04 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Justin Gottula <justin@jgottula.com>,
        sergey.senozhatsky.work@gmail.com
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: fix writeback_store returning zero in most
 situations
Message-ID: <20200416214649.GA60148@google.com>
References: <CAKuMfTUPzPjuNk+T_GQMCKoB9ssh2arr6xRiu6VODwwB0PMdZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKuMfTUPzPjuNk+T_GQMCKoB9ssh2arr6xRiu6VODwwB0PMdZw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 14, 2020 at 10:24:18PM -0700, Justin Gottula wrote:
> Commit 3b82a051c101 ("zram: fix error return codes not being returned in
> writeback_store") altered the return value logic in writeback_store such
> that ret = len is done at the beginning of the function, which alleviated
> an issue where the -EIO and -ENOSPC break-outs from the for-loop would
> unintentionally hit the ret = len previously located at the end of the
> function. That change in itself was largely fine; however, it exposed
> another return value logic problem.
> 
> Currently, when the writeback_store for-loop does _not_ encounter the -EIO
> or -ENOSPC situations, and _does_ attempt to write at least one block to
> the backing device, the function will simply return whatever the most
> recent submit_bio_wait return value was. This means that if at least one
> block write is attempted, the function will never actually return len; and,
> if the last written block's call to submit_bio_wait was successful, then
> the function will actually return _zero_. (Prior to the above-mentioned
> patch, this situation was masked by the fact that the ret = len assignment
> occurred _after_ all calls to submit_bio_wait.)
> 
> So, if writeback of one or more blocks is attempted, and the last
> submit_bio_wait is successful (which will usually be the case), userspace
> programs performing write(3) syscalls to /sys/block/zramN/writeback will
> receive a return value of zero. Well-written programs use non-negative
> return values from write(3) to determine if a partial write occurred, and
> in that circumstance, they generally add the value to their buffer pointer
> and call write(3) again. Programs written this way will, as a result,
> effectively spin in a loop calling write(3) forever (or at least until an
> actual error value does finally crop up), repeatedly writing the entire
> string buffer ("huge" or "idle") to the writeback file and getting the
> false impression that no forward progress is being made, since zero bytes
> of the buffer are apparently being consumed with each syscall.
> 
> I came across this problem while adding a new parameter to the zramctl
> program, in a personal fork of the util-linux suite, that would allow the
> user to easily request writeback on a zram device. In zramctl (and the
> util-linux programs in general), sysfs writes are typically done via
> ul_path_write_string, which invokes write_all. The write_all utility
> function is written in such a way that write(3) return values _not greater
> than zero_ are treated as error conditions; upon which, any errno value
> other than EINTR or EAGAIN will cause the function to bail out and indicate
> an error. A return value of zero is indeed greater than zero; and an errno
> value of zero is neither EINTR nor EAGAIN; so write_all bails and indicates
> an error. (And thanks to automatic strerror-based printout functions, this
> of course produces the message "error: Success", a personal favorite of
> mine.)
> 
> The writeback_store return value problem is addressed by storing the
> submit_bio_wait result in a separate local variable, which is only assigned
> to ret if it is actually an errno value.
> 
> The behavior should now be that, if an error arises from one or more of the
> calls to submit_bio_wait during writeback_store, and none of the other
> explicit error cases in the function are triggered, then the most recent
> submit_bio_wait error will be returned. Otherwise, the function will return
> len.
> 
> Fixes: a939888ec38b ("zram: support idle/huge page writeback")
> Signed-off-by: Justin Gottula <justin@jgottula.com>

Thanks for the patch, Justin.

I couldn't remember why I wanted to do continue even though we knew
the write was failure from the beginning.

Couldn't we just bail out whenever we encounter the error?
Sergey, Justin, what do you think?

IMO, it would be more consistent with other error handling.

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1bdb5793842b..e444359edaf5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -703,12 +703,13 @@ static ssize_t writeback_store(struct device *dev,
                /* Need for hugepage writeback racing */
                zram_set_flag(zram, index, ZRAM_IDLE);
                zram_slot_unlock(zram, index);
-               if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
+               ret = zram_bvec_read(zram, &bvec, index, 0, NULL);
+               if (ret) {
                        zram_slot_lock(zram, index);
                        zram_clear_flag(zram, index, ZRAM_UNDER_WB);
                        zram_clear_flag(zram, index, ZRAM_IDLE);
                        zram_slot_unlock(zram, index);
-                       continue;
+                       break;
                }

                bio_init(&bio, &bio_vec, 1);
@@ -728,7 +729,7 @@ static ssize_t writeback_store(struct device *dev,
                        zram_clear_flag(zram, index, ZRAM_UNDER_WB);
                        zram_clear_flag(zram, index, ZRAM_IDLE);
                        zram_slot_unlock(zram, index);
-                       continue;
+                       break;
                }

                atomic64_inc(&zram->stats.bd_writes);


> ---
> Side Note: My understanding of whether a return value of zero from
> write(3) is actually even valid--given a nonzero length parameter--became a
> whole lot murkier when I took a really close look at the Linux and POSIX
> man pages, as well as Internet discussions on the topic. Initially I was
> sure that a zero return value indicated that no error had occurred, but
> that no forward progress on the write had been made either; and that as
> such, the implementation of write_all in util-linux was faulty. But now
> I've come to understand that apparently some historical implementations of
> write(3) have actually returned zero as an indication that a non-blocking
> write on certain special files would block (though modern POSIX specifies
> returning -1 and setting errno to EAGAIN for this case); and that a return
> value of zero may apparently be used as an EOF indication. So perhaps
> treating a zero result as an error in write_all, implicit and accidental
> though it may have appeared, was actually intentional and well-founded all
> along; I don't entirely know. In any case, though, it's clear that the zram
> driver shouldn't be returning 0 in this circumstance.
> 
>  drivers/block/zram/zram_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 1bf4a908a0bd..e55330a615c2 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -627,6 +627,7 @@ static ssize_t writeback_store(struct device *dev,
>     struct bio_vec bio_vec;
>     struct page *page;
>     ssize_t ret = len;
> +   int bio_ret;
>     int mode;
>     unsigned long blk_idx = 0;
> 
> @@ -719,8 +720,9 @@ static ssize_t writeback_store(struct device *dev,
>          * XXX: A single page IO would be inefficient for write
>          * but it would be not bad as starter.
>          */
> -       ret = submit_bio_wait(&bio);
> -       if (ret) {
> +       bio_ret = submit_bio_wait(&bio);
> +       if (bio_ret) {
> +           ret = bio_ret;
>             zram_slot_lock(zram, index);
>             zram_clear_flag(zram, index, ZRAM_UNDER_WB);
>             zram_clear_flag(zram, index, ZRAM_IDLE);
> --
> 2.25.1
