Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F4CC77B7C
	for <linux-block@archiver.kernel.org>; Sun, 21 May 2023 14:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjEUOGg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUOGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 10:06:36 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2DAA
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 07:06:32 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ae6dce19f7so24616745ad.3
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 07:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684677992; x=1687269992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdGHhRK5RXlAQpDJqGY3xF/EgX6bGTS13kZGM+DdR6I=;
        b=jbwmybhFuvOx4Fqz/wsd8a3+99meTpURI9/f/+b5Yl0El6yBRZA53cLotfUNyZju/Q
         igqJPm2TKOQUqdpzRi2vnOP4qkR/FMB5eEknpOLjUO0Uh9u6pKajxdD8FexOhP3vyOY8
         +rn081gt2XHh0/D+j4tuIPLpeV86rBB8SdDl1jTjcEaFAr+ySVTd5NApwaV24DS9cGTb
         0036HsAT6qIvsZhvTdnqthKQRfGuFTT552Bvu+HTcsADV5G0w5tz2QXGG2ZSlqBiX4V6
         GuKSfw6zdYucKr1Hvs3IKLJwgHRF1I4hMe2noVarWIk3l5lMUBft8PQkj2rMUVKOu2a+
         EmAA==
X-Gm-Message-State: AC+VfDxa8rVC6X3KojGzGzvHagYcw9aD/v9hD8MA3ET4oY7Qq9VPFE6x
        oZHMQo5I52jGBX0rJXnPG5ZCRlLB0Tc=
X-Google-Smtp-Source: ACHHUZ4YG4kliQPPsEUKhWvpHhQ+JZpIPsrGC5SZLtX8UnTIW8AgTXhzPoBgDIg7tNfTmUHJVxmsQw==
X-Received: by 2002:a17:903:2444:b0:1aa:f203:781c with SMTP id l4-20020a170903244400b001aaf203781cmr10458233pls.44.1684677991459;
        Sun, 21 May 2023 07:06:31 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001ac7f583f72sm2976838plb.209.2023.05.21.07.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 07:06:30 -0700 (PDT)
Message-ID: <6d9190c1-de31-cca4-e91c-5aa7f61628ac@acm.org>
Date:   Sun, 21 May 2023 07:06:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush
 commands
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
References: <20230519044050.107790-1-hch@lst.de>
 <20230519044050.107790-8-hch@lst.de>
 <36dbbde0-e7f4-c1bd-8015-6265ac812786@acm.org>
 <20230520045644.GB32182@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230520045644.GB32182@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/23 21:56, Christoph Hellwig wrote:
> On Fri, May 19, 2023 at 12:55:45PM -0700, Bart Van Assche wrote:
>>>    	LIST_HEAD(rq_list);
>>> -	struct request *rq, *next;
>>> +	LIST_HEAD(flush_list);
>>> +	struct request *rq;
>>>      	spin_lock_irq(&q->requeue_lock);
>>>    	list_splice_init(&q->requeue_list, &rq_list);
>>> +	list_splice_init(&q->flush_list, &flush_list);
>>>    	spin_unlock_irq(&q->requeue_lock);
>>
>> "rq_list" stands for "request_list". That name is now confusing since this patch
>> add a second request list (flush_list).
> 
> It is.  But I think you were planning on doing a bigger rework in this
> area anyway?

Yes, that's right. I plan to remove both rq_list and flush_list from 
this function.

Bart.
