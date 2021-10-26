Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDBBC433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4A360E74
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhJZOpG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhJZOpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:45:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B3C061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:42:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x66so14509058pfx.13
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kq1S4qwrXxntJdVPakPNFVUHYz9PO0MQF46/bxmhu6A=;
        b=GCOtfNgJc/gWbiXMYXaOiq+mPhYtINAr3+fG/7IaxrGobGnpF99gBf5wTJXTQE38LQ
         XeTMtthd0FpEylDdPknYwFg9jQ4mtKJKcJGDpjW0WV3ZNwZDToiwa+pVD50cuL4t8pfn
         VPaeq2Eh6/WmfyZ5wvVsre1sz0bu2qH356BXr2Kt2xqTgCsvcXUHr4geo/AqPdVFxVMe
         aBGAdnLBDkuABroOnbT+mjL9BDkImCLTS8+X3IppSLxsxGq9YkJTSrDCSBp5QFA7HTIo
         YTcTspQ8VXNgpe9OKF6FeUp37lGoVuBfOTrRnCcwV9xOj1LHsqxosz+7cKahQ4R8AvWu
         PUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kq1S4qwrXxntJdVPakPNFVUHYz9PO0MQF46/bxmhu6A=;
        b=CSfL8AWXjsZTJRT193tneAn9gu8rxXxg8plTwbUza6imxJSMbIRhqqf9CJeB4QdEWK
         4rj+7MrjS/VWoYWA1JNR7tKZyaTvE+eFPHoMBN9nkEDfrjSzIFxJY9u0yeMrjL7tTXDr
         SDYARSqOhmXqnSQaQ6vTbHPzMyoiB92LJ8ONZPJHqBc7N+G74ITbLhVw10Tqz2fEf5bj
         jPMUeQPmNaHvg9vpSvDDDZ7XbIrDID/EFKbasUl6ITIH9mfbTZ8IksmjUnONGuHmdzZN
         ++dGp4olJCiYO3xw+pyt+B9+AFjhrt4Qhj0+7/aAt8Panmz/Puu11JBoWXfYnpRkCJd8
         J55Q==
X-Gm-Message-State: AOAM530bVSTT0o+JJ9+Q9aCrZm6PAsQDZuW6sYPC2z5b3BVFUBQcFS+V
        uRgRwlOBE7wZ+ErhrXkq/EgA
X-Google-Smtp-Source: ABdhPJzkY4v2ovqKTCsH10wzAvT6oWtc2VWoqCE+/V11MgxPYQTpmw0eijnhkSRjbEpBTYhsmbADag==
X-Received: by 2002:a63:9508:: with SMTP id p8mr18874681pgd.413.1635259361434;
        Tue, 26 Oct 2021 07:42:41 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id p9sm22413642pfn.7.2021.10.26.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:42:35 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 0/4] Add blk_validate_block_size() helper for drivers to validate block size
Date:   Tue, 26 Oct 2021 22:40:11 +0800
Message-Id: <20211026144015.188-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer can't support the block size larger than
page size yet, so driver needs to validate the block size
before setting it. Now this validation is done in device drivers
with some duplicated codes. This series tries to add a block
layer helper for it and makes loop driver, nbd driver and
virtio-blk driver use it.

We tested both invalid block size and valid block size cases
for loop driver with the example in man page [1] and for
nbd and virtio-blk driver with qemu-nbd and storage-daemon (vduse)
in the qemu repo [2].

[1] https://man7.org/linux/man-pages/man4/loop.4.html
[2] https://github.com/bytedance/qemu/tree/vduse

V2 to V3:
- Fix some commit logs and print message

V1 to V2:
- Return and print error if validation fails in virtio-blk driver

Xie Yongji (4):
  block: Add a helper to validate the block size
  nbd: Use blk_validate_block_size() to validate block size
  loop: Use blk_validate_block_size() to validate block size
  virtio-blk: Use blk_validate_block_size() to validate block size

 drivers/block/loop.c       | 17 ++---------------
 drivers/block/nbd.c        |  3 ++-
 drivers/block/virtio_blk.c | 12 ++++++++++--
 include/linux/blkdev.h     |  8 ++++++++
 4 files changed, 22 insertions(+), 18 deletions(-)

-- 
2.11.0

