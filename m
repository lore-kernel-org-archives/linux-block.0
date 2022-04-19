Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E00DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 06:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348866AbiDSGgA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiDSGf7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 02:35:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819D2611F;
        Mon, 18 Apr 2022 23:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=p+NLQwzImL098ZQLVg3qNIFs+TqTKrzJhpz7yD8KxCE=; b=ycGVL8ui5+jwMoAY7Zi1/uqt1I
        /4G3mLyfmZPO/ncA13nYWZaOdDSW/EK9OBileaz9roqqdAm1Noo5SPPX1m1vX+uAFPB9Ug5bZJjCy
        vrxue4SxJo3vSDrB+9TTsuS9SB1Up+TkLPT7Hv2DYF5kR9t8B8tuPrCZvS5zi7XdUsYTw/H6r52Zu
        +5OWod33+8vKBjGSO3/W1BfDRqI89XgYVlJoCT+J1s08H4jtwKFFTPLsEJGX5bDtg6OWQPwFgkn2d
        FqByKVPN35XkFjZbLWCdjJfx0Cvpi+JxcN/Z5nt5aD4h9sA2ZWLghdMPwN5Zqf8BKJENJkcUQ2klk
        aTAGpngA==;
Received: from [2001:4bb8:191:364b:8ef6:df8:5a60:ae5d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nghQJ-001i13-J7; Tue, 19 Apr 2022 06:33:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: [PATCH 4/4] loop: remove most the top-of-file boilerplate comment from the UAPI header
Date:   Tue, 19 Apr 2022 08:33:03 +0200
Message-Id: <20220419063303.583106-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419063303.583106-1-hch@lst.de>
References: <20220419063303.583106-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just leave the SPDX marker and the copyright notice and remove the
irrelevant rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/loop.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 98e60801195e2..6f63527dd2ed6 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -1,11 +1,6 @@
 /* SPDX-License-Identifier: GPL-1.0+ WITH Linux-syscall-note */
 /*
- * include/linux/loop.h
- *
- * Written by Theodore Ts'o, 3/29/93.
- *
- * Copyright 1993 by Theodore Ts'o.  Redistribution of this file is
- * permitted under the GNU General Public License.
+ * Copyright 1993 by Theodore Ts'o.
  */
 #ifndef _UAPI_LINUX_LOOP_H
 #define _UAPI_LINUX_LOOP_H
-- 
2.30.2

