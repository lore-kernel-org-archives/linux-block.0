Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC77C04AA9
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4A82084B
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="FEEmpF/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfEDSif (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35058 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfEDSie (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so3037156ljj.2
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1RXqMd3oM130PbV6/2cqI1sCTRLP7lSwTZjKdujSbk=;
        b=FEEmpF/uTHtOxKNBHDa9xmhPxLUFRXtpFHeLfT8aZS8IA+WE7hA5EQolSTMGYOzZ8i
         KXXsasRzJ30hky/IR69UYrMDyfOAeqgGJYK1f4wfCSYLiQH7fptaqtRQFZdUUxSIxjOh
         SLet2L2RNpVWNDAIk820Q2nAwJCa4yUTZAFu698u1hHVLyRiFEcT1mUNffPngEnNE/4w
         /i+ZmqoeO6zHEeTySUNx+9A/OKTYt0HyMShYo7dfLWS/SQlOqpReKNhYjxHQLVz2gIyR
         ghabmVcWp+0lKgSEBBD6Dvzkd08VkN6jkpLqRtL25SG0NEw+jIOjCaegImJQy1AkL4wp
         x3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1RXqMd3oM130PbV6/2cqI1sCTRLP7lSwTZjKdujSbk=;
        b=rQrHvUJl4sNzbGkwywEqP5lC2XuB8mCmvmjNyXp+PrBbklBZhs+pEG8fVqZAI7uzAU
         e1nTAyyrGI8i0JoW/ZTBTXEowqT1crDtODyn576PghGTlv/uNQCPkcBQ6oZ3sk7bfQDC
         jplwfBZCOxg8Id8gIKeI1i5ORfCeQ/2yeeAAPa3he37qXxHjjJjIqYRcZYOInlAK/9CN
         GEfQtFH3XMh8CbzAd5/T+06FVQWGRg8fz3qAg/p8NMKdB7eJpFHAI/gikOm7HeGTBVIZ
         c0IrYgmD+WHhvD0HaWqfDmyp/BmZOINuSVYEqw9JJAXNHUiAeCPy+sxwc/B6Qopr7OdJ
         msxw==
X-Gm-Message-State: APjAAAXg7IULwYuDUETBVnyduqu8Le+/ejBLJTyFfVxVQi19APawO8h0
        bFntVzyo0hnRNOHV4ckdTN8gig==
X-Google-Smtp-Source: APXvYqzAGtz1e6NHcfOW3QFIjfUSjblMN7qBzMhZVPiuh13K/e16wvS3V99lAsgGVs7f7829hjXZHQ==
X-Received: by 2002:a2e:7308:: with SMTP id o8mr8295216ljc.171.1556995112270;
        Sat, 04 May 2019 11:38:32 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:31 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 06/26] lightnvm: pblk: fix race during put line
Date:   Sat,  4 May 2019 20:37:51 +0200
Message-Id: <20190504183811.18725-7-mb@lightnvm.io>
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

In the pblk_put_line_back function, a race condition with
__pblk_map_invalidate can make a line not part of any lists.

Fix gc_list by resetting it to null fixes the above issue.

Fixes: a4bd217 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-gc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index ea9f392a395e..e23b1923b773 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -64,19 +64,23 @@ static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct list_head *move_list;
 
+	spin_lock(&l_mg->gc_lock);
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
 	line->state = PBLK_LINESTATE_CLOSED;
 	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
 					line->state);
+
+	/* We need to reset gc_group in order to ensure that
+	 * pblk_line_gc_list will return proper move_list
+	 * since right now current line is not on any of the
+	 * gc lists.
+	 */
+	line->gc_group = PBLK_LINEGC_NONE;
 	move_list = pblk_line_gc_list(pblk, line);
 	spin_unlock(&line->lock);
-
-	if (move_list) {
-		spin_lock(&l_mg->gc_lock);
-		list_add_tail(&line->list, move_list);
-		spin_unlock(&l_mg->gc_lock);
-	}
+	list_add_tail(&line->list, move_list);
+	spin_unlock(&l_mg->gc_lock);
 }
 
 static void pblk_gc_line_ws(struct work_struct *work)
-- 
2.19.1

