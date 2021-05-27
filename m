Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E739C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC132613C9
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 20:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhE0UB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 16:01:57 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:34566 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhE0UBz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 16:01:55 -0400
Received: by mail-pg1-f174.google.com with SMTP id l70so784639pga.1
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 13:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B7RxuUhYvQN8rfWjQpeq5F1bfTbqCbdjaOBi3pA1oHQ=;
        b=ZISrZ6PFwEz1oC52KJ/hADUUc8fJdEWgZD6YQ1l9siWbwdNMZRb0QyjdklGfo3bI/n
         Y+zFW5vlsNojNmttpChJz3sm78gKLSNHt71LDNXmWEx/WZPg8dSVy+LaxT076MN1IZMP
         W8YQaiebes2RQi5R96NaTRVCEZAAVcf6ToXoebCtH5UFwSjvpUnnLjeAKkAeo1p5evNa
         IqJC69ytNXy1jc5Z6T0iYnYH0K3+SMBmxMJuK4o4w9yu5wlhON+ysCvg2Jm42hk6tXfd
         RkZ5nS+Y47RrhyjcRzaI9LZwG4pHkzHlUBWy4gOBhc6oNnBHUrfETGjNvzY3K2de2kuZ
         NY3g==
X-Gm-Message-State: AOAM530ALRxDPw9sMngLjxkU5L53qBCqPU9Gdvj1ztun1W5VitQwwTKn
        u0vVeWgbrb4JxXXYkuJJDWzpvE6LSUQ=
X-Google-Smtp-Source: ABdhPJxkjC9oi23dYc9/NUDymBOUvRiQ5yVmcOBEGzoz/rfb5ZC2qaw6UpPqagSlsXBbE2EGmctTyg==
X-Received: by 2002:a63:36c1:: with SMTP id d184mr5247530pga.47.1622145621757;
        Thu, 27 May 2021 13:00:21 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id z19sm2425911pjn.0.2021.05.27.13.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 13:00:21 -0700 (PDT)
Subject: Re: [PATCH 7/9] block/mq-deadline: Reserve 25% of tags for
 synchronous requests
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-8-bvanassche@acm.org>
 <DM6PR04MB7081C21724FE9742E1A16C13E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <141c7185-4f9e-2b5f-a255-9d30d03ba46a@acm.org>
Date:   Thu, 27 May 2021 13:00:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081C21724FE9742E1A16C13E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 8:33 PM, Damien Le Moal wrote:
> On 2021/05/27 10:02, Bart Van Assche wrote:
>> For interactive workloads it is important that synchronous requests are
>> not delayed. Hence reserve 25% of tags for synchronous requests. This patch
> 
> s/tags/scheduler tags
> 
> to be clear that we are not talking about the device tags. Same in the patch
> title may be.

OK.

>> +static void dd_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
> 
> Similarly as you did in patch 1, may be add a comment about this operation and
> when it is called ?

Will do.

>> +static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
>> +{
>> +	struct request_queue *q = hctx->queue;
>> +	struct deadline_data *dd = q->elevator->elevator_data;
>> +	struct blk_mq_tags *tags = hctx->sched_tags;
>> +
>> +	dd->async_depth = 3 * q->nr_requests / 4;
> 
> I think that nr_requests is always at least 2, but it may be good to have a
> sanity check here that we do not end up with async_depth == 0, no ?

OK, I will add a check.

Thanks,

Bart.
