Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F887C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24693205F4
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="jtk5M/I6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfEDSid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33661 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEDSic (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so7885391ljc.0
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1xp8dy6HUVHg33310d7zWs5VJh87FSyOg/4AbibYuc=;
        b=jtk5M/I65vabxpWzTKSLJu2t7uKIF/8C8YgcM/SNsEa79VuMuGsrGU/mSCXs7gcqKZ
         KQvTuW9x/RkXyVfNCdg3BuNskDCSFW/xcTtHDw3EbDFXJlsWlJXzxoumUvvbDoNq9ols
         g4//QBoN22t3ZDu7jXirHW8+3tiCYwGrbeb0w9C4JdyVXye0Okcx2ZyILdJ37PcbGL0w
         mXYAkr2EqVtaus+6j/e5NhWFpgfJdoyqlY2fymUQX0xIYf9+QZlnBykc++dKC2JyGUa5
         kh1MqBAUvqxnflKAZcpsPB9GgoCLYP4TukexRypB9NDl3YRCA+Gg29SL/M5N4UoidzBE
         6duA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1xp8dy6HUVHg33310d7zWs5VJh87FSyOg/4AbibYuc=;
        b=BZibxAmoRJ8JdEAFYOBrCLck11aGAs5FyQCCT5x7iIf6WbAMFFqz6PhHOuLrd8u7Od
         HKaV9auXb7c+SldnFhG/R5iiOo4SwAXBnD1DGsGzwqy240bTcikxJXjn5ZRWsgjqaLtG
         JGxXlO5zfXFfw0uw+EoC7cJqsoYjq41PlBdiPF3vHQo0AqjlqmfTdqYCD2yCjqaszpw0
         U8qexFULtPuvlNw5N5Gisd0NOz8lWiulG/VB4maoe3WHz2bTXxLmURB2ddgN2VSbOD/b
         4hKehrwHeNteQs8goaRDiSKPoIfnMyHlrJeNSt49ibvWB1Env+idIoAkVLZFOBXaoF5b
         yNJQ==
X-Gm-Message-State: APjAAAWynNpUBCb6F4lqxaM4sb2RL5Ca/Gt19OXSTL+XWT71LvVE1Yg/
        GgzM0tO09KeTBkp9piY5FCVcwA==
X-Google-Smtp-Source: APXvYqx97SRcZ8E0qKrSXc2UTkL7+7bLDMMFHegDSUKfg0LC78M80znZuxGDnN/VbwIkvkWbhKskwQ==
X-Received: by 2002:a2e:9812:: with SMTP id a18mr9281616ljj.146.1556995110524;
        Sat, 04 May 2019 11:38:30 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:30 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 04/26] lightnvm: pblk: remove unused smeta_ssec field
Date:   Sat,  4 May 2019 20:37:49 +0200
Message-Id: <20190504183811.18725-5-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

smeta_ssec field in pblk_line is never used after it was replaced by
the function pblk_line_smeta_start().

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 1 -
 drivers/lightnvm/pblk.h      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index fac32138291f..39280c1e9b5d 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1162,7 +1162,6 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	off = bit * geo->ws_opt;
 	bitmap_set(line->map_bitmap, off, lm->smeta_sec);
 	line->sec_in_line -= lm->smeta_sec;
-	line->smeta_ssec = off;
 	line->cur_sec = off + lm->smeta_sec;
 
 	if (init && pblk_line_smeta_write(pblk, line, off)) {
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 58da72dbef45..381f0746a9cf 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -464,7 +464,6 @@ struct pblk_line {
 	int meta_line;			/* Metadata line id */
 	int meta_distance;		/* Distance between data and metadata */
 
-	u64 smeta_ssec;			/* Sector where smeta starts */
 	u64 emeta_ssec;			/* Sector where emeta starts */
 
 	unsigned int sec_in_line;	/* Number of usable secs in line */
-- 
2.19.1

