Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE34C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 10:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6331020578
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 10:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfANKuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:50:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:44406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbfANKuE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 05:50:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4175EAED7;
        Mon, 14 Jan 2019 10:50:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 53A221E157A; Mon, 14 Jan 2019 11:50:01 +0100 (CET)
Date:   Mon, 14 Jan 2019 11:50:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] loop: Add test for changing capacity when filesystem is
 mounted
Message-ID: <20190114105001.GF13316@quack2.suse.cz>
References: <20190114084811.14455-1-jack@suse.cz>
 <20190114084811.14455-4-jack@suse.cz>
 <f3988910-5c64-2ab4-a4e8-8255d72458b1@i-love.sakura.ne.jp>
 <20190114104119.GE13316@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <20190114104119.GE13316@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 14-01-19 11:41:19, Jan Kara wrote:
> On Mon 14-01-19 18:44:22, Tetsuo Handa wrote:
> > Thank you for the patch.
> > 
> > On 2019/01/14 17:48, Jan Kara wrote:
> > > +	# This hangs if rereading capacity changed block size
> > > +	l /mnt
> > 
> > Is 'l' defined as an alias to 'ls' ? I suggest not depending on such alias,
> > for at least 'l' is not defined in my environment.
> 
> Yeah, my bad. I have it everywhere and my finger memory just typed it into
> the test :). Of course 'ls -l' is better for the test so I'll fix it up in
> the next version. Thanks for review.

The test had a couple more bugs which should be fixed now so attached is a
new version which I've actually tested inside the blktests framework ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--f+W+jCU1fRNres8c
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-loop-Add-test-for-changing-capacity-when-filesystem-.patch"

From 45a003672775cb6dcebc99d7ddfe19a1c9507ac3 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 14 Jan 2019 09:23:42 +0100
Subject: [PATCH v2] loop: Add test for changing capacity when filesystem is
 mounted

Add test for changing capacity of a loop device when a filesystem with
non-default block size is mounted on it. This is a regression test for
"blockdev: Fix livelocks on loop device".

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/loop/007     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/loop/007.out |  2 ++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/loop/007
 create mode 100644 tests/loop/007.out

diff --git a/tests/loop/007 b/tests/loop/007
new file mode 100755
index 000000000000..3598aeba4443
--- /dev/null
+++ b/tests/loop/007
@@ -0,0 +1,38 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Jan Kara
+#
+# Test loop device capacity change handling with filesystem mounted on top.
+#
+# Regression test for patch "blockdev: Fix livelocks on loop device".
+#
+
+. tests/loop/rc
+
+DESCRIPTION="update loop device capacity with filesystem"
+
+QUICK=1
+
+requires() {
+	_have_program mkfs.ext4
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local mount_dir="/mnt/blktests/"
+
+	truncate -s 1G "$TMPDIR/img"
+	mkdir -p "$mount_dir"
+	local loop_device="$(losetup -P -f --show "$TMPDIR/img")"
+	mkfs.ext4 -b 1024 "$loop_device" &>/dev/null
+	mount -t ext4 "$loop_device" "$mount_dir"
+	losetup -c "$loop_device"
+	# This hangs if rereading capacity changed block size
+	ls -l "$mount_dir" >/dev/null
+	umount "$mount_dir"
+	losetup -d "$loop_device"
+	rm -fr "$mount_dir" "$TMPDIR/img"
+
+	echo "Test complete"
+}
diff --git a/tests/loop/007.out b/tests/loop/007.out
new file mode 100644
index 000000000000..32752934d48a
--- /dev/null
+++ b/tests/loop/007.out
@@ -0,0 +1,2 @@
+Running loop/007
+Test complete
-- 
2.16.4


--f+W+jCU1fRNres8c--
