Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD45AC05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 20:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBQUZM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBQUZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 15:25:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63A060A4D
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676665418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8KVm+rH4OiProm3VFkUTkkgWGgDejSqetBx+uMahJ4=;
        b=MnQhx8qgf5F+GjwwST4/9mh+ghoID4tTTQ3CMaM6unmps5OIulhMg0rWfwliSYc/6JYdYI
        /Eny54A/YYtNpzOBZgDbVrK/4OZN6Kui16yqYfurJW64lHfRpS/VD8dQJTbmG64Hl3ynS6
        Vefcpd7swIqHrg5jzXzXDs7sLU/njbI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-aZh4fNSdOp27lS4lj24o0A-1; Fri, 17 Feb 2023 15:23:34 -0500
X-MC-Unique: aZh4fNSdOp27lS4lj24o0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 414092805586;
        Fri, 17 Feb 2023 20:23:33 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B920C15BA0;
        Fri, 17 Feb 2023 20:23:28 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, Chas Williams <3chas3@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        Andrew Waterman <waterman@eecs.berkeley.edu>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 4/4] Move USE_WCACHING to drivers/block/pktcdvd.c
Date:   Fri, 17 Feb 2023 21:23:01 +0100
Message-Id: <20230217202301.436895-5-thuth@redhat.com>
In-Reply-To: <20230217202301.436895-1-thuth@redhat.com>
References: <20230217202301.436895-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

I don't think this was ever intended to be exposed to userspace, but
it did require an "#ifdef CONFIG_*".  Since the name is kind of
generic and was only used in one place, I've moved the definition to
the one user.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
Message-Id: <1447119071-19392-11-git-send-email-palmer@dabbelt.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 drivers/block/pktcdvd.c      | 11 +++++++++++
 include/uapi/linux/pktcdvd.h | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 2f1a92509271..1d5ec8d9d1a5 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -90,6 +90,17 @@ do {									\
 
 #define MAX_SPEED 0xffff
 
+/*
+ * use drive write caching -- we need deferred error handling to be
+ * able to successfully recover with this option (drive will return good
+ * status as soon as the cdb is validated).
+ */
+#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
+#define USE_WCACHING		1
+#else
+#define USE_WCACHING		0
+#endif
+
 static DEFINE_MUTEX(pktcdvd_mutex);
 static struct pktcdvd_device *pkt_devs[MAX_WRITERS];
 static struct proc_dir_entry *pkt_proc;
diff --git a/include/uapi/linux/pktcdvd.h b/include/uapi/linux/pktcdvd.h
index 9cbb55d21c94..6a5552dfd6af 100644
--- a/include/uapi/linux/pktcdvd.h
+++ b/include/uapi/linux/pktcdvd.h
@@ -29,17 +29,6 @@
  */
 #define PACKET_WAIT_TIME	(HZ * 5 / 1000)
 
-/*
- * use drive write caching -- we need deferred error handling to be
- * able to successfully recover with this option (drive will return good
- * status as soon as the cdb is validated).
- */
-#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
-#define USE_WCACHING		1
-#else
-#define USE_WCACHING		0
-#endif
-
 /*
  * No user-servicable parts beyond this point ->
  */
-- 
2.31.1

