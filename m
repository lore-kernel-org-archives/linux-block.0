Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C589C433FE
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 03:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3F06124C
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 03:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhIUDS4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:18:56 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:38640 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhIUDSo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 23:18:44 -0400
Received: by mail-pj1-f52.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so950089pjc.3
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 20:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B9rFhodwArC8MzaB6G2CpinMtO0LcjoBhPDIGgEGcjo=;
        b=w7pgOLvU/MNA673xjeHUt+GSaQEhQmpRDPoQgagwO9pVK+Gf07clgDnwH2QQ/yop+i
         KHjCxlhbDJCLZBePjjQE2Hkrhanni/dox0vbwb6W9a7KvO65t4+4Jxi8++QVY5IdnLJk
         tLrPRlw9Q/rt7RvwtmaMIWcmkfV0JjOUq7nE2RoTgaUM/d4sdzha7vdxpjfMtwggCRcU
         +riSiUgq3KwxSKRPC4usAYd1mYcyxFG57lEhIYUW+Dw/8hS2VI9fPaMau0+IbAeLYpm7
         qITTeBgBWT4Wy7Bf4EfSrXSNJ0r46uHiuUsNL/yFvuKcWrRlLGbwsFKBF7eWpYHNZSWa
         A2rA==
X-Gm-Message-State: AOAM532mKkqA8USUWtRYS8l8JArAe6qKditQXhtk5/iOBOU4niztsdOG
        wta81dC0LsQMai8oRbBboDw=
X-Google-Smtp-Source: ABdhPJx5yAWlA+KSgg4bigEwxg3lmd+PdaeE4pQ1Wt351WZr80w/8cpaV0TP86xoWXGWb3PDVRbOVg==
X-Received: by 2002:a17:902:ced1:b0:13b:a0f8:63 with SMTP id d17-20020a170902ced100b0013ba0f80063mr25618415plg.37.1632194236315;
        Mon, 20 Sep 2021 20:17:16 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:2c03:4c32:d511:41a6? ([2601:647:4000:d7:2c03:4c32:d511:41a6])
        by smtp.gmail.com with ESMTPSA id e18sm10909602pfj.159.2021.09.20.20.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 20:17:14 -0700 (PDT)
Message-ID: <88348c39-37a3-e7f4-727a-6a61148215db@acm.org>
Date:   Mon, 20 Sep 2021 20:17:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/4] block: factor out a blk_try_enter_queue helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20210920112405.1299667-1-hch@lst.de>
 <20210920112405.1299667-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20210920112405.1299667-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/21 04:24, Christoph Hellwig wrote:
>   		smp_rmb();
> -
>   		wait_event(q->mq_freeze_wq,
>   			   (!q->mq_freeze_depth &&
>   			    blk_pm_resume_queue(pm, q)) ||

I prefer to keep this blank line. Otherwise this patch looks good to me.

Thanks,

Bart.
