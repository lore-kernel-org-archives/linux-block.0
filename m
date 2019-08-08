Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0528C433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9358821479
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GyfDnfPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbfHHNfF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:35:05 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:38452 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbfHHNfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 09:35:02 -0400
Received: by mail-pf1-f170.google.com with SMTP id y15so44142557pfn.5
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GpmhOOhkjZn/xPUlAc0Il+1MLsQaxLxLhCEUVCkaXcY=;
        b=GyfDnfPtZ50Yp5OLwkB9MAp59zkRYwuo2uowH34HWERv68pXqjexeZf/LiildrlfkG
         SUWFQBm4VtFWSeVThF6R2fdBrOjnmJAwD3HBW+48GDXr4kpvnF44jBRpLCS4kBPr3YD0
         HPWmUbWFP+ndfXLRh200lCvjlg5g54sN+Ok12oavsDAKYb8fxTfesCaRtW3zQO0beCo4
         VDEcxrZWX9fC0vkkhDspzw9VWnSb8UoOUpZQ/7d/4ouPmgvHPNrPIIpDWidBUOuiL/gT
         2SzOYPj/ggMeTsVyTgO+zGHSIDa+vhdvlUaFG7NFFMMh235WXPtAtUxr6RdzZP7/9J2o
         eVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GpmhOOhkjZn/xPUlAc0Il+1MLsQaxLxLhCEUVCkaXcY=;
        b=AcN6YBM3A+33qbxpsEMxXwqbNImFd5/Idju/vxREwRTaYDiJGie24Da2rlwlkjjORd
         fusRBYZbXKkvAgBkMVmg4hgE5771/l/40i8BS0FrnaJWnSLJ8ykUNwQxGISf7M/xcuco
         hknDHZ9JbQxBxQs8N5M57VhlIRX2hk7e+7PUBBDa6ehInu2Y4LKBtqL7AgjyYR6oU4yO
         MsSH1LW9y8UCJoxgZXXTV7um9nqsqw7m567+fBLutW8NqRbzl2SGbXgSoSCpm6b6W2Cf
         BfZR3G2pbkNMR3ETHjiNsM2Q+SuYmpQeTxd49MQAxHoOw3jktKpJuO7e7zvaXGYRmzm3
         qDjQ==
X-Gm-Message-State: APjAAAWl0ShyDj/qoxW7cbXiBFN+zVHmzB4X+tvtwsEdhHzNiXjMnMmj
        XVLpVwakUCafy2a+deA/dS/lgQXjDKA19Q==
X-Google-Smtp-Source: APXvYqwuGRL9zpfvmjxOsypOQVucm/W3gHDymvkqRK/j43viONqdygL9QT+paQgK/bWk97ALxnOYMA==
X-Received: by 2002:a63:6a81:: with SMTP id f123mr12979749pgc.348.1565271301170;
        Thu, 08 Aug 2019 06:35:01 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:186c:3a47:dc97:3ed1? ([2605:e000:100e:83a1:186c:3a47:dc97:3ed1])
        by smtp.gmail.com with ESMTPSA id f19sm142886966pfk.180.2019.08.08.06.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 06:35:00 -0700 (PDT)
Subject: Re: [PATCH -next] lightnvm: remove set but not used variables
 'data_len' and 'rq_len'
To:     YueHaibing <yuehaibing@huawei.com>, mb@lightnvm.io,
        hans@owltronix.com, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190807131847.62412-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <93b23b81-cc4e-4008-cffe-38f87da11481@kernel.dk>
Date:   Thu, 8 Aug 2019 06:34:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807131847.62412-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/19 6:18 AM, YueHaibing wrote:
> drivers/lightnvm/pblk-read.c: In function pblk_submit_read_gc:
> drivers/lightnvm/pblk-read.c:423:6: warning: variable data_len set but not used [-Wunused-but-set-variable]
> drivers/lightnvm/pblk-recovery.c: In function pblk_recov_scan_oob:
> drivers/lightnvm/pblk-recovery.c:368:15: warning: variable rq_len set but not used [-Wunused-but-set-variable]
> 
> They are not used since commit 48e5da725581 ("lightnvm:
> move metadata mapping to lower level driver")

Applied, thanks.

-- 
Jens Axboe

