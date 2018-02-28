Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34659 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeB1A4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 19:56:50 -0500
Received: by mail-pl0-f65.google.com with SMTP id u13-v6so490898plq.1
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 16:56:49 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 0/2] block: sbitmap tweaks
Date: Tue, 27 Feb 2018 16:56:41 -0800
Message-Id: <cover.1519779182.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Two fixlets inspired by Tejun's patch
(https://patchwork.kernel.org/patch/10226749/). Patch 2 is what we
discussed on that patch, patch 1 is a small preparation.

Omar Sandoval (2):
  block: clear ctx pending bit under ctx lock
  sbitmap: use test_and_set_bit_lock()/clear_bit_unlock()

 block/blk-mq.c          |  2 +-
 include/linux/sbitmap.h |  8 ++++++++
 lib/sbitmap.c           | 10 +++++-----
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.16.2
