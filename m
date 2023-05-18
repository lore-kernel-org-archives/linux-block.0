Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFDAC7EE22
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 12:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjERM6N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 08:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjERM6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 08:58:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8711170B
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 05:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 781DE64EBE
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 12:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDBCC433EF;
        Thu, 18 May 2023 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684414689;
        bh=NSVL7ONQMhMeA3zju4zrGWvQARwd+zJhN1xsuTpBQHc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UXxWShIJWl9f+PT6bqccSpskhQzNItd2eXvHmylrBMxpYtv+aIFb6XrH6kBS/5rPz
         xfNdH1gFgDWCi9/UQe32mTTHmfJ1ksLJAITPNXuHC4Xla2n3SK5tRXjWnPDY6VdLlx
         vGXDv7ffjZFdooueTiQsmxQbNHPvbp0LSWnzdmZxuA9tai9K6cTKNlYb90IT6XD+x7
         N63MLGvWrxQ10GPKM5qkIKUbHE6pqMru3laDWnxspJzGUSwj9ec4ezDuEXtZz7I1z/
         8E8V9i1aWucicx+lubomSckrA/prDFksTF2pVXdg+/EEPz1EgHEShsQGPK6cjO3kkd
         yrV/Ygo1YvkRw==
Message-ID: <a0bb43f5-1d24-a928-e38f-3990c26d8895@kernel.org>
Date:   Thu, 18 May 2023 21:58:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 10/11] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-11-bvanassche@acm.org>
 <bdaa4854-7320-f5ec-ff13-489516149c2a@kernel.org>
 <734963d6-48aa-ffa0-91e7-34a5fb576a7e@acm.org>
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

I tried and it does not work. The compiler does not remove the if block for the
!CONFIG_BLK_DEV_ZONED case. Unfortunate.

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

