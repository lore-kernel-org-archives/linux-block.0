Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932997AbeGDL7l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Jul 2018 07:59:41 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests] dir-locals: fix indenation with Emacs
Date: Wed,  4 Jul 2018 13:59:38 +0200
Message-Id: <20180704115938.15060-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A recent update of Emacs broke .dir-locals.el's shell indendation
setting.

Also set 'sh-indendation' not just 'sh-basic-offset' for this.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 .dir-locals.el | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.dir-locals.el b/.dir-locals.el
index f64c48202910..46961929fac9 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -1,3 +1,4 @@
 ((sh-mode . ((sh-basic-offset . 8)
+	     (sh-indentation . 8)
 	     (fill-column . 80)
 	     (indent-tabs-mode . t))))
-- 
2.16.4
