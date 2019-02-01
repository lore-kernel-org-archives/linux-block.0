Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A28C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27AF218AF
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="LFvvxXgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfBAUwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:52:34 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:33488 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfBAUvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 15:51:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id C2619AD111;
        Fri,  1 Feb 2019 21:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549054275; i=@fjfi.cvut.cz;
        bh=eT+Kit8BKg1dbviLqQ78ocvrXMLG75wnjnZMb0eWJe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LFvvxXgbQUhDds49GOvl9pUXBGgNF2MNmeRDU9Bbm46pvv/ZhAAmc6apR0aj2XZmP
         zgal8pKaBKFIZlQd/ez8vYZug+LtWaEnLU+k6Q/6ri7C+zE8UNeFFw7c5snNaNi72Y
         R4jTOE29nqNlJEOnRQWFhK2e2oNfWOWeavUP8nxI=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 08RQ81EKix-1; Fri,  1 Feb 2019 21:51:11 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 9024FAD109;
        Fri,  1 Feb 2019 21:50:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 9024FAD109
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 7457B6004E; Fri,  1 Feb 2019 21:50:48 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v4 03/16] block: sed-opal: unify space check in add_token_*
Date:   Fri,  1 Feb 2019 21:50:10 +0100
Message-Id: <1549054223-12220-4-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

All add_token_* functions have a common set of conditions that have to
be checked. Use a common function for those checks in order to avoid
different behaviour as well as code duplication.

Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
---
 block/sed-opal.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 5c123a5b4ab1..980705681806 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -510,15 +510,29 @@ static int opal_discovery0(struct opal_dev *dev, void *data)
 	return opal_discovery0_end(dev);
 }
 
-static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
+static size_t remaining_size(struct opal_dev *cmd)
+{
+	return IO_BUFFER_LENGTH - cmd->pos;
+}
+
+static bool can_add(int *err, struct opal_dev *cmd, size_t len)
 {
 	if (*err)
-		return;
-	if (cmd->pos >= IO_BUFFER_LENGTH - 1) {
-		pr_debug("Error adding u8: end of buffer.\n");
+		return false;
+
+	if (remaining_size(cmd) < len) {
+		pr_debug("Error adding %zu bytes: end of buffer.\n", len);
 		*err = -ERANGE;
-		return;
+		return false;
 	}
+
+	return true;
+}
+
+static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
+{
+	if (!can_add(err, cmd, 1))
+		return;
 	cmd->cmd[cmd->pos++] = tok;
 }
 
@@ -563,9 +577,8 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 	msb = fls64(number);
 	len = DIV_ROUND_UP(msb, 8);
 
-	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
+	if (!can_add(err, cmd, len + 1)) {
 		pr_debug("Error adding u64: end of buffer.\n");
-		*err = -ERANGE;
 		return;
 	}
 	add_short_atom_header(cmd, false, false, len);
@@ -587,9 +600,8 @@ static void add_token_bytestring(int *err, struct opal_dev *cmd,
 		is_short_atom = false;
 	}
 
-	if (len >= IO_BUFFER_LENGTH - cmd->pos - header_len) {
+	if (!can_add(err, cmd, header_len + len)) {
 		pr_debug("Error adding bytestring: end of buffer.\n");
-		*err = -ERANGE;
 		return;
 	}
 
-- 
2.20.1

