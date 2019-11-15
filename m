Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022CBC43141
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA31F2075E
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKOKFp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:05:45 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58593 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOKFp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 05:05:45 -0500
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xAFA5btj032359;
        Fri, 15 Nov 2019 19:05:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Fri, 15 Nov 2019 19:05:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040052248.bbtec.net [126.40.52.248])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xAFA5b39032356
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 15 Nov 2019 19:05:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] block: Bail out iteration functions upon SIGKILL.
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Bob Liu <bob.liu@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
 <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
 <BYAPR04MB58165EC2C792CE26AAAF361FE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
 <272e3542-72ab-12ff-636b-722a68a2589c@i-love.sakura.ne.jp>
 <BYAPR04MB5816D18E6F6633030265B06EE7760@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <74a7ed17-0e2b-976c-0000-2774a1a10585@i-love.sakura.ne.jp>
Date:   Fri, 15 Nov 2019 19:05:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816D18E6F6633030265B06EE7760@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/13 10:54, Damien Le Moal wrote:
> On 2019/11/12 23:48, Tetsuo Handa wrote:
> [...]
>>>> +static int blk_should_abort(struct bio *bio)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	cond_resched();
>>>> +	if (!fatal_signal_pending(current))
>>>> +		return 0;
>>>> +	ret = submit_bio_wait(bio);
>>>
>>> This will change the behavior of __blkdev_issue_discard() to a sync IO
>>> execution instead of the current async execution since submit_bio_wait()
>>> call is the responsibility of the caller (e.g. blkdev_issue_discard()).
>>> Have you checked if users of __blkdev_issue_discard() are OK with that ?
>>> f2fs, ext4, xfs, dm and nvme use this function.
>>
>> I'm not sure...
>>
>>>
>>> Looking at f2fs, this does not look like it is going to work as expected
>>> since the bio setup, including end_io callback, is done after this
>>> function is called and a regular submit_bio() execution is being used.
>>
>> Then, just breaking the iteration like below?
>> nvmet_bdev_execute_write_zeroes() ignores -EINTR if "*biop = bio;" is done. Is that no problem?
>>
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/bio.h>
>>  #include <linux/blkdev.h>
>>  #include <linux/scatterlist.h>
>> +#include <linux/sched/signal.h>
>>  
>>  #include "blk.h"
>>  
>> @@ -30,6 +31,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>  	struct bio *bio = *biop;
>>  	unsigned int op;
>>  	sector_t bs_mask;
>> +	int ret = 0;
>>  
>>  	if (!q)
>>  		return -ENXIO;
>> @@ -76,10 +78,14 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>  		 * is disabled.
>>  		 */
>>  		cond_resched();
>> +		if (fatal_signal_pending(current)) {
>> +			ret = -EINTR;
>> +			break;
>> +		}
>>  	}
>>  
>>  	*biop = bio;
>> -	return 0;
>> +	return ret;
> 
> This will leak a bio as blkdev_issue_discard() executes the bio only in
> the case "if (!ret && bio)". So that does not work as is, unless all
> callers of __blkdev_issue_discard() are also changed. Same problem for
> the other __blkdev_issue_xxx() functions.
> 
> Looking more into this, if an error is returned here, no bio should be
> returned and we need to make sure that all started bios are also
> completed. So your helper blk_should_abort() did the right thing calling
> submit_bio_wait(). However, I Think it would be better to fail
> immediately the current loop bio instead of executing it and then
> reporting the -EINTR error, unconditionally, regardless of what the
> started bios completion status is.
> 
> This could be done with the help of a function like this, very similar
> to submit_bio_wait().
> 
> void bio_chain_end_wait(struct bio *bio)
> {
> 	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> 
> 	bio->bi_private = &done;
> 	bio->bi_end_io = submit_bio_wait_endio;
> 	bio->bi_opf |= REQ_SYNC;
> 	bio_endio(bio);
> 	wait_for_completion_io(&done);
> }
> 
> And then your helper function becomes something like this:
> 
> static int blk_should_abort(struct bio *bio)
> {
> 	int ret;
> 
> 	cond_resched();
> 	if (!fatal_signal_pending(current))
> 		return 0;
> 
> 	if (bio_flagged(bio, BIO_CHAIN))
> 		bio_chain_end_wait(bio);

I don't know about block layer, but I feel this is bad because bio_put()
will be called without submit_bio_wait() when bio_flagged() == false.
Who calls submit_bio_wait() if bio_flagged() == false ?

> 	bio_put(bio);
> 
> 	return -EINTR;
> }
> 
> Thoughts ?
> 
