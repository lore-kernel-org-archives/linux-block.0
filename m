Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6829FC43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470D22067B
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 14:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfKLOrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:47:41 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58904 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLOrl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 09:47:41 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xACElXEC026007;
        Tue, 12 Nov 2019 23:47:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Tue, 12 Nov 2019 23:47:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040052248.bbtec.net [126.40.52.248])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xACElWEb026003
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 12 Nov 2019 23:47:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] block: Bail out iteration functions upon SIGKILL.
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bob Liu <bob.liu@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
 <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
 <BYAPR04MB58165EC2C792CE26AAAF361FE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <272e3542-72ab-12ff-636b-722a68a2589c@i-love.sakura.ne.jp>
Date:   Tue, 12 Nov 2019 23:47:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB58165EC2C792CE26AAAF361FE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/12 13:05, Damien Le Moal wrote:
> On 2019/11/08 20:54, Tetsuo Handa wrote:
>> syzbot found that a thread can stall for minutes inside fallocate()
>> after that thread was killed by SIGKILL [1]. While trying to allocate
>> 64TB of disk space using fallocate() is legal, delaying termination of
>> killed thread for minutes is bad. Thus, allow iteration functions in
>> block/blk-lib.c to be killable.
>>
>> [1] https://syzkaller.appspot.com/bug?id=9386d051e11e09973d5a4cf79af5e8cedf79386d
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Reported-by: syzbot <syzbot+b48daca8639150bc5e73@syzkaller.appspotmail.com>
>> ---
>>  block/blk-lib.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index 5f2c429..6ca7cae 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -7,9 +7,22 @@
>>  #include <linux/bio.h>
>>  #include <linux/blkdev.h>
>>  #include <linux/scatterlist.h>
>> +#include <linux/sched/signal.h>
>>  
>>  #include "blk.h"
>>  
>> +static int blk_should_abort(struct bio *bio)
>> +{
>> +	int ret;
>> +
>> +	cond_resched();
>> +	if (!fatal_signal_pending(current))
>> +		return 0;
>> +	ret = submit_bio_wait(bio);
> 
> This will change the behavior of __blkdev_issue_discard() to a sync IO
> execution instead of the current async execution since submit_bio_wait()
> call is the responsibility of the caller (e.g. blkdev_issue_discard()).
> Have you checked if users of __blkdev_issue_discard() are OK with that ?
> f2fs, ext4, xfs, dm and nvme use this function.

I'm not sure...

> 
> Looking at f2fs, this does not look like it is going to work as expected
> since the bio setup, including end_io callback, is done after this
> function is called and a regular submit_bio() execution is being used.

Then, just breaking the iteration like below?
nvmet_bdev_execute_write_zeroes() ignores -EINTR if "*biop = bio;" is done. Is that no problem?

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -7,6 +7,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
+#include <linux/sched/signal.h>
 
 #include "blk.h"
 
@@ -30,6 +31,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	struct bio *bio = *biop;
 	unsigned int op;
 	sector_t bs_mask;
+	int ret = 0;
 
 	if (!q)
 		return -ENXIO;
@@ -76,10 +78,14 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		 * is disabled.
 		 */
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 	}
 
 	*biop = bio;
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
 
@@ -136,6 +142,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	unsigned int max_write_same_sectors;
 	struct bio *bio = *biop;
 	sector_t bs_mask;
+	int ret = 0;
 
 	if (!q)
 		return -ENXIO;
@@ -172,10 +179,14 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 			nr_sects = 0;
 		}
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 	}
 
 	*biop = bio;
-	return 0;
+	return ret;
 }
 
 /**
@@ -216,6 +227,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 	struct bio *bio = *biop;
 	unsigned int max_write_zeroes_sectors;
 	struct request_queue *q = bdev_get_queue(bdev);
+	int ret = 0;
 
 	if (!q)
 		return -ENXIO;
@@ -246,10 +258,14 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 			nr_sects = 0;
 		}
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 	}
 
 	*biop = bio;
-	return 0;
+	return ret;
 }
 
 /*
@@ -273,6 +289,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 	struct bio *bio = *biop;
 	int bi_size = 0;
 	unsigned int sz;
+	int ret = 0;
 
 	if (!q)
 		return -ENXIO;
@@ -296,10 +313,14 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 				break;
 		}
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 	}
 
 	*biop = bio;
-	return 0;
+	return ret;
 }
 
 /**

> 
>> +	bio_put(bio);
>> +	return ret ? ret : -EINTR;
>> +}
>> +
>>  struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
>>  {
>>  	struct bio *new = bio_alloc(gfp, nr_pages);
