Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D91C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 07:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B59B61417
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 07:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhEYHYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 03:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhEYHYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 03:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621927372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+A+HfSpXZqAH5SCxE7ycsL7iyfz3fycevoSOlmzgN8=;
        b=fAjUQ7mMg6vIWG4LFC6xZktcl6iOeal8dlJllYGzdKpWgqGN7XoSu0DacSPEV+U2K0Gzi+
        GprA6QmR87XpHM2RveDrgojFNYAEZaxjibKjrTwYUkYPwKEsGPD2o4knvpYV6Q7AU7jJAr
        UjDxSLNM/G7a0ySvZ4E8hdwaCrtzSPY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-Qx-QHvfhNHyD93dz3sc-og-1; Tue, 25 May 2021 03:22:51 -0400
X-MC-Unique: Qx-QHvfhNHyD93dz3sc-og-1
Received: by mail-ej1-f72.google.com with SMTP id i8-20020a1709068508b02903d75f46b7aeso8126916ejx.18
        for <linux-block@vger.kernel.org>; Tue, 25 May 2021 00:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h+A+HfSpXZqAH5SCxE7ycsL7iyfz3fycevoSOlmzgN8=;
        b=dmQRhywYQ4kGrV8N7P8iwm/RB1m++9RYab0T2FxzqrBiDaToWd8KntXEEPPx9Rv79I
         9EkjP5UGAR99Bt5hQGPUo+YIRn/ZbFWhoDwc5S+gy0Ec2Usf+LqqOS6Nb/wAZiM2pVaN
         kOUb0OEgghJ7tCgOxhkW3AyLrGMpRO1B3V9uaRTmsD2NAD0OwaXXLu2dWLprEjhYK36Q
         Y/nmukGUnNeXWafvRn692Qtucf7pKmCOorsya2LOv0oNIvzsvfYKJ20XPMk22eb3wPmb
         wS53LuolBKSFfG9wQCqGlTsxNXM8FNZ32lfRcs41GLmmiQprzFWrf5SHIsV57sGgUD8K
         Sdhw==
X-Gm-Message-State: AOAM533p31UG0YjsEiQvNWFD1u6FtiDYrG2aMrS0//eZTbFTZodE3R85
        AGk9zGhytib3/y8/ujrIsYHTGZjpKe++Mvvgex190yh0U8PHsHjO2LD5ITk/4Ay5t7Y0NUwxj/m
        C3isx9rt9PZSMJ1J2LfkisSQ=
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr29866816edy.224.1621927369845;
        Tue, 25 May 2021 00:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS0no7nsHNRCqlg+nhqUCjlv+Qptu6bm1cQU9E9Jv2TBtMJhNOQr2oL6OuXDEhh8h9h/8pgA==
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr29866806edy.224.1621927369711;
        Tue, 25 May 2021 00:22:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g10sm8661205ejd.109.2021.05.25.00.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 00:22:49 -0700 (PDT)
To:     Christoph Hellwig <hch@lst.de>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        slp@redhat.com, sgarzare@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com> <20210524145928.GA3873@lst.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com>
Date:   Tue, 25 May 2021 09:22:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524145928.GA3873@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/05/21 16:59, Christoph Hellwig wrote:
> On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
>> Possible drawbacks of this approach:
>>
>> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>>    expensive since it requires DMA. If such devices become popular then
>>    the virtio_blk driver could use a similar approach to NVMe when
>>    VIRTIO_F_ACCESS_PLATFORM is detected in the future.
>>
>> - If a blk_poll() thread is descheduled it not only hurts polling
>>    performance but also delays completion of non-REQ_HIPRI requests on
>>    that virtqueue since vq notifications are disabled.
> 
> Yes, I think this is a dangerous configuration.  What argument exists
> again just using dedicated poll queues?

There isn't an equivalent of the admin queue in virtio-blk, which would 
allow the guest to configure the desired number of poll queues.  The 
number of queues is fixed.

Could the blk_poll() thread use preempt notifiers to enable/disable 
callbacks, for example using two new .poll_start and .end_poll callbacks 
to struct blk_mq_ops?

Paolo

