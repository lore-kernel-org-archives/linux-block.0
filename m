Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A34C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 07:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7685B20859
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 07:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfAOHj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:39:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:41492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfAOHj6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 02:39:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F3DDAE15;
        Tue, 15 Jan 2019 07:39:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 617FA1E087B; Tue, 15 Jan 2019 08:39:55 +0100 (CET)
Date:   Tue, 15 Jan 2019 08:39:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Josef Bacik <jbacik@fb.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] loop: Add test for changing capacity when filesystem is
 mounted
Message-ID: <20190115073955.GA29524@quack2.suse.cz>
References: <20190114084811.14455-1-jack@suse.cz>
 <20190114084811.14455-4-jack@suse.cz>
 <f3988910-5c64-2ab4-a4e8-8255d72458b1@i-love.sakura.ne.jp>
 <20190114104119.GE13316@quack2.suse.cz>
 <20190114105001.GF13316@quack2.suse.cz>
 <BYAPR04MB45026647498A4B84C5001EA686800@BYAPR04MB4502.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB45026647498A4B84C5001EA686800@BYAPR04MB4502.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 14-01-19 19:10:17, Chaitanya Kulkarni wrote:
> Hi Jan,
> 
> Thanks for the test.
> 
>      1	From 45a003672775cb6dcebc99d7ddfe19a1c9507ac3 Mon Sep 17 00:00:00 2001
>      2	From: Jan Kara <jack@suse.cz>
>      3	Date: Mon, 14 Jan 2019 09:23:42 +0100
>      4	Subject: [PATCH v2] loop: Add test for changing capacity when filesystem is
>      5	 mounted
>      6	
>      7	Add test for changing capacity of a loop device when a filesystem with
>      8	non-default block size is mounted on it. This is a regression test for
>      9	"blockdev: Fix livelocks on loop device".
>     10	
>     11	Signed-off-by: Jan Kara <jack@suse.cz>
>     12	---
>     13	 tests/loop/007     | 38 ++++++++++++++++++++++++++++++++++++++
>     14	 tests/loop/007.out |  2 ++
>     15	 2 files changed, 40 insertions(+)
>     16	 create mode 100755 tests/loop/007
>     17	 create mode 100644 tests/loop/007.out
>     18	
>     19	diff --git a/tests/loop/007 b/tests/loop/007
>     20	new file mode 100755
>     21	index 000000000000..3598aeba4443
>     22	--- /dev/null
>     23	+++ b/tests/loop/007
>     24	@@ -0,0 +1,38 @@
>     25	+#!/bin/bash
>     26	+# SPDX-License-Identifier: GPL-3.0+
>     27	+# Copyright (C) 2019 Jan Kara
>     28	+#
>     29	+# Test loop device capacity change handling with filesystem mounted on top.
>     30	+#
>     31	+# Regression test for patch "blockdev: Fix livelocks on loop device".
>     32	+#
>     33	+
>     34	+. tests/loop/rc
>     35	+
>     36	+DESCRIPTION="update loop device capacity with filesystem"
>     37	+
>     38	+QUICK=1
>     39	+
>     40	+requires() {
>     41	+	_have_program mkfs.ext4
>     42	+}
>     43	+
>     44	+test() {
>     45	+	echo "Running ${TEST_NAME}"
>     46	+
> Can we add loop module load/unload at the start and end of the test case
> ?  or is there any specific reason we are not loading and unloading the
> module in this test ?

Well, no other loop tests do this AFAICT. Normally, loop module gets
auto-loaded when first opening some loop device so manual loading usually
is not needed. Also unloading can easily fail if there are other users of
the loop module independent of the test suite.

So to sum it up, I can add loading / unloading to all loop tests but IMO
the benefit is doubtful.

								Honza

>     47	+	local mount_dir="/mnt/blktests/"
>     48	+
>     49	+	truncate -s 1G "$TMPDIR/img"
>     50	+	mkdir -p "$mount_dir"
>     51	+	local loop_device="$(losetup -P -f --show "$TMPDIR/img")"
>     52	+	mkfs.ext4 -b 1024 "$loop_device" &>/dev/null
>     53	+	mount -t ext4 "$loop_device" "$mount_dir"
>     54	+	losetup -c "$loop_device"
>     55	+	# This hangs if rereading capacity changed block size
>     56	+	ls -l "$mount_dir" >/dev/null
>     57	+	umount "$mount_dir"
>     58	+	losetup -d "$loop_device"
>     59	+	rm -fr "$mount_dir" "$TMPDIR/img"
>     60	+
>     61	+	echo "Test complete"
>     62	+}
>     63	diff --git a/tests/loop/007.out b/tests/loop/007.out
>     64	new file mode 100644
>     65	index 000000000000..32752934d48a
>     66	--- /dev/null
>     67	+++ b/tests/loop/007.out
>     68	@@ -0,0 +1,2 @@
>     69	+Running loop/007
>     70	+Test complete
>     71	-- 
>     72	2.16.4
>     73	
> 
> 
> -ck
> 
> 
> 
> 
> From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org> on behalf of Jan Kara <jack@suse.cz>
> Sent: Monday, January 14, 2019 2:50 AM
> To: Jens Axboe
> Cc: Jan Kara; linux-block@vger.kernel.org; Josef Bacik; Tetsuo Handa
> Subject: Re: [PATCH] loop: Add test for changing capacity when filesystem is mounted
>   
>  
> On Mon 14-01-19 11:41:19, Jan Kara wrote:
> > On Mon 14-01-19 18:44:22, Tetsuo Handa wrote:
> > > Thank you for the patch.
> > > 
> > > On 2019/01/14 17:48, Jan Kara wrote:
> > > > + # This hangs if rereading capacity changed block size
> > > > + l /mnt
> > > 
> > > Is 'l' defined as an alias to 'ls' ? I suggest not depending on such alias,
> > > for at least 'l' is not defined in my environment.
> > 
> > Yeah, my bad. I have it everywhere and my finger memory just typed it into
> > the test :). Of course 'ls -l' is better for the test so I'll fix it up in
> > the next version. Thanks for review.
> 
> The test had a couple more bugs which should be fixed now so attached is a
> new version which I've actually tested inside the blktests framework ;).
> 
>                                                                 Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>     
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
