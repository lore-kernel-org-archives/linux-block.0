Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43ACC31E40
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8109B2086D
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 22:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bhd2VyLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfHFWZz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:25:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37481 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfHFWZz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 18:25:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so86345654qto.4
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pH32zVB3+F/ChCdyTdMtG2lcokUsbDzNKurXgdNw+eM=;
        b=Bhd2VyLMdxTR0bfXCtkRvd/jZJ3GdIXDjv7Lpc7m8AFZoIU4VXg1rM3+cV8QSDHHAE
         jI7EEOQc7t6BSuBu77eQ4KrQRp0uvWLZcliRsoraFn9OyWAiRwUOap2E/hyp/Un+/XQH
         5IHq5uDq79aLlRW6yvBzdaHLhAiKoagFPR8r/GFpl2GMz4eRR1RX023k9y63+D5chIbu
         dVVjwOYijQgfNhgIATTG8YgsgB+oJsHbQSmvmfc7HI7Vy3v7EVkcC6I08Ixv7W338IEn
         Sqgjj2VZaAkk0laEWkYSMlwx/qhPKukdcDMTOLmch/dhXZcS9ICe9eLQLQbKO36ATU2M
         oKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pH32zVB3+F/ChCdyTdMtG2lcokUsbDzNKurXgdNw+eM=;
        b=o6BWpZBkGJzfWYSR6MrjEHLLTwKzxNz5Itv+g05+nQK9sUnA6ltUyMzEvka1qPZdYV
         XqpFrWFkuSS5tC6VAVw2MeqsZx+LKeBIMPGqN5w3dBVuF9WHCu5PHmntZoV0nmbZCSGv
         ihbsUWCPhjVCCyh7fkF7O7PFJwsKFjPc14mSGL+/lh/YUWuJnEMkGTDhJTq6LbIpe7zj
         mO22pEs1sED/5SKPlRceavnqO1Uld+MCyUAjomng+V5eQy3EQ7fJ6jayll9IFrn7suLc
         9NulUcnW7b/+yi0pR9EYAyj3rp6zUboPWGaGYrQrNAXVSVOv+ZpHIpdjPwsC68PT6RV8
         TwEQ==
X-Gm-Message-State: APjAAAXCGMk3ukmt4GUIqeFc4h3m2b+nKC6C264qSblei8G4K/PcYwSR
        dUzo3lJD0s30qvjNadKy/utvUsiXKrorpkjhD0GkGw9gU80=
X-Google-Smtp-Source: APXvYqzJQr3foOGESFYZIVGlvM44L1FSZXdFrXmixWF5WlF/FxcaVOiqBJzHmh2GvCKvL3JpQTLTIaJxKFW95cmt03I=
X-Received: by 2002:a0c:ad07:: with SMTP id u7mr5187740qvc.2.1565130354260;
 Tue, 06 Aug 2019 15:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190806220524.251404-1-balsini@android.com>
In-Reply-To: <20190806220524.251404-1-balsini@android.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 6 Aug 2019 18:25:42 -0400
Message-ID: <CAJWu+oq9JLnbGdqy+362JZUzjv6PvuRTNwiarTQiEfizsY32hQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_DIRECT_IO in compat ioctl
To:     Alessio Balsini <balsini@android.com>
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, dvander@gmail.com,
        Yifan Hong <elsk@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Alessio,

On Tue, Aug 6, 2019 at 6:05 PM Alessio Balsini <balsini@android.com> wrote:
>
> Export LOOP_SET_DIRECT_IO as additional lo_compat_ioctl.
> The input argument for this ioctl is a single long, in the end converted
> to a 1-bit boolean. Compatibility is then preserved.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Alessio Balsini <balsini@android.com>

This looks Ok to me, but I believe the commit message should also
explain what was this patch "fixing", how was this lack of an "export"
noticed, why does it matter, etc as well.

thanks,

 - Joel


> ---
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 3036883fc9f8..a7461f482467 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1755,6 +1755,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>         case LOOP_SET_FD:
>         case LOOP_CHANGE_FD:
>         case LOOP_SET_BLOCK_SIZE:
> +       case LOOP_SET_DIRECT_IO:
>                 err = lo_ioctl(bdev, mode, cmd, arg);
>                 break;
>         default:
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
