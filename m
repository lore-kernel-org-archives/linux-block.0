Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C65C433B4
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BBE611CE
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 12:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbhERMji (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 08:39:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4663 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbhERMji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 08:39:38 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkwT211W7z16QW5;
        Tue, 18 May 2021 20:35:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 20:38:18 +0800
Received: from [10.47.83.99] (10.47.83.99) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 13:38:16 +0100
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        <linux-block@vger.kernel.org>, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>, chenxiang <chenxiang66@hisilicon.com>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com> <YKOiClSTyHl5lbXV@T590>
 <108caf1d-c31d-2303-57a8-8fe0f7bde22b@suse.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7f985b61-fd26-0f90-14ab-d4c857f7851c@huawei.com>
Date:   Tue, 18 May 2021 13:37:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <108caf1d-c31d-2303-57a8-8fe0f7bde22b@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.99]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/05/2021 12:54, Hannes Reinecke wrote:
>> In yanhui's virt workload(qemu, libaio, dio, high queue depth, single
>> job), the patch can improve throughput much(>50%) when running
>> sequential write(dio, libaio, 16 jobs) to XFS. And it is observed that
>> IO merge is recovered to level of disabling host tags.
>>
> I've found a good testcase for this by using null_blk:
> 
> modprobe null_blk submit_queues=32 queue_mode=2 irqmode=0 bs=4096
> hw_queue_depth=2048 completion_nsec=1 nr_devices=4 shared_tags=1
> shared_tag_bitmap=1
> 
> and using a simple fio job with libaio and rw=read and numjobs=32 will
> do the trick:
> 
> [nullb]
> rw=read
> size=16g
> ioengine=libaio
> direct=1
> buffered=0
> group_reporting=1
> bs=4096
> numjobs=32
> 
> (of course, the 'numjobs' and 'submit_queues' parameter would need to be
> adjusted to your machine).
> Omitting the 'shared_tag_bitmap' module parameter would yield around 12M
> iops; adding it would see a rather dramatic drop to 172k iops.
> With this patchset it's back to the expected iops value.

I will consider running this test myself, but do you mean that you get 
~12M with shared_tag_bitmap=1 and this patch?

I would always expect shared_tag_bitmap=1 to give a drop for null_blk, 
as we move from per-submit queue driver tag to all submit queues sharing 
the same driver tagset.

And I am not sure if you are fixing the IO sched from default.

Thanks,
John
