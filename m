Return-Path: <SRS0=SIFN=YZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F45CA9ECF
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 14:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02435208E3
	for <linux-block@archiver.kernel.org>; Fri,  1 Nov 2019 14:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="by+aCiRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfKAOnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:43:05 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36251 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfKAOnF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 10:43:05 -0400
Received: by mail-il1-f193.google.com with SMTP id s75so8887315ilc.3
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2019 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOsu2AcG2YG+DGQYkcK4IHDj0JhN9eSDbjkqK9jcdeU=;
        b=by+aCiRbys++Hk7pZDZPyBKkx18BYYSC1DSo4Jvg0Y7Fw4nrTh42bNjln5w3wVp49S
         6TFbd/JAY0l5wsaIoyBB7/+tjbY1DO2Z2Stwj31eHK5Fq+SgOUtpGZavHSW6z1aFuRyv
         ky6qkBzmoN1F4xzhrekVLEUhwDFL19eoRbF7tzDD69FdBf2I9aq21ygAGFx9Ny+sxh3/
         lENK43cv6xhuOk9n6XDje23lyxLdO4G3FVNVH/VoMD3yWRLFrPeVKf/K6VxC21VrNOvK
         AwvWCSmLK6Krn+lHP+o9blGyQpqpqvM+FKGywyImb6hazbo3naiQZNZFDhcImgqITbHU
         5Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOsu2AcG2YG+DGQYkcK4IHDj0JhN9eSDbjkqK9jcdeU=;
        b=kkqf2h8dQ0XXOLnUfcvcXn1sQGJg1vL3sbvAhAKQ/uIhx6SMhBUplOXqJNmWqp3TBs
         prdGU1FVADkfShxZCkb9YH76utt4a6aqiQaptKXfceUqGHG3b/msL7X++LQKdW62w5YP
         vl5qSVaPSIOVbhuoZiMnXBtnGsEvT4e7uqin0KHy1X7j/bDlvfWQEO6sd9PGuWIp0EUN
         4LUX/vtXu7Bk85qnkQlRiCeeh1vGhgyLhxZ5X9nAwuhON6WeIV6/00iQdLahS6SjiG+O
         6u1CClBQ6jHJ4cCA5zz85gZxAnhWVEk0KSktMvFudL7NALJJsC4ix2M6qSX9M+BaWDFH
         lHSA==
X-Gm-Message-State: APjAAAU/2kqmwEFpE1DQ/wKDLUOoqE76XrefoXJkpXMRk8GaeQJCzjt4
        7tX2DaSnYUqUye3ZHWyrSKcmzA==
X-Google-Smtp-Source: APXvYqxgmEpiVeLF3XJCoR505jhuWbx/CW7TxVDFN3I3miphrKm6TiRF71WtKd6tpywv2xpw6YwQrw==
X-Received: by 2002:a05:6e02:546:: with SMTP id i6mr12379669ils.54.1572619384454;
        Fri, 01 Nov 2019 07:43:04 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n28sm985343ili.70.2019.11.01.07.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 07:43:03 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Make blk_mq_run_hw_queue() return void
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1572368370-139412-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <411ad78b-ba8c-cbee-f4f4-19a626cbfc0f@kernel.dk>
Date:   Fri, 1 Nov 2019 08:43:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572368370-139412-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/19 10:59 AM, John Garry wrote:
> Since commit 97889f9ac24f ("blk-mq: remove synchronize_rcu() from
> blk_mq_del_queue_tag_set()"), the return value of blk_mq_run_hw_queue()
> is never checked, so make it return void, which very marginally simplifies
> the code.

Applied, thanks.

-- 
Jens Axboe

