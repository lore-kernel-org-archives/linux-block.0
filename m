Return-Path: <SRS0=4Sb2=2K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFA5C43603
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 06:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121C52465E
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 06:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfLTGRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:17:00 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:20213 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbfLTGRA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 01:17:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TlPVA1v_1576822598;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TlPVA1v_1576822598)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Dec 2019 14:16:38 +0800
Subject: Re: [PATCH] block: make the io_ticks counter more accurate
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, xlpang@linux.alibaba.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191217142828.79295-1-wenyang@linux.alibaba.com>
 <658ba1d9-45b3-db85-250d-7a1a9328e9ff@kernel.dk>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <9e2de812-4ca7-3560-08ea-a346944c05d6@linux.alibaba.com>
Date:   Fri, 20 Dec 2019 14:16:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <658ba1d9-45b3-db85-250d-7a1a9328e9ff@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/12/18 9:28 上午, Jens Axboe wrote:
> On 12/17/19 7:28 AM, Wen Yang wrote:
>> Instead of the jiffies, we should update the io_ticks counter
>> with the passed in parameter 'now'.
> 
> But they are not the same clock source...
> 

Hi Jens,
Thanks for your comments.
We plan to change it to the following version,
please kindly help with some suggestions.
Thank you.


diff --git a/block/blk-core.c b/block/blk-core.c
index 379f6f5..da7de9f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1365,7 +1365,7 @@ void blk_account_io_done(struct request *req, u64 now)
  		part_stat_lock();
  		part = req->part;

-		update_io_ticks(part, jiffies);
+		update_io_ticks(part, nsecs_to_jiffies(now));
  		part_stat_inc(part, ios[sgrp]);
  		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
  		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - 
req->start_time_ns));
@@ -1407,7 +1407,7 @@ void blk_account_io_start(struct request *rq, bool 
new_io)
  		rq->part = part;
  	}

-	update_io_ticks(part, jiffies);
+	update_io_ticks(part, nsecs_to_jiffies(ktime_get_ns()));

  	part_stat_unlock();
  }
--
1.8.3.1


--
Best Regards,
Wen

