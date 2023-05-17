Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993A4C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjEQHyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjEQHyD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE93C0A
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4027F637A7
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 07:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13E1C433EF;
        Wed, 17 May 2023 07:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684310034;
        bh=Atqjt76rgKkc3XUpurss4xCb5z8JjwKRufe8I/s1McM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EdHNhHgIMFNW46xMtd/ied8akmiu9lT1bXvM4HIo9lnaYz5J3WP8XW3HciV7UMVNd
         4W4XMOO23YQ99Nx/1hE20JJK80S0oSQpZUSSJggX8NXvlT6btYcchXGnKou6oKJYFp
         rhk1dA7bYAwBDhX+GctsiFTVvvLNfi4+oRpRftlrBiZcllH0g3EH8YOSp0qzrsnZs7
         pJeLUSUVAoikmd1U/Eebqst5krawdwnWZHePtwnfI1N+hW4HcSSGiRax6oXLgy0lSq
         wu+JZQKfKYHcHOtSmUcmLdALT91WfomNFoPbhqlQKVKohdFhZGTtgv8DFmSrg1lVjx
         tvqmTIorQlS8Q==
Message-ID: <70b2d482-6259-0d69-e7c2-8a70f2d3e534@kernel.org>
Date:   Wed, 17 May 2023 16:53:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 11/11] block: mq-deadline: Fix handling of at-head
 zoned writes
To:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-12-bvanassche@acm.org>
 <4a037c7b-ba78-0db1-936b-85e112df00fa@suse.de>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4a037c7b-ba78-0db1-936b-85e112df00fa@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 16:47, Hannes Reinecke wrote:
> On 5/17/23 00:33, Bart Van Assche wrote:
>> Before dispatching a zoned write from the FIFO list, check whether there
>> are any zoned writes in the RB-tree with a lower LBA for the same zone.
>> This patch ensures that zoned writes happen in order even if at_head is
>> set for some writes for a zone and not for others.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   block/mq-deadline.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index 059727fa4b98..67989f8d29a5 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -346,7 +346,7 @@ static struct request *
>>   deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>>   		      enum dd_data_dir data_dir)
>>   {
>> -	struct request *rq;
>> +	struct request *rq, *rb_rq, *next;
>>   	unsigned long flags;
>>   
>>   	if (list_empty(&per_prio->fifo_list[data_dir]))
>> @@ -364,7 +364,12 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>>   	 * zones and these zones are unlocked.
>>   	 */
>>   	spin_lock_irqsave(&dd->zone_lock, flags);
>> -	list_for_each_entry(rq, &per_prio->fifo_list[DD_WRITE], queuelist) {
>> +	list_for_each_entry_safe(rq, next, &per_prio->fifo_list[DD_WRITE],
>> +				 queuelist) {
>> +		/* Check whether a prior request exists for the same zone. */
>> +		rb_rq = deadline_from_pos(per_prio, data_dir, blk_rq_pos(rq));
>> +		if (rb_rq && blk_rq_pos(rb_rq) < blk_rq_pos(rq))
>> +			rq = rb_rq;
>>   		if (blk_req_can_dispatch_to_zone(rq) &&
>>   		    (blk_queue_nonrot(rq->q) ||
>>   		     !deadline_is_seq_write(dd, rq)))
> 
> Similar concern here; we'll have to traverse the entire tree here.
> But if that's of no concern...

Should be fine for HDDs. Not so sure about much faster UFS devices.
And for NVMe ZNS, using a scheduler in itself already halve the max perf you can
get...

> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

