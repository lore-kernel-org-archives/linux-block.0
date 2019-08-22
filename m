Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EA2C3A5A1
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 16:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F13233A2
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 16:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfHVQPJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:15:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41545 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732157AbfHVQPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 12:15:09 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1i0piZ-0008RI-1F
        for linux-block@vger.kernel.org; Thu, 22 Aug 2019 16:13:43 +0000
Received: by mail-qt1-f200.google.com with SMTP id 91so7013622qtf.13
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2019 09:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xO4f5LyO1PZ+amXcQ0RlQJkFGBKrHUfxg3DhwTaUd1U=;
        b=o4NmzowRIAUMO4l9I1+e7RcOdWD6P2QaMu/lQS46EZXSPqv58AIyfrQBMlr/xrqm12
         ae0+PGyaYfeZdN3Y/lfigyuFUYtB0DqLkttWaqjMBRTmKKqueTGo9lr9bJeG2crUc04C
         8JbMxUiiYLeI4xxddfq+b05sBY47woHqNzJlbwEhh/1XB4wpfT0sLriuBVXC25qO9++8
         W90PJ5w7Z6Rs6mYIH2DZwCC7i8GRn8Yvaj9+qT2OPwikh3uhq36M+RLdGjk651jEqoMF
         vef4BH4gXgyVwbwocRFXX0nsB2AhUu6h5XdmGUForWt3Hj0Zv27FchGKN0ZcrFJQwo51
         2YhQ==
X-Gm-Message-State: APjAAAVNTsLRN8URC/FEtOF5f4UorcJEd8W3DqSAryuQCha4Z6UJ65QO
        qD944OnJLW0PNZRlUBEzmpmUFLyGxruNDkXV5T7+/mvljOgia+VQ3PZKnZqWyM5SR78jz8k4sIL
        GOTBcAwS2CHQIu7rsDjR2nXnnCK5LUW7uzqFhveCy
X-Received: by 2002:a05:620a:693:: with SMTP id f19mr38335965qkh.189.1566490421776;
        Thu, 22 Aug 2019 09:13:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxCa+zfrHMhMyn0bVEAvMuTDgOyEWm8N+LMas5RglV0aoVXn+mpkmkBG0TTKtYV2WN+FR11kQ==
X-Received: by 2002:a05:620a:693:: with SMTP id f19mr38335936qkh.189.1566490421540;
        Thu, 22 Aug 2019 09:13:41 -0700 (PDT)
Received: from localhost ([191.13.61.137])
        by smtp.gmail.com with ESMTPSA id z186sm65318qkb.2.2019.08.22.09.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:13:40 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com,
        liu.song.a23@gmail.com, NeilBrown <neilb@suse.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v3 2/2] mdadm: Introduce new array state 'broken' for raid0/linear
Date:   Thu, 22 Aug 2019 13:13:18 -0300
Message-Id: <20190822161318.26236-2-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190822161318.26236-1-gpiccoli@canonical.com>
References: <20190822161318.26236-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently if a md raid0/linear array gets one or more members removed while
being mounted, kernel keeps showing state 'clean' in the 'array_state'
sysfs attribute. Despite udev signaling the member device is gone, 'mdadm'
cannot issue the STOP_ARRAY ioctl successfully, given the array is mounted.

Nothing else hints that something is wrong (except that the removed devices
don't show properly in the output of mdadm 'detail' command). There is no
other property to be checked, and if user is not performing reads/writes
to the array, even kernel log is quiet and doesn't give a clue about the
missing member.

This patch is the mdadm counterpart of kernel new array state 'broken'.
The 'broken' state mimics the state 'clean' in every aspect, being useful
only to distinguish if an array has some member missing. All necessary
paths in mdadm were changed to deal with 'broken' state, and in case the
tool runs in a kernel that is not updated, it'll work normally, i.e., it
doesn't require the 'broken' state in order to work.
Also, this patch changes the way the array state is showed in the 'detail'
command (for raid0/linear only) - now it takes the 'array_state' sysfs
attribute into account instead of only rely in the MD_SB_CLEAN flag.

Cc: NeilBrown <neilb@suse.com>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

v2 -> v3:
* Nothing changed.

v1 -> v2:
* Added handling for md/linear 'broken' state.


 Detail.c  | 17 +++++++++++++++--
 Monitor.c |  9 +++++++--
 maps.c    |  1 +
 mdadm.h   |  1 +
 mdmon.h   |  2 +-
 monitor.c |  4 ++--
 6 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/Detail.c b/Detail.c
index ad60434..cc7e9f1 100644
--- a/Detail.c
+++ b/Detail.c
@@ -81,6 +81,7 @@ int Detail(char *dev, struct context *c)
 	int external;
 	int inactive;
 	int is_container = 0;
+	char arrayst[12] = { 0 }; /* no state is >10 chars currently */
 
 	if (fd < 0) {
 		pr_err("cannot open %s: %s\n",
@@ -485,9 +486,21 @@ int Detail(char *dev, struct context *c)
 			else
 				st = ", degraded";
 
+			if (array.state & (1 << MD_SB_CLEAN)) {
+				if ((array.level == 0) ||
+				    (array.level == LEVEL_LINEAR))
+					strncpy(arrayst,
+						map_num(sysfs_array_states,
+							sra->array_state),
+						sizeof(arrayst)-1);
+				else
+					strncpy(arrayst, "clean",
+						sizeof(arrayst)-1);
+			} else
+				strncpy(arrayst, "active", sizeof(arrayst)-1);
+
 			printf("             State : %s%s%s%s%s%s \n",
-			       (array.state & (1 << MD_SB_CLEAN)) ?
-			       "clean" : "active", st,
+			       arrayst, st,
 			       (!e || (e->percent < 0 &&
 				       e->percent != RESYNC_PENDING &&
 				       e->percent != RESYNC_DELAYED)) ?
diff --git a/Monitor.c b/Monitor.c
index 036103f..9fd5406 100644
--- a/Monitor.c
+++ b/Monitor.c
@@ -1055,8 +1055,12 @@ int Wait(char *dev)
 	}
 }
 
+/* The state "broken" is used only for RAID0/LINEAR - it's the same as
+ * "clean", but used in case the array has one or more members missing.
+ */
+#define CLEAN_STATES_LAST_POS	5
 static char *clean_states[] = {
-	"clear", "inactive", "readonly", "read-auto", "clean", NULL };
+	"clear", "inactive", "readonly", "read-auto", "clean", "broken", NULL };
 
 int WaitClean(char *dev, int verbose)
 {
@@ -1116,7 +1120,8 @@ int WaitClean(char *dev, int verbose)
 			rv = read(state_fd, buf, sizeof(buf));
 			if (rv < 0)
 				break;
-			if (sysfs_match_word(buf, clean_states) <= 4)
+			if (sysfs_match_word(buf, clean_states)
+			    <= CLEAN_STATES_LAST_POS)
 				break;
 			rv = sysfs_wait(state_fd, &delay);
 			if (rv < 0 && errno != EINTR)
diff --git a/maps.c b/maps.c
index 02a0474..49b7f2c 100644
--- a/maps.c
+++ b/maps.c
@@ -150,6 +150,7 @@ mapping_t sysfs_array_states[] = {
 	{ "read-auto", ARRAY_READ_AUTO },
 	{ "clean", ARRAY_CLEAN },
 	{ "write-pending", ARRAY_WRITE_PENDING },
+	{ "broken", ARRAY_BROKEN },
 	{ NULL, ARRAY_UNKNOWN_STATE }
 };
 
diff --git a/mdadm.h b/mdadm.h
index 43b07d5..c88ceab 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -373,6 +373,7 @@ struct mdinfo {
 		ARRAY_ACTIVE,
 		ARRAY_WRITE_PENDING,
 		ARRAY_ACTIVE_IDLE,
+		ARRAY_BROKEN,
 		ARRAY_UNKNOWN_STATE,
 	} array_state;
 	struct md_bb bb;
diff --git a/mdmon.h b/mdmon.h
index 818367c..b3d72ac 100644
--- a/mdmon.h
+++ b/mdmon.h
@@ -21,7 +21,7 @@
 extern const char Name[];
 
 enum array_state { clear, inactive, suspended, readonly, read_auto,
-		   clean, active, write_pending, active_idle, bad_word};
+		   clean, active, write_pending, active_idle, broken, bad_word};
 
 enum sync_action { idle, reshape, resync, recover, check, repair, bad_action };
 
diff --git a/monitor.c b/monitor.c
index 81537ed..e0d3be6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -26,7 +26,7 @@
 
 static char *array_states[] = {
 	"clear", "inactive", "suspended", "readonly", "read-auto",
-	"clean", "active", "write-pending", "active-idle", NULL };
+	"clean", "active", "write-pending", "active-idle", "broken", NULL };
 static char *sync_actions[] = {
 	"idle", "reshape", "resync", "recover", "check", "repair", NULL
 };
@@ -476,7 +476,7 @@ static int read_and_act(struct active_array *a, fd_set *fds)
 		a->next_state = clean;
 		ret |= ARRAY_DIRTY;
 	}
-	if (a->curr_state == clean) {
+	if ((a->curr_state == clean) || (a->curr_state == broken)) {
 		a->container->ss->set_array_state(a, 1);
 	}
 	if (a->curr_state == active ||
-- 
2.22.0

