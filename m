Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA88DC43444
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F59A206BA
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RbQMq7Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfAIPdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:33:46 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:23882 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732319AbfAIPdq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 10:33:46 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190109153343epoutp01aade55d00b4d12363f962139a34c553c~4N-sa-2Ck2879428794epoutp015;
        Wed,  9 Jan 2019 15:33:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190109153343epoutp01aade55d00b4d12363f962139a34c553c~4N-sa-2Ck2879428794epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547048023;
        bh=k7MfEcBGovQbLgQhfFJFSQ6L27BmOdyxHRZwS8mBT2Q=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=RbQMq7Eho+yDlMbjXrHj73f3Y1zZchGnx8M/gcPkcvbZYUHrROnD6bHsr2WViXbIX
         cRWHzauWpnN7JLTUKgcJivMAI4YLSDghU4pKPhyWzDHlF0uPKUrIl0f1f+tYpZAbYm
         H1KyAZtFpnZg2WvxxzBhbyzSutCTfIB0X+m9fDwQ=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190109153342epcas2p36510eaa713c1b6fb7fb69b95c8c2a0a6~4N-rqqlQQ3045830458epcas2p31;
        Wed,  9 Jan 2019 15:33:42 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.40.04055.654163C5; Thu, 10 Jan 2019 00:33:42 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190109153342epcas2p3208f62a4dd876f8e1765b48f8aec2432~4N-q-kSRM3044430444epcas2p3B;
        Wed,  9 Jan 2019 15:33:42 +0000 (GMT)
X-AuditID: b6c32a45-711ff70000000fd7-51-5c3614567586
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.6D.03627.554163C5; Thu, 10 Jan 2019 00:33:42 +0900 (KST)
Received: from test-PowerEdge-R720.sa.corp.samsungelectronics.net
        ([107.108.221.212]) by mmp1.samsung.com (Oracle Communications Messaging
        Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PL2000VLLVH1220@mmp1.samsung.com>; Thu, 10 Jan 2019 00:33:41 +0900 (KST)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nvme@lists.infradead.org, jack@suse.com, david@fromorbit.com,
        tytso@mit.edu, prakash.v@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 4/4] fs/ext4,jbd2: add support for passing write-hint with
 journal.
Date:   Wed, 09 Jan 2019 21:01:01 +0530
Message-id: <1547047861-7271-5-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCmqW6YiFmMwYPTmhZbjt1jtHi+fDGj
        xdH/b9ks9t7Stpg57w6bxZ69J1ks5i97ym5xZcoiZovWnp/sDpwepxZJeGxeUu/RdOYos0ff
        llWMHuu3XGXx+LxJLoAtissmJTUnsyy1SN8ugSvj/LtzLAU9shW33uxhb2CcJtHFyMkhIWAi
        0dQ/j62LkYtDSGAHo8Tbz90sEM53IGfuH1aYqmW9k6CqdjNK7D99ixXCmc4k0fyxk7GLkYOD
        TUBT4sLkUhBTREBR4vJ7J5ASZoFzjBJLP05kAhkkLBAqMW3fJBYQm0VAVWJp+x52EJtXwEni
        3YdtUMvkJG6e62QGsTkFnCV+9fxkBhkkITCHTeL5ucVsEEUuEtObnzJC2MISr45vYYewpSWe
        rdoIFS+W+HXnKFRzB6PE9YaZLBAJe4mLe/6CXcQswCfRcfgvO8jVEgK8Eh1tQhCmh8TveXEQ
        P05jlDj+opVtAqPkAkaGVYxiqQXFuempxUYFhnrFibnFpXnpesn5uZsYwVGp5bqDccY5n0OM
        AhyMSjy8Cf9MY4RYE8uKK3MPMUpwMCuJ8KrfMYkR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvtI
        em60kEB6YklqdmpqQWoRTJaJg1OqgfHkD6fy3lMc3qrL3+Vf3zDh7QGX9Ze3pz4XqBRknpnq
        c5+xsCrVNW/3noW5RdL+ZoX6tld/F875vSx4FXfbM64Ik8NxV5027iiftCxsPVvNtvPNj56c
        uGeYrf0m866t9vMpszYwC03t3hVh8fwrU3CD9GR57/ybB6SXeKlKGYo/zNqvlpZ5uVeJpTgj
        0VCLuag4EQBfxiZ1xgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsVy+t9jAd0wEbMYg03qFluO3WO0eL58MaPF
        0f9v2Sz23tK2mDnvDpvFnr0nWSzmL3vKbnFlyiJmi9aen+wOnB6nFkl4bF5S79F05iizR9+W
        VYwe67dcZfH4vEkugC2KyyYlNSezLLVI3y6BK+P8u3MsBT2yFbfe7GFvYJwm0cXIySEhYCKx
        rHcSWxcjF4eQwE5GiXV3prFAODOZJPpfTGDuYuTgYBPQlLgwuRTEFBFQlLj83gmkhFngHKPE
        9RsdzCCDhAVCJabtm8QCYrMIqEosbd/DDmLzCjhJvPuwjRVimZzEzXOdYPWcAs4Sv3p+gtlC
        QDUXb11lm8DIs4CRYRWjZGpBcW56brFRgVFearlecWJucWleul5yfu4mRmBobTus1b+D8fGS
        +EOMAhyMSjy8Cf9MY4RYE8uKK3MPMUpwMCuJ8KrfMYkR4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zsuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwMicc/KyfoTrtR392Qw99+33LemdcvngnKpz072f
        3VJLt9f/98L7VO4xhX0XenoD3thuj2c8vyxBYkt4mkKDeEcEw0t9ZSGT60nnpO1s9u9SupF/
        4QUbY3yN98zNWbb8Ey5lcmYZluxmbuRwOMH4RU1PgrOy9+yZNgXrBVMav5vx/7ZviS90UGIp
        zkg01GIuKk4EAIdh2bApAgAA
X-CMS-MailID: 20190109153342epcas2p3208f62a4dd876f8e1765b48f8aec2432
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20190109153342epcas2p3208f62a4dd876f8e1765b48f8aec2432
References: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
        <CGME20190109153342epcas2p3208f62a4dd876f8e1765b48f8aec2432@epcas2p3.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For NAND based SSDs, mixing of data with different life-time reduces
efficiency of internal garbage-collection. During FS operations, series
of journal updates will follow/precede series of data/meta updates, causing
intermixing inside SSD. By passing a write-hint with journal, its write
can be isolated from other data/meta writes, leading to endurance/performance
benefit on SSD.

This patch introduces "j_writehint" member in JBD2 journal, using which
Ext4 specifies write-hint (as SHORT) for journal.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/ext4/super.c      |  2 ++
 fs/jbd2/commit.c     | 11 +++++++----
 fs/jbd2/journal.c    |  3 ++-
 fs/jbd2/revoke.c     |  3 ++-
 include/linux/jbd2.h |  8 ++++++++
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d6c142d..3af4049 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4289,6 +4289,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
 
+	sbi->s_journal->j_writehint = KERN_WRITE_LIFE_SHORT;
+
 	sbi->s_journal->j_commit_callback = ext4_journal_commit_callback;
 
 no_journal:
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 2eb55c3..6da4c28 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -153,10 +153,12 @@ static int journal_submit_commit_record(journal_t *journal,
 
 	if (journal->j_flags & JBD2_BARRIER &&
 	    !jbd2_has_feature_async_commit(journal))
-		ret = submit_bh(REQ_OP_WRITE,
-			REQ_SYNC | REQ_PREFLUSH | REQ_FUA, bh);
+		ret = submit_bh_write_hint(REQ_OP_WRITE,
+			REQ_SYNC | REQ_PREFLUSH | REQ_FUA, bh,
+			journal->j_writehint);
 	else
-		ret = submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
+		ret = submit_bh_write_hint(REQ_OP_WRITE, REQ_SYNC, bh,
+			journal->j_writehint);
 
 	*cbh = bh;
 	return ret;
@@ -711,7 +713,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
-				submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
+				submit_bh_write_hint(REQ_OP_WRITE, REQ_SYNC,
+						bh, journal->j_writehint);
 			}
 			cond_resched();
 			stats.run.rs_blocks_logged += bufs;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 8ef6b6d..804dc2c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1384,7 +1384,8 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
 	jbd2_superblock_csum_set(journal, sb);
 	get_bh(bh);
 	bh->b_end_io = end_buffer_write_sync;
-	ret = submit_bh(REQ_OP_WRITE, write_flags, bh);
+	ret = submit_bh_write_hint(REQ_OP_WRITE, write_flags, bh,
+				journal->j_writehint);
 	wait_on_buffer(bh);
 	if (buffer_write_io_error(bh)) {
 		clear_buffer_write_io_error(bh);
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index a1143e5..376b1d8 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -642,7 +642,8 @@ static void flush_descriptor(journal_t *journal,
 	set_buffer_jwrite(descriptor);
 	BUFFER_TRACE(descriptor, "write");
 	set_buffer_dirty(descriptor);
-	write_dirty_buffer(descriptor, REQ_SYNC);
+	write_dirty_buffer_with_hint(descriptor, REQ_SYNC,
+				journal->j_writehint);
 }
 #endif
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 0f919d5..918f21e 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1139,6 +1139,14 @@ struct journal_s
 	 */
 	__u32 j_csum_seed;
 
+	/**
+	 * @j_writehint:
+	 *
+	 * write-hint for journal (set by FS).
+	 */
+	enum rw_hint	j_writehint;
+
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/**
 	 * @j_trans_commit_map:
-- 
2.7.4

