Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE32C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 16:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDJQfM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJQfL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 12:35:11 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74792189
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 09:35:10 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id c3so5830479pjg.1
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 09:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681144510; x=1683736510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8VNoDEZcbIFzAr9aW+pwuaMxBXHSwyYFPVrsWRYLAI=;
        b=17K8Xr7PDAaCdpddqhSyXSLogN7dx0PDQAAJn84WUuXRw68zLOiOA9nKP3IBhaSwUs
         WQWxzrLZVSO/e4w6DCUUC9KigeVuUBOdJkSiFI33N6eXx18Baz8NPsj1uw6XVPFJHcCF
         aoPjKo+X5E8BoiFuHfzRNGehRCaAh1hfYXGsFuJ6diGPWs8vsJ5lGowmBuKVC4LCQkeU
         2K4gAeKOwDt8TVVnvaj58dCrjyDdAuvvsyNAUqSmWl3CiHz6qhUE7sG9cpC/XBKmKsSn
         LonPzFxnXVz0WPy8OfRtXJvfvqbGFHcja+qoPZvSUUXDSyMylCAFHv3Smb9XA2SUe2d2
         uMVA==
X-Gm-Message-State: AAQBX9e4BjDNV7zxfY5t6hooKJcSDtp2cXUscs2+omDgvKhyHAtc8mzf
        mjTftwWM/y8rBkhAw3OKydo=
X-Google-Smtp-Source: AKy350aioISGmxAkgxkiYo2QjDyVW58eJ7+VXte7yY8/XZ7Cf101emWI6ejTNbhj1/J0QvtXpsKVhA==
X-Received: by 2002:a17:902:e851:b0:1a6:4e86:6ca1 with SMTP id t17-20020a170902e85100b001a64e866ca1mr1426346plg.9.1681144509828;
        Mon, 10 Apr 2023 09:35:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:11fd:f446:f156:c8? ([2620:15c:211:201:11fd:f446:f156:c8])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b00199193e5ea1sm8042261plb.61.2023.04.10.09.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 09:35:09 -0700 (PDT)
Message-ID: <d562a3b0-c87e-c9ba-c153-80caa7cbb1d9@acm.org>
Date:   Mon, 10 Apr 2023 09:35:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 01/12] block: Send zoned writes to the I/O scheduler
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-2-bvanassche@acm.org>
 <a5483be5-7d0e-7a1d-dd74-00b69ba8bf25@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a5483be5-7d0e-7a1d-dd74-00b69ba8bf25@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 00:42, Damien Le Moal wrote:
> On 4/8/23 08:58, Bart Van Assche wrote:
>> Send zoned writes inserted by the device mapper to the I/O scheduler.
>> This prevents that zoned writes get reordered if a device mapper driver
>> has been stacked on top of a driver for a zoned block device.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: Mike Snitzer <snitzer@kernel.org>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   block/blk-mq.c | 16 +++++++++++++---
>>   block/blk.h    | 19 +++++++++++++++++++
>>   2 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index db93b1a71157..fefc9a728e0e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -3008,9 +3008,19 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
>>   	blk_account_io_start(rq);
>>   
>>   	/*
>> -	 * Since we have a scheduler attached on the top device,
>> -	 * bypass a potential scheduler on the bottom device for
>> -	 * insert.
>> +	 * Send zoned writes to the I/O scheduler if an I/O scheduler has been
>> +	 * attached.
>> +	 */
>> +	if (q->elevator && blk_rq_is_seq_zoned_write(rq)) {
>> +		blk_mq_sched_insert_request(rq, /*at_head=*/false,
>> +					    /*run_queue=*/true,
>> +					    /*async=*/false);
>> +		return BLK_STS_OK;
>> +	}
> 
> Looks OK to me, but as I understand it, this function is used only for request
> based device mapper, none of which currently support zoned block devices if I a
> not mistaken. So is this change really necessary ?

Hi Damien,

Probably not. I will double check whether this patch can be dropped.

Thanks,

Bart.

