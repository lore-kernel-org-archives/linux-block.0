Return-Path: <SRS0=Y6k2=EN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F9FC388F7
	for <linux-block@archiver.kernel.org>; Sat,  7 Nov 2020 20:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053D120885
	for <linux-block@archiver.kernel.org>; Sat,  7 Nov 2020 20:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Td5JgPoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgKGUOF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Nov 2020 15:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGUOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Nov 2020 15:14:04 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE74C0613CF
        for <linux-block@vger.kernel.org>; Sat,  7 Nov 2020 12:14:04 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id k7so2587968plk.3
        for <linux-block@vger.kernel.org>; Sat, 07 Nov 2020 12:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Br3/u4cDGf9o3wvMmd+gUG91KAUJPY1IXRRmcNYch5w=;
        b=Td5JgPojuQP4QfrgNydD8OcfnWLFgd+X85sBoVvSWMF15J+JcnRTZ6n6su+UGVSwDi
         37tcW8rfX/w4hjzudJYs+Sz+68LnXl3i8TrvoAi9ceW6auEWQJrdHLuL+fb5zaweTSNH
         8iGtcbncvCR2fbSqaKiX6Dii0iNytajm//EKA1+O1U3SbNAXxW6Ef0dIZ3lhW0xFhc1p
         Q/E+SQZK3XYXt+h4QyA1o8xdlIoTYaB+1ccY/pF6KDDFaa4aAKebCUgVMS0gVOBfHPgj
         nBMLfLU0xDRewmRImMtLT+5TytJEU79kk70U8hgPa12roEd8O18wPq7Xc4p+zCkj+4Vf
         aE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Br3/u4cDGf9o3wvMmd+gUG91KAUJPY1IXRRmcNYch5w=;
        b=TRje3y4MC+Qcx4Hju59D08q/PDyLu/n9Qxcwfe/HLEWo+7CMqSehAgqXIyi+wgoF5S
         1VYntUHR5YQDPy/uaHs+N6YOQPrgvJKR3TCOKpiO0Wfnqdk6qQU2tB1xByjDJ3A+NCa+
         exMvv0BGTd9Ol77QnrCnLaohFjVJAO88dQRUFPTIvBlnYWUg6N0ZTYYq5WV97K9dOtoS
         uD7WrFdyeq+qcHIbt1e0b8M9gk4K0vdshrkUWdLfdRy/NRR3CH/F2GfTMikwBIwCdoHs
         ap7Gr5qLOH1VtqMFUCBJ/iQZ6SGyPAncUKmf8fBgwEBufZbfapY692/KRSN9EJvkPK+N
         Nthw==
X-Gm-Message-State: AOAM5318uBy4q5UAyQ4OIFZVEPi4pS7bxgovx4C9MP1+ZJrmcszauarp
        rkXhuixuA80x+zmuTn034PejvBihD/7ZUA==
X-Google-Smtp-Source: ABdhPJzGdKFPdVjRrpllSHeJUTYAfIgnZ/GXmi93OHG+uOiDrBZEaKzZELDwr7rZRzVosJ8g4xFvqQ==
X-Received: by 2002:a17:90a:bb18:: with SMTP id u24mr5624476pjr.85.1604780043913;
        Sat, 07 Nov 2020 12:14:03 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 22sm6712771pjw.34.2020.11.07.12.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 12:14:03 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.10-rc
Message-ID: <bdeefa97-9ec3-cac8-3e6b-dd912d0c0c33@kernel.dk>
Date:   Sat, 7 Nov 2020 13:14:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes that should make it into this release:

- NVMe pull request from Christoph:
	- revert a nvme_queue size optimization (Keith Bush)
	- fabrics timeout races fixes (Chao Leng and Sagi Grimberg)"

- null_blk zone locking fix (Damien)

Please pull!


The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-07

for you to fetch changes up to e1777d099728a76a8f8090f89649aac961e7e530:

  null_blk: Fix scheduling in atomic with zoned mode (2020-11-06 09:36:42 -0700)

----------------------------------------------------------------
block-5.10-2020-11-07

----------------------------------------------------------------
Chao Leng (3):
      nvme: introduce nvme_sync_io_queues
      nvme-rdma: avoid race between time out and tear down
      nvme-tcp: avoid race between time out and tear down

Damien Le Moal (1):
      null_blk: Fix scheduling in atomic with zoned mode

Jens Axboe (1):
      Merge tag 'nvme-5.10-2020-11-05' of git://git.infradead.org/nvme into block-5.10

Keith Busch (1):
      Revert "nvme-pci: remove last_sq_tail"

Sagi Grimberg (2):
      nvme-rdma: avoid repeated request completion
      nvme-tcp: avoid repeated request completion

 drivers/block/null_blk.h       |  2 +-
 drivers/block/null_blk_zoned.c | 47 ++++++++++++++++++++++++++++--------------
 drivers/nvme/host/core.c       |  8 +++++--
 drivers/nvme/host/nvme.h       |  1 +
 drivers/nvme/host/pci.c        | 23 +++++++++++++++++----
 drivers/nvme/host/rdma.c       | 14 +++----------
 drivers/nvme/host/tcp.c        | 16 ++++----------
 7 files changed, 65 insertions(+), 46 deletions(-)

-- 
Jens Axboe

