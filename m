Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B879C4332E
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A0722BEF
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 13:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbhAKN2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 08:28:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11088 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732320AbhAKNQF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 08:16:05 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DDvL70bbtzMHd4;
        Mon, 11 Jan 2021 21:14:07 +0800 (CST)
Received: from [10.174.177.185] (10.174.177.185) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 11 Jan 2021 21:15:14 +0800
From:   "yukuai (C)" <yukuai3@huawei.com>
Subject: question about relative control for sync io using bfq
To:     <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>, chenzhou <chenzhou10@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>
Message-ID: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
Date:   Mon, 11 Jan 2021 21:15:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We found a performance problem:

kernel version: 5.10
disk: ssd
scheduler: bfq
arch: arm64 / x86_64
test param: direct=1, ioengine=psync, bs=4k, rw=randread, numjobs=32

We are using 32 threads here, test results showed that iops is equal
to single thread.

After digging into the problem, I found root cause of the problem is 
strange:

bfq_add_request
  bfq_bfqq_handle_idle_busy_switch
   bfq_add_bfqq_busy
    bfq_activate_bfq
     bfq_activate_requeue_entity
      __bfq_activate_requeue_entity
       __bfq_activate_entity
        if (!bfq_entity_to_bfqq(entity))
         if (!entity->in_groups_with_pending_reqs)
          entity->in_groups_with_pending_reqs = true;
          bfqd->num_groups_with_pending_reqs++

If test process is not in root cgroup, num_groups_with_pending_reqs will
be increased after request was instered to bfq.

bfq_select_queue
  bfq_better_to_idle
   idling_needed_for_service_guarantees
    bfq_asymmetric_scenario
     return varied_queue_weights || multiple_classes_busy || 
bfqd->num_groups_with_pending_reqs > 0

After issuing IO to driver, num_groups_with_pending_reqs is ensured to
be nonzero, thus bfq won't expire the queue. This is the root cause of
degradating to single-process performance.

One the other hand, if I set slice_idle to zero, bfq_better_to_idle will
return false early, and the problem will disapear. However, relative
control will be inactive.

My question is that, is this a known flaw for bfq? If not, as cfq don't
have such problem, is there a suitable solution?

Thanks!
Yu Kuai
such problem,
