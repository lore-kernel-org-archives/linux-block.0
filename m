Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA9FC77B7C
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 17:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDTRAg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjDTRAd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 13:00:33 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605A52D78
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 10:00:11 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-63b8b19901fso1609385b3a.3
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 10:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682010011; x=1684602011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nk/aXnAftkLsiVI0cOrdaWp9cVF6Sn9pwMOIZ62LuGA=;
        b=HZa2y2VB60zbpNexgxZSY2npuiLAvnUTFHnuYMzHnKTq/RRG6MjZ9PKL5GZ26Xa4MW
         yOs4FZKKB1q0as1PObMQx+hpdRpNQq9MC4ecPkpFzz/VgMCN+rHm9vEMHRg8Cdnc+s+p
         xIi8jQo0KeOlNbNR73AiGLd2u7Fv1SnzHLu6y+QVt2NGq5CA8VB6erGpYvXWV1c7h2VT
         woQoW1pbC0RlZtmy8enLZpMUITVF3oyn+FxxrP/4y8EQpuqEB1d+0jTvq2yWNTaRkgFX
         jUmMblNwFQoEik6XjRJZSANn+UuVB9YHVDxM2jEr6y1LQlku1WPS/NNwyThjJ+mwzCR0
         y8dw==
X-Gm-Message-State: AAQBX9eiChNUvizGv81tt70gdBVaP66NMBxLLEWiRuyLCftnfkne0Rue
        Wi79z45OydOlvEiZr9izZhQ=
X-Google-Smtp-Source: AKy350bQIWQckimXF8G5x0zBjONUWOv5LnnvU0bCcdayqM4GSpbSKyrdg3tO3BYQGiAu3Lgv6heMwA==
X-Received: by 2002:a05:6a20:e186:b0:f0:ab4c:c04d with SMTP id ks6-20020a056a20e18600b000f0ab4cc04dmr2574745pzb.40.1682010010611;
        Thu, 20 Apr 2023 10:00:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:216b:53b9:f55c:cf92? ([2620:15c:211:201:216b:53b9:f55c:cf92])
        by smtp.gmail.com with ESMTPSA id k17-20020a63f011000000b0051ba16c35cfsm1350895pgh.29.2023.04.20.10.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:00:10 -0700 (PDT)
Message-ID: <05e3962f-73c8-a721-a457-605243b64e66@acm.org>
Date:   Thu, 20 Apr 2023 10:00:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 06/11] block: mq-deadline: Disable head insertion for
 zoned writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-7-bvanassche@acm.org> <20230419043044.GC25329@lst.de>
 <e6adbe81-c45f-9801-bee6-a5a7ccad8945@acm.org> <20230420050619.GC4371@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230420050619.GC4371@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/23 22:06, Christoph Hellwig wrote:
> The problem is that we now run into different handling depending
> on which kind of write is coming in.  So we need to find a policy
> that works for everyone.  Remember that as of the current for-6.4/block
> branch the only at_head inservations remaining are:
> 
>   - blk_execute* for passthrough requests that never enter the I/O
>     scheduler
>   - REQ_OP_FLUSH that never enter the I/O scheduler
>   - requeues using blk_mq_requeue_request
>   - processing of the actual writes in the flush state machine
> 
> with the last one going away in my RFC series.
> 
> So if we come to the conclusion that requeues from the driver do not
> actually need at_head insertations to avoid starvation or similar
> we should just remove at_head insertations from the I/O scheduler.
> If we can't do that, we need to handle them for zoned writes as well.

Hi Christoph,

I'm fine with not inserting requeued requests at the head of the queue. 
Inserting requeued requests at the head of the queue only preserves the 
original submission order if a single request is requeued. If multiple 
requests are requeued inserting at the head of the queue will cause 
inversion of the order of the requeued requests.

This implies that the I/O scheduler or disk controller (if no I/O 
scheduler is configured) will become responsible for optimizing the 
request order if requeuing happens.

Bart.
