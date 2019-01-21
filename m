Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1094C37123
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 21:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5D621019
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 21:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAUVKS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:10:18 -0500
Received: from gfuc.org ([88.99.83.187]:47844 "EHLO gfuc.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfAUVKS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 16:10:18 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2019 16:10:17 EST
Received: from [192.168.178.72] (dslb-092-075-222-085.092.075.pools.vodafone-ip.de [92.75.222.85])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by gfuc.org (Postfix) with ESMTPSA id 04B781E00A5
        for <linux-block@vger.kernel.org>; Mon, 21 Jan 2019 21:01:59 +0000 (UTC)
From:   Florian Stecker <m19@florianstecker.de>
Subject: fsync hangs after scsi rejected a request
To:     linux-block@vger.kernel.org
Message-ID: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
Date:   Mon, 21 Jan 2019 22:01:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi everyone,

on my laptop, I am experiencing occasional hangs of applications during 
fsync(), which are sometimes up to 30 seconds long. I'm using a BTRFS 
which spans two partitions on the same SSD (one of them used to contain 
a Windows, but I removed it and added the partition to the BTRFS volume 
instead). Also, the problem only occurs when an I/O scheduler 
(mq-deadline) is in use. I'm running kernel version 4.20.3.

 From what I understand so far, what happens is that a sync request 
fails in the SCSI/ATA layer, in ata_std_qc_defer(), because it is a 
"Non-NCQ command" and can not be queued together with other commands. 
This propagates up into blk_mq_dispatch_rq_list(), where the call

ret = q->mq_ops->queue_rq(hctx, &bd);

returns BLK_STS_DEV_RESOURCE. Later in blk_mq_dispatch_rq_list(), there 
is the piece of code

needs_restart = blk_mq_sched_needs_restart(hctx);
if (!needs_restart ||
	(no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
	blk_mq_run_hw_queue(hctx, true);
else if (needs_restart && (ret == BLK_STS_RESOURCE))
	blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);

which restarts the queue after a delay if BLK_STS_RESOURCE was returned, 
but somehow not for BLK_STS_DEV_RESOURCE. Instead, nothing happens and 
fsync() seems to hang until some other process wants to do I/O.

So if I do

- else if (needs_restart && (ret == BLK_STS_RESOURCE))
+ else if (needs_restart && (ret == BLK_STS_RESOURCE || ret == 
BLK_STS_DEV_RESOURCE))

it fixes my problem. But was there a reason why BLK_STS_DEV_RESOURCE was 
treated differently that BLK_STS_RESOURCE here?

In any case, it seems wrong to me that ret is used here at all, as it 
just contains the return value of the last request in the list, and 
whether we rerun the queue should probably not only depend on the last 
request?

Can anyone of the experts tell me whether this makes sense or I got 
something completely wrong?

Best,
Florian
