Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16D1C282DE
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 07:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9732083E
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 07:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFEHTE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:19:04 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54576 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbfFEHTD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 03:19:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TTTMtl-_1559718986;
Received: from 30.5.112.239(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TTTMtl-_1559718986)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jun 2019 15:16:27 +0800
Subject: Re: [RFC] block: add counter to track io request's d2c time
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>
References: <20190604012855.1679-1-xiaoguang.wang@linux.alibaba.com>
 <BYAPR04MB5749B89B96684EA3540E0DE886150@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <0b30c7ca-a8d0-d948-56d1-a065b47ddfcf@linux.alibaba.com>
Date:   Wed, 5 Jun 2019 15:16:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749B89B96684EA3540E0DE886150@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi£¬

> In case I missed, is it possible to include iostat patch corresponding
> to this kernel patch ?
I hadn't make a iostat patch and will make one later.

Regards,
Xiaoguang Wang

> 
> On 6/3/19 6:29 PM, Xiaoguang Wang wrote:
>> Indeed tool iostat's await is not good enough, which is somewhat sketchy
>> and could not show request's latency on device driver's side.
>>
>> Here we add a new counter to track io request's d2c time, also with this
>> patch, we can extend iostat to show this value easily.
>>
>> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
>> ---
>>    block/blk-core.c          | 3 +++
>>    block/genhd.c             | 7 +++++--
>>    block/partition-generic.c | 8 ++++++--
>>    include/linux/genhd.h     | 4 ++++
>>    4 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index ee1b35fe8572..b0449ec80a7d 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1257,6 +1257,9 @@ void blk_account_io_done(struct request *req, u64 now)
>>    		update_io_ticks(part, jiffies);
>>    		part_stat_inc(part, ios[sgrp]);
>>    		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>> +		if (req->io_start_time_ns)
>> +			part_stat_add(part, d2c_nsecs[sgrp],
>> +				      now - req->io_start_time_ns);
>>    		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
>>    		part_dec_in_flight(req->q, part, rq_data_dir(req));
>>    
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 24654e1d83e6..727bc1de1a74 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -1377,7 +1377,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>>    			   "%lu %lu %lu %u "
>>    			   "%lu %lu %lu %u "
>>    			   "%u %u %u "
>> -			   "%lu %lu %lu %u\n",
>> +			   "%lu %lu %lu %u %u %u %u\n",
>>    			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
>>    			   disk_name(gp, hd->partno, buf),
>>    			   part_stat_read(hd, ios[STAT_READ]),
>> @@ -1394,7 +1394,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>>    			   part_stat_read(hd, ios[STAT_DISCARD]),
>>    			   part_stat_read(hd, merges[STAT_DISCARD]),
>>    			   part_stat_read(hd, sectors[STAT_DISCARD]),
>> -			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD)
>> +			   (unsigned int)part_stat_read_msecs(hd, STAT_DISCARD),
>> +			   (unsigned int)part_stat_read_d2c_msecs(hd, STAT_READ),
>> +			   (unsigned int)part_stat_read_d2c_msecs(hd, STAT_WRITE),
>> +			   (unsigned int)part_stat_read_d2c_msecs(hd, STAT_DISCARD)
>>    			);
>>    	}
>>    	disk_part_iter_exit(&piter);
>> diff --git a/block/partition-generic.c b/block/partition-generic.c
>> index aee643ce13d1..0635a46a31dd 100644
>> --- a/block/partition-generic.c
>> +++ b/block/partition-generic.c
>> @@ -127,7 +127,7 @@ ssize_t part_stat_show(struct device *dev,
>>    		"%8lu %8lu %8llu %8u "
>>    		"%8lu %8lu %8llu %8u "
>>    		"%8u %8u %8u "
>> -		"%8lu %8lu %8llu %8u"
>> +		"%8lu %8lu %8llu %8u %8u %8u %8u %8u"
>>    		"\n",
>>    		part_stat_read(p, ios[STAT_READ]),
>>    		part_stat_read(p, merges[STAT_READ]),
>> @@ -143,7 +143,11 @@ ssize_t part_stat_show(struct device *dev,
>>    		part_stat_read(p, ios[STAT_DISCARD]),
>>    		part_stat_read(p, merges[STAT_DISCARD]),
>>    		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
>> -		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD));
>> +		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
>> +		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
>> +		(unsigned int)part_stat_read_d2c_msecs(p, STAT_READ),
>> +		(unsigned int)part_stat_read_d2c_msecs(p, STAT_WRITE),
>> +		(unsigned int)part_stat_read_d2c_msecs(p, STAT_DISCARD));
>>    }
>>    
>>    ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index 8b5330dd5ac0..f80ba947cac2 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -85,6 +85,7 @@ struct partition {
>>    
>>    struct disk_stats {
>>    	u64 nsecs[NR_STAT_GROUPS];
>> +	u64 d2c_nsecs[NR_STAT_GROUPS];
>>    	unsigned long sectors[NR_STAT_GROUPS];
>>    	unsigned long ios[NR_STAT_GROUPS];
>>    	unsigned long merges[NR_STAT_GROUPS];
>> @@ -367,6 +368,9 @@ static inline void free_part_stats(struct hd_struct *part)
>>    #define part_stat_read_msecs(part, which)				\
>>    	div_u64(part_stat_read(part, nsecs[which]), NSEC_PER_MSEC)
>>    
>> +#define part_stat_read_d2c_msecs(part, which)				\
>> +	div_u64(part_stat_read(part, d2c_nsecs[which]), NSEC_PER_MSEC)
>> +
>>    #define part_stat_read_accum(part, field)				\
>>    	(part_stat_read(part, field[STAT_READ]) +			\
>>    	 part_stat_read(part, field[STAT_WRITE]) +			\
>>
> 
