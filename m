Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E6EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B0460ED4
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhJYJtf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhJYJsH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:48:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E12C061348
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:45:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v20so7533876plo.7
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPD3abwHwXnuHqOkpauS6OSyWnIWVDUEQ3mrtmK8uvA=;
        b=oxsWgkuPavApcWBDAr8JzU4NKA7bwzmPbaQKXjKjUTHeBmbANPxD6kGxeCz8evoXuI
         MiIFaQlRC7tTIGroYg5u6RyTv24HoGEgc9ZAwsMEeGUikqyusonrpF8v87HMOEAzMcrw
         n4TewbhIq5BES24UPFR4ihl2EPFQ0sLinsOnqdcqPSToOGAenu4XGJQ6/tKLpAvN8Cvy
         z7dVTI47XOC43LcT852fSV6Wt1kAGdgC4oRwouDHCJP5OXO1UeKmghiYYwXJYsc6LwAM
         HEOsaj9j03pxnSONl37iOKeaLx63Xelt3tw/8NNaL/RMeCaxkN1LE2Ntjw0PbJExdWJK
         CCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPD3abwHwXnuHqOkpauS6OSyWnIWVDUEQ3mrtmK8uvA=;
        b=kYIQpKZ70fXNdJKEPW1m/fvyDpEwP0eCUEr8dPs1t6TcSubES7qB4sLZNrHGNneQgz
         r+gXiJH5n+p9MYVdXP45RD8RgO2KuTQvdba0Qpzm3vkXJiwb+YPg74lEcrEn2X0rt+td
         MrP4d7FunEoh9MtFJ6UNzv+m7Baep6ahdv7iNopHldY0HcwTE1VNVw4Bt7wve+Uw5JIH
         QK3G0WDEdvgsiO+8qpFYR5tjIvr6Q0/i6iRQ0z5o12OhkndIS9qWEbn2a8rSKYfQ2lU5
         M79CoYIirEyLbYBYTkf3hLWQ28gCWv7IwV4YVmajO/uiihIvAWyPkWRlqc0cYttxtWnD
         eTgQ==
X-Gm-Message-State: AOAM531CEOlbT84+YwG7WG0L/B8gCZ3aerI1ZzE2qK7iOw/LwsYRGOOy
        pN5b/18dXc0f8ITgzBbatN7P
X-Google-Smtp-Source: ABdhPJxDcVzxvbwQ7LOszVdQOSXCMt3SRb+GDgq7Adixsg3NGvOdY5MKJ02q6bvNGyaFZxOaPXoOgA==
X-Received: by 2002:a17:90b:1d8e:: with SMTP id pf14mr19081276pjb.125.1635155144236;
        Mon, 25 Oct 2021 02:45:44 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id g11sm20050222pfc.194.2021.10.25.02.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 02:45:43 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 0/4] Add blk_validate_block_size() helper for drivers to validate block size
Date:   Mon, 25 Oct 2021 17:43:02 +0800
Message-Id: <20211025094306.97-1-xieyongji@bytedance.com>
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

Xie Yongji (4):
  block: Add a helper to validate the block size
  nbd: Use blk_validate_block_size() to validate block size
  loop: Use blk_validate_block_size() to validate block size
  virtio-blk: Use blk_validate_block_size() to validate block size

 drivers/block/loop.c       | 17 ++---------------
 drivers/block/nbd.c        |  3 ++-
 drivers/block/virtio_blk.c |  7 +++++--
 include/linux/blkdev.h     |  8 ++++++++
 4 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.11.0

