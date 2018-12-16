Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB2EC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47388206BA
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 15:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U8Y3aqWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbeLPPpo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:45:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41861 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbeLPPpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 10:45:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so4927546plm.8
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 07:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=odKBxFgga6Yiurj5SrTSRwdVIYVR4cLhPbRKQYhN00c=;
        b=U8Y3aqWu/z+jRfWk6g+bnPtjJ9rQPWepZ0Ka6ahlBsbt3D6DgZrPkGFUvv0bw0UfEm
         0Z2agrCNtDHmHVFLivTD2mh6p0ROVKGIBSDMW4zU2uJPbwnUVO9Pw0E6dS31IHKfR56C
         cZciG5IXs4UqlrAVCY0u5C//EN8+nK8MpTcOpIz858CsLqyNzSyT5jAUC7qjxc+OglJy
         J6M+I6deXBRuVydzpQoXkgdxi0Lh1nsLrOpLQM1Qy7aMvk9m+vJ1ofwYjcclaZlP79kH
         G6OxQN2DTazGb6j7c27m1PtRejyou/5L8GicwWoeVVQZC9HK+csamHyc+3+tLY7SjQWU
         D0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odKBxFgga6Yiurj5SrTSRwdVIYVR4cLhPbRKQYhN00c=;
        b=Q3Hknj3AzY6MLdx1GaYdehMgXuyfArW3ECGZLoRVrs99dHdqkMcJU21NWUSqw0uclP
         kEw+2C65hSoUFhjsJ5Gpbtw5ADcGu6MKtA3QqZBu2oprmx8XZA6KuqHmutsHNVmOt/oC
         Ra23Wx82lEpKpRgUfVGRzU3t86Pba9yUnTTq9QKN3kcAaAd6ygeCre3nn36cbJBorTT5
         XGVttf/V9W1mBad33ib7O+CfbjbzLm10MunPquU4UrcGOEegmvlsP20ulkrZyN/oywNU
         V1Z+Oev+DlbL75+GP8vY31l3/APUss2hzAIM9UEKDnNoeOKbccrQzFYlPmtKtskho8Hk
         uG4w==
X-Gm-Message-State: AA+aEWYEio8cCIUldU4CRUZ6WCier1fDdQMdc2VAylxwa9mzZ6FTv0LC
        HDyKDbU4kRbkrNgymGXeAFOomA3dK9GTyQ==
X-Google-Smtp-Source: AFSGD/WDsXfPgNZSCNjkv0+Hq2XI7kpZHEDtPF5jZMqFrl+G1duaq/jJa1BrOm/Tkg0EOLQa3gVW6g==
X-Received: by 2002:a17:902:3383:: with SMTP id b3mr9526901plc.170.1544975143167;
        Sun, 16 Dec 2018 07:45:43 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d129sm16660895pfc.31.2018.12.16.07.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 07:45:42 -0800 (PST)
Subject: Re: [PATCH] aoe: add __exit annotation
To:     Chengguang Xu <cgxu519@gmx.com>, ed.cashin@acm.org
Cc:     linux-block@vger.kernel.org
References: <20181216060818.26986-1-cgxu519@gmx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7dbd36eb-16d4-1a78-8d64-9ebbfe9c5c0c@kernel.dk>
Date:   Sun, 16 Dec 2018 08:45:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216060818.26986-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/15/18 11:08 PM, Chengguang Xu wrote:
> Add __exit annotation to cleanup helper which
> is only called once in the module.

Applied, thanks.

-- 
Jens Axboe

