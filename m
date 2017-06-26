Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35635 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751397AbdFZJ6M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:12 -0400
Received: by mail-wm0-f54.google.com with SMTP id w126so2843317wme.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:11 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 01/20] lightnvm: re-convert ppa format on I/O failure
Date: Mon, 26 Jun 2017 11:57:10 +0200
Message-Id: <1498471049-25505-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In case of a failure when submitting a request, convert the ppa_list
addresses to the target format so that it can interpret ppas for
recovery

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 440deb54031a..9ff348f69370 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -641,6 +641,7 @@ EXPORT_SYMBOL(nvm_max_phys_sects);
 int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
+	int ret;
 
 	if (!dev->ops->submit_io)
 		return -ENODEV;
@@ -648,7 +649,12 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 	nvm_rq_tgt_to_dev(tgt_dev, rqd);
 
 	rqd->dev = tgt_dev;
-	return dev->ops->submit_io(dev, rqd);
+
+	/* In case of error, fail with right address format */
+	ret = dev->ops->submit_io(dev, rqd);
+	if (ret)
+		nvm_rq_dev_to_tgt(tgt_dev, rqd);
+	return ret;
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
-- 
2.7.4
