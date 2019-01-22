Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A35C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 22:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967A920866
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 22:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="oCrTX03q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfAVWcm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:32:42 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45674 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfAVWcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 17:32:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 42306B068B;
        Tue, 22 Jan 2019 23:32:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1548196359; i=@fjfi.cvut.cz;
        bh=ZBmwnOhDmz9YcY0uWH2azZtVoLnnGl0xukx0I3jebQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oCrTX03qyUYUBA53U27NCST1et3aFbcLJIQ8Y4DcwSSdXG7Lx/I+7dKnt9gr4d38V
         zT//kfAnug3RP7jgkcjh2vcY2UcquSv0u8toH1kdW6QAq+DJPS65iFOtSpz3z59nXD
         zoO8LeM0P5a7WDFq8HK6Avrqt042pKUb8tJMNY5Y=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id L05FoJWogzVM; Tue, 22 Jan 2019 23:32:34 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 68260B0673;
        Tue, 22 Jan 2019 23:32:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 68260B0673
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id DF7066004F; Tue, 22 Jan 2019 23:32:31 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH v3 09/16] block: sed-opal: split generation of bytestring header and content
Date:   Tue, 22 Jan 2019 23:31:40 +0100
Message-Id: <1548196307-12987-10-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548196307-12987-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1548196307-12987-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Split the header generation from the (normal) memcpy part if a
bytestring is copied into the command buffer. This allows in-place
generation of the bytestring content. For example, copy_from_user may be
used without an intermediate buffer.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 4225f23b2165..4b0a63b9d7c9 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -586,14 +586,11 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 		add_token_u8(err, cmd, number >> (len * 8));
 }
 
-static void add_token_bytestring(int *err, struct opal_dev *cmd,
-				 const u8 *bytestring, size_t len)
+static u8 *add_bytestring_header(int *err, struct opal_dev *cmd, size_t len)
 {
 	size_t header_len = 1;
 	bool is_short_atom = true;
-
-	if (*err)
-		return;
+	char *start;
 
 	if (len & ~SHORT_ATOM_LEN_MASK) {
 		header_len = 2;
@@ -602,17 +599,27 @@ static void add_token_bytestring(int *err, struct opal_dev *cmd,
 
 	if (!can_add(err, cmd, header_len + len)) {
 		pr_debug("Error adding bytestring: end of buffer.\n");
-		return;
+		return NULL;
 	}
 
 	if (is_short_atom)
 		add_short_atom_header(cmd, true, false, len);
 	else
 		add_medium_atom_header(cmd, true, false, len);
+	start = &cmd->cmd[cmd->pos];
+	return start;
+}
 
-	memcpy(&cmd->cmd[cmd->pos], bytestring, len);
-	cmd->pos += len;
+static void add_token_bytestring(int *err, struct opal_dev *cmd,
+				 const u8 *bytestring, size_t len)
+{
+	u8 *start;
 
+	start = add_bytestring_header(err, cmd, len);
+	if (!start)
+		return;
+	memcpy(start, bytestring, len);
+	cmd->pos += len;
 }
 
 static int build_locking_range(u8 *buffer, size_t length, u8 lr)
-- 
2.20.1

