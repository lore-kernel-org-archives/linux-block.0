Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B3DC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 02:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA33A2054F
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 02:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rw4iV60C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfEBCFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 22:05:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43178 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBCFJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 22:05:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so764410qtq.10;
        Wed, 01 May 2019 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ux5b965d508SI5nyhUWR5JM2SSNy1WKrzRHcMYwUexE=;
        b=rw4iV60Ck+fjUmTU9oUz6dTdQVc1A9uiwQfjMjVPHoJvrzak6iCg1wy+0Nb2j8n1bm
         NCbDQjTm9MNyWhrE0jF7jofmB66HaCdgPToSNyCowQ/4qgb6D5w+vBmZp//mnzGYrTu8
         gYleIgBAT/oy8OXP1gF5t+C9YjjRmAmz6JnYi4gbqwfm+MQPzcSzx66Xq7v+urARtKoH
         zmqxAU9szkxg+gGFVRMBEnB2Lv0nOfCZfRQwaTqu5y1jIxFXkHnxrrvxNU4LdA+X6t3+
         JXMKbbWYUh4k5CQY95oxS33vwWhGvuzku9cRyFxWPpdx+mG21Dc3ACzYWtcOAO61rSwm
         PnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ux5b965d508SI5nyhUWR5JM2SSNy1WKrzRHcMYwUexE=;
        b=JZoh5DyB2KeLJFVaoxIta1/n0VnjpIxnfTY6VuYI9/orO2O7ah+N1DLeBO6hX60XHw
         9PFs3R/hSXr4fUdCxNrmXpJIepPRCtPDajiy5W5DgHSYEsht5M5mztsTDWHtFN3nUBPe
         JeWUIeQfTBHBZQhmjiLAx7SGJaG+TKU6JZBMd/rXUlgLWUA78FSx03jC2iKESPigXOUn
         X1eTxDpzv6P8IG5qd7b6mixt4EvPbFu9HyEH5pwrhE2FiwButY3Uo/4Buu9iag4uKncb
         Ar3oX0HjWy41m/rGc7XC2yyZDp1aqK9x5Ox3NLRnJQTYHcfz48Drj4FgTLSRT/8AN1A9
         5VGA==
X-Gm-Message-State: APjAAAV0pK+6ekhQR0o/H0Zomu59z4yxf7MKYvmYzBfvOvpyQz9LcaES
        Ye4dm6Gnw3jD0zL/6N9S0Goa1HzU8sg=
X-Google-Smtp-Source: APXvYqz29ToL8dwP614jRR3suZl7AeEDj7LX0sNAHG8r1I8hQfjaMjfJHPb8TRvaaJms5WBT/YHWsw==
X-Received: by 2002:ac8:3334:: with SMTP id t49mr1058795qta.295.1556762707557;
        Wed, 01 May 2019 19:05:07 -0700 (PDT)
Received: from laptop (189.26.185.89.dynamic.adsl.gvt.net.br. [189.26.185.89])
        by smtp.gmail.com with ESMTPSA id n21sm14714915qkk.30.2019.05.01.19.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 19:05:06 -0700 (PDT)
Date:   Wed, 1 May 2019 23:04:57 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH v2 1/3] blk-mq.c: Add documention of function
 blk_mq_init_queue
Message-ID: <20190502020455.GA71748@laptop>
References: <20190416032801.200694-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416032801.200694-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

gentle ping v2.

On Tue, Apr 16, 2019 at 12:27:59AM -0300, Marcos Paulo de Souza wrote:
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
> 
>  No changes from v1.
> 
>  block/blk-mq.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9516304a38ee..4a8277a54c03 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2650,6 +2650,15 @@ void blk_mq_release(struct request_queue *q)
>  	blk_mq_sysfs_deinit(q);
>  }
>  
> +/**
> + * blk_mq_init_queue - Create a new request queue associating a blk_mq_tag_set
> + * @set: tag_set to be associated with the request queue
> + *
> + * Description:
> + * This function creates a new request queue, associating @set with it.
> + *
> + * Returns a new request queue on success, or ERR_PTR() on failure.
> + */
>  struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *uninit_q, *q;
> -- 
> 2.16.4
> 

-- 
Thanks,
Marcos
