Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D49192D97
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 02:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782527897; cv=none; b=FJ6wPzK63whyjl0svhjfNF4lhXvYrwflqXIwmsqbszoqto2kVTsYCzUPRSR6PP/ft2tzLRU4b4QQ+e6fFA1QIllG4/BAas4kWp23PHQg6zESWclTtlx7b+qhOPov2b8TviAm1iTxl5Lqi6+ktyzmuUocHSrmsCPB02xP/oeM6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782527897; c=relaxed/simple;
	bh=pT4AazqRdkXg+ynjjZXTFT+0AuMhAu3qIMPI2HUbu1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MOYQdr/IPpBWk2kFnkfnBPictwIXCt/aHpQN7vPHuhycNWv8x+3GKOrlACTClThWiC9qZdCbkkSa7HJpsVhxrxM8KXAoaBAMYSlSwDFG08pF4RWuvnsOnvGCiAWPqPCyxOaI347FyWd+8VpbJquIppUVwxSsuqTlBlIN6eMl39U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kH83nHzv; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kH83nHzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Fq
	1TNAMyDr5ZsvAbHvJVtr3U5qxIlu52ZGLrHt+2XNQ=; b=kH83nHzvreE1Mr91+u
	jDKCcosNCCVQ1EdKwXo9l+esnt8w3JAI3+JnnF50tWBGUT5CNUFlsYPlVZsu8M+k
	5Tex23AxqjveqUlkO+KnqbCNYwk7RNdeuS8o9r+8AM3JRIGXCT483lSR11YlHT8d
	k3dyzRB8+sFryAmYRS6rCGRSc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnN15_Nz9q8zMIGQ--.61470S2;
	Sat, 27 Jun 2026 10:37:52 +0800 (CST)
From: dayou5941@163.com
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	liyouhong <liyouhong@kylinos.cn>
Subject: [PATCH] block: fix error injection static_branch dec imbalance
Date: Sat, 27 Jun 2026 10:37:49 +0800
Message-Id: <20260627023749.1048910-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN15_Nz9q8zMIGQ--.61470S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF17ur47Zw15Ar4xJw1rCrg_yoW8tFWDpF
	ya93s5WrW8JF1rJF4UZa9rZ34jyrZIgFn3tFy3Gw1I9as3AF1vqF1kKrWjgF1DKrZ3Aa1j
	q3WvgrWDGF4UCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um1v-UUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3gBYB2o-N4Bn8wAA33

From: liyouhong <liyouhong@kylinos.cn>

error_inject_add() only increments blk_error_injection_enabled when
adding the first rule to a given disk, but error_inject_removeall()
always decrements the static key.  blk_error_injection_exit() is
invoked from blk_unregister_queue() for every gendisk teardown, including
disks that never configured any injection rules.

Removing an unrelated block device therefore decrements the global
static key without a matching increment, which can silently disable
error injection on disks that still have rules in their
error_injection_list.  Repeated teardown of unconfigured disks can
further trigger a static_key underflow WARN in jump_label.c.

Only decrement the static key when removing a disk that actually had
entries, mirroring the list_empty() guard in error_inject_add().

Fixes: e8dcf2d142bd ("block: add configurable error injection")
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
 block/error-injection.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/error-injection.c b/block/error-injection.c
index d24c90e9a25f..d210bd5fd8fb 100644
--- a/block/error-injection.c
+++ b/block/error-injection.c
@@ -118,15 +118,24 @@ static int error_inject_add(struct gendisk *disk, enum req_op op,
 static void error_inject_removeall(struct gendisk *disk)
 {
 	struct blk_error_inject *inj;
+	bool had_entries;
 
 	mutex_lock(&disk->error_injection_lock);
+	had_entries = !list_empty(&disk->error_injection_list);
 	clear_bit(GD_ERROR_INJECT, &disk->state);
 	while ((inj = list_first_entry_or_null(&disk->error_injection_list,
 			struct blk_error_inject, entry))) {
 		list_del_rcu(&inj->entry);
 		kfree_rcu_mightsleep(inj);
 	}
-	static_branch_dec(&blk_error_injection_enabled);
+	/*
+	 * blk_error_injection_exit() runs for every gendisk teardown, not
+	 * only for disks that configured rules.  Only adjust the global
+	 * static key if this disk ever contributed to it, mirroring the
+	 * list_empty() check in error_inject_add().
+	 */
+	if (had_entries)
+		static_branch_dec(&blk_error_injection_enabled);
 	mutex_unlock(&disk->error_injection_lock);
 }
 
-- 
2.25.1

