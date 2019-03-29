Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C188C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EDE206B7
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sL1ub9Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfC2R7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:59:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46444 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfC2R7Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 13:59:16 -0400
Received: by mail-io1-f67.google.com with SMTP id b9so2427663iot.13
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ANCDDLf1QcqTPYCQmvl6+jFWJE/RCQSs3Xhq3HdgaZI=;
        b=sL1ub9ZgNvWeSDtRivY0CbTw/acTIOgqM1/vdITA+0YJPsO2kxaJhNCHSIi+6JkhSQ
         u4QP2kcJSOHnvwC0Aq2qj6bpne0YXL23od691AZ/HuUk7Mao5gB84O/3aqaT5WvokfJg
         FWjESe030p1BqJgeW/GhaIgn+3CQ4GPRq6SdtcQIF9F2pFK2TwcekNgw3tNmXlzMpbU8
         JOH/ckuXFc3sGxWn1YefpCqYpcmzqoxsRVFDT7I7cBwbeBfUAkU2lShU0WUvPtEkqL5m
         06s+djS3L6HkldN8koPrZ/QHfZFo+1xb3c8AJPyAs+ahMEXuiszdAKPwV6v35kPK8QtB
         3jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANCDDLf1QcqTPYCQmvl6+jFWJE/RCQSs3Xhq3HdgaZI=;
        b=fKyUMA/mpoTc1mlvPpI66I1KxO1CQmkE8bMlyZD+OCB0BEt3oD8k1vkecIarOLX0Nd
         McuFgTlcZC8jSMenn/lb/qTJ2KHREETJJ110nzVmW2gzok+MYgdtXk6cC+aafnEPdF/L
         ZT8RDFrPm5wklGYwLOtliyk9oV38TM+Ron0whx8MpL9Z7GKxibagmGVcsabDfsWqtDpi
         QOgpoi2EUhWHDXm9o3d3cVbSLVA/MTfy+w/8HJm6eC6DmwUZ/en+qWupKiadlmrNHndN
         OmeIUJdLmP0erfXhZ63mrthchdeUwe98RRXY927aD8NNxTmHd9mZrPYGlTt0HPtAzhEE
         STiA==
X-Gm-Message-State: APjAAAWEOvSlhPG5kQyDIq9X6ptLeyxrKPX2vgcw3TjouZDmWw/IwvG5
        +UDU3UNbwdCVPzIGh1finQ5gTg==
X-Google-Smtp-Source: APXvYqxPei6ByH3IWEEqfZC1nryXeZAQzjIJzT5Kpztow4n2x43so1KHvDZ3kBwv8ZDr8+DaAJquJg==
X-Received: by 2002:a6b:4e10:: with SMTP id c16mr16192730iob.18.1553881873712;
        Fri, 29 Mar 2019 10:51:13 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y16sm1074018ion.64.2019.03.29.10.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:51:12 -0700 (PDT)
Subject: Re: [PATCH 1/3] Don't jump to compute_result state from check_result
 state
To:     Song Liu <songliubraving@fb.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, neilb@suse.com, xni@redhat.com,
        ncroxon@redhat.com, stable@vger.kernel.org,
        David Jeffy <djeffery@redhat.com>
References: <20190329174617.3670341-1-songliubraving@fb.com>
 <20190329174617.3670341-2-songliubraving@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97dc86ee-b9d6-152e-ba5a-b485ac6a3fde@kernel.dk>
Date:   Fri, 29 Mar 2019 11:51:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329174617.3670341-2-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 11:46 AM, Song Liu wrote:
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index c033bfcb209e..4204a972ecf2 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -4223,26 +4223,15 @@ static void handle_parity_checks6(struct r5conf *conf, struct stripe_head *sh,
>  	case check_state_check_result:
>  		sh->check_state = check_state_idle;
>  
> +		if (s->failed > 1)            
> +		    break;

Not sure what happened here, but there's a lot of whitespace after that
if statement, and the break is using 4 spaces instead of a tab. I fixed
both of these up, but please review the style of patches going forward.

-- 
Jens Axboe

