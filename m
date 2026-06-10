Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D034165B
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110722; cv=none; b=eL5q8kreDFup5Ga9Pxn5sk6+WukulHFeN4LjKFhpni7Pa79aTGhARYDHfOat1xLj2zIuR/entT+Yww0qkhZuXM/Td9NhJ38m6O80rVFjU5Q6oBvR/nB7rCrbCqHQZx5XR+ItjeCm7KNxjzGoQxoxyjKy9QMUMA9xeXBW/X60xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110722; c=relaxed/simple;
	bh=VAVuPDGzYShMG0fXnp/4nNqLuLVZdB6WmFmnlVZC36A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTnS2Zkqk4rezkNbtCpTbd2EIU/C9MSNmfoQyAQj/ewfBzNrsGeI0RbLXjuF4vUOgW1ODU7t2Qd3uV8gM05wwbzp6AWeYQOYdmkxJx4uzr3PPUgnu/VVx1SpokUV1YJjAoZPSGl0kO+dYJjljamnTDs2bml4cSruo/UUQLJ35YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowAA3zwavlylqh8QlAA--.33615S3;
	Thu, 11 Jun 2026 00:58:28 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-block@vger.kernel.org
Cc: kees@kernel.org,
	axboe@kernel.dk,
	objecting@objecting.org,
	akpm@linux-foundation.org,
	phdm@macqel.be,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	zzhan461@ucr.edu,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] block: partitions: bound sysv68 slice table count
Date: Thu, 11 Jun 2026 00:58:13 +0800
Message-ID: <f16321f7378d613d81af13f288de82217fc7d934.1781036698.git.zzhan461@ucr.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1781036698.git.zzhan461@ucr.edu>
References: <cover.1781036698.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowAA3zwavlylqh8QlAA--.33615S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur15Zw4xAw15ArWkAF4fXwb_yoW8uw4UpF
	ZIkr9Fq398GFyakayUZF4xuw4Fkas7Jr4qgrW7Jwn0934xtr4kKFy0vrZxZ3W5tr90kryj
	vF1Y9w18ZF4DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsOCWopHlEJRQAAsN

From: Zhao Zhang <zzhan461@ucr.edu>

sysv68_partition() reads a single sector for the slice table, but it
trusts ios_slccnt from disk and walks that many entries after skipping
the synthetic whole-disk slice. A crafted image can set ios_slccnt
larger than the 64 struct slice records that fit in one sector and
trigger an out-of-bounds read while scanning partitions.

Limit the slice count to the number of records that fit in the sector
returned by read_part_sector(), then drop the whole-disk entry only
when the bounded count is non-zero.

Fixes: 19d0e8ce856a ("partition: add support for sysv68 partitions")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 block/partitions/sysv68.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/partitions/sysv68.c b/block/partitions/sysv68.c
index 470e0f9de7be..5110ed83c541 100644
--- a/block/partitions/sysv68.c
+++ b/block/partitions/sysv68.c
@@ -48,7 +48,8 @@ struct slice {
 
 int sysv68_partition(struct parsed_partitions *state)
 {
-	int i, slices;
+	sector_t slice_sector;
+	unsigned int i, slices;
 	int slot = 1;
 	Sector sect;
 	unsigned char *data;
@@ -65,14 +66,16 @@ int sysv68_partition(struct parsed_partitions *state)
 		return 0;
 	}
 	slices = be16_to_cpu(b->dk_ios.ios_slccnt);
-	i = be32_to_cpu(b->dk_ios.ios_slcblk);
+	slice_sector = be32_to_cpu(b->dk_ios.ios_slcblk);
 	put_dev_sector(sect);
 
-	data = read_part_sector(state, i, &sect);
+	data = read_part_sector(state, slice_sector, &sect);
 	if (!data)
 		return -1;
 
-	slices -= 1; /* last slice is the whole disk */
+	slices = min_t(unsigned int, slices, SECTOR_SIZE / sizeof(*slice));
+	if (slices)
+		slices -= 1; /* last slice is the whole disk */
 	seq_buf_printf(&state->pp_buf, "sysV68: %s(s%u)", state->name, slices);
 	slice = (struct slice *)data;
 	for (i = 0; i < slices; i++, slice++) {
-- 
2.47.3

