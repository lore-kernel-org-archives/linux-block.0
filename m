Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36050 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbcEKMIr (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 11 May 2016 08:08:47 -0400
Received: by mail-wm0-f46.google.com with SMTP id n129so216791775wmn.1
        for <linux-block@vger.kernel.org>; Wed, 11 May 2016 05:08:46 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: clear reserved bit on generic addr
Date: Wed, 11 May 2016 14:08:26 +0200
Message-Id: <1462968506-9292-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When an address is converted from device to generic mode, the reserved
bit needs to be cleared in order to signal that the address points to a
flash block, not to a cacheline on the write buffer.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 include/linux/lightnvm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 45be892..3d2c380 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -418,6 +418,9 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 	l.g.ch |= (r.ppa >> dev->ppaf.ch_offset) &
 					(((1 << dev->ppaf.ch_len) - 1));
 
+	/* On device side, reserved bit is always 0 */
+	l.g.reserved = 0;
+
 	return l;
 }
 
-- 
2.5.0

