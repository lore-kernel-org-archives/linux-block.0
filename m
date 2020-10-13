Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB72C433E7
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 22:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394F7218AC
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 22:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgJMWgW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 18:36:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41685 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgJMWgW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 18:36:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id c20so723657pfr.8
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 15:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=22rjIu8LeKR2tBfy7MaBP9NMMuLHR3AZBGqzLdXRcOQ=;
        b=ZpYefrsMDME71+xuteaWT6VrMk6LTVxdNKPWQq4hTULsmBUh6LSARcWIQVKhran2HU
         T345rJ7j7/gzuzwTGqFm0eSlnnqr7GHDdQg3UGRI4+H48/4o4t5FBLREdnmesNPVrDoC
         T7L7zOQrm3Slq6IHmC7YrSyjrvvOAwBnpwBbB/aqsdfSMET+0nJ2KczPYWj6U/m34Ko1
         GKNQQb8akvE9A1h4jGEBGws8hSJZWxbgSBU0kbaS11WmyVsKy+fVXvY/kXSzKAxUcI4v
         POK2XRxqwWQGV37vBsLFoMgydbZvDIyOhV0uvwAf3dWlp3DJT4mBckD///WMLIkUD0SS
         rKUw==
X-Gm-Message-State: AOAM533dAvd5/vbD4QP9wOqfoPQAFdyvhFzBfAXTTw8fhUdccNDRu+RU
        EKiL1W6jpYu+c8m5hXRE0lE=
X-Google-Smtp-Source: ABdhPJz3XhhK0F+L5hCMUdSnly23cyfDlL2WAU/D/d9FH+VGCD7dca4A3kpbIBsFJqc+x8SDjrNcUA==
X-Received: by 2002:aa7:95a6:0:b029:155:336c:3494 with SMTP id a6-20020aa795a60000b0290155336c3494mr1414214pfk.17.1602628581396;
        Tue, 13 Oct 2020 15:36:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5a09:2d7:19f0:1ee0? ([2601:647:4802:9070:5a09:2d7:19f0:1ee0])
        by smtp.gmail.com with ESMTPSA id 8sm747162pge.7.2020.10.13.15.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 15:36:20 -0700 (PDT)
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To:     Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
Date:   Tue, 13 Oct 2020 15:36:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> This may just reduce the probability. The concurrency of timeout and 
>>> teardown will cause the same request
>>> be treated repeatly, this is not we expected.
>>
>> That is right, not like SCSI, NVME doesn't apply atomic request 
>> completion, so
>> request may be completed/freed from both timeout & nvme_cancel_request().
>>
>> .teardown_lock still may cover the race with Sagi's patch because 
>> teardown
>> actually cancels requests in sync style.
> In extreme scenarios, the request may be already retry success(rq state 
> change to inflight).
> Timeout processing may wrongly stop the queue and abort the request.
> teardown_lock serialize the process of timeout and teardown, but do not 
> avoid the race.
> It might not be safe.

Not sure I understand the scenario you are describing.

what do you mean by "In extreme scenarios, the request may be already 
retry success(rq state change to inflight)"?

What will retry the request? only when the host will reconnect
the request will be retried.

We can call nvme_sync_queues in the last part of the teardown, but
I still don't understand the race here.
