Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CFFC10F0B
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 10:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6E42173C
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qs6e07by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfBZKzS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:55:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41241 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfBZKzR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 05:55:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id n2so13394840wrw.8;
        Tue, 26 Feb 2019 02:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySN8srwOFToAgVDBdnBx2qaw3D1HebYFeaH6dGO69Oc=;
        b=qs6e07byqT+pfaRudjoCMUSwyMqUSgPnAe9VZLvaSM45I3+PgcOCm1TxkklpqDSjXH
         AY9V8ZCipbvGpY/bc22Cz0petjFIFCds859oyidNwit2H3wkMfRjLxrT7tZbLCIGRcp8
         2t2HFaxvgkpvF0K7JNK1co93HcGKgVslHN7t2GPSjpJJ8yF0ZNIliPcLXJfhFnjd6djX
         SVGhGSJF7SNsUVGcR46epchqP0rQSDElTIBXh17ubVYwRJfmQe4puWAGKzK+hMxU3nXZ
         YyP952q6iAOwTPAgN+WQXJhM1Q+QySjcuinrbHgMYoke1iFLWx0R1IkYe0fmQvh/G2cN
         h87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySN8srwOFToAgVDBdnBx2qaw3D1HebYFeaH6dGO69Oc=;
        b=hOb1fyKPF8V9cfO+vvwygjoF8+BZS5BiNqwAx/sSs4maoh3pyQQdKosFd1MnWsKaJH
         Sm71q/2MkiMtA9o6knEncihmmdN8bxy4TEVYNGyyZhqSLEsO0gFdrhga14DNYIakSfB2
         2JyQnn9yNgePhYR7/TPnn4BUc06JhA13Yr/yT9mPCuIvCZdGJCC7DJGqmvjwg1Fs3dC2
         esO2IA6GuoYZ48teIY8dYwKaW31nJgOUdLl5SlxrXYR8rsph2SQVXFpWTjp5z3D7uqNg
         DruoHC3p7wIAs2bO94i8h6CGtZZX4LKHyJFQdXElc/A246oymgwKF9qPQySALu0+897h
         vYgg==
X-Gm-Message-State: AHQUAua016IECVI2n44m/26QEcUMTEEbCdjeRctuNIGYlUVuhJ895BMo
        fGg3BxA3KFsXP2z9NQb4ulBMQmL2LnEhowHRrf52NnDZ
X-Google-Smtp-Source: AHgI3IbAhXUzc0SeBIn8HwuMjaleFdP9LgYkHTI0Sj7XgYt5EuqrB1NIFvl5KbXhnpM0AowRE84rJN7MZhz1dJS3IZQ=
X-Received: by 2002:a5d:668b:: with SMTP id l11mr15674420wru.116.1551178515839;
 Tue, 26 Feb 2019 02:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20190226105150.10717-1-cmaiolino@redhat.com>
In-Reply-To: <20190226105150.10717-1-cmaiolino@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 26 Feb 2019 18:55:03 +0800
Message-ID: <CACVXFVO6i9PyzCgaacMy=yU9pxosvpZW3gtVdigwwRcS7ei0=w@mail.gmail.com>
Subject: Re: [PATCH V2] fs: fix guard_bio_eod to check for real EOD errors
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 6:52 PM Carlos Maiolino <cmaiolino@redhat.com> wrote:
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
>
> Kudos to Eric Sandeen for coming up with the reproducer above
>
> Changelog:
>
>         V2: Compare truncated_bytes agains bvec->bv_len instead of
>             PAGE_SIZE
>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  fs/buffer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 784de3dbcf28..b43347896ce0 100644
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
> +       if (truncated_bytes > bvec->bv_len)
> +               return;
> +
>         /* Truncate the bio.. */
>         bio->bi_iter.bi_size -= truncated_bytes;
>         bvec->bv_len -= truncated_bytes;

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming Lei
