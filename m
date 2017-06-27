Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:47283 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751612AbdF0Lzg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 07:55:36 -0400
Date: Tue, 27 Jun 2017 14:55:33 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Jens Axboe <axboe@fb.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>,
        Frans Klaver <fransklaver@gmail.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH V3] lightnvm: if LUNs are already allocated fix return
Message-ID: <20170627115531.GA53387@dhcp-216.srv.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

While creating new device with NVM_DEV_CREATE if LUNs are already
allocated ioctl would return -ENOMEM which is wrong.  This patch
propagates -EBUSY from nvm_reserve_luns which is correct response.

Fixes: ade69e243 ("lightnvm: merge gennvm with core")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---

V3: Propagate return value from nvm_reserve_luns instead of hard-coding (Frans)
V2: return error code directly instead of using ret variable (Frans)

 drivers/lightnvm/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index b8f82f5..ddae430 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -252,8 +252,9 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	}
 	mutex_unlock(&dev->mlock);
 
-	if (nvm_reserve_luns(dev, s->lun_begin, s->lun_end))
-		return -ENOMEM;
+	ret = nvm_reserve_luns(dev, s->lun_begin, s->lun_end);
+	if (ret)
+		return ret;
 
 	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
 	if (!t) {
-- 
2.5.5
