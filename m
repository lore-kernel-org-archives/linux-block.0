Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9B5C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B59F619BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhCWQ3A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:29:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2734 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhCWQ2s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:28:48 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F4cBV4CZzz682N5;
        Wed, 24 Mar 2021 00:24:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 17:28:44 +0100
Received: from [10.47.11.95] (10.47.11.95) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 16:28:43 +0000
Subject: Re: [PATCH] blk-mq: Fix races between iterating over requests and
 freeing requests
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Khazhy Kumykov <khazhy@google.com>,
        "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
References: <20210319010009.10041-1-bvanassche@acm.org>
 <721c833d-7dc6-30a5-371e-c8c6388fb852@huawei.com>
 <ecab7c5c-53b8-61e4-800e-b9c368e4b8b4@kernel.dk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6a2a5558-6413-bbe7-b2fe-61b89629495a@huawei.com>
Date:   Tue, 23 Mar 2021 16:26:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <ecab7c5c-53b8-61e4-800e-b9c368e4b8b4@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.95]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>
>> Do we have any performance figures to say that the effect is negligible?
> 
> I ran this through my usual peak testing, it's pretty good at finding
> any changes in performance related to changes in overhead. The workload
> is a pretty simple 512b random read, QD 128, using io_uring and polled
> IO.
> 
> It seems to cause a slight slowdown for me. Performance before the patch
> is around 3.23-3.27M IOPS, and after we're at around 3.20-3.22. Looking
> at perf diff, the most interesting bits seem to be:
> 
> 
> 2.09%     -1.05%  [kernel.vmlinux]  [k] blk_mq_get_tag
> 0.48%     +0.98%  [kernel.vmlinux]  [k] __do_sys_io_uring_enter
> 1.49%     +0.85%  [kernel.vmlinux]  [k] __blk_mq_alloc_request
>            +0.71%  [kernel.vmlinux]  [k] __blk_mq_free_request
> 
> which seems to show some shifting around of cost (often happens), but
> generally up a bit looking at the blk side.
> 
> So nothing really major here, and I don't think it's something that
> should getting this fixed.


>John, I can run your series through the same,
> let me know.
> 

The first patch in my series solves the issues reported by community also:
https://lore.kernel.org/linux-block/1614957294-188540-2-git-send-email-john.garry@huawei.com/

And that patch should give no throughput performance hit.

The other two patches in that series are to solve more theoretical 
issues of iterator interactions, but their approach is unacceptable.

Obviously your call. IMHO, Bart's solution would make more sense.

Thanks,
John
