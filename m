Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931AAC282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B11820870
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfAWHFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:05:24 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.71]:11674 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbfAWHFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 02:05:23 -0500
X-Greylist: delayed 1213 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 02:05:22 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 70D0D24C8CF
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 00:45:08 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mCHcgQS1d2PzOmCHcg13Ez; Wed, 23 Jan 2019 00:45:08 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46068 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmCHZ-002o3x-5R; Wed, 23 Jan 2019 00:45:07 -0600
Date:   Wed, 23 Jan 2019 00:45:01 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] block: Mark expected switch fall-throughs
Message-ID: <20190123064501.GA26147@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmCHZ-002o3x-5R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:46068
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_receiver.c:3093:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_receiver.c:3120:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/block/drbd/drbd_req.c:856:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/drbd/drbd_int.h      | 2 +-
 drivers/block/drbd/drbd_receiver.c | 4 ++--
 drivers/block/drbd/drbd_req.c      | 2 +-
 drivers/block/rsxx/core.c          | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

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
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c7ad88d91a09..74350663443f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3094,7 +3094,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 			rv =  1;
 			break;
 		}
-		/* Else fall through to one of the other strategies... */
+		/* Else fall through - to one of the other strategies... */
 	case ASB_DISCARD_OLDER_PRI:
 		if (self == 0 && peer == 1) {
 			rv = 1;
@@ -3119,7 +3119,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 		}
 		if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
 			break;
-		/* else: fall through */
+		/* else, fall through */
 	case ASB_DISCARD_LEAST_CHG:
 		if	(ch_self < ch_peer)
 			rv = -1;
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
diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 0cf4509d575c..898d522e8338 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -439,6 +439,7 @@ static void card_state_change(struct rsxx_cardinfo *card,
 		 * Fall through so the DMA devices can be attached and
 		 * the user can attempt to pull off their data.
 		 */
+		/* fall through */
 	case CARD_STATE_GOOD:
 		st = rsxx_get_card_size8(card, &card->size8);
 		if (st)
-- 
2.20.1

