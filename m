Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9808FC54FD0
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738202084D
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eUFfhFep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgDXPlt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgDXPls (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 11:41:48 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1510C09B045
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 08:41:47 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f82so9630187ilh.8
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oC0yEnkJ/J2hsjBM014eNiYTakX5Zj7YmsQkLzTW7xA=;
        b=eUFfhFep2CmzurpvqLOLFqdTdy8Kk8m8mVUvvjCAlYfYuAfHz+pjPQVEB1tIuYazmM
         QG7wLNQg3tI2aY4OPPnTwWz5Ls78nsYpU3yS7RgWouvPLKgaOPAczyKrp6WPtRAlG2EG
         9qRktiXqwci0nhW4f9LcDuuPaFW4aXAEPIgvS0LHlZ2zX0hDnPeMllalEpOMeSChw5nD
         3ux5HAA2PoE6m8crIfRf27w5+NXC1s+2mdOX0+VlLDs06PrKmt3i+ga2i2uwm1U4QaJc
         uiqbcnRxURgWz9VEPi8GFh7RPchBLV20p2fjLm3rdx+wLzgTuu76SEVjrcfMIDf7Xcqa
         zYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oC0yEnkJ/J2hsjBM014eNiYTakX5Zj7YmsQkLzTW7xA=;
        b=MjuO45cjvgorx+4+qGzxiCzZdHqusn1zNJmI4c/EbkMYIDYAp/2ElDnscB25P0y6Ph
         a3CnlSfAC3AgnDus33f9xpN7Y9BWlgIb60y/jZLJXdlqycKqUfdNiKrkNqPSJH2WSZMa
         r9dMR9xFMpDwqyHbWyBHgy6FGSILruoyiptBCyHo6BmlEHsBlAJTi9uSFjT1rQnALrO9
         iR8dwLkle9OsS4H5CUvVWJpWdpJxISqWodpaEN4SqBs8e/GSINjxzXmGDZuct8o2MxWJ
         cmohyCak5Ep1f24RuOujWnUOXxTtLBni7Ik1qAkm9ybLs5nsQBQQ/KiRYIjZvIddjmxQ
         WqFQ==
X-Gm-Message-State: AGi0PubIl/cf1uIFeaYa8nD5LWHIkT9bztv5QBn7xNiyblzh4v8rCf7h
        SGTkJ0wK6vWQSlFSxqZqtpf8kg==
X-Google-Smtp-Source: APiQypKpj4kDHiKb4sBo394Wlj2cjrkqbmL9J6SOzCfAwnV6huTz5A9J9FBqrmZoR/1fLLXa8KudJQ==
X-Received: by 2002:a92:5f46:: with SMTP id t67mr8852938ilb.64.1587742907110;
        Fri, 24 Apr 2020 08:41:47 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c12sm2157203ilo.31.2020.04.24.08.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:41:46 -0700 (PDT)
Subject: Re: [PATCH V8 00/11] blk-mq: improvement CPU hotplug
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <104406f7-70f2-ef3b-6b03-02cf847d5eb8@kernel.dk>
 <20200424154032.GB17253@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1eba973b-25cf-88bd-7284-d86730b4ddf2@kernel.dk>
Date:   Fri, 24 Apr 2020 09:41:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424154032.GB17253@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 9:40 AM, Christoph Hellwig wrote:
> On Fri, Apr 24, 2020 at 09:23:45AM -0600, Jens Axboe wrote:
>>> Please comment & review, thanks!
>>
>> Applied for 5.8 - had to do it manually for the first two patches, as
>> they conflict with the dma drain removal from core from Christoph.
> 
> I'd really like to see the barrier mess sorted out before this is
> merged..

OK, we can hold off until that's sorted.

-- 
Jens Axboe

