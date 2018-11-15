Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54122C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FE221780
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MFKsa9cV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FE221780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeKPGAy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:00:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40949 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeKPGAx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:00:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id x2-v6so10185071pfm.7
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=icRdzyUDE+OvWMNb0rdi14U8SFWuNTllMG6eK8HYzMU=;
        b=MFKsa9cVKNp2dHHvziQAvTbsQGPpfafzycD/39wvGXx7vz1BQLWWNxpyPIQk/56por
         R3AATdTPltD4vG+yzBfxeFfUKwMfESgg0lBsThJ4I25DOLpXmWR1G8Q2YKvK7SNT3UXl
         3PkRV8b5ieR2lhdiLxV0uhqCt6KbryM5tIQa1IkX2dMB2v3S5nLoDBBcCHQKSpuBGqeo
         VuIMuPHARbImxidWI9tJ47CgxX4v4NWfeDKc958RJUGH9oXilAYuFZTh7FxjqGtEq0FC
         6j0xCVvheEazxiPvYDxhXFKMxCzSxaWQXONr3X4059DIaJlKI1EOgtGlMqAHd8pLHtdj
         +mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=icRdzyUDE+OvWMNb0rdi14U8SFWuNTllMG6eK8HYzMU=;
        b=hrfNViJyUMKYg19nSlTDR+LYhai3l/L69WDkqDmH5bDQVpHrYXJcGD1BMQVz0tAkZE
         rlo8d3zQXuGwmvySrJPyd8eCqqujKsKsUnF3N1iTzfRsAieUXi2Zb73jSCVuD81dTgSP
         MO/wb0dzBhzc16eoXGfaEcmoHJmzRBr28QMqCo/uRV6UVE4MtIkCOQXefLkuYiZ5Qenu
         7rriX2vI6CAsZTqWBBdhDJOX/Mqf3XHFGcJ1UaO7K/9jg2hOPsLlaannI89xiOHgYImd
         QcTCy8Ry8PHx9J9//k0lauVZcPWgVBx9Obj7BPuLulOQiuNa98y0f/jE37GPr4XleqKJ
         gw7w==
X-Gm-Message-State: AGRZ1gLtGv4MmrB3iIRw5BDClUDNFSH9/SNH9QaNTH5kGvh8eNtf07Yf
        pDC2gxbV/OJQv9bIUzmuLyyRGrXCCKE=
X-Google-Smtp-Source: AJdET5cfRbultEA9KOt4HhSWJ4SA/RD9+cy4pKB4j8ItHzZKDq4T94O5S+4CFw5ScI3wynePlB4Ceg==
X-Received: by 2002:a63:d252:: with SMTP id t18mr7069487pgi.133.1542311500972;
        Thu, 15 Nov 2018 11:51:40 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET v2 0/11] Various block optimizations
Date:   Thu, 15 Nov 2018 12:51:24 -0700
Message-Id: <20181115195135.22812-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some of these are optimizations, the latter part is prep work
for supporting polling with aio.

Patches against my for-4.21/block branch. These patches can also
be found in my mq-perf branch, though there are other patches
sitting on top of this series (notably aio polling, as mentioned).

Changes since v2:

- Include polled swap IO in the poll optimizations
- Get rid of unnecessary write barrier for DIO wakeup
- Fix a potential stall if need_resched() was set and preempt
  wasn't enabled
- Provide separate mq_ops for NVMe with poll queues
- Drop q->mq_ops patch
- Rebase on top of for-4.21/block

Changes since v1:

- Improve nvme irq disabling for polled IO
- Fix barriers in the ordered wakeup for polled O_DIRECT
- Add patch to allow polling to find any command that is done
- Add patch to control whether polling spins or not
- Have async O_DIRECT mark a bio as pollable
- Don't plug for polling



