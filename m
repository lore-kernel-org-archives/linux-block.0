Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35501 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbdG0Ot4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2017 10:49:56 -0400
Received: by mail-wm0-f50.google.com with SMTP id c184so107426766wmd.0
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2017 07:49:56 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
Subject: [PATCH] lightnvm: pblk fix for 4.13
Date: Thu, 27 Jul 2017 16:49:49 +0200
Message-Id: <1501166990-24366-1-git-send-email-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Can you pick up this fix for 4.13? It is a fix to a read corruption in
pblk that has been there form the beginning. It is due to a bad bio
manipulation in the case that an I/O containing lbas that are invalid,
point to data in the host cache and point to data on the device, all
three in a single bio.

The patch applies on top of you for-4.13/block and is available too at:
  - https://github.com/OpenChannelSSD/linux/tree/pblk.for-4.13

I marked the patch to fix the original pblk commit, but it does not
apply anymore on the original 4.12 code. How do we handle these
situations? We make a backport when Greg makes 4.12 stable?

Thanks,
Javier

Javier González (1):
  lightnvm: pblk: advance bio according to lba index

 drivers/lightnvm/pblk-rb.c   |  4 ++--
 drivers/lightnvm/pblk-read.c | 19 ++++++++++++++-----
 drivers/lightnvm/pblk.h      |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.7.4
