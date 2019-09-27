Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D89FC4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FBF207FF
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 17:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kaf/QsQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfI0Rcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:32:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39259 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0Rcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 13:32:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so4137925wrj.6
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IsZPSGfhBufla4Hej5fanNeOtnvcgjtOJFtxNDoa/K0=;
        b=kaf/QsQL0dgFgUZsCFSXo11RClVpQK+cZdlvy26o60s9bmC/WP0V6zoppCQzEtnT2h
         E4dcP9kid2/ZPZgm11E6wrLAxJErAPhHTFRy1hh4ded9Sc8MyYQLqqS3FFjrMRcENTVo
         guGKM8CKoEWZl70BamuVObq81WJk9d3rvjaZTOXQhNPIxp8hss40+oW2hRpPYI6d53Mh
         Poclzzf52e11y20BkT29WiGDZTPB+TKHdWQOCEGNXBGoCqUSIPEbAB48uWqCR+eQABJV
         sjSgI10ahLzUKcXdEqPsiXS68MtnUuXB0+dU+8gXKskO3PHD5YfyIwqf/bxlXv5ZY820
         XzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IsZPSGfhBufla4Hej5fanNeOtnvcgjtOJFtxNDoa/K0=;
        b=WY7CZK37/TnPg6iE0wSD3sgh5UmbXEkpU//puGNqO5GGS/aSnif3OimEn5BEQFJ5CN
         fyWFxEy1nT3z1ohA7XZDhQDi6J9zrfTX41nxooGiRe+c3PuXvlbnVGSYt8qIj+OQLiGa
         X623PlT0eYAF9bnjxvubuqF4kTegMwkPNDGPehDqyLgkUcPL4ZVIkon7137ZWLU5dSZ/
         Qa0ytBiSOTILFK7iWgaPe3fydI/aYVJV8qNJFTy+kndAvpCX2SF+MmmOzykcR1InzCyU
         liac6A5l5sTfRYxVxdG8ycrlHBA9BvXkNLCyDTYR2uhUl0hGbrMBAiiIse0LMXhAaRiW
         XqsQ==
X-Gm-Message-State: APjAAAWHvDqug0Q1/om0V/nwWk4tjoGZBkYMYiL0S0stzZqXo1AaSX4N
        DRzuVP4Uoc3fwA3jis7F6ss1/w==
X-Google-Smtp-Source: APXvYqxz0wdSmhsbYuA02fZYlDoKhCu6gQbbabQ2DbtPwrQWvGtZRgs3lmiYoX5BhYGi0IkD4lDZYg==
X-Received: by 2002:adf:c7cf:: with SMTP id y15mr4004680wrg.54.1569605555211;
        Fri, 27 Sep 2019 10:32:35 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id p85sm12637173wme.23.2019.09.27.10.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 10:32:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: respect io scheduler
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Dave Chinner <dchinner@redhat.com>
References: <20190927072431.23901-1-ming.lei@redhat.com>
 <20190927072431.23901-2-ming.lei@redhat.com>
 <BYAPR04MB58166A77C55B3B8667B37554E7810@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac7a494c-9d83-6cc1-ac39-3cdd258ddb68@kernel.dk>
Date:   Fri, 27 Sep 2019 19:32:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB58166A77C55B3B8667B37554E7810@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/19 7:25 PM, Damien Le Moal wrote:
> On 2019/09/27 0:25, Ming Lei wrote:
>> Now in case of real MQ, io scheduler may be bypassed, and not only this
>> way may hurt performance for some slow MQ device, but also break zoned
>> device which depends on mq-deadline for respecting the write order in
>> one zone.
>>
>> So don't bypass io scheduler if we have one setup.
>>
>> This patch can double sequential write performance basically on MQ
>> scsi_debug when mq-deadline is applied.
>>
>> Cc: Bart Van Assche <bvanassche@acm.org>
>> Cc: Hannes Reinecke <hare@suse.com>
>> Cc: Damien Le Moal <damien.lemoal@wdc.com>
>> Cc: Dave Chinner <dchinner@redhat.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>   block/blk-mq.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 20a49be536b5..d7aed6518e62 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2003,6 +2003,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>   		}
>>   
>>   		blk_add_rq_to_plug(plug, rq);
>> +	} else if (q->elevator) {
>> +		blk_mq_sched_insert_request(rq, false, true, true);>  	} else if (plug && !blk_queue_nomerges(q)) {
>>   		/*
>>   		 * We do limited plugging. If the bio can be merged, do that.
>> @@ -2026,8 +2028,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>   			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
>>   					&cookie);
>>   		}
>> -	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
>> -			!data.hctx->dispatch_busy)) {
>> +	} else if ((q->nr_hw_queues > 1 && is_sync) ||
>> +			!data.hctx->dispatch_busy) {
>>   		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
>>   	} else {
>>   		blk_mq_sched_insert_request(rq, false, true, true);
>>
> 
> I think this patch should have a Cc: stable@vger.kernel.org
> This fixes a problem existing since we added deadline zone write-locking with
> commit 5700f69178e9 ("mq-deadline: Introduce zone locking support").

I'd rather not mark it for stable until it's been in the kernel for some
weeks at least, since we are potentially dealing with behavioral change
for everyone. We've been burnt by stuff like this in the past.

That said, this patch could be a candidate. Let's revisit in a few weeks.

-- 
Jens Axboe

