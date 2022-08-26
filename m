Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E481ECAAA3
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 21:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiHZVPJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Aug 2022 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiHZVPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Aug 2022 17:15:08 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09EB26C3
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 14:15:05 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id v23so2603903plo.9
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 14:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8yljTrp0ZmVDvm5z7PoXYCFKrdB4dGD4Cu78mtLW4TI=;
        b=p9wzR2U1/92ZBLwLnF8uAxw8h3U55uef6g/d2/ecSlneg1skohAq5EDjHsR4QDxqb3
         IzjggrvbpH+lSr/XnAVxAzXEBvJuGVW+yBVhgbnGbsVBcwkicRSGCYJD5LFm5ocKiK3z
         wPf6y3k1PBYqcHTOs+7W2EwZT5BZLuVP5Hmio5HDMNCpUceg//2ykiGtwhI/vO9C/B3k
         Pu1FgO5E+d8hyTgeSvLWHeWTXUUbOAC1yAJP93z0EQ+OrQy0IuLaLLGXAHFQFgXT9wgn
         zC8tw4amkoogBIrxZDVkBIlc2R1435aPunl8yeljPQBc5SryDborYzAhYyWl7+ZUAxqY
         3bog==
X-Gm-Message-State: ACgBeo3YpzYmQkW8EMle5bxSbiL6AKs4z+9Eb5KccWXnS4k3Tk6y6Kru
        U2ytxsrmoUFamYurPdKf3VLatrWeuIc=
X-Google-Smtp-Source: AA6agR4TzFYQjYbyGwq6vJSAl2KVl5qw6383Kro6B+vbj6zGSLYNu3f2KNtzAZ3zDfsZguG7rS33lw==
X-Received: by 2002:a17:902:e744:b0:173:569:279c with SMTP id p4-20020a170902e74400b001730569279cmr5268258plf.156.1661548505057;
        Fri, 26 Aug 2022 14:15:05 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a12:b4b9:f1b3:ec63? ([2620:15c:211:201:a12:b4b9:f1b3:ec63])
        by smtp.gmail.com with ESMTPSA id u14-20020a63f64e000000b0041c30f78fa6sm1855503pgj.69.2022.08.26.14.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 14:15:04 -0700 (PDT)
Message-ID: <33f221f4-7e34-be2c-5409-0abc9517874f@acm.org>
Date:   Fri, 26 Aug 2022 14:15:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] block: I/O error occurs during SATA disk stress test
Content-Language: en-US
To:     Gu Mi <gumi@linux.alibaba.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org
References: <1661411393-98514-1-git-send-email-gumi@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1661411393-98514-1-git-send-email-gumi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/22 00:09, Gu Mi wrote:
> The problem occurs in two async processes, One is when a new IO
> calls the blk_mq_start_request() interface to start sending,The other
> is that the block layer timer process calls the blk_mq_req_expired
> interface to check whether there is an IO timeout.
> 
> When an instruction out of sequence occurs between blk_add_timer
> and WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in the interface
> blk_mq_start_request,at this time, the block timer is checking the
> new IO timeout, Since the req status has been set to MQ_RQ_IN_FLIGHT
> and req->deadline is 0 at this time, the new IO will be misjudged as
> a timeout.
> 
> Our repair plan is for the deadline to be 0, and we do not think
> that a timeout occurs. At the same time, because the jiffies of the
> 32-bit system will be reversed shortly after the system is turned on,
> we will add 1 jiffies to the deadline at this time.

Hi Gu,

With which kernel version has this race been observed? Since commit 
2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in 
blk_mq_tagset_busy_iter") the request reference count is increased 
before the timeout handler (blk_mq_check_expired()) is called. Do you 
agree that since then it is no longer possible that 
blk_mq_start_request() is called while blk_mq_check_expired() is in 
progress?

Thanks,

Bart.
