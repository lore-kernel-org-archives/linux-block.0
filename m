Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C3EC433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Dec 2021 20:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhLDUQm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Dec 2021 15:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhLDUQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Dec 2021 15:16:42 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC9C061751
        for <linux-block@vger.kernel.org>; Sat,  4 Dec 2021 12:13:16 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x6so8079444iol.13
        for <linux-block@vger.kernel.org>; Sat, 04 Dec 2021 12:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s/GPDl5dRrWA47RNMSHEzffScc5qkUhcV7AvYge1sPc=;
        b=G3FxP8oiFM+JTo6Qa55u922+wSekzBkJ64YQ2t/l9vHROcVSBw+b6djj3goI49cUyq
         u1Q01cmWtv2Zmc7yZiQ8sq+Dq1alLnFYlwiLiJSSBoJAHKmmfWEIz/b6bBBAoLtEuFAr
         zQnx9Wgh8/2n7SL4nQjpvMIWu5U9Wjb//17qyZaMVLyhLD6FetQjLOQ2ssWm/bTDPDA6
         CQ6XkU3GtSFmq290A5iJ0jDWEXOnVEV9qikutXxzHlXSqMwO6S9PmYEU8sti4ej0Wp+I
         fvcZOI0OMwjwKF7q6TRsuiE732+obg8SBixAW3Yp1us+dCf606YwARLhhi5soDphXM+S
         5wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/GPDl5dRrWA47RNMSHEzffScc5qkUhcV7AvYge1sPc=;
        b=e+d4JjZ6t1rtq3Kydr6Ao+yJYce2q/dwXrTdY/pA2dSFFmNibuyEH+RN4X7N9Q6vRp
         EmEHKLBzWw9gvSAFEDwymHQo0VN9Pi06FVleFI/WTwkRRFXc8iDkUHLuSD2g3+xvip/K
         ZhT+E22KUakoXUQVo3WuTXIyaTd2IJFPP5pnCsodRwPTuWTccd+jFSe7su0LG1YYvRHH
         JfIi7tnrVzv1wgTGKO62zbeI0qKvWlAp5uOkfzquV9c0GjMvtIJrvvXnrWDkyu7KolZv
         bbV1gKgedMdZCmikRbVzQPUOU09N6L4z5ZNhvwXELAK686x/7nFsUNBSyqA0w7weRs5u
         zelA==
X-Gm-Message-State: AOAM533OZbY+SKeYbRbFl6k5cerRP5BSHZZKD43N/74gOls9xG0rWVhO
        OJQ+EMaupRQCrE3n6vU0w8LA8Q==
X-Google-Smtp-Source: ABdhPJyGEZq9vp3aRUXDEfeq4qqWnFtEipW97YjBkLTA4PqZxz+D/nAsbDcOAfjOyC8tBxebnh5hcQ==
X-Received: by 2002:a6b:8d12:: with SMTP id p18mr27141290iod.145.1638648795800;
        Sat, 04 Dec 2021 12:13:15 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id r18sm3531328ilh.59.2021.12.04.12.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 12:13:15 -0800 (PST)
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
To:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-2-axboe@kernel.dk>
 <2a3fb650-4b6e-9eb1-aa6b-318236717ccf@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad621fff-2338-fad8-48cb-dfdbd5ccc72a@kernel.dk>
Date:   Sat, 4 Dec 2021 13:13:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2a3fb650-4b6e-9eb1-aa6b-318236717ccf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/21 3:43 AM, Hannes Reinecke wrote:
> On 12/3/21 10:45 PM, Jens Axboe wrote:
>> If we have a list of requests in our plug list, send it to the driver in
>> one go, if possible. The driver must set mq_ops->queue_rqs() to support
>> this, if not the usual one-by-one path is used.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   block/blk-mq.c         | 24 +++++++++++++++++++++---
>>   include/linux/blk-mq.h |  8 ++++++++
>>   2 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 22ec21aa0c22..9ac9174a2ba4 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2513,6 +2513,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>>   {
>>   	struct blk_mq_hw_ctx *this_hctx;
>>   	struct blk_mq_ctx *this_ctx;
>> +	struct request *rq;
>>   	unsigned int depth;
>>   	LIST_HEAD(list);
>>   
>> @@ -2521,7 +2522,26 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>>   	plug->rq_count = 0;
>>   
>>   	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
>> -		blk_mq_run_dispatch_ops(plug->mq_list->q,
>> +		struct request_queue *q;
>> +
>> +		rq = plug->mq_list;
>> +		q = rq->q;
>> +
>> +		/*
>> +		 * Peek first request and see if we have a ->queue_rqs() hook.
>> +		 * If we do, we can dispatch the whole plug list in one go. We
>> +		 * already know at this point that all requests belong to the
>> +		 * same queue, caller must ensure that's the case.
>> +		 */
>> +		if (q->mq_ops->queue_rqs &&
>> +		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> 
> What is the dependency on shared tags here?
>  From what I've seen it's just about submitting requests; the only 
> difference to shared tags is the way the tags are allocated.
> Care to explain?

For shared tags, we need to actively increment the use count per
request. This path doesn't do that, so it's disabled for now. It could
be done, but then it'd have to be in the caller, so I'd rather leave it
for a future optimization if anyone cares enough about this for shared
tags.

I can add a comment about it if that helps.

-- 
Jens Axboe

