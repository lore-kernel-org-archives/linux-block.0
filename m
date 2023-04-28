Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8092FC77B61
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 17:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344447AbjD1RD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjD1RDz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 13:03:55 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF7C4EE2
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 10:03:47 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1a92369761cso1474175ad.3
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 10:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682701427; x=1685293427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLXUN3xvCdQPCinnElkanhq2eGKK0eBW8l6b0HgkA7k=;
        b=j5SRjoeaEDspRs/o9X5fh96kYkJaItOQfBqiUU5dtfI42StPMXgiLGADmWFLc1w8Fe
         2mLNPJEfpqKb+KHYjwAXHzAmaTgQRDfb91H9/qwMVjqQPSGUOisIofrZ4E0OBvZFNuds
         oxgyXHyjp2bAPXJPfAkrPOIVMFgPbKxnz20SCbY0J5Dao735LkNyKnIGoR8MX6fXMS6N
         PPGByDnSfSar/vM16NqAympuVPEQ15ydHIdrgFlOCpZGjqwcI2xYt4MSw9UckKi25G5q
         zNXyrNRHasR4YOdb2p7fXh43t6+WdaC/9Aflf4tah2syGxJjBZfS10iR+DAvhXrzWf2z
         GUsw==
X-Gm-Message-State: AC+VfDzXQP526EZYKv9A7u4UrDti/O7yxXdzGz3Yn4deSR8c9M/JMXdv
        A4KXBho6gBLy2Sm1e/w6XhxRiSEl3wc=
X-Google-Smtp-Source: ACHHUZ5MjfMwabcz17TDGNyOd54Y994V5BWKUzcLhUoyFkPldUV9tuppEqoORDQx1PmqTw2+Dq0AbQ==
X-Received: by 2002:a17:902:e013:b0:1a6:9e53:950e with SMTP id o19-20020a170902e01300b001a69e53950emr4958336plo.41.1682701426559;
        Fri, 28 Apr 2023 10:03:46 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001a6dc4a98f9sm13523359plz.195.2023.04.28.10.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 10:03:46 -0700 (PDT)
Message-ID: <05a7d0cb-44c9-cb2f-12c2-957123e031d5@acm.org>
Date:   Fri, 28 Apr 2023 10:03:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 8/9] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230424203329.2369688-1-bvanassche@acm.org>
 <20230424203329.2369688-9-bvanassche@acm.org> <20230428055443.GI8549@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230428055443.GI8549@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/23 22:54, Christoph Hellwig wrote:
> On Mon, Apr 24, 2023 at 01:33:28PM -0700, Bart Van Assche wrote:
>> @@ -821,7 +833,16 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>   		 * set expire time and add to fifo list
>>   		 */
>>   		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
>> -		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
>> +		insert_before = &per_prio->fifo_list[data_dir];
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +		if (blk_rq_is_seq_zoned_write(rq)) {
>> +			struct request *rq2 = deadline_latter_request(rq);
>> +
>> +			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
>> +				insert_before = &rq2->queuelist;
>> +		}
>> +#endif
> 
> Why does this need an ifdef?

Because the blk_rq_zone_no() definition is surrounded with #ifdef 
CONFIG_BLK_DEV_ZONED / #endif. Without the #ifdef the above code would 
trigger a compilation error with CONFIG_BLK_DEV_ZONED=n. I have 
considered to add a definition of blk_rq_zone_no() for 
CONFIG_BLK_DEV_ZONED=n. I prefer not to do this because I think it's 
better to cause a compiler error if blk_rq_zone_no() is used in code 
that is also used for the CONFIG_BLK_DEV_ZONED=n case.

> Also can you please always add comments for these special cases?

Will do.

Thanks,

Bart.

