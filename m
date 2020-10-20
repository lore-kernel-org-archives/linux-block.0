Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23885C433DF
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8168E2225F
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgJTILZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:11:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37490 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbgJTILY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:11:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id c16so833988wmd.2
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2020 01:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PrzDcCSg58tLG5OCWN/DAVZsKK40F6GDbr2bMNkjeOI=;
        b=NHOckI/PMIGISZvMJ7jHMSIP++HBe1DNLI8TJ7QQ02g30Blpx5tIn9gUwFbJPwf51E
         xTpyUuiUdcGc90fWXjqNCnbjdMAHUBdjbVldxcjjLAu6hifK5ahWQhENSDWoztQdttN5
         J5zzlRyqIIhe3xjbapjv/aS5ZpFKVRUnB2GF8rt/sSVO0oZCnzwwxYA7HvwkQex6kEMd
         x2A679S+FxyaeXXppizwNhEBPJVjx0bP1N+rZsSzzEoAlT0HBOZlx8FV/xMHb5z4gA9u
         X0CDW06aGHac8qAz/2+gievAn1FOhx0Afdm7aoqPVFJcujAt9dv8fvmo5vWTdWXUTN+g
         Ihog==
X-Gm-Message-State: AOAM530b6aZZacQSOl0TH3PaOJob/Ri7GLzFpv3XchxO6QP029Xv4RPj
        8TQ67mwxsuj8z8AIcc+Mzho=
X-Google-Smtp-Source: ABdhPJwwUZ2t7Zhxa7NQMi8fvWT9QiqN4uHYzcGFQJpBd7BxxXvNckrZbQKabn6C2Nu34t6OK+oMiw==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr1547150wmf.67.1603181482022;
        Tue, 20 Oct 2020 01:11:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:104e:47d9:f0fe:a697? ([2601:647:4802:9070:104e:47d9:f0fe:a697])
        by smtp.gmail.com with ESMTPSA id v6sm1770762wrp.69.2020.10.20.01.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 01:11:21 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme: tcp: fix race between timeout and normal
 completion
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Chao Leng <lengchao@huawei.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
 <20201016142811.1262214-4-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e9d2e28e-fb55-358c-3e8c-6f3e9dd91c25@grimberg.me>
Date:   Tue, 20 Oct 2020 01:11:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016142811.1262214-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> NVMe TCP timeout handler allows to abort request directly when the
> controller isn't in LIVE state. nvme_tcp_error_recovery() updates
> controller state as RESETTING, and schedule reset work function. If
> new timeout comes before the work function is called, the new timedout
> request will be aborted directly, however at that time, the controller
> isn't shut down yet, then timeout abort vs. normal completion race
> will be triggered.

This assertion is incorrect, the before completing the request from
the timeout handler, we call nvme_tcp_stop_queue, which guarantees upon
return that no more completions will be seen from this queue.

> Fix the race by the following approach:
> 
> 1) aborting timed out request directly only in case that controller is in
> CONNECTING and DELETING state. In the two states, controller has been shutdown,
> so it is safe to do so; Also, it is enough to recovery controller in this way,
> because we only stop/destroy queues during RESETTING, and cancel all in-flight
> requests, no new request is required in RESETTING.

Unfortunately RESETTING also requires direct completion because this
state may include I/O that may timeout and unless we complete it
the reset flow cannot make forward progress
(nvme_disable_ctrl/nvme_shutdown_ctrl generate I/O in fabrics).

> 
> 2) delay unquiesce io queues and admin queue until controller is LIVE
> because it isn't necessary to start queues during RESETTING. Instead,
> this way may risk timeout vs. normal completion race because we need
> to abort timed-out request directly during CONNECTING state for setting
> up controller.

We can't unquisce I/O only when the controller is LIVE because I/O needs
to be able to failover for multipath, which should not be tied with
the controller becoming LIVE again what-so-ever...
