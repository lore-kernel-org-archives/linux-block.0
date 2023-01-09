Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B059AC63797
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjAIXvd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjAIXvc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:51:32 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D69562C8
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:51:31 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso14613568pjt.0
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd30483XYzFkkXYu6LkGJcveYixXOpvFF79EQUaS7OU=;
        b=G/Y9XZQw7UxLPFg6gnsL+hyM0yt/3fqWqiomDHTA4l8qAOhEpGwxFbBtHVMtocBouS
         vwDmgN1zhLbHr5d8Ti1J8Iq6YAPH+7XOxH3Uh55+FW/mpmDw6Dy17GN6j9DAL5qeNd/g
         48yfa7Y37m7CdqytdwMlixQlwMPelfDFSYz6reNfGSfoC4TS70pkXoUmq8gY8fwp9yXf
         nzzwkO7IZMfFsbBoxs7lPh2082kcXjWqVQu7EunPBIv5f0Bemw0wx79Fk5x9sYvPny53
         HcYPi0ZZ9t272SvQMqt6ClywO0L/JGTVKm0UErZhyH2VMTQmuXwxHuikU/7PBxKXxJPi
         Dupw==
X-Gm-Message-State: AFqh2kpM5zkqQ9sRgWEg2fabiuDiklcnLYGcHSNHY/onYVlKoO4OlXG6
        xDEbF53pmbTOIqoVTao1jDs=
X-Google-Smtp-Source: AMrXdXuuTudIcf1CPtpCmefHKhkuTrexBV2bjevbDtHErI2Xr0U2UA11mvpxL6Mc17UrBd8SeOq4iQ==
X-Received: by 2002:a17:902:8e8b:b0:192:e4cf:ca64 with SMTP id bg11-20020a1709028e8b00b00192e4cfca64mr21956423plb.28.1673308290857;
        Mon, 09 Jan 2023 15:51:30 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:9f06:14dd:484f:e55c? ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b00189fd83eb95sm6756685plg.69.2023.01.09.15.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 15:51:29 -0800 (PST)
Message-ID: <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
Date:   Mon, 9 Jan 2023 15:51:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 15:46, Damien Le Moal wrote:
> On 1/10/23 08:27, Bart Van Assche wrote:
>> Measurements have shown that limiting the queue depth to one for zoned
>> writes has a significant negative performance impact on zoned UFS devices.
>> Hence this patch that disables zone locking from the mq-deadline scheduler
>> for storage controllers that support pipelining zoned writes. This patch is
>> based on the following assumptions:
>> - Applications submit write requests to sequential write required zones
>>    in order.
>> - It happens infrequently that zoned write requests are reordered by the
>>    block layer.
>> - The storage controller does not reorder write requests that have been
>>    submitted to the same hardware queue. This is the case for UFS: the
>>    UFSHCI specification requires that UFS controllers process requests in
>>    order per hardware queue.
>> - The I/O priority of all pipelined write requests is the same per zone.
>> - Either no I/O scheduler is used or an I/O scheduler is used that
>>    submits write requests per zone in LBA order.
>>
>> If applications submit write requests to sequential write required zones
>> in order, at least one of the pending requests will succeed. Hence, the
>> number of retries that is required is at most (number of pending
>> requests) - 1.
> 
> But if the mid-layer decides to requeue a write request, the workqueue
> used in the mq block layer for requeuing is going to completely destroy
> write ordering as that is outside of the submission path, working in
> parallel with it... Does blk_queue_pipeline_zoned_writes() == true also
> guarantee that a write request will *never* be requeued before hitting the
> adapter/device ?

We don't need the guarantee that reordering will never happen. What we 
need is that reordering happens infrequently (e.g. less than 1% of the 
cases). This is what the last paragraph before your reply refers to. 
Maybe I should expand that paragraph.

Thanks,

Bart.

