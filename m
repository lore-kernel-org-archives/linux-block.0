Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A2EC3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 20:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAQUpp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 15:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjAQUhZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 15:37:25 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A845239
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 11:22:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so11753631pjg.4
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 11:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V0qcABF+rC2+wypY9Co8ogyd9bMie1DG0YXrqCGR92M=;
        b=jQ9R9GO6CcL14A488fdRl0hUZC+f54CPIRgkg9E2CCgREegJcouLOr1z7BUrh8BwMF
         WYSKkwE48/wbtZz/bimn1F6f+bRfr3uQZ5mKXzhWeKdYDwcTRGpvvL5D923glniNz32f
         MCR5oZaSIULnOnsKBCs/q6pHMheyvzt9FSTXyU4p2eBISjB68RQW3IBdkWsDM972bxLq
         DRIaYNQfteFoi6a9JND1UT5WzUggyBjjwqL9keEN1cIUcV5HbbqWafukgTWZZg0notCs
         dAohn7ZovOOl3arn/j/o9pwP6KpY4G6Et+mPf7AcWTlJDsONluMg+owroNlRQ2uUzQQn
         phSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0qcABF+rC2+wypY9Co8ogyd9bMie1DG0YXrqCGR92M=;
        b=qrQx5OpOZ2I5ZmTKhOqI9CtSq8Fm5BeT26DAyzaw58ycO36ksujLaUwuI6W0YPQc7o
         Hn0cEWAuc547rQgb700AIiq3vl1JsYcndupLCBzmheawyVRdVb0NV0rf8uZHpJNWv7Iv
         aAd9vYKNMiAkuuYH4pmF+z5hF8IOyt30zV6SRKl3vx9kmBwo/9gqcyb4gmmgiZ4TPf8H
         jKJX5znaOT213Ui6z1CpLyWG8bTuO7lIN4eIFz95E8A8+PoPffSdqtJr6yLzxjSWTKpR
         4ARzZXmVY4tE5/l7h9wIn7Csi5kP77ziJj1X9D2rgLylAbgNainYv4D/BU/ah++tJq3j
         OTYA==
X-Gm-Message-State: AFqh2kpNmzZknqNH+dXh3fxPIZvl1wDADC2fIq/ZGBEpZfHNN9ffKGYF
        Twx+MVjEphKPrxJs7AwYDIY54kK8G1Yld0S3v7iQjBfNOJ2wvg==
X-Google-Smtp-Source: AMrXdXsATbyHIe7ZlH83NjP1r0fhxSqw0ijai8PbLlQzO/fEUf9l3lua68zv5B61GkcM9Xvp5pZkzS9SForTOUpSijM=
X-Received: by 2002:a17:90b:48d0:b0:226:b5f4:d420 with SMTP id
 li16-20020a17090b48d000b00226b5f4d420mr471440pjb.102.1673983327042; Tue, 17
 Jan 2023 11:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20230114170113.3985630-1-trix@redhat.com>
In-Reply-To: <20230114170113.3985630-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Jan 2023 11:21:55 -0800
Message-ID: <CAKwvOdk=3GrWN_h41nPi_TKgw1uwB2twaV38B+Fj_paVuZ2nxw@mail.gmail.com>
Subject: Re: [PATCH] paride/pcd: return earlier when an error happens in pcd_atapi()
To:     Tom Rix <trix@redhat.com>
Cc:     tim@cyberelk.net, axboe@kernel.dk, nathan@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 14, 2023 at 9:01 AM Tom Rix <trix@redhat.com> wrote:
>
> clang static analysis reports
> drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
>   is a garbage value [core.UndefinedBinaryOperatorResult]
>   tocentry->cdte_ctrl = buffer[5] & 0xf;
>                         ~~~~~~~~~ ^
>
> When the call to pcd_atapi() fails, buffer[] is in an unknown state,
> so return early.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/block/paride/pcd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
> index a5ab40784119..4524d8880463 100644
> --- a/drivers/block/paride/pcd.c
> +++ b/drivers/block/paride/pcd.c
> @@ -827,12 +827,13 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
>                         char buffer[32];
>                         int r;

Hi Tom, Thanks for the patch!
It looks like `r` is now unused; mind removing that in v2?

Same below.

>
> -                       r = pcd_atapi(cd, cmd, 12, buffer, "read toc header");
> +                       if (pcd_atapi(cd, cmd, 12, buffer, "read toc header"))
> +                               return -EIO;
>
>                         tochdr->cdth_trk0 = buffer[2];
>                         tochdr->cdth_trk1 = buffer[3];
>
> -                       return r ? -EIO : 0;
> +                       return 0;
>                 }
>
>         case CDROMREADTOCENTRY:
> @@ -845,13 +846,13 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
>                         struct cdrom_tocentry *tocentry =
>                             (struct cdrom_tocentry *) arg;
>                         unsigned char buffer[32];
> -                       int r;

^

>
>                         cmd[1] =
>                             (tocentry->cdte_format == CDROM_MSF ? 0x02 : 0);
>                         cmd[6] = tocentry->cdte_track;
>
> -                       r = pcd_atapi(cd, cmd, 12, buffer, "read toc entry");
> +                       if (pcd_atapi(cd, cmd, 12, buffer, "read toc entry"))
> +                               return -EIO;
>
>                         tocentry->cdte_ctrl = buffer[5] & 0xf;
>                         tocentry->cdte_adr = buffer[5] >> 4;
> @@ -866,7 +867,7 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
>                                     (((((buffer[8] << 8) + buffer[9]) << 8)
>                                       + buffer[10]) << 8) + buffer[11];
>
> -                       return r ? -EIO : 0;
> +                       return 0;
>                 }
>
>         default:
> --
> 2.27.0
>
>


-- 
Thanks,
~Nick Desaulniers
