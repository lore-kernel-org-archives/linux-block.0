Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6E4C4708D
	for <linux-block@archiver.kernel.org>; Mon,  5 Dec 2022 19:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiLET2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Dec 2022 14:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiLET16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Dec 2022 14:27:58 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8156B286C7
        for <linux-block@vger.kernel.org>; Mon,  5 Dec 2022 11:24:53 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 2GxgpcFOTOAzA2GxhpQODA; Mon, 05 Dec 2022 20:17:12 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 05 Dec 2022 20:17:12 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christoph Hellwig <hch@infradead.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH v2] block: sed-opal: Don't include <linux/kernel.h>
Date:   Mon,  5 Dec 2022 20:16:48 +0100
Message-Id: <c1d479b39e30fe70c4579a1af035d4db49421f56.1670069909.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to include <linux/kernel.h> here.

Prefer the less invasive <linux/types.h> and <linux/compiler_types.h>
which are needed in this .h file itself.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Change in v2:
  * No need to add a useless comment    [Christoph Hellwig]
  * No need to add a new empty line     [Christoph Hellwig]

v1: https://lore.kernel.org/all/a2de79b3de30fe70c457953af935dadd49441f00.1670069909.git.christophe.jaillet@wanadoo.fr/

Let see if build-bots agree with me!
---
 include/linux/sed-opal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 6f837bb6c715..87f981c70894 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -11,7 +11,8 @@
 #define LINUX_OPAL_H
 
 #include <uapi/linux/sed-opal.h>
-#include <linux/kernel.h>
+#include <linux/compiler_types.h>
+#include <linux/types.h>
 
 struct opal_dev;
 
-- 
2.34.1

