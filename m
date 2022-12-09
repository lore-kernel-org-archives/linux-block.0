Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970EAC4708D
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 14:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLIO4J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiLIOzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 09:55:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E9680A3A
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 06:55:09 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so3377839edc.12
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 06:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnWGghdREJ6zIaEe7+G9hDEkG3lKlZcJtoyqEzGOui4=;
        b=etk+O6PxUdlMnrbUHpn6B7DyLtaQUUWYF68CRq/diHpQhMD1Z8IH20wHDuGOJ7Ps2J
         vC2i9BWWlwz5l+GrDZNBxw+W1qTuXLQlNfCd7StHomMxa3+hnOJ4iXULEZ1yXuUtLIi7
         pZeG2tOWgfCC8jIEQTqshRzeWx3C8PCoXdDZqbRIUx/JuNKnTzg8qDamfb4MhonIB03y
         uYbkQ2tX8LWjTCRPZpY+AVF1BobG/QCvsVsuV9T2/ra06cxeIpJSHKw0TfYf/Dlkruo+
         8BZwazFbW6b0ntHMmBhjuTA7FwAsGpCBqGzaDNkL890QWEVq298eQneGC4gS/ev6ADSw
         4Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnWGghdREJ6zIaEe7+G9hDEkG3lKlZcJtoyqEzGOui4=;
        b=a+Whw3WXsGppPshOsU50cCYk0dirday4u8iN0JVmVWqBHX6dDR0psQCmUFNw+R+XZp
         dp7L6uCtT3b3j2ygoE1XL7lTuIbYQ5zTpQ1SUbtoF/ebHbuhrXh+kMvgKH7Shw00/miR
         +bEDiwtBkeZKWgF2yaQKH90OFDi42oQit5EkRPKIZYfAbOAiePzdUnKN+qFbQSjHB9io
         EJwvbTBVyvsEJlHsYb6Inaxq19O5SPDNkHjQEaL0vlpg0RbnI/9SwsllE2jL+weUejG6
         MGAMh/SM0aQeoMx3uZ+JxxiHr/cHD0ZTHio5wBZv87NArn0D4odaJv/lQaIybQuYi/qB
         EyWw==
X-Gm-Message-State: ANoB5pk8nJD+yLOtLnD3rEl4m8f9KBaxfJ9lxPg4KUGNLe7HZr2XJuLz
        xkppUCcE/jeaiTSgq6RefSOkZw==
X-Google-Smtp-Source: AA0mqf5rbXukl5UTZkcY7tYtNfsG6ZjU+A51fdmuMQAEXwiG59ugk79RVU8Yl/8afabZ/aFwOYxQZw==
X-Received: by 2002:a05:6402:298d:b0:465:f6a9:cb7b with SMTP id eq13-20020a056402298d00b00465f6a9cb7bmr4954559edb.12.1670597708142;
        Fri, 09 Dec 2022 06:55:08 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b0046b1d63cfc1sm716856edq.88.2022.12.09.06.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:55:07 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 2/3] drbd: drop API_VERSION define
Date:   Fri,  9 Dec 2022 15:55:03 +0100
Message-Id: <20221209145504.2273072-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
References: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the genetlink api version as defined in drbd_genl_api.h.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_debugfs.c | 2 +-
 drivers/block/drbd/drbd_main.c    | 2 +-
 drivers/block/drbd/drbd_proc.c    | 2 +-
 include/linux/drbd.h              | 1 -
 include/linux/drbd_genl_api.h     | 2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index a72c096aa5b1..12460b584bcb 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -844,7 +844,7 @@ static int drbd_version_show(struct seq_file *m, void *ignored)
 {
 	seq_printf(m, "# %s\n", drbd_buildtag());
 	seq_printf(m, "VERSION=%s\n", REL_VERSION);
-	seq_printf(m, "API_VERSION=%u\n", API_VERSION);
+	seq_printf(m, "API_VERSION=%u\n", GENL_MAGIC_VERSION);
 	seq_printf(m, "PRO_VERSION_MIN=%u\n", PRO_VERSION_MIN);
 	seq_printf(m, "PRO_VERSION_MAX=%u\n", PRO_VERSION_MAX);
 	return 0;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 345bfac441da..5156d2fb2d76 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2899,7 +2899,7 @@ static int __init drbd_init(void)
 
 	pr_info("initialized. "
 	       "Version: " REL_VERSION " (api:%d/proto:%d-%d)\n",
-	       API_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX);
+	       GENL_MAGIC_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX);
 	pr_info("%s\n", drbd_buildtag());
 	pr_info("registered as block device major %d\n", DRBD_MAJOR);
 	return 0; /* Success! */
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 2227fb0db1ce..1d0feafceadc 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -228,7 +228,7 @@ int drbd_seq_show(struct seq_file *seq, void *v)
 	};
 
 	seq_printf(seq, "version: " REL_VERSION " (api:%d/proto:%d-%d)\n%s\n",
-		   API_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX, drbd_buildtag());
+		   GENL_MAGIC_VERSION, PRO_VERSION_MIN, PRO_VERSION_MAX, drbd_buildtag());
 
 	/*
 	  cs .. connection state
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 5755537b51b1..df65a8f5228a 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -40,7 +40,6 @@
 
 extern const char *drbd_buildtag(void);
 #define REL_VERSION "8.4.11"
-#define API_VERSION 1
 #define PRO_VERSION_MIN 86
 #define PRO_VERSION_MAX 101
 
diff --git a/include/linux/drbd_genl_api.h b/include/linux/drbd_genl_api.h
index bd62efc29002..70682c058027 100644
--- a/include/linux/drbd_genl_api.h
+++ b/include/linux/drbd_genl_api.h
@@ -47,7 +47,7 @@ enum drbd_state_info_bcast_reason {
 #undef linux
 
 #include <linux/drbd.h>
-#define GENL_MAGIC_VERSION	API_VERSION
+#define GENL_MAGIC_VERSION	1
 #define GENL_MAGIC_FAMILY	drbd
 #define GENL_MAGIC_FAMILY_HDRSZ	sizeof(struct drbd_genlmsghdr)
 #define GENL_MAGIC_INCLUDE_FILE <linux/drbd_genl.h>
-- 
2.38.1

