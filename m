Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EE9C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 07:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJSHPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 03:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJSHPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 03:15:31 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC56385E
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:15:29 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so16445038wms.0
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvVWhk/BBaku1ZpMDQOh5RR4YdPhYTMo8mECNdmaEzA=;
        b=lT7ichLwGTzBl4jfY1hdQh1iBGJ92XqKCO/G/GFKh6nwemcVTKgZ00U5kOAtWvodE4
         aZjeHHUBO5gp+mvoL95HpJvbOo8lz1UQauHoeNwvOhQkxMVYCbSk4JRXR1r3XcIcqUye
         EUXeGQin1JwBhCDIxqxUvYH0UUtPdNdQh6p6OgQNaVTsgd9hYzl7g8PUysdRx+oiaSUL
         1mzhUGLAN4nPdamoaUvVpdIzLJzGW9HEK3EjuakwUNQAg1DG5gKbcVhy6F1RRYL+8GHR
         F8FKCDrnmyqckqOJhdyMwAp3X3e3SLdgA4uBtrWvgmv2xTy9AoWjeAEjpPJqI+RERFm0
         9SfA==
X-Gm-Message-State: ACrzQf0Mz/exVp6f+d8cyVpU2ujt4cKBK9a7FOhV+SatZFuexNzTKaZb
        modpGSgJ2zkHwER4OM1zjKtbfGH6PnQ=
X-Google-Smtp-Source: AMsMyM5l42PXh4XxSQ3VMjZQsW+o5W0El0fbSviQq+qtnJ4ULUpcN7CX8KvH06cNK+tOcZUCEr6qug==
X-Received: by 2002:a05:600c:4448:b0:3c6:fb65:2462 with SMTP id v8-20020a05600c444800b003c6fb652462mr4464065wmn.39.1666163728309;
        Wed, 19 Oct 2022 00:15:28 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b002206203ed3dsm12973900wrs.29.2022.10.19.00.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 00:15:27 -0700 (PDT)
Message-ID: <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
Date:   Wed, 19 Oct 2022 10:15:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
 <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y09GROYqk3FMM21W@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Then the big question is "how long do the SRCU readers run?"
>>>
>>> If all of the readers ran for exactly the same duration, there would be
>>> little point in having more than one srcu_struct.
>>
>> The SRCU readers are the I/O dispatch, which will have quite similar
>> runtimes for the different queues.
>>
>>> If the kernel knew up front how long the SRCU readers for a given entry
>>> would run, it could provide an srcu_struct structure for each duration.
>>> For a (fanciful) example, you could have one srcu_struct structure for
>>> SSDs, another for rotating rust, a third for LAN-attached storage, and
>>> a fourth for WAN-attached storage.  Maybe a fifth for lunar-based storage.
>>
>> All the different request_queues in a tag_set are for the same device.
>> There might be some corner cases like storare arrays where they have
>> different latencies.  But we're not even waiting for the I/O completion
>> here, this just protects the submission.
>>
>>> Does that help, or am I off in the weeds here?
>>
>> I think this was very helpful, and at least to be moving the srcu_struct
>> to the tag_set sounds like a good idea to explore.
>>
>> Ming, anything I might have missed?
> 
> I think it is fine to move it to tag_set, this way could simplify a
> lot.
> 
> The effect could be that blk_mq_quiesce_queue() becomes a little
> slow, but it is always in slow path, and synchronize_srcu() won't
> wait new read-side critical-section.
> 
> Just one corner case, in case of BLK_MQ_F_BLOCKING, is there any such driver
> which may block too long in ->queue_rq() sometime? such as wait for dozens
> of seconds.

nvme-tcp will opportunistically try a network send directly from
.queue_rq(), but always with MSG_DONTWAIT, so that is not a problem.

nbd though can block in .queue_rq() with blocking network sends, however
afaict nbd allocates a tagset per nbd_device, and also a request_queue
per device, so its effectively the same if the srcu is in the tagset or
in the request_queue.
