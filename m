Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EC6C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 22:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFE0613E6
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 22:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhELW7z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 18:59:55 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:39487 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348890AbhELWYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 18:24:15 -0400
Received: by mail-pl1-f179.google.com with SMTP id t4so13310764plc.6
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 15:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9zLY425xAPm5dg8y0L8KPWDn3DL0qDj00Tbv6wVX/9I=;
        b=AI+NOomPFZjOmNzed4c7N0mMyDlAPJE1y6HnCk0qkFby3yhivyOIDPOh+ktNgnNZMP
         GKJ2dlhJbNFSTY8IHSuvZ0rDfunqWA8MzHeT7b5L9Hb9agBCNZFoeMPrw+bhb4OcuqQB
         /ABw1BMlcsVjYR5E/DCXXFeoHoeVKzuV623B9EBYAIJLx/lTcxaictHXk5XzxcFtC7xo
         YAzF75NjOKjAI3sR9Z7D4aEUId9oKDp2lTSfGR2ikgTSIa1Cu2p5MfdfKxJMVttYHHjY
         p1UwdRXu/KT5Qgyb7zKzGR+FAfdbFwLJMw7scGBh2xZjOWc9au3hTa5DH4/yJhXNcuen
         GGxQ==
X-Gm-Message-State: AOAM530fohXzk/q54GL/gFl6VeAZTq8Qc4KRFdn2lYHTwYgppCElDDPq
        nViGo642lLIDlBumKs76itU=
X-Google-Smtp-Source: ABdhPJxrZQcPLl4CynVlQ3IEHFgWOzKF9tFptOnxnNlSwn8giYHLIv85KPFvOMiOoAUfarY76YEYQg==
X-Received: by 2002:a17:902:d718:b029:ee:cf89:57ea with SMTP id w24-20020a170902d718b02900eecf8957eamr37652876ply.3.1620858185660;
        Wed, 12 May 2021 15:23:05 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m14sm690975pff.17.2021.05.12.15.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 15:23:03 -0700 (PDT)
Subject: Re: [PATCH] block/partitions/efi.c: Fix the efi_partition()
 kernel-doc header
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@math.psu.edu>
References: <20210512201700.9788-1-bvanassche@acm.org>
 <ef6562fa-6f8f-da28-b0f7-90a126ab4222@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6be8f403-aa1e-7149-a2cf-a5925c471efc@acm.org>
Date:   Wed, 12 May 2021 15:23:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <ef6562fa-6f8f-da28-b0f7-90a126ab4222@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 2:18 PM, Jens Axboe wrote:
> On 5/12/21 2:17 PM, Bart Van Assche wrote:
>> Fix the following kernel-doc warning:
>>
>> block/partitions/efi.c:685: warning: wrong kernel-doc identifier on line:
>>   * efi_partition(struct parsed_partitions *state)
>>
>> Cc: Alexander Viro <viro@math.psu.edu>
>> Fixes: a22f8253014b ("[PATCH] partition parsing cleanup")
> 
> Heh, I think using a sha from the history tree might cause more
> harm than good. If you want it applied to any stable, probably
> better to just use:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

You are right, but it is not my intention to send this patch to any 
stable tree. I'm fine with leaving out the Fixes: tag. If it would be 
inconvenient for you to do this then I will repost this patch.

Thanks,

Bart.


