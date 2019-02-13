Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D0AC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78665222B2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 14:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xPgee+vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfBMOc4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:32:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34997 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbfBMOcz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 09:32:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so1255288plo.2
        for <linux-block@vger.kernel.org>; Wed, 13 Feb 2019 06:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IyyLoqU/dsGoyqGaUNq5ipSXtk9haMKmqrRIXAEiKaI=;
        b=xPgee+vZ8gEbBefm+ekseYolomj7hAzp7HmrL7351q4aunRJ14op+CbaIU22Uurqru
         MwvVkNa0XrUbdVzqguIWqJd7LSE/b5H3IEcf67jpQk9tAXyCMlzglcs1lqeyNUg+6SdW
         Nv12GYVKDQ3fNl2ndBed/dqbdNOHc/FDErR7MiinvJomb6tFjdFXHST39mPCJzUfkZVJ
         gwe/LRW3Er6vNi5kSPCsx4+3tg0KM0z4v4Q/y1v97FEcfZUJrLBgL/qiHnO2T+4HphJW
         m9SIPxHj5hvx0XMEg54aYSrOr5kzWfNHFZVYWUr1YT1dqHIWKodI/cKZF/N3jPDLkL7l
         kgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IyyLoqU/dsGoyqGaUNq5ipSXtk9haMKmqrRIXAEiKaI=;
        b=Oymx2loN8a1lcOpVDjHPfnLudungp3OmZFTt1iUmFocUR8basIZAVD9eDZuN5lRG9U
         vg9ajG5zrYzvc8FbLPolxNOYoj6Njfb6J8/o2b8gt73ZFE/ELZgU7v25bnNB1ko3Yj55
         ZzNNvwN6xp1tnXPxBo1QjKAajGQ2yUMuMrGpSm91aR+IJpsOFf/GtrthSfIcIJbAqFT7
         eGMMxJxHTn90+j/u3Ki+BQY2HsGRto/U5jNDXgBiAThCIA57CmOA4/mwSlpHdBVT0zL3
         T0KWIhgr7pPZfEVhGmXY/dmbD+nI8ZamJ1KJlVXQTo1X0TYGikJfXul8Gyj21zylg/8C
         qywA==
X-Gm-Message-State: AHQUAubPo1qngVnMa/GOK/rHISmaU3/k3lgtVvySUCV3Y1Zl6nfZTFJW
        jxKGK+jLOb6DiE7D3oGGjA8qDw==
X-Google-Smtp-Source: AHgI3IaKVW8dnmxrk3TxuQ7z7vmbe516YOWo2atafen89bz37phI9j23HCY8fCgVFQl7LTz5ifwprQ==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr776144plr.221.1550068375177;
        Wed, 13 Feb 2019 06:32:55 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e81sm13477895pfb.65.2019.02.13.06.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 06:32:54 -0800 (PST)
Subject: Re: [GIT PULL] nvme fix for 5.0
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190213070438.GA11528@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b134687b-0bc6-94c6-b220-be419f17fa39@kernel.dk>
Date:   Wed, 13 Feb 2019 07:32:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213070438.GA11528@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/13/19 12:04 AM, Christoph Hellwig wrote:
> The following changes since commit aef1897cd36dcf5e296f1d2bae7e0d268561b685:
> 
>   blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue (2019-02-11 19:51:52 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.0
> 
> for you to fetch changes up to 4726bcf30fad37cc555cd9dcd6c73f2b2668c879:
> 
>   nvme-pci: add missing unlock for reset error (2019-02-12 09:29:07 +0100)
> 
> ----------------------------------------------------------------
> Keith Busch (1):
>       nvme-pci: add missing unlock for reset error
> 
>  drivers/nvme/host/pci.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

