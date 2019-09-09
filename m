Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E7CC4740C
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAB721924
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfMQ0N0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfIIM5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:57:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38487 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfIIM5D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 08:57:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so14535191wme.3;
        Mon, 09 Sep 2019 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqBuAhLk8WUfA1MYmYB0V6NwagpBGla+VruOq7texiI=;
        b=pfMQ0N0vQFNrlf7+Euo0B+eu/R9lqsB2N6y/Zf6dCfmXjNpc8lVq/rsNd2K+m/tdQo
         NsFPf3E58S5t836nUBN7kByqFDaUYjcByFgizXjX8zh6Bdaoao+7/LInzczFiFpa/6GH
         o7mqH05RH2yNis8PC9tXH6aEStmnoebyLhBnpid2qbxrYPXn1Htbxt79QXLE9U/2FZxC
         9wfDYFiU0sNaVZ8yoBoHlqRlWuDgjTvEmzVzPykw86/tB6E4Ii0843fous5s9lrSCuWX
         pByoxLxJyXxNzv4PEsTvmPreXk3vpGXiB4/E2bAnqXdN0WoZLOoFmeHvK93xRSip9rKH
         egtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqBuAhLk8WUfA1MYmYB0V6NwagpBGla+VruOq7texiI=;
        b=Zgwd58UwS5zNQVuPWmP1Pk6oNRwtwz8PUaXTiR1qvqtUo9dCCVWcrPikvJSAyYCh6S
         aYbpgRCxa9PgCqRmzzoo1+hOw6PNAhG8MZ9TgwCgT9B6PGVD0QFWTRXyf75oroV4IsRd
         f36JaUoRqQnjQ71CnS5danIR6OjavtE6wHbhnK4RrtLYHti3zFcW7VjtyyvS++TiVdvD
         45oiY9YhmcCV63Lo9RAs2Dhv2gInbYhuzp7Hl+VlTHP/tQ7d0YOOkxlGGiZztFscQgw9
         jkhI/HyYyIWSagd6J/qfHW1P+n24zMNd5z/dTUdSgDWIkhN/+dLiMsN7pvOTUqjBlgqj
         gdRg==
X-Gm-Message-State: APjAAAUR7upX4qkPxWmrqA33q6tsb6HLmACrH9pjuT4/Fu2cC0/NeC2O
        JQoneORF0j059TB0yXjywYa6MYcK
X-Google-Smtp-Source: APXvYqyXgpZUJfJVC5gENHP0+6FV5H/yIWLx5Co3Rn4FgyQ44vdgInN4M/6j6o9YKW+BKqfij5Bjrw==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr17217044wmi.24.1568033820460;
        Mon, 09 Sep 2019 05:57:00 -0700 (PDT)
Received: from localhost (p2E5BE0B8.dip0.t-ipconnect.de. [46.91.224.184])
        by smtp.gmail.com with ESMTPSA id r16sm16166050wrc.81.2019.09.09.05.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 05:56:59 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christoph Hellwig <hch@lst.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 0/3] mmc: Fix scatter/gather on SDHCI
Date:   Mon,  9 Sep 2019 14:56:55 +0200
Message-Id: <20190909125658.30559-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Commit 158a6d3ce3bc ("iommu/dma: add a new dma_map_ops of
get_merge_boundary()") causes scatter/gather to break for SDHCI and
potentially other MMC hosts.

The reason is that the commit ends up tricking the block layer into
believing that there's effectively no limit on the segment size. While
this may be true for some device, it's certainly not true for all. The
DMA descriptors used by SDHCI, for example, have a 16-bit field that
contains the number of bytes to transmit for that particular transfer.
As a result of the segment size exceeding the capabilities of the
hardware, the scatterlist ends up containing entries that are too large
to fit into a single descriptor.

This small series fixes this by making the block layer respect the
segment size restrictions set for the device. It also prevents the MMC
queue code to attempt to overwrite the maximum segment size of a device
that may already have been set up. Finally it configures the maximum
segment size for SDHCI. The last step is technically not required
because the maximum segment size for SDHCI coincides with the default,
but I think it's better to be explicit here.

As a result, all entries in the scatterlist are now small enough to fit
into SDHCI DMA descriptors. Some improvements could be made to how the
scatterlist is packed. For example, the dma-iommu code compacts the SG
entries so that they result in segments less than the maximum segment,
but doesn't split up individual entries. This often results in holes in
the individual segments. In order to create full 64 KiB segments with
only the last segment being partial, the code would have to split up
individual entries. This should be possible but is not done as part of
this series.

Thierry

Thierry Reding (3):
  block: Respect the device's maximum segment size
  mmc: core: Respect MMC host's maximum segment size
  mmc: sdhci: Set DMA maximum segment size to 64 KiB

 block/blk-settings.c     | 24 +++++++++++++++---------
 drivers/mmc/core/queue.c |  2 --
 drivers/mmc/host/sdhci.c |  5 +++++
 drivers/mmc/host/sdhci.h |  1 +
 4 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.23.0

