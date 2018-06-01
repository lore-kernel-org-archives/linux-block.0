Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39328 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFAMBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 08:01:53 -0400
Received: by mail-wm0-f45.google.com with SMTP id p11-v6so1710977wmc.4
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 05:01:53 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V2] lightnvm: pblk: remove unnecessary bio_get/put
Date: Fri,  1 Jun 2018 14:01:45 +0200
Message-Id: <1527854506-8708-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Matias,

Here you have the patch, rebased on top of your tree. Please pick up for
4.18

Thanks!
Javier

Changes since V1
  - Rebase on top of Matias for-4.18/core
  - Rename error tags on the modified code to be compliant with the rest
  of pblk

Javier González (1):
  lightnvm: pblk: remove unnecessary bio_get/put

 drivers/lightnvm/pblk-read.c | 65 +++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

-- 
2.7.4
