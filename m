Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1727C77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 22:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjEQWFm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjEQWFj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 18:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D886E9A
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 15:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8992E64B37
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AF9C433EF;
        Wed, 17 May 2023 22:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684361121;
        bh=9Tz/h0QZnnXwCqZCf+i+PnwV6YBTeZ0KAIp3cAmrN+s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=US2gex97FVzFYFeIJ4DH/PRxgo7laem/GIdcCqv5Xm5o3pqEjNLFHLwxqiE1qeZiB
         XD+YV/DhpT0KCsEUKy+15jfoFwgrfCf39v5ulVzHguWh/UbxscN/7zNSm+h/Ns2O7v
         ugbfzXiBLeSKaUua9cNgpwBjV2R7n4FcRaZTMJR2/o07/A1ZfTIno+qGiUQwwOa9Yk
         5R4d2j97XYuyMt3lYPyqQbUx/3NDrKG3PWarYv+WfgLgoiq6jhWx17v5m4jaGE6wHW
         +nseU0mIVs61mQXWftLfJuouE/ULjylMmljw93tmG2QLm6aLVInX0GuPniDDU3FsaM
         V9+EDom4qonBQ==
Message-ID: <b2b0e324-f5f5-0227-1274-ed58e871ce0f@kernel.org>
Date:   Thu, 18 May 2023 07:05:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 10/11] block: mq-deadline: Handle requeued requests
 correctly
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-11-bvanassche@acm.org>
 <bdaa4854-7320-f5ec-ff13-489516149c2a@kernel.org>
 <734963d6-48aa-ffa0-91e7-34a5fb576a7e@acm.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <734963d6-48aa-ffa0-91e7-34a5fb576a7e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 01:28, Bart Van Assche wrote:
> On 5/16/23 18:22, Damien Le Moal wrote:
>> On 5/17/23 07:33, Bart Van Assche wrote:
>>> -/* Return the first request for which blk_rq_pos() >= pos. */
>>> +/*
>>> + * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
>>> + * return the first request after the highest zone start <= @pos.
>>
>> This comment is strange. What about:
>>
>> For zoned devices, return the first request after the start of the zone
>> containing @pos.
> 
> I will make this change.
> 
>>> @@ -818,7 +835,20 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>>   		 * set expire time and add to fifo list
>>>   		 */
>>>   		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
>>> -		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
>>> +		insert_before = &per_prio->fifo_list[data_dir];
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +		/*
>>> +		 * Insert zoned writes such that requests are sorted by
>>> +		 * position per zone.
>>> +		 */
>>> +		if (blk_rq_is_seq_zoned_write(rq)) {
>>> +			struct request *rq2 = deadline_latter_request(rq);
>>> +
>>> +			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
>>> +				insert_before = &rq2->queuelist;
>>> +		}
>>> +#endif
>>> +		list_add_tail(&rq->queuelist, insert_before);
>>
>> Why not:
>>
>> 		insert_before = &per_prio->fifo_list[data_dir];
>> 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) 	
>> 		    && blk_rq_is_seq_zoned_write(rq)) {
>> 			/*
>> 			 * Insert zoned writes such that requests are sorted by
>> 			 * position per zone.
>> 		 	*/
>> 			struct request *rq2 = deadline_latter_request(rq);
>>
>> 			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
>> 				insert_before = &rq2->queuelist;
>> 		}
>> 		list_add_tail(&rq->queuelist, insert_before);
>>
>> to avoid the ugly #ifdef ?
> 
> I think the above code won't build because no blk_rq_zone_no() 
> definition is available if CONFIG_BLK_DEV_ZONED=n. I prefer it this way 
> because my view is that using blk_rq_zone_no() if CONFIG_BLK_DEV_ZONED=n 
> is wrong.

The compiler should drop the entire if block for CONFIG_BLK_DEV_ZONED=n case.
Worth trying to check as the code is much nicer without the #ifdef.
I will test this series today and check.

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

