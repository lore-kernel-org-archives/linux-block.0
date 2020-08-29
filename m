Return-Path: <SRS0=CCtz=CH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76D9C433E2
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D8B207DA
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 16:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QbRKLoIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgH2Qzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgH2Qzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Aug 2020 12:55:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F6C061236
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 09:55:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m34so1960958pgl.11
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gpCk8VygJk1zZ08Ty15aVZKL4rkUM5lf7IFSkXE+mKM=;
        b=QbRKLoIW/ndCidQfvSQKq6pdqhlWDnCNAIJWHE1fPzXe9c8+V7UpvHganwEBvpocr8
         xbJk0tF+BJQ/XtrOPdjlx6PjP9i24tfRlisOC7YlXlHj4lnp8X90mWLmsQ0jaIWH2RyS
         YMlSI7WKjDoSpIJ2t+MMkeeMvFtTKbzRE1L+Uqm541YgLso2hKVfwbhJ+kHW9Ikb+GWF
         foe8UwKa7E55gGQGlmCpqrQi8zvRn3SsVi6CK+Fs+1+UZEPtG01pom5JNsOgy46D1Ueu
         VgBBu6UO+1Y5iSTgnU9lGZHewpj8qN/ER8kD0CZGlTP/1zZZxfotc2AL29KX/sUh+5LK
         lfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gpCk8VygJk1zZ08Ty15aVZKL4rkUM5lf7IFSkXE+mKM=;
        b=JTtyH/9neSjX1uB79hrxl9XWAOn/dvUnqq4sHYCxxz0OFgrCiLfCiiUMd5EQ7POFBq
         3N1ElE1Kh2Ds2O2gMuvUl2jvOunocbXHe72DvrXpm0YJv7uwtumNSgE6bPI6sLYw2fvz
         jYp1VTcQ6ETh/Sp+beF/kRBiPCwxx+5cGdanAj4mlJYppLE8EZMHBmB2o7+J6PFVzG/f
         xHNFALVVyFAqHz3LRf42337yswqsgv6v+xrcHTORkcjgjFJ0rQyrYWlCXeuQia/yil+r
         vG0o+TvF9zjmENCZtPZgWHF06g3JP2e12lxYYsfFefG/JPtl21Vd+uWf1Yv0xjS0v1fB
         0MUQ==
X-Gm-Message-State: AOAM5333u1jy3raxlF83FbHS6MdsJCSyaAtxASQXhsIgTb3eACYPTDZl
        4CAQZyXdj8WvubmfNDr9EmlPmQ==
X-Google-Smtp-Source: ABdhPJzpX5e6UXpjfRs8fVs5NiULAPs3P32fOIet9239Y9oMqYW/uFqBsq+B0saHLNIqTBWsY1HdMA==
X-Received: by 2002:a63:4621:: with SMTP id t33mr3075897pga.32.1598720141968;
        Sat, 29 Aug 2020 09:55:41 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a5sm2947812pgb.23.2020.08.29.09.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 09:55:41 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.9 next rc
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200829153243.324252-1-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <18fdb68f-8747-6f44-de0d-390a3fbd41c3@kernel.dk>
Date:   Sat, 29 Aug 2020 10:55:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829153243.324252-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/29/20 9:32 AM, Sagi Grimberg wrote:
> Hey Jens,
> 
> Some more nvme fixes:
> - instance leak and io boundary fixes from Keith
> - fc locking fix from Christophe
> - various tcp/rdma reset during traffic fixes from Me
> - pci use-after-free fix from Tong
> - tcp target null deref fix from Ziye
> 
> Please pull.
> 
> The following changes since commit a433d7217feab712ff69ef5cc2a86f95ed1aca40:
> 
>   Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9 (2020-08-28 07:52:02 -0600)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.9-rc

This doesn't look right... I pulled from the usual spot, diffstat and
changes match up.

BTW, in the future, can you switch to signed tags? They are nice to use
in general, but particularly for git repos that are outside the kernel.org
infrastructure.

-- 
Jens Axboe

