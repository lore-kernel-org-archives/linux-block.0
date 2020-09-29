Return-Path: <SRS0=YBZ7=DG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B57C4346E
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 04:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBFA20BED
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 04:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgI2EIK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 00:08:10 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35311 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgI2EIK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 00:08:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UAS.o2m_1601352487;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UAS.o2m_1601352487)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Sep 2020 12:08:07 +0800
Subject: Re: dm: fix imposition of queue_limits in dm_wq_work() thread
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20200927120435.44118-1-jefflexu@linux.alibaba.com>
 <20200928160322.GA23320@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <2f6f1882-0519-22fc-a11c-645b721ac731@linux.alibaba.com>
Date:   Tue, 29 Sep 2020 12:08:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928160322.GA23320@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I see. Thanks.

On 9/29/20 12:03 AM, Mike Snitzer wrote:
> On Sun, Sep 27 2020 at  8:04am -0400,
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
>> Hi Mike, would you mind further expalin why bio processed by dm_wq_work()
>> always gets a previous ->submit_bio. Considering the following call graph:
>>
>> ->submit_bio, that is, dm_submit_bio
>>    DMF_BLOCK_IO_FOR_SUSPEND set, thus queue_io()
>>
>> then worker thread dm_wq_work()
>>    dm_process_bio  // at this point. the input bio is the original bio
>>                       submitted to dm device
>>
>> Please let me know if I missed something.
>>
>> Thanks.
>> Jeffle
> In general you have a valid point, that blk_queue_split() won't have
> been done for the suspended device case, but blk_queue_split() cannot be
> used if not in ->submit_bio -- IIUC you cannot just do it from a worker
> thread and hope to have proper submission order (depth first) as
> provided by __submit_bio_noacct().  Because this IO will be submitted
> from worker you could have multiple threads allocating from the
> q->bio_split mempool at the same time.
>
> All said, I'm not quite sure how to address this report.  But I'll keep
> at it and see what I can come up with.
>
> Thanks,
> Mike
>
>> Original commit log:
>> dm_process_bio() can be called by dm_wq_work(), and if the currently
>> processing bio is the very beginning bio submitted to the dm device,
>> that is it has not been handled by previous ->submit_bio, then we also
>> need to impose the queue_limits when it's in thread (dm_wq_work()).
>>
>> Fixes: cf9c37865557 ("dm: fix comment in dm_process_bio()")
>> Fixes: 568c73a355e0 ("dm: update dm_process_bio() to split bio if in ->make_request_fn()")
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>   drivers/md/dm.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>> index 6ed05ca65a0f..54471c75ddef 100644
>> --- a/drivers/md/dm.c
>> +++ b/drivers/md/dm.c
>> @@ -1744,17 +1744,13 @@ static blk_qc_t dm_process_bio(struct mapped_device *md,
>>   	}
>>   
>>   	/*
>> -	 * If in ->submit_bio we need to use blk_queue_split(), otherwise
>> -	 * queue_limits for abnormal requests (e.g. discard, writesame, etc)
>> -	 * won't be imposed.
>> -	 * If called from dm_wq_work() for deferred bio processing, bio
>> -	 * was already handled by following code with previous ->submit_bio.
>> +	 * Call blk_queue_split() so that queue_limits for abnormal requests
>> +	 * (e.g. discard, writesame, etc) are ensured to be imposed, while
>> +	 * it's not needed for regular IO, since regular IO will be split by
>> +	 * following __split_and_process_bio.
>>   	 */
>> -	if (current->bio_list) {
>> -		if (is_abnormal_io(bio))
>> -			blk_queue_split(&bio);
>> -		/* regular IO is split by __split_and_process_bio */
>> -	}
>> +	if (is_abnormal_io(bio))
>> +		blk_queue_split(&bio);
>>   
>>   	if (dm_get_md_type(md) == DM_TYPE_NVME_BIO_BASED)
>>   		return __process_bio(md, map, bio, ti);
>> -- 
>> 2.27.0
>>
