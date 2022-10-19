Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA3CC433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 07:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJSH5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 03:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJSH5Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 03:57:16 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BFB4D176
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:57:15 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so16956217wmr.2
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzVbvk8hx8l7BIuvfVsIXXb4jKz9eu/T6hBQaAEGOU4=;
        b=arUjod4gKri1giEvNpovazMEO0sJUmtp6DeYFstLv10NaXejNh/EilwHy/zjteRQkC
         AllwFoXC+on3J0nCHG5iN7V9yEf5XURoFJkz4Or5iBC1NCseTTd5Bw5rjKQuxE/nIfxB
         lPO4JkpzPoxh8IssAZes/xVQXG6dEgoEi20wprW5iqYIPc8y/tChOYXzf25j6tISwkVC
         F0hlpoWe3PSANPdRCz72YYlTXpG6+OtlbZVhF/l15XzrvsLVTMc74OU7nm1Kj/Ef+XSG
         RINK36PoE7vB8nw21eFnsocptA1KWJy3NuTZyvjoGj2+v+kcy4f6KXM5U5p1zcNIajoY
         Zq/Q==
X-Gm-Message-State: ACrzQf0QEJcTIAsPDC3X7raggsx5O2+HK7N6f8jOHWWXV8LPyH7EnnKh
        J7CF/prSFn5kNwupjTJH9rY=
X-Google-Smtp-Source: AMsMyM4tyl1SCsAIq8EtI4ZWNNZXuswm8uv6k/Bvfu0xwrxOJ7mJ5+QN0/j6R2az0CPMYvqiLfQQFw==
X-Received: by 2002:a05:600c:4f52:b0:3c6:cd82:5943 with SMTP id m18-20020a05600c4f5200b003c6cd825943mr25417718wmq.185.1666166233751;
        Wed, 19 Oct 2022 00:57:13 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c430700b003b492338f45sm14815320wme.39.2022.10.19.00.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 00:57:13 -0700 (PDT)
Message-ID: <c791d0d8-80b5-d25c-f8d6-f93bf6c840a6@grimberg.me>
Date:   Wed, 19 Oct 2022 10:57:11 +0300
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
References: <20221013094450.5947-2-lengchao@huawei.com>
 <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
 <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590>
 <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
 <20221019072535.GA11402@lst.de>
 <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me>
 <20221019073231.GA12035@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019073231.GA12035@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/19/22 10:32, Christoph Hellwig wrote:
> On Wed, Oct 19, 2022 at 10:30:44AM +0300, Sagi Grimberg wrote:
>> iscsi defers network sends to a workqueue anyways, and no scsi lld sets
>> BLK_MQ_F_BLOCKING.
> 
> Yes, but Mike had a series to implement a similar fast path as nvme-tcp
> as while ago that included supporting BLK_MQ_F_BLOCKING in the scsi
> midlayer.

Hmmm, didn't see that, pointer?

>  We'll also need it to convert the paride drivers to libata,
> but those are single request_queue per tag_set as far as I know.

didn't see paride even attempting to quiesce...
