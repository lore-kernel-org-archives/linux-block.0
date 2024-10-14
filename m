Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6372C1A4F03;
	Mon, 14 Oct 2024 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903679; cv=none; b=FGpslM2M1DCe35IYaL0Vy7N6ickhpF+40JZrB1Ic+ZOP3uPsyL4+vHW1kqgpkoM+/BjB/dVZdKmO90Jim/ohDHLYQ0YnXZDFB809QYxtL3iAoNE+CswfxHZgb0ybsG6vVVZRhIEka5OZ6I1lnq3Th+p705XHw+K47uDA/rlj/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903679; c=relaxed/simple;
	bh=gGmDIIzyy9IHazPso2R/WKF0iZif8zx/sBJb7QmIGlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b65UB5V6zugMtMjyBtJbIXB+gI/wILq6RORvfof+QD0zt1MTP2YwYGJEIeBp2mfkaJGoCJw3CRdq0v8xcYr8FKp1cw20S+u0W+GohYP3nJZbwsHwiIa56QyIZe/8J2euZ5tL0xKG5IK/3il1TR8Pm6Ie6iZY7lmfR79dzJC0/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 997AD16F8;
	Mon, 14 Oct 2024 04:01:47 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 769A53F51B;
	Mon, 14 Oct 2024 04:01:14 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Kalesh Singh <kaleshsingh@google.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	v9fs@lists.linux.dev,
	virtualization@lists.linux.dev
Subject: [RFC PATCH v1 35/57] virtio: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:42 +0100
Message-ID: <20241014105912.3207374-35-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Updated multiple BUILD_BUG_ON() instances to test against page size
limits.

Wrap global variables that are initialized with PAGE_SIZE derived values
using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
deferred for boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/block/virtio_blk.c      |  2 +-
 drivers/virtio/virtio_balloon.c | 10 ++++++----
 net/9p/trans_virtio.c           |  4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 194417abc1053..8a8960b609bc9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -899,7 +899,7 @@ static ssize_t serial_show(struct device *dev,
 	int err;
 
 	/* sysfs gives us a PAGE_SIZE buffer */
-	BUILD_BUG_ON(PAGE_SIZE < VIRTIO_BLK_ID_BYTES);
+	BUILD_BUG_ON(PAGE_SIZE_MIN < VIRTIO_BLK_ID_BYTES);
 
 	buf[VIRTIO_BLK_ID_BYTES] = '\0';
 	err = virtblk_get_id(disk, buf);
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 54469277ca303..3818d894bd212 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -25,6 +25,7 @@
  * page units.
  */
 #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned int)(PAGE_SIZE >> VIRTIO_BALLOON_PFN_SHIFT)
+#define VIRTIO_BALLOON_PAGES_PER_PAGE_MAX (unsigned int)(PAGE_SIZE_MAX >> VIRTIO_BALLOON_PFN_SHIFT)
 #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
 /* Maximum number of (4k) pages to deflate on OOM notifications. */
 #define VIRTIO_BALLOON_OOM_NR_PAGES 256
@@ -138,7 +139,7 @@ static u32 page_to_balloon_pfn(struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 
-	BUILD_BUG_ON(PAGE_SHIFT < VIRTIO_BALLOON_PFN_SHIFT);
+	BUILD_BUG_ON(PAGE_SHIFT_MIN < VIRTIO_BALLOON_PFN_SHIFT);
 	/* Convert pfn from Linux page size to balloon page size. */
 	return pfn * VIRTIO_BALLOON_PAGES_PER_PAGE;
 }
@@ -228,7 +229,7 @@ static void set_page_pfns(struct virtio_balloon *vb,
 {
 	unsigned int i;
 
-	BUILD_BUG_ON(VIRTIO_BALLOON_PAGES_PER_PAGE > VIRTIO_BALLOON_ARRAY_PFNS_MAX);
+	BUILD_BUG_ON(VIRTIO_BALLOON_PAGES_PER_PAGE_MAX > VIRTIO_BALLOON_ARRAY_PFNS_MAX);
 
 	/*
 	 * Set balloon pfns pointing at this page.
@@ -1042,8 +1043,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		 * host's base page size. However, it needs more work to report
 		 * that value. The hard-coded order would be fine currently.
 		 */
-#if defined(CONFIG_ARM64) && defined(CONFIG_ARM64_64K_PAGES)
-		vb->pr_dev_info.order = 5;
+#if defined(CONFIG_ARM64)
+		if (PAGE_SIZE == SZ_64K)
+			vb->pr_dev_info.order = 5;
 #endif
 
 		err = page_reporting_register(&vb->pr_dev_info);
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 0b8086f58ad55..25b8253011cec 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -786,7 +786,7 @@ static struct virtio_driver p9_virtio_drv = {
 	.remove		= p9_virtio_remove,
 };
 
-static struct p9_trans_module p9_virtio_trans = {
+static DEFINE_GLOBAL_PAGE_SIZE_VAR(struct p9_trans_module, p9_virtio_trans, {
 	.name = "virtio",
 	.create = p9_virtio_create,
 	.close = p9_virtio_close,
@@ -804,7 +804,7 @@ static struct p9_trans_module p9_virtio_trans = {
 	.pooled_rbuffers = false,
 	.def = 1,
 	.owner = THIS_MODULE,
-};
+});
 
 /* The standard init function */
 static int __init p9_virtio_init(void)
-- 
2.43.0

