Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 4/4] Maintainers: Add Information for SED Opal library
Date: Tue, 29 Nov 2016 14:52:02 -0700
Message-Id: <1480456322-27339-5-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, sagi@grimberg.me, hch@infradead.org,
 Rafael.Antognolli@intel.com, axboe@fb.com, linux-block@vger.kernel.org,
 Scott Bauer <scott.bauer@intel.com>, jonathan.derrick@intel.com,
 j.naumann@fu-berlin.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli@intel.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d414840..929eba3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10846,6 +10846,16 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-spear.c
 
+SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
+M:	Scott Bauer <scott.bauer@intel.com>
+M:	Jonathan Derrick <jonathan.derrick@intel.com>
+M:	Rafael Antognolli <rafael.antognolli@intel.com>
+L:	linux-nvme@lists.infradead.org
+S:	Supported
+F:	block/sed*
+F:	include/linux/sed*
+F:	include/uapi/linux/sed*
+
 SECURITY SUBSYSTEM
 M:	James Morris <james.l.morris@oracle.com>
 M:	"Serge E. Hallyn" <serge@hallyn.com>
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
