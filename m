Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553CAC43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DCD206C0
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeLNS77 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:59:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40364 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNS77 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 13:59:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so6382976oth.7;
        Fri, 14 Dec 2018 10:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XVtfZxMKULLz0z4vLPwF+0VmgbRmglG9tctFZMoTuuo=;
        b=CJXZuNcb9w8Q6z1+QVaHn6kiovSatrnDcBYbu4yEZNxDcNH5JEVUbBqv2UmXk1a8JJ
         o4J6evSqzb+j+BD+pwq7U3rIWv2cL8rquXA4nvnDGvykFCKgTzWucvwZN8+FzFJD7awS
         H/egt34MHFkcDWA9zQkDrZU3ojfwqPVX/vQ1tOcCA6wqH9MaAup1UG96+Nxe//+hMspN
         DvVF1k/dQ3TDvcgPt/frUFCQi/Mq4XsKBFXX66QmZTK6+nbkldkKoY4TEKFOsN5Wdq/T
         hQdNyFSF2vx8IlimvfCWEM1kaRwzH+OUQBk+6eWsttRxqML4UtDBN/GYYiZBIqbb9bok
         M4iQ==
X-Gm-Message-State: AA+aEWYE80xt7oB55d9aHaABC4BQJ5/MxUvrgqnIeRxr1p4NjtngcGWD
        J5S6ZeOZ67LIHsHddTPZ0f+aRF2A
X-Google-Smtp-Source: AFSGD/VDv5BXY0gwGV1yYuI85IASjeqUvTa9LR9kDSOUQ6zCoWSUP9Oca7k/tWRW6Wy4BNAjQ8zB1w==
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr3049643otl.319.1544813997573;
        Fri, 14 Dec 2018 10:59:57 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id x4sm2408021otk.37.2018.12.14.10.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 10:59:56 -0800 (PST)
Subject: Re: [PATCH v3 6/6] nvme-rdma: implement polling queue map
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20181213213410.9841-1-sagi@grimberg.me>
 <20181213213410.9841-7-sagi@grimberg.me> <20181214154632.GC24417@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1ae85cf5-4b54-c1f2-7337-16184f7ba5d4@grimberg.me>
Date:   Fri, 14 Dec 2018 10:59:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214154632.GC24417@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +static bool nvme_rdma_poller_queue(struct nvme_rdma_queue *queue)
> 
> Can we please make this poll_queue?  or at least polled_queue?
> poller sounds odd..

Changed to nvme_rdma_poll_queue..

> 
>> -		set->nr_maps = 2 /* default + read */;
>> +		set->nr_maps = HCTX_MAX_TYPES;
>>   	}
>>   
>>   	ret = blk_mq_alloc_tag_set(set);
>> @@ -864,6 +881,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>>   			ret = PTR_ERR(ctrl->ctrl.connect_q);
>>   			goto out_free_tag_set;
>>   		}
>> +
>> +		if (ctrl->ctrl.opts->nr_poll_queues)
>> +			blk_queue_flag_set(QUEUE_FLAG_POLL,
>> +				ctrl->ctrl.connect_q);
> 
> The block core is supposed to detect we can poll based on nr_maps > 2,
> and then set QUEUE_FLAG_POLL automatically.  Although I got the details
> wrong for PCI as well, but I just sent a fix..

I'll lose that, but I didn't understand what you got wrong for pci?
(didn't understand the fix either)

>> +static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
>> +{
>> +	struct nvme_rdma_queue *queue = hctx->driver_data;
>> +	struct ib_cq *cq = queue->ib_cq;
>> +
>> +	return ib_process_cq_direct(cq, -1);
> 
> I think we can skip the cq local variable here.

Lost..

> Otherwise this looks really nice and simple, thanks for looking into it!
> 
> Do you have any performance number, especially with Jens' ringbuffer
> code?

Well, I can get from my local vm on my laptop on top of soft-roce 7K
iops :) (compared tp 5.5K without polling, but not something to
conclude from)

I don't have any numbers to show for right now...

As I said in the cover letter, we want a way to tell ib_poll_cq_direct
to not count send completions (where we end our sqe), right now we are
probably screwing up poll_success stat...
