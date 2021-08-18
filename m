Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD8AC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 03:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C7960ED5
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 03:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhHRDDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 23:03:35 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:43570 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhHRDDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 23:03:35 -0400
Received: by mail-pf1-f182.google.com with SMTP id 7so704242pfl.10
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 20:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wIRgThqeF/wSNfpQO+9JjdLuGhX37BH1DXBc0wj52PI=;
        b=sKFWOd6nitcTWqOFYLXsOmN5OnswRogAj1eRf2lEHeP+A5gPuHWKiDHZJB39icalnS
         fOq5gfHUxYZ+V6ClQ9fXPIFZ6KiUpkW4SSfQcJIZpUpbUc3yqzBFhzxckl4+sNCu0c4Z
         OOawA3mPSfLr8y0WPypeKhOkQS2HJB4Mi/cZqyVLMoDv4v1+6B/jtvklE7hNoQezeesM
         xFGT2tP8MoF+pvFYsCYG14T5c6EnhT5xia8oMBv2Ak27Dqf1HFZDfnsnwtmI4e2c+TDI
         kRzl9uhLEBz2g8Y9i2rsFtRe2R/IkbxB4Hht9Or3GLZbq9LMRswQCH6+5qUxTQdvCHqs
         7rBA==
X-Gm-Message-State: AOAM532uNNlrF43x5d6B3SuV6ldbqE2UwScpF9umosutrZOLI9cTUvRh
        D9rPBbh5joYr3kPGG8PEaGk=
X-Google-Smtp-Source: ABdhPJzz2GXD3u5XKbu/+TNNkBK9/+xFZHxuzD59E2OI2DYvtswo+ArjDyVnizNVds05/by9E7wwcQ==
X-Received: by 2002:a63:d849:: with SMTP id k9mr6742278pgj.67.1629255780785;
        Tue, 17 Aug 2021 20:03:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a2e:bdc6:d31c:3f87? ([2601:647:4000:d7:a2e:bdc6:d31c:3f87])
        by smtp.gmail.com with ESMTPSA id 6sm4132303pfg.108.2021.08.17.20.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 20:03:00 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix is_flush_rq
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>,
        Yufen Yu <yuyufen@huawei.com>
References: <20210818010925.607383-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ef0681f8-5862-e340-b9e6-ebce5cfa3c2c@acm.org>
Date:   Tue, 17 Aug 2021 20:02:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818010925.607383-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/21 6:09 PM, Ming Lei wrote:
> +bool is_flush_rq(struct request *rq)
> +{
> +	return rq->end_io == flush_end_io;
> +}

My understanding is that calling is_flush_rq() is only safe if the
caller guarantees that the request refcount >= 1. How about adding a
comment that explains this?

Thanks,

Bart.
