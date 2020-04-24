Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F404C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD952087E
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ykl8bBqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXPXs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726301AbgDXPXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 11:23:48 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED087C09B045
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 08:23:47 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so9606387ile.9
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XxVpXzFYNx48bNZyUXharX9yg6pxhSlrCd2rYwDr8AI=;
        b=ykl8bBqmJMcxHvRRbFLBCfCZrTicx8WjQjGA2czI/afaIk31ZbQB88AWn0+ShJllvb
         8dyfmiJjI8AUk9jTSDUJKEiOcKQijy4kIPMb00SyIobm2Uw/Z6ZJX17DC33E3USHW08V
         dWUmzCXh7YMeswmBDxYg2S/3LZQLiaOvuLDVKLFzUauTcclAgKCbgGii624bZqP0gVAj
         fwSm6ztZkN1QQOwfU7Hp4EkFHzT3w2es3GCbTXs3EwS08jD6R5PQXFDModG/yaPRqv8D
         R+KsvTYBzDJGnAQOaSKE0dZWgb4eJhv3pckNfPDWX14AqVzMfj6kdloxS0jtSK16sKUZ
         kFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XxVpXzFYNx48bNZyUXharX9yg6pxhSlrCd2rYwDr8AI=;
        b=YgNnQPzKr2MuZIbTM1zqIwcSbcLPykZvtOQWoflQq0WvFYghuDdnYcPFrWrt1E8sDL
         s1Zwqy0yWgsaU4Hw6ag4+9sQB6e+sQmIcjxs/P5QWMPZuaTtLjyfBFHsjn55dEUNNGl6
         xGV3se7TVlNDJDovLkow3CIoG/JLognVvrC6qiviyE3onxev+bV5d5Ou+2HjndIeusuX
         5l9vCaZFW3c/H6pvBX8axbOcd0MAiCsGw+8qv4IIRvFkjbGQi9q2Lf8hLhzf21auvrgL
         TPN3apMxglC33Id0lK2P+Os7yPbjTS4EMJPB7jLAKMQrvoWMgN+eP6HaLYwEW+m+yUrT
         GC+w==
X-Gm-Message-State: AGi0Pub1QglYXgY9uzbEB+FGP/O6A5nAliwOkqFPA0l1EBCXpAqwDfdd
        LCgF/coY+xhRFluJwNkiueWzUA==
X-Google-Smtp-Source: APiQypIvq41meQyPBo18RKNrsNnKdOhr66JMN4g/Q4wUJ5DFfOdKufQT/+b5jMW9Aia7/bYTv7Jexg==
X-Received: by 2002:a92:3d85:: with SMTP id k5mr9518718ilf.26.1587741827345;
        Fri, 24 Apr 2020 08:23:47 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q13sm1993113ion.36.2020.04.24.08.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:23:46 -0700 (PDT)
Subject: Re: [PATCH V8 00/11] blk-mq: improvement CPU hotplug
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200424102351.475641-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <104406f7-70f2-ef3b-6b03-02cf847d5eb8@kernel.dk>
Date:   Fri, 24 Apr 2020 09:23:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 4:23 AM, Ming Lei wrote:
> Hi,
> 
> Thomas mentioned:
>     "
>      That was the constraint of managed interrupts from the very beginning:
>     
>       The driver/subsystem has to quiesce the interrupt line and the associated
>       queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>       until it's restarted by the core when the CPU is plugged in again.
>     "
> 
> But no drivers or blk-mq do that before one hctx becomes inactive(all
> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> 
> This patchset tries to address the issue by two stages:
> 
> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> 
> - mark the hctx as internal stopped, and drain all in-flight requests
> if the hctx is going to be dead.
> 
> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
> 
> - steal bios from the request, and resubmit them via generic_make_request(),
> then these IO will be mapped to other live hctx for dispatch
> 
> Thanks John Garry for running lots of tests on arm64 with this patchset
> and co-working on investigating all kinds of issues.
> 
> Thanks Christoph's review on V7.
> 
> Please comment & review, thanks!

Applied for 5.8 - had to do it manually for the first two patches, as
they conflict with the dma drain removal from core from Christoph.

-- 
Jens Axboe

