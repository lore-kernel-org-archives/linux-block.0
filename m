Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479FC77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 22:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEQWPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjEQWPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 18:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7EA35A9
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 15:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC95264B4C
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 22:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CBDC433EF;
        Wed, 17 May 2023 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684361704;
        bh=XYAg82ZallMK4BfwV5q/+LTZFKkXsTUCpOEkAjOKnL8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iwZgGKg1COqm6GhME0Vt996b6P2TM5qI6vJdHIfdjoy6XCXtxQ+opmTEYWJjOGwUL
         aw8971ykMvvHIUhyMosB4D0Sr5m3fSJCaiu0wvT9LokSllucwaN38aPkfxoTMTfpEN
         OXuW2073avv9c//XP3+gJAdQggavik5DiqC3GFAxpqrYNtyiMzerzqyvh/CiGNl2T8
         gJnkv4fsaH8YO4+nAyibmGZohHQPoFqunQzxFB4lDIgRZ1NKJJxkOcXK++wLSefyYZ
         vFolHMqxgUDTYhmcRbfflPYRHVzCNxo2gkGX+gdTwFmhiaQu6tIPQbLGiTrJLPWMqo
         H4bluTbTg4T7g==
Message-ID: <5829b5a0-d411-9485-2fa0-7c723377abf1@kernel.org>
Date:   Thu, 18 May 2023 07:15:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 07/11] block: mq-deadline: Improve
 deadline_skip_seq_writes()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-8-bvanassche@acm.org>
 <37120c5c-120f-3ff3-fcbf-1a52f389fe3e@kernel.org>
 <06e87316-4b22-b275-4223-775192e5ccac@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <06e87316-4b22-b275-4223-775192e5ccac@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 01:30, Bart Van Assche wrote:
> On 5/16/23 18:06, Damien Le Moal wrote:
>> On 5/17/23 07:33, Bart Van Assche wrote:
>>> Make deadline_skip_seq_writes() do what its name suggests, namely to
>>> skip sequential writes.
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Cc: Ming Lei <ming.lei@redhat.com>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>   block/mq-deadline.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>>> index 6276afede9cd..dbc0feca963e 100644
>>> --- a/block/mq-deadline.c
>>> +++ b/block/mq-deadline.c
>>> @@ -308,7 +308,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>>>   	do {
>>>   		pos += blk_rq_sectors(rq);
>>>   		rq = deadline_latter_request(rq);
>>> -	} while (rq && blk_rq_pos(rq) == pos);
>>> +	} while (rq && blk_rq_pos(rq) == pos && blk_rq_is_seq_zoned_write(rq));
>>
>> No ! The "seq write" skip here is to skip writes that are contiguous/sequential
>> to ensure that we keep issuing contiguous/sequential writes belonging to
>> different zones, regardless of the target zone type.
>>
>> So drop this change please.
> 
> Hi Damien,
> 
> I'm fine with dropping this patch. I came up with this patch because it 
> surprised me to see that deadline_skip_seq_writes() does not check the 
> type of the requests that it is skipping. If e.g. a WRITE is followed by 
> two contiguous READs, all three requests are skipped. Is this intentional?

Hmmm... mq-deadline is not supposed to mix up reads and writes in the same
scheduling batch, and there is one sort_list (rbtree) per data direction. So we
should not be seeing different data directions in this loop, no ?

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

