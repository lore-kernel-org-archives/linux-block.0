Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD4C3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 14:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F12233A1
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 14:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fhLd1rwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfICOAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:00:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46920 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICOAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 10:00:06 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so35989810iog.13
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2019 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h/hQ57K984Wv1bGizyUSkpIjdiKH/RDAeWFj1GjhG5w=;
        b=fhLd1rwqeIrufQ1fXDm2nWayZqIAOfJg01YOwVDMztiQKxpHWkY+INxHW6ZYC0PqON
         JK4PAWlOFDXp5nO1CWeu8NatcDJlS8vpH0zGvbfqtTLKZ+MkZXjyZHyzA3LFIpj5CAHz
         DpvfZRjTKzzvgLHlCSK9Iaa+oZecW7giqzoFni0/HnMo8KEb8JbQ5GiRTpQaPfl8WuTS
         fwKh7oUp9PUi0LpfZV8cwDaXfShFeHARr1N23a0U/LHSg75ZF9HP2fdafOz8RDaOgbvb
         kGt7UJgZ2kGXMbs3DyznvLAFhzHObQCWFsxjb5i+iBCzMECJ+16NwmDmod/pHdgg8Pku
         /ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h/hQ57K984Wv1bGizyUSkpIjdiKH/RDAeWFj1GjhG5w=;
        b=HPIDI+RBVGkUUGjsd48NPc14DaR1VEE5w+JkAt3RHAlam0jSjJGJ+OWlvIfEDe1VDR
         fKflJOTIeayblM4SlPrkwT3ryQ/PAQBewK3KVbiVi3xg2vfjuT65IAXyPgBRxD725g5c
         k0YW+FXPhSwks2toV4/otCPJcVieNu0A1kLH0c81xMKR1RTzdXfAbjHdABGZjR6m9wPT
         NeG7Ejma8NRIDvTXtwjvyRefeFUDSQafF51nomFxZxYH90Wsr/X609+kdAEX8pdNwVtO
         UH/D9tiBecphQ/8HM8Y4BRukzcA67sLmEMQY6zViDhWMRUMhmnOPKXjxAJe7Plj3SvwW
         IS+g==
X-Gm-Message-State: APjAAAXs/ajqT0Bq3NEWqG589q57tI76/GVr5m+GwC0qmI7xjWR56GNK
        QGCF5Kb0JT3GAzugMplyfeIHRC6sEZvFXw==
X-Google-Smtp-Source: APXvYqwtTiAS6lxN8AgIwZnH1MREPTnyDFf1cCt22MKfqQ3tAqDF04AdocmOMw0OfpPIeWinGadPPA==
X-Received: by 2002:a5e:c301:: with SMTP id a1mr152334iok.1.1567519205802;
        Tue, 03 Sep 2019 07:00:05 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l21sm5756815iom.24.2019.09.03.07.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 07:00:04 -0700 (PDT)
Subject: Re: [PATCH] block: mq-deadline: Fix queue restart handling
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>
References: <20190828044020.23915-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53bab076-2f3e-05d1-5238-7eb2156b91e5@kernel.dk>
Date:   Tue, 3 Sep 2019 08:00:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828044020.23915-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/19 10:40 PM, Damien Le Moal wrote:
> Commit 7211aef86f79 ("block: mq-deadline: Fix write completion
> handling") added a call to blk_mq_sched_mark_restart_hctx() in
> dd_dispatch_request() to make sure that write request dispatching does
> not stall when all target zones are locked. This fix left a subtle race
> when a write completion happens during a dispatch execution on another
> CPU:
> 
> CPU 0: Dispatch			CPU1: write completion
> 
> dd_dispatch_request()
>      lock(&dd->lock);
>      ...
>      lock(&dd->zone_lock);	dd_finish_request()
>      rq = find request		lock(&dd->zone_lock);
>      unlock(&dd->zone_lock);
>      				zone write unlock
> 				unlock(&dd->zone_lock);
> 				...
> 				__blk_mq_free_request
>                                        check restart flag (not set)
> 				      -> queue not run
>      ...
>      if (!rq && have writes)
>          blk_mq_sched_mark_restart_hctx()
>      unlock(&dd->lock)
> 
> Since the dispatch context finishes after the write request completion
> handling, marking the queue as needing a restart is not seen from
> __blk_mq_free_request() and blk_mq_sched_restart() not executed leading
> to the dispatch stall under 100% write workloads.
> 
> Fix this by moving the call to blk_mq_sched_mark_restart_hctx() from
> dd_dispatch_request() into dd_finish_request() under the zone lock to
> ensure full mutual exclusion between write request dispatch selection
> and zone unlock on write request completion.

Applied, thanks.

-- 
Jens Axboe

