Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39BDC433DB
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558EF20663
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 12:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLUMIE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Dec 2020 07:08:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2275 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgLUMID (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Dec 2020 07:08:03 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Czyp12pKHz67Qrw;
        Mon, 21 Dec 2020 20:04:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 21 Dec 2020 13:07:21 +0100
Received: from [10.210.168.224] (10.210.168.224) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 21 Dec 2020 12:07:20 +0000
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <ppvk@codeaurora.org>,
        <kashyap.desai@broadcom.com>, <linuxarm@huawei.com>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
Date:   Mon, 21 Dec 2020 12:06:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.224]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/12/2020 22:43, Bart Van Assche wrote:
> On 12/17/20 3:07 AM, John Garry wrote:
>> References to old IO sched requests are currently cleared from the
>> tagset when freeing those requests; switching elevator or changing
>> request queue depth is such a scenario in which this occurs.
>>
>> However, this does not stop the potentially racy behaviour of freeing
>> and clearing a request reference between a tagset iterator getting a
>> reference to a request and actually dereferencing that request.
>>
>> Such a use-after-free can be triggered, as follows:
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in bt_iter+0xa0/0x120
>> Read of size 8 at addr ffff00108d589300 by task fio/3052
>>
>> CPU: 32 PID: 3052 Comm: fio Tainted: GW
>> 5.10.0-rc4-64839-g2dcf1ee5054f #693
>> Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
>> D05 IT21 Nemo 2.0 RC0 04/18/2018
>> Call trace:
>> dump_backtrace+0x0/0x2d0
>> show_stack+0x18/0x68
>> dump_stack+0x100/0x16c
>> print_address_description.constprop.12+0x6c/0x4e8
>> kasan_report+0x130/0x200
>> __asan_load8+0x9c/0xd8
>> bt_iter+0xa0/0x120
>> blk_mq_queue_tag_busy_iter+0x2d8/0x540
>> blk_mq_in_flight+0x80/0xb8
>> part_stat_show+0xd8/0x238
>> dev_attr_show+0x44/0x90
>> sysfs_kf_seq_show+0x128/0x1c8
>> kernfs_seq_show+0xa0/0xb8
>> seq_read_iter+0x1ec/0x6a0
>> seq_read+0x1d0/0x250
>> kernfs_fop_read+0x70/0x330
>> vfs_read+0xe4/0x250
>> ksys_read+0xc8/0x178
>> __arm64_sys_read+0x44/0x58
>> el0_svc_common.constprop.2+0xc4/0x1e8
>> do_el0_svc+0x90/0xa0
>> el0_sync_handler+0x128/0x178
>> el0_sync+0x158/0x180
>>
>> This is found experimentally by running fio on 2x SCSI disks - 1x disk
>> holds the root partition. Userspace is constantly triggering the tagset
>> iter from reading the root (gen)disk partition info. And so if the IO
>> sched is constantly changed on the other disk, eventually the UAF occurs,
>> as described above.
> 
> Hi John,

Hi Bart,

> 
> Something is not clear to me. The above call stack includes
> blk_mq_queue_tag_busy_iter(). That function starts with
> percpu_ref_tryget(&q->q_usage_counter) and ends with calling
> percpu_ref_put(&q->q_usage_counter). So it will only iterate over a tag set
> if q->q_usage_counter is live. However, both blk_mq_update_nr_requests()
> and elevator_switch() start with freezing the request queue.
> blk_mq_freeze_queue() starts with killing q->q_usage_counter and waits
> until that counter has dropped to zero. In other words,
> blk_mq_queue_tag_busy_iter() should not iterate over a tag set while a tag
> set is being freed or reallocated. 

Right, this is what I thought, but Ming reminded me 
"blk_mq_queue_tag_busy_iter() can be run on another request queue just
between one driver tag is allocated and updating the request map, so one
extra request reference still can be grabbed."

> Does this mean that we do not yet have
> a full explanation about why the above call stack can be triggered?

We understand it, and I'll describe my experiment in detail:
a. fio runs on 2x disks, sda (root partition disk) and sdb.
b. for sda, userpace triggers blk_mq_queue_tag_busy_iter(), as in 
stackframe above. Since its request queue is not frozen, it will iter 
the busy tags.
c. on sdb, I continuously change the IO scheduler.

So sdb request queue gets frozen as we switch IO sched, but we could 
have this sequence of events:
- blk_mq_queue_tag_busy_iter() on sda takes reference to a sdb request
    - Getting a tag and updating ->rqs[] in tagset is not atomic
- requests for sdb cleared in tagset and request memory is freed
- blk_mq_queue_tag_busy_iter() on sda still holds reference to sdb 
request and dereferences it -> UAF

Hope it's clear. It is a bit unlikely, I will admit, but it still can 
happen and UAF is never good. So please let me know if other idea to solve.

Thanks,
John
