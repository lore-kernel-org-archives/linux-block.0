Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-block@vger.kernel.org
Subject: [PATCH 3/3] block/sed-opal: Propagate original error message to
 userland.
Date: Wed, 22 Feb 2017 10:15:08 -0700
Message-Id: <1487783708-16285-4-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
References: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, axboe@fb.com,
 jonathan.derrick@intel.com, hch@lst.de, Scott Bauer <scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

During an error on a comannd, ex: user provides wrong pw to unlock
range, we will gracefully terminate the opal session. We want to
propagate the original error to userland instead of the result of
the session termination, which is almost always a success.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 020bf3e..1e18dca 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -396,8 +396,11 @@ static int next(struct opal_dev *dev)
 			 * session. Therefore we shouldn't attempt to terminate
 			 * a session, as one has not yet been created.
 			 */
-			if (state > 1)
-				return end_opal_session_error(dev);
+			if (state > 1) {
+				end_opal_session_error(dev);
+				return error;
+			}
+
 		}
 		state++;
 	} while (!error);
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
