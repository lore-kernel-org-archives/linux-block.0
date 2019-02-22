Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D624AC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 23:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A177A2070D
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 23:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVMUrSFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfBVXdf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:33:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36963 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVXdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 18:33:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id w6so811173wrs.4;
        Fri, 22 Feb 2019 15:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bK3bECTzIpa7S2dMxrB9ei1vdzNWezLk7O1i7YLUg8=;
        b=tVMUrSFTK2FSgKIRHQp8yYKGgMP2SUgEwE3+3cRUarQIyhU7v0x9JM3uRYGqLMYCeM
         vxIYkN8vBmPOxwfw3ngVANUWUqIS1PwFKRXx2wJDCCHof/netOrPfA+nj7ct9B/mrYkI
         u7g07oGkgZL2vlT+EMLkFwBnO8029V5dk+L0G8/QW45gp98znj5xCS32+PJ7uQAzw4DE
         PfI78nFCx8ZfFFUTnFifo784SLJdncgnHnqBnpIpsGz4IaoAuD5PHCqFBsuFi8JVotpx
         GQZRLuh2bZLoo7cJQof/NVGo5ULlSqkNk0XLOzlYlEuU+8U+NYDtCn2meDQaZqRLmNGt
         CZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bK3bECTzIpa7S2dMxrB9ei1vdzNWezLk7O1i7YLUg8=;
        b=ZGmBlesKIjmDaI6wy5Bn5okyTcqhEWkv/a7XQ/+xGTVGIWMhx60pWChxr2WGJ1INax
         Tqit6WiTxFTKt9iPCrlY4H0psJuIfwx3lZq4s3deHV6ZbQ0kWUTIta/bJPvaXf9DUJgl
         i0Mr6QT58z7F57rh73kiYqjfhPnORH/McbJXmXaS4mV4BDgg8mQ/Nfsv4hBkcbcDweAy
         FxvvLSdwIQFW4zRPFHE8lmHH6zr9TrpaX7lOi3QdWhEuEumtblmIbDOkCmWunbN+3spa
         4hmp4qsMFNI5Y0bhvNhm4k5QAapumo9fPKUYIYu2h4ic5H0TDFHNZp1aLCde/l1iWCKi
         Htcg==
X-Gm-Message-State: AHQUAubp758AB3E0J5z1RxAWiKiPZmPwGp12Io55zsJkETi3smbIDju6
        YpTGteZuq/vuZdhjJj7w3pYGdVuWJWpVpirzCoI=
X-Google-Smtp-Source: AHgI3IZX+kQ4iyWhyJYKljtAMzm3zl3kLzP/UzEB7/ANgiz/norOwaUSjq0V6CeJSJzq1je0AhioAxZUFBByRW7HQVw=
X-Received: by 2002:adf:ee82:: with SMTP id b2mr4988369wro.185.1550878413760;
 Fri, 22 Feb 2019 15:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20190222141311.24694-1-cmaiolino@redhat.com>
In-Reply-To: <20190222141311.24694-1-cmaiolino@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 23 Feb 2019 07:33:21 +0800
Message-ID: <CACVXFVOBqTxXrMhqEAvQ8nMe9aYdrevj372_67aiZhXUFxjcgQ@mail.gmail.com>
Subject: Re: [PATCH] fs: fix guard_bio_eod to check for real EOD errors
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Carlos,

Cc block list given it is related with interface between fs and block layer.

On Fri, Feb 22, 2019 at 10:14 PM Carlos Maiolino <cmaiolino@redhat.com> wrote:
>
> guard_bio_eod() can truncate a segment in bio to allow it to do IO on
> odd last sectors of a device.
>
> It already checks if the IO starts past EOD, but it does not consider
> the possibility of an IO request starting within device boundaries can
> contain more than one segment past EOD.
>
> In such cases, truncated_bytes can be bigger than PAGE_SIZE, and will
> underflow bvec->bv_len.

It can cause memory corruption even for < PAGE_SIZE, also it can be correct
to see > PAGE_SIZE truncated_bytes:

- xfs is going to support big block size which may be 64k
- multi-page bvec patches have been in block tree, and it is planned to land
v5.1, so > PAGE_SIZE truncating may come because .bv_len can be much
bigger than PAGE_SIZE

- suppose fs block size is 4k, bio sector is 1022 and size is 4k, and
disk size is
1024, last bvec is (0, 1024), then 'truncated_bytes' will be 3k, so
the check can't
capture this case, and memory corruption still may be caused.

>
> Fix this by checking if truncated_bytes is lower than PAGE_SIZE.
>
> This situation has been found on filesystems such as isofs and vfat,
> which doesn't check the device size before mount, if the device is
> smaller than the filesystem itself, a readahead on such filesystem,
> which spans EOD, can trigger this situation, leading a call to
> zero_user() with a wrong size possibly corrupting memory.
>
> I didn't see any crash, or didn't let the system run long enough to
> check if memory corruption will be hit somewhere, but adding
> instrumentation to guard_bio_end() to check truncated_bytes size, was
> enough to see the error.
>
> The following script can trigger the error.
>
> MNT=/mnt
> IMG=./DISK.img
> DEV=/dev/loop0
>
> mkfs.vfat $IMG
> mount $IMG $MNT
> cp -R /etc $MNT &> /dev/null
> umount $MNT
>
> losetup -D
>
> losetup --find --show --sizelimit 16247280 $IMG
> mount $DEV $MNT
>
> find $MNT -type f -exec cat {} + >/dev/null

BTW, which kernel is  for this issue? Did you investigate why the bad bio
is made?

>
> Kudos to Eric Sandeen for coming up with the reproducer above
>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>
> P.S. I'm not 100% proficient in bio internals, so I'm not sure if this is the
> right fix, so comments are much appreciated.
> Thanks
>
>  fs/buffer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 784de3dbcf28..32dc5cd2f6ba 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3063,6 +3063,13 @@ void guard_bio_eod(int op, struct bio *bio)
>         /* Uhhuh. We've got a bio that straddles the device size! */
>         truncated_bytes = bio->bi_iter.bi_size - (maxsector << 9);
>
> +       /*
> +        * The bio contains more than one segment which spans EOD, just return
> +        * and let IO layer turn it into an EIO
> +        */
> +       if (truncated_bytes > PAGE_SIZE)
> +               return;
> +

The correct check should be:

+       if (truncated_bytes > bvec->bv_len)
+               return;

Also it should be helpful to warn on this bad bio, but it is fine to not do it
here cause block layer logs this bad bio too.

BTW, this is just a workaround, not one real fix on the reported problem.

Thanks,
Ming Lei
