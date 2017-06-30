Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38514 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbdF3P44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 11:56:56 -0400
Received: by mail-wm0-f48.google.com with SMTP id b184so50445547wme.1
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 08:56:55 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 04/10] lightnvm: pblk: schedule if data is not ready
Date: Fri, 30 Jun 2017 17:56:37 +0200
Message-Id: <1498838203-21539-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
References: <1498838203-21539-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When user threads place data into the write buffer, they reserve space
and do the memory copy out of the lock. As a consequence, when the write
thread starts persisting data, there is a chance that it is not copied
yet. In this case, avoid polling, and schedule before retrying.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-rb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 665a4ccfe7f5..2dda874af890 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -578,8 +578,10 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
 		 */
 try:
 		flags = READ_ONCE(entry->w_ctx.flags);
-		if (!(flags & PBLK_WRITTEN_DATA))
+		if (!(flags & PBLK_WRITTEN_DATA)) {
+			io_schedule();
 			goto try;
+		}
 
 		page = virt_to_page(entry->data);
 		if (!page) {
-- 
2.7.4
