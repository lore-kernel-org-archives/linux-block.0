Return-Path: <SRS0=Dgp+=T4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DB7C04AB6
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 14:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD592075B
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 14:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfE1OYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 10:24:43 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:60152 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfE1OYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 10:24:43 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id HqQS200073XaVaC01qQSAk; Tue, 28 May 2019 16:24:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVd1e-00058G-2v; Tue, 28 May 2019 16:24:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVd1e-00057O-1L; Tue, 28 May 2019 16:24:26 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Igor Konopko <igor.j.konopko@intel.com>,
        David Howells <dhowells@redhat.com>,
        "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/5] lightnvm: Fix uninitialized pointer in nvm_remove_tgt()
Date:   Tue, 28 May 2019 16:24:20 +0200
Message-Id: <20190528142424.19626-2-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528142424.19626-1-geert@linux-m68k.org>
References: <20190528142424.19626-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With gcc 4.1:

    drivers/lightnvm/core.c: In function ‘nvm_remove_tgt’:
    drivers/lightnvm/core.c:510: warning: ‘t’ is used uninitialized in this function

Indeed, if no NVM devices have been registered, t will be an
uninitialized pointer, and may be dereferenced later.  A call to
nvm_remove_tgt() can be triggered from userspace by issuing the
NVM_DEV_REMOVE ioctl on the lightnvm control device.

Fix this by preinitializing t to NULL.

Fixes: 843f2edbdde085b4 ("lightnvm: do not remove instance under global lock")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/lightnvm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 0df7454832efe082..aa017f48eb8c588c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -492,7 +492,7 @@ static void __nvm_remove_target(struct nvm_target *t, bool graceful)
  */
 static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
 {
-	struct nvm_target *t;
+	struct nvm_target *t = NULL;
 	struct nvm_dev *dev;
 
 	down_read(&nvm_lock);
-- 
2.17.1

