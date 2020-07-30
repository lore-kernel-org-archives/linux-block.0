Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357FAC433E0
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8662082E
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 15:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bV+E0PYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgG3PUN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3PUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 11:20:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C867C061574
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 08:20:12 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t15so19662517iob.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vE/A57ahNtmo2vm8Z4bMXWHDnjf02DfOHnffGnFds1c=;
        b=bV+E0PYCECvxlfZcjNKMaUrLDxQylLDnUNf2B4x+0ZOqj5i8eerQpXMq8DJBBXsFar
         5luftlWSVBDA/s616oEqHKo16fm7+MLX/b888GDMpjWW3kFcHdSfDTDzIasZ/NG8vhi4
         B5bx4BrQQ/9SKZG8rbddvdD5FxSikryOQLJwveFJ/aDDYPdjaAoORsk8+XQ7ACLMyLJA
         p4K1mTGMpR5t1rVaRgWLaof4crLTMsIdtLh3bLWugxHQHSr6Cwy3BpCyWfcjTLJ/aQel
         KmN7RTs1oJBzaihf1D+60EMqeynknbv1i8DxVTOTXkMutrWQVfrOwUs+7t80X5yH4Ah6
         smVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vE/A57ahNtmo2vm8Z4bMXWHDnjf02DfOHnffGnFds1c=;
        b=gy9Ip+VWy/+RWaIi2xm6dUNh5WTor5hfm85S+gaCNeCz4sdf97YHQ6ZpkBKoJ7kEiz
         g7i7IPLkwN2FbJn0I2s4KIQsj7hu/KRcPiUsgpdzA3+YpRhfFZ1PTVE3pfK3FjbJmYYn
         Jz3Qof6ppzZ/RLDsrIixl96BNEHKzGxpMTTF7TD9BwwBQiVS1lJtH0vTRlRUqP9jJgGF
         y2jFavypNdgWov2/9zZJLoFyLNukc8pK39UuK9nKdWk62J5DXpMXPbxNANIZfZv/sh9g
         OCv3Q/G/WJPqOk2bF1e/94o3iIeCVJnsu5nQTKQ2hjHhzdri361YGEh8lVgdi8Xem21/
         pQzw==
X-Gm-Message-State: AOAM531olLBzAeH79R3FVADsIXQjN0s+k/a82sotETDPIcAakPb+ELtk
        gwj7f6UCLKc3aeyHm8KGnQe1hLFUY4w=
X-Google-Smtp-Source: ABdhPJyMKmMBXM3ydOpkwopx6F6KiYQ5Hnzn7vndXXNFTnirI95ijm3lpY/Gd524r3TNk52g2A1orA==
X-Received: by 2002:a05:6638:27a:: with SMTP id x26mr3797744jaq.43.1596122411533;
        Thu, 30 Jul 2020 08:20:11 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k8sm3232180ilk.11.2020.07.30.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 08:20:11 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.8-rc
Message-ID: <fdd0107a-a9cf-b7c5-211c-78226f901bf5@kernel.dk>
Date:   Thu, 30 Jul 2020 09:20:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Three NVMe fixes that should go into this release. Please pull!


The following changes since commit 1f273e255b285282707fa3246391f66e9dc4178f:

  Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8 (2020-07-16 08:58:14 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-30

for you to fetch changes up to d6364a867ccbf34a6afe0d57721ff64aa43befcd:

  Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8 (2020-07-29 11:21:14 -0600)

----------------------------------------------------------------
block-5.8-2020-07-30

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: add a Identify Namespace Identification Descriptor list quirk

Jens Axboe (1):
      Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8

Kai-Heng Feng (1):
      nvme-pci: prevent SK hynix PC400 from using Write Zeroes command

Sagi Grimberg (1):
      nvme-tcp: fix possible hang waiting for icresp response

 drivers/nvme/host/core.c | 15 +++------------
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  |  4 ++++
 drivers/nvme/host/tcp.c  |  3 +++
 4 files changed, 17 insertions(+), 12 deletions(-)

-- 
Jens Axboe

