Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36503 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbdF0IkQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 04:40:16 -0400
Received: by mail-wm0-f45.google.com with SMTP id 62so17902626wmw.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2017 01:40:15 -0700 (PDT)
From: "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH] Small patch for 4.13 window
Date: Tue, 27 Jun 2017 10:39:49 +0200
Message-Id: <20170627083950.11312-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Thanks for picking up the pblk changes. I have just a small one that
wasn't part of the batch. Would you pick this one up as well for the
4.13 window?

-Matias

Rakesh Pandit (1):
  ligtnvm: if LUNs are already allocated fix return

 drivers/lightnvm/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.9.3
