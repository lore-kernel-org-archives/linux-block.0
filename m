Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:51698 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeH2OGD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 10:06:03 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so6879185itf.1
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 03:09:53 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
Date: Wed, 29 Aug 2018 12:09:29 +0200
Message-Id: <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In the OCSSD 2.0 spec., the sector and metadata sizes are reported though
the standard nvme identify command. Thus, the lightnvm subsystem needs
to update this information on the geometry structure on bootup.

Since 1.2 devices report these values on the OCSSD geometry identify,
avoid this update is it is unnecessary and can also corrupt the geometry
if the devices does not report the nvme sizes correctly (which is not
required by the OCSSD 1.2 spec either)

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 5bfa354c5dd5..33ed09f8410e 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_geo *geo = &ndev->geo;
 
+	if (geo->version == NVM_OCSSD_SPEC_12)
+		return;
+
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
 }
-- 
2.7.4
