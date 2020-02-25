Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C27C35DEE
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 01:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D5D2176D
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 01:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J0N6DOVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBYBvJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:51:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46469 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYBvI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 20:51:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id k29so6307095pfp.13
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2020 17:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2k9qpBuuuwDw2T3HwPn6fsY7AmBYoepNeYi9RBrSZIg=;
        b=J0N6DOVFZQKcZZdfWZm+UWtO92sTdkIVnAAh/smjNNVklUUqgSNJ4zt5XMqHGg38d1
         Eo09Bw7+o9M06+gcBgZze04MnIt/Mp98zmXoCEJc9UMptBhbsU0bCCBObDmjMRJNtC+2
         /Jrwz9f86WlbBvgc2cORkH6m7WV9lTULw3UYA2SMNNpnjXZC19wUsZMdO8ktuauVoHiN
         qpAUY2sDpSuRrS13JrSeI53pzk1izyhoUMgHx7j1UClbw2iQs2KT1RfQlZ6CpR6/I5fK
         tI1F3pLan6i+m0QjD3YQeeZOFmw5TFHe/NBBPwrgnPocwM7t4KF0unPk+pey6yHWQhXY
         7DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2k9qpBuuuwDw2T3HwPn6fsY7AmBYoepNeYi9RBrSZIg=;
        b=rKSHWLK9lUWFQkcHjZYC0byA6rIMERc853Oy8s5+6RakgqKR9SVvX0czqOYXt6wSpD
         kCkuqxaSTybfLqrgWM+zJiV0yCgzws6ythTmQ2ddcXMYgWy9X9sQPGRC/8gupPtB6l6X
         PY29Je09gC4zYIZ9vZoBOiqRAPrjF30p4N0J0W6Hy1HaAcwNXzF+3Gn3iVlG8kCjY3jr
         33/KkF3QBXaU5xhgMC4A5vH6Fj3J6FHMZW/6om+OX+JYjH4Zg05FPj/Cxo01MzKs/JoW
         VJXBsj2f19I4vX6xZvgetRoJGc6LQIpNtcZ7BPr09bIBOxkksG26IFiaGrwVW4Mr4ZS9
         ysng==
X-Gm-Message-State: APjAAAXjJLuqOA5FjFQo33OGxlo2Bpf/yUtlwavzYdY3cM4fAJ/njJ7I
        aIw2ooT+5PNcp2cFp8U6DgmVXA==
X-Google-Smtp-Source: APXvYqz3zfiQQB/VGrY4InsjqM/xSsIbPyYOOT/YCwajRYsecoTy4G6pX/Ck76kHE0g4zS62MIGCSQ==
X-Received: by 2002:a63:e011:: with SMTP id e17mr57460369pgh.49.1582595468005;
        Mon, 24 Feb 2020 17:51:08 -0800 (PST)
Received: from ?IPv6:2600:380:6c71:d0c:5c34:90d5:6c23:1c5c? ([2600:380:6c71:d0c:5c34:90d5:6c23:1c5c])
        by smtp.gmail.com with ESMTPSA id g24sm14222518pfk.92.2020.02.24.17.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 17:51:07 -0800 (PST)
Subject: Re: [PATCH V2] blk-mq: insert passthrough request into hctx->dispatch
 directly
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Ewan D . Milne" <emilne@redhat.com>
References: <20200225010432.29225-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b59035c5-aa41-88a8-d5ae-c53242b59e28@kernel.dk>
Date:   Mon, 24 Feb 2020 18:51:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225010432.29225-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/24/20 6:04 PM, Ming Lei wrote:
> For some reason, device may be in one situation which can't handle
> FS request, so STS_RESOURCE is always returned and the FS request
> will be added to hctx->dispatch. However passthrough request may
> be required at that time for fixing the problem. If passthrough
> request is added to scheduler queue, there isn't any chance for
> blk-mq to dispatch it given we prioritize requests in hctx->dispatch.
> Then the FS IO request may never be completed, and IO hang is caused.
> 
> So passthrough request has to be added to hctx->dispatch directly
> for fixing the IO hang.
> 
> Fix this issue by inserting passthrough request into hctx->dispatch
> directly together withing adding FS request to the tail of
> hctx->dispatch in blk_mq_dispatch_rq_list(). Actually we add FS request
> to tail of hctx->dispatch at default, see blk_mq_request_bypass_insert().
> 
> Then it becomes consistent with original legacy IO request
> path, in which passthrough request is always added to q->queue_head.

Applied, thanks Ming.

-- 
Jens Axboe

