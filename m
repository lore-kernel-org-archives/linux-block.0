Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B13EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Apr 2022 06:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiDZG2p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Apr 2022 02:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiDZG2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Apr 2022 02:28:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B0626E9
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 23:25:36 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KnWyp2HPwzGp1l;
        Tue, 26 Apr 2022 14:22:58 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 14:25:34 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 14:25:33 +0800
Subject: Re: Precise disk statistics
To:     "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "Hunt, Joshua" <johunt@akamai.com>
References: <1650661324247.40468@akamai.com> <1650915337169.63486@akamai.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <87031651-ba75-2b6f-8a5e-b0b4ef41c65f@huawei.com>
Date:   Tue, 26 Apr 2022 14:25:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1650915337169.63486@akamai.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2022/04/26 3:35, Jayaramappa, Srilakshmi Ð´µÀ:
> ________________________________________
> From: Jayaramappa, Srilakshmi
> Sent: Friday, April 22, 2022 5:02 PM
> To: axboe@kernel.dk; snitzer@redhat.com; linux-block@vger.kernel.org
> Cc: Hunt, Joshua
> Subject: Precise disk statistics
> 
> Hi,
> 
> We install LTS kernel on our machines. While moving from 4.19.x to 5.4.x we noticed a performance drop in one of our applications.
> We tracked down the root cause to the commit series for removing the pending IO accounting (80a787ba3809 to 6f75723190d8)
> which includes 5b18b5a73760 block: delete part_round_stats and switch to less precise counting.
> 
> The application (which runs on non-dm machines) tracks disk utilization to estimate the load it can further take on. After the commits in question,
> we see an over reporting of disk utilization [1] compared to the older method of reporting based on inflight counter [2] for the same load.
> The over-reporting is observed in v5.4.190 and in v5.15.35 as well. I've attached the config file used to build the kernel.
> 
> We understand that the disk util% does not provide a true picture of how much more work the device is capable of doing in flash based
> devices and we are planning to use a different model to observe the performance potential.
> In the interim we are having to revert the above commit series to bring back the original reporting method.
> 
> In the hopes of getting back our application's performance with a new change on top of the 5.4.x reporting (as opposed to reverting commits),
> I tried checking if the request queue is busy before updating io_ticks [3]. With this change the applications's throughput is closer to
> what we observe with the commits reverted, but still behind by ~ 6 %. Though, I am not sure that this change is safe overall.
> 
> I'd appreciate your expert opinion on this matter. Could you please let us know if there is some other idea we could explore to report precise disk stats
> that we can build on top of existing reporting in the kernel and submit a patch, or if going back to using the inflight counters is indeed our best bet.
> 
> Thank you
> -Sri
> 
> [1]
> root@xxx:~# DISK=nvme3n1; dd if=/dev/$DISK of=/dev/null bs=1048576 iflag=direct count=2048 & iostat -yxm /dev/$DISK 1 1 ; wait
> ...
> 2147483648 bytes (2.1 GB, 2.0 GiB) copied, 0.721532 s, 3.0 GB/s
> 
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>             0.13    0.00    0.28    1.53    0.00   98.07
> 
> Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await dareq-sz  aqu-sz  %util
> nvme3n1       16383.00   2047.88     0.00   0.00    0.21   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00  72.20
> 
> [2]
> 
> root@xxx:~# DISK=nvme3n1; dd if=/dev/$DISK of=/dev/null bs=1048576 iflag=direct count=2048 & iostat -yxm /dev/$DISK 1 1 ; wait
> ...
> 2147483648 bytes (2.1 GB, 2.0 GiB) copied, 0.702101 s, 3.1 GB/s
> 
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>             0.03    0.00    0.18    1.57    0.00   98.22
> 
> Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await dareq-sz  aqu-sz  %util
> nvme3n1       16380.00   2047.50     0.00   0.00    0.20   128.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00  64.20
> 
> 
> [3]
> diff --git a/block/bio.c b/block/bio.c
> index cb38d6f3acce..8275b10a1c9a 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1754,14 +1754,17 @@ void bio_check_pages_dirty(struct bio *bio)
>          schedule_work(&bio_dirty_work);
>   }
> 
> -void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
> +void update_io_ticks(struct request_queue *q, struct hd_struct *part, unsigned long now, bool end)
>   {
>          unsigned long stamp;
>   again:
>          stamp = READ_ONCE(part->stamp);
>          if (unlikely(stamp != now)) {
>                  if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
> +                      if (blk_mq_queue_inflight(q)) {
>                                  __part_stat_add(part, io_ticks, end ? now - stamp : 1);
Hi,

We met the same problem, and I'm pretty sure the root cause is the above
code: while starting the first IO in the new jiffies, io_ticks will
always add 1 jiffies in additional, which is wrong. And in your test
case, dd will issue io one by one, thus if the new io is issued in the
new jiffies than the jiffies that old io is done, io_ticks will be
miscaculated.

We reintroduce part_round_stats() to fix the problem. However, iterate
tags when starting each IO is not a good idea, and we can't figure out
a good solution that will not affect fast path yet.

Thanks,
Kuai
> +            }
>                  }
>          }
>          if (part->partno) {
> 
> 
> 
> Sorry, resending without the config attachment since my original email bounced from linux-block.
> 
> 
> Thanks
> -Sri.
> 
