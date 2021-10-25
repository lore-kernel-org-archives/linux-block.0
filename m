Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DD360F92
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhJYO1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhJYO1l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 10:27:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37863C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id np13so8395351pjb.4
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34PmSfQOG07gU3fQRAV116BDNZ8vyqmNrac0iFZZhZ8=;
        b=b2nkeZ2CMBBGyjkH0v2BBAVzFfgxYePp+8yPTERseQuN9EVDpkRCDFCWs9ew/iWE5c
         5OYfzur0wxvZ4SM6CwGjGhYWsC/R8qUjtqjDfiFG8prYfV2J/P9BePAqR9pqiGQbwc38
         tEbLZD3kDZG9YyxflDERBVni+SGGU0vaWpCyoLcYUaOlH6A3jYkwMgmQu2h2LJMQHnrJ
         WGlXz51dv3K+LQ5sqpEVQqIq+8R8q0LjpN1VxpbsMZS0wNX7GvH5JAgwVJMIpawaBroO
         D8FNG0fTq6snijFMPoHSUn9K+igxH8TJOLK98zqXLQ6NWf0ODICiml2t/aMZHPtVORiU
         s1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34PmSfQOG07gU3fQRAV116BDNZ8vyqmNrac0iFZZhZ8=;
        b=hXPRFjGiF5Xl/gJ7GUU/g6UefIt031BAVnXw1t8DDM4GjQSMQF2Yi0IEo34nzsJ0Uv
         mnXWjgR5VMxVdG3dpZtMdTIE/7bRJh4IqSEu2CnWu7vHgl0zIcBHZrQ5+HOpD6keuUrc
         lYKuKKnNaH+XDl8S46/SHBOtDGsHyrAG5lU0yQJGfy6E9cOshROy9eGSuklGg+GSTQFE
         0fIZ6Q0XTzz2fQH80bhuqVNTp3+WHBLudPSZi6X6aMIssZzo4uHv/4dRXw91DEWETV8p
         j9kYWUsPCoDqiF8nIZ6BY1VO/9PJaB5kUE7Rv9iDZGqcpqHKi5/bOtebm6BeM5Kp8AcA
         mxGQ==
X-Gm-Message-State: AOAM532mgWCXb2Y3FD1q65wuuxDhAk/UWdVxLC+9cqMRTmCcMXKejQ9G
        aKsQtjG+zFC6to0zfmHaMff6
X-Google-Smtp-Source: ABdhPJzH5eg/+QPzpvST0pmvC/Rnw+zNH7pzd4mvAczULWSZ3WGI+jHGJwEapLzt5GfZovLa7shShQ==
X-Received: by 2002:a17:902:c40f:b0:140:6774:9365 with SMTP id k15-20020a170902c40f00b0014067749365mr1617852plk.67.1635171918588;
        Mon, 25 Oct 2021 07:25:18 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d15sm22099056pfu.12.2021.10.25.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:25:15 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/4] Add blk_validate_block_size() helper for drivers to validate block size
Date:   Mon, 25 Oct 2021 22:25:02 +0800
Message-Id: <20211025142506.167-1-xieyongji@bytedance.com>
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

V1 to V2:
- Return and print error if validation fails in virtio-blk driver

Xie Yongji (4):
  block: Add a helper to validate the block size
  nbd: Use blk_validate_block_size() to validate block size
  loop: Use blk_validate_block_size() to validate block size
  virtio-blk: Use blk_validate_block_size() to validate block size

 drivers/block/loop.c       | 17 ++---------------
 drivers/block/nbd.c        |  3 ++-
 drivers/block/virtio_blk.c | 11 +++++++++--
 include/linux/blkdev.h     |  8 ++++++++
 4 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.11.0

