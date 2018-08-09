Return-Path: <gustavo@embeddedor.com>
Date: Thu, 9 Aug 2018 10:54:46 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Tim Waugh <tim@cyberelk.net>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] block: paride: pd: mark expected switch fall-throughs
Message-ID: <20180809155446.GA19883@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1056543 ("Missing break in switch")
Addresses-Coverity-ID: 1056544 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/paride/pd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 8961b190..7cf9475 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -426,6 +426,7 @@ static void run_fsm(void)
 				pd_claimed = 1;
 				if (!pi_schedule_claimed(pi_current, run_fsm))
 					return;
+				/* fall through */
 			case 1:
 				pd_claimed = 2;
 				pi_current->proto->connect(pi_current);
@@ -445,6 +446,7 @@ static void run_fsm(void)
 				spin_unlock_irqrestore(&pd_lock, saved_flags);
 				if (stop)
 					return;
+				/* fall through */
 			case Hold:
 				schedule_fsm();
 				return;
-- 
2.7.4
