Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C6C43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 16:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbiFTQMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242469AbiFTQL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366520BCC
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 09:11:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 32B991F8A4;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655741514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7z7sMxKWqNuUnoONWOQLCm36kIZY/iXbJgtfkyS+es=;
        b=p3UMLOXLRC/7fUqNv8Kc+ui6hAEE77KnJUa96TRrJhl06HFZENQ5sBaUBv/UHh3xutr+Wi
        nBiRW6J6Psjt7exgKMjYAAPbVDkv8D9JHTns4ynsHm3HVTSyzuu9omqKBORhDs+AjNrHTn
        Mhi9wEaxOrV0rPZKv8oc+IukWlgz6JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655741514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7z7sMxKWqNuUnoONWOQLCm36kIZY/iXbJgtfkyS+es=;
        b=fVgsDbhc8OajLHsl6qMrJF/XSZq0KwyizokqSucadfHP/eEy3L12sC7G7NfcRMxpaJe+ZB
        JXmEBvRFT0+mJXAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AB5FC2C145;
        Mon, 20 Jun 2022 16:11:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 449EDA0639; Mon, 20 Jun 2022 18:11:53 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/8] block: Make ioprio_best() static
Date:   Mon, 20 Jun 2022 18:11:44 +0200
Message-Id: <20220620161153.11741-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620160726.19798-1-jack@suse.cz>
References: <20220620160726.19798-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; h=from:subject; bh=nzKwe/dsRzaRdBCCbEuxYw4XmmzvyvAPcFHj+sL8ObY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisJxAZ21nzu/gTPHMRUkAH9h8G3ab3BsI9KvWcDKd 9ZVbnNmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrCcQAAKCRCcnaoHP2RA2ZCICA CSMsWE3MW3Z5Cea5uZregJPGHDY1+bQtjEAyazThE2B6z8ERgXKyV3b0YERt4dfoZ8cN8NN8UVtGgo oGlVfIotp0tZb5kQhHcZLpHvo7c5VE0cUGnkB9+3Gmh8ef/P6UjyaqVcEfi/ehP93xLEQ2PcYDMozC 1ScwhLRHFF4zPt8hGu/ooB+ufWCPAwTLG8Y+39/9ki3i8jKEE60U6ZfJkD1KejLj8OOWMIMBGFDxru xXLSAzhQIfNNbE5F1XiMC4Chul0X0J3h5cX3X0EdCEEWG8NoJfP+PubWBCDK/Bzd9h4gWJI7qaooME /J1eEfWQ6n0WPRRzKyCR3QxedJeGJe
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nobody outside of block/ioprio.c uses it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioprio.c         | 2 +-
 include/linux/ioprio.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 2a34cbca18ae..b5cf7339709b 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -154,7 +154,7 @@ static int get_task_ioprio(struct task_struct *p)
 	return ret;
 }
 
-int ioprio_best(unsigned short aprio, unsigned short bprio)
+static int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
 	if (!ioprio_valid(aprio))
 		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 61ed6bb4998e..519d51fc8902 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -66,11 +66,6 @@ static inline int get_current_ioprio(void)
 	return prio;
 }
 
-/*
- * For inheritance, return the highest of the two given priorities
- */
-extern int ioprio_best(unsigned short aprio, unsigned short bprio);
-
 extern int set_task_ioprio(struct task_struct *task, int ioprio);
 
 #ifdef CONFIG_BLOCK
-- 
2.35.3

