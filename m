Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29784C433DB
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 02:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FE223AFD
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 02:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbhAOCsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbhAOCsu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 21:48:50 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3660C061575
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 18:48:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c79so4593357pfc.2
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 18:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VBUZdcggrTG32P70SFIDXvoYqHmBkktzAy9HqU8P20g=;
        b=zhWnq/wpGQOBbp7JBCtwNzJ5XhZDwUJ1MenpPxAtUzWvCWF3V+HjQ3GxzvNexjW5ca
         mN2s/LaqNo+jPY58w3jmS/MGibwqLFWxS9HR7nks3nMrzGdSSFGmSWxSXjhM3f/obA8b
         5AJV+B/0bljBqfYryGpi6T8m1FjRM3Q2THp/LigqFjSM4+tFBYJf18ccpvM7skvBf8lN
         DkygQtzV72g2Teb2hdsAxajPRqHK6TY3zNUp4hDHRFX70fqrz/inBRIx0Kv6EJ55qYXS
         JvzPLSugDEfJmEah69osuAxt2+w1JPBl2pi5X3aUTa51iBP2QXdmlD/xhQaVLza0YtGi
         B4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBUZdcggrTG32P70SFIDXvoYqHmBkktzAy9HqU8P20g=;
        b=kWa8sAABqvN7VqtSykn3joFFVJ5FL7MNGgGHt43oJnWc1FgGNPUoJjBZYuP92qoFrv
         bQIvIBDeZezqyiV0hEhFpoKTnw4pEECdRHjBEAz4DJXV4cEO6KDsk64YHzuzBaAZfTCI
         vX3y4HNDjQdqjhIF6GTZWFqlFbZMp9t+MjLIgVoMxtJ66qPZz+CY5+F+qwOEg+7L3e/P
         4+/872RDYKAmm/m4zPHZGIoTj3kAX1bqwWTUtPgQ7rXNTCMCNYasTnp766OnJMVM0FnJ
         ztiExcw33sMWHppvC9XOaOY4v766+KvPYl62D86hvubOEw3G1hhM5jysT2Y8L3hJtn6B
         +mVQ==
X-Gm-Message-State: AOAM533oWNr9iLATxktkVAoiyVXsLj5mDCI4E70jkAHd9WJPx1m+pVmO
        5Sstrx/sEvHgQb0NiuEVFaRKHQ==
X-Google-Smtp-Source: ABdhPJykHopNnFQdYPjpD7UAHWaAKrFP1nGCIiWR4dYmrTxCAJAL8habRAohWA9rp1F1wQHbJlEJRg==
X-Received: by 2002:a65:430b:: with SMTP id j11mr10208273pgq.130.1610678889371;
        Thu, 14 Jan 2021 18:48:09 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z13sm6747135pjz.42.2021.01.14.18.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 18:48:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 5.11
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux NVMe <linux-nvme@lists.infradead.org>
References: <YACbrIes4r8Qa1mA@infradead.org>
Message-ID: <ac34b82a-1391-7ba9-834c-daabaf65d125@kernel.dk>
Date:   Thu, 14 Jan 2021 19:48:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YACbrIes4r8Qa1mA@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 14, 2021 at 12:30 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> The following changes since commit 5342fd4255021ef0c4ce7be52eea1c4ebda11c63:
>
>   bcache: set bcache device into read-only mode for BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET (2021-01-09 09:21:03 -0700)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/nvme.git tags/nvme-5.11-2021-01-14

Pulled, thanks.

-- 
Jens Axboe

