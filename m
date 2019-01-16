Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F26C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B07120675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 16:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yvnSA1Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394120AbfAPQpJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:45:09 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39349 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfAPQpI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 11:45:08 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so3578456itl.4
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 08:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K2ro2jNi0z3gTscGjIrTMp2rBUzrDM2swzQp3Myz/OI=;
        b=yvnSA1Q2RFh8eR8tWGSqM4KAHr2jQ0XWSmIoqIHfLhTb7BJ75+B41XDd3fqvKXpQK4
         V9qKTdK4dHmIfx+DliNG/M7O7xzflj+xotana0YVDsqgLl3wpdEStC/x3sIJ5M/wNPxV
         QB18V9J1gzNWOlCj1PM34CRHoiPVyxLw68xzYKrXaTp2oJ5NY6Zv5tt2SZYbK3MgPfvd
         82EnP2j69VOkTB20B4w7jtcF+d8jE42FCo0GhW5BURVad/TMaERGq88uY4SAs7NhskT9
         Z12OkSDYRaG29BeglkwtaL874F0r8ycGqis8l8HVlg7v0o34H/cgYqd1ZYffP/X5HSsj
         +cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K2ro2jNi0z3gTscGjIrTMp2rBUzrDM2swzQp3Myz/OI=;
        b=eb3VyWPLHvwUHHK+6LGwr4WCdTys38Cr2G/MAP1psHqVF/+k2G4ZeSGwIkMnFuvL1f
         o8ZA+qzlGPLPeGd1HewzQE3C0HfxUkuXmO+EU/hZl2IsRW2dxLvapkEAfBu6tfhi3zgP
         /2QFAL2R15IiCw5q+VVf2GvmcmLeaujvbH90AVL8iQXRnZteX+0haAZFDsCgQd1HeHRl
         wCqntLCfKsJ5d6WVQHeLnVmEe3zOGXebTvya7zYNEufmOz4KvRAPCGeyGZPiKCBElRpN
         4jImXSoigoNDEC0fIdwCwfeSAgVSHYRDEYTdtncwXjebbNjoYOdEruTh0QlcOM5M7HOP
         NH6g==
X-Gm-Message-State: AJcUukdWxIhUwHkqfdc6N+23Zfon2m8WC+gg3LioYAQr00qmT7i6KW20
        2yMApguIfe9lK438jIqmys1BFg==
X-Google-Smtp-Source: ALg8bN5oAsQ/WfYuBQ12vFAA4soWt5RoEfMVYoB2MjkZAzCeusP0wUH7p60DFWIY2fLt7VFG288ogA==
X-Received: by 2002:a05:660c:1cc:: with SMTP id s12mr5711961itk.33.1547657107986;
        Wed, 16 Jan 2019 08:45:07 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id g12sm2469335iok.38.2019.01.16.08.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 08:45:06 -0800 (PST)
Subject: Re: [GIT PULL] two nvme fixes for 5.0-rc3
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190116163724.GA24217@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <57fe0e8e-1402-b3d8-4297-c9bf7488369f@kernel.dk>
Date:   Wed, 16 Jan 2019 09:45:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116163724.GA24217@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 9:37 AM, Christoph Hellwig wrote:
> The following changes since commit 8218a55b6b911d396565da4ed5ca8b18bf0d38fb:
> 
>   sbitmap: Protect swap_lock from hardirq (2019-01-14 21:30:32 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.0
> 
> for you to fetch changes up to eda14f8977df052dce3a9c54a6bf8d8f76c96eb1:
> 
>   nvme-pci: fix nvme_setup_irqs() (2019-01-15 06:50:52 +0100)
> 
> ----------------------------------------------------------------
> Ming Lei (1):
>       nvme-pci: fix nvme_setup_irqs()
> 
> Sagi Grimberg (1):
>       nvmet-tcp: fix uninitialized variable access
> 
>  drivers/nvme/host/pci.c   | 21 +++++++++++++--------
>  drivers/nvme/target/tcp.c |  2 +-
>  2 files changed, 14 insertions(+), 9 deletions(-)

I applied these manually, Linus and I both committed the patch from
Ming for sbitmap, so I ended up dropping that. Looks like you got
my branch while that was in there.

-- 
Jens Axboe

