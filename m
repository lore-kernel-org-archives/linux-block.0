Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C5C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 17:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A8523B32
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 17:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgLHRiC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:38:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2225 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgLHRiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 12:38:02 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cr6jk6lMpz67NkT;
        Wed,  9 Dec 2020 01:34:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 18:37:20 +0100
Received: from [10.210.169.98] (10.210.169.98) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 17:37:18 +0000
Subject: Re: [RFC PATCH] blk-mq: Clean up references when freeing rqs
From:   John Garry <john.garry@huawei.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>, <hare@suse.de>,
        <ppvk@codeaurora.org>, <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>
References: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
 <20201202033134.GD494805@T590>
 <aaf77015-3039-6b04-3417-d376e3467444@huawei.com>
 <20201203005505.GB540033@T590>
 <fa222311-2184-0041-61ab-b3d70fb92585@huawei.com>
 <7beb86a2-5c4b-bdc0-9fce-1b583548c6d0@huawei.com>
Message-ID: <9d4124ea-dbab-41cf-63bd-b17ef3e5037a@huawei.com>
Date:   Tue, 8 Dec 2020 17:36:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7beb86a2-5c4b-bdc0-9fce-1b583548c6d0@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.98]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/12/2020 11:36, John Garry wrote:
>>
>> OK, but another thing to say is that I need to find a somewhat 
>> reliable reproducer for the potential problem you mention. So far this 
>> patch solves the issue I see (in that kasan stops warning). Let me 
>> analyze this a bit further.
>>
> 
> Hi Ming,
> 
> I am just looking at this again, and have some doubt on your concern [0].
> 
>  From checking blk_mq_queue_tag_busy_iter() specifically, don't we 
> actually guard against this with the q->q_usage_counter mechanism? That 
> is, an agent needs to grab a q counter ref when attempting the iter. 
> This will fail when the queue IO sched is being changed, as we freeze 
> the queue during this time, which is when the requests are freed, so no 
> agent can hold a reference to a freed request then. And same goes for 
> blk_mq_update_nr_requests(), where we freeze the queue.
> 
> But I didn't see such a guard for blk_mq_tagset_busy_iter().
> 

So I was able to trigger a use-after-free BUG in 
blk_mq_tagset_busy_iter() even with my change, but I needed to add a 
delay, as follows:

--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -278,6 +278,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, 
unsigned int bitnr, void *data)
                 rq = tags->rqs[bitnr];
         if (!rq)
                 return true;
+       msleep(50);
         if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
             !blk_mq_request_started(rq))
                 return true;


And here's the splat:

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
another which constantly reads /sys/class/scsi_host/host0/host_busy.

I need the delay to make triggering the issue quick, as the window is so 
small between the tag bit being cleared at the point the queue is being 
frozen, and clearing the reference in the tagset.

Anyway, solving this doesn't look trivial...

Thanks,
john
