Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 1/2] uapi: sed-opal fix IOW for activate lsp to use correct
 struct
Date: Thu,  9 Feb 2017 10:20:00 -0700
Message-Id: <1486660801-5105-2-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, arnd@arndb.de, hch@infradead.org,
 linux-kernel@vger.kernel.org, axboe@fb.com, David.Laight@ACULAB.COM,
 linux-block@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>,
 jonathan.derrick@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

the IOW for the IOC_OPAL_ACTIVATE_LSP took the wrong strcure which
would give us the wrong size when using _IOC_SIZE, switch it to the
right structure.

Fixes: 058f8a2 ("Include: Uapi: Add user ABI for Sed/Opal")

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 include/uapi/linux/sed-opal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index fc06e3a..c72e073 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -106,7 +106,7 @@ struct opal_mbr_data {
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
-#define IOC_OPAL_ACTIVATE_LSP       _IOW('p', 223, struct opal_key)
+#define IOC_OPAL_ACTIVATE_LSP       _IOW('p', 223, struct opal_lr_act)
 #define IOC_OPAL_SET_PW             _IOW('p', 224, struct opal_new_pw)
 #define IOC_OPAL_ACTIVATE_USR       _IOW('p', 225, struct opal_session_info)
 #define IOC_OPAL_REVERT_TPR         _IOW('p', 226, struct opal_key)
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
