Return-Path: <SRS0=USsu=2Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F69C2D0DA
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B29F2075E
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 16:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLZQmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Dec 2019 11:42:23 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46757 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbfLZQmX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Dec 2019 11:42:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tm-.zlD_1577378536;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Tm-.zlD_1577378536)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Dec 2019 00:42:17 +0800
Subject: Re: [PATCH v2] block: make the io_ticks counter more accurate
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, xlpang@linux.alibaba.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191226031014.58970-1-wenyang@linux.alibaba.com>
 <41175786-8a02-62e0-fc79-955ec0e74aeb@kernel.dk>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <533328c7-4158-d9fd-d8db-0d02eb9c5108@linux.alibaba.com>
Date:   Fri, 27 Dec 2019 00:42:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <41175786-8a02-62e0-fc79-955ec0e74aeb@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/12/26 11:39 上午, Jens Axboe wrote:
> On 12/25/19 8:10 PM, Wen Yang wrote:
>> Instead of the jiffies, we should update the io_ticks counter
>> with the passed in parameter 'now'.
> 
> I'm still missing some justification for this. What exactly is this
> patch trying to solve or improve? Your commit message says "we should",
> but why?
> 

Hi Jens,

Thank you for your comments.
We observed in the document that:

io_ticks
========

This value counts the number of milliseconds during which the device has
had I/O requests queued.

And the iostat command uses io_ticks count to calculate %util:
https://github.com/sysstat/sysstat/blob/master/rd_stats.c#L372

eg：
Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s 
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util


So we need to unify the time windows of these statistics（io_ticks, 
rd_tick, time_in_queue, etc）.
However, the current code uses jiffies to count io_ticks.
Jiffies is different from the passed in parameter 'now',
so these statistics will be inconsistent：

void blk_account_io_done(struct request *req, u64 now)
{
…
     update_io_ticks(part, jiffies);
     part_stat_inc(part, ios[sgrp]);
     part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
     part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - 
req->start_time_ns));
…
}

In addition, we also found another issue:
the update_io_tick() function only adds one to io_ticks at a time,
which will result in the calculated %util lower than the real one.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/bio.c#n1713


We will try our best to improve it.
please kindly help with some suggestions.
Thanks.

-- 
Best Regards,
Wen

