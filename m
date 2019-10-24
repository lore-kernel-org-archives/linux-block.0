Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E03CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 13:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7EE2166E
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 13:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pjkLHdON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfJXNC0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:02:26 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37470 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbfJXNC0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 09:02:26 -0400
Received: by mail-il1-f195.google.com with SMTP id v2so1843748ilq.4
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S0NrLWZ7FXKxXP9Y8KMoYFjeiKt/AVgpthFCF/o+yug=;
        b=pjkLHdON3i8pbCo3atAdQ1n5TfendcH+d/AHaXHQKPCh7Opti89fEvZcdR1WNKieeh
         mBnvaHS6RdsetaZEcXrFxDo91LoWN2URTZ8dq4krjISzSjDgMMJpm2fCz6HLQkAg/0Uw
         w8K86En1QBrrdvo8xoxIc+zZ8ZlFskLMjRh6TE9YeX5fM4vMj9sdUkZkCq6jyq3ReG/J
         5v/IQO8Pbp2KGp34KayQkfBrlz0bOBvw+b86Z/iKY+fLo6f1O6O43G376ADUP8Zqfjv1
         Bl4KMBwPHYYsPX+i978Bi+tMkvLQacLR/7VFiYD0rvR96yeXxQGQpToPond6XcMNAdgi
         6Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S0NrLWZ7FXKxXP9Y8KMoYFjeiKt/AVgpthFCF/o+yug=;
        b=M//0FHgSFYrnal9CVZ8P+DClmKJh+bx9sBoyY5RSIkOBnJrP1uH/nRtoJwF9p8XATa
         veSC4sycaeAZDf8GyV18ir8DT/mwtk/im/VyjdezxsifNWpguYpylM4LPjFBzwSq4dwI
         3xWupDD47cF3NqZjUOrLdoRDh1ajOoLhIm5aNhsSnbMk5tGSL0a6LSp4z0Wn0/lnJWcf
         gLQCL3IRwxgWrX1ej7i++0FnX5ACNijVLToyLyxjDRnMcRYV3ZB5nH4yS2890+M66eos
         C6PWcNTwnZoE8rLu/GSoHuXHXNA1bGRRFBGzfaPalLZmgIgPpV8a+bdnKs1mCAieU10v
         Ft9w==
X-Gm-Message-State: APjAAAUlHFqvU1u8ff0gMkgYM1+VgHhYCCA5F1BYX/WtVwPSjt8cvbWa
        QlSKZt0OBZ+T17xQe7P6grGYnQ==
X-Google-Smtp-Source: APXvYqwwIXpCa0MmS3T7qrsOlnxzziUkdefXwbG7VxG18PItE9Xe2EmCZjGvKiOb5fBaA4R72octyw==
X-Received: by 2002:a92:1907:: with SMTP id 7mr31136861ilz.72.1571922145629;
        Thu, 24 Oct 2019 06:02:25 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t4sm77364ils.21.2019.10.24.06.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:02:24 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix cpu indexing error in
 blk_mq_alloc_request_hctx()
To:     Ming Lei <tom.leiming@gmail.com>,
        James Smart <jsmart2021@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191023175700.18615-1-jsmart2021@gmail.com>
 <CACVXFVN+xXL9EJbrCPC50vOD0sG1pX1npUFSNZSNGBLyutLh0w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd913d58-1b06-69df-3b4e-7d00f2d4074f@kernel.dk>
Date:   Thu, 24 Oct 2019 07:02:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVN+xXL9EJbrCPC50vOD0sG1pX1npUFSNZSNGBLyutLh0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 3:28 AM, Ming Lei wrote:
> On Thu, Oct 24, 2019 at 4:53 PM James Smart <jsmart2021@gmail.com> wrote:
>>
>> During the following test scenario:
>> - Offline a cpu
>> - load lpfc driver, which auto-discovers NVMe devices. For a new
>>    nvme device, the lpfc/nvme_fc transport can request up to
>>    num_online_cpus() worth of nr_hw_queues. The target in
>>    this case allowed at least that many of nvme queues.
>> The system encountered the following crash:
>>
>>   BUG: unable to handle kernel paging request at 00003659d33953a8
>>   ...
>>   Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
>>   RIP: 0010:blk_mq_get_request+0x21d/0x3c0
>>   ...
>>   Blk_mq_alloc_request_hctx+0xef/0x140
>>   Nvme_alloc_request+0x32/0x80 [nvme_core]
>>   __nvme_submit_sync_cmd+0x4a/0x1c0 [nvme_core]
>>   Nvmf_connect_io_queue+0x130/0x1a0 [nvme_fabrics]
>>   Nvme_fc_connect_io_queues+0x285/0x2b0 [nvme_fc]
>>   Nvme_fc_create_association+0x0x8ea/0x9c0 [nvme_fc]
>>   Nvme_fc_connect_ctrl_work+0x19/0x50 [nvme_fc]
>>   ...
>>
>> There was a commit a while ago to simplify queue mapping which
>> replaced the use of cpumask_first() by cpumask_first_and().
>> The issue is if cpumask_first_and() does not find any _intersecting_ cpus,
>> it return's nr_cpu_id. nr_cpu_id isn't valid for the per_cpu_ptr index
>> which is done in __blk_mq_get_ctx().
>>
>> Considered reverting back to cpumask_first(), but instead followed
>> logic in blk_mq_first_mapped_cpu() to check for nr_cpu_id before
>> calling cpumask_first().
>>
>> Fixes: 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
>> Signed-off-by: Shagun Agrawal <shagun.agrawal@broadcom.com>
>> Signed-off-by: James Smart <jsmart2021@gmail.com>
>> CC: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-mq.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8538dc415499..0b06b4ea57f1 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -461,6 +461,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>>                  return ERR_PTR(-EXDEV);
>>          }
>>          cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
>> +       if (cpu >= nr_cpu_ids)
>> +               cpu = cpumask_first(alloc_data.hctx->cpumask);
> 
> The first cpu may be offline too, then kernel warning or timeout may
> be triggered later
> when this allocated request is dispatched.
> 
> To be honest, blk_mq_alloc_request_hctx() is really a weird interface,
> given the hctx may become
> dead just when calling into blk_mq_alloc_request_hctx().
> 
> Given only NVMe FC/RDMA uses this interface, could you provide some
> background about
> this kind of usage?
> 
> The normal usage is that user doesn't specify the hctx for allocating
> request from, since blk-mq
> can figure out which hctx is used for allocation via queue mapping.
> Just wondering why NVMe
> FC/RDMA can't do that way?

Fully agree, it'd be much nicer if that weird interface could just
die.

-- 
Jens Axboe

