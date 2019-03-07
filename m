Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0871C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 15:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A373F20652
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="L7oPiFvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfCGP5y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:57:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33861 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCGP5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 10:57:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id a16so13909473edn.1
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 07:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/GqXQBmkdSqQ1wOgMWWR75IMCgWdLAO+p+34fsZNkW0=;
        b=L7oPiFvzIfbGYD2pUSC18v9jv5jkA+3ecOiEnebD0FF8RkhRAS8I3oA3BTQrymmW3F
         aeGv5JT50ZUgJQ2C7m2qLBXUx74E73VH3307clL9tiMDUeXqeDDJmOR34mxDS8wK67oY
         wXsRUjiPPgFalXXzXSFFwmDFdlHQenbrej9pF+H6Hig72zuI6ELOPSK8M3j5ZNnkMG9n
         vLTDpN6PWy0PdEAPCJaf+CPBxE553hnWZ4Om8s7ckg7h5KC5Rv2ppxui8R8IMCLItbBw
         4123tPMj6/ZdzQfW2UIATYen3Vh/MT72h+aCWBSldxKGjtfLJNX38KjQz0JeLFr+2l8y
         tMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/GqXQBmkdSqQ1wOgMWWR75IMCgWdLAO+p+34fsZNkW0=;
        b=VEW6z7X9z2pnMfTbz7Z42T2e4rbvbvvhLVmzmFFR/S/kw++9DNLjTgU2/DTrhhLaHC
         JR1Q+tYoCyQTF40FgxL4jgTLqbU8HedAvm9ZpC3H7p3v9IWuewywA2kxSclWIxmg/uDu
         8QnNqKOB1/d3vHBtr4XPqoCNiWpsa61nzfW05MPW464l6mNcLFdzSBWLxdiDytM1cbd0
         IRU2vMaEomCCYpytn00pg3xZxJF3LcQM1+redcg8ZvpHmJLWIpdeJYJyjnhCiEtVVQ5D
         hK4mMDkyp62j2iPl8S+qrN0e6fA6EOqW0BSQU4rNQ98m8L1sqFDR4iI8NsW7cUy+FkVr
         1s0Q==
X-Gm-Message-State: APjAAAU0c91WzlemN1EKMqOEFJCR0OsK4wA1EL1fAITsG2DjhtL9/CqQ
        OTsv+kEr1/XxxUgRgJ8v3FtRD8xZlXQ=
X-Google-Smtp-Source: APXvYqyjmE27orYbGEaM615J3UNweo0x7hvQqNs0J8AHFX4ISC/e0/9eSj/liVzQep/nRuZ5RKSdDg==
X-Received: by 2002:a50:e70a:: with SMTP id a10mr28965559edn.70.1551974272677;
        Thu, 07 Mar 2019 07:57:52 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id z49sm1448730edb.15.2019.03.07.07.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 07:57:51 -0800 (PST)
Subject: Re: [PATCH] pblk: fix max_io calculation
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20190307121853.14503-1-javier@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8b13dcf3-4486-0e14-b718-417c7fc42a7b@lightnvm.io>
Date:   Thu, 7 Mar 2019 16:57:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190307121853.14503-1-javier@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/19 1:18 PM, Javier González wrote:
> When calculating the maximun I/O size allowed into the buffer, consider
> the write size (ws_opt) used by the write thread in order to cover the
> case in which, due to flushes, the mem and subm pointers are disaligned
> by (ws_opt - 1). This case currently translates into a stall when
> an I/O of the largest possible size is submitted.
> 
> Fixes: f9f9d1ae2c66 ("lightnvm: pblk: prevent stall due to wb threshold")
> 
> Signed-off-by: Javier González <javier@javigon.com>
> ---
> 
> Matias: Can you apply this as a fix to 5.1. This is a case I missed when fixing
> the wb threshold, which is also scheduled for 5.1
> 
> Thanks,
> Javier
> 
>   drivers/lightnvm/pblk-rl.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index b014957dde0b..a5f8bc2defbc 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -233,10 +233,15 @@ void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
>   	/* To start with, all buffer is available to user I/O writers */
>   	rl->rb_budget = budget;
>   	rl->rb_user_max = budget;
> -	rl->rb_max_io = threshold ? (budget - threshold) : (budget - 1);
>   	rl->rb_gc_max = 0;
>   	rl->rb_state = PBLK_RL_HIGH;
>   
> +	/* Maximize I/O size and ansure that back threshold is respected */
> +	if (threshold)
> +		rl->rb_max_io = budget - pblk->min_write_pgs_data - threshold;
> +	else
> +		rl->rb_max_io = budget - pblk->min_write_pgs_data - 1;
> +
>   	atomic_set(&rl->rb_user_cnt, 0);
>   	atomic_set(&rl->rb_gc_cnt, 0);
>   	atomic_set(&rl->rb_space, -1);
> 

Hi Jens,

If possible, could you please pick this one up for 5.1? It fixes a 
previous patch that was introduced in 5.1 that should fix a stall, but 
didn't quite catch it.

Thank you,
-Matias
