Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA28C433DF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B93220659
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgEMWy7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 18:54:59 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40719 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbgEMWy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 18:54:59 -0400
Received: by mail-wr1-f41.google.com with SMTP id e16so1472193wra.7
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 15:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SAeDYdzVe59UwJZ8f46mi9QAGf+85KPhdItREGlFCSWVH+G+gpB+KYXGKeBdmP7xsv
         ZPGHUX5UVG0xomdYfuEixuQDMnGpe46yS3gRtH+tdRlt5EDhbcmP8JsXZiMatcTNutNg
         ixyPxTeMZSI3zX0h6VwW9KyKJd8KAKRroXej4lM9HofVXH+HH+m32WFaUwXLEWKCt3N1
         9mTESf3orcabDVut/sHqmwvQ31r1uIN6x4K9AcTiWQ4+kZsyjEQCAeDA+eZ4jD+24MQR
         7DUih/VgQ2/48jnBaqUBy7v9TfD5bVspPesUiSRWSFGS/oz2nz3uamVohAHaD5E81ryZ
         tSDA==
X-Gm-Message-State: AOAM5338DAxc0Z0FMP5bDYu2kb9RMMp7206qjcz1doFrOsFmTQWMeDf0
        xHU56i1KNP+g6DSg9k/tBMc=
X-Google-Smtp-Source: ABdhPJz/Kja4i82XcTEne1G7rgJ+25OhXTDegQjmf/k86lwM9s88fW7SQsLZBQvz2mS5zac5XzOEeA==
X-Received: by 2002:adf:e408:: with SMTP id g8mr1890521wrm.363.1589410497441;
        Wed, 13 May 2020 15:54:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59e0:deac:a73c:5d11? ([2601:647:4802:9070:59e0:deac:a73c:5d11])
        by smtp.gmail.com with ESMTPSA id v2sm1360232wrn.21.2020.05.13.15.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 15:54:56 -0700 (PDT)
Subject: Re: [PATCH 4/9] blk-mq: move getting driver tag and bugget into one
 helper
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-5-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e586eb81-fe98-8753-2175-66609243306a@grimberg.me>
Date:   Wed, 13 May 2020 15:54:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513095443.2038859-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
