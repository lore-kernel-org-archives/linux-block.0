Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754AAC433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E2A61BFA
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhKQEeh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 23:34:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43800 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhKQEeg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 23:34:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 188C5212C9;
        Wed, 17 Nov 2021 04:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637123498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LR7oS0QBuwyr6aqAxtE7ckvRLKf85Sqp8tA5knq0q3M=;
        b=lUg9TRuhaYSI9swGvSpkctbJ/tPKbaJsNjvsrhrksRAY4ZCsL7ubiL+rMTUbE7laumxWxR
        /Uw3NMgtb2qiwj7s5ubvLpXmsB6eODXrJd7SdOpF6jqyII6YpTeF5RegqQ62pPE7uX6pno
        1q9iKwt7nswJjy9Mu1SIA1Ls2WyW8dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637123498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LR7oS0QBuwyr6aqAxtE7ckvRLKf85Sqp8tA5knq0q3M=;
        b=yQ5OcbXpj8m2ePUgpw9LpryUv8x4qtS/tAv9z/I/GgZneC1q5bpKDd8fvNIal+oSmO6D0C
        HI6Faw06STIVhvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A47F13BC3;
        Wed, 17 Nov 2021 04:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f07OLqiFlGGRGAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 04:31:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] FAT: use blkdev_issue_flush() instead of congestion_wait()
Date:   Wed, 17 Nov 2021 15:31:34 +1100
Message-id: <163712349419.13692.2859038330142282757@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


congestion_wait() in this context is just a sleep - block devices do not
in general support congestion signalling any more.

The goal here is to wait for any recently written data to get to
storage.  This can be achieved using blkdev_issue_flush().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/fat/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 13855ba49cd9..c50a52f40e37 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -175,9 +175,9 @@ long fat_generic_ioctl(struct file *filp, unsigned int cm=
d, unsigned long arg)
 static int fat_file_release(struct inode *inode, struct file *filp)
 {
 	if ((filp->f_mode & FMODE_WRITE) &&
-	     MSDOS_SB(inode->i_sb)->options.flush) {
+	    MSDOS_SB(inode->i_sb)->options.flush) {
 		fat_flush_inodes(inode->i_sb, inode, NULL);
-		congestion_wait(BLK_RW_ASYNC, HZ/10);
+		blkdev_issue_flush(inode->i_sb->s_bdev);
 	}
 	return 0;
 }
--=20
2.33.1

