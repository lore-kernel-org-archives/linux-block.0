Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034499;
	b=HRwcKdLGupl/YkCbQ2DULNkNRkKMFKvP6hBcL1aSthBFtrI6jLTdIGRNCkOWYDXOGckB
	 /oS5PKwnAkul0uQbuETuvOUtj6iLBq5YBIa3G76jQ62bDYPF/5dV6Co2/Q8vXxGsyUhHo
	 xUx1wPf/DP87pMf7Vaokwm7EOuR/3azFPOWYrAq1jyguouaCojVt/V9TfZR7GqsXECu4w
	 uN6U/eQlvT9yHTWvK6Y7nfLWPPvSXVGcO6LM3onTq98cZlA/4ViTRY890oh9n50z8oA0W
	 n5uNnkbtmqvOPrHMJoIP0NYr33AWx0CeVt34Ej2YxjrblIivAbAasAwmcJ42xcr9r7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034499;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=m4mmos7+sKcZJq+QzeTverze++CcBHiAuMrLuy1YFug=;
	b=0p83CA8AtaD1QCN0xvB6STD2gRz/eVNhgdBTPDuiN4F4dWbpfUduCYoFRJIYnO0mbv3O
	 3uZMM8iQHjo9+3/i8VEXj4XKmGeb61EsbZnDaxtcTI4XeVqilh18gj4sYsfLj5PwBa8Hu
	 FLgqgcytVqkr0xAjoIqhKj5wkSyFQbTSzmTu+DM5PyM1yMBcHrD+2OSe9I/5axbEUa8L3
	 1H7sDSibRnkTBv5awLFVUxerBocDuRuV4MSwvyziS8dyhdgBpfB5l+dlELwIHNSf1J/J0
	 96c6uxgwYDz3O+8ThQWAozpcgSIfnGyQsq+SfgmrYE9taad1J4axXJEr3If3GCMJeLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=huawei.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F585606A326
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 06:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F585606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jM6Gf37TGz20MG
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 92D8440573
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 14:54:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgAHwgQ1y+5qHB5yDQ--.31669S9;
	Sat, 07 Nov 2026 14:54:49 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: axboe@kernel.dk,
	josef@toxicpanda.com,
	xiubli@redhat.com,
	prasanna.kalever@redhat.com,
	ming.lei@redhat.com,
	yukuai@fygo.io,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	yangerkun@huawei.com,
	wangkefeng.wang@huawei.com,
	leijitang@huawei.com,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	houtao1@huawei.com,
	wozizhi@huawei.com
Subject: [RFC PATCH 5/5] nbd: allow genetlink operations to run in parallel
Date: Sat,  7 Nov 2026 14:46:29 +0800
Message-ID: <20261107064629.4093489-6-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261107064629.4093489-1-yangerkun@huawei.com>
References: <20261107064629.4093489-1-yangerkun@huawei.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHwgQ1y+5qHB5yDQ--.31669S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1DGF48uw47Zw1ktFWrKrg_yoW8Gw4xpF
	WUXFZ7KFy8GF4rua1vya1xWFWYqwnrAFy2qa4qk34Y9ry5Ar9FqrWkKay8tw1qyr97AF12
	vF4jqayIya4kC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFwIDUUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Each nbd doit only touches one device's state, and the global state
(nbd_index_idr and nbd_total_devices) is accessed briefly under
nbd_index_mutex.  genl_mutex nevertheless serializes the whole genetlink
doit path.

The cost that matters is teardown: nbd_disconnect_and_put() calls
flush_workqueue() while holding genl_mutex, so a disconnect blocks every
other device for the duration of the flush.  Enable parallel_ops; the
preceding patches make sure no handler relies on genl_mutex for
correctness.

Test with a minimal netlink client in an 8-vCPU KVM guest, 32 devices x
10 connect/disconnect cycles, median of 3 runs:

  parallel_ops=0:  378 ms
  parallel_ops=1:   27 ms

Connect-only and status do not improve, since their critical sections
are short.

Suggested-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Assisted-by: LLM
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index cf2a47fc572d..6a7060773e27 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2542,6 +2542,7 @@ static struct genl_family nbd_genl_family __ro_after_init = {
 	.hdrsize	= 0,
 	.name		= NBD_GENL_FAMILY_NAME,
 	.version	= NBD_GENL_VERSION,
+	.parallel_ops	= 1,
 	.module		= THIS_MODULE,
 	.small_ops	= nbd_connect_genl_ops,
 	.n_small_ops	= ARRAY_SIZE(nbd_connect_genl_ops),
-- 
2.52.0

