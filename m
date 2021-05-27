Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EA2C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5D6613BF
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhE0T5K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 15:57:10 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:50798 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbhE0T5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 15:57:09 -0400
Received: by mail-pj1-f46.google.com with SMTP id f8so1167909pjh.0
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 12:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dfX7W3Y+8l7+0BRAFALnwFv8gCfbD7+2OOjOglcHebA=;
        b=TJNB1FC++o61uivvayGHL4Xt+xMS1AgAgkk3U23UM6gaP/5wwEBIlI1zZG5IhbGagV
         3sBXe6cTVfYzD6obQBXboGwyheKvGUx+q8wMfd/BzyAUK8GPok/7x8BwDt8s9n1TNIoT
         tRAII4M7DSeDPpFoCRH7PepfUjr4cKT9U8VEGN4jgjQ2eSha5q5J3gy3tLVSnB4PJCdE
         s5BFB8/PmVXJXinXvIFzC5loDZ3aX870hojeerXU7ZcMGALsExSnyWAydX70S+RistvV
         y7PaSEXyUu+xqkdyG4qthsNbrGOgmM2aoyFPWAx/q8gPqogqYxTVGiHayQoM8+zf+SrS
         nwRA==
X-Gm-Message-State: AOAM531JvDGwc6c2CNn1wtoluAS7ICYDP5yLZIP0izm1QzCB3P6ax7A/
        gHm2OZrbTxL7cBR4lHkX0VY=
X-Google-Smtp-Source: ABdhPJydjOLj3bqLLM7DRFQvKng3EjCN3OWaxm3LyEP9j8jNtQqQT+ySfPjzbtA1GLcOfCW0mTPQ3g==
X-Received: by 2002:a17:902:da8f:b029:f4:11e0:48f with SMTP id j15-20020a170902da8fb02900f411e0048fmr4617222plx.56.1622145336050;
        Thu, 27 May 2021 12:55:36 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id e6sm2411514pjt.1.2021.05.27.12.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 12:55:35 -0700 (PDT)
Subject: Re: [PATCH 7/9] block/mq-deadline: Reserve 25% of tags for
 synchronous requests
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-8-bvanassche@acm.org>
 <32cadabf-1a1c-30a4-f1cd-545e88455c66@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4a193f08-736a-f542-f5ae-382a4bd8650f@acm.org>
Date:   Thu, 27 May 2021 12:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <32cadabf-1a1c-30a4-f1cd-545e88455c66@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 11:54 PM, Hannes Reinecke wrote:
> On 5/27/21 3:01 AM, Bart Van Assche wrote:
>> For interactive workloads it is important that synchronous requests are
>> not delayed. Hence reserve 25% of tags for synchronous requests. This patch
>> still allows asynchronous requests to fill the hardware queues since
>> blk_mq_init_sched() makes sure that the number of scheduler requests is the
>> double of the hardware queue depth. From blk_mq_init_sched():
>>
>> 	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
>> 				   BLKDEV_MAX_RQ);
>
> I wonder if that's a good idea in general ... I'm thinking of poor SATA
> drives which only have 31 tags; setting aside 8 of them for specific
> use-cases does make a difference one would think.
> 
> Do you have testcases for this?

Hi Hannes,

The mq-deadline scheduler is the only scheduler that does not yet set
aside tags for synchronous requests. BFQ and Kyber both implement the
.limit_depth I/O scheduler callback function.

Yes, I have a test case for this, namely SCSI UFS devices. The UFS
device in my test setup supports a single I/O queue and limits the
number of outstanding SCSI commands to 32 (UFSHCD_CAN_QUEUE).

Please note that the limit mentioned above is still above the number of
controller tags. For e.g. UFS q->tag_set->queue_depth == 32 and
attaching an I/O scheduler increases nr_requests from 32 to 64.
Reserving 25% of tags for synchronous requests leaves 3 * 64 / 4 = 48
scheduler tags for asynchronous requests.

Thanks,

Bart.
