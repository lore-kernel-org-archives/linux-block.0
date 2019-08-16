Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22D9C3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B275D2064A
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 13:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfHPNlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:41:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54791 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfHPNlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 09:41:11 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hycTc-0001Kw-K3
        for linux-block@vger.kernel.org; Fri, 16 Aug 2019 13:41:08 +0000
Received: by mail-qt1-f198.google.com with SMTP id h15so5887100qtq.18
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 06:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4N5xU9SyzOFldeE0V1HPJ7KCJ6tN+7YPLGNAaqnzYCw=;
        b=kOpl7eWO6FfDdIfcATYqsD3gxfeagYsEoc3v//VqePxhZ6N04HKHRoRqHGon+P+aKf
         i5lIlRWn5M8OvNLnsOz5LPv2C1aLVagjZhjYrf8Ql2v6IjqvZ4ia+ZqFqZIsT+L5EpgG
         vlNWEBfgMtdBH7zUtZdSVDz2lGUxfSHPDSmm8S0Mfs26U2vitP9GzI5Bl/KkepMHo30C
         Faa5UFUd3MsFM3R0Xnh8U3CUJbM55Xpo5xC58YJXz0/KWfS77ytiKh5SIPseqyUA4slp
         dbcEZTIEbaHxKWcC8NRQ68cesg2CtHTE2A9ucc4sWuyrGeqJCQgMSvefrBH5gpMoEKwJ
         SyCg==
X-Gm-Message-State: APjAAAWZ47VYROmTgn4JmAEe0oKmYrRS+CiQUNSk/U6hbhd0Vg6kp79Z
        NEqbeQir9FQa0+yYRBVhuERo6+5FKfnDjFNfAZLi6BSbgmFXjAHXYEo5s4B3+33/57lslzt2ijG
        wmAXRBI36bPzKhAkCJc+dt5mSxnE454l85/XLtUD/
X-Received: by 2002:ae9:e91a:: with SMTP id x26mr8807455qkf.305.1565962866539;
        Fri, 16 Aug 2019 06:41:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwygp8F7l+JofXM1Fz9C0aXGXFyMZ2WmVpWE1a9KOfVKgvwBjgYBmjCKz5pS9XXRy+Bg7quRQ==
X-Received: by 2002:ae9:e91a:: with SMTP id x26mr8807436qkf.305.1565962866250;
        Fri, 16 Aug 2019 06:41:06 -0700 (PDT)
Received: from localhost ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id u57sm3517952qtk.29.2019.08.16.06.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 06:41:05 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 1/2] md raid0/linear: Introduce new array state 'broken'
Date:   Fri, 16 Aug 2019 10:40:58 -0300
Message-Id: <20190816134059.29751-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently if md raid0/linear array gets one or more members removed while
being mounted, kernel keeps showing state 'clean' in the 'array_state'
sysfs attribute. Despite udev signaling the member device is gone, 'mdadm'
cannot issue the STOP_ARRAY ioctl successfully, given the array is mounted.

Nothing else hints that something is wrong (except that the removed devices
don't show properly in the output of 'mdadm detail' command). There is no
other property to be checked, and if user is not performing reads/writes
to the array, even kernel log is quiet and doesn't give a clue about the
missing member.

This patch changes this behavior; when 'array_state' is read we introduce
a non-expensive check (only for raid0/md-linear) that relies in the
comparison of the total number of disks when array was assembled with
gendisk flags of those devices to validate if all members are available
and functional. A new array state 'broken' was added: it mimics the state
'clean' in every aspect, being useful only to distinguish if such array
has some member missing. Also, we show a rate-limited warning in kernel
log in such case.

This patch has no proper functional change other than adding the
'clean'-like state; it was tested with ext4 and xfs filesystems. It
requires a 'mdadm' counterpart to handle the 'broken' state.

Cc: NeilBrown <neilb@suse.com>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

Cover-letter from v1:
lore.kernel.org/linux-block/20190729203135.12934-1-gpiccoli@canonical.com

v1 -> v2:
* Added handling for md/linear 'broken' state;
* Check for is_missing_dev() instead of personality (thanks Neil for
the suggestion);
* Changed is_missing_dev() handlers to static;
* Print rate-limited warning in case of more members go away, not only
the first.

Song, after thinking and experimenting a bit more, I don't think it
makes sense to allow setting the 'broken' state, unless we refactor
and "re-purpose" this state. What 'broken' really means is a 'clean'
state but with 1+ members missing - setting it is the same as set
'clean', so it'd be counter-intuitive to set 'broken' but having in
fact set 'clean' merely with the name 'broken'.

The purpose of 'broken' is really to only indicate a missing member,
as noticed by kernel in array_state reads.
If you really think we should use 'broken' for other purposes and hence
users should be allowed to set it, let's discuss and rewrite it.
Personally I think the less we change, the better. We just need
some way to warn users about the missing members of their arrays.
Thanks,

Guilherme


 drivers/md/md-linear.c | 25 +++++++++++++++++++++++++
 drivers/md/md.c        | 22 ++++++++++++++++++----
 drivers/md/md.h        |  2 ++
 drivers/md/raid0.c     | 26 ++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index ed2297541414..a404f700e3f8 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -237,6 +237,30 @@ static void linear_free(struct mddev *mddev, void *priv)
 	kfree(conf);
 }
 
+static bool linear_is_missing_dev(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+	static int already_missing;
+	int def_disks, work_disks = 0;
+
+	def_disks = mddev->raid_disks;
+	rdev_for_each(rdev, mddev)
+		if (rdev->bdev->bd_disk->flags & GENHD_FL_UP)
+			work_disks++;
+
+	if (unlikely(def_disks - work_disks)) {
+		if (already_missing < (def_disks - work_disks)) {
+			already_missing = def_disks - work_disks;
+			pr_warn("md: %s: linear array has %d missing/failed members\n",
+				mdname(mddev), already_missing);
+		}
+		return true;
+	}
+
+	already_missing = 0;
+	return false;
+}
+
 static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 {
 	char b[BDEVNAME_SIZE];
@@ -325,6 +349,7 @@ static struct md_personality linear_personality =
 	.size		= linear_size,
 	.quiesce	= linear_quiesce,
 	.congested	= linear_congested,
+	.is_missing_dev	= linear_is_missing_dev,
 };
 
 static int __init linear_init (void)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ba4de55eea13..0ef93d21cab6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4160,12 +4160,17 @@ __ATTR_PREALLOC(resync_start, S_IRUGO|S_IWUSR,
  * active-idle
  *     like active, but no writes have been seen for a while (100msec).
  *
+ * broken
+ *     RAID0/LINEAR-only: same as clean, but array is missing a member.
+ *     It's useful because RAID0/LINEAR mounted-arrays aren't stopped
+ *     when a member is gone, so this state will at least alert the
+ *     user that something is wrong.
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
@@ -4181,7 +4186,7 @@ array_state_show(struct mddev *mddev, char *page)
 {
 	enum array_state st = inactive;
 
-	if (mddev->pers)
+	if (mddev->pers) {
 		switch(mddev->ro) {
 		case 1:
 			st = readonly;
@@ -4201,7 +4206,15 @@ array_state_show(struct mddev *mddev, char *page)
 				st = active;
 			spin_unlock(&mddev->lock);
 		}
-	else {
+
+		if ((mddev->pers->is_missing_dev) &&
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
@@ -4315,6 +4328,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		break;
 	case write_pending:
 	case active_idle:
+	case broken:
 		/* these cannot be set */
 		break;
 	}
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 5d7c1cad4946..2b40990c7642 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -590,6 +590,8 @@ struct md_personality
 	int (*congested)(struct mddev *mddev, int bits);
 	/* Changes the consistency policy of an active array. */
 	int (*change_consistency_policy)(struct mddev *mddev, const char *buf);
+	/* Check if there are any missing/failed members - RAID0/LINEAR only. */
+	bool (*is_missing_dev)(struct mddev *mddev);
 };
 
 struct md_sysfs_entry {
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index ef896ee7198b..f7144be96029 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -455,6 +455,31 @@ static inline int is_io_in_chunk_boundary(struct mddev *mddev,
 	}
 }
 
+static bool raid0_is_missing_dev(struct mddev *mddev)
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
+		if (already_missing < (def_disks - work_disks)) {
+			already_missing = def_disks - work_disks;
+			pr_warn("md: %s: raid0 array has %d missing/failed members\n",
+				mdname(mddev), already_missing);
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
@@ -788,6 +813,7 @@ static struct md_personality raid0_personality=
 	.takeover	= raid0_takeover,
 	.quiesce	= raid0_quiesce,
 	.congested	= raid0_congested,
+	.is_missing_dev	= raid0_is_missing_dev,
 };
 
 static int __init raid0_init (void)
-- 
2.22.0

