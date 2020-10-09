Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB9C433DF
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 18:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F221D222B9
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 18:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QYTcu/ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbgJISqC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733158AbgJISqC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 14:46:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E5AC0613D2
        for <linux-block@vger.kernel.org>; Fri,  9 Oct 2020 11:46:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so7884256pgm.11
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2020 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tvb7wUl1WDADunzvhUG9D+BwLU/sGnn7Lab3f1xlFfE=;
        b=QYTcu/ldiLE/EUj9lqnhojhjxlvd24ULZ6UVFCWVhQTaxijM2pOWztPTC4LIz1V06c
         UYYSWE6HcoYiYDQw3El53ClvHZVoUqClAwf2MvsnCXHZxDVZyNxDOuZCu3FhZNXvY3Y2
         i4huJeklufco0j6ERlugqTacJq4rvkaqIq57tTXRA1tiy4BCaVDMHfRXdbuORDMOod76
         /d8uV7RhXMj30BpbHe14bZ5aknSZ0L0d97n07QD1NDArFi1zdW7ORjverPbalWPfA3cr
         MD1f7akIofHI073oVcmzvPk85Ghdqj/e3I4ZNDz++SooCzNUmfx8K1GIHqJlvN4W62sS
         ACpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tvb7wUl1WDADunzvhUG9D+BwLU/sGnn7Lab3f1xlFfE=;
        b=Uez0hv+oemOxwD0FQ5j6vpYrmQgmZl2MDHHrOXcrpjuL+uJAJZvKWUb8GNoeKh3zI3
         YdPVj+/JVwoy3+p1Sv+h2t1v+RxEBd2Dxkza128/KuU7jUmpm56wsll+ozwJGpNhMW49
         lkE8G/fjMTYag3vDPub9s0cb01dDIGtJ6E7+xPuk01NtQzOpP3ZeuhrIpLGCkEeRrw8C
         xqaTkjlkWfEnxzPJ8NbBv2YO/ohlpu0THXDcQQ56EP7nOUZHzUOM1/025zvYjuc+ZdTo
         sHpPAggOo44+Myjg1eynf4EpLCe5DFi7RDpUg9fp7+WzoaCvnTlkJhnkbIIyGjw0CXpi
         C0sw==
X-Gm-Message-State: AOAM53383tq1rc1ptR9d9EtmvwYYMJz1ds8InhHWnElN6VL8NavDHnyd
        sPVXm1RohtHrh7GctXAZjFmXfg==
X-Google-Smtp-Source: ABdhPJzFaxh5Cz2M6tn08UEupGu5M4JGTDx3MlQkUxnSUD4L4xTZZkQPWzr1Ab5TRBpjC62Nxx7gpA==
X-Received: by 2002:aa7:8e56:0:b029:155:af99:90fc with SMTP id d22-20020aa78e560000b0290155af9990fcmr674513pfr.67.1602269161591;
        Fri, 09 Oct 2020 11:46:01 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y10sm12044356pff.119.2020.10.09.11.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 11:46:00 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 0/7] some improvements and cleanups for block
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de
References: <20201009032633.83645-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9707e8a4-7a4d-b58d-6086-93588d41453d@kernel.dk>
Date:   Fri, 9 Oct 2020 12:45:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009032633.83645-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/20 9:26 PM, Yufen Yu wrote:
> Hi all,
>   This series contains improvement for elevator exit, removing
>   wrong comments and clean-up code.
> 
> Yufen Yu (7):
>   block: invoke blk_mq_exit_sched no matter whether have .exit_sched
>   block: remove redundant mq check
>   block: use helper function to test queue register
>   blk-mq: use helper function to test hw stopped
>   block: fix comment and add lockdep assert
>   block: get rid of unnecessary local variable
>   blk-mq: get rid of the dead flush handle code path
> 
>  block/blk-iocost.c   |  2 +-
>  block/blk-mq-sched.c |  6 ------
>  block/blk-mq.c       |  2 +-
>  block/blk-sysfs.c    |  5 +----
>  block/elevator.c     | 23 ++++++++---------------
>  5 files changed, 11 insertions(+), 27 deletions(-)

Applied, thanks.

-- 
Jens Axboe

