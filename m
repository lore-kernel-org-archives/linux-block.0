Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C3C2F3DD
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6712820879
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfAUOSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:18:06 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:31960 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfAUNuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:00 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0LDnip8059345;
        Mon, 21 Jan 2019 22:49:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Mon, 21 Jan 2019 22:49:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0LDndWk059229
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 22:49:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3] fs: ratelimit __find_get_block_slow() failure message.
Date:   Mon, 21 Jan 2019 22:49:37 +0900
Message-Id: <1548078577-10353-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When something let __find_get_block_slow() hit all_mapped path, it calls
printk() for 100+ times per a second. But there is no need to print same
message with such high frequency; it is just asking for stall warning, or
at least bloating log files.

  [  399.866302][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
  [  399.873324][T15342] b_state=0x00000029, b_size=512
  [  399.878403][T15342] device loop0 blocksize: 4096
  [  399.883296][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
  [  399.890400][T15342] b_state=0x00000029, b_size=512
  [  399.895595][T15342] device loop0 blocksize: 4096
  [  399.900556][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
  [  399.907471][T15342] b_state=0x00000029, b_size=512
  [  399.912506][T15342] device loop0 blocksize: 4096

This patch reduces frequency to up to once per a second, in addition to
concatenating three lines into one.

  [  399.866302][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8, b_state=0x00000029, b_size=512, device loop0 blocksize: 4096

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 fs/buffer.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 52d024b..48318fb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -200,6 +200,7 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 	struct buffer_head *head;
 	struct page *page;
 	int all_mapped = 1;
+	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
 
 	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
 	page = find_get_page_flags(bd_mapping, index, FGP_ACCESSED);
@@ -227,15 +228,15 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
 	 * file io on the block device and getblk.  It gets dealt with
 	 * elsewhere, don't buffer_error if we had some unmapped buffers
 	 */
-	if (all_mapped) {
-		printk("__find_get_block_slow() failed. "
-			"block=%llu, b_blocknr=%llu\n",
-			(unsigned long long)block,
-			(unsigned long long)bh->b_blocknr);
-		printk("b_state=0x%08lx, b_size=%zu\n",
-			bh->b_state, bh->b_size);
-		printk("device %pg blocksize: %d\n", bdev,
-			1 << bd_inode->i_blkbits);
+	ratelimit_set_flags(&last_warned, RATELIMIT_MSG_ON_RELEASE);
+	if (all_mapped && __ratelimit(&last_warned)) {
+		printk("__find_get_block_slow() failed. block=%llu, "
+		       "b_blocknr=%llu, b_state=0x%08lx, b_size=%zu, "
+		       "device %pg blocksize: %d\n",
+		       (unsigned long long)block,
+		       (unsigned long long)bh->b_blocknr,
+		       bh->b_state, bh->b_size, bdev,
+		       1 << bd_inode->i_blkbits);
 	}
 out_unlock:
 	spin_unlock(&bd_mapping->private_lock);
-- 
1.8.3.1

