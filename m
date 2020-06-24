Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E22C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C325B206A5
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 15:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eo6tW5i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404031AbgFXPGQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403991AbgFXPGP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 11:06:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71585C061573
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 08:06:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so1275944pjf.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8uF5w3sOPVT17Ezk3id8iO3jPq9X7wblkG7EOsqeUtA=;
        b=eo6tW5i0u1YYwzJoyExGj4O7ckjwQpuzK7Fkr0Kj0wlhU6TProl5w8OYmwwalgwT3y
         ctRGb2rAZyjONOxNPe0I0/AZIHCmCRhwZkYWLD0BaJtkQDhPd4dPatYIcTwF4/hueUXf
         Iiy1Vf+WVam8DaWYiydWJ87zXmXtyCrw+2xUx2WILBDq2fhlOH8C8FJT9wMDutpD5Frt
         mW90OGbkkrqYmrv2YODESHwIeABDhz/0T3zzUKpn1rwrT5KQE0giDI75UqNJoUn813Ur
         DgFsvX/Pe1cVh/jngWyH1TjWKTyF6XVBcgGiHIE0d3ZkpVUyQTEGcMMyoHD+rB49LOBL
         YmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8uF5w3sOPVT17Ezk3id8iO3jPq9X7wblkG7EOsqeUtA=;
        b=K2nmJHxzUIXkC7kwvl5cjRIE9KjejBCLdKatMeB4R0NowcbsC1zucgXlfPDZcOq3+E
         zFMTu11nHfx6s7+Vv46V5nfR2DOnhIAiJJzMgQ+kaFDsOcbda2eEwNIdaV27swjq4M7v
         1rRPeKpE20M0Onv15oYX2jYc/bbuctyk3NXaHjFewKPnQMEZbB/Lvdy0aVpL0LDyKGT6
         N/fM7xKEDfSbV/HJVNih/jDPIHXsLIAGCPk6Foa0tAfH+AXtTOYs4tEF4Uc/ldnb+I7K
         cE/+EsDDxWQIRkuVjqxDyUTXZgvonWPGvKCCOZ7rmkwCBDlMgrer1nY9AfwJr3bSBEMT
         yXvg==
X-Gm-Message-State: AOAM531crF61Alc8CMyVeZRyl2mNYpJ5jJI1MgU3e4Umt0zu+KOwvEkp
        WpluHq0Rv3DjQDqeKND3FRe+qA==
X-Google-Smtp-Source: ABdhPJxDFn9unnDzZaE+RlArT65thQpiQh/eVPeagd4KILnwqmqlyJIB6KuCYTOiUV9PdBHNN0Yq8A==
X-Received: by 2002:a17:90a:55c7:: with SMTP id o7mr26495040pjm.205.1593011174943;
        Wed, 24 Jun 2020 08:06:14 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u200sm4728048pfc.43.2020.06.24.08.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:06:14 -0700 (PDT)
Subject: Re: [PATCH] blk-rq-qos: remove redundant finish_wait to rq_qos_wait.
To:     Guo Xuenan <guoxuenan@huawei.com>, linux-block@vger.kernel.org
Cc:     fangwei1@huawei.com, wangli74@huawei.com
References: <20200624130400.2902189-1-guoxuenan@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb2b5fdd-2e12-c301-032e-3458191a7053@kernel.dk>
Date:   Wed, 24 Jun 2020 09:06:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624130400.2902189-1-guoxuenan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/20 7:04 AM, Guo Xuenan wrote:
> It is no need do finish_wait twice after acquiring inflight.

Seems cleaner to kill the redundant one, rather than adding
a new one and removing another one. We end up with less
code that way.

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 656460636ad3..18f3eab9f768 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -273,8 +273,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		if (data.got_token)
 			break;
 		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
-			finish_wait(&rqw->wait, &data.wq);
-
 			/*
 			 * We raced with wbt_wake_function() getting a token,
 			 * which means we now have two. Put our local token

-- 
Jens Axboe

