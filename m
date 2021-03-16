Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B09DC433E6
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4EF65113
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 17:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhCPRA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 13:00:26 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:34115 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbhCPRAH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 13:00:07 -0400
Received: by mail-pg1-f175.google.com with SMTP id l2so23017011pgb.1;
        Tue, 16 Mar 2021 10:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nzyLAzp9XA/aLRyNpG0/Wcg9B/Qt9o8s5jH7pFizpQ4=;
        b=Rvc6We7+gel/t8EHnvng0RFCNL6j9Pc4mE5ONJY21Ep1Zmuh75JQc3VmwEaQ/ndMjz
         jCyiiEW6NeaQGcT3x+y+EHw9GWDSth2NGgZ0tbuf57srU1VK2tlmMLX2HecoAQY6A/cO
         Yay4IGuZ7noVfyMa+OXiQw2PGHUeQBZ1esvGzPtU0vAS0/vUmSrIHHjVqNycDsLkQoAU
         xE5lrhbHYSt56UGyFGCbdfbIRT+o6HYI8WK8U5mcLa603wPb6DMubqVaa3p/1PIM1VIJ
         FNuHzkCYYEVihC3etv9pxqO9KDjbZ/sN+0D+L/aY19Ps/l77QaYCPOyzf7IKIbwaesE1
         gkMg==
X-Gm-Message-State: AOAM530AOihWkYKAnPYnFG99jNET868Mvn1RkaxTniUpZx9vAlONzkyX
        YMPgIejIbYLvku3mGWasJO0=
X-Google-Smtp-Source: ABdhPJzwgAcQRWzQ7BNkdV+5+2zLQZOZCBZ4yDYZU85bxU+58iHR/myQ0FSqa4J/UqY4FEu2DTTm+Q==
X-Received: by 2002:a05:6a00:138e:b029:204:422e:a87e with SMTP id t14-20020a056a00138eb0290204422ea87emr547433pfg.24.1615914006283;
        Tue, 16 Mar 2021 10:00:06 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 2sm16901197pfi.116.2021.03.16.10.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:00:05 -0700 (PDT)
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pragalla@codeaurora.org" <pragalla@codeaurora.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        yuyufen <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
 <YElrSFGyim3rjDN+@T590> <8c6c6783-6152-2332-2f50-14c409e40320@huawei.com>
 <2b0c66ba-03b3-844c-1684-f8e80d11cdbb@acm.org>
 <4ffaba53-100a-43a5-8746-b753d4153be5@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fff92b15-d483-ad6a-bb01-ef61117b7cbd@acm.org>
Date:   Tue, 16 Mar 2021 10:00:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <4ffaba53-100a-43a5-8746-b753d4153be5@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/21 9:15 AM, John Garry wrote:
> I'll have a look at this ASAP -  a bit busy.
> 
> But a quick scan and I notice this:
> 
>  > @@ -226,6 +226,7 @@ static inline void __blk_mq_put_driver_tag(struct 
> blk_mq_hw_ctx *hctx,
>  >                          struct request *rq)
>  >   {
>  >       blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
>  > +    rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
> 
> Wasn't a requirement to not touch the fastpath at all, including even if 
> only NULLifying a pointer?
> 
> IIRC, Kashyap some time ago had a patch like above (but without RCU 
> usage), but the request from Jens was to not touch the fastpath.
> 
> Maybe I'm mistaken - I will try to dig up the thread.

Hi John,

I agree that Jens asked at the end of 2018 not to touch the fast path to 
fix this use-after-free (maybe that request has been repeated more 
recently). If Jens or anyone else feels strongly about not clearing 
hctx->tags->rqs[rq->tag] from the fast path then I will make that 
change. My motivation for clearing these pointers from the fast path is 
as follows:
- This results in code that is easier to read and easier to maintain.
- Every modern CPU pipelines store instructions so the performance 
impact of adding an additional store should be small.
- Since the block layer has a tendency to reuse tags that have been 
freed recently, it is likely that hctx->tags->rqs[rq->tag] will be used 
for a next request and hence that it will have to be loaded into the CPU 
cache anyway.

Bart.
