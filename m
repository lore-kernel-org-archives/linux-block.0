Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34912 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752374AbdDJSwB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 14:52:01 -0400
Received: by mail-wm0-f51.google.com with SMTP id w64so46465650wma.0
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2017 11:52:00 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/3] lightnvm: make nvm_free static
Date: Mon, 10 Apr 2017 20:51:37 +0200
Message-Id: <1491850297-18235-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1491850297-18235-1-git-send-email-javier@cnexlabs.com>
References: <1491850297-18235-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Prefix the nvm_free static function with a missing static keyword.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index bdbb333..3e51a05 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -999,7 +999,7 @@ static int nvm_core_init(struct nvm_dev *dev)
 	return ret;
 }
 
-void nvm_free(struct nvm_dev *dev)
+static void nvm_free(struct nvm_dev *dev)
 {
 	if (!dev)
 		return;
-- 
2.7.4
