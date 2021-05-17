Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59CC433ED
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 06:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B11261007
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 06:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhEQGR7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 02:17:59 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:4175 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234766AbhEQGR5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 02:17:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UZ4SGva_1621232199;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UZ4SGva_1621232199)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 May 2021 14:16:39 +0800
Subject: Re: [PATCH V6 00/12] block: support bio based io polling
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Hannes Reinecke <hare@suse.de>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <630a63ef-f9e0-6ad6-d6be-ec7a46e5ec45@linux.alibaba.com>
Date:   Mon, 17 May 2021 14:16:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210422122038.2192933-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

What's the latest progress of this bio-based polling feature?

I've noticed that hch has also sent a patch set on this [1]. But as far
as I know, hch's patch set only refactors the interface of polling in
the block layer. It indeed helps bio-based polling for some kind of
bio-based driver, but for DM/MD where one bio could be mapped to several
split bios, more work is obviously needed, just like Lei Ming's
io_context related code in this patch set.

hch may have better idea, after all [1] is just a preparation patch set.


[1]
https://lore.kernel.org/linux-block/20210427161619.1294399-2-hch@lst.de/T/


-- 
Thanks,
Jeffle


On 4/22/21 8:20 PM, Ming Lei wrote:
> Hi Jens,
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
> V6:
> 	- move poll code into block/blk-poll.c, as suggested by Christoph
> 	- define bvec_iter as __packed, and add one new field to bio, as
> 	  suggested by Christoph
> 	- re-organize patch order, as suggested by Christoph
> 	- add one flag for checking if the disk is capable of bio polling
> 	  and remove .poll_capable(), as suggested by Christoph
> 	- fix type of .bi_poll
> 
> V5:
> 	- fix one use-after-free issue in case that polling is from another
> 	context: adds one new cookie of BLK_QC_T_NOT_READY for preventing
> 	this issue in patch 8/12
> 	- add reviewed-by & tested-by tag
> 
> V4:
> 	- cover one more test_bit(QUEUE_FLAG_POLL, ...) suggested by
> 	  Jeffle(01/12)
> 	- drop patch of 'block: add helper of blk_create_io_context'
> 	- add new helper of blk_create_io_poll_context() (03/12)
> 	- drain submission queues in exit_io_context(), suggested by
> 	  Jeffle(08/13)
> 	- considering shared io context case for blk_bio_poll_io_drain()
> 	(08/13)
> 	- fix one issue in blk_bio_poll_pack_groups() as suggested by
> 	Jeffle(08/13)
> 	- add reviewed-by tag
> V3:
> 	- fix cookie returned for bio based driver, as suggested by Jeffle Xu
> 	- draining pending bios when submission context is exiting
> 	- patch style and comment fix, as suggested by Mike
> 	- allow poll context data to be NULL by always polling on submission queue
> 	- remove RFC, and reviewed-by
> 
> V2:
> 	- address queue depth scalability issue reported by Jeffle via bio
> 	group list. Reuse .bi_end_io for linking bios which share same
> 	.bi_end_io, and support 32 such groups in submit queue. With this way,
> 	the scalability issue caused by kfifio is solved. Before really
> 	ending bio, .bi_end_io is recovered from the group head.
> 
> 
> 
> Jeffle Xu (2):
>   block: extract one helper function polling hw queue
>   dm: support IO polling for bio-based dm device
> 
> Ming Lei (10):
>   block: add helper of blk_queue_poll
>   block: define 'struct bvec_iter' as packed
>   block: add one helper to free io_context
>   block: move block polling code into one dedicated source file
>   block: prepare for supporting bio_list via other link
>   block: create io poll context for submission and poll task
>   block: add req flag of REQ_POLL_CTX
>   block: use per-task poll context to implement bio based io polling
>   block: limit hw queues to be polled in each blk_poll()
>   block: allow to control FLAG_POLL via sysfs for bio poll capable queue
> 
>  block/Makefile                |   3 +-
>  block/bio.c                   |   5 +
>  block/blk-core.c              |  68 +++-
>  block/blk-ioc.c               |  15 +-
>  block/blk-mq.c                | 231 -------------
>  block/blk-mq.h                |  40 +++
>  block/blk-poll.c              | 632 ++++++++++++++++++++++++++++++++++
>  block/blk-sysfs.c             |  16 +-
>  block/blk.h                   | 112 ++++++
>  drivers/md/dm-table.c         |  24 ++
>  drivers/md/dm.c               |   2 +
>  drivers/nvme/host/core.c      |   2 +-
>  include/linux/bio.h           | 132 +++----
>  include/linux/blk_types.h     |  31 +-
>  include/linux/blkdev.h        |   1 +
>  include/linux/bvec.h          |   2 +-
>  include/linux/device-mapper.h |   1 +
>  include/linux/genhd.h         |   2 +
>  include/linux/iocontext.h     |   2 +
>  19 files changed, 1003 insertions(+), 318 deletions(-)
>  create mode 100644 block/blk-poll.c
> 


