Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873E1C4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 12:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F78D23C44
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 12:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgLJMYC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 07:24:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2241 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgLJMX5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 07:23:57 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CsCfD3BjJz67NBM;
        Thu, 10 Dec 2020 20:19:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 13:23:11 +0100
Received: from [10.210.172.228] (10.210.172.228) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 12:23:09 +0000
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
 <20201209010102.GA1217988@T590>
 <13327a68-6f86-96da-0c5f-5fa0be326d6f@huawei.com>
 <20201210020745.GA1363446@T590>
 <d8500ca2-1f26-7d28-6baa-237284df0a5c@huawei.com>
Message-ID: <76190c94-c5c1-9553-5509-9969fc323544@huawei.com>
Date:   Thu, 10 Dec 2020 12:22:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d8500ca2-1f26-7d28-6baa-237284df0a5c@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.228]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

> 
> So I'll try an experiment today to prove your concern about 
> blk_mq_queue_tag_busy_iter(). Then look at possible solution which 
> builds on patch in $subject, and compare.

JFYI, I was able to trigger this:

[ 1651.324150] 
==================================================================
[ 1651.331400] BUG: KASAN: use-after-free in bt_iter+0xa0/0x120
[ 1651.337054] Read of size 8 at addr ffff00108d589300 by task fio/3052

[ 1651.344891] CPU: 32 PID: 3052 Comm: fio Tainted: GW 
5.10.0-rc4-64839-g2dcf1ee5054f #693
[ 1651.354281] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon 
D05 IT21 Nemo 2.0 RC0 04/18/2018
[ 1651.363407] Call trace:
[ 1651.365861]  dump_backtrace+0x0/0x2d0
[ 1651.369519]  show_stack+0x18/0x68
[ 1651.372833]  dump_stack+0x100/0x16c
[ 1651.376316]  print_address_description.constprop.12+0x6c/0x4e8
[ 1651.382146]  kasan_report+0x130/0x200
[ 1651.385801]  __asan_load8+0x9c/0xd8
[ 1651.389284]  bt_iter+0xa0/0x120
[ 1651.392419]  blk_mq_queue_tag_busy_iter+0x2d8/0x540
[ 1651.397293]  blk_mq_in_flight+0x80/0xb8
[ 1651.401121]  part_stat_show+0xd8/0x238
[ 1651.404867]  dev_attr_show+0x44/0x90
[ 1651.408439]  sysfs_kf_seq_show+0x128/0x1c8
[ 1651.412530]  kernfs_seq_show+0xa0/0xb8
[ 1651.416274]  seq_read_iter+0x1ec/0x6a0
[ 1651.420019]  seq_read+0x1d0/0x250
[ 1651.423331]  kernfs_fop_read+0x70/0x330
[ 1651.427161]  vfs_read+0xe4/0x250
[ 1651.430382]  ksys_read+0xc8/0x178
[ 1651.433690]  __arm64_sys_read+0x44/0x58
[ 1651.437524]  el0_svc_common.constprop.2+0xc4/0x1e8
[ 1651.442309]  do_el0_svc+0x90/0xa0
[ 1651.445619]  el0_sync_handler+0x128/0x178
[ 1651.449623]  el0_sync+0x158/0x180

[ 1651.454418] The buggy address belongs to the page:
[ 1651.459208] page:00000000140c0813 refcount:0 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0x108d589
[ 1651.468683] flags: 0xbfffc0000000000()
[ 1651.472432] raw: 0bfffc0000000000 0000000000000000 ffffffff42150201 
0000000000000000
[ 1651.480173] raw: 0000000000000000 0000000000000000 00000000ffffffff 
0000000000000000
[ 1651.487909] page dumped because: kasan: bad access detected

[ 1651.494956] Memory state around the buggy address:
[ 1651.499744]  ffff00108d589200: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[ 1651.506960]  ffff00108d589280: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[ 1651.514176] >ffff00108d589300: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[ 1651.521389]       ^
[ 1651.524611]  ffff00108d589380: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[ 1651.531827]  ffff00108d589400: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[ 1651.539044] 
==================================================================
[ 1651.546258] Disabling lock debugging due to kernel taint
john@ubuntu:~$

So I run fio on disk providing root partition and another disk, and 
constantly change IO scheduler on other disk.

I did also add this delay to trigger in reasonable timeframe:

+++ b/block/blk-mq-tag.c
@@ -215,8 +215,11 @@ static bool bt_iter(struct sbitmap *bitmap, 
unsigned int bitnr, void *data)
* We can hit rq == NULL here, because the tagging functions
* test and set the bit before assigning ->rqs[].
*/
-  if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
-     return iter_data->fn(hctx, rq, iter_data->data, reserved);
+  if (rq) {
+     mdelay(50);
+     if (rq->q == hctx->queue && rq->mq_hctx == hctx)
+        return iter_data->fn(hctx, rq, iter_data->data, reserved);
+       }
        return true;
}


Thanks,
John
