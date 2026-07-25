Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404F370AFC
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946841; cv=none; b=Va1hu/LE4tegu/ju4swH+C+v1uf0xII2sK5tDxPcEM05YMM3Aot2CpiTeWR2xYsg1ox1RlbjKfjRFenUtntRZo0ltkBTs1FZ4nP0cZPhi7XHlke35pZz57FPJYCI9TL+kVVe4wYXzwGwq6g+3O1QO2SJrT/gMH5Bp/xi512BW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946841; c=relaxed/simple;
	bh=wAN8X6yhzhh8xIKRIXyntpv/tc89ZOLz8xL1tqy3G28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHpv+d52QC6zz3Yy1KNe7lL5XS/Wwz0J2YlQLlP91Y0no3tLTowRpWsyk9jUDxOaOeXT+fX0R0HUjnSwGMZv7Iv6DQp/lLnEiaQIdMuVwValQ3KR3BcoNYxWQOAjfY4fH0apqZqkeBYA2wzCPzTmRSmrqJH6Cm/n9ADCC25DNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6TS24ybPzYQtwH
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2811C40838
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHSSIGRqCkPTCQ--.40042S8;
	Sat, 25 Jul 2026 10:33:55 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	yukuai@fygo.io,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V6 04/10] null_blk: free global tag_set on init error path
Date: Sat, 25 Jul 2026 10:25:03 +0800
Message-ID: <20260725022509.714271-5-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260725022509.714271-1-wozizhi@huaweicloud.com>
References: <20260725022509.714271-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHSSIGRqCkPTCQ--.40042S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4UGFyUWw1xAFy7Cry7trb_yoW8Jw4rpF
	4UW3WUKry0kF17uFWjy3W2kFyrWan7JryUKrWak34F9r45Ar9Ikrn7tas8XF1UX393JFZa
	vFnrZFyrXayUGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

If shared_tags is enabled, null_setup_tagset() allocates the global tag_set
via null_init_global_tag_set(). If device creation later fails, err_dev
destroys the default devices and calls unregister_blkdev(), but never frees
the global tag_set. Since module init failed, null_exit() is never invoked,
so the global tag_set's tags and maps are permanently leaked.

Free the global tag_set in err_dev, matching null_exit() which does
if (tag_set.ops) blk_mq_free_tag_set(&tag_set).

Fixes: 82f402fefa50 ("null_blk: add support for shared tags")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/block/null_blk/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6cb213779cc5..df85189f0b69 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2185,6 +2185,8 @@ static int __init null_init(void)
 		null_destroy_dev(nullb);
 	}
 	unregister_blkdev(null_major, "nullb");
+	if (tag_set.ops)
+		blk_mq_free_tag_set(&tag_set);
 	return ret;
 }
 
-- 
2.52.0

