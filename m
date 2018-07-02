Return-Path: <gustavo@embeddedor.com>
Date: Mon, 2 Jul 2018 12:49:02 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drbd: mark expected switch fall-throughs
Message-ID: <20180702174902.GA18713@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used in this case: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/drbd/drbd_receiver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index be9450f..a36a307 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2790,6 +2790,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		   then we would do something smarter here than reading
 		   the block... */
 		peer_req->flags |= EE_RS_THIN_REQ;
+		/* fall through */
 	case P_RS_DATA_REQUEST:
 		peer_req->w.cb = w_e_end_rsdata_req;
 		fault_type = DRBD_FAULT_RS_RD;
@@ -2968,6 +2969,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 		/* Else fall through to one of the other strategies... */
 		drbd_warn(device, "Discard younger/older primary did not find a decision\n"
 		     "Using discard-least-changes instead\n");
+		/* fall through */
 	case ASB_DISCARD_ZERO_CHG:
 		if (ch_peer == 0 && ch_self == 0) {
 			rv = test_bit(RESOLVE_CONFLICTS, &peer_device->connection->flags)
@@ -2979,6 +2981,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 		}
 		if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
 			break;
+		/* else: fall through */
 	case ASB_DISCARD_LEAST_CHG:
 		if	(ch_self < ch_peer)
 			rv = -1;
-- 
2.7.4
