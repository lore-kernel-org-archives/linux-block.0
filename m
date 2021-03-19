Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65A2C433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 05:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8CA64F69
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 05:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhCSFuy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 01:50:54 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60116 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233819AbhCSFuh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 01:50:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0USWV5kS_1616133030;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0USWV5kS_1616133030)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Mar 2021 13:50:30 +0800
Subject: Re: [RFC PATCH V2 00/13] block: support bio based io polling
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210318164827.1481133-1-ming.lei@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <ca04d070-55b6-a156-3a18-68e0fe38269b@linux.alibaba.com>
Date:   Fri, 19 Mar 2021 13:50:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318164827.1481133-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/19/21 12:48 AM, Ming Lei wrote:
> Hi,
> 
> Add per-task io poll context for holding HIPRI blk-mq/underlying bios
> queued from bio based driver's io submission context, and reuse one bio
> padding field for storing 'cookie' returned from submit_bio() for these
> bios. Also explicitly end these bios in poll context by adding two
> new bio flags.
> 
> In this way, we needn't to poll all underlying hw queues any more,
> which is implemented in Jeffle's patches. And we can just poll hw queues
> in which there is HIPRI IO queued.
> 
> Usually io submission and io poll share same context, so the added io
> poll context data is just like one stack variable, and the cost for
> saving bios is cheap.
> 
> Any comments are welcome.
> 
> V2:
> 	- address queue depth scalability issue reported by Jeffle via bio
> 	group list. Reuse .bi_end_io for linking bios which share same
> 	.bi_end_io, and support 32 such groups in submit queue. With this way,
> 	the scalability issue caused by kfifio is solved. Before really
> 	ending bio, .bi_end_io is recovered from the group head.

I have retested this latest version, and it seems the scaling issue has
been fixed at the first glance.

Test results with the latest version:
3-threads  dm-stripe-3 targets  (12k randread IOPS, unit K)
317 -> 409 (iodepth=128)

Compared to the test results of v1:
3-threads  dm-stripe-3 targets  (12k randread IOPS, unit K)
313 -> 349 (iodepth=128, kfifo queue depth =128)
313 -> 409 (iodepth=32, kfifo queue depth =128)
314 -> 409 (iodepth=128, kfifo queue depth =512)

> 
> 
> Jeffle Xu (4):
>   block/mq: extract one helper function polling hw queue
>   block: add queue_to_disk() to get gendisk from request_queue
>   block: add poll_capable method to support bio-based IO polling
>   dm: support IO polling for bio-based dm device
> 
> Ming Lei (9):
>   block: add helper of blk_queue_poll
>   block: add one helper to free io_context
>   block: add helper of blk_create_io_context
>   block: create io poll context for submission and poll task
>   block: add req flag of REQ_TAG
>   block: add new field into 'struct bvec_iter'
>   block: prepare for supporting bio_list via other link
>   block: use per-task poll context to implement bio based io poll
>   blk-mq: limit hw queues to be polled in each blk_poll()
> 
>  block/bio.c                   |   5 +
>  block/blk-core.c              | 248 ++++++++++++++++++++++++++++++++--
>  block/blk-ioc.c               |  12 +-
>  block/blk-mq.c                | 232 ++++++++++++++++++++++++++++++-
>  block/blk-sysfs.c             |  14 +-
>  block/blk.h                   |  55 ++++++++
>  drivers/md/dm-table.c         |  24 ++++
>  drivers/md/dm.c               |  14 ++
>  drivers/nvme/host/core.c      |   2 +-
>  include/linux/bio.h           | 132 +++++++++---------
>  include/linux/blk_types.h     |  20 ++-
>  include/linux/blkdev.h        |   4 +
>  include/linux/bvec.h          |   9 ++
>  include/linux/device-mapper.h |   1 +
>  include/linux/iocontext.h     |   2 +
>  include/trace/events/kyber.h  |   6 +-
>  16 files changed, 686 insertions(+), 94 deletions(-)
> 

-- 
Thanks,
Jeffle
