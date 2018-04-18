Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:43387 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeDRMG2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Apr 2018 08:06:28 -0400
Received: by mail-wr0-f176.google.com with SMTP id u4-v6so4117107wrg.10
        for <linux-block@vger.kernel.org>; Wed, 18 Apr 2018 05:06:28 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V2]  lightnvm: pblk: take bitmap alloc. out of critical section
Date: Wed, 18 Apr 2018 14:06:07 +0200
Message-Id: <1524053168-30476-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Changes since V1 - from Matias:
 - rename a function to line__reinit
 - propagate error code
 - improve commit message

Javier González (1):
  lightnvm: pblk: take bitmap alloc. out of critical section

 drivers/lightnvm/pblk-core.c | 97 +++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 41 deletions(-)

-- 
2.7.4
