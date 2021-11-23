Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E65C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhKWQta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhKWQt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:49:29 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939FC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:46:21 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id l8so22373795ilv.3
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bEuiWMvQu0aQxfo6ME+TABX/KdsNprUBIfX4Rdn1F4E=;
        b=VM/BXG2H+9erBPm8+gw5CiupjRSg70PJlT5EIb3XgJtKfjIni8GojEvEWmzQzGct0o
         XbJBtrRzMuhXKBgC1ceYR2j9JHu2OadS4pRJ7wN1XXXL/bOW+GYLRxRMm9m5PCuo7RjS
         uHUUsqojoFn5tRAXHCAGiTivurVmc/tEjBHhuhfVo2J+IQv2olDopciNzgrc0cmI5SQC
         EFIAb7o8KeLNu1qIYDHO7eg0XKuC8wJlc10a4MGOxkKV8abMrl3/Ty3A8raeFyAFqCQe
         AYCm3GPpcKi4/4ZN9MZ7w+BcpDjG9BP+UkYA4cYUxFDHy/e5O2TyI14JLExsVVxMrJXw
         fhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bEuiWMvQu0aQxfo6ME+TABX/KdsNprUBIfX4Rdn1F4E=;
        b=pAnAfni8TGgUQwUpMhKWlk7qsl9OHRkLQf9HGAUtmiBEz1eG5AzU2sLfGegOEplFdf
         WZXJr4zEcBdti2m/o/VdimBRzDaRtGiIXRLjZFAEFnBFADKejc1KWsycPGEC2eBKexdj
         zg5t/7XJUtrY+dRMTByyAsKezGL9RAyfeAe4yqGLadRG6/53GuwskeF7B/Te6aLFtOp5
         s8xIrB/D7xhqQuMMBDyHtPqgtojTtpu3nVMoapThrPMYy8TlBGTDO2BOxeim1S2D9z1H
         NmpAUb+xztPm5BxN9MrDoqf7pjQNqLTokb4gFxEiUwg45BWY04ktSkDCrYZTgVYTVg2N
         Nefw==
X-Gm-Message-State: AOAM531tiQAjMbztp6D+fNB+3inP+/uza58ULWA1IT3U5+1PhnOMpvFx
        sgFOYlVXvWDVtGPYmd8j16dJ8Y1+IoeY+xSR
X-Google-Smtp-Source: ABdhPJxAXkD6uO9c8SBmHmSAup2maPWqGmCdzBbaUaU+Ujb7jaBtarCpWKs5QEGCxjfq4cADz5ajGQ==
X-Received: by 2002:a92:d246:: with SMTP id v6mr7659793ilg.148.1637685980986;
        Tue, 23 Nov 2021 08:46:20 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a12sm5332276iow.6.2021.11.23.08.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:46:20 -0800 (PST)
Subject: Re: [PATCH 1/3] block: move io_context creation into where it's
 needed
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-2-axboe@kernel.dk> <YZ0ZUJGilOzhF2k5@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <56538fd1-ca28-386b-36ba-493399af1803@kernel.dk>
Date:   Tue, 23 Nov 2021 09:46:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ0ZUJGilOzhF2k5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 9:39 AM, Christoph Hellwig wrote:
>> +	/* create task io_context, if we don't have one already */
>> +	if (unlikely(!current->io_context))
>> +		create_task_io_context(current, GFP_ATOMIC, rq->q->node);
> 
> Wouldn't it be nicer to have an interface that hides the check
> and the somewhat pointless current argument?  And name that with a
> blk_ prefix?

Yeah, we can do that.

>> +
>> +	blk_mq_sched_assign_ioc(rq);
> 
> But thinking about this a little more:
> 
> struct io_context has two uses, one is the unsigned short ioprio,
> and the other is the whole bfq mess.
> 
> Can't we just split the ioprio out (we'll find a hole somewhere
> in task_struct) and then just allocate the io_context in
> blk_mq_sched_assign_ioc, which would also avoid the pointless
> ioc_lookup_icq on a newly allocated io_context.  I'd also really
> expect blk_mq_sched_assign_ioc to be implemented in blk-ioc.c.

It would be nice to decouple ioprio from the io_context, and just
leave the io_context for BFQ essentially.

I'll give it a shot.

> While we're at it: bfq_bic_lookup is a really weird helper which
> gets passed an unused bfqd argument.

Unsurprising.

-- 
Jens Axboe

