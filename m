Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA70C77B7D
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 16:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjEQQ2L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 12:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEQQ2K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 12:28:10 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93348A7D
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 09:28:08 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso1066846a91.0
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 09:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340888; x=1686932888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GmLusIr/rDOIu7yGBpHEWYMEPckcM4Y5+8RdjHQ5IMI=;
        b=Q4TJtg1MdbchWPFFhC10mKl/Ls/nAah4eNLQetorBKare0yvpCQfH57qgg7XhpdIlL
         eYjwzxA03JZnV4aJUlKQ9gcd/mmROwC8JXqRXcXOj0k94cO5BGmI4WY7OyUJis9A+eH0
         WXCE8mn7SNP5El1ax3pX8wKTAc94988E7qmg/lE/LcU6Sb4WxKVQZNMBUCUF6tptI+eT
         NJjukLgGRJkly+EjDv0desKBpsDIz44vU/yWAb0g/f7BDVrXp92/w64TaUNEZ2AZ5RQ/
         hEphf07CUuim68U4PI2VvDUS1JnJmFmUQ2Ogs2lcva/8kZG4W10tSE26CCk+7OrwTejE
         j6RA==
X-Gm-Message-State: AC+VfDx5Q2tMymcU3LGL/Bck1iuR2aWvDi2sV7aezVhRz+gZXvmhDCEz
        CqodXJqhylDZm56cu45uZ0U=
X-Google-Smtp-Source: ACHHUZ41udJcb8DSOsv6b/yp/Y8vOJVUxo400Jb/AGD8nDqoxE7Zwy6iS/XneuqZhK2ixOCGw3Rtbw==
X-Received: by 2002:a17:90a:2f25:b0:253:4220:1bcf with SMTP id s34-20020a17090a2f2500b0025342201bcfmr175977pjd.43.1684340887881;
        Wed, 17 May 2023 09:28:07 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a784300b0024df90a4c58sm1736772pjl.36.2023.05.17.09.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:28:07 -0700 (PDT)
Message-ID: <734963d6-48aa-ffa0-91e7-34a5fb576a7e@acm.org>
Date:   Wed, 17 May 2023 09:28:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 10/11] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-11-bvanassche@acm.org>
 <bdaa4854-7320-f5ec-ff13-489516149c2a@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bdaa4854-7320-f5ec-ff13-489516149c2a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/23 18:22, Damien Le Moal wrote:
> On 5/17/23 07:33, Bart Van Assche wrote:
>> -/* Return the first request for which blk_rq_pos() >= pos. */
>> +/*
>> + * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
>> + * return the first request after the highest zone start <= @pos.
> 
> This comment is strange. What about:
> 
> For zoned devices, return the first request after the start of the zone
> containing @pos.

I will make this change.

>> @@ -818,7 +835,20 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>   		 * set expire time and add to fifo list
>>   		 */
>>   		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
>> -		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
>> +		insert_before = &per_prio->fifo_list[data_dir];
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +		/*
>> +		 * Insert zoned writes such that requests are sorted by
>> +		 * position per zone.
>> +		 */
>> +		if (blk_rq_is_seq_zoned_write(rq)) {
>> +			struct request *rq2 = deadline_latter_request(rq);
>> +
>> +			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
>> +				insert_before = &rq2->queuelist;
>> +		}
>> +#endif
>> +		list_add_tail(&rq->queuelist, insert_before);
> 
> Why not:
> 
> 		insert_before = &per_prio->fifo_list[data_dir];
> 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) 	
> 		    && blk_rq_is_seq_zoned_write(rq)) {
> 			/*
> 			 * Insert zoned writes such that requests are sorted by
> 			 * position per zone.
> 		 	*/
> 			struct request *rq2 = deadline_latter_request(rq);
> 
> 			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
> 				insert_before = &rq2->queuelist;
> 		}
> 		list_add_tail(&rq->queuelist, insert_before);
> 
> to avoid the ugly #ifdef ?

I think the above code won't build because no blk_rq_zone_no() 
definition is available if CONFIG_BLK_DEV_ZONED=n. I prefer it this way 
because my view is that using blk_rq_zone_no() if CONFIG_BLK_DEV_ZONED=n 
is wrong.

Thanks,

Bart.

