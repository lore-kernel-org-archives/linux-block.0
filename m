Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A255C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 16:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705E060EE5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 16:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhIWQkt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhIWQks (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 12:40:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24034C061574
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 09:39:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r75so8897410iod.7
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1cB851R84al8S1MpSZwYOiAQ2LJ5EMuLHJ+zX42ERps=;
        b=SPuxwZFhLKA5qIg3FbjDaKac7cQsv6lGBKuBIf0hcs9EzP+sRT/W1BgexNAklaaY5H
         t1zS0WvjKJLQT+2CYuz34NZfWWCbEh/Em20SaL9oj/5pv+hYqWgkValRx9BHdjzPqxSi
         yLrsMzUvxkogqCuZiQXk7Bgqex79swyE8kZBllfSV9uQEFiQ39yhRvjB/+cYnQuPvABd
         d+F6TzkpG9s00d2p8e507WCLltVHwdEfedXJdDourM3rkA2/DAkYedlB3fD3zJTDKMlR
         6L7cH5QSh2a9cFW7K0Vk5rvZTMWh5RNLoqVdIhn2St8YMFdkHUGsRZqp66sJhn0VPhe8
         yQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cB851R84al8S1MpSZwYOiAQ2LJ5EMuLHJ+zX42ERps=;
        b=32HlUYqJ0ZEtDvei25It0PdZ25FgiTLUEoNJwHtE1GaRetCmzDnBo687stjp3jWagf
         qR2Al9YdmKcOd/P0M4/gaCxnoJjIVSvQCfd5Psw6unVc0rOrbmmzgDOs2YK5xvyRvf/6
         3/rndO+EXPvST56v4V6t/YQGiyUUZbEj19vYVwdHblGDTrlKSy7kyK4VusfzDzc1gIfX
         Mxrx/DegX6LFl1PHaysBO7lbFXwCIjSIhe/7lgtDp+JbUjKUMKvCPfJojt0RDfc3an8z
         SECzHXRz4dxMlaiXHFRuwMdZhTpc7t+m4BL68p2qxStmknYhoJVoNf35ZdVb+Lyquwkv
         U87g==
X-Gm-Message-State: AOAM532gq2A5qJha9gfa+PBjBPLIcMLvltlaXvkZsRimYLKqjiShcHeN
        qqu9kh+fr+PshA3ipUDUKeKcO+ou6cVXDQLCVPc=
X-Google-Smtp-Source: ABdhPJxkecTW4UgED0MTTHn+BEzJKGbFegHgq0DKLz0JFFCwH25Sz3PPf1+/e6CqlGd5ayMtG3B0AQ==
X-Received: by 2002:a5e:930a:: with SMTP id k10mr4752299iom.61.1632415150202;
        Thu, 23 Sep 2021 09:39:10 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 67sm2695092iou.4.2021.09.23.09.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:39:09 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Fix a NULL pointer dereference
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210922175055.568763-1-bvanassche@acm.org>
 <d8c3e376-145e-f29a-3cf2-210fae4c8884@kernel.dk>
 <fdf80121-35aa-0295-8614-54247fd12686@acm.org>
 <ae742deb-df52-9c65-8cb1-3f66dc0bde53@acm.org>
 <4c26ddaf-1b25-7a53-6e6b-09b59ada1a99@kernel.dk>
 <941cc786-fea9-4f35-dc19-8b84461285e9@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <86906e1f-83dd-503f-1369-158966a2ac20@kernel.dk>
Date:   Thu, 23 Sep 2021 10:39:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <941cc786-fea9-4f35-dc19-8b84461285e9@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/21 10:22 AM, Bart Van Assche wrote:
> On 9/23/21 9:04 AM, Jens Axboe wrote:
>> What options are you loading null_blk with?
> 
> The issues I reported are the result of running test blk/010 from the
> blktests suite. That test loads the null_blk kernel module twice:
> 
> _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32
> [ ... ]
> _exit_null_blk
> _init_null_blk queue_mode=2 submit_queues=16 nr_devices=32 shared_tags=1
> [ ... ]
> _exit_null_blk
> 
> Please let me know if you need more information.

Tried both that and running block/010, didn't trigger anything for me.
Odd...

-- 
Jens Axboe

