Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20A9C77B7D
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 14:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbjEJORk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjEJORk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 10:17:40 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53E32D63
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 07:17:38 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-54f846d24d1so1168631eaf.3
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683728258; x=1686320258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cCQabe5JuhcRvJtO/OpwB2FMEEy+ObXllS788CtQPhs=;
        b=HNyKOsL6NpUR27yCluKCwskCvlxEApb4vYTzN5JHc9nt5+hFMfhQVf3rArrsTdGx7E
         nxrvtMHvJofMZbB/AJfaHWUkEEWTMMSlzFtt+Zp44oC7I66ObIN3GJvZjr4Ji2BrLqak
         4+EZ2lTWuSO0P0oM7Vu+BKbHQchJzFsyLFhyUOv8ZBQm4HFBudR+VlxOYvd9TlbjTd/G
         925lXPdMomPEVTtTPDiX9T8IQ+NmNekpBNTq62rdqFWozXejjHUgmqW6JmisUdrb2E9p
         cpWt9iiaGYaRucid4RQkFUr0q9n9jDJcojSI+1L8cnil4d9v9on/o7hLmsWRmTKm0RUl
         7/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728258; x=1686320258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCQabe5JuhcRvJtO/OpwB2FMEEy+ObXllS788CtQPhs=;
        b=TZj1nHcITn9OIiVyDrfehcGRN5gevV95iLlKKXo1dZanEaZyJmSvEhCo0QFHSHb5ao
         5ZxJpEe7ccbfTzJZ0vqP3xWMt8ec8T1bVDKl0/AQKc1iG1RdyOqcN3A/czkwXMGDwRW0
         UbZsfYcyx4jQJs2y9THT56W3U9/xYLaK+0JYkV6IXBzpI+oXH5O8SypJJBZSX1xAcR/1
         b+nsUL+sS424KgcG8HGGYR1v6/wagNTUWRnPUrpTJZhj1kxER7auQZ4h1U8RnczZb7GF
         nDHXH5+NLOWI5DfMIJkj1hADrPkfv7VznuV0kr8j7QuieeAWPM3Ikk/97JmrUr0CsxHU
         QEyA==
X-Gm-Message-State: AC+VfDzSIS6R8GnJbxTdmTXLL2ZS5Usz3IkBm/vik7B64eVIfxIx7P9H
        vP07t5+XjTqfwv+KM4Ang+lmOMBUi+l9T0dZIsotjA==
X-Google-Smtp-Source: ACHHUZ5RAiRg91t7wTL/55Q4OLYdE1CD+iJYTQ+aCxGZa8yGUNxYO/iVzslJUs9rdpIVIlVlHjD4aFszFq0yWuq08bI=
X-Received: by 2002:a4a:91cf:0:b0:54f:7324:d277 with SMTP id
 e15-20020a4a91cf000000b0054f7324d277mr2888091ooh.4.1683728257964; Wed, 10 May
 2023 07:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230510074223.991297-1-loic.poulain@linaro.org> <ZFub1U5f1qR5hOwX@infradead.org>
In-Reply-To: <ZFub1U5f1qR5hOwX@infradead.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 10 May 2023 16:17:01 +0200
Message-ID: <CAMZdPi99xo5FfSbUydvP4RNqWvDGcOCccckhdXs6S7paOa5W+w@mail.gmail.com>
Subject: Re: [PATCH] block: Deny writable memory mapping if block is read-only
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 10 May 2023 at 15:27, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, May 10, 2023 at 09:42:23AM +0200, Loic Poulain wrote:
> > User should not be able to write block device if it is read-only at
> > block level (e.g force_ro attribute). This is ensured in the regular
> > fops write operation (blkdev_write_iter) but not when writing via
> > user mapping (mmap), allowing user to actually write a read-only
> > block device via a PROT_WRITE mapping.
> >
> > Example: This can lead to integrity issue of eMMC boot partition
> > (e.g mmcblk0boot0) which is read-only by default.
> >
> > To fix this issue, simply deny shared writable mapping if the block
> > is readonly.
> >
> > Note: Block remains writable if switch to read-only is performed
> > after the initial mapping, but this is expected behavior according
> > to commit a32e236eb93e ("Partially revert "block: fail op_is_write()
> > requests to read-only partitions"")'.
>
> We should not be able to every mmap something (shared-)writable if the
> file descriptor.
>
> And ... we don't failed writable opens for block devices ?!?

No, because the file itself is writable, but not the underlying block.
I agree, it would make more sense to simply deny the block open fops
instead... but it could be considered as uapi breakage as we may have
some existing applications opening the device RW, and simply
ignore/discard the sys write errors for ro devices... but if it's
acceptable let's do it. For sure, we could argue that making the mmap
failing is also a change in uapi behavior, but except reconsidering
a32e236eb93e which may be obsolete today, I don't see a better
solution to prevent unwanted writing.



>
> Something like this is what we would need, but I really need to look
> into the history of this whole thing a bit more:
>
>
> diff --git a/block/bdev.c b/block/bdev.c
> index 1795c7d4b99efa..6dd6045672b8bf 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -724,6 +724,11 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
>                 return ERR_PTR(-ENXIO);
>         disk = bdev->bd_disk;
>
> +       if ((mode & FMODE_WRITE) && bdev_read_only(bdev)) {
> +               ret = -EACCES;
> +               goto put_blkdev;
> +       }
> +
>         if (mode & FMODE_EXCL) {
>                 ret = bd_prepare_to_claim(bdev, holder);
>                 if (ret)
> @@ -798,7 +803,6 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
>  struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
>                                         void *holder)
>  {
> -       struct block_device *bdev;
>         dev_t dev;
>         int error;
>
> @@ -806,13 +810,7 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
>         if (error)
>                 return ERR_PTR(error);
>
> -       bdev = blkdev_get_by_dev(dev, mode, holder);
> -       if (!IS_ERR(bdev) && (mode & FMODE_WRITE) && bdev_read_only(bdev)) {
> -               blkdev_put(bdev, mode);
> -               return ERR_PTR(-EACCES);
> -       }
> -
> -       return bdev;
> +       return blkdev_get_by_dev(dev, mode, holder);
>  }
>  EXPORT_SYMBOL(blkdev_get_by_path);
>
