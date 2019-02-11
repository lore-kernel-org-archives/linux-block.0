Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097CC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 18:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD206218A4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 18:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfBKSex (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:34:53 -0500
Received: from gateway30.websitewelcome.com ([192.185.147.85]:41806 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730240AbfBKSex (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 13:34:53 -0500
X-Greylist: delayed 1390 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 13:34:52 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A758239854
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 12:11:41 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tG3RgxT8z2qH7tG3RgVnmE; Mon, 11 Feb 2019 12:11:41 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=41322 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtG3Q-001wjP-RA; Mon, 11 Feb 2019 12:11:41 -0600
Date:   Mon, 11 Feb 2019 12:11:40 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] drbd: Mark expected switch fall-throughs
Message-ID: <20190211181140.GA19355@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gtG3Q-001wjP-RA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:41322
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

In file included from drivers/block/drbd/drbd_actlog.c:30:
drivers/block/drbd/drbd_int.h: In function ‘__drbd_chk_io_error_’:
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (df == DRBD_READ_ERROR || df == DRBD_WRITE_ERROR) {
      ^
drivers/block/drbd/drbd_int.h:1782:2: note: here
  case EP_DETACH:
  ^~~~
drivers/block/drbd/drbd_req.c: In function ‘__req_mod’:
drivers/block/drbd/drbd_req.c:856:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (!(req->rq_state & RQ_NET_OK)) {
      ^
  CC [M]  fs/btrfs/inode-map.o
drivers/block/drbd/drbd_req.c:871:2: note: here
  case BARRIER_ACKED:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that in some cases, the code comment is modified in
accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/drbd/drbd_int.h | 2 +-
 drivers/block/drbd/drbd_req.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 000a2f4c0e92..f070f7200fc0 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1778,7 +1778,7 @@ static inline void __drbd_chk_io_error_(struct drbd_device *device,
 				_drbd_set_state(_NS(device, disk, D_INCONSISTENT), CS_HARD, NULL);
 			break;
 		}
-		/* NOTE fall through for DRBD_META_IO_ERROR or DRBD_FORCE_DETACH */
+		/* fall through - for DRBD_META_IO_ERROR or DRBD_FORCE_DETACH */
 	case EP_DETACH:
 	case EP_CALL_HELPER:
 		/* Remember whether we saw a READ or WRITE error.
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 643a04af213b..3809c7e6be8c 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -866,7 +866,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 			} /* else: FIXME can this happen? */
 			break;
 		}
-		/* else, fall through to BARRIER_ACKED */
+		/* else, fall through - to BARRIER_ACKED */
 
 	case BARRIER_ACKED:
 		/* barrier ack for READ requests does not make sense */
-- 
2.20.1

