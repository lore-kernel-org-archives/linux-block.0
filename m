Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099C7C48BC2
	for <linux-block@archiver.kernel.org>; Sun, 27 Jun 2021 22:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DAF61990
	for <linux-block@archiver.kernel.org>; Sun, 27 Jun 2021 22:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhF0W1E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jun 2021 18:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhF0W1E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jun 2021 18:27:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB9C061574
        for <linux-block@vger.kernel.org>; Sun, 27 Jun 2021 15:24:39 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s19so19861875ioc.3
        for <linux-block@vger.kernel.org>; Sun, 27 Jun 2021 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mOya+d4Av6qp+T3v/+bO5yvv69i78j2UzT/v+gbf72Q=;
        b=azohttPBRNfBB5CSQ/joaj/ttxjAuTb4ogezUngbBB5Zr5focWxCGHO8HRvj2Jltc7
         cc5iE5w0cd4m/lTGjeAZSsBWKbrR9CXNOA3Vetj6KnTMCS+vsSmsH+m0YQq4qpNWBEVL
         pFJ37AWdvUaZgqsOX6w6bBDSDc9dI82LXei0RS6HQdoeRLTCMXxbOqw4IwigEh/4TtqT
         s6dOazHSKPbQe9tBEPmB9Z7dSI/xeH6QBY5N6knl4GTsLlKOgIVJkUd56adpmxl07xah
         XrhmALQJb/02vMvn9175Pvm9RXSphr4/UZxz4zmB16bVr5kYNrobCxZw2xHmu7aYH5YS
         WBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOya+d4Av6qp+T3v/+bO5yvv69i78j2UzT/v+gbf72Q=;
        b=YIMptuuBWuQNOK8ypDfk5FToUtAKK36mfwvC2Pr7rRVlh7Jg/i1IGQlJ23him9r6ZY
         FXF0cpY1M8Sc5TXU1EyY0p07QgwWApenTGZO5UtLQhHEeOz8E5sjKupcSdldNowuMcmi
         2Szk4ccuxx6A4tEEGnFnWIOUvi7cSPNSXwE6eWmhiX7P+UxF3q74F2Q8sSoDxxXgP9eZ
         PK2NQGNaD8WSIhbRxlSWBJqnWJ2ReAkR4rFtrCwL3FMWE8+cm6tntVFZ9tMlnw7OIjf2
         oZy9b4nzFOl6Qd2kSigaSnE46kPVC37AENaBZiru28tMYKHQtm5DsTf8yl2TlzrnvLRu
         uQfQ==
X-Gm-Message-State: AOAM533IY4pDf+4/tZIDtBjHUw18Y5dt7jYGybGW+USAMwUzMtrggF3e
        M5mxde41ZBpSwwMqXxY8QbI7vQxX/zyBHQ==
X-Google-Smtp-Source: ABdhPJy9jy5xKxFVITLo8QatDpU0iwSZW98Fpm0Zh8yBhXvjqSGVlXROQpZCopHx8Bt1DFgYUwd4Zg==
X-Received: by 2002:a05:6602:3407:: with SMTP id n7mr18090985ioz.129.1624832678456;
        Sun, 27 Jun 2021 15:24:38 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id l26sm6937013iok.26.2021.06.27.15.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 15:24:37 -0700 (PDT)
Subject: Re: [PATCH] block: remove redundant bio_uninit from simple direct io
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de
References: <20210626104736.911941-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <37173158-c49b-def1-6722-df7135df9d4a@kernel.dk>
Date:   Sun, 27 Jun 2021 16:24:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210626104736.911941-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/26/21 4:47 AM, Yufen Yu wrote:
> Since bio_endio() will call bio_uninit() for us, we can remove
> it from current code path.

What about the error path?

-- 
Jens Axboe

