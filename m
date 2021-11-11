Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77C7C433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 14:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C10C6117A
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 14:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhKKO0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 09:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhKKO0s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 09:26:48 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913EBC061766
        for <linux-block@vger.kernel.org>; Thu, 11 Nov 2021 06:23:59 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x10so7110770ioj.9
        for <linux-block@vger.kernel.org>; Thu, 11 Nov 2021 06:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=qlvjFc13kiLZjSix7h+msJMRnEMmEZNmM+IzPuV0+yc=;
        b=P8gBnrP2edIo8sPhNXlgChFYMba5CIS6/nQMAt5PFFKTnuFIK8OmQRWYy6mLXuOo6A
         rcY3bw3tCE227I3amNFL0chOcu+/HYGyjtbGmnLVXvrsF2yTtiBEcyHDwOwPoSFKSZI6
         STnDJ2A+7TKR3lxSEuRGEyhfK8rFqciOrsC4Ph5vcerw9SfLRspUN645WjxYiqq73DF5
         rwTs4X37NT8nXVxxUGFptR++YaJ530l7PMMMavtjeuZ39NP0ChmBD+nnXqMHxT3NOklP
         qTCKceAOUXZUT9WPH/MXMPN/hWDBLXLhiWnXArxKycWJiLQXR/uEjLJ2nJuuwfC0/Qdm
         f/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=qlvjFc13kiLZjSix7h+msJMRnEMmEZNmM+IzPuV0+yc=;
        b=paaeobIxw+h0++KmKlr+criv3BRFL0hGxEvDgXB0J17FLhnJa0o2lmiWJXdNdK4gLY
         jCWkmlPfngpNL1G6iYv5Za6E3vlVnveifjKyUQ2b7MOyW4+0sHKRXaV1WWJ04zh3N5s9
         4g71Qx0rCGlG0Ap5JO/w0j1zVoRK5xUQVqXJHSPSZrJexevsKTQfeMCIUnWTyjiUiVy3
         taXJVyTrm1kn/XE7uHyMlDeYokLqHx4YgpouZn+lyC3YFfR/FdJeiYmGoymCNhmvl1Lf
         e1XkRoTVN7p9wCQTkCR8DP+xvHsgcmCXGzvhUkftmx/bSxLn6XahQsMzenITgao7GvMx
         rWdg==
X-Gm-Message-State: AOAM532IZyK+RLbARHx8vxoPygHRO+iUZTXoPgNO5+JkeRhJcefWGzcv
        Z9/vwrD70r/OZE9Jj6ILC+rKzQzXoXqODaFG
X-Google-Smtp-Source: ABdhPJyRhcEaD2r2MBC0eCdChgnIKG2Q6RoUP+0m0vv7Yx/Bdt5X5d8ADtLFBwC0SEDhMyFIIuIZBQ==
X-Received: by 2002:a6b:b886:: with SMTP id i128mr5248118iof.151.1636640638654;
        Thu, 11 Nov 2021 06:23:58 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y21sm1666294ioj.41.2021.11.11.06.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:23:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211111085134.345235-1-ming.lei@redhat.com>
References: <20211111085134.345235-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] blk-mq: fix hang in blk_mq_freeze_queue_wait
Message-Id: <163664063817.5662.16500200254816548076.b4-ty@kernel.dk>
Date:   Thu, 11 Nov 2021 07:23:58 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 11 Nov 2021 16:51:32 +0800, Ming Lei wrote:
> The 1st patch fixes hang in blk_mq_freeze_queue_wait().
> 
> The 2nd one renames blk_attempt_bio_merge, so we can avoid duplicated
> symbols in block layer.
> 
> 
> Ming Lei (2):
>   blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
>   blk-mq: rename blk_attempt_bio_merge
> 
> [...]

Applied, thanks!

[1/2] blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
      commit: c20eb570e2c3aaf0890d85fc6d8ab84b8800c167
[2/2] blk-mq: rename blk_attempt_bio_merge
      commit: c7f87443cd935134b21fcc6b76693f45d15fccc0

Best regards,
-- 
Jens Axboe


