Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbeIZKFe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Sep 2018 06:05:34 -0400
Subject: Re: [PATCH] bcache: use REQ_PRIO to indicate bio for metadata
To: Adam Manzanares <Adam.Manzanares@wdc.com>
Cc: "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180925161213.15923-1-colyli@suse.de>
 <8f55a4a3-ee8f-6d2f-0565-7fe5fc224119@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <c5c9c44d-e2ec-36b5-2db6-170707061179@suse.de>
Date: Wed, 26 Sep 2018 11:54:36 +0800
MIME-Version: 1.0
In-Reply-To: <8f55a4a3-ee8f-6d2f-0565-7fe5fc224119@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On 9/26/18 12:32 AM, Adam Manzanares wrote:
>
> On 9/25/18 9:12 AM, Coly Li wrote:
>> In cached_dev_cache_miss() and check_should_bypass(), REQ_META is used
>> to check whether a bio is for metadata request. REQ_META is used for
>> blktrace, the correct REQ_ flag should be REQ_PRIO. This flag means the
>> bio should be prior to other bio, and frequently be used to indicate
>> metadata io in file system code.
>>
>> This patch replaces REQ_META with correct flag REQ_PRIO.
>>
>> CC Adam Manzanares because he explains to me what REQ_PRIO is for.
> Sorry for the confusion, I was talking about using the bi_ioprio field
> to pass ioprio information down to devices that support prioritized
> commands. I haven't used the REQ_PRIO flag in the work that I have done.

Hi Adam,

Aha, I misunderstood you. After 'git blame' I realize REQ_PRIO is 
invented by Christoph Hellwig,

     Add a new REQ_PRIO to let requests preempt others in the cfq I/O 
schedule,
     and lave REQ_META purely for marking requests as metadata in blktrace.

 From log of commit 65299a3b788b ("block: separate priority boosting 
from REQ_META") it seems this patch still uses REQ_PRIO in a correct 
way. And, thank you for clarifying this :-)

Coly Li

>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Adam Manzanares <adam.manzanares@wdc.com>
>> ---
>>    drivers/md/bcache/request.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
>> index 51be355a3309..13d3355a90c0 100644
>> --- a/drivers/md/bcache/request.c
>> +++ b/drivers/md/bcache/request.c
>> @@ -395,7 +395,7 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
>>    	 * unless the read-ahead request is for metadata (eg, for gfs2).
>>    	 */
>>    	if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND) &&
>> -	    !(bio->bi_opf & REQ_META))
>> +	    !(bio->bi_opf & REQ_PRIO))
>>    		goto skip;
>>    
>>    	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
>> @@ -877,7 +877,7 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
>>    	}
>>    
>>    	if (!(bio->bi_opf & REQ_RAHEAD) &&
>> -	    !(bio->bi_opf & REQ_META) &&
>> +	    !(bio->bi_opf & REQ_PRIO) &&
>>    	    s->iop.c->gc_stats.in_use < CUTOFF_CACHE_READA)
>>    		reada = min_t(sector_t, dc->readahead >> 9,
>>    			      get_capacity(bio->bi_disk) - bio_end_sector(bio));
