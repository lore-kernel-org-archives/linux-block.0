Return-Path: <SRS0=AgPR=5H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA8C4332B
	for <linux-block@archiver.kernel.org>; Sun, 22 Mar 2020 06:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0D420753
	for <linux-block@archiver.kernel.org>; Sun, 22 Mar 2020 06:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgCVGEx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Mar 2020 02:04:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:49066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgCVGEx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Mar 2020 02:04:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E57D9AD0B;
        Sun, 22 Mar 2020 06:04:51 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>, Coly Li <colyli@suse.de>
Subject: [PATCH 5/7] bcache: Use scnprintf() for avoiding potential buffer overflow
Date:   Sun, 22 Mar 2020 14:03:03 +0800
Message-Id: <20200322060305.70637-6-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200322060305.70637-1-colyli@suse.de>
References: <20200322060305.70637-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 3470fae4eabc..323276994aab 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -154,7 +154,7 @@ static ssize_t bch_snprint_string_list(char *buf,
 	size_t i;
 
 	for (i = 0; list[i]; i++)
-		out += snprintf(out, buf + size - out,
+		out += scnprintf(out, buf + size - out,
 				i == selected ? "[%s] " : "%s ", list[i]);
 
 	out[-1] = '\n';
-- 
2.25.0

