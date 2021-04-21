Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AA3C433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598456144C
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 15:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbhDUPQ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbhDUPQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 11:16:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B794C06138A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 08:15:55 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id d25so5237584oij.5
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43BM1RWeXNmeeSS9PVJMPj0AxRoQfR0CMNvFedQdo6g=;
        b=2MP4GxATv8z+lbdocPj1QM5XxbECXHXeXv5daIIZR4d+LiPzLg0o2HV3aeOybsUM8M
         x1qeuLTLWE95xVzJUx0XJd3VZp/1cLAQs02Dtev12EzxMOX8bq8+927CLJQl/D8LFOrT
         7XzgbISnulEdJRfehkk8bXbBSv/4MhgH1tDpFJFv8lb3Aif2m1/MNPwaUpMyoI2qbumh
         xrEGGqXOEtBp4zbvhDlcfdWZ2vCjEaf0yuHSn2+w8hmHQqIZHy7zuexaj1bVSFhSIprq
         yIFQDQqP9OxfK3kYIXjtPZ5xas1cuv2H8n3n8MZ0OJTVwffG5yth599VbAZ7rqbnDJQj
         dkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43BM1RWeXNmeeSS9PVJMPj0AxRoQfR0CMNvFedQdo6g=;
        b=AkHfc7scGzyP9QZ7zUdK5sjVD6OVDMRz0XYDsOMbl6ERxH1Y3sDM8d2HULIhfdIHIR
         PPgD34c7MJfNUMM/53NFyKAFscDZxM50JNNdAwBQDi8vdI7vdlk1xcTpBg2Vn4f1XjKu
         zha7v/Tm3v+9F4Gff0RkETrMQf1S8sXfiOY/peMQGCpCZZ+XuVoQ6Rfag3A7s+3e3QjS
         cT7Mlno8t5BOMG1gsAINI/eg+5DSsxjEAlaxkYG6UHCIGbig8JX3+GZxu4iw54+PkSYE
         RLAa0NBG4RdTHZNqu6JyEXcP8/xVEPrqg+JVHKnweH30hcbOPVTwtUYn/aoXLLwZxG9Y
         lh9Q==
X-Gm-Message-State: AOAM5316m2ZR2F/sqjJwPFWvelWYOWJsgvvvYa7CijCIwVX+O/wMd5h4
        X9JJEe4IzAmxi/YY6JzT5QHdsw==
X-Google-Smtp-Source: ABdhPJzfGy4O/+HA1Ao/Zzf6QlxmxboWQrb3BWm9jVakgb+joZP/bP3rf5nkvDoHQEz/Ij+2f0gS3g==
X-Received: by 2002:aca:4c08:: with SMTP id z8mr6884712oia.67.1619018154583;
        Wed, 21 Apr 2021 08:15:54 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id z25sm571624otm.34.2021.04.21.08.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 08:15:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] ataflop: potential out of bounds in do_format()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YH/7+65JruUO/wsg@mwanda>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f79a1f7-8b7c-420c-0e70-d3b5880222bf@kernel.dk>
Date:   Wed, 21 Apr 2021 09:15:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YH/7+65JruUO/wsg@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/21 4:18 AM, Dan Carpenter wrote:
> The function uses "type" as an array index:
> 
> 	q = unit[drive].disk[type]->queue;
> 
> Unfortunately the bounds check on "type" isn't done until later in the
> function.  Fix this by moving the bounds check to the start.

Applied this and 2/2, thanks Dan.

-- 
Jens Axboe

