Return-Path: <linux-block-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:33720 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeJ2Awi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Oct 2018 20:52:38 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matias Bjorling <mb@lightnvm.io>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lightnvm: Fix uninitialized return value in nvm_get_chunk_meta()
Date: Sun, 28 Oct 2018 17:07:26 +0100
Message-Id: <20181028160726.24450-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

With gcc 4.1:

    drivers/lightnvm/core.c: In function ‘nvm_get_bb_meta’:
    drivers/lightnvm/core.c:977: warning: ‘ret’ may be used uninitialized in this function

and

    drivers/nvme/host/lightnvm.c: In function ‘nvme_nvm_get_chk_meta’:
    drivers/nvme/host/lightnvm.c:580: warning: ‘ret’ may be used uninitialized in this function

Indeed, if (for the former) the number of channels or LUNs is zero, or
(for both) the passed number of chunks is zero, ret will be returned
uninitialized.

Fix this by preinitializing ret to zero.

Fixes: aff3fb18f957de93 ("lightnvm: move bad block and chunk state logic to core")
Fixes: a294c199455187d1 ("lightnvm: implement get log report chunk helpers")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
I don't know if this can happen in practice, but given this is core
functionality that can be called from other files, or even from other
modules, I think it's better to be safe than sorry.

The latter seems to be a pre-existing issue since v4.17.
I didn't notice it before, due to the dependency of NVM on PCI (my gcc
4.1 targets m68k, i.e. no PCI).
---
 drivers/lightnvm/core.c      | 2 +-
 drivers/nvme/host/lightnvm.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index efb976a863d2295a..73ab3cf2686804ba 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -974,7 +974,7 @@ static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
 	struct ppa_addr ppa;
 	u8 *blks;
 	int ch, lun, nr_blks;
-	int ret;
+	int ret = 0;
 
 	ppa.ppa = slba;
 	ppa = dev_to_generic_addr(dev, ppa);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a4f3b263cd6c60ee..d64805dc8efbaa02 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -577,7 +577,8 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
-	int ret, i, max_len;
+	int i, max_len;
+	int ret = 0;
 
 	/*
 	 * limit requests to maximum 256K to avoid issuing arbitrary large
-- 
2.17.1
