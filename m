Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB8C77B70
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 04:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjDQE0w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 00:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQE0v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 00:26:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2A0211B
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 21:26:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B257467373; Mon, 17 Apr 2023 06:26:46 +0200 (CEST)
Date:   Mon, 17 Apr 2023 06:26:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush
 commands
Message-ID: <20230417042646.GA32372@lst.de>
References: <20230416200930.29542-1-hch@lst.de> <20230416200930.29542-8-hch@lst.de> <ac7547c1-214a-7919-a95c-7bf8bc186e48@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7547c1-214a-7919-a95c-7bf8bc186e48@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 16, 2023 at 02:01:30PM -0700, Bart Van Assche wrote:
> On 4/16/23 13:09, Christoph Hellwig wrote:
>> diff --git a/block/blk-flush.c b/block/blk-flush.c
>> index 69e9806f575455..231d3780e74ad1 100644
>> --- a/block/blk-flush.c
>> +++ b/block/blk-flush.c
>> @@ -188,7 +188,9 @@ static void blk_flush_complete_seq(struct request *rq,
>>     	case REQ_FSEQ_DATA:
>>   		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
>> -		blk_mq_add_to_requeue_list(rq, 0);
>> +		spin_lock(&q->requeue_lock);
>> +		list_add_tail(&rq->queuelist, &q->flush_list);
>> +		spin_unlock(&q->requeue_lock);
>>   		blk_mq_kick_requeue_list(q);
>>   		break;
>
> At least the SCSI core can call blk_flush_complete_seq() from interrupt 
> context so I don't think the above code is correct. The call chain is as 
> follows:

All callers of blk_flush_complete_seq already disable interrupts when
taking mq_flush_lock.  No need to disable interrupts again for a nested
lock then.

