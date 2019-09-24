Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EB3C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 13:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CCF2168B
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 13:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="upfHDqR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfIXNWO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 09:22:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53085 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfIXNWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 09:22:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id x2so50829wmj.2
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 06:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EaRj4gq+l7ymUHQDU7Q6v7i1++StYnwsqQObCbfYiSE=;
        b=upfHDqR8wIXcmNkcRkVjVlTL3nWcU9X3V+BqPRobHyRixf/UaJP6AMsg8hOsbWBMbL
         9Zw39nGtILSZGHfksbVSsuIVnmmU5oeUVoC8ecZjc+nBndCIrKOyeCIc/T3FNdWj8Hry
         f4A2FTWlpFDSvdXaEwimIzAJAJ/sIm6jTYFNGu/7I+HfgtiuDJmFWEo/846IggVpN8/A
         aNdVjlURubmDnJvf/87X2SpxQnDmN+QREmLyiqDKy9fbGD2JOFsXumxD2GRxzCa7aeB/
         PlTaTRgpcG2oxFd4VKpHYjcCfF0Wr3f9+HIzz7Vsh9/ou2O4KHTPs1k/YTVZ6h2JTL1+
         f/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EaRj4gq+l7ymUHQDU7Q6v7i1++StYnwsqQObCbfYiSE=;
        b=fZanMOTyBW4waivGCLFfNV6W/hJzipvBVTtAIiCfb9gnbd5//19F5/DxfhHQD9Dc8h
         wcWRY76whlVoko0FQNTDuQAFGluFVaonrkfXLvlchw0rX3Cn2ezCTSBIliCwFqyfQdfC
         yChBNTVbEgndrEe/5uOWS5qmX7ZJCZuhSghufRl5L680inn4DpWYCINaVipaXscvxFAl
         7hJDjz05Ejnv7VmBaDtsoevZ7sOPeBiHTeTLks3N5Lg7PHQ59R9I9czEGb7la2Q1ArNh
         VofajhYinRWJB2GUNro4Sd/RuF5+8ejY9ONmyxtuvlSgSNeif1mJJ114sC0laX3xnW5h
         WPug==
X-Gm-Message-State: APjAAAVQz+XvlHPRXYeIGc0bNGRi+on7FjFnXfJLQT9j94Qs7ElsXpWP
        khT++cmkFmT3HB0mXN0x5dfOrA==
X-Google-Smtp-Source: APXvYqx7/R7Zj4jEPu3B8+GhiUmHpvQRVMY+XX6kQE5m7Qjw2+yIKR6o6IiThnzjjb4Q/9vsBlu3ng==
X-Received: by 2002:a05:600c:2108:: with SMTP id u8mr2833967wml.13.1569331331217;
        Tue, 24 Sep 2019 06:22:11 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id j26sm3707931wrd.2.2019.09.24.06.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:22:10 -0700 (PDT)
Subject: Re: [PATCH] io_uring: compare cached_cq_tail with cq.head
 in_io_uring_poll
To:     yangerkun <yangerkun@huawei.com>, hristo@venev.name
Cc:     linux-block@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com
References: <20190924125334.5543-1-yangerkun@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e32a5b7-2782-69e8-b4e4-8574d910d517@kernel.dk>
Date:   Tue, 24 Sep 2019 15:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924125334.5543-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/19 6:53 AM, yangerkun wrote:
> After 75b28af("io_uring: allocate the two rings together"), we compare
> sq.head with cached_cq_tail to determine does there any cq invalid.
> Actually, we should use cq.head.

Nice catch, applied. BTW, note for future submissions, this:

> Fixes: 75b28af ("io_uring: allocate the two rings together")

sha should be 12 characters. I will fix it up in this one.

-- 
Jens Axboe

