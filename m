Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE4C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5816135F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhEYIJg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 04:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232034AbhEYIJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621930003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ub5yjHLwnKgzkGvx4GaW/I0s0yGaXeZ4jZCMAsk/qs4=;
        b=ONGluuS6Dj9+GBOTCE7PEnMcun4BZV6k8P21zDM5VXgG1V1nTa838S2NnILhK5KCslf+5Q
        JXgFc/NduQpmhRlvJ5z4ZiKjiQFMwAX5PZ0Pa47g0Ac//oMemWfuR/2vjpbo+D1j9I0LCz
        WKVZo/GEqaRAs6mfPEHpNbapFc7jyrU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-66IQZ28XNMenjkNHEyr-yA-1; Tue, 25 May 2021 04:06:39 -0400
X-MC-Unique: 66IQZ28XNMenjkNHEyr-yA-1
Received: by mail-ej1-f71.google.com with SMTP id i23-20020a17090685d7b02903d089ab83fcso8461985ejy.19
        for <linux-block@vger.kernel.org>; Tue, 25 May 2021 01:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ub5yjHLwnKgzkGvx4GaW/I0s0yGaXeZ4jZCMAsk/qs4=;
        b=WtOa3f4vzKZr8x6HXHLlE1yveKdYcDXFrRUpKYwJa3OWQcqrsDv2Tzhft/HI87Pudf
         RBrqJVaxgoenhb7PWa9os4TE/8Rqk775pBS7uYO4VQSeiw6ShPiDdRuJGGFQGVuf3OI8
         bNUa+RUMQOSLslt5DzN6w5z6d3/Bee9gZSmZLhTMtgyEC0wE1Z3IufaF5+82B8+EbGVx
         4tZjzE0ibAzjyuzHxH2VGwQdTTRV3RuFIT21uAPijxicbnOWm/xaaxxZFoCrAr6UN5eD
         gzxnBBiLluRuvAmOjlP4wCljLv7mtwxhq6ym4JK803RNqxpyFoW2tpJPfGqgxAadcFeY
         pcUQ==
X-Gm-Message-State: AOAM5317sVSc71ak6eqjrEI2Q/d+vMqZvw8Q+YaV7W8r70ILpusMeJfr
        OlQC88l7VF2GQ+wuXFbKNZ0QiYZDLWY5KyNXjPGC1hIlo4UiQ45MU8O3sit7C4V3V0q8rkvFLFl
        hdGz6BV/f1ebq3ygEuwmYX70=
X-Received: by 2002:a05:6402:40c1:: with SMTP id z1mr29288927edb.97.1621929998253;
        Tue, 25 May 2021 01:06:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygZqhf+xYB7Ndg3ayTHtQu/3t0kArAedOP5pe98sDgQVP2z7+rV66oJGM/D3XST8tFG3f5gA==
X-Received: by 2002:a05:6402:40c1:: with SMTP id z1mr29288906edb.97.1621929998039;
        Tue, 25 May 2021 01:06:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n8sm8645618ejl.0.2021.05.25.01.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 01:06:37 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        slp@redhat.com, sgarzare@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com> <20210524145928.GA3873@lst.de>
 <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com> <YKypgi2qcYVTgYdv@T590>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1997919-e059-b50b-19b3-5741e3309000@redhat.com>
Date:   Tue, 25 May 2021 10:06:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKypgi2qcYVTgYdv@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/05/21 09:38, Ming Lei wrote:
> On Tue, May 25, 2021 at 09:22:48AM +0200, Paolo Bonzini wrote:
>> On 24/05/21 16:59, Christoph Hellwig wrote:
>>> On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
>>>> Possible drawbacks of this approach:
>>>>
>>>> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>>>>     expensive since it requires DMA. If such devices become popular then
>>>>     the virtio_blk driver could use a similar approach to NVMe when
>>>>     VIRTIO_F_ACCESS_PLATFORM is detected in the future.
>>>>
>>>> - If a blk_poll() thread is descheduled it not only hurts polling
>>>>     performance but also delays completion of non-REQ_HIPRI requests on
>>>>     that virtqueue since vq notifications are disabled.
>>>
>>> Yes, I think this is a dangerous configuration.  What argument exists
>>> again just using dedicated poll queues?
>>
>> There isn't an equivalent of the admin queue in virtio-blk, which would
>> allow the guest to configure the desired number of poll queues.  The number
>> of queues is fixed.
> 
> Dedicated vqs can be used for poll only, and I understand VM needn't to know
> if the vq is polled or driven by IRQ in VM.
> 
> I tried that in v5.4, but not see obvious IOPS boost, so give up.
> 
> https://github.com/ming1/linux/commits/my_v5.4-virtio-irq-poll

Sure, but polling can be beneficial even for a single queue.  Queues 
have a cost on the host side as well, so a 1 vCPU - 1 queue model may 
not be always the best.

Paolo

