Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36273 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756617AbcGGHyj (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id i4so3077450wmg.3
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:38 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 04/17] nvme: lightnvm: make MLC num_pairs little endian
Date: Thu,  7 Jul 2016 09:54:10 +0200
Message-Id: <1467878063-22919-5-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Johannes Thumshirn <jthumshirn@suse.de>

According to the OpenChannel SSD interface specification the NAND flash
MLC page pairing information's number of page page pairings field is the
first two bytes in the MLC Page Pairing data structure. The hardware's
data structure itself is little endian so annotate it as such, like the
rest of lighnvm's data structures.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a0af055..97fe610 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -156,7 +156,7 @@ struct nvme_nvm_completion {
 
 #define NVME_NVM_LP_MLC_PAIRS 886
 struct nvme_nvm_lp_mlc {
-	__u16			num_pairs;
+	__le16			num_pairs;
 	__u8			pairs[NVME_NVM_LP_MLC_PAIRS];
 };
 
-- 
2.1.4

