Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C145FC433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 08:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJRIjn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 04:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiJRIji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 04:39:38 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7031209E
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 01:39:34 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id f11so22279712wrm.6
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53P1QmYMd8KsBAVxU106S0lFuL+mv2oWPz1hSw9tglc=;
        b=6egHdZC1f3ZKUQhjMZIhUYv7NZadVf5yuRl1jQl6tcl9GJ0/MlyvTWy5ym61sKFzXk
         JE5S1hIr+SJcBF67SD3aTWn0l5xOFFoygnlYyJfheWlORAYJMpUXzHn8QV1P6XmLQ7v9
         gk1L8q5OSRjsE5sLkP7huB66fSATqkPPYYlhG7nf3GFYJSX4yKgDEc7zIWO75rcV7Tub
         A8G04regFsY4QjXcDzzr3aMYBuOzoU3vfCVQDTX/XpZYcSagW7Etl5d7QUgsH5uhbxr+
         MfH7L4EAqUk1b1tQimDXluBwTAD6F3EwsSMO5mZpYveQdp7JTqETHi83rybdOzXZ1gJ5
         bV/Q==
X-Gm-Message-State: ACrzQf3FGWA4F8Wz9hIApwNOVEpwNSVMeDgB5Io2FFhThRDU0Kqmtu4Q
        Zl6OsS+no92ycGMuOa9yqPw=
X-Google-Smtp-Source: AMsMyM72mfp97zZTW6OsYczsfJlzaeFM5fpBYqQ6DPClRURwnWfLnHHgojYrblonlTxrL3sYriDrsw==
X-Received: by 2002:a05:6000:2a6:b0:22e:ddd1:d9ff with SMTP id l6-20020a05600002a600b0022eddd1d9ffmr1057677wry.447.1666082372801;
        Tue, 18 Oct 2022 01:39:32 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c1d0600b003a5f3f5883dsm19029260wms.17.2022.10.18.01.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:39:32 -0700 (PDT)
Message-ID: <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me>
Date:   Tue, 18 Oct 2022 11:39:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017134244.GA24775@lst.de>
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221017134244.GA24775@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Having to allocate a struct rcu_synchronize for each of the potentially
>> many queues here is a bit sad.
>>
>> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
>> last week, so I wonder if something like that would also be feasible
>> for SRCU, as that would come in really handy here.
> 
> Alternatively I wonder if we could simply use a single srcu_struct
> in the tag_set instead of one per-queue.  That would potentially
> increase the number of read side critical sections
> blk_mq_wait_quiesce_done would have to wait for in tagsets with
> multiple queues, but I wonder how much overhead that would be in
> practive.

It used to be on the hctx actually. It was moved to the request_queue
in an attempt to make parallel quiesce that didn't eventually complete
afaict.

For nvme, we never really quiesce a single namespace, so it will be a
net positive IMO. I also think that quiesce is really more a tagset
operation so I would think that its a more natural location.

The only question in my mind is regarding patch 2/2 with the subtle
ordering of nvme_set_queue_dying...
