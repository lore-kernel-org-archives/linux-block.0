Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C251C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 02:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1229120851
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 02:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PjPL++tI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1229120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeK1Nhk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:37:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44297 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeK1Nhk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 08:37:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so9389086pfh.11
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 18:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+1RO7oRqZMo2SkUAfVRZqf0y+/uSm7/o66knF6yM1Sg=;
        b=PjPL++tITXdVqv1bJDIaHKRd3UG9Dmm5XN/bapN0urgx/IB5JeS681s91AX+ogxKDA
         oQchAda1etIiJhxfNM1XqPNjW8nQ/bJdtG28sHg9D+f1d1/Ou4Bsje5DUSdeNtF4LfMH
         Qrxlfx+Y8/cD/FFYOBF7pSkjev8GxXJsoOvOzB1CCJdsCiRwe7bNI887VrP2UC/w4oNn
         cHSpGbUoc2VHx9GQQzRF6YjjS4mpP2rvlxhb2n4MIMVdj+bLZvznoj05O4VOml1hJUPw
         M+PhfeaU6neaK1hdANdxlS2D2SuIH5ijdrvxkPCluZhZtsNJEdzPM6Qo/kMLTQA7Vz0p
         z+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+1RO7oRqZMo2SkUAfVRZqf0y+/uSm7/o66knF6yM1Sg=;
        b=JLZ1ZcrsOyQwISh9smPC5SU/KbTh/dBsvGNHm/eHJ40NPJnf90H53W6xEk1l4rxgb5
         F4PEeDNsOlFuuq0PKEuwPCsFmzr1hx9yRxr7J6Ovfx1scQsjcyjmZrcXP+RBEmY0ycY5
         OdLAhIAQHcQmESvPk4n6W0RXVW4HhuuhYdF7Dl2dyw8VvUgUH3jRY+hmCvE78PC8S+IQ
         Gy8kZ+UP20I4cgOEQJZ9KVcTcWyIAwNol2jMYj0E78RoDLYDCYLRLCrhd+eZTt95AIoc
         QTzePaOzlZlwsRNQvsIrdfisaX2VQJcpNxxGVcpi7cZ7UF5oaPEu9qJXJzjZyThEgJ/J
         IYmw==
X-Gm-Message-State: AA+aEWaCoJGX6X2HgXUGLBp8yeA5wjCGC8+a8Gie1QWilwLYe/6SjfX1
        BrknndP4cGNzFK2W8MlRX4hrFVeHvFk=
X-Google-Smtp-Source: AFSGD/XYfmdG6FUh0KHBkKFCdgR0VAMsWzUM24gVLtEg3qIVjMOZYUZnLJad0roBMmy17ikHmjBvNg==
X-Received: by 2002:a63:1c61:: with SMTP id c33mr30764748pgm.354.1543372663579;
        Tue, 27 Nov 2018 18:37:43 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 196sm16205837pfc.77.2018.11.27.18.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 18:37:42 -0800 (PST)
Subject: Re: [PATCH 7/8] blk-mq: use bd->last == true for list inserts
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-8-axboe@kernel.dk> <20181128014922.GE11128@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c148e021-6c93-38c8-662e-0c123bf26e87@kernel.dk>
Date:   Tue, 27 Nov 2018 19:37:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128014922.GE11128@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/18 6:49 PM, Ming Lei wrote:
> On Mon, Nov 26, 2018 at 09:35:55AM -0700, Jens Axboe wrote:
>> If we are issuing a list of requests, we know if we're at the last one.
>> If we fail issuing, ensure that we call ->commits_rqs() to flush any
>> potential previous requests.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-core.c |  2 +-
>>  block/blk-mq.c   | 32 ++++++++++++++++++++++++--------
>>  block/blk-mq.h   |  2 +-
>>  3 files changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index c9758d185357..808a65d23f1a 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1334,7 +1334,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
>>  	 * bypass a potential scheduler on the bottom device for
>>  	 * insert.
>>  	 */
>> -	return blk_mq_request_issue_directly(rq);
>> +	return blk_mq_request_issue_directly(rq, true);
>>  }
>>  EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
>>  
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 6a249bf6ed00..0a12cec0b426 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1260,6 +1260,14 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>>  	if (!list_empty(list)) {
>>  		bool needs_restart;
>>  
>> +		/*
>> +		 * If we didn't flush the entire list, we could have told
>> +		 * the driver there was more coming, but that turned out to
>> +		 * be a lie.
>> +		 */
>> +		if (q->mq_ops->commit_rqs)
>> +			q->mq_ops->commit_rqs(hctx);
>> +
> 
> Looks you miss to do it for blk_mq_do_dispatch_sched() and
> blk_mq_do_dispatch_ctx(), in which only one request is added to
> the rq_list.

blk_mq_do_dispatch() is handled through blk_mq_dispatch_rq_list(),
it doesn't need to do this on its own, it's only working on
single requests.

Ditto for blk_mq_do_dispatch()

> Maybe we can call the .commit_rqs(hctx) just at the end of
> blk_mq_sched_dispatch_requests() for cover all non-direct-issue
> cases.

I think you miss the point of ->commits_rqs() - it's only meant to
catch the case where we set bd->last == false, and never got to
the end. Like not getting a driver tag, for instance. It's not
meant to always be a kick things into gear, it's more efficient
to use bd->last for the general case, as most drivers require some
sort of locking for the submission.

-- 
Jens Axboe

