Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5ABC433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 09:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A9E61166
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 09:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhI0JxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhI0JxJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 05:53:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C2C061604
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 02:51:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so3293934pjv.5
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRePW3/TNCc7XAOvX2Kj8B2CrMxOQEcmgec1IIbW5Bc=;
        b=Kv0CFzwqmrmNCeq5ie36LnoFoefO3upoJO65nED9HFSLpOR8RWZrEybbVYO7On51L+
         yDr5vWV5JZQBK6y3B+w9GeG8IYVc4uzKBgVSguCCkzT3hUli/9zvA9HXvMzYD9YSwuB+
         Ed9zJmWD4L6tMMshbGjdANvnABU4nNzy3YaG9twfYmOKTHpbOq5XVOQFouj30mAUlZTi
         H3oFHfOM+UR1UEd4iPmH7cyAmNzYhkNgma7rk9envMghYIk6IYIK/UFa+wcf+L51zh/9
         gKntTZE8Te8MSY2DqGPODRBkP7dg8699MLXvo+eU1rfvJ38sNCJ5Bs9rSHwMJHQjaO73
         BLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRePW3/TNCc7XAOvX2Kj8B2CrMxOQEcmgec1IIbW5Bc=;
        b=rjGd0NxO/OahSWAgXJeLKVBnQWZbtDdtbsDO2omAu6dSJec5ThuNeOQB76vKXUmD3V
         P5IkAWyynFwRrbGDKsoF40eevUxNsFpWJkZQRf1jrVd82YP65Dmu8Bnyn28woIUMELRi
         GUnY6KMfzPojIOI424K9TX49INuFMNBy9RzruY/wu9PpoSX6zRG1kuG31ky0jaH1FYTy
         Dx8dgwX+ijmVhFQUsgbkmGltm1THxgAeHZSdMIa+SvgUgOCZ2bhdB1b0JzuKj1FHk3P0
         xqSwY/rprzEXkGLfjAPGZxap3p6dMpNEZ7pyq5Fap/pDZ5ed6A8JDADX5mU1YO5221Km
         An/A==
X-Gm-Message-State: AOAM533m7cU2VkvlY3kfGLzSa7A6c99FXmMQxXP3yGJqNnNKbLy1sHA1
        ETsDpKPu3E/EXpU/iGgXyiX4E8tkB5sVWJMM+uJFRBUldsY=
X-Google-Smtp-Source: ABdhPJy8qcfslrU6xWthqnTohHRpxrn9aUuU1mGA/gd6Rw6vxMIxAEKfecnkKiSEsHRjsb3BAljBhVwwKX2poMkSz6U=
X-Received: by 2002:a17:90a:f293:: with SMTP id fs19mr6467832pjb.137.1632736287919;
 Mon, 27 Sep 2021 02:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210927094327.644665-1-arnd@kernel.org>
In-Reply-To: <20210927094327.644665-1-arnd@kernel.org>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 27 Sep 2021 11:51:17 +0200
Message-ID: <CAB0TPYGWXAs5t_bG8BMs_9xvOmfsJiy1ejM0WoJC3Ts3yC6E1Q@mail.gmail.com>
Subject: Re: [PATCH] loop: avoid out-of-range warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks!

On Mon, Sep 27, 2021 at 11:43 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns that the sanity check for page size always succeeds
> when building with 64KB pages:
>
> drivers/block/loop.c:282:27: error: result of comparison of constant 65536 with expression of type 'unsigned short' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
>                            ~~~~~ ^ ~~~~~~~~~
>
> There is nothing wrong here, so just shut up the check by changing
> the type of the bsize argument.
>
> Fixes: 3448914e8cc5 ("loop: Add LOOP_CONFIGURE ioctl")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Martijkn Coenen <maco@android.com>

> ---
>  drivers/block/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 7bf4686af774..51315a93b399 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -277,7 +277,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>   * @bsize: size to validate
>   */
>  static int
> -loop_validate_block_size(unsigned short bsize)
> +loop_validate_block_size(unsigned int bsize)
>  {
>         if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
>                 return -EINVAL;
> --
> 2.29.2
>
