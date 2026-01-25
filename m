Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06161C69D;
	Sun, 25 Jan 2026 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348448; cv=none; b=JN/0m9mDc8fDQA1p15bBHsBxm0By1kVYAUc/zmR2iAJy3BscbmR+5bpeDd7dn83Wi0LbONTd9wrXL2QTFOKAq4hWVPlXtbicjcMcs+0MniQKuHvIn+i4JPH6Z7V81TFjKh6GsKoZukZnsU0FRJFqpmozRX9CBaQUo0reroTKqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348448; c=relaxed/simple;
	bh=0Zf7BEv6p+3dBc3JB9lg4zzC7r1pclLCPpE2kWTS1SU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SuiefG2FlolhHr8RJnVbXXxtohmZd5pL1itpbFdgToWWuznqzJvMLDtdvJAqwSE1l9C2b2d+FAh+poyc5VUtffZ4Wl001n0osrAZY3b4XcnKpKfM6K/SEqAZ/d5bo+rOmxWBzpDCISG+HvAEby2E98tb2+HpYsG0jDrhuWErOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-03 (Coremail) with SMTP id rQCowACHa+JbHXZp9yqsBg--.15253S2;
	Sun, 25 Jan 2026 21:40:43 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: [PATCH] z2ram: fix a memory leak in z2_open()
Date: Sun, 25 Jan 2026 21:40:42 +0800
Message-Id: <20260125134042.2061512-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHa+JbHXZp9yqsBg--.15253S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5N7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAcSE2l1qZuEdAADsX

Add iounmap to release the memory if kmalloc_array()
fails in z2_open().

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/block/z2ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 8c1c7f4211eb..1a38a927b8e0 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -192,6 +192,8 @@ static int z2_open(struct gendisk *disk, blk_mode_t mode)
 			if (z2ram_map == NULL) {
 				printk(KERN_ERR DEVICE_NAME
 				       ": cannot get mem for z2ram_map\n");
+				if (vaddr)
+					iounmap((void *)vaddr);
 				goto err_out;
 			}
 
-- 
2.25.1

