Return-Path: <SRS0=yOtT=PF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3851FC43387
	for <linux-block@archiver.kernel.org>; Fri, 28 Dec 2018 12:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B67E20873
	for <linux-block@archiver.kernel.org>; Fri, 28 Dec 2018 12:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeL1Mrx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:47:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:51040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbeL1Mrx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Dec 2018 07:47:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01207AE1F;
        Fri, 28 Dec 2018 12:47:50 +0000 (UTC)
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
To:     Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20181128021959.GG11128@ming.t460p>
 <20181128070010.GA20369@lst.de> <20181128100659.GA16495@ming.t460p>
 <20181128100848.GA23567@lst.de> <20181128154927.GE6401@localhost.localdomain>
 <ddc31c4c-5d5f-c5ca-67bf-33acdd03ed54@kernel.dk>
 <20181128162655.GF6401@localhost.localdomain>
 <20181128223146.GH6401@localhost.localdomain>
 <20181128233629.GA8332@localhost.localdomain> <20181129171159.GA28238@lst.de>
 <20181129172034.GD8332@localhost.localdomain>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <70460671-289e-b6b0-fc3c-9bfdad00bc53@suse.de>
Date:   Fri, 28 Dec 2018 13:47:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181129172034.GD8332@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 6:20 PM, Keith Busch wrote:
> On Thu, Nov 29, 2018 at 06:11:59PM +0100, Christoph Hellwig wrote:
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index a82830f39933..d0ef540711c7 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -647,7 +647,7 @@ EXPORT_SYMBOL(blk_mq_complete_request);
>>>   
>>>   int blk_mq_request_started(struct request *rq)
>>>   {
>>> -	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
>>> +	return blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT;
>>>   }
>>>   EXPORT_SYMBOL_GPL(blk_mq_request_started);
>>
>> Independ of this series this change looks like the right thing to do.
>> But this whole area is a mine field, so separate testing would be
>> very helpful.
>>
>> I also wonder why we even bother with the above helper, a direct
>> state comparism seems a lot more obvious to the reader.
> 
> I think it's just because blk_mq_rq_state() is a private interface. The
> enum mq_rq_state is defined under include/linux/, so it looks okay to
> make getting the state public too.
>   
>> Last but not least the blk_mq_request_started check in nbd
>> should probably be lifted into blk_mq_tag_to_rq while we're at it..
>>
>> As for the nvme issue - it seems to me like we need to decouple the
>> nvme loop frontend request from the target backend request.  In case
>> of a timeout/reset we'll complete struct request like all other nvme
>> transport drivers, but we leave the backend target state around, which
>> will be freed when it completes (or leaks when the completion is lost).
> 
> I don't think nvme's loop target should do anything to help a command
> complete. It shouldn't even implement a timeout for the same reason
> no stacking block driver implements these. If a request is stuck, the
> lowest level is the only driver that should have the responsibility to
> make it unstuck.
> 
Not quite.
You still need to be able to reset the controller, which you can't if 
you have to wait for the lowest level.

Cheers,

Hannes
