Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81760C433DB
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 11:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF80207AA
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 11:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgLWLmK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 06:42:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2282 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLWLmJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 06:42:09 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D1B5J4m2Rz67T4y;
        Wed, 23 Dec 2020 19:37:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 23 Dec 2020 12:41:27 +0100
Received: from [10.47.6.156] (10.47.6.156) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 23 Dec
 2020 11:41:26 +0000
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
From:   John Garry <john.garry@huawei.com>
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <hare@suse.de>, <kashyap.desai@broadcom.com>,
        <linuxarm@huawei.com>
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
 <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
 <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
 <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
 <f98fd31e-89d4-523f-df70-4bd5f39ccbd5@huawei.com>
 <33e41110-b3b2-ac16-f131-de1679ce8238@acm.org>
 <7bdd562d-b258-43a2-0de0-966091086cff@huawei.com>
Message-ID: <e56e8831-4a74-8411-6c04-3a65aff855f4@huawei.com>
Date:   Wed, 23 Dec 2020 11:40:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7bdd562d-b258-43a2-0de0-966091086cff@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.156]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

- ppvk@codeaurora.org

> 
>> Are there any blk_mq_tagset_busy_iter() calls that happen from a 
>> context where the tag set can disappear while that function is in 
>> progress?
>>
> 
> So isn't the blk_mq_tag_set always a member of the host driver data for 
> those cases, and, since blk_mq_tagset_busy_iter() is for iter'ing block 
> driver tags and called from block driver or hctx_busy_show(), it would 
> exist for the lifetime of the host device.
> 
>> Some blk_mq_tagset_busy_iter() calls happen from a context where it is 
>> not allowed to sleep but also where it is guaranteed that the tag set 
>> won't disappear, e.g. the call from inside sdk_mq_queue_rq().
> 
> You're talking about skd_mq_queue_rq() -> skd_in_flight() -> 
> blk_mq_tagset_busy_iter(), right?
> 
> So I would expect any .queue_rq calls to complete before the associated 
> request queue and tagset may be unregistered.
> 
>>
>> How about using a mutex inside blk_mq_queue_tag_busy_iter() instead? 
>> As far as I can see all blk_mq_queue_tag_busy_iter() happen from a 
>> context where it is allowed to sleep.
> 
> Well then it seems sensible to add might_sleep() also.
> 
> And we still have the blk_mq_queue_tag_busy_iter() problem. As Ming 
> mentioned yesterday, we know contexts where from where it is called 
> which may not sleep.

Sorry, I got the 2x iter functions mixed up.

So if we use mutex to solve blk_mq_queue_tag_busy_iter() problem, then 
we still have this issue in blk_mq_tagset_busy_iter() which I report 
previously [0]:

[  319.771745] BUG: KASAN: use-after-free in bt_tags_iter+0xe0/0x128
[  319.777832] Read of size 4 at addr ffff0010b6bd27cc by task more/1866
[  319.784262]
[  319.785753] CPU: 61 PID: 1866 Comm: more Tainted: G        W
5.10.0-rc4-18118-gaa7b9c30d8ff #1070
[  319.795312] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
D05 IT21 Nemo 2.0 RC0 04/18/2018
[  319.804437] Call trace:
[  319.806892]  dump_backtrace+0x0/0x2d0
[  319.810552]  show_stack+0x18/0x68
[  319.813865]  dump_stack+0x100/0x16c
[  319.817348]  print_address_description.constprop.12+0x6c/0x4e8
[  319.823176]  kasan_report+0x130/0x200
[  319.826831]  __asan_load4+0x9c/0xd8
[  319.830315]  bt_tags_iter+0xe0/0x128
[  319.833884]  __blk_mq_all_tag_iter+0x320/0x3a8
[  319.838320]  blk_mq_tagset_busy_iter+0x8c/0xd8
[  319.842760]  scsi_host_busy+0x88/0xb8
[  319.846418]  show_host_busy+0x1c/0x48
[  319.850079]  dev_attr_show+0x44/0x90
[  319.853655]  sysfs_kf_seq_show+0x128/0x1c8
[  319.857744]  kernfs_seq_show+0xa0/0xb8
[  319.861489]  seq_read_iter+0x1ec/0x6a0
[  319.865230]  seq_read+0x1d0/0x250
[  319.868539]  kernfs_fop_read+0x70/0x330
[  319.872369]  vfs_read+0xe4/0x250
[  319.875590]  ksys_read+0xc8/0x178
[  319.878898]  __arm64_sys_read+0x44/0x58
[  319.882730]  el0_svc_common.constprop.2+0xc4/0x1e8
[  319.887515]  do_el0_svc+0x90/0xa0
[  319.890824]  el0_sync_handler+0x128/0x178
[  319.894825]  el0_sync+0x158/0x180
[  319.898131]
[  319.899614] The buggy address belongs to the page:
[  319.904403] page:000000004e9e6864 refcount:0 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x10b6bd2
[  319.913876] flags: 0xbfffc0000000000()
[  319.917626] raw: 0bfffc0000000000 0000000000000000 fffffe0000000000
0000000000000000
[  319.925363] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[  319.933096] page dumped because: kasan: bad access detected
[  319.938658]
[  319.940141] Memory state around the buggy address:
[  319.944925]  ffff0010b6bd2680: ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff
[  319.952139]  ffff0010b6bd2700: ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff
[  319.959354] >ffff0010b6bd2780: ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff
[  319.966566] ^
[  319.972131]  ffff0010b6bd2800: ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff
[  319.979344]  ffff0010b6bd2880: ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff
[  319.986557]
==================================================================
[  319.993770] Disabling lock debugging due to kernel taint

So to trigger this, I start fio on a disk, and then have one script
which constantly enables and disables an IO scheduler for that disk, and
another script which constantly reads /sys/class/scsi_host/host0/host_busy .

And in this problem, the driver tag we iterate may point to a stale IO 
sched request.

Thanks,
John

[0] 
https://lore.kernel.org/linux-block/9d4124ea-dbab-41cf-63bd-b17ef3e5037a@huawei.com/
