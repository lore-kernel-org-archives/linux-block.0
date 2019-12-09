Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E006C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 15:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22061207FF
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 15:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfLIPmt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:42:49 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:46853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfLIPmt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 10:42:49 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M5wc7-1igGr43rMB-007VUy; Mon, 09 Dec 2019 16:42:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
        Martin Wilck <mwilck@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] [regression fix] pktcdvd: fix regression on 64-bit architectures
Date:   Mon,  9 Dec 2019 16:42:29 +0100
Message-Id: <20191209154240.2588381-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RnvGgNPsLcNsz/pTedpfw6YyLBidhusuTHMHcevs+DRX4+sYTxj
 dCUyb2XdxJJnqurSCAV+zGC3AKNnaHILQChlfisYAmB3WC2yqI8IP9RNFGHwPZyGi9abBJN
 ZxXUaipSdk8hwNc3DPZBPC25DxxFWIxeee9xAsZ0SG9W7Q7dMZjRvYSsRy+k5ckiF0aRFvK
 PFiIcCo4gdUR1JG4l3yUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OehzC7dtquQ=:uwNy207tG0GYdJT8LqashL
 nRRbljgAQlTGgGQcPrXJgPHYnRdo7vHx+sdNNHgoQsfHEEGyFykOe6vErVb5JYF8nD2SeTAr9
 Wfnh9nuC1jIVeynN+K5ExhFFTZVqKj7pbc/j0AWlWxcCLT4SP809lJsM1QMoypDbRAbx+j6Rh
 tQeyyVgLM0x0Sbc1rGtBqdOSmyDr4fkXG0NY2c372OY9R3LVYhLqiUi1cXH6sADeznpjuIyGz
 6RGOi1u5Nak66iLb7L9S9tX14lLq8o7dEoDbJV9oBfpZicndHgK5WpyqC9IqTwdGOEQhDUVBK
 VoPDVlKZs6CLgm9Ym2BwxWs2xd1kDUEamdlLotqzrGU5qgmc9AUcpsi1pez1ETadM/tn9P2SA
 8IGqoppF0FASHiQ7b+PkONhqUJIaD3GGe2xkLfZd3QRs/Tw9rh7f4hIlmBwA4TkuOXTtOSGdE
 lmZ4Yi4g6aIHpQCGJ+n8cgv3Ve7MRyEciRJVle6g7rCCzg7q8SIrNoViR70wGc1RBIVrvdJIV
 a5/yVbtYUwDEWb1jG8VdPmzgl8oeALxqt93fKvDuq28zmP5MCQ0ppYq38jTdCFKAeDXvIE+IW
 qKi7Jdi0L14l3K5r8HoYaloeYPhTWiN3Dgb+WuDIY2ZXB8bxXNvpp6b289DEm2Xbsjunv1J6E
 WOoefeWULQmJa4gbWR+aoGuPoUkMCL744UM9bsWcCOI3QAHnOPgYVufg1zlcV9XTd1YJzpe6V
 yRS6oFyY8sfHF048Yf/9JQ3YglnErA0CTpVT1BgdFr+k/YANgGa+UTHTRYkwKqUpenUmcgBMu
 VaBHuy4yXhA9bvC8Js8kfTNBINSIdl0ToUyhCG/XWvwKoECeIUfg3rq4rLWVpdZ6WlO28grcE
 h0NG84+uxZGAhAa+7OLQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The support for the compat ioctl did not actually do what it was
supposed to do because of a typo, instead it broke native support for
CDROM_LAST_WRITTEN and CDROM_SEND_PACKET on all architectures with
CONFIG_COMPAT enabled.

Fixes: 1b114b0817cc ("pktcdvd: add compat_ioctl handler")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
Please apply for v5.5, I just noticed the regression while
rebasing some of the patches I created on top.
---
 drivers/block/pktcdvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 48c2eb4bbba2..ab4d3be4b646 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2705,7 +2705,7 @@ static const struct block_device_operations pktcdvd_ops = {
 	.release =		pkt_close,
 	.ioctl =		pkt_ioctl,
 #ifdef CONFIG_COMPAT
-	.ioctl =		pkt_compat_ioctl,
+	.compat_ioctl =		pkt_compat_ioctl,
 #endif
 	.check_events =		pkt_check_events,
 };
-- 
2.20.0

