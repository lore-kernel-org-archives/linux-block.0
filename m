Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6ACC3A5A2
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3650E20863
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 10:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="QF1YyFIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392186AbfIJKMn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:12:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41609 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392136AbfIJKMm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 06:12:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id a4so15802869ljk.8
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2019 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIypOE6gjfATSZoix2kguReUWJHTcsgf5EsyS0T781E=;
        b=QF1YyFIkmZH8XMjdajrv1LsBZvMStMtL9CdUSsoqF53hVExeBX3ofrdCsBZ/RfLbEZ
         bF4iUNbPwTMCFtuQY7B4eVyLSqzqCXxcg4t2ySUWC4RnI1xw47mTDnuJPWLAvv0Eo9yU
         609AkfC6pXkT7Imqgs74GtajM0JLN+FY+WK9b9qvpWMRLyfRzMGzlwPB3JVr637fDM2A
         AI6JTjXcTKRxXeiVwtwR+OqEQLANkMr6+OEr4ATQm8mkUDW8kvYvuhlm5VjTcWVfhFRc
         h2Fdu1B2THjxZfDG5pRqklTDwtnEmJLYNHkxRdzInkLugfKm1y9uLWZYt9S6gEzgB1/6
         DPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIypOE6gjfATSZoix2kguReUWJHTcsgf5EsyS0T781E=;
        b=WZnLwHIDOamQaCpmzDI0/qLvqzCGmgSAXELZtZw4OOKdkkCuC32ePpdirX6MnbB48x
         wK3np0JKkqF3Qc3AQFEbRfOs4Z3xk7LJze5xp283a80RqJQ50NcjmrDP7CHBxeDMo/r7
         0oe3TRW4wlDgxIFHpEc0yppoAon6tbaPdJOfZBlnv7O7ZaY+JM6F5IZXPzgWQ4TnpdCc
         O4QScvkR6SaneVG4cqNu/6RQJFCJlNdcoGa0XkwLorBufLk6jhH1IuE3AId7oTDLB+N6
         GtmIDf8KtQCEZ/fIuI/GsRRbyFMG0iKRTXikzfTur/qI1MAVNZMC6lCATTDmtkFxqLkR
         omNw==
X-Gm-Message-State: APjAAAWD2gj7jh+rfwsKBkji/r269qZMvPvALj0xf8VKWQjXjfIEMv/v
        k+d6aXZ4IuijznJUn6aHDfWe0Ozcb3tbt1BWsVYJmg==
X-Google-Smtp-Source: APXvYqyn5Iv26yGhGRoybRCrkATjmQRFJ0chHHX7nMpvtSffVmLBw/0PY1zHPe2ZxcY10fGaOxP0+hSePlHfRh5I4zU=
X-Received: by 2002:a2e:9602:: with SMTP id v2mr19496698ljh.215.1568110359105;
 Tue, 10 Sep 2019 03:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190828103229.191853-1-maco@android.com> <20190904194901.165883-1-maco@android.com>
In-Reply-To: <20190904194901.165883-1-maco@android.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 10 Sep 2019 12:12:28 +0200
Message-ID: <CAB0TPYHjPbzMNqS6wiYmjUjrmROSVVCYsSQLjwE+PUOBsMH_mw@mail.gmail.com>
Subject: Re: [PATCH v2] loop: change queue block size to match when using DIO.
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, Ming,

Do you have any thoughts about this patch?

Thanks,
Martijn

On Wed, Sep 4, 2019 at 9:49 PM Martijn Coenen <maco@android.com> wrote:
>
> The loop driver assumes that if the passed in fd is opened with
> O_DIRECT, the caller wants to use direct I/O on the loop device.
> However, if the underlying block device has a different block size than
> the loop block queue, direct I/O can't be enabled. Instead of requiring
> userspace to manually change the blocksize and re-enable direct I/O,
> just change the queue block sizes to match, as well as the io_min size.
>
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
> v2 changes:
> - Fixed commit message to say the block size must match the underlying
>   block device, not the underlying filesystem.
> - Also set physical blocksize and minimal io size correspondingly.
>
>  drivers/block/loop.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index ab7ca5989097a..b547182037af2 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -994,6 +994,16 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>         if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
>                 blk_queue_write_cache(lo->lo_queue, true, false);
>
> +       if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
> +               /* In case of direct I/O, match underlying block size */
> +               unsigned short bsize = bdev_logical_block_size(
> +                       inode->i_sb->s_bdev);
> +
> +               blk_queue_logical_block_size(lo->lo_queue, bsize);
> +               blk_queue_physical_block_size(lo->lo_queue, bsize);
> +               blk_queue_io_min(lo->lo_queue, bsize);
> +       }
> +
>         loop_update_rotational(lo);
>         loop_update_dio(lo);
>         set_capacity(lo->lo_disk, size);
> --
> 2.23.0.187.g17f5b7556c-goog
>
