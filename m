Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156FAC76186
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D561A20679
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 20:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfG2UcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:32:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43119 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2UcT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 16:32:19 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hsCJd-0001rM-5j
        for linux-block@vger.kernel.org; Mon, 29 Jul 2019 20:32:17 +0000
Received: by mail-pf1-f200.google.com with SMTP id u21so39221413pfn.15
        for <linux-block@vger.kernel.org>; Mon, 29 Jul 2019 13:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whXvhgGtatFXmXSUn6jtBUdUIA159PzirgC5FY68oK4=;
        b=nFeNbCp5HFJKIiQGkzfJyvOk6MmxVb60F70aTHp3eEWypZrgJ0Lpeo+7n4uBcENSRb
         Gnfgn/Xdzj7bNGTUR7liNf/rHp9+oCyxyXKcP/4L6vL0Znzzy9n6d1rhNf8ufsCclPgl
         MgpsTTUjq5JfjCz3WGM/JUZPfFvqRssn6jxYsPHfldaSbtdKYcCkDwKe/QZXn9up+6EH
         wlimLHyUXkSb2dUZMYq/G+EqFSQ0OOw5cfJSQDB0s4MG+OCUem/iZgZuIdwQSbyVQcro
         kDaCQKcbayLrfo1RTKzP4XpwCbli3QeXkVxVrAbeiycfyUpzFbFzw/Cm14QasJDZ5zzR
         xOXg==
X-Gm-Message-State: APjAAAUFkjmwGv4we6G825bFj2qV6guZj7ZUCW1C1bIHhQrwHp7pXx2r
        e9a5nzIFry/jKxwOPwCXSmSa4IXLTbBK6Z+9oFYvk1FWWX8Str9yeiqMuHVtOYNTXpjf4LnUDwk
        em9BuSQoqj9Dcy14nBLgU6qjNB5a5CGV80D7eCRjj
X-Received: by 2002:a17:902:5998:: with SMTP id p24mr36839251pli.110.1564432335923;
        Mon, 29 Jul 2019 13:32:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmi8xgalciar0mz+ASsu8t3lRBPdbMQ9dkrP8A8M7iRLQ6QwazuOhdM70/JckE2LFiY299IA==
X-Received: by 2002:a17:902:5998:: with SMTP id p24mr36839236pli.110.1564432335717;
        Mon, 29 Jul 2019 13:32:15 -0700 (PDT)
Received: from localhost ([152.254.214.186])
        by smtp.gmail.com with ESMTPSA id i137sm63642116pgc.4.2019.07.29.13.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:32:15 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com, neilb@suse.com,
        songliubraving@fb.com
Subject: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for raid0
Date:   Mon, 29 Jul 2019 17:31:34 -0300
Message-Id: <20190729203135.12934-2-gpiccoli@canonical.com>
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
don't show properly in the output of 'mdadm detail' command). There is no
other property to be checked, and if user is not performing reads/writes
to the array, even kernel log is quiet and doesn't give a clue about the
missing member.

This patch changes this behavior; when 'array_state' is read we introduce
a non-expensive check (only for raid0) that relies in the comparison of
the total number of disks when array was assembled with gendisk flags of
those devices to validate if all members are available and functional.
A new array state 'broken' was added: it mimics the state 'clean' in every
aspect, being useful only to distinguish if such array has some member
missing. Also, we show a rate-limited warning in kernel log in such case.

This patch has no proper functional change other than adding a 'clean'-like
state; it was tested with ext4 and xfs filesystems. It requires a 'mdadm'
counterpart to handle the 'broken' state.

Cc: NeilBrown <neilb@suse.com>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 drivers/md/md.c    | 23 +++++++++++++++++++----
 drivers/md/md.h    |  2 ++
 drivers/md/raid0.c | 26 ++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fba49918d591..b80f36084ec1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4160,12 +4160,18 @@ __ATTR_PREALLOC(resync_start, S_IRUGO|S_IWUSR,
  * active-idle
  *     like active, but no writes have been seen for a while (100msec).
  *
+ * broken
+ *     RAID0-only: same as clean, but array is missing a member.
+ *     It's useful because RAID0 mounted-arrays aren't stopped
+ *     when a member is gone, so this state will at least alert
+ *     the user that something is wrong.
+ *
  */
 enum array_state { clear, inactive, suspended, readonly, read_auto, clean, active,
-		   write_pending, active_idle, bad_word};
+		   write_pending, active_idle, broken, bad_word};
 static char *array_states[] = {
 	"clear", "inactive", "suspended", "readonly", "read-auto", "clean", "active",
-	"write-pending", "active-idle", NULL };
+	"write-pending", "active-idle", "broken", NULL };
 
 static int match_word(const char *word, char **list)
 {
@@ -4181,7 +4187,7 @@ array_state_show(struct mddev *mddev, char *page)
 {
 	enum array_state st = inactive;
 
-	if (mddev->pers)
+	if (mddev->pers) {
 		switch(mddev->ro) {
 		case 1:
 			st = readonly;
@@ -4201,7 +4207,15 @@ array_state_show(struct mddev *mddev, char *page)
 				st = active;
 			spin_unlock(&mddev->lock);
 		}
-	else {
+
+		if ((mddev->pers->level == 0) &&
+		   ((st == clean) || (st == broken))) {
+			if (mddev->pers->is_missing_dev(mddev))
+				st = broken;
+			else
+				st = clean;
+		}
+	} else {
 		if (list_empty(&mddev->disks) &&
 		    mddev->raid_disks == 0 &&
 		    mddev->dev_sectors == 0)
@@ -4315,6 +4329,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		break;
 	case write_pending:
 	case active_idle:
+	case broken:
 		/* these cannot be set */
 		break;
 	}
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 41552e615c4c..e7b42b75701a 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -590,6 +590,8 @@ struct md_personality
 	int (*congested)(struct mddev *mddev, int bits);
 	/* Changes the consistency policy of an active array. */
 	int (*change_consistency_policy)(struct mddev *mddev, const char *buf);
+	/* Check if there is any missing/failed members - RAID0 only for now. */
+	bool (*is_missing_dev)(struct mddev *mddev);
 };
 
 struct md_sysfs_entry {
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 58a9cc5193bf..79618a6ae31a 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -455,6 +455,31 @@ static inline int is_io_in_chunk_boundary(struct mddev *mddev,
 	}
 }
 
+bool raid0_is_missing_dev(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+	static int already_missing;
+	int def_disks, work_disks = 0;
+	struct r0conf *conf = mddev->private;
+
+	def_disks = conf->strip_zone[0].nb_dev;
+	rdev_for_each(rdev, mddev)
+		if (rdev->bdev->bd_disk->flags & GENHD_FL_UP)
+			work_disks++;
+
+	if (unlikely(def_disks - work_disks)) {
+		if (!already_missing) {
+			already_missing = 1;
+			pr_warn("md: %s: raid0 array has %d missing/failed members\n",
+				mdname(mddev), (def_disks - work_disks));
+		}
+		return true;
+	}
+
+	already_missing = 0;
+	return false;
+}
+
 static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 {
 	struct r0conf *conf = mddev->private;
@@ -789,6 +814,7 @@ static struct md_personality raid0_personality=
 	.takeover	= raid0_takeover,
 	.quiesce	= raid0_quiesce,
 	.congested	= raid0_congested,
+	.is_missing_dev	= raid0_is_missing_dev,
 };
 
 static int __init raid0_init (void)
-- 
2.22.0

