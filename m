Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14BBEB64DC
	for <linux-block@archiver.kernel.org>; Sun, 25 Jun 2023 08:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjFYIJx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Jun 2023 04:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFYIJw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jun 2023 04:09:52 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1D610F
        for <linux-block@vger.kernel.org>; Sun, 25 Jun 2023 01:09:49 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-31114d47414so618499f8f.1
        for <linux-block@vger.kernel.org>; Sun, 25 Jun 2023 01:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687680588; x=1690272588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwfLjyoUz3ZDqsKQEVoGFsXw4nHaaBvsnDikn6HJhJo=;
        b=UEu6ohq+d+1CDNGf1WrzgG0MDuGd8hmG5oBmKVfVuBSyoeuLVOSkVYo3C/OnJTbmaF
         eBfiDeIUPLK0RjRvtGQoYUQi1VIUv9mHGriTByISUxZMkwAoGXonOje9d80TDD4E7bPf
         oDLECWBAHQiTRSNiSBRN5cXqpOoGcvB29FxTcGcy1TDrqhqlj1chLtbl7QXHzhrPo1QW
         R6sDZkUfQ3xBh0rh+xqFaCbB+4Zbu4H6NhGhTQ6kZ8ejV/mqb70MNrZixQRfq/lmLARH
         tOva57ZN1UfqOOwD2lxqL3lrlzLyOw/YkmJam4SyBCU+1XELGCY0oaHzEHKL+tfuJ7ia
         Uo0g==
X-Gm-Message-State: AC+VfDz3Y0HDY/WXxnO5EpyX9vLzVEzUSjL5BLNuNnvshTJR8vSaATeU
        d5gvaX2shdUD5z2TaRUPBUDKLNVLs/s=
X-Google-Smtp-Source: ACHHUZ5FjGgKnKoBXfpyo3JNxXwqBqUImEJ7SWTVZRMv+JkraYho9UCyjCeDUcSyrIuSt63wjnkAuA==
X-Received: by 2002:a5d:468d:0:b0:30a:d0a0:266e with SMTP id u13-20020a5d468d000000b0030ad0a0266emr24109094wrq.2.1687680587578;
        Sun, 25 Jun 2023 01:09:47 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm3980931wrv.74.2023.06.25.01.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 01:09:46 -0700 (PDT)
Message-ID: <643f1f34-e88b-0e79-3834-62884b614008@grimberg.me>
Date:   Sun, 25 Jun 2023 11:09:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
References: <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>> The point was to contain requests from entering while the hctx's are
>>>>>> being reconfigured. If you're going to pair up the freezes as you've
>>>>>> suggested, we might as well just not call freeze at all.
>>>>>
>>>>> blk_mq_update_nr_hw_queues() requires queue to be frozen.
>>>>
>>>> It's too late at that point. Let's work through a real example. You'll
>>>> need a system that has more CPU's than your nvme has IO queues.
>>>>
>>>> Boot without any special nvme parameters. Every possible nvme IO queue
>>>> will be assigned "default" hctx type. Now start IO to every queue, then
>>>> run:
>>>>
>>>>    # echo 8 > /sys/modules/nvme/parameters/poll_queues && echo 1 > /sys/class/nvme/nvme0/reset_controller
>>>>
>>>> Today, we freeze prior to tearing down the "default" IO queues, so
>>>> there's nothing entered into them while the driver reconfigures the
>>>> queues.
>>>
>>> nvme_start_freeze() just prevents new IO from being queued, and old ones
>>> may still be entering block layer queue, and what matters here is
>>> actually quiesce, which prevents new IO from being queued to
>>> driver/hardware.
>>>
>>>>
>>>> What you're suggesting will allow IO to queue up in a queisced "default"
>>>> queue, which will become "polled" without an interrupt hanlder on the
>>>> other side of the reset. The application doesn't know that, so the IO
>>>> you're allowing to queue up will time out.
>>>
>>> time out only happens after the request is queued to driver/hardware, or after
>>> blk_mq_start_request() is called in nvme_queue_rq(), but quiesce actually
>>> prevents new IOs from being dispatched to driver or be queued via .queue_rq(),
>>> meantime old requests have been canceled, so no any request can be
>>> timed out.
>>
>> Quiesce doesn't prevent requests from entering an hctx, and you can't
>> back it out to put on another hctx later. It doesn't matter that you
>> haven't dispatched it to hardware yet. The request's queue was set the
>> moment it was allocated, so after you unquiesce and freeze for the new
>> queue mapping, the requests previously blocked on quiesce will time out
>> in the scenario I've described.
>>
>> There are certainly gaps in the existing code where error'ed requests
>> can be requeued or stuck elsewhere and hit the exact same problem, but
>> the current way at least tries to contain it.
> 
> Yeah, but you can't remove the gap at all with start_freeze, that said
> the current code has to live with the situation of new mapping change
> and old request with old mapping.
> 
> Actually I considered to handle this kind of situation before, one approach
> is to reuse the bio steal logic taken in nvme mpath:
> 
> 1) for FS IO, re-submit bios, meantime free request
> 
> 2) for PT request, simply fail it
> 
> It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
> always set for PT request, but not see any better approach for handling
> PT request.

Ming,

I suggest to submit patches for tcp/rdma and continue the discussion on
the pci driver.
