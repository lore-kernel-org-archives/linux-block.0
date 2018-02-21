Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44651 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbeBUJ1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:25 -0500
Received: by mail-wr0-f194.google.com with SMTP id v65so2422313wrc.11
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:24 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 14/20] lightnvm: make address conversions depend on generic device
Date: Wed, 21 Feb 2018 10:26:52 +0100
Message-Id: <1519205218-26994-15-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On address conversions, use the generic device, instead of the target
device. This allows to use conversions outside of the target's realm.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 4 ++--
 include/linux/lightnvm.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index baec963b2c96..59b62ca65596 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -588,7 +588,7 @@ static void nvm_ppa_tgt_to_dev(struct nvm_tgt_dev *tgt_dev,
 
 	for (i = 0; i < nr_ppas; i++) {
 		nvm_map_to_dev(tgt_dev, &ppa_list[i]);
-		ppa_list[i] = generic_to_dev_addr(tgt_dev, ppa_list[i]);
+		ppa_list[i] = generic_to_dev_addr(tgt_dev->parent, ppa_list[i]);
 	}
 }
 
@@ -598,7 +598,7 @@ static void nvm_ppa_dev_to_tgt(struct nvm_tgt_dev *tgt_dev,
 	int i;
 
 	for (i = 0; i < nr_ppas; i++) {
-		ppa_list[i] = dev_to_generic_addr(tgt_dev, ppa_list[i]);
+		ppa_list[i] = dev_to_generic_addr(tgt_dev->parent, ppa_list[i]);
 		nvm_map_to_tgt(tgt_dev, &ppa_list[i]);
 	}
 }
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index cd310bf06051..91340998f0c3 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -415,10 +415,10 @@ struct nvm_dev {
 	struct list_head targets;
 };
 
-static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
+static inline struct ppa_addr generic_to_dev_addr(struct nvm_dev *dev,
 						  struct ppa_addr r)
 {
-	struct nvm_geo *geo = &tgt_dev->geo;
+	struct nvm_dev_geo *geo = &dev->dev_geo;
 	struct ppa_addr l;
 
 	if (geo->c.version == NVM_OCSSD_SPEC_12) {
@@ -443,10 +443,10 @@ static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
 	return l;
 }
 
-static inline struct ppa_addr dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
+static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 						  struct ppa_addr r)
 {
-	struct nvm_geo *geo = &tgt_dev->geo;
+	struct nvm_dev_geo *geo = &dev->dev_geo;
 	struct ppa_addr l;
 
 	l.ppa = 0;
-- 
2.7.4
