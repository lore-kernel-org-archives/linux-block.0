Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65D3DC87A
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848287; cv=none; b=CuGE4X20ttKgao66CSJQ7g0k2/Q6Pju/euHbFVSSaqBY+sbQ9txKVII1rvE00+gm0uqwuZHq72JEoUapfywDBPRJOvt9u+eNRv52/Lqfr0DOO6+dNX/bahc5xkLSTO6b63IhEwdU91nMEbdWtc2Fjft9ajltWRiiGQfJTKnaBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848287; c=relaxed/simple;
	bh=gjkD20a30W3BdUIrpM0P5+ypCIkdEKOWXhz7PqeBvbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RphFDzCuIC3XWhU15KR2vw9Bquc+84UMHsTWke3uGT0ZUUmEnqqU1Q6tCz7elsKx4upR1RCVJ4onyQ9R/ejpcqZLOV2/eK7L/+Xn8qN92UdprPRqGF+xmaBXyEqAtfbH+x4ZN4sM4IISMOOgCb2vMQKyTOG1R0iArhWeJW/wVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 17ea3186900411f1aa26b74ffac11d73-20260804
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:409e89c0-317e-480c-8f55-860c7aaa9fa8,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.12,REQID:409e89c0-317e-480c-8f55-860c7aaa9fa8,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:e7bac3a,CLOUDID:ae8c97d57958c40ca2212b39014dd110,BulkI
	D:260804205752U3O34YN3,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17ea3186900411f1aa26b74ffac11d73-20260804
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1657834874; Tue, 04 Aug 2026 20:57:48 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: tom.leiming@gmail.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH] ublk: avoid teardown retry loop on xarray allocation failure
Date: Tue,  4 Aug 2026 20:57:36 +0800
Message-Id: <20260804125736.2011774-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ublk_shmem_remove_ranges() removes matching maple tree ranges in
batches, but first stores each range into a temporary xarray so that the
pages can be unpinned after dropping the maple tree lock.

That temporary xarray is filled under the maple tree lock with
xa_store(..., GFP_ATOMIC). If the store fails before mas_erase(), the
current range is left in the tree and the helper returns false. The
outer ublk_shmem_remove_ranges() loop then immediately retries the same
range. While the atomic allocation keeps failing, the teardown path has
no forward progress.

The issue can be reproduced with radix_tree_node failslab injection after
a SHMEM_ZC buffer has already been registered:

  # Kernel config:
  #   CONFIG_BLK_DEV_UBLK=y
  #   CONFIG_DEBUG_FS=y
  #   CONFIG_FAULT_INJECTION=y
  #   CONFIG_FAULT_INJECTION_DEBUG_FS=y
  #   CONFIG_FAILSLAB=y

  echo 10 > /proc/sys/vm/nr_hugepages
  mkdir -p /tmp/htlb
  mount -t hugetlbfs none /tmp/htlb
  fallocate -l 4M /tmp/htlb/ublk_buf

  dev_id=$(kublk add -t null --shmem_zc \
		--htlb /tmp/htlb/ublk_buf |
	   awk -F '[ :]' '/dev id/ {print $3}')

  echo 1 > /sys/kernel/slab/radix_tree_node/failslab
  echo Y > /sys/kernel/debug/failslab/cache-filter
  echo Y > /sys/kernel/debug/failslab/ignore-gfp-wait
  echo 1 > /sys/kernel/debug/failslab/interval
  echo -1 > /sys/kernel/debug/failslab/times
  echo 100 > /sys/kernel/debug/failslab/probability

  kublk del -n "$dev_id"

On the unfixed kernel the delete command was still running after 3
seconds. Disabling failslab made it return. The fault-injection stack
showed:

  should_failslab
  kmem_cache_alloc_lru_noprof
  __xas_nomem
  __xa_store
  xa_store
  __ublk_shmem_remove_ranges
  ublk_cdev_rel
  ublk_ctrl_del_dev

Remove the allocation from the teardown loop. Keep the existing batch
limit, but collect {base_pfn, nr_pages} pairs in a fixed-size stack array.
Once a matching range is found, the range is erased from the maple tree
before dropping the lock, so each successful scan makes progress without
depending on any GFP_ATOMIC allocation.

With the same failslab settings, the fixed kernel completed
"kublk del -n $dev_id" successfully in about 45 ms.

Fixes: 309e02dccf64 ("ublk: avoid unpinning pages under maple tree spinlock")
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/block/ublk_drv.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66f10a49509f..00a661146243 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5519,39 +5519,36 @@ static void ublk_unpin_range_pages(unsigned long base_pfn,
 
 /*
  * Inner loop: erase up to UBLK_REMOVE_BATCH matching ranges under
- * mas_lock, collecting them into an xarray. Then drop the lock and
- * unpin pages + free ranges outside spinlock context.
+ * mas_lock, collecting the page ranges in a fixed-size array. Then
+ * drop the lock and unpin pages + free ranges outside spinlock context.
  *
  * Returns true if the tree walk completed, false if more ranges remain.
- * Xarray key is the base PFN, value encodes nr_pages via xa_mk_value().
  */
 #define UBLK_REMOVE_BATCH	64
 
+struct ublk_unpin_range {
+	unsigned long base_pfn;
+	unsigned long nr_pages;
+};
+
 static bool __ublk_shmem_remove_ranges(struct ublk_device *ub,
 					int buf_index, int *ret)
 {
 	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
 	struct ublk_buf_range *range;
-	struct xarray to_unpin;
-	unsigned long idx;
+	struct ublk_unpin_range to_unpin[UBLK_REMOVE_BATCH];
 	unsigned int count = 0;
+	unsigned int i;
 	bool done = false;
-	void *entry;
-
-	xa_init(&to_unpin);
 
 	mas_lock(&mas);
 	mas_for_each(&mas, range, ULONG_MAX) {
-		unsigned long nr;
-
 		if (buf_index >= 0 && range->buf_index != buf_index)
 			continue;
 
 		*ret = 0;
-		nr = mas.last - mas.index + 1;
-		if (xa_err(xa_store(&to_unpin, mas.index,
-				    xa_mk_value(nr), GFP_ATOMIC)))
-			goto unlock;
+		to_unpin[count].base_pfn = mas.index;
+		to_unpin[count].nr_pages = mas.last - mas.index + 1;
 		mas_erase(&mas);
 		kfree(range);
 		if (++count >= UBLK_REMOVE_BATCH)
@@ -5561,9 +5558,9 @@ static bool __ublk_shmem_remove_ranges(struct ublk_device *ub,
 unlock:
 	mas_unlock(&mas);
 
-	xa_for_each(&to_unpin, idx, entry)
-		ublk_unpin_range_pages(idx, xa_to_value(entry));
-	xa_destroy(&to_unpin);
+	for (i = 0; i < count; i++)
+		ublk_unpin_range_pages(to_unpin[i].base_pfn,
+				       to_unpin[i].nr_pages);
 
 	return done;
 }
-- 
2.25.1

