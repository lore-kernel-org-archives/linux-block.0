Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F4EC48BC2
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F50A6120D
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 16:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhFUQJE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhFUQJD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 12:09:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9BFC061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 09:06:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h2so4684558iob.11
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7jUykncA5qRRmS+H7aDsCFWxcgz7WG5fMTfEwWdMFns=;
        b=eew3+I39WntTHfr2YvhveWTpnWKnA0iCb/JEXbO5UBGYoC8F46GK/4+iEBxx/jyPMq
         KfDauR6+ZNLGKx6P7rhMOdbSv4inqxNOPlsBwxytJMlnlovSCKjF4J8puC2/XnDv4fJa
         4Y86bwwmY8giKYy241vOp4cBHTdXWfBQoFtoBM/PQXIZZe4mCIL08eK7GRCkOTQnFTn9
         zk/zk/G7yybxBVMPUWtolS7YGJcQfyGi2GG4ZxrH/KV1PGxAuZBbpB4FB+tSBfBaw7Qt
         ZcYDzb1WB5Fqg2OWWNuae10tO9WSqqOUiKhPGE9PQZIQqmO02owK8WXkVQCGT1qUC5cX
         /ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7jUykncA5qRRmS+H7aDsCFWxcgz7WG5fMTfEwWdMFns=;
        b=XYSqkwFhJhaqHEhpi2TOfmzSzdIiSsa+2ojvgzM7W+dcX2Kr2M9X0iJ0TmGsBp/Qbc
         f0Yw+TU6axPKB4tM6x7DgLtPLYCox3pfu/+OWPD4bnsz0qmNs3t1gdXrUYOGs53S1+1C
         qsFEcABbIr2RWnY8mKAILvbiQNm+uFsVn6JF7l6gMD97bj20RMbBQzppAyy4CDpp/j4G
         Y9eyaycwVoGS4HymBMNotno0/rhR8G0keGtLG4rmyzdP7bJLbMprfSBrkUUPEngQEaL1
         Z03XeuXJ8tSbWYpaj78epP+k4bAXGaYvvzZMkpHXUqOr5TviWryYRFt8rUDuwIporYTH
         8H3Q==
X-Gm-Message-State: AOAM530wcpbK2i1c4OPRPCIQmjjVmDC3kH8x4tX6bUp98wygZVhVNOOO
        iNV6MmMHAXqcQyoQ3PK3Ekvsww==
X-Google-Smtp-Source: ABdhPJxA2920TE+DZuJCsrwibH0ZnSPpd+acl8LGRQUErItK2iiHdtt0S1ABaO1QuOQff3kc66qfmA==
X-Received: by 2002:a02:90cb:: with SMTP id c11mr18223919jag.53.1624291607562;
        Mon, 21 Jun 2021 09:06:47 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j12sm6365477ilk.26.2021.06.21.09.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:06:46 -0700 (PDT)
Subject: Re: [PATCH v3 00/16] Improve I/O priority support
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
References: <20210618004456.7280-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f7d741e9-7e9e-28d5-1ebb-124c2b8b344b@kernel.dk>
Date:   Mon, 21 Jun 2021 10:06:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/21 6:44 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> A feature that is missing from the Linux kernel for storage devices that
> support I/O priorities is to set the I/O priority in requests involving page
> cache writeback. Since the identity of the process that triggers page cache
> writeback is not known in the writeback code, the priority set by ioprio_set()
> is ignored. However, an I/O cgroup is associated with writeback requests
> by certain filesystems. Hence this patch series that implements the following
> changes:
> * Add an rq-qos policy that makes the I/O priority configurable per I/O cgroup
>   and also that changes the I/O priority of requests to the lower of (request
>   I/O priority, cgroup I/O priority).
> * Introduce one queue per I/O priority in the mq-deadline scheduler.
> * Dispatch the highest priority requests first.
> 
> Please consider this patch series for kernel v5.14.

Applied, thanks Bart.

-- 
Jens Axboe

