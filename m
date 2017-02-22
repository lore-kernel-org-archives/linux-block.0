Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-block@vger.kernel.org
Subject: Final opal patches for rc1
Date: Wed, 22 Feb 2017 10:15:05 -0700
Message-Id: <1487783708-16285-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, keith.busch@intel.com, linux-nvme@lists.infradead.org,
 hch@lst.de, jonathan.derrick@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

These are the final changes for rc1.

Patch 1 contains some code to clean up an opal structure if something changes
at runtime. (already reviewed by Christoph)

Patch 2 contains changes to the nvme driver to use the above patch. If a new
FW is loaded and we no longer support opal we clean up. This patch is based off
code from Keith and Christoph.

Patch 3 is a one line change to propagate an original error messaage to user
land instead of the return status of the session termination code.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
