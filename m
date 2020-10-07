Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F5AC41604
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F35B20870
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 13:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KUfuSgGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgJGN62 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgJGN62 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 09:58:28 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE41C061755
        for <linux-block@vger.kernel.org>; Wed,  7 Oct 2020 06:58:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k25so2430737ioh.7
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2020 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ApVkILdO+uIfe4VZPZoDW2BRjH6gkT6FPQIzKvydhlY=;
        b=KUfuSgGA97wNxCMsWA2p96mjDsarVX3PtbcK57KDFfZAlAE2dphX6vEcyEqGauQDZ4
         NXfw77if1MVRiOGZiRW3GRiaZeyjc4eK3v6LopAxRg9CVfHcR2jNj/IqNBw+ecePUMb8
         0LVI1vI5//mnsNUI5zC4rtt+IyvXnqCkuKzzxFZCpAd1R9XeI9PpX9ZmAWhx/uRbp3ww
         SlIgfAhTGCLvasOM/3aa7iTXwjrfaV7V2xrFa29k7sPR98s4RgydqlRTvBLed95tVCJ0
         RhQbz28jr1C6xnt9IgIzTpN/tPVmIuoULUsi/oRH3E99KzudcY/+wUaQ6RGDN7VIJjKp
         CZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ApVkILdO+uIfe4VZPZoDW2BRjH6gkT6FPQIzKvydhlY=;
        b=Bmf/TTQbfmE8uyCGagQeAnBIuANyApsBT2kfZNRGA0+FlPUcmYt/A1uUq7JU6R5s0o
         dOxcQIiiG3JYLo06i/eLEN5D0w8/ymN0esoP18diW9lGaKC0A8dCsJNqU/KpgmfHkIE/
         GYym4VynePhajSCmSSTXPWaYlrYGPvnP3Ki4TWCoGiJ5cCfsQVzCuwRdZ6xGFboXOocd
         dz2BR5i/a3elPA8+cbUgWm1pKiBUmaodiDT1Oc9exPdbqGQ58Dx4U1aYCGM//cFmS9FY
         prXUCin/QETB3YE6V8uhxs4aPKZvuiqL+7Ut6O9PZBS7QP6+8tnx0z9HSwtTOSaoVENg
         U/Wg==
X-Gm-Message-State: AOAM533yJO5BUjaQmigE8HK3qqybMk/7DSkBVY5/h3Npt7XwozSUMLZI
        fsAkQA1YbUQHrXdTzjti3kH8Bw==
X-Google-Smtp-Source: ABdhPJzbpPWBeUqVnrm67JPU+pAmQJKybgTUh9ur4v9YiFuGzHY/CISgR7ibuFnyPJmZDDXElXi4Fg==
X-Received: by 2002:a02:9543:: with SMTP id y61mr3171306jah.64.1602079106187;
        Wed, 07 Oct 2020 06:58:26 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w12sm911856ioa.8.2020.10.07.06.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 06:58:25 -0700 (PDT)
Subject: Re: [PATCH] block: soft limit zone-append sectors as well
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a04275e3-48e9-a2e7-c28e-8fce0827a06e@kernel.dk>
Date:   Wed, 7 Oct 2020 07:58:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/20 3:20 AM, Johannes Thumshirn wrote:
> Martin rightfully noted that for normal filesystem IO we have soft limits
> in place, to prevent them from getting too big and not lead to
> unpredictable latencies. For zone append we only have the hardware limit
> in place.
> 
> Cap the max sectors we submit via zone-append to the maximal number of
> sectors if the second limit is lower.
> 
> Link: https://lore.kernel.org/linux-btrfs/yq1k0w8g3rw.fsf@ca-mkp.ca.oracle.com
> Reported-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  include/linux/blkdev.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index cf80e61b4c5e..967cd76f16d4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1406,7 +1406,10 @@ static inline unsigned int queue_max_segment_size(const struct request_queue *q)
>  
>  static inline unsigned int queue_max_zone_append_sectors(const struct request_queue *q)
>  {
> -	return q->limits.max_zone_append_sectors;
> +
> +	struct queue_limits *l = q->limits;
> +
> +	return min(l->max_zone_append_sectors, l->max_sectors);

As the test robot points out, this won't even compile... How much
testing did you do with this?

-- 
Jens Axboe

