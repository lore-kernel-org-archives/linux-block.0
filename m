Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211B0C48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 13:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54922085A
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 13:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UkrW7PyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfFYND6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:03:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39304 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbfFYND6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 09:03:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so16172363ljh.6
        for <linux-block@vger.kernel.org>; Tue, 25 Jun 2019 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ARK2prxRV/r8YkWxnnbALm6Pw85xxSzYq4sr4VIfIYM=;
        b=UkrW7PyHLM+UCjb9yNI25LpeVNz39xUL9IGQsHEnSehYh9reiTPFnLo9YPWm1VgUAc
         0iCj70AO4HDdbWbKWKBvit4BXpFxpcEmJdZgNglmsuoJpiC10Z+jxs47WMxyb1WCErIb
         FiKkEPSVJqpgSegB1A3nSFoIwkdDlBue8EQuXk4W+9hdJ6Xd4dofZmW9UCkfHjJXMrjv
         Rl2mK+FyUsa9j/j3NsMT2RIF/rou5i5LIu3ieZQNbeJR5r4vOIpeVXfdr0Nru4t6hS52
         RqELOSABdrgUuyBHfbFUkYMtJk9+xnk7Nd4WkJxmJMxYM+WQ0wlgaGE7cufyyBvINyWJ
         S9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ARK2prxRV/r8YkWxnnbALm6Pw85xxSzYq4sr4VIfIYM=;
        b=SuncpfyAnrQ7c0rK5fU2Vt5H6gD1gnGSZyO3w9ay7LSPUqsEniS5+ql9wBMo+fU6r7
         QbooWUDmL2bm7RgTbmErhmfEiVwgbB6BuCLfNOEUKa/cSQV7DLdJbwl8E8LE43ecqPJ+
         mokIKtU5s4swSMHJGHzBvrB/gEtCsy2QGQgPsTFT1RztzlTLo5YRTX2vfhfN3hPR9MXx
         Lfu5NOybYoIi7MF6Lw0AO8IcoVQFGvxso1CQ5JQ2+LWhlFzPWFLn8Hjal1TwJrsUU/Vc
         Fy10wefDFX6bEK+wa3DROpfTNviSuKdga2KszpwMGvB2HViy3Ejr6Q43aWHWXvi9I2jf
         qgKg==
X-Gm-Message-State: APjAAAV3BQwxBhujHnEB6CysuKCLzGgD+DTOq4WR0l6u9IOpWcvw3QjG
        JkQztjLgEQGE0uJzO56qIR8qnw==
X-Google-Smtp-Source: APXvYqxHO1flsaGt4P5qYTOlxVD2HC4muB9gcro4b9JaKCo31KcUlf6dWiReFri6tJtYcHieGpJY+w==
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr18452425ljk.158.1561467835635;
        Tue, 25 Jun 2019 06:03:55 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id x22sm1972057lfq.20.2019.06.25.06.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 06:03:54 -0700 (PDT)
Subject: Re: [PATCH 2/4] null_blk: add zone open, close, and finish support
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-3-mb@lightnvm.io>
 <BYAPR04MB5816D471063D970DDCF9AEC7E7E60@BYAPR04MB5816.namprd04.prod.outlook.com>
 <1aa6552c-ecf9-a168-df75-ec8c52ddbea6@lightnvm.io>
 <BYAPR04MB581665C81B89838BC022BF7BE7E30@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f70736f5-4edf-c925-d22a-a3238761da90@lightnvm.io>
Date:   Tue, 25 Jun 2019 15:03:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB581665C81B89838BC022BF7BE7E30@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/25/19 2:36 PM, Damien Le Moal wrote:
> On 2019/06/25 20:06, Matias Bjørling wrote:
>> On 6/22/19 3:02 AM, Damien Le Moal wrote:
>>> On 2019/06/21 22:07, Matias Bjørling wrote:
>>>> From: Ajay Joshi <ajay.joshi@wdc.com>
>>>>
>>>> Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH
>>>> support to allow explicit control of zone states.
>>>>
>>>> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
>>>> Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
>>>> ---
>>>>    drivers/block/null_blk.h       |  4 ++--
>>>>    drivers/block/null_blk_main.c  | 13 ++++++++++---
>>>>    drivers/block/null_blk_zoned.c | 33 ++++++++++++++++++++++++++++++---
>>>>    3 files changed, 42 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
>>>> index 34b22d6523ba..62ef65cb0f3e 100644
>>>> --- a/drivers/block/null_blk.h
>>>> +++ b/drivers/block/null_blk.h
>>>> @@ -93,7 +93,7 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
>>>>    		     gfp_t gfp_mask);
>>>>    void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>>>>    			unsigned int nr_sectors);
>>>> -void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
>>>> +void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector);
>>>>    #else
>>>>    static inline int null_zone_init(struct nullb_device *dev)
>>>>    {
>>>> @@ -111,6 +111,6 @@ static inline void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>>>>    				   unsigned int nr_sectors)
>>>>    {
>>>>    }
>>>> -static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t sector) {}
>>>> +static inline void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector) {}
>>>>    #endif /* CONFIG_BLK_DEV_ZONED */
>>>>    #endif /* __NULL_BLK_H */
>>>> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
>>>> index 447d635c79a2..5058fb980c9c 100644
>>>> --- a/drivers/block/null_blk_main.c
>>>> +++ b/drivers/block/null_blk_main.c
>>>> @@ -1209,10 +1209,17 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
>>>>    			nr_sectors = blk_rq_sectors(cmd->rq);
>>>>    		}
>>>>    
>>>> -		if (op == REQ_OP_WRITE)
>>>> +		switch (op) {
>>>> +		case REQ_OP_WRITE:
>>>>    			null_zone_write(cmd, sector, nr_sectors);
>>>> -		else if (op == REQ_OP_ZONE_RESET)
>>>> -			null_zone_reset(cmd, sector);
>>>> +			break;
>>>> +		case REQ_OP_ZONE_RESET:
>>>> +		case REQ_OP_ZONE_OPEN:
>>>> +		case REQ_OP_ZONE_CLOSE:
>>>> +		case REQ_OP_ZONE_FINISH:
>>>> +			null_zone_mgmt_op(cmd, sector);
>>>> +			break;
>>>> +		}
>>>>    	}
>>>>    out:
>>>>    	/* Complete IO by inline, softirq or timer */
>>>> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
>>>> index fca0c97ff1aa..47d956b2e148 100644
>>>> --- a/drivers/block/null_blk_zoned.c
>>>> +++ b/drivers/block/null_blk_zoned.c
>>>> @@ -121,17 +121,44 @@ void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>>>>    	}
>>>>    }
>>>>    
>>>> -void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
>>>> +void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector)
>>>>    {
>>>>    	struct nullb_device *dev = cmd->nq->dev;
>>>>    	unsigned int zno = null_zone_no(dev, sector);
>>>>    	struct blk_zone *zone = &dev->zones[zno];
>>>> +	enum req_opf op = req_op(cmd->rq);
>>>>    
>>>>    	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
>>>>    		cmd->error = BLK_STS_IOERR;
>>>>    		return;
>>>>    	}
>>>>    
>>>> -	zone->cond = BLK_ZONE_COND_EMPTY;
>>>> -	zone->wp = zone->start;
>>>> +	switch (op) {
>>>> +	case REQ_OP_ZONE_RESET:
>>>> +		zone->cond = BLK_ZONE_COND_EMPTY;
>>>> +		zone->wp = zone->start;
>>>> +		return;
>>>> +	case REQ_OP_ZONE_OPEN:
>>>> +		if (zone->cond == BLK_ZONE_COND_FULL) {
>>>> +			cmd->error = BLK_STS_IOERR;
>>>> +			return;
>>>> +		}
>>>> +		zone->cond = BLK_ZONE_COND_EXP_OPEN;
>>>
>>>
>>> With ZBC, open of a full zone is a "nop". No error. So I would rather have this as:
>>>
>>> 		if (zone->cond != BLK_ZONE_COND_FULL)
>>> 			zone->cond = BLK_ZONE_COND_EXP_OPEN;
>>> 		
>> Is this only ZBC? I can't find a reference to it in ZAC. I think it
>> should fail. One is trying to open a zone that is full, one can't open
>> it again. It's done for this round.
> 
> Page 52/53, section 5.2.6.3.2:
> 
> If the OPEN ALL bit is cleared to zero and the zone specified by the ZONE ID
> field (see 5.2.4.3.3) is in Zone Condition:
> a) EMPTY, IMPLICITLY OPENED, or CLOSED, then the device shall process an
> Explicitly Open Zone function
> (see 4.6.3.4.10) for the zone specified by the ZONE ID field;
> b) EXPLICITLY OPENED or FULL, then the device shall:
> 	A) not change the zone's state; and
> 	B) return successful command completion;
> 
>>>
>>>> +		return;
>>>> +	case REQ_OP_ZONE_CLOSE:
>>>> +		if (zone->cond == BLK_ZONE_COND_FULL) {
>>>> +			cmd->error = BLK_STS_IOERR;
>>>> +			return;
>>>> +		}
>>>> +		zone->cond = BLK_ZONE_COND_CLOSED;
>>>
>>> Sam as for open. Closing a full zone on ZBC is a nop.
>>
>> I think this should cause error.
> 
> See ZAB/ZAC close command description. Same text as above, almost. Not an error.
> It is a nop. ZAC page 48, section 5.2.4.3.2:
> 
> If the CLOSE ALL bit is cleared to zero and the zone specified by the ZONE ID
> field (see 5.2.4.3.3) is in Zone Condition:
> a) IMPLICITLY OPENED, or EXPLICITLY OPENED, then the device shall process a
> Close Zone function
> (see 4.6.3.4.11) for the zone specified by the ZONE ID field;
> b) EMPTY, CLOSED, or FULL, then the device shall:
> 	A) not change the zone's state; and
> 	B) return successful command completion;
> 
>>
>> And the code above would
>>> also set an empty zone to closed. Finally, if the zone is open but nothing was
>>> written to it, it must be returned to empty condition, not closed.
>>
>> Only on a reset event right? In general, if I do a expl. open, close it,
>> it should not go to empty.
> 
> See the zone state machine. It does return to empty from expl open if nothing
> was written, that is, if the WP is still at zone start. This text is in ZAC
> section 4.6.3.4.11 as noted above:
> 
> For the specified zone, the Zone Condition state machine processing of this
> function (e.g., as shown in the ZC2: Implicit_Open state (see 4.6.3.4.3))
> results in the Zone Condition for the specified zone becoming:
> a) EMPTY, if the write pointer indicates the lowest LBA in the zone and Non
> Sequential Write Resources Active is false; or
> b) CLOSED, if the write pointer does not indicate the lowest LBA in the zone or
> Non-Sequential Write Resources Active is true.
> 

Schooled! That is what one gets from having the spec in paper form on 
the table ;)

>>
>> So something
>>> like this is needed.
>>>
>>> 		switch (zone->cond) {
>>> 		case BLK_ZONE_COND_FULL:
>>> 		case BLK_ZONE_COND_EMPTY:
>>> 			break;
>>> 		case BLK_ZONE_COND_EXP_OPEN:
>>> 			if (zone->wp == zone->start) {
>>> 				zone->cond = BLK_ZONE_COND_EMPTY;
>>> 				break;
>>> 			}
>>> 		/* fallthrough */
>>> 		default:
>>> 			zone->cond = BLK_ZONE_COND_CLOSED;
>>> 		}
>>>
>>>> +		return;
>>>> +	case REQ_OP_ZONE_FINISH:
>>>> +		zone->cond = BLK_ZONE_COND_FULL;
>>>> +		zone->wp = zone->start + zone->len;
>>>> +		return;
>>>> +	default:
>>>> +		/* Invalid zone condition */
>>>> +		cmd->error = BLK_STS_IOERR;
>>>> +		return;
>>>> +	}
>>>>    }
>>>>
>>>
>>>
>>
>>
> 
> 

