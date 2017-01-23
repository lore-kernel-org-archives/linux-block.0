Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33256 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdAWMAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 07:00:20 -0500
Received: by mail-wm0-f66.google.com with SMTP id r144so25894540wme.0
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 03:59:46 -0800 (PST)
From: "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 3/8] lightnvm: remove nvm_submit_ppa* functions
Date: Mon, 23 Jan 2017 12:59:14 +0100
Message-Id: <20170123115919.14339-4-matias@cnexlabs.com>
In-Reply-To: <20170123115919.14339-1-matias@cnexlabs.com>
References: <20170123115919.14339-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The nvm_submit_ppa* functions are no longer needed after gennvm and core
have been merged.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 109 -----------------------------------------------
 include/linux/lightnvm.h |   4 --
 2 files changed, 113 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index a4e2e3b..ffdf048 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -883,115 +883,6 @@ void nvm_end_io(struct nvm_rq *rqd, int error)
 }
 EXPORT_SYMBOL(nvm_end_io);
 
-static void nvm_end_io_sync(struct nvm_rq *rqd)
-{
-	struct completion *waiting = rqd->wait;
-
-	rqd->wait = NULL;
-
-	complete(waiting);
-}
-
-static int __nvm_submit_ppa(struct nvm_dev *dev, struct nvm_rq *rqd, int opcode,
-						int flags, void *buf, int len)
-{
-	DECLARE_COMPLETION_ONSTACK(wait);
-	struct bio *bio;
-	int ret;
-	unsigned long hang_check;
-
-	bio = bio_map_kern(dev->q, buf, len, GFP_KERNEL);
-	if (IS_ERR_OR_NULL(bio))
-		return -ENOMEM;
-
-	nvm_generic_to_addr_mode(dev, rqd);
-
-	rqd->dev = NULL;
-	rqd->opcode = opcode;
-	rqd->flags = flags;
-	rqd->bio = bio;
-	rqd->wait = &wait;
-	rqd->end_io = nvm_end_io_sync;
-
-	ret = dev->ops->submit_io(dev, rqd);
-	if (ret) {
-		bio_put(bio);
-		return ret;
-	}
-
-	/* Prevent hang_check timer from firing at us during very long I/O */
-	hang_check = sysctl_hung_task_timeout_secs;
-	if (hang_check)
-		while (!wait_for_completion_io_timeout(&wait,
-							hang_check * (HZ/2)))
-			;
-	else
-		wait_for_completion_io(&wait);
-
-	return rqd->error;
-}
-
-/**
- * nvm_submit_ppa_list - submit user-defined ppa list to device. The user must
- *			 take to free ppa list if necessary.
- * @dev:	device
- * @ppa_list:	user created ppa_list
- * @nr_ppas:	length of ppa_list
- * @opcode:	device opcode
- * @flags:	device flags
- * @buf:	data buffer
- * @len:	data buffer length
- */
-int nvm_submit_ppa_list(struct nvm_dev *dev, struct ppa_addr *ppa_list,
-			int nr_ppas, int opcode, int flags, void *buf, int len)
-{
-	struct nvm_rq rqd;
-
-	if (dev->ops->max_phys_sect < nr_ppas)
-		return -EINVAL;
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
-
-	rqd.nr_ppas = nr_ppas;
-	if (nr_ppas > 1)
-		rqd.ppa_list = ppa_list;
-	else
-		rqd.ppa_addr = ppa_list[0];
-
-	return __nvm_submit_ppa(dev, &rqd, opcode, flags, buf, len);
-}
-EXPORT_SYMBOL(nvm_submit_ppa_list);
-
-/**
- * nvm_submit_ppa - submit PPAs to device. PPAs will automatically be unfolded
- *		    as single, dual, quad plane PPAs depending on device type.
- * @dev:	device
- * @ppa:	user created ppa_list
- * @nr_ppas:	length of ppa_list
- * @opcode:	device opcode
- * @flags:	device flags
- * @buf:	data buffer
- * @len:	data buffer length
- */
-int nvm_submit_ppa(struct nvm_dev *dev, struct ppa_addr *ppa, int nr_ppas,
-				int opcode, int flags, void *buf, int len)
-{
-	struct nvm_rq rqd;
-	int ret;
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
-	ret = nvm_set_rqd_ppalist(dev, &rqd, ppa, nr_ppas, 1);
-	if (ret)
-		return ret;
-
-	ret = __nvm_submit_ppa(dev, &rqd, opcode, flags, buf, len);
-
-	nvm_free_rqd_ppalist(dev, &rqd);
-
-	return ret;
-}
-EXPORT_SYMBOL(nvm_submit_ppa);
-
 /*
  * folds a bad block list from its plane representation to its virtual
  * block representation. The fold is done in place and reduced size is
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index f2007b2..abb3d55 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -489,10 +489,6 @@ extern int nvm_get_l2p_tbl(struct nvm_tgt_dev *, u64, u32, nvm_l2p_update_fn *,
 extern int nvm_get_area(struct nvm_tgt_dev *, sector_t *, sector_t);
 extern void nvm_put_area(struct nvm_tgt_dev *, sector_t);
 extern void nvm_end_io(struct nvm_rq *, int);
-extern int nvm_submit_ppa(struct nvm_dev *, struct ppa_addr *, int, int, int,
-								void *, int);
-extern int nvm_submit_ppa_list(struct nvm_dev *, struct ppa_addr *, int, int,
-							int, void *, int);
 extern int nvm_bb_tbl_fold(struct nvm_dev *, u8 *, int);
 extern int nvm_get_bb_tbl(struct nvm_dev *, struct ppa_addr, u8 *);
 extern int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr, u8 *);
-- 
2.7.4

