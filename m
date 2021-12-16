Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 18:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbhLPSCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbhLPSCN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 13:02:13 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E660C061574
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 10:02:13 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p23so36315247iod.7
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 10:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=XyeHe/ZUR30c+im6FqbCg6K2xS35VsWNSCM8fVTsQFw=;
        b=OhIFm1Z6gnsCbteDMP9SCUFs+a+hfVpuVCL5q97RqUtFCNLAFeNNPN3PR6IZCKxb/P
         nzSmeFuMR5q8gG3Vo/9+BC/c5Ht2alwT5LJnbiBZZAlaGokdbhZnKUiSZyhFbNFBMrA7
         gIs8RtUGa3AUMDDxYCWW617IXVJx5CdkGd9XW6+mcEGZjXFfOcH13out7LKeX3EQ+9YX
         KnvqqKDZIef21PoZ3bM7FOI7cotsWNWnEu7+54g5nbreiEj84U5dPrX2vQeFEVSxsxny
         Y8hW2X18Ak20wIAxk2VqvHfqyotVDuzpuWLp4kAQfytK65WCGSVbGKIoA/loBqWO0IdK
         bHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=XyeHe/ZUR30c+im6FqbCg6K2xS35VsWNSCM8fVTsQFw=;
        b=UYPxmQIPIBx5bHT6y+ILtpBvUmZGil70PFmI2/NetDfRyIg4w/c2W4fJgJUQ4nZvpH
         Fan+merBX6ptlpSDYqTcpT2A7yce5Y3NHEjd4E0qpqEtOFsN4CcFbBxaLtp229OhcUX+
         Fv0aA4OmIGSyVMxzX6pt511FCLF9As68x4KNWLYyrH2hxSTXLILWVC6GIi2X8hAiYYxr
         YI+xFx08Tx47JFunIqjXDZuVER9kEAOc/cbdAAY8035hBeGJkxSm5or7d0oRnDPMeAbo
         rLfqjzFVGFLhHW0rxrN3eN56X/ARHq+IMGf4WcK4r2PySdYsKt1Q1uf1QfTDvgqCyjLM
         gLAw==
X-Gm-Message-State: AOAM531C6yMGKn2juvfcs3XwCw1aVsFrlkAoyjiSwxJyPL1hwIKrra0l
        u8ASz0Odgh66e6wPQkvULIo/OQ==
X-Google-Smtp-Source: ABdhPJxPTSiA96cWbvLiFKaySWoesuqCCV0NXYtbxHFFSfG5DewV6cdRhyGmRvd/jWNxksJEPe6uZg==
X-Received: by 2002:a05:6638:3486:: with SMTP id t6mr10147626jal.13.1639677732476;
        Thu, 16 Dec 2021 10:02:12 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r17sm2584239ilm.60.2021.12.16.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 10:02:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
Subject: Re: more I/O context cleanup v2
Message-Id: <163967773197.96862.10409401677447962143.b4-ty@kernel.dk>
Date:   Thu, 16 Dec 2021 11:02:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 9 Dec 2021 07:31:20 +0100, Christoph Hellwig wrote:
> this series dusts off a few more bits in the I/O context handling, and
> makes a chunk of code only needed by the BFQ I/O scheduler optional.
> 
> Changes since v1:
>  - fix a comment typo
>  - keep the RCU critical section in ioc_clear_queue
>  - add a few more cleanups
> 
> [...]

Applied, thanks!

[01/11] block: remove the nr_task field from struct io_context
        commit: 8a2ba1785c5803d59a63b6320ff54fd4a37a41ce
[02/11] block: simplify struct io_context refcounting
        commit: 0aed2f162bbc7853fe91c0d70492ea73c4e9cb07
[03/11] block: refactor put_iocontext_active
        commit: 4be8a2eaff2e4473b6e8ad9a3857bc9b1e79c8ba
[04/11] block: remove the NULL ioc check in put_io_context
        commit: 8a20c0c7e0cea7eb0c32fd6b63ff514c9ac32b8f
[05/11] block: refactor put_io_context
        commit: edf70ff5a1ed9769da35178454d743828061a6a3
[06/11] block: cleanup ioc_clear_queue
        commit: 091abcb3efd71cb18e80c8f040d9e4a634d8906d
[07/11] block: move set_task_ioprio to blk-ioc.c
        commit: a411cd3cfdc5bbd1329d5b33dbf39e2b5213969d
[08/11] block: fold get_task_io_context into set_task_ioprio
        commit: 8472161b77c41d260c5ba0af6bf940269b297bb6
[09/11] block: open code create_task_io_context in set_task_ioprio
        commit: 5fc11eebb4a98df5324a4de369bb5ab7f0007ff7
[10/11] block: fold create_task_io_context into ioc_find_get_icq
        commit: 90b627f5426ce144cdd4ea585d1f7812359a1a6a
[11/11] block: only build the icq tracking code when needed
        commit: 5ef1630586317e92c9ebd7b4ce48f393b7ff790f

Best regards,
-- 
Jens Axboe


