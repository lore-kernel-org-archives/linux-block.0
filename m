Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB81AC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 21:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5F5222C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 21:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="boPndI9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbfBLVgY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:36:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33640 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbfBLVgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 16:36:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so96775pfb.0
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 13:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QQkdTMdNDt0csHfOKh6c0WB2AnQV91Ff8jsXvBTYa9s=;
        b=boPndI9JtRMGKCjcs45DBsU0LcQh1zNizOaMDQ7yyNDSxE5lNk7GOdaH8Y3uSENOOT
         48Y32Sbp0j348cN+BTpx36g8aDhuW6LfJ9zRAYV2vqpSkkpfNG++64xha8P4k2BBU4LB
         WeUQRpmsVph6StNDEg/8FjKlxfhaAT/ikParyOwv4ymMKGala3rjI0SVbr8A9E25d7pV
         T5mv5EFPfufneq/24apDbF14/mrJ6K0yGyHgEyf1dHHuFFcOEqm+E8YzKm3wMwWQfMM8
         +BhoT2xlm5qD8HqwEp9vnnVFpKnWcczKnMGsE7t7RifAxfolk1XQtNtj/Q2UIdjQXVsT
         Fdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QQkdTMdNDt0csHfOKh6c0WB2AnQV91Ff8jsXvBTYa9s=;
        b=M5PwslYBLL4lgug4zkqnsRsYS+utNScsiaQyT8sb3EUq8k0EBmI2pE+VvkVE/19pp+
         3WvaOMuuc9aOsaWAm1DM5nVm/FLrLx/qrDfegz3jQAyYH5Bx7Opj5bXworscej9pkNsz
         gzS6qWXtK7YrCI+XP1/56EwQj94N/GEWoUJ8sa9Gz1K/X691fx7OV+WRU+zVqNnacifY
         Oru5eawKgPSxv4P6OcIvmPBphxyZCZVzOpEGVpiosJYOxPjCsW8avx76uoskM3tk/iY/
         MPKeex+35qOFOXoEMPrU6/aWFl+Rd7fFDzWCRQ2LSYQtM3W/U7WjY3DpGMKXvO9F3Jw3
         mM0Q==
X-Gm-Message-State: AHQUAuaL1/TE1JTk/kFOeDnsJMQ78w3DRvx5nsVHiyX+VxuKVeSWMtf2
        QF9pvmp5Qggz9ri4/3+LztarNw==
X-Google-Smtp-Source: AHgI3IZwDREieIVMYBHf1T6bkQRwyXzusmCytGo7bprBZtAa/14/+W4jARR2RuaxkJEfZL3Bnti/Tw==
X-Received: by 2002:a62:57d7:: with SMTP id i84mr6062153pfj.125.1550007382757;
        Tue, 12 Feb 2019 13:36:22 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w65sm15061407pfb.23.2019.02.12.13.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:36:21 -0800 (PST)
Subject: Re: [PATCH] drbd_receiver: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20190212212820.GA15942@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a4429a8-56d4-b349-444c-282246537121@kernel.dk>
Date:   Tue, 12 Feb 2019 14:36:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212212820.GA15942@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/19 2:28 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/block/drbd/drbd_receiver.c: In function ‘drbd_asb_recover_0p’:
> drivers/block/drbd/drbd_receiver.c:3093:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (self == 1 && peer == 0) {
>       ^
> drivers/block/drbd/drbd_receiver.c:3098:2: note: here
>   case ASB_DISCARD_OLDER_PRI:
>   ^~~~
> drivers/block/drbd/drbd_receiver.c:3120:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
>       ^
> drivers/block/drbd/drbd_receiver.c:3123:2: note: here
>   case ASB_DISCARD_LEAST_CHG:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that in some cases, the code comment is modified in
> accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/block/drbd/drbd_receiver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index c7ad88d91a09..78bb763a367d 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3094,7 +3094,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
>  			rv =  1;
>  			break;
>  		}
> -		/* Else fall through to one of the other strategies... */
> +		/* Else fall through - to one of the other strategies... */
>  	case ASB_DISCARD_OLDER_PRI:
>  		if (self == 0 && peer == 1) {
>  			rv = 1;
> @@ -3119,7 +3119,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
>  		}
>  		if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
>  			break;
> -		/* else: fall through */
> +		/* Else fall through */

This is getting really silly, as these two hunks both aptly demonstrate. Can
we please inject some sanity into this fall through witch hunt?

The last hunk is updating ANOTHER patch that also attempted to silence this
stuff.

-- 
Jens Axboe

