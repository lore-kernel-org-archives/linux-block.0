Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B124CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC6D2054F
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghr92F0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504105AbfJXSxc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:53:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34533 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408131AbfJXSxc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 14:53:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so22112927wrr.1
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 11:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jckTcw1dtIAjEWeZblbeQZBTHIV9qrkK2X3NKUVxYd0=;
        b=ghr92F0B12/ChYf8yZJEcloJ+ZxYgxENOdsqwqKRkJQ/7qrPVgeVF2i4fLSpDfiiku
         G/4ETD8jok2AxVPkOeWEmBq0I0wBWnOe9ZBiI2eHh2xmRWLpoDNZBOcUjmSuHQ6iUw+a
         pUCHgHyxyUZpSABfTSKSMKsD6SIXDxk0M1oxG4PFAT/GkLYogyUqq80XXu/DCAembCkx
         NhlWtDNPx7/V9EUpD9mlCB+foklgH/tdeYlsgXMF4YZnEY/1MeaW6r0QyJ77pJTpESWg
         atoO77p8ZxiDpx6seZJdOhCxLUbD0LL2+nRBKedGz1kDsqI5lf5Juj/1pJoiL7CCrNnV
         8KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jckTcw1dtIAjEWeZblbeQZBTHIV9qrkK2X3NKUVxYd0=;
        b=dy+eqruvoVxks1mrhWRISzAg5A9nF0qde/EJKx6f1O9c3rtr2Xe7CcMvzsZLG8CBra
         kIwRl0O7b1jTZr+vLd8LDV/9HMkcYARG6IT9f3sOLR0whKBvRxaT9z7nEu4XKeguknSc
         LMvpXHFdSGUAqsBLr377mib7OB1n/2Gheo1QuwqfJaHkJXpYO3tqxwjnW6o9upqTZxtM
         VdmAo39uYvpFpOjHcs7SSEs5Jl8x28w9zXocNZ3itmaRxb6DPT5fN7tmkD44DWoQnsVl
         onOEJeeu+QTHkRBoAv1zHMM85Usos1QznnhSCejLGe2r/YGJtUeDouUCNnSYs1AUbBZl
         ROYQ==
X-Gm-Message-State: APjAAAXsU2CrtG1CEEkADVfB94zOf2cXlFhEVrjBIpIWRFEZhVcxw31N
        gTy1Ewy/UPoWoyLR8Djl644sx3Cp
X-Google-Smtp-Source: APXvYqyYN038dYpytb4QSXnPg7HO7v1j69/w9nexeVkEHaCPp0X3a+Gl9WQp8qkPSPr/B3lkJa/7vA==
X-Received: by 2002:a05:6000:10d:: with SMTP id o13mr5037334wrx.321.1571943210167;
        Thu, 24 Oct 2019 11:53:30 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p1sm4087983wmg.11.2019.10.24.11.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 11:53:29 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix cpu indexing error in
 blk_mq_alloc_request_hctx()
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <jsmart2021@gmail.com>
References: <20191023175700.18615-1-jsmart2021@gmail.com>
 <CACVXFVN+xXL9EJbrCPC50vOD0sG1pX1npUFSNZSNGBLyutLh0w@mail.gmail.com>
 <cd913d58-1b06-69df-3b4e-7d00f2d4074f@kernel.dk>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <810e40ce-a111-f56a-84d1-03f0e74f14e3@gmail.com>
Date:   Thu, 24 Oct 2019 11:53:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cd913d58-1b06-69df-3b4e-7d00f2d4074f@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/2019 6:02 AM, Jens Axboe wrote:
> On 10/24/19 3:28 AM, Ming Lei wrote:
>> The normal usage is that user doesn't specify the hctx for allocating
>> request from, since blk-mq
>> can figure out which hctx is used for allocation via queue mapping.
>> Just wondering why NVMe
>> FC/RDMA can't do that way?
> 
> Fully agree, it'd be much nicer if that weird interface could just
> die.
> 

Well.  All depends on what you think a hctx corresponds to, which 
relates to why the caller originally set nr_hw_queues to what it did. I 
think it is reasonable for the caller to say - this must be via this 
specific context.

To the nvme fabric transports (rdma, fc, tcp) the hctx corresponds to 
the nvme controller queue to issue a request on. In the single case 
where the hctx is specified specifically, it is the 1st command on a new 
nvme controller queue. The command *must* be issued on the queue it is 
to initialize (this is different from pci nvme).  The hctx is specified 
so the correct nvme queue is selected when the command comes down the 
request path.  Saying "don't do that" means one of the following: a) 
snooping every rq on the request path to spot initialization ios and 
move them to the right queue; or b) creating a duplicate non-blk-mq 
request path for this 1 initialization io. Both of those are ugly.

-- james

