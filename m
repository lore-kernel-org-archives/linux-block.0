Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2DEC4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 07:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJSHau (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 03:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJSHat (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 03:30:49 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C11C78224
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:30:48 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso412704wmq.0
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LofcaUSMIaNx2cRds1XrysPOZVMwRolaIDakuz6r9bk=;
        b=Xx2pdXvnGCvcOCcV51MbmplkcetGpTGxVJJZeGbfEiJIxAPPDYMYsC6ApYhRV0WXzw
         fq+Xef7/ZNbCihz7usSiaIJPjWj6nBw1QTwuRKdpvEJwoTrwenQ6xu36gI8O0rjvdffv
         Im1agICAbYnA4OjM4dNZjfBce40bsef4NQwgguFlcrsfXI4KL9B9KMnMZuU2S7gq5sX0
         ulIERgpZYW/pfTEWk7+V0mthHXc5S/Q0/YT3b6ZckRp6IrLVpIIyZlC8drO5phDTkF2L
         DQSMLwt2cuF+Y3cC65Un53yukG859PgCaDnv6u3kKu9bMe1c2THo0JnYUpGTs4Frfpea
         ZjyQ==
X-Gm-Message-State: ACrzQf3bGa15UBGGO9wfdJiPhmuq4PIxi7moqJZFNzzXzKOkk/w2HXfs
        zf/mBFW94EofUcCSKkUSDx0=
X-Google-Smtp-Source: AMsMyM6ehhFFVp3zLUaCyDL+dBLZlA6v9cYEx07QrvR3VhdpTVhOCIDTYKIKQ5Byxj+J0Oqc1N71XQ==
X-Received: by 2002:a05:600c:1509:b0:3c6:809a:b5a1 with SMTP id b9-20020a05600c150900b003c6809ab5a1mr26112789wmg.71.1666164646481;
        Wed, 19 Oct 2022 00:30:46 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b0022afcc11f65sm12887605wru.47.2022.10.19.00.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 00:30:46 -0700 (PDT)
Message-ID: <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me>
Date:   Wed, 19 Oct 2022 10:30:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
 <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590>
 <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
 <20221019072535.GA11402@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019072535.GA11402@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> nvme-tcp will opportunistically try a network send directly from
>> .queue_rq(), but always with MSG_DONTWAIT, so that is not a problem.
>>
>> nbd though can block in .queue_rq() with blocking network sends, however
>> afaict nbd allocates a tagset per nbd_device, and also a request_queue
>> per device, so its effectively the same if the srcu is in the tagset or
>> in the request_queue.
> 
> Yes, the only multiple request_queue per tag_set cases right now
> are nvme-tcp and mmc.  There have been patches from iSCSI, but they
> seem to be stuck.

iscsi defers network sends to a workqueue anyways, and no scsi lld sets
BLK_MQ_F_BLOCKING.
