Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38536 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeJIScD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:32:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id f29-v6so680369pff.5
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:15:37 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 42/45] lightnvm: do no update csecs and sos on 1.2
Date: Tue,  9 Oct 2018 13:12:12 +0200
Message-Id: <20181009111215.7653-43-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

1.2 devices exposes their data and metadata size through the separate
identify command. Make sure that the NVMe LBA format does not override
these values.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 7d0a4d3b0a48..a4f3b263cd6c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -977,6 +977,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_geo *geo = &ndev->geo;
 
+	if (geo->version == NVM_OCSSD_SPEC_12)
+		return;
+
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
 }
-- 
2.17.1
