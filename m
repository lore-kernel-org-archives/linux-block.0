Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36997 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeBUJ1M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:12 -0500
Received: by mail-wr0-f196.google.com with SMTP id z12so2446406wrg.4
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:12 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 02/20] lightnvm: add controller capabilities to 2.0
Date: Wed, 21 Feb 2018 10:26:40 +0100
Message-Id: <1519205218-26994-3-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Assign missing mccap value on 2.0 path

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index c81e64cc20d7..969bb874850c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -392,6 +392,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	dev_geo->c.ws_opt = le32_to_cpu(id->ws_opt);
 	dev_geo->c.mw_cunits = le32_to_cpu(id->mw_cunits);
 
+	dev_geo->c.mccap = le32_to_cpu(id->mccap);
+
 	dev_geo->c.trdt = le32_to_cpu(id->trdt);
 	dev_geo->c.trdm = le32_to_cpu(id->trdm);
 	dev_geo->c.tprt = le32_to_cpu(id->twrt);
-- 
2.7.4
