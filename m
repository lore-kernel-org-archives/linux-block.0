Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442C3C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 09:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BADE61CBB
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 09:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhF3JqM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:46:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38174 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3JqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 05:46:12 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3065D1FE59;
        Wed, 30 Jun 2021 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625046223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syWhgjUEA3Suq9NaFjFTKKAGY+GrebcNJjzwNFC1W58=;
        b=FYP1W55Q+UbCZnlwzcG0DvU0eogwKiE7Y052FIn0XwjJDTu1BM6tfC3RJOSbQ1njj34OPc
        hGOFztYZUoryR4h9mGXfEmV5Whtk5NT8ya0OZKItWBFKFCB/3pKFFqM9XqguoDzijlLIau
        OJ3uy2uIsiOj7rMExIMNuvt300Bktx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625046223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syWhgjUEA3Suq9NaFjFTKKAGY+GrebcNJjzwNFC1W58=;
        b=aQgP1PCWUn6Vad+J9a4c2XI39JglUKNaBjMSjFVVVLBRnZA8Ij7PCz+djbTtJDh9Z1CN9d
        5v3rHjiuH1TfzNDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 939F111906;
        Wed, 30 Jun 2021 09:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625046223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syWhgjUEA3Suq9NaFjFTKKAGY+GrebcNJjzwNFC1W58=;
        b=FYP1W55Q+UbCZnlwzcG0DvU0eogwKiE7Y052FIn0XwjJDTu1BM6tfC3RJOSbQ1njj34OPc
        hGOFztYZUoryR4h9mGXfEmV5Whtk5NT8ya0OZKItWBFKFCB/3pKFFqM9XqguoDzijlLIau
        OJ3uy2uIsiOj7rMExIMNuvt300Bktx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625046223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syWhgjUEA3Suq9NaFjFTKKAGY+GrebcNJjzwNFC1W58=;
        b=aQgP1PCWUn6Vad+J9a4c2XI39JglUKNaBjMSjFVVVLBRnZA8Ij7PCz+djbTtJDh9Z1CN9d
        5v3rHjiuH1TfzNDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Kr7RIM483GCnbQAALh3uQQ
        (envelope-from <hare@suse.de>); Wed, 30 Jun 2021 09:43:42 +0000
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de> <YNwug8n7qGL5uXfo@T590>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de>
Date:   Wed, 30 Jun 2021 11:43:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YNwug8n7qGL5uXfo@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/21 10:42 AM, Ming Lei wrote:
> On Wed, Jun 30, 2021 at 10:18:37AM +0200, Hannes Reinecke wrote:
>> On 6/29/21 9:49 AM, Ming Lei wrote:
>>> Hi,
>>>
>>> blk_mq_alloc_request_hctx() is used by NVMe fc/rdma/tcp/loop to connect
>>> io queue. Also the sw ctx is chosen as the 1st online cpu in hctx->cpumask.
>>> However, all cpus in hctx->cpumask may be offline.
>>>
>>> This usage model isn't well supported by blk-mq which supposes allocator is
>>> always done on one online CPU in hctx->cpumask. This assumption is
>>> related with managed irq, which also requires blk-mq to drain inflight
>>> request in this hctx when the last cpu in hctx->cpumask is going to
>>> offline.
>>>
>>> However, NVMe fc/rdma/tcp/loop don't use managed irq, so we should allow
>>> them to ask for request allocation when the specified hctx is inactive
>>> (all cpus in hctx->cpumask are offline).
>>>
>>> Fix blk_mq_alloc_request_hctx() by adding/passing flag of
>>> BLK_MQ_F_NOT_USE_MANAGED_IRQ.
>>>
>>>
>>> Ming Lei (2):
>>>     blk-mq: not deactivate hctx if the device doesn't use managed irq
>>>     nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for fc/rdma/tcp/loop
>>>
>>>    block/blk-mq.c             | 6 +++++-
>>>    drivers/nvme/host/fc.c     | 3 ++-
>>>    drivers/nvme/host/rdma.c   | 3 ++-
>>>    drivers/nvme/host/tcp.c    | 3 ++-
>>>    drivers/nvme/target/loop.c | 3 ++-
>>>    include/linux/blk-mq.h     | 1 +
>>>    6 files changed, 14 insertions(+), 5 deletions(-)
>>>
>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>> Cc: Daniel Wagner <dwagner@suse. thede>
>>> Cc: Wen Xiong <wenxiong@us.ibm.com>
>>> Cc: John Garry <john.garry@huawei.com>
>>>
>>>
>> I have my misgivings about this patchset.
>> To my understanding, only CPUs present in the hctx cpumask are eligible to
>> submit I/O to that hctx.
> 
> It is just true for managed irq, and should be CPUs online.
> 
> However, no such constraint for non managed irq, since irq may migrate to
> other online CPUs if all CPUs in irq's current affinity become offline.
> 

But there shouldn't be any I/O pending during CPU offline (cf 
blk_mq_hctx_notify_offline()), so no interrupts should be triggered, 
either, no?

>> Consequently if all cpus in that mask are offline, where is the point of
>> even transmitting a 'connect' request?
> 
> nvmef requires to submit the connect request via one specified hctx
> which index has to be same with the io queue's index.
> 
> Almost all nvmef drivers fail to setup controller in case of
> connect io queue error.
> 

And I would prefer to fix that, namely allowing blk-mq to run on a 
sparse set of io queues.
The remaining io queues can be connected once the first cpu in the hctx 
cpumask is onlined; we already have blk_mq_hctx_notify_online(), which 
could easily be expanded to connect to relevant I/O queue...

> Also CPU can become offline & online, especially it is done in
> lots of sanity test.
> 

True, but then again all I/O on the hctx should be quiesced during cpu 
offline.

> So we should allow to allocate the connect request successful, and
> submit it to drivers given it is allowed in this way for non-managed
> irq.
> 

I'd rather not do this, as the 'connect' command runs on the 'normal' 
I/O tagset, and hence runs into the risk of being issues against 
non-existing CPUs.

>> Shouldn't we rather modify the tagset to only refer to the current online
>> CPUs _only_, thereby never submit a connect request for hctx with only
>> offline CPUs?
> 
> Then you may setup very less io queues, and performance may suffer even
> though lots of CPUs become online later.
> ;
Only if we stay with the reduced number of I/O queues. Which is not what 
I'm proposing; I'd rather prefer to connect and disconnect queues from 
the cpu hotplug handler. For starters we could even trigger a reset once 
the first cpu within a hctx is onlined.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
