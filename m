Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45257 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbeIRNeo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 09:34:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so1081844eda.12
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 01:03:17 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 4/4] lightnvm: pblk: guarantee mw_cunits on read buffer
Date: Tue, 18 Sep 2018 10:03:05 +0200
Message-Id: <1537257785-31630-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
References: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

OCSSD 2.0 defines the amount of data that the host must buffer per chunk
to guarantee reads through the geometry field mw_cunits. This value is
the base that pblk uses to determine the size of its read buffer.
Currently, this size is set to be the closes power-of-2 to mw_cunits
times the number of parallel units available to the pblk instance for
each open line (currently one). When an entry (4KB) is put in the
buffer, the L2P table points to it. As the buffer wraps up, the L2P is
updated to point to addresses on the device, thus guaranteeing mw_cunits
at a chunk level.

However, given that pblk cannot write to the device under ws_min
(normally ws_opt), there might be a window in which the buffer starts
wrapping up and updating L2P entries before the mw_cunits value in a
chunk has been surpassed.

In order not to violate the mw_cunits constrain in this case, account
for ws_opt on the read buffer creation.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 549f13a58b33..604bb743b92b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -195,7 +195,8 @@ static int pblk_rwb_init(struct pblk *pblk)
 	unsigned long buffer_size;
 	int pgs_in_buffer;
 
-	pgs_in_buffer = max(geo->mw_cunits, geo->ws_opt) * geo->all_luns;
+	pgs_in_buffer = (max(geo->mw_cunits, geo->ws_opt) + geo->ws_opt)
+								* geo->all_luns;
 
 	if (write_buffer_size && (write_buffer_size > pgs_in_buffer))
 		buffer_size = write_buffer_size;
-- 
2.7.4
