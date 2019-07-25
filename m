Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5123C7618B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0A922C7B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Aw4o5QSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbfGYQY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:24:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38846 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390437AbfGYQY2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 12:24:28 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so23344456ioa.5
        for <linux-block@vger.kernel.org>; Thu, 25 Jul 2019 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+VPzjzJbmRozJIvTKRd41RQ1wR4Ggz73XJuu/DaeZOI=;
        b=Aw4o5QSPeXfCC0cUBILFJ39Ujxpj2PDCQA58od61nHc9KeJHRB3XIaCcWsKI/+c4iP
         1xZ62E92cHcFPxZar05zfHc1RffcUAhok3vq04x1K3s4KfatrYAOySWqUA0lmNZCdvI0
         d8lpZgeYmu6RbVpWyYw1Jlf8eiW1ItmqCOwkIzdWJzLb906RSDnWu9i03actatrW7mWh
         6YHRfYGJqolyTjVyNejVg51ES4UyK1GR2a6XK2RW+q7BgjuxwvkZwl+Kbse5Ed4v6QPW
         pXfE8Ixyg+KJwjN54OhADvfEgZLAFMOH0y2PneIOGG2XTRbWnQrrK3n7I1b8XcGBziRJ
         Xb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+VPzjzJbmRozJIvTKRd41RQ1wR4Ggz73XJuu/DaeZOI=;
        b=NZliqPTacNUarKs/+dzKfTZmrAwA5fmiJCqD/XUvPURjHgysTfGYsddA1pxarmAaD6
         jF2VfoBrRbEzlVLOVaRfSSa8cpAOACuy7U2yCl0b14PIAYeOEe8IOAstZ25mpOFzeNwU
         IaZLM62pIakowMlXcNSVtLJQK8Gv6tNRXh1ybCdZyJB8v0psE68l2e9pJVeZJZD6bFO/
         Z+z2/O/aaGhEcVfKHH5BOlsFcvK+Ve9JaLKSz6CFz3SgoLeFrk1Kr9gaJJIPM+GAC1NH
         fGdnfpDWbkNQZmn4cQdiNoT9sFr3ppEO+b/X2wx583aA2olNRzCeZ6ytIuYOnKFXU9wq
         qN0Q==
X-Gm-Message-State: APjAAAWwjR2GhTBtdA4x9gU7O6B5MAd5KIUmk7/FucODzeMGXahs9HTN
        E2pHc9EJEpa8st4DsEVnLm8=
X-Google-Smtp-Source: APXvYqzLbWGkPs++0ubPK5ICYVIG3stE+tmXo13HNSwsXkens1k99m8h9trJRSm59YMMoXLhCFO55Q==
X-Received: by 2002:a5d:9908:: with SMTP id x8mr32048739iol.304.1564071867888;
        Thu, 25 Jul 2019 09:24:27 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c23sm41593655iod.11.2019.07.25.09.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:24:26 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.3
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190725141245.GA4339@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1bda303-27f9-8c5c-3cb1-a2bb58c91566@kernel.dk>
Date:   Thu, 25 Jul 2019 10:24:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725141245.GA4339@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/25/19 8:12 AM, Christoph Hellwig wrote:
> 
> The following changes since commit 77ce56e2bfaa64127ae5e23ef136c0168b818777:
> 
>    drbd: dynamically allocate shash descriptor (2019-07-23 07:35:18 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.infradead.org/nvme.git nvme-5.3
> 
> for you to fetch changes up to 8fe34be14ecb5eb0ef8d8d44aa7ab62d9e2911ca:
> 
>    Revert "nvme-pci: don't create a read hctx mapping without read queues" (2019-07-23 17:47:02 +0200)
> 
> ----------------------------------------------------------------
> Logan Gunthorpe (1):
>        nvme: fix memory leak caused by incorrect subsystem free
> 
> Marta Rybczynska (1):
>        nvme: fix multipath crash when ANA is deactivated
> 
> Misha Nasledov (1):
>        nvme: ignore subnqn for ADATA SX6000LNP
> 
> yangerkun (1):
>        Revert "nvme-pci: don't create a read hctx mapping without read queues"
> 
>   drivers/nvme/host/core.c      | 12 +++++-------
>   drivers/nvme/host/multipath.c |  8 ++------
>   drivers/nvme/host/nvme.h      |  6 +++++-
>   drivers/nvme/host/pci.c       |  6 +++---
>   4 files changed, 15 insertions(+), 17 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

