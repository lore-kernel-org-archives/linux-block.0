Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33218 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdFCDiW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2017 23:38:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so14519120pfe.0
        for <linux-block@vger.kernel.org>; Fri, 02 Jun 2017 20:38:21 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-block@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] elevator: fix truncation of icq_cache_name
Date: Fri,  2 Jun 2017 20:35:51 -0700
Message-Id: <20170603033551.17261-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

gcc 7.1 reports the following warning:

    block/elevator.c: In function ‘elv_register’:
    block/elevator.c:898:5: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
         "%s_io_cq", e->elevator_name);
         ^~~~~~~~~~
    block/elevator.c:897:3: note: ‘snprintf’ output between 7 and 22 bytes into a destination of size 21
       snprintf(e->icq_cache_name, sizeof(e->icq_cache_name),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "%s_io_cq", e->elevator_name);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The bug is that the name of the icq_cache is 6 characters longer than
the elevator name, but only ELV_NAME_MAX + 5 characters were reserved
for it --- so in the case of a maximum-length elevator name, the 'q'
character in "_io_cq" would be truncated by snprintf().  Fix it by
reserving ELV_NAME_MAX + 6 characters instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/elevator.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 9ec5e22846e0..0e306c5a86d6 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -153,7 +153,7 @@ struct elevator_type
 #endif
 
 	/* managed by elevator core */
-	char icq_cache_name[ELV_NAME_MAX + 5];	/* elvname + "_io_cq" */
+	char icq_cache_name[ELV_NAME_MAX + 6];	/* elvname + "_io_cq" */
 	struct list_head list;
 };
 
-- 
2.13.0
