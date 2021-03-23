Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E4FC433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 07:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5BB619B7
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 07:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWH3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 03:29:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:35882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhCWH2m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 03:28:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB318AE20;
        Tue, 23 Mar 2021 07:28:41 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
Date:   Tue, 23 Mar 2021 08:28:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/21 3:57 AM, Sagi Grimberg wrote:
> 
>> When we reset/teardown a controller, we must freeze and quiesce the
>> namespaces request queues to make sure that we safely stop inflight I/O
>> submissions. Freeze is mandatory because if our hctx map changed between
>> reconnects, blk_mq_update_nr_hw_queues will immediately attempt to freeze
>> the queue, and if it still has pending submissions (that are still
>> quiesced) it will hang.
>>
>> However, by freezing the namespaces request queues, and only unfreezing
>> them when we successfully reconnect, inflight submissions that are
>> running concurrently can now block grabbing the nshead srcu until either
>> we successfully reconnect or ctrl_loss_tmo expired (or the user
>> explicitly disconnected).
>>
>> This caused a deadlock when a different controller (different path on the
>> same subsystem) became live (i.e. optimized/non-optimized). This is
>> because nvme_mpath_set_live needs to synchronize the nshead srcu before
>> requeueing I/O in order to make sure that current_path is visible to
>> future (re-)submisions. However the srcu lock is taken by a blocked
>> submission on a frozen request queue, and we have a deadlock.
>>
>> In order to fix this use the blk_mq_submit_bio_direct API to submit the
>> bio to the low-level driver, which does not block on the queue free
>> but instead allows nvme-multipath to pick another path or queue up the
>> bio.
> 
> Almost...
> 
> This still has the same issue but instead of blocking on
> blk_queue_enter() it is blocked on blk_mq_get_tag():
> -- 
>   __schedule+0x22b/0x6e0
>   schedule+0x46/0xb0
>   io_schedule+0x42/0x70
>   blk_mq_get_tag+0x11d/0x270
>   ? blk_bio_segment_split+0x235/0x2a0
>   ? finish_wait+0x80/0x80
>   __blk_mq_alloc_request+0x65/0xe0
>   blk_mq_submit_bio+0x144/0x500
>   blk_mq_submit_bio_direct+0x78/0xa0
>   nvme_ns_head_submit_bio+0xc3/0x2f0 [nvme_core]
>   __submit_bio_noacct+0xcf/0x2e0
>   __blkdev_direct_IO+0x413/0x440
>   ? __io_complete_rw.constprop.0+0x150/0x150
>   generic_file_read_iter+0x92/0x160
>   io_iter_do_read+0x1a/0x40
>   io_read+0xc5/0x350
>   ? common_interrupt+0x14/0xa0
>   ? update_load_avg+0x7a/0x5e0
>   io_issue_sqe+0xa28/0x1020
>   ? lock_timer_base+0x61/0x80
>   io_wq_submit_work+0xaa/0x120
>   io_worker_handle_work+0x121/0x330
>   io_wqe_worker+0xb6/0x190
>   ? io_worker_handle_work+0x330/0x330
>   ret_from_fork+0x22/0x30
> -- 
> 
> -- 
>   ? usleep_range+0x80/0x80
>   __schedule+0x22b/0x6e0
>   ? usleep_range+0x80/0x80
>   schedule+0x46/0xb0
>   schedule_timeout+0xff/0x140
>   ? del_timer_sync+0x67/0xb0
>   ? __prepare_to_swait+0x4b/0x70
>   __wait_for_common+0xb3/0x160
>   __synchronize_srcu.part.0+0x75/0xe0
>   ? __bpf_trace_rcu_utilization+0x10/0x10
>   nvme_mpath_set_live+0x61/0x130 [nvme_core]
>   nvme_update_ana_state+0xd7/0x100 [nvme_core]
>   nvme_parse_ana_log+0xa5/0x160 [nvme_core]
>   ? nvme_mpath_set_live+0x130/0x130 [nvme_core]
>   nvme_read_ana_log+0x7b/0xe0 [nvme_core]
>   process_one_work+0x1e6/0x380
>   worker_thread+0x49/0x300
> -- 
> 
Actually, I had been playing around with marking the entire bio as 
'NOWAIT'; that would avoid the tag stall, too:

@@ -313,7 +316,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
         ns = nvme_find_path(head);
         if (likely(ns)) {
                 bio_set_dev(bio, ns->disk->part0);
-               bio->bi_opf |= REQ_NVME_MPATH;
+               bio->bi_opf |= REQ_NVME_MPATH | REQ_NOWAIT;
                 trace_block_bio_remap(bio, disk_devt(ns->head->disk),
                                       bio->bi_iter.bi_sector);
                 ret = submit_bio_noacct(bio);


My only worry here is that we might incur spurious failures under high 
load; but then this is not necessarily a bad thing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
