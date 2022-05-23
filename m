Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F066BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 12:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiEWM2y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 08:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiEWM2x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 08:28:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D639841632
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 05:28:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso6060257pjb.1
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=BQG28UlEYcr8A85oce3InSxdg5B3vG0GxSj7UdX4+lw=;
        b=Tzc2jBqSorBWlTvHNHN3J56nJpaB2gvtmIahJMNSXGXeQp0JiJd2wrRQB6zQx8J4i9
         vlTYgc1xWYPBdGVCp0aVzcCpvfrG4pt6rODRiajfh07yZZOxBv90OzkaTs5PZoFvJCAM
         FmmRoYI9U0bd6Qw6xVP/CQLZWEFXyLrJLIwlzdPxVgsM+Km+OIyGFj4Tg+CioLjNRvnz
         pG2+/HYbs1pQSE9X360fLmSUkuQk32XFf+PAdfrfMzkqFZAAOcDz1sN+99nqvckbjfxl
         rvEZeutRD8+V/v0QryhIIwMkQc0nbldXvPGRQCVp8zK8gRBHEaan+SptkyCttyUpOWhC
         P5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=BQG28UlEYcr8A85oce3InSxdg5B3vG0GxSj7UdX4+lw=;
        b=zIkrSpe3CDoJFBc2Xh+K8+uUEFhTPJC5rmtp3+O8nXu6h3IUyySTPk4NvahfP776QI
         sTmcKtfs+5Gu0vVPJKVAaFBXXf4acTep838qJm3I78UridAtY7rsZUe+/67MRBmQVdMh
         Q145GPLEK5Sbv4lNNUsv/lwmQdDAgTzcPa1n3nged007/F6B4C+EudGeLz4MTNxHsKj8
         dJ2vzeHPeSOkoQ31Zn3/hRI5BaCL6W/SWNWcLsJGtZXY8eMP2ASh9cr91u7YymsvJSLo
         RGJZZ+T2Ase/F3gnl9VMx1PTU4sHT+CqCq1SWcgUPm1SwVBO9jXKywMiMxta3XPoX4wM
         7qIg==
X-Gm-Message-State: AOAM531XxvvbdJmynam1pw6twrmYxv3r+YGUeKX///qguytXf79afznf
        whSBio6i3VhkZgMULMtLvrKZV7iOtP2COQ==
X-Google-Smtp-Source: ABdhPJwsYBLu6eoFsvyNaQNTkFYbNgelSEItCSF9TU3j+Uja0+5qNOIoSffjHfwZnsAKgku3zKG3GQ==
X-Received: by 2002:a17:90b:1b43:b0:1e0:4bda:13bf with SMTP id nv3-20020a17090b1b4300b001e04bda13bfmr5573438pjb.109.1653308931137;
        Mon, 23 May 2022 05:28:51 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n13-20020a056a0007cd00b0051844a64d3dsm7146881pfu.25.2022.05.23.05.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:28:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, jack@suse.cz, yukuai3@huawei.com
In-Reply-To: <20220522122350.743103-1-ming.lei@redhat.com>
References: <20220522122350.743103-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: don't touch ->tagset in blk_mq_get_sq_hctx
Message-Id: <165330893019.361005.16959517425064628353.b4-ty@kernel.dk>
Date:   Mon, 23 May 2022 06:28:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 22 May 2022 20:23:50 +0800, Ming Lei wrote:
> blk_mq_run_hw_queues() could be run when there isn't queued request and
> after queue is cleaned up, at that time tagset is freed, because tagset
> lifetime is covered by driver, and often freed after blk_cleanup_queue()
> returns.
> 
> So don't touch ->tagset for figuring out current default hctx by the mapping
> built in request queue, so use-after-free on tagset can be avoided. Meantime
> this way should be fast than retrieving mapping from tagset.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't touch ->tagset in blk_mq_get_sq_hctx
      commit: 5d05426e2d5fd7df8afc866b78c36b37b00188b7

Best regards,
-- 
Jens Axboe


