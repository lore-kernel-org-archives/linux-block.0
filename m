Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ABFC4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF07B60FD8
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhHPQdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:33:45 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:40781 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhHPQdo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:33:44 -0400
Received: by mail-pj1-f42.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso14367620pjh.5
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gZ73ZqwPRdbPSQPbznX5IbEAHOaoNMvD6pFvIk5ecZU=;
        b=ujZ7VeyJqjXeVe8C11lPzo/uGRTFsGe3r1Cn3N5q0oeWFUfvKtrJpz2xT8O7nEZQn3
         gg7mnQwZSAjp0RpntxpM2QHizecaxe0j0Zuy/EnzGMZS4hNxifoU5vByoQc4RNGUVwFU
         +g/woDWLQypOazvhBj1nu84zdE+XgJgDp1pryXpmvvjUSDZruHNFfXf7c4mnNffIKjW2
         xhzDTXZkqzuayHh5xRtZNR0YmPCy/JU/mlcU4REvt8lwVv8DrqRzhAfuh42q5XrldiSs
         h9CtWsRLnL0OmHObPeertvlXz9U6wZW5w/QI7ZYlI10zzE2ySvRhpFSN3kjZbkP40df3
         xZaw==
X-Gm-Message-State: AOAM5315hugG67tIln+NO52OGe43gtJwFTuFKErfejweP9RkQ5F7SXjs
        2XWooqJ1YJZ0Pn64US3EpAXpmTOaWrw=
X-Google-Smtp-Source: ABdhPJyK6St8Sxynhh2G6/X8hB8JbDLA0W/1a+gbH11M4xqQWiQ2QtAcNU1lpelM59L1hy59YOWbWQ==
X-Received: by 2002:a63:171d:: with SMTP id x29mr16843551pgl.418.1629131592571;
        Mon, 16 Aug 2021 09:33:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3e2c:ff4c:882:85b9])
        by smtp.gmail.com with ESMTPSA id b13sm7407061pfr.72.2021.08.16.09.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:33:11 -0700 (PDT)
Subject: Re: paride initialization cleanup
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org
References: <20210816161110.909076-1-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <953db079-d556-f0c5-31eb-932d7f78a3c7@acm.org>
Date:   Mon, 16 Aug 2021 09:33:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210816161110.909076-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/21 9:11 AM, Christoph Hellwig wrote:
> the paride drivers currently have a major Linux 1.x-style mess for
> initializing the gendisks.  This series refactors them to be modular
> and self-contained in preparation of error handling for add_disk.

Hi Christoph,

My understanding is that both the parallel port and IDE are obsolete 
technologies. Is anyone still using the paride drivers?

Thanks,

Bart.
