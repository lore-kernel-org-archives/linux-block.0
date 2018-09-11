Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37977 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeIKQ2R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 12:28:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33-v6so18938949edb.5
        for <linux-block@vger.kernel.org>; Tue, 11 Sep 2018 04:29:21 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V2 PATCH]  lightnvm: pblk: recover open lines on 2.0 devices
Date: Tue, 11 Sep 2018 13:29:13 +0200
Message-Id: <1536665354-13493-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

# Changes sinve V1:
  - Rebase on top of Matias' core

Javier González (1):
  lightnvm: pblk: recover open lines on 2.0 devices

 drivers/lightnvm/pblk-recovery.c | 406 ++++++++++++---------------------------
 1 file changed, 124 insertions(+), 282 deletions(-)

-- 
2.7.4
