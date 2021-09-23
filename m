Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55CCC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B128D61216
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 13:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhIWNer (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:34:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9912 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbhIWNer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 09:34:47 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HFbbC5s8Sz8ymG;
        Thu, 23 Sep 2021 21:28:39 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:33:11 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:33:10 +0800
Subject: Re: [patch v8 0/7] handle unexpected message from server
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f56cc608-ac55-0eee-f3d0-19ba1a8c22ef@huawei.com>
Date:   Thu, 23 Sep 2021 21:33:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210916093350.1410403-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/16 17:33, Yu Kuai wrote:

Hi, jens

Any interest to apply this series?

Thanks,
Kuai
> This patch set tries to fix that client might oops if nbd server send
> unexpected message to client, for example, our syzkaller report a uaf
> in nbd_read_stat():
> 
> Call trace:
>   dump_backtrace+0x0/0x310 arch/arm64/kernel/time.c:78
>   show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x144/0x1b4 lib/dump_stack.c:118
>   print_address_description+0x68/0x2d0 mm/kasan/report.c:253
>   kasan_report_error mm/kasan/report.c:351 [inline]
>   kasan_report+0x134/0x2f0 mm/kasan/report.c:409
>   check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>   __asan_load4+0x88/0xb0 mm/kasan/kasan.c:699
>   __read_once_size include/linux/compiler.h:193 [inline]
>   blk_mq_rq_state block/blk-mq.h:106 [inline]
>   blk_mq_request_started+0x24/0x40 block/blk-mq.c:644
>   nbd_read_stat drivers/block/nbd.c:670 [inline]
>   recv_work+0x1bc/0x890 drivers/block/nbd.c:749
>   process_one_work+0x3ec/0x9e0 kernel/workqueue.c:2147
>   worker_thread+0x80/0x9d0 kernel/workqueue.c:2302
>   kthread+0x1d8/0x1e0 kernel/kthread.c:255
>   ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1174
> 
> 1) At first, a normal io is submitted and completed with scheduler:
> 
> internel_tag = blk_mq_get_tag -> get tag from sched_tags
>   blk_mq_rq_ctx_init
>    sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
> ...
> blk_mq_get_driver_tag
>   __blk_mq_get_driver_tag -> get tag from tags
>   tags->rq[tag] = sched_tag->static_rq[internel_tag]
> 
> So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
> to the request: sched_tags->static_rq[internal_tag]. Even if the
> io is finished.
> 
> 2) nbd server send a reply with random tag directly:
> 
> recv_work
>   nbd_read_stat
>    blk_mq_tag_to_rq(tags, tag)
>     rq = tags->rq[tag]
> 
> 3) if the sched_tags->static_rq is freed:
> 
> blk_mq_sched_free_requests
>   blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
>    -> step 2) access rq before clearing rq mapping
>    blk_mq_clear_rq_mapping(set, tags, hctx_idx);
>    __free_pages() -> rq is freed here
> 
> 4) Then, nbd continue to use the freed request in nbd_read_stat()
> 
> Changes in v8:
>   - add patch 5 to this series.
>   - modify some words.
> Changes in v7:
>   - instead of exposing blk_queue_exit(), using percpu_ref_put()
>   directly.
>   - drop the ref right after nbd_handle_reply().
> Changes in v6:
>   - don't set cmd->status to error if request is completed before
>   nbd_clear_req().
>   - get 'q_usage_counter' to prevent accessing freed request through
>   blk_mq_tag_to_rq(), instead of using blk_mq_find_and_get_req().
> Changes in v5:
>   - move patch 1 & 2 in v4 (patch 4 & 5 in v5) behind
>   - add some comment in patch 5
> Changes in v4:
>   - change the name of the patchset, since uaf is not the only problem
>   if server send unexpected reply message.
>   - instead of adding new interface, use blk_mq_find_and_get_req().
>   - add patch 5 to this series
> Changes in v3:
>   - v2 can't fix the problem thoroughly, add patch 3-4 to this series.
>   - modify descriptions.
>   - patch 5 is just a cleanup
> Changes in v2:
>   - as Bart suggested, add a new helper function for drivers to get
>   request by tag.
> 
> Yu Kuai (7):
>    nbd: don't handle response without a corresponding request message
>    nbd: make sure request completion won't concurrent
>    nbd: check sock index in nbd_read_stat()
>    nbd: don't start request if nbd_queue_rq() failed
>    nbd: clean up return value checking of sock_xmit()
>    nbd: partition nbd_read_stat() into nbd_read_reply() and
>      nbd_handle_reply()
>    nbd: fix uaf in nbd_handle_reply()
> 
>   drivers/block/nbd.c | 135 +++++++++++++++++++++++++++++++-------------
>   1 file changed, 96 insertions(+), 39 deletions(-)
> 
