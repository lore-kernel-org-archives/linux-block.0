Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:40749 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbdIQVER (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Sep 2017 17:04:17 -0400
Date: Mon, 18 Sep 2017 00:04:14 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH] lightnvm: remove already calculated nr_chnls
Message-ID: <20170917210412.GA2879@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove repeated calculation for number of channels while creating a
target device.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---

This is also a trivial change I found while investigating/working on
other issue.

 drivers/lightnvm/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 1b8338d..01536b8 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -139,7 +139,6 @@ static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
 	int prev_nr_luns;
 	int i, j;
 
-	nr_chnls = nr_luns / dev->geo.luns_per_chnl;
 	nr_chnls = (nr_chnls_mod == 0) ? nr_chnls : nr_chnls + 1;
 
 	dev_map = kmalloc(sizeof(struct nvm_dev_map), GFP_KERNEL);
-- 
2.7.4
