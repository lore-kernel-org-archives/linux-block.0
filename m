Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01455C10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C447B206BE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="r8yHbXA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCLN0a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:26:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43713 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgCLN03 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 09:26:29 -0400
Received: by mail-io1-f68.google.com with SMTP id n21so5605995ioo.10
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nA8lCB19o3JmVJPcZnB38FEyzkH+O9wRPnSTQ9wsLXY=;
        b=r8yHbXA79vhOly3vITu6iQs5LMjM3iumzezfd+cd4rbU6YbQqWy4wwg6yYWco0PrvZ
         qeDZglWEOonCOhwdtiUP3y60i3dOpATD61T5e+erOfKE+pejuOYfY/AyN+otSR2sFN6u
         hicfpiVmTpl/ypn/maJb9QNZb4AmLKfkwXRi6hjfdIcfd8i4XNClpOKfhasnlHSdtv77
         PwYNsRV64ALazQU3vHnWGuw4rPs9eSdcJB8nn34EFe2tFgkNHqJgBWBICi3Ji7kD2q4k
         ztTuMPmAT5DLLFh/5g3A3HP47oBrsS40Ty4C80ODajAeN3nyo/5/g6PyZvbJ0CEpyYln
         9NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nA8lCB19o3JmVJPcZnB38FEyzkH+O9wRPnSTQ9wsLXY=;
        b=WITwPGyAr0mh8jeNPrpZN+ozEZ5B/c614yyciEt3vncdmluvFEcvFKwkkrZDhsiq2P
         I88W1glVuEd36VJQD/H5gqqdHRaHraUDCE0m9oXmscoSMHvIDaGkJYBBvDkA7jaIfPpl
         JnXN5qN7aKVi5iX3VvTbmrqejtIaKe7Ua+LBLjXiN4vX9gD+a0JYlhxOnVc+lfNwmbCA
         eI19iksf1yEcb2Hgg7J+jMzRMktVLqa0mGPeEdkHgVIP8IxAYI4q9diptr7LU4fi3ML4
         C4SDWaGiUh1SsSuD5iXjiwjYp9bMuMPrntGvjw3bRZzBm10B2GaWhJK88TK9yBLPi4WJ
         +YHw==
X-Gm-Message-State: ANhLgQ3CcAGungieQ3ZcWFNp8orb0s98tWy0oZzlEvYaNbpjiEraS8Kd
        XfHsD6yjyDqGm4wIKzZ6FSFhbw==
X-Google-Smtp-Source: ADFU+vuIdeZ1LttHRiG9Wj+Fo5lkfpdC4ZlHl//fagGnsNNVHhEzk5eOpl041xcEVU5OfNCv7BlaYQ==
X-Received: by 2002:a05:6638:275:: with SMTP id x21mr7988912jaq.142.1584019588263;
        Thu, 12 Mar 2020 06:26:28 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i82sm7844839ilf.32.2020.03.12.06.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:26:27 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: insert flush request to the front of dispatch
 queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20200312091548.25237-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fd41813-0491-4cce-d3a3-d13e37ad2e69@kernel.dk>
Date:   Thu, 12 Mar 2020 07:26:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312091548.25237-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/20 3:15 AM, Ming Lei wrote:
> commit 01e99aeca397 ("blk-mq: insert passthrough request into
> hctx->dispatch directly") may change to add flush request to the tail
> of dispatch by applying the 'add_head' parameter of
> blk_mq_sched_insert_request.
> 
> Turns out this way causes performance regression on NCQ controller because
> flush is non-NCQ command, which can't be queued when there is any in-flight
> NCQ command. When adding flush rq to the front of hctx->dispatch, it is
> easier to introduce extra time to flush rq's latency compared with adding
> to the tail of dispatch queue because of S_SCHED_RESTART, then chance of
> flush merge is increased, and less flush requests may be issued to
> controller.
> 
> So always insert flush request to the front of dispatch queue just like
> before applying commit 01e99aeca397 ("blk-mq: insert passthrough request
> into hctx->dispatch directly").

Applied, thanks.

-- 
Jens Axboe

