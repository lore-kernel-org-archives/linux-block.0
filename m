Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D2C43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 14:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358097AbiFVONL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358061AbiFVONA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 10:13:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3F3FC1
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 07:12:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eo8so24154438edb.0
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fG5D+uGBwwK40MTabwUY6wsv1epKDtgAgJdk4dbADg8=;
        b=AVxqSYm2tQicUHoKP/CQ7yVFeY1/yS3p6olpcI8LxibnzNqI0LwIFgedn3fJON+uLF
         4y/ScsW+Av9Owd0pW239PDzkOZAGy5EYoLVnJqLECv3CE8N6mltknxWBBRtWeUk+JTP8
         PL5kUFzheHzaWkGqv3gEUmN7pMTipy2e3YNdtuxY+QSnHEPKQUEudnxqNhbY4BfxDpd+
         7uCRZUaFSxaWpKM3+SBtXo7OvWUXYhf/Rcy4NEJIr1y+f3hm6rn6cHazffo3Xu4r7Bwi
         lJP+t9S171aqRH1t76uT2Wzxg1EurjYBhMYT0oz7dYAL7SJw7NFP+DIT/jDkFq84YOzR
         3ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fG5D+uGBwwK40MTabwUY6wsv1epKDtgAgJdk4dbADg8=;
        b=BAmk1tAPKDPPlb/FMipBZ+d8ynq2wJGjGIVb1a1Y/7OeXQlm5GwSuP+NEEiYYPfFnW
         bpMw8qfVncLozD8Ka6yAa/yJNOFvt49Bf5PwQcs3dfHNtV4+783lxtPr/HNJ23Uz9fdO
         7LH+YctWKvCS+D5drsh0kTBDsBIZs4msZ/qkllS84vemKkpf0TkdWkNkizp1od5ffwr9
         TjWpH5WdzkRYa9wYVjpCsk940tyqL2zKgEVWvYdkAfp7iBSvaYYw56LN2nWmb7Nk/j1I
         Gd0KWVIuh6fga2rSb6HdPpRuR1m2nRf/la5q0sHDprz7BOorLCOlMVm9o+2BPWnJz5x9
         x2Rw==
X-Gm-Message-State: AJIora9V4ek5DP4M2CuC9zRjrh9XAFJ5REiO/XDlMZO6l5e20Q/SwXSx
        /1l4vlOdbjv2489p95O5WNxsCA==
X-Google-Smtp-Source: AGRyM1uUESYrbLTpgv2oZVuiUBydC1onWAi2Dy56rj0mDfvLHWZ0vYGmEitukPRk/QfY457MKqHLxQ==
X-Received: by 2002:a05:6402:3587:b0:435:b9a1:d5c5 with SMTP id y7-20020a056402358700b00435b9a1d5c5mr2403935edc.219.1655907176277;
        Wed, 22 Jun 2022 07:12:56 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ch11-20020a0564021bcb00b0043586bee560sm6526365edb.68.2022.06.22.07.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:12:55 -0700 (PDT)
Message-ID: <b628a808-bb07-c94f-9d70-6bd4eb4be690@linbit.com>
Date:   Wed, 22 Jun 2022 16:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drbd: Fix typo in comment
Content-Language: en-US
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk
References: <20220616143227.4004-1-wangxiang@cdjrlc.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220616143227.4004-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 16.06.22 um 16:32 schrieb Xiang wangx:
> Delete the redundant word 'and'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/block/drbd/drbd_bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
> index 9e060e49b3f8..8afdde400e37 100644
> --- a/drivers/block/drbd/drbd_bitmap.c
> +++ b/drivers/block/drbd/drbd_bitmap.c
> @@ -86,7 +86,7 @@ struct drbd_bitmap {
>  
>  	/* exclusively to be used by __al_write_transaction(),
>  	 * drbd_bm_mark_for_writeout() and
> -	 * and drbd_bm_write_hinted() -> bm_rw() called from there.
> +	 * drbd_bm_write_hinted() -> bm_rw() called from there.
>  	 */
>  	unsigned int n_bitmap_hints;
>  	unsigned int al_bitmap_hints[AL_UPDATES_PER_TRANSACTION];

Thanks!

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
