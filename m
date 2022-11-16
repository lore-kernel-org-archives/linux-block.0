Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40D3C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 22:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiKPWUy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiKPWU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 17:20:27 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5811B9F8
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 14:20:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p12so17754600plq.4
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 14:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEjKgjdJfrVf8HtFsOf1hWq1pz83a0clNltcH86fMuM=;
        b=AxDY1tR+GKHnPALcIjn81i5WURkI+PBRB1KtXzV0iw8UWZu1GRX7LD4sLAhlr6yjK8
         MaCsWreQZCJRo5+748KcKkO+FEfg3K0zcWO3annv6Ti9S8/Wwdt/WINxrv9uFqFml74e
         MECnGki+BxZ3UuNKrOrAj0cQxNr4Bxq2DWDDGFWSFLkcNc+jBjOj8pstmnGKOiVdnIXh
         508PXSBBHlNGHok2bwUBjSDy8hcIyu6L6WyyJlb5v0Nc7x65S6UfKx8HxGGOTpu93H9w
         H2Y9w97jIlpJg0qPVdK4KLOz6FusTvku2nGoOr2xfXCfJv9iVvMazQ2L889EClT+A/RJ
         cRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEjKgjdJfrVf8HtFsOf1hWq1pz83a0clNltcH86fMuM=;
        b=UOwX3+H/epI6zhXg0WiWWe0TsKKxDLamIlYTeKOtC5ZJT8MerJMRynkjcSnmPj1lSX
         vNTWQVGuKDzgehir+B6FMx6NFjv9QCKEqNLfUYsLlJefd6In735vVGQI7musD6vwya55
         va1r0uPKnXpnPQvxiy7wiiiBXFu0qMWJL+meBGVy1iKcb0LA/CgSAKeP/3r0LM/hqvWs
         j67Z8IsFs5DSHfI0oZlT39HHDe5kOiZnombVZuXTmbzchjFU7QsuJ82dV3gfRNeVzfPn
         O0mgXYA9Qn7RXSAFdresNZH6Rhm5pp5D5Haass1dcKvNCMf44EDoQKr2GBdcLv8owYBe
         zOQQ==
X-Gm-Message-State: ANoB5pk/B4E9aPwauMYJjEXN8qYsXqTsoLPhqC7gxamvzewqQL+0Rn9J
        SIOUsw9K2INpiFt25iWPpLToXA==
X-Google-Smtp-Source: AA0mqf7WZxQxdqgnIyWTf+4IzjNaKNBlVf2HQMB+vbxL9rzQ67Grpka8LdSFqFoq7/nQ08zWSufZRA==
X-Received: by 2002:a17:90b:4b42:b0:20a:e38c:8c5f with SMTP id mi2-20020a17090b4b4200b0020ae38c8c5fmr5704988pjb.217.1668637225806;
        Wed, 16 Nov 2022 14:20:25 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e24-20020a63f558000000b00470275c8d6dsm10011228pgk.10.2022.11.16.14.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:20:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        agk@redhat.com, snitzer@kernel.org, hch@lst.de
Cc:     yi.zhang@huawei.com, yukuai3@huawei.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3 00/10] fix delayed holder tracking
Message-Id: <166863722483.6643.3538275832445983293.b4-ty@kernel.dk>
Date:   Wed, 16 Nov 2022 15:20:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 15 Nov 2022 22:10:44 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Hi all,
> 
> this series tries to fix the delayed holder tracking that is only used by
> dm by moving it into dm, where we can track the lifetimes much better.
> v2 is from Christoph, here I send v3 with some additional fixes.
> 
> [...]

Applied, thanks!

[01/10] block: clear ->slave_dir when dropping the main slave_dir reference
        commit: d90db3b1c8676bc88b4309c5a571333de2263b8e
[02/10] dm: remove free_table_devices
        commit: 992ec6a92ac315d3301353ff3beb818fcc34e4e4
[03/10] dm: cleanup open_table_device
        commit: b9a785d2dc6567b2fd9fc60057a6a945a276927a
[04/10] dm: cleanup close_table_device
        commit: 7b5865831c1003122f737df5e16adaa583f1a595
[05/10] dm: make sure create and remove dm device won't race with open and close table
        commit: d563792c8933a810d28ce0f2831f0726c2b15a31
[06/10] dm: track per-add_disk holder relations in DM
        commit: 1a581b72169968f4154b5793828f3bc28b258b35
[07/10] block: remove delayed holder registration
        commit: 7abc077788363ac7194aefd355306f8e974feff7
[08/10] block: fix use after free for bd_holder_dir
        commit: 62f535e1f061b4c2cc76061b6b59af9f9335ee34
[09/10] block: store the holder kobject in bd_holder_disk
        commit: 3b3449c1e6c3fe19f62607ff4f353f8bb82d5c4e
[10/10] block: don't allow a disk link holder to itself
        commit: 077a4033541fc96fb0a955985aab7d1f353da831

Best regards,
-- 
Jens Axboe


