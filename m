Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70B23EA83
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651327; cv=none; b=nbAcv1ZKSw0Ee0INHUcKS41wDmTJQG8LBH9PFS/S8L5rOEI1Ny8sz8hJFdWBy3ttIIm8jGE4g3mIGJ9efeZy/F5GPaNIMZ24lSUVnPtfnaNjCgocrJFXTEp0c+GDmB3fXSwq5E6vGbN9ETrfk/SEhN8sPPohK0Ujx2ttlcEBVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651327; c=relaxed/simple;
	bh=KLoHVHOo4Q1dYGlCScIGe06D7/zZj9Ifi4eYJkxW1Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOZOrIkbouSLXSmIOCzAlgwbULK+nIcnI+06V83XZApPPC/ymz+1T/OT1B7A/CSfw4R8D53dpc3wvkPktxSvcjyAayKrmFLSeDAI5KKrPFKe5BAeYPy3uIF2BxLSm+l2vs0zEtBb42wIwz3Us+OA2sTadC37NM6R39Chc1vMHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fZ86p3WGqzKHMjj
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:54:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DA52B40574
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:55:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgA3Otp6xbdpKYBhBA--.38497S6;
	Mon, 16 Mar 2026 16:55:22 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	yukuai@fnnas.com,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH 2/2] blk-throttle: fix timer scheduled on wrong service_queue in tg_flush_bios
Date: Mon, 16 Mar 2026 16:44:55 +0800
Message-Id: <20260316084455.3323966-3-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
References: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3Otp6xbdpKYBhBA--.38497S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw4rCF13Zw18Ar1xuFyfZwb_yoW8Jr1fpF
	W3J3W7CF4ktryYkF4Ygwn3WFWYva17XrWjvws8Ga13AFy7XFn7KryDCr1rZFW8Zan3ArWa
	vFs5t3y5ZF1DG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r
	1DMxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUjOtxDUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

tg_flush_bios() calls tg_update_disptime() which inserts the tg into
the parent_sq's pending_tree, but then schedules the pending timer on
the tg's own sq. For leaf tg's with no children, the timer fires on an
empty pending_tree and does nothing, leaving the bio stranded until the
parent_sq's timer happens to fire naturally.

This is masked in blk_throtl_cancel_bios() which walks all levels in
post-order, but affects throtl_pd_offline() where a single leaf cgroup
goes offline.

Fix by scheduling the timer on the parent_sq where the tg was actually
enqueued.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b82da0dfa8e8..93e9e0e352f0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1646,7 +1646,7 @@ static void tg_flush_bios(struct throtl_grp *tg)
 	 */
 	tg_update_disptime(tg);
 
-	throtl_schedule_pending_timer(sq, jiffies + 1);
+	throtl_schedule_pending_timer(sq->parent_sq, jiffies + 1);
 }
 
 static void throtl_pd_offline(struct blkg_policy_data *pd)
-- 
2.39.2

