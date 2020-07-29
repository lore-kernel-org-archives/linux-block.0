Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD8C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 04:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F00842070B
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 04:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgG2Ejh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 00:39:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38580 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgG2Ejh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 00:39:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id m16so11243161pls.5
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 21:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gxYDx5pEjBGzNAcO5iDUs2RLckxHaGp4SDZYoJL4RCw=;
        b=MVcsWi8URGJunQXCOp/DF5KjxyazxR/s9AJfhXD18l+5aghwFH+GJG4k3vcxukHTAg
         prPSyPbPxHbokN71IL5Y6j6WOR//1E5+hR+ZmOKs4JkKjclQhCaJGgMFlehjZtSP9RtN
         2d0f4IOzk25T4xH2iE+1XCbxcGJs9w3EcIi/0cgYWL/Caf5kZjvxkw+SQXyRN3xDAioP
         /8Fno1jBgdWL8Bktro0/nMRDV96XdZu2+8ki+sg1QC7BJIHty+hfvj/W5xiEGjFIAJ4S
         fZdzDWebATU55qLgnCkOv2CO9AKJTZOsm9l4mJnPobzdGEOTLU+drdhVGZcehhnc2Chw
         E5ug==
X-Gm-Message-State: AOAM531cddMegELZ/GTQgsGsyyoSI8ILqoyLSbf59yetnNbbZYmZRw2n
        4dEHysS6irK24YxCF9GcoSQ=
X-Google-Smtp-Source: ABdhPJzc2rtDbQsrUdjJI5UzJe9jQNDalJTCdqHt5SpuvftO1Z5yMbStZKmT86T0g9skTgfSuzygqw==
X-Received: by 2002:a17:90a:6946:: with SMTP id j6mr6810696pjm.223.1595997576341;
        Tue, 28 Jul 2020 21:39:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fcc5:69d8:6e20:4fd1? ([2601:647:4802:9070:fcc5:69d8:6e20:4fd1])
        by smtp.gmail.com with ESMTPSA id o26sm616394pfp.219.2020.07.28.21.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 21:39:35 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Keith Busch <kbusch@kernel.org>
Cc:     paulmck@kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>, Ming Lin <mlin@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
Date:   Tue, 28 Jul 2020 21:39:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> Dynamically allocating each one is possible but not very scalable.
>>>>
>>>> The question is if there is some way, we can do this with on-stack
>>>> or a single on-heap rcu_head or equivalent that can achieve the same
>>>> effect.
>>>
>>> If the hctx structures are guaranteed to stay put, you could count
>>> them and then do a single allocation of an array of rcu_head structures
>>> (or some larger structure containing an rcu_head structure, if needed).
>>> You could then sequence through this array, consuming one rcu_head per
>>> hctx as you processed it.  Once all the callbacks had been invoked,
>>> it would be safe to free the array.
>>>
>>> Sounds too simple, though.  So what am I missing?
>>
>> We don't want higher-order allocations...
> 
> So:
> 
>    (1) We don't want to embed the struct in the hctx because we allocate
>    so many of them that this is non-negligable to add for something we
>    typically never use.
> 
>    (2) We don't want to allocate dynamically because it's potentially
>    huge.
> 
> As long as we're using srcu for blocking hctx's, I think it's "pick your
> poison".
> 
> Alternatively, Ming's percpu_ref patch(*) may be worth a look.
> 
>   * https://www.spinics.net/lists/linux-block/msg56976.html1
I'm not opposed to having this. Will require some more testing
as this affects pretty much every driver out there..

If we are going with a lightweight percpu_ref, can we just do
it also for non-blocking hctx and have a single code-path?
