Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6455C7618B
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8114122CEB
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149215;
	bh=+ji7mFsUFkSIoN123yX2W9OUGZf68/Hsg61RzvHrGZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jgG8hHWK/iZg0T/vr9sflHpuc5SIaFGCrCdZC6U/DKQPndZORRzUyl58m9yx1+cC+
	 IVrcBCfYGRcEaupe5A04hLU7NnE3FfL4uSbK3yvQKdNKiAiP2z2cysvNqLE5DtDUGG
	 /dFb0DKJNfLDG2hTFDUFv9vaAGfvLedoSKZXaaiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfGZNnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388171AbfGZNnV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67DDE22BF5;
        Fri, 26 Jul 2019 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148600;
        bh=+ji7mFsUFkSIoN123yX2W9OUGZf68/Hsg61RzvHrGZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxO83RbQvgLYww6IV3AivStxozIKbdTBkMekw2UDAL1bmzoGLE3noOQ29WyUt1boL
         NRmfUF9BnWkzgwd18w0PlPUbC3NmqodMfxfnaNS89amRR+iu78m9PRCgkLZctT4QHN
         xlKUOCCYeu4KToPb4BLS77lnVpeFRMZARimLEjxU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Efremov <efremov@ispras.ru>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 40/47] floppy: fix out-of-bounds read in copy_buffer
Date:   Fri, 26 Jul 2019 09:42:03 -0400
Message-Id: <20190726134210.12156-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
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
index b1425b218606..0d43e90eb252 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3244,8 +3244,10 @@ static int set_geometry(unsigned int cmd, struct floppy_struct *g,
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

