Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9293BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 07:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615DF6198C
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 07:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCWHEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 03:04:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5109 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhCWHEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 03:04:33 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F4Mkh1kXgzYNHw;
        Tue, 23 Mar 2021 15:02:36 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 23 Mar 2021 15:04:24 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 23
 Mar 2021 15:04:24 +0800
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        "Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
Date:   Tue, 23 Mar 2021 15:04:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/3/23 11:23, Sagi Grimberg wrote:
> 
> 
> On 3/22/21 7:57 PM, Sagi Grimberg wrote:
>>
>>> When we reset/teardown a controller, we must freeze and quiesce the
>>> namespaces request queues to make sure that we safely stop inflight I/O
>>> submissions. Freeze is mandatory because if our hctx map changed between
>>> reconnects, blk_mq_update_nr_hw_queues will immediately attempt to freeze
>>> the queue, and if it still has pending submissions (that are still
>>> quiesced) it will hang.
>>>
>>> However, by freezing the namespaces request queues, and only unfreezing
>>> them when we successfully reconnect, inflight submissions that are
>>> running concurrently can now block grabbing the nshead srcu until either
>>> we successfully reconnect or ctrl_loss_tmo expired (or the user
>>> explicitly disconnected).
>>>
>>> This caused a deadlock when a different controller (different path on the
>>> same subsystem) became live (i.e. optimized/non-optimized). This is
>>> because nvme_mpath_set_live needs to synchronize the nshead srcu before
>>> requeueing I/O in order to make sure that current_path is visible to
>>> future (re-)submisions. However the srcu lock is taken by a blocked
>>> submission on a frozen request queue, and we have a deadlock.
>>>
>>> In order to fix this use the blk_mq_submit_bio_direct API to submit the
>>> bio to the low-level driver, which does not block on the queue free
>>> but instead allows nvme-multipath to pick another path or queue up the
>>> bio.
>>
>> Almost...
>>
>> This still has the same issue but instead of blocking on
>> blk_queue_enter() it is blocked on blk_mq_get_tag():
>> -- 
>>   __schedule+0x22b/0x6e0
>>   schedule+0x46/0xb0
>>   io_schedule+0x42/0x70
>>   blk_mq_get_tag+0x11d/0x270
>>   ? blk_bio_segment_split+0x235/0x2a0
>>   ? finish_wait+0x80/0x80
>>   __blk_mq_alloc_request+0x65/0xe0
>>   blk_mq_submit_bio+0x144/0x500
>>   blk_mq_submit_bio_direct+0x78/0xa0
>>   nvme_ns_head_submit_bio+0xc3/0x2f0 [nvme_core]
>>   __submit_bio_noacct+0xcf/0x2e0
>>   __blkdev_direct_IO+0x413/0x440
>>   ? __io_complete_rw.constprop.0+0x150/0x150
>>   generic_file_read_iter+0x92/0x160
>>   io_iter_do_read+0x1a/0x40
>>   io_read+0xc5/0x350
>>   ? common_interrupt+0x14/0xa0
>>   ? update_load_avg+0x7a/0x5e0
>>   io_issue_sqe+0xa28/0x1020
>>   ? lock_timer_base+0x61/0x80
>>   io_wq_submit_work+0xaa/0x120
>>   io_worker_handle_work+0x121/0x330
>>   io_wqe_worker+0xb6/0x190
>>   ? io_worker_handle_work+0x330/0x330
>>   ret_from_fork+0x22/0x30
>> -- 
>>
>> -- 
>>   ? usleep_range+0x80/0x80
>>   __schedule+0x22b/0x6e0
>>   ? usleep_range+0x80/0x80
>>   schedule+0x46/0xb0
>>   schedule_timeout+0xff/0x140
>>   ? del_timer_sync+0x67/0xb0
>>   ? __prepare_to_swait+0x4b/0x70
>>   __wait_for_common+0xb3/0x160
>>   __synchronize_srcu.part.0+0x75/0xe0
>>   ? __bpf_trace_rcu_utilization+0x10/0x10
>>   nvme_mpath_set_live+0x61/0x130 [nvme_core]
>>   nvme_update_ana_state+0xd7/0x100 [nvme_core]
>>   nvme_parse_ana_log+0xa5/0x160 [nvme_core]
>>   ? nvme_mpath_set_live+0x130/0x130 [nvme_core]
>>   nvme_read_ana_log+0x7b/0xe0 [nvme_core]
>>   process_one_work+0x1e6/0x380
>>   worker_thread+0x49/0x300
>> -- 
>>
>>
>>
>> If I were to always start the queues in nvme_tcp_teardown_ctrl
>> right after I cancel the tagset inflights like:
>> -- 
>> @@ -1934,8 +1934,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>>          nvme_sync_io_queues(ctrl);
>>          nvme_tcp_stop_io_queues(ctrl);
>>          nvme_cancel_tagset(ctrl);
>> -       if (remove)
>> -               nvme_start_queues(ctrl);
>> +       nvme_start_queues(ctrl);
>>          nvme_tcp_destroy_io_queues(ctrl, remove);
>> -- 
>>
>> then a simple reset during traffic bricks the host on infinite loop
>> because in the setup sequence we freeze the queue in
>> nvme_update_ns_info, so the queue is frozen but we still have an
>> available path (because the controller is back to live!) so nvme-mpath
>> keeps calling blk_mq_submit_bio_direct and fails, and
>> nvme_update_ns_info cannot properly freeze the queue..
>> -> deadlock.
>>
>> So this is obviously incorrect.
>>
>> Also, if we make nvme-mpath submit a REQ_NOWAIT we basically
>> will fail as soon as we run out of tags, even in the normal path...
>>
>> So I'm not exactly sure what we should do to fix this...
> 
> It's still not too late to go with my original approach... ;)
I check it again. I still think the below patch can avoid the bug.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a6c35f9af416114588298aa7a90b15bbed15a41
The process:
1.nvme_ns_head_submit_bio call srcu_read_lock(&head->srcu).
2.nvme_ns_head_submit_bio will add the bio to current->bio_list instead of waiting for the frozen queue.
3.nvme_ns_head_submit_bio call srcu_read_unlock(&head->srcu, srcu_idx).
So nvme_ns_head_submit_bio do not hold head->srcu long when the queue is frozen, can avoid deadlock.

Sagi, suggest trying this patch.

> .
