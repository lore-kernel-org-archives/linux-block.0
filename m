Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F288C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E362073E
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 18:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vIkkeK1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGBSLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGBSLy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 14:11:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704F3C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 11:11:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h22so12863576pjf.1
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+xvSQSVLi9qjNChiWcvmHMeE7PdhPj01xUVBnDWHVZo=;
        b=vIkkeK1f2M+ZUIi5TVUzVnaCz+/9ofM6TeInaeP9CX3/4+fPgzDwbKEajj9m+RV+Ze
         vLr9D5cHB0p1+T5DsrPksUaxjz5/JNK47pTpeU7FSRyzvJFuXZ0V/GwCQGoQC/PjqPO6
         STDhWeVA5RXbt+1MXg7aHXNfFb/Gee9wvkcXulQu8aCEfoybYv79YpGbV9ogiwgJtErI
         quSn9+G13Fnv8KBYH5m6kig4YkQaPQ6rerf4VMv2XyXPRgz+m9KHcgDcpyO7di12qSC+
         Q6QxMU7Ur5KHnwvbwQz18xFxXGA+An7R2wOrIsK9QzK+YReEDKgGnM1L6DD32UltYQIO
         o+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+xvSQSVLi9qjNChiWcvmHMeE7PdhPj01xUVBnDWHVZo=;
        b=gaY4Ixe2t7BEmrDbBa2RlD6NyFe6AscsBBqZAstjnmu6Rgpa+BJYqwLdTz80oaW4uw
         Qjrp5t23tKvDJTvZxYIdicUrme+fqpPBtgVkqaLoVF1qPXen54RZMWgfSEfDt0iV7Dl5
         X0XEAV8rjS6O1URLVEUeCF/bhaZ8d6vouThkadYI+5mEiDoOXWmfPI6Y7RXahRJir6RF
         KDQDAF3rbrTcDfL4/FjM9KilwFVjT1MasyhrklBDFzZrmG0Z0UXlDUOtSfZiNW9EHfA9
         gaWrS5ivBrphp4P3qOtnjoCBoYCxA/e9O5SLivhr64iHALvhQkVJxj/4fGhHKNCplMk9
         6eOQ==
X-Gm-Message-State: AOAM530wTVNbtYwkKZLEbjUs+a5hvgbE2h7UIE4srg0Sl+n4Ephv291f
        o1fv1F6bFvbKYmXLdOv8V0k6LQ==
X-Google-Smtp-Source: ABdhPJxPWhlvrfExBBerGxc/tmSwb6mhWXRYPDne8ntGywD7UHhakw189oo11S3nWuDViuLXoJGQwA==
X-Received: by 2002:a17:90a:3489:: with SMTP id p9mr34276441pjb.56.1593713513925;
        Thu, 02 Jul 2020 11:11:53 -0700 (PDT)
Received: from [10.174.189.217] ([204.156.180.104])
        by smtp.gmail.com with ESMTPSA id l22sm8238485pjq.20.2020.07.02.11.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 11:11:53 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.8
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200702084207.GA3718469@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8368fa84-18ff-5a7c-1549-c80b8fced17d@kernel.dk>
Date:   Thu, 2 Jul 2020 12:11:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702084207.GA3718469@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/20 2:42 AM, Christoph Hellwig wrote:
> The following changes since commit e7eea44eefbdd5f0345a0a8b80a3ca1c21030d06:
> 
>   virtio-blk: free vblk-vqs in error path of virtblk_probe() (2020-06-30 19:02:58 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8

Pulled, thanks.

-- 
Jens Axboe

