Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52741C7618B
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2300B22CE5
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148835;
	bh=og77Y5EQree6qi0dTIEGGGXF9sFJz3o9fKjp7GNNEd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hVI0pP6LbrrKlTccKCbz87HiBd4O5xPpF1oaohaMTOK1fOv21Og5sBhMvs8uHwxjl
	 5XU/B54cwrzCdtxqD9IIAaMKNOg4Q1yy2NABKsg5Mkxp1XxLMb/suK0gJDEk7qvbYw
	 6gyht7WFwEtszPE1K72VxE5LF/eIlR+VZs2wDpjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfGZNq5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388319AbfGZNqH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 09:46:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870A522CE8;
        Fri, 26 Jul 2019 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148767;
        bh=og77Y5EQree6qi0dTIEGGGXF9sFJz3o9fKjp7GNNEd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jj+D3jNcsHucO4OEaHiJC9xDwUQVPWSQn8yM40bdCbC9wxMgO6d0G499ocYtJZw0a
         ZA8vaT9qckGQNGasCkLcTY28G/KatjhF2P8Zz+i1zUcXn39nNhvyrWSOV1nBoUcWmJ
         9cWgdhF6Rmk1O+J2zkyKIT5Q62ousGTlv4M1ppeo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Efremov <efremov@ispras.ru>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 22/23] floppy: fix out-of-bounds read in copy_buffer
Date:   Fri, 26 Jul 2019 09:45:21 -0400
Message-Id: <20190726134522.13308-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134522.13308-1-sashal@kernel.org>
References: <20190726134522.13308-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Denis Efremov <efremov@ispras.ru>

[ Upstream commit da99466ac243f15fbba65bd261bfc75ffa1532b6 ]

This fixes a global out-of-bounds read access in the copy_buffer
function of the floppy driver.

The FDDEFPRM ioctl allows one to set the geometry of a disk.  The sect
and head fields (unsigned int) of the floppy_drive structure are used to
compute the max_sector (int) in the make_raw_rw_request function.  It is
possible to overflow the max_sector.  Next, max_sector is passed to the
copy_buffer function and used in one of the memcpy calls.

An unprivileged user could trigger the bug if the device is accessible,
but requires a floppy disk to be inserted.

The patch adds the check for the .sect * .head multiplication for not
overflowing in the set_geometry function.

The bug was found by syzkaller.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/floppy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 42ae1d2d8243..7516fed84ae9 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3236,8 +3236,10 @@ static int set_geometry(unsigned int cmd, struct floppy_struct *g,
 	int cnt;
 
 	/* sanity checking for parameters. */
-	if (g->sect <= 0 ||
-	    g->head <= 0 ||
+	if ((int)g->sect <= 0 ||
+	    (int)g->head <= 0 ||
+	    /* check for overflow in max_sector */
+	    (int)(g->sect * g->head) <= 0 ||
 	    /* check for zero in F_SECT_PER_TRACK */
 	    (unsigned char)((g->sect << 2) >> FD_SIZECODE(g)) == 0 ||
 	    g->track <= 0 || g->track > UDP->tracks >> STRETCH(g) ||
-- 
2.20.1

