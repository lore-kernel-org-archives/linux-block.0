Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64BCC7618B
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 13:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF0622CE8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148915;
	bh=6H3V95Rkj95ytRF6BwwNX/yuyl+ZuXbdxk8+F232DmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bqwjHxAzK5IZBMTqZsbKBQ6r9cGFKGpz4BbtNiYgJxQ6dlOjtEBDocr+3zPnvECip
	 nmd9v38i8b4CK7VMJ0fVmSYEMkOKo+zLWceh1mXN3cAGYkn8ZGwovt0itwAs1dMExi
	 cW77Tk38l7Kln1KlN9QRaXlxYmwHVJrUe7K+sfH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbfGZNsb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387530AbfGZNpQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 09:45:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC9122CC2;
        Fri, 26 Jul 2019 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148715;
        bh=6H3V95Rkj95ytRF6BwwNX/yuyl+ZuXbdxk8+F232DmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UpGM8bGoLlPWD1b+1oPXRhPB3aUJlc3Vba/3Fa/U0cpV+o5y8EGG7Gneazy6mxScl
         uDuBsnwVtxBoaKS57aCw1M0Fg4IeAWMtbBXaIG09p7d+06D5L/UYwD7sGL3ZYUWoyt
         bk9/LInYYZWvMHgXRmrtL6DjS/oAjODeuV/q7Mfg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Efremov <efremov@ispras.ru>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 26/30] floppy: fix div-by-zero in setup_format_params
Date:   Fri, 26 Jul 2019 09:44:28 -0400
Message-Id: <20190726134432.12993-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134432.12993-1-sashal@kernel.org>
References: <20190726134432.12993-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Denis Efremov <efremov@ispras.ru>

[ Upstream commit f3554aeb991214cbfafd17d55e2bfddb50282e32 ]

This fixes a divide by zero error in the setup_format_params function of
the floppy driver.

Two consecutive ioctls can trigger the bug: The first one should set the
drive geometry with such .sect and .rate values for the F_SECT_PER_TRACK
to become zero.  Next, the floppy format operation should be called.

A floppy disk is not required to be inserted.  An unprivileged user
could trigger the bug if the device is accessible.

The patch checks F_SECT_PER_TRACK for a non-zero value in the
set_geometry function.  The proper check should involve a reasonable
upper limit for the .sect and .rate fields, but it could change the
UAPI.

The patch also checks F_SECT_PER_TRACK in the setup_format_params, and
cancels the formatting operation in case of zero.

The bug was found by syzkaller.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/floppy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 6914c6e1e1a8..bb9b50d1d828 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2113,6 +2113,9 @@ static void setup_format_params(int track)
 	raw_cmd->kernel_data = floppy_track_buffer;
 	raw_cmd->length = 4 * F_SECT_PER_TRACK;
 
+	if (!F_SECT_PER_TRACK)
+		return;
+
 	/* allow for about 30ms for data transport per track */
 	head_shift = (F_SECT_PER_TRACK + 5) / 6;
 
@@ -3235,6 +3238,8 @@ static int set_geometry(unsigned int cmd, struct floppy_struct *g,
 	/* sanity checking for parameters. */
 	if (g->sect <= 0 ||
 	    g->head <= 0 ||
+	    /* check for zero in F_SECT_PER_TRACK */
+	    (unsigned char)((g->sect << 2) >> FD_SIZECODE(g)) == 0 ||
 	    g->track <= 0 || g->track > UDP->tracks >> STRETCH(g) ||
 	    /* check if reserved bits are set */
 	    (g->stretch & ~(FD_STRETCH | FD_SWAPSIDES | FD_SECTBASEMASK)) != 0)
-- 
2.20.1

