Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1AC433FE
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7996140A
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhKQPqF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbhKQPqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 10:46:01 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3379C061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:43:02 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e8so3194856ilu.9
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mnqTP7w38oGEKUf1Lb51PY/pVtAOC/Lpf5PZhcPuTl4=;
        b=nuJGKFlisYiFBrOKbW4VAHMYtwJ5TUqATuZ81MnCgAOsCuC5qBDE7vNp4PdvhlDISS
         y/rk/LQF4Po1cpySBeV7C2em7lvzHQRUSM9zlEgiELPia50/KMGIYbLyvrGg07Gvtv3C
         EC+Tuoa9X5P7IN9GBhiIP4L5mgfnas3UH2U1xqhWvY3WgVuXSsfQRDJEq3/2CvHL3Vt3
         eoNnBWjaXfNlTQX3Z+osIZp4ErnJ28AhDXA1YVs2MOsOeyvnu91BK7byKTxCRrBOgY59
         a8GiIrrdVMHYlVuxrQLVrK53bYzYAkBSfYJSF7RcBAqxUrIMeBQE6WNZy/iwiGwOR4ec
         LB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mnqTP7w38oGEKUf1Lb51PY/pVtAOC/Lpf5PZhcPuTl4=;
        b=OJl1i0eTqjsrl02fzhqYMLDLAt1XqRC1mYnoq6UAtOQI+QmbtQY9pZYaoDbXRdZNhO
         hGR2Kd3KcSg9SjSPVFyvpxmmtIjJKsvorzQqkPMF4A8DxDoFsk3jH1LWoyrCz5x+ufHX
         KK/KFQlz8plOgZv8/vzJIFYdqEwkANrw5O9gj3Ek4aISvoWWvS9q0dlQOwRDCsO9RDke
         UelldplmaoS5ibx82zbcNd8zi2WTmqlCuidZvDH+iI9osr139lkjws8JhCyV31XcD6to
         69ll7Octt18bxU8++QR/suFxqahuxd6EGle1fKxWjYK5OLId+Sb1fSmKtA2V+JiPJyqo
         EVYg==
X-Gm-Message-State: AOAM530h4RHyqaa51BaEKdRSx8Bc1eDf8ohUdbFrF63+IcT8yeLMYptx
        OG2yOORIW0ixQMCg3bRco+jIYA==
X-Google-Smtp-Source: ABdhPJxA7QmO/gJbdK8+O+Ob17VWgWgU22hWM+wN6LtCj7WuRx3AiSm9PxcMf3uKSIBAqVKqVCDOvg==
X-Received: by 2002:a92:d341:: with SMTP id a1mr10809900ilh.59.1637163782335;
        Wed, 17 Nov 2021 07:43:02 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c7sm81849iob.28.2021.11.17.07.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:43:02 -0800 (PST)
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-2-axboe@kernel.dk> <YZS7XPMlvMEP5yfp@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <942f12f8-a334-f90b-481b-ff3b36fb1102@kernel.dk>
Date:   Wed, 17 Nov 2021 08:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZS7XPMlvMEP5yfp@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/17/21 1:20 AM, Ming Lei wrote:
> On Tue, Nov 16, 2021 at 08:38:04PM -0700, Jens Axboe wrote:
>> If we have a list of requests in our plug list, send it to the driver in
>> one go, if possible. The driver must set mq_ops->queue_rqs() to support
>> this, if not the usual one-by-one path is used.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq.c         | 17 +++++++++++++++++
>>  include/linux/blk-mq.h |  8 ++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 9b4e79e2ac1e..005715206b16 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2208,6 +2208,19 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>>  	int queued = 0;
>>  	int errors = 0;
>>  
>> +	/*
>> +	 * Peek first request and see if we have a ->queue_rqs() hook. If we
>> +	 * do, we can dispatch the whole plug list in one go. We already know
>> +	 * at this point that all requests belong to the same queue, caller
>> +	 * must ensure that's the case.
>> +	 */
>> +	rq = rq_list_peek(&plug->mq_list);
>> +	if (rq->q->mq_ops->queue_rqs) {
>> +		rq->q->mq_ops->queue_rqs(&plug->mq_list);
>> +		if (rq_list_empty(plug->mq_list))
>> +			return;
>> +	}
>> +
> 
> Then BLK_MQ_F_TAG_QUEUE_SHARED isn't handled as before for multiple NVMe
> NS.

Can you expand? If we have multiple namespaces in the plug list, we have
multiple queues. There's no direct issue of the list if that's the case.
Or maybe I'm missing what you mean here?

-- 
Jens Axboe

