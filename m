Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1DEC77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 17:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDJRbg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjDJRbf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 13:31:35 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847591BC7
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 10:31:34 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 90-20020a17090a0fe300b0023b4bcf0727so5132782pjz.0
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 10:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681147894; x=1683739894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgDyEewDFMR14YTWbAEaZaM0sRLURcJE5V9cI6RCObc=;
        b=XVb28P/JPCWI+GKOUdAZ8kc1XG3ooRB7cUGpaNgyVdIlfGiEh8RUD2Kq0dVVtvHXWr
         TNRDAiyqo3OI31Utfwx9jriOzvTX+CCAv/L+L5KzW9pEDimMm4Z3sSFKAQuT5u+ULnUP
         eZRmFjK44iZ92TwrE1NyDMCB52rsKNVxOVECz6mEMrmS5Z1JwV2H63yMVakrTjpS7C+Y
         YindqDabiz2meqz2UPyH+3yuFil9KppdKuWSVb6JyoSiRCojC1t7HfwpcUTilSKzy28a
         ebUuqWeLwvMGFa0z42/Zax/eTNsaROPB3dL8oVZyvBC7IgDQR/QEIyEXeh4sUCjlvQ/Y
         M05A==
X-Gm-Message-State: AAQBX9c5d8hOAtWfFKET+4LznsTj6XP4t9pHlMmWEq5LPBVJzT3bo9oS
        YSJc5H/Wj1MYblmKwr9D+tc=
X-Google-Smtp-Source: AKy350ZxeKTuB/7cWrH5xKdPMF1sftcuybSizYA5ZseuVJW63QXqHSph4b1/SQgqFFbpHeAxPEjnfw==
X-Received: by 2002:a17:90b:1bcd:b0:23f:78d6:6ac5 with SMTP id oa13-20020a17090b1bcd00b0023f78d66ac5mr14642643pjb.19.1681147893882;
        Mon, 10 Apr 2023 10:31:33 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:11fd:f446:f156:c8? ([2620:15c:211:201:11fd:f446:f156:c8])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090ad15400b002469a865810sm2811908pjw.28.2023.04.10.10.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:31:33 -0700 (PDT)
Message-ID: <985e1cff-5a13-f7d5-1282-c30f339c0aa1@acm.org>
Date:   Mon, 10 Apr 2023 10:31:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 12/12] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-13-bvanassche@acm.org>
 <c9b29094-50f9-3dac-647e-b7b5b7cc729d@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c9b29094-50f9-3dac-647e-b7b5b7cc729d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 01:32, Damien Le Moal wrote:
> On 4/8/23 08:58, Bart Van Assche wrote:
>> @@ -834,7 +847,18 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>   		 * set expire time and add to fifo list
>>   		 */
>>   		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
>> -		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
>> +		insert_before = &per_prio->fifo_list[data_dir];
>> +		if (blk_rq_is_seq_zoned_write(rq)) {
>> +			const unsigned int zno = blk_rq_zone_no(rq);
>> +			struct request *rq2 = rq;
>> +
>> +			while ((rq2 = deadline_earlier_request(rq2)) &&
>> +			       blk_rq_zone_no(rq2) == zno &&
>> +			       blk_rq_pos(rq2) > blk_rq_pos(rq)) {
>> +				insert_before = &rq2->queuelist;
>> +			}
>> +		}
>> +		list_add_tail(&rq->queuelist, insert_before);
> 
> This seems incorrect: the fifo list is ordered in arrival time, so always
> queuing at the tail is the right thing to do. What I think you want to do here
> is when we choose the next request to be the oldest (to implement aging), you
> want to get the first request for the target zone of that oldest request. But
> why do that on insert ? This should be in the dispatch code, coded in
> deadline_fifo_request(), no ?

Hi Damien,

If the dispatch code would have to look up the zoned write with the 
lowest LBA then it would have to iterate over the entire FIFO list. The 
above loop will on average perform much less work. If no requeuing 
happens, the expression 'blk_rq_pos(rq2) > blk_rq_pos(rq)' will evaluate 
to false the first time it is evaluated and the loop body will never be 
executed.

Thanks,

Bart.


