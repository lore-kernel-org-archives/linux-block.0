Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbdGLSB0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 14:01:26 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: axboe@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH 0/2] block: two cleanup patches
Date: Wed, 12 Jul 2017 11:00:51 -0700
Message-Id: <cover.1499881589.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Hi,
Cleanup the bio_uninit staff as Christoph suggested. I don't remove
bio_disassociate_task from bio_free, as bio_associate_blkcg is an exported
symbol and can be called anywhere.

Thanks,
Shaohua

Shaohua Li (2):
  block: delete bio_uninit in blockdev
  block: delete bio_uninit

 block/bio.c         | 17 +++--------------
 fs/block_dev.c      |  4 +---
 include/linux/bio.h |  1 -
 3 files changed, 4 insertions(+), 18 deletions(-)

-- 
2.9.3
