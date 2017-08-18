Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36120 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdHRGPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 02:15:35 -0400
Received: by mail-yw0-f172.google.com with SMTP id u207so53574442ywc.3
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2017 23:15:35 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] loop: LOOP_FLAGS_BLOCKSIZE fixes
Date: Thu, 17 Aug 2017 23:15:24 -0700
Message-Id: <cover.1503036471.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

A couple of bugs I found while adding blktests for the new loop block
size feature. Based on v4.13-rc5, we should get these in for 4.13.

Thanks!

Omar Sandoval (2):
  loop: always return block size in LOOP_GET_STATUS
  loop: fix hang if LOOP_SET_STATUS gets invalid blocksize or encrypt
    type

 drivers/block/loop.c | 53 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

-- 
2.14.1
