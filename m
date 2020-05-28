Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B1C433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 14:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54A5207D3
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 14:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EHF+4bl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgE1Orw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgE1Orv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 10:47:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A713C05BD1E
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 07:47:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so11629190plr.2
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QP3G9NO5yNP1BJTlSs3uwEigbTBL2kpS3PFyQQNwc2g=;
        b=EHF+4bl2qFJnT1B1Rt5RQfwNP+5VkISqvB8CWWY0IRc3szs5eLb6P0KyDIgxUxRmiV
         H6IsmTjW7VJM6sW7SXZLe/tahlj9Rm/rwkT6g4Gz1RpluI3Ynz8sHSN4aH39kuhQ/hzh
         XJIvMph7YnM6IggOy7s+Rg8P0Euinn1BqXGDi6sVm1uC6ATOpVMtc2b+SrIGGSSRozx3
         1aMFweUd/x2vTQ4katGZ8+AoYTl/kg42gLvCmgLQJTaynbj9MWtb+US0YGpnU86s86Ba
         7LLBAR+FLbvLVy1ImzL22BbIZtwIHgnth8n6pAZPrsH86jSCDecvSGJpKeTt9/GOetBk
         t8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QP3G9NO5yNP1BJTlSs3uwEigbTBL2kpS3PFyQQNwc2g=;
        b=f/+BmBcGpr9zk8CjyY1OX8U9cKiuXV+KREpQ3F6sEKpIuTaDlOSvQokp0M3UEnMe6G
         dMyc3zZaznLQyCb47qYDQ0C/83qvCPNXNfV7TMpTcJU2Wd/sh/VBtSAhOV25+ifhTO/+
         /LY3OHaRzUq6+luUIvMNFC4vFR0uMUQzR9eGl2UjiFq0+vtjfnTVJSlHd/I0pDZ5Ahxr
         tvJc0H+IlvzW0wGsjPULTvq0fIjHb/Ox2m8vSmLLfhM8NDn/72ttROYvLw4gR7eXEjt3
         UKK+XweDkB9xLZWjOB7/BbvwBRnDhdxqyRLy0uSry4In4wuGn/Zpl/L8ZHuMDGTc5kI4
         2alA==
X-Gm-Message-State: AOAM533urefgv7QP3Ri5FOaZyuiV9+fGhk2fmztu6h4pc3RletLVWXVe
        hvFyF8t2yqWDphn/6uwcLo/j4vU22QPDAA==
X-Google-Smtp-Source: ABdhPJwsjW9BsLbmfVoO4F9R0HG3hphc4xmMei3OyYhgdwvZ1okd5XvFvw/6cuWkLHLeiSBZuznUcQ==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22mr3943095pll.232.1590677269657;
        Thu, 28 May 2020 07:47:49 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o27sm4876050pgd.18.2020.05.28.07.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 07:47:49 -0700 (PDT)
Subject: Re: [PATCH] block: fix a warning when blkdev.h is included for
 !CONFIG_BLOCK builds
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200528134123.923849-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c51a27a-868c-9241-aa31-5a0ad0ae8b0c@kernel.dk>
Date:   Thu, 28 May 2020 08:47:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528134123.923849-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/28/20 7:41 AM, Christoph Hellwig wrote:
> disk_start_io_acct and disk_end_io_acct need at least a struct gendisk
> forward declaration, but for weird historic reasons much of blkdev.h
> is stubbed out for CONFIG_BLOCK=n.  Fix this by stubbing more out for
> now, but eventually this header will need a massive cleanup.

Applied, thanks.

-- 
Jens Axboe

