Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E9C38142
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 17:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjAaRcA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 12:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAaRb7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 12:31:59 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6756ED5
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 09:31:40 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id m13so3906911plx.13
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 09:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaB7zSs/8/VT5BVJzCf71+n1VdJdmjigPow8Ih9D+gk=;
        b=6Sax8kW4E2ncddbebZv240qA0JlXE2xVEvj5/KwaDUVEtneOjo0gErdE0oJTY9nEOd
         pRny0S/xAkFR+lqrXuP3LqRWNdp4pHUzMgTSKhLRYmjETqkBjYDpoWsTsCMqUppcbVhK
         LHRPJ8+nnSwHZV30Xkdly13j9w0O60A9RfQ3I5e2b+UxN8usPieh5fwy2kMqeJ12Myq3
         s8j4XZzSmcD4x5pfzvVIeXDl2qtwJAUOg7nRwlr7H+um3jmCyLk3YxwUQmZgMlZJjGk/
         jf6kpiJOJhSl0JdBLzEd0FttxzGIvkPJufiGPrTenGA+47yZhC6YKnEH/0Bnvfvs5QeB
         p4PA==
X-Gm-Message-State: AO0yUKWomDQiVLcMmG/6rJt5w+pDjSucbun4+doqU/a4+BmcHCUIDQdY
        KPx4ZUrUfOmTFTlr5TSkPFc=
X-Google-Smtp-Source: AK7set8LiWBMMjG7p3DMKblK8ZA497Xf+JhbxR1l2IZSzemyjFpaNumPJ7lOraEsMZU8gwZUhoB3LA==
X-Received: by 2002:a17:902:d484:b0:196:8bd6:2396 with SMTP id c4-20020a170902d48400b001968bd62396mr8625252plg.30.1675186299261;
        Tue, 31 Jan 2023 09:31:39 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7e97:ee02:2248:2471? ([2620:15c:211:201:7e97:ee02:2248:2471])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b0019607547f29sm9999414plp.304.2023.01.31.09.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 09:31:38 -0800 (PST)
Message-ID: <102b71d2-ee00-c317-fd63-3f3d006505d4@acm.org>
Date:   Tue, 31 Jan 2023 09:31:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: Revert "let blkcg_gq grab request queue's refcnt"
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230130232257.972224-1-bvanassche@acm.org>
 <Y9h0WMOqNau4s0c0@T590>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y9h0WMOqNau4s0c0@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/23 17:52, Ming Lei wrote:
> Hi Bart,
> 
> On Mon, Jan 30, 2023 at 03:22:57PM -0800, Bart Van Assche wrote:
>> Since commit 0a9a25ca7843 ("block: let blkcg_gq grab request queue's
>> refcnt") for many request queues the reference count drops to 1 when
>> the request queue is destroyed instead of to 0. In other words, the
>> request queue is leaked. Fix this by reverting that commit.
> 
> When/where you observe that the reference count drops to 1 instead of 0?
> 
> Do you have kmem leak log?
> 
> Probably, the last drop is in blkg_free_workfn().

Hi Ming,

The reference count leak was discovered while I was testing my patch 
series that adds support for sub-page limits 
(https://lore.kernel.org/linux-block/20230130212656.876311-1-bvanassche@acm.org/T/#t). 
The second patch in that series adds a counter that tracks the number of 
queues that need support for limits below the page size 
(sub_page_limit_queues). I noticed that without this patch that counter 
increases but never decreases. With this patch applied, that counter 
drops back to zero after having run a test that needs support for 
sub-page limits.

Thanks,

Bart.

