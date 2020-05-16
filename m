Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D345C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047DA2065C
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BhLxWNEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgEPP0J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgEPP0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 11:26:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A5BC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 08:26:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so2197660plr.2
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GqzWFnVTxjwBGNcbYipaqJo53cuwjB0S+zYqBcFej6w=;
        b=BhLxWNEcJbG6K7j/aq4QnOk+4VaOIYk2HI+nR0FaRPpnYqGyF9Gg+GSZrih9asvk8O
         bmWm/IZKpaKE1HCTlo8pn/os03TgUIMTLVNq8Ga9UxwzKqKnThAC92XbK+lAzCUBPTbq
         M2geh1SL495P7k/9qHAA1rQK10AODN7MHDlLURzy7lZlp5LrRl6p9ktc8vuL5gR61VFP
         WCR6gK9IBBpQKFR9Yc6LPhuqGJFzdmK3lfoSGI7yiyfhzuyXnjYY8oOxQ2xJb3jxHFx4
         7p8jCxhinQrPfPowhTMwaV0r0YKcoUqFcMw6+QBDbsobyEtR2GcxqKnvx9trtlNLXUrB
         9NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GqzWFnVTxjwBGNcbYipaqJo53cuwjB0S+zYqBcFej6w=;
        b=kBeCkW+76nX1PEHR2dAE1+jW1qsqPViTfEaBSxr2tro0ZF+rW9wxQ4EPeXd3gPiaEU
         4uL6MvG5jFfpN+0KS7ARFUk2heAXwAmYldmSb8/oKInisDCw4JDCG7r/3tU8Z8vWBTRt
         T4IaOxjKWVPsfCDPAboH543H1xi202RydOMefR7R6gtBGpD1MPvu3sEm7G/tDSKU3iFv
         iNfoQ5qYnK8q5ekXRGICqGHzwxYo0M0EFUj9bHP4k8sEgyjqlye8rHz4mVAvbN34+tbq
         kXlC/jgukhce2a5lmBRbVsWeUXU35/LB8aGXBj2MjKOp5EiaSm+DgHLvej8cJq2HPILw
         HuBA==
X-Gm-Message-State: AOAM530z2HO+LG6OjrEs5pF25TrNnYj6Bzotc3+6B/779P18pPcn6LYn
        1QhheWXhRsCdr8/Ff1xxjeN4O8TBoN0=
X-Google-Smtp-Source: ABdhPJz52J+Ih8aTAkNl1FeoEfxtnrZEKpLUTWWqYrN8eXiwQh+SiV9dmUxW6YuBW1NbSBFvBvZAtw==
X-Received: by 2002:a17:90a:24c5:: with SMTP id i63mr9444265pje.98.1589642766791;
        Sat, 16 May 2020 08:26:06 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:d12:e022:17e3:128? ([2605:e000:100e:8c61:d12:e022:17e3:128])
        by smtp.gmail.com with ESMTPSA id y14sm3981799pjl.1.2020.05.16.08.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 08:26:06 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fix for 5.7
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200516132532.GA244143@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b693162e-0a1b-10be-6d49-fb278d27dc8a@kernel.dk>
Date:   Sat, 16 May 2020 09:26:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200516132532.GA244143@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/20 7:25 AM, Christoph Hellwig wrote:
> The following changes since commit 59c7c3caaaf8750df4ec3255082f15eb4e371514:
> 
>   nvme: fix possible hang when ns scanning fails during error recovery (2020-05-09 16:07:58 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.7
> 
> for you to fetch changes up to b69e2ef24b7b4867f80f47e2781e95d0bacd15cb:
> 
>   nvme-pci: dma read memory barrier for completions (2020-05-12 18:02:24 +0200)
> 
> ----------------------------------------------------------------
> Keith Busch (1):
>       nvme-pci: dma read memory barrier for completions
> 
>  drivers/nvme/host/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)

Pulled, thanks.

-- 
Jens Axboe

