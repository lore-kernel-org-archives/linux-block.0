Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A1C004EF
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 10:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4613120861
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 10:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="BGZjj8D8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGJKmq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:42:46 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:40776 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbfGJKmq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 06:42:46 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id B99FB2E0EBF;
        Wed, 10 Jul 2019 13:42:42 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id uC97EkyPww-ggUe3vPG;
        Wed, 10 Jul 2019 13:42:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1562755362; bh=MuHsnMCLNYQMR7LQcEktY+8kMNp1AKabcUeHAMKR+Lw=;
        h=In-Reply-To:Message-ID:Date:References:To:From:Subject:Cc;
        b=BGZjj8D8y+oFQMhHbtp28s9y8KPUGvHMIb/s6H6Ut3D7K4rDQ3yblRq9KWrkzEY8w
         NYDruSUJfsGJ6x8IyfFvwIrbt+Ymq5XA375GgGcf1DVrVrry/OlFf2RQo2zy37kyRf
         OcDTCr5S3/TY58oAHlb6vbZaxkdzoMP8DCWQCL2U=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:fce8:911:2fe8:4dfb])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id maOvm5OG9B-gfwmJY11;
        Wed, 10 Jul 2019 13:42:41 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] blk-throttle: fix zero wait time for iops throttled group
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Liu Bo <bo.liu@linux.alibaba.com>, Stable <stable@vger.kernel.org>,
        cgroups@vger.kernel.org
References: <156259979778.2486.6296077059654653057.stgit@buzz>
Message-ID: <50aa6400-6128-0344-d7c8-0d73fccff350@yandex-team.ru>
Date:   Wed, 10 Jul 2019 13:42:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <156259979778.2486.6296077059654653057.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08.07.2019 18:29, Konstantin Khlebnikov wrote:
> After commit 991f61fe7e1d ("Blk-throttle: reduce tail io latency when iops
> limit is enforced") wait time could be zero even if group is throttled and
> cannot issue requests right now. As a result throtl_select_dispatch() turns
> into busy-loop under irq-safe queue spinlock.

To be clear: this almost instantly kills entire machine - other cpus stuck at sending ipi.

> 
> Fix is simple: always round up target time to the next throttle slice.
> 
> Fixes: 991f61fe7e1d ("Blk-throttle: reduce tail io latency when iops limit is enforced")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: stable@vger.kernel.org # v4.19+
> ---
>   block/blk-throttle.c |    9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 9ea7c0ecad10..8ab6c8153223 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -881,13 +881,10 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
>   	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>   	u64 tmp;
>   
> -	jiffy_elapsed = jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
> -
> -	/* Slice has just started. Consider one slice interval */
> -	if (!jiffy_elapsed)
> -		jiffy_elapsed_rnd = tg->td->throtl_slice;
> +	jiffy_elapsed = jiffies - tg->slice_start[rw];
>   
> -	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
> +	/* Round up to the next throttle slice, wait time must be nonzero */
> +	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
>   
>   	/*
>   	 * jiffy_elapsed_rnd should not be a big value as minimum iops can be
> 
