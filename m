Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B2C433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 21:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D1824078
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgLKTaS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 14:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393569AbgLKTaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 14:30:02 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77005C0613D3
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 11:29:22 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so7796974pga.7
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 11:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mTNRkZN78nWE7RuNU9seNWtfXw5g6UF+iM4vGdKAeyU=;
        b=LIRRdEISSeD3UoBtyEvDd0t9+94kSskvNSMtiNkV95WfnNoeIkeFUQgjlItOHfDupc
         Drd25/whuG1vqsZe1mkXeY1NbB7r0IcKFPnuawrwUgnOk/W/zEqHpmeWz7oj2qZTAjDH
         RDWDUvl8cGjudLCX5vWoMmdSATJ3oekipLO+WzGWSQVL15k+z4q1d8C6q50Q+zWU+40M
         ZZfMQ5NV7RdU53pHEKPOqTpP8O//K7XmkPHR4riSNKLRNKpuauYZ2/T7z3c33iM+PXWj
         RJP3Pig7zWjDhGCfgY0R4oswEIYmGl8g8CtZL2WNoV4IA8pjKjla9Rp4CqxhUDz6kRLN
         FhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTNRkZN78nWE7RuNU9seNWtfXw5g6UF+iM4vGdKAeyU=;
        b=Ro/41pPs7H+45axrIJuFZ9oEok6l26cT9S5CPYTjn/bVWK7FealYM4/WHuiv3UisX3
         U81kGbeh1RKJgA7di64nIZaPncIcEIPRRrF1XUoDJ4piZCl0OB++tFr4Haqu2rcFFTTJ
         eQBP2v+JX/ZcZXYd/c7UUI7mXLfg5r9aGsOlxQGiMeFE8nN38ESBhGUIek3DqT+lUZRV
         mS0xzvzwMYGCrsuEk9/Hue8EouyIIrlJj0MULsI8/DHjc4KGbcEf0z6/aHJBlmVYb7Yk
         mb2qdJ/8vCD6jbdAYbkoUiasn0RijtFVkyOeNQFO83yX+3NiOCAhUutOctxWa/bhkECb
         Y9Kw==
X-Gm-Message-State: AOAM531c+0bizX9Vsub1ekYm4vyGBFfZ5qY2AXGBGrm4ogZYGbCb3eMJ
        0mVwV0eEeLQmHcl2+t5LHf6urg==
X-Google-Smtp-Source: ABdhPJwmp1wEwBY9KTgTJhFQ6IRL5rVvkUkKnNZznmf+8yiXr4ujsxrYARHg14X3ZryDQnr9ZtMLfw==
X-Received: by 2002:a63:525c:: with SMTP id s28mr13527317pgl.134.1607714961862;
        Fri, 11 Dec 2020 11:29:21 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gk4sm7832691pjb.57.2020.12.11.11.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 11:29:21 -0800 (PST)
Subject: Re: [PATCH v2] block: drop dead assignments in loop_init()
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, kernel-janitors@vger.kernel.org
References: <20201211184604.27646-1-lukas.bulwahn@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <511d884a-ed95-5e9f-0fea-b859355a6c7f@kernel.dk>
Date:   Fri, 11 Dec 2020 12:29:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211184604.27646-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/20 11:46 AM, Lukas Bulwahn wrote:
> Commit 8410d38c2552 ("loop: use __register_blkdev to allocate devices on
> demand") simplified loop_init(); so computing the range of the block region
> is not required anymore and can be dropped.
> 
> Drop dead assignments in loop_init().
> 
> As compilers will detect these unneeded assignments and optimize this,
> the resulting object code is identical before and after this change.
> 
> No functional change. No change in object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> v1 -> v2:
>   - replaced if block with ternary operator after Julia's style comment
> 
> Christoph, please ack.
> 
> Jens, please pick this minor non-urgent clean-up patch on your
> block -next tree on top of Christoph's commit above.
> 
>  drivers/block/loop.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d2ce1ddc192d..10c7c154c114 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2304,7 +2304,6 @@ MODULE_ALIAS("devname:loop-control");
>  static int __init loop_init(void)
>  {
>  	int i, nr;
> -	unsigned long range;
>  	struct loop_device *lo;
>  	int err;
>  
> @@ -2341,13 +2340,7 @@ static int __init loop_init(void)
>  	 * /dev/loop-control interface, or be instantiated by accessing
>  	 * a 'dead' device node.
>  	 */
> -	if (max_loop) {
> -		nr = max_loop;
> -		range = max_loop << part_shift;
> -	} else {
> -		nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
> -		range = 1UL << MINORBITS;
> -	}
> +	nr = max_loop ? max_loop : CONFIG_BLK_DEV_LOOP_MIN_COUNT;

I greatly prefer an if/else to ternary, it's a lot easier to read imho.

-- 
Jens Axboe

