Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0104FC4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 08:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJSI3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 04:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJSI3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 04:29:33 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55F13DCA
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 01:29:30 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id j7so27867686wrr.3
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 01:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+YQK553ZwAb75g9DYbrpJvtlRziCaaKNmA4fzdn2Go=;
        b=4pBxnGdrz78TADFWuo8nqib0vG3nJh4I2P59qHw7zqF4vDmbtiuNyxZ9Jc942HbJKs
         mQg5SmcXrNe2Exz5M79cfMbhRfmXyJry26QKvL6qbufhpQnbYQqmjoWyveIPeFzahhho
         Tau12RRE+kmn18ZENTa41VHOkvSrq+doI2vk3BHqvaac14/If5HkVe3HL1nD2b9Jn118
         Xlyr01TeIELHCyRzguKDjdrEbUUlGgUxkwKkUQSAKY8YWjwEIfP6Pp0F4Yi0BpkuG7Iw
         VITbxbGOiVR2nMYTgT7hXm0rDjFllsb19y0Hi09yeMHpZty405yWXwWbhh99wxTkFxmz
         2RcA==
X-Gm-Message-State: ACrzQf3POV/k08V9XTBdRAxgew+yiaRFgqWOe82Yg7bwOiP7ZTtCA2BL
        SXSdaklfwJ0fdZ5YmPah974=
X-Google-Smtp-Source: AMsMyM5YXYOq0swriFXs8+YYZMHVekIYDljoauTk0kcObiPq1L4R2KyizmHUw1twq22YPfLd/0Zcfw==
X-Received: by 2002:a5d:4d07:0:b0:22e:3c45:9f00 with SMTP id z7-20020a5d4d07000000b0022e3c459f00mr4189315wrt.646.1666168169115;
        Wed, 19 Oct 2022 01:29:29 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q8-20020a1cf308000000b003c6b9749505sm20546201wmq.30.2022.10.19.01.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 01:29:28 -0700 (PDT)
Message-ID: <78b32314-6e03-6069-3459-d21189eb42e4@grimberg.me>
Date:   Wed, 19 Oct 2022 11:29:26 +0300
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
References: <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
 <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590>
 <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
 <20221019072535.GA11402@lst.de>
 <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me>
 <20221019073231.GA12035@lst.de>
 <c791d0d8-80b5-d25c-f8d6-f93bf6c840a6@grimberg.me>
 <20221019081734.GA15255@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019081734.GA15255@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> iscsi defers network sends to a workqueue anyways, and no scsi lld sets
>>>> BLK_MQ_F_BLOCKING.
>>>
>>> Yes, but Mike had a series to implement a similar fast path as nvme-tcp
>>> as while ago that included supporting BLK_MQ_F_BLOCKING in the scsi
>>> midlayer.
>>
>> Hmmm, didn't see that, pointer?
> 
> https://www.spinics.net/lists/linux-scsi/msg170849.html

Nice.

>>>   We'll also need it to convert the paride drivers to libata,
>>> but those are single request_queue per tag_set as far as I know.
>>
>> didn't see paride even attempting to quiesce...
> 
> The block layer might.  But it really does not matter for our
> considerations here..

Right.
