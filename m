Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DCDC433FF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE27220679
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfG2Uc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:32:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43127 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfG2Uc3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 16:32:29 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsCJm-0001rt-PQ
        for linux-block@vger.kernel.org; Mon, 29 Jul 2019 20:32:26 +0000
Received: by mail-pf1-f199.google.com with SMTP id y66so39211471pfb.21
        for <linux-block@vger.kernel.org>; Mon, 29 Jul 2019 13:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIjcz6M8NyPtGB3RM+IZ0QLHvujOqxEoGwPE89UkV5k=;
        b=ToI2QmfCnrdIJj0M7+zcroj8Fzo49FNpkP6iJ2ON4rJm+6x1VqYB0XooFiWvR2ApY2
         qONrID+4fkS37xMFyK2O30qNBzY6jSFe4amA7y72Z9xISb252AyD2fhnWVfGXo+6bLuS
         v6yf1oCM6pNyb/HndDqbQ8fWqrEER/deAIVjDIH0j6+eD60DbXW0N7huxEenlhEDCcqY
         yZNYUBsECnkZGPajgnmgzY8XN50Edab0vEbpUGyrqb9O6qRKwPSUBZ9AFxybUwXPjEM/
         SlFuEq2zAk17rGMU24+iTwWmnjoing6kH0/4Zw6KV4df9sUmsoFYPgeaG7QLkqJsjaC6
         lZWQ==
X-Gm-Message-State: APjAAAVtJ10pKf93eM75pr7mwq0l8wGtZ7SPizVLCepeIOiqonbG0R6/
        VF5ZIQYoRiGfBSYZ3jA80LffTN01j92RECMAuEIhVZmrQYLUE91bPmcHzSvUhPGNggQIKys+06M
        0n8LaAV4Wz6m5MvOK5F5sy6BzyjXkB/aeEPYQvBxN
X-Received: by 2002:a62:b411:: with SMTP id h17mr36752107pfn.99.1564432345512;
        Mon, 29 Jul 2019 13:32:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxeJ2LYVVU963yH9rf018/SKEDn/PK5NA2KYIlWk86JH+JXwBlhoFCYG/WM7iwIvhPnEptODA==
X-Received: by 2002:a62:b411:: with SMTP id h17mr36752082pfn.99.1564432345289;
        Mon, 29 Jul 2019 13:32:25 -0700 (PDT)
Received: from localhost ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id 67sm28789831pfd.177.2019.07.29.13.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:32:24 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com, neilb@suse.com,
        songliubraving@fb.com
Subject: [PATCH 2/2] mdadm: Introduce new array state 'broken' for raid0
Date:   Mon, 29 Jul 2019 17:31:35 -0300
Message-Id: <20190729203135.12934-3-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729203135.12934-1-gpiccoli@canonical.com>
References: <20190729203135.12934-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently if a md/raid0 array gets one or more members removed while
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
command (for raid0 only) - now it takes the 'array_state' sysfs attribute
into account instead of only rely in the MD_SB_CLEAN flag.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 Detail.c  | 16 ++++++++++++++--
 Monitor.c |  9 +++++++--
 maps.c    |  1 +
 mdadm.h   |  1 +
 mdmon.h   |  2 +-
 monitor.c |  4 ++--
 6 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Detail.c b/Detail.c
index 20ea03a..4bf86b1 100644
--- a/Detail.c
+++ b/Detail.c
@@ -81,6 +81,7 @@ int Detail(char *dev, struct context *c)
 	int external;
 	int inactive;
 	int is_container = 0;
+	char arrayst[12] = { 0 }; /* no state is >10 chars currently */
 
 	if (fd < 0) {
 		pr_err("cannot open %s: %s\n",
@@ -485,9 +486,20 @@ int Detail(char *dev, struct context *c)
 			else
 				st = ", degraded";
 
+			if (array.state & (1 << MD_SB_CLEAN)) {
+				if (array.level == 0)
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
index 036103f..9a6a250 100644
--- a/Monitor.c
+++ b/Monitor.c
@@ -1055,8 +1055,12 @@ int Wait(char *dev)
 	}
 }
 
+/* The state "broken" is used only for RAID0 - it's the same as "clean", but
+ * used in case the array has one or more members missing.
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
index 02a0474..98ddbbc 100644
--- a/maps.c
+++ b/maps.c
@@ -150,6 +150,7 @@ mapping_t sysfs_array_states[] = {
 	{ "read-auto", ARRAY_READ_AUTO },
 	{ "clean", ARRAY_CLEAN },
 	{ "write-pending", ARRAY_WRITE_PENDING },
+	{ "broken", ARRAY_BROKEN_RAID0 },
 	{ NULL, ARRAY_UNKNOWN_STATE }
 };
 
diff --git a/mdadm.h b/mdadm.h
index c36d7fd..72c2525 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -375,6 +375,7 @@ struct mdinfo {
 		ARRAY_ACTIVE,
 		ARRAY_WRITE_PENDING,
 		ARRAY_ACTIVE_IDLE,
+		ARRAY_BROKEN_RAID0,
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

