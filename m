Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005862BCF41;
	Tue, 30 Sep 2025 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214963; cv=none; b=YZj8tSjaDi7Q7+yk0C9TexHXSn+OzvawQcgxajmS4mx3xZS/GmbcuYFaNhLMEMVzB63X4cHQXEdVRnkXXyurLTSl87jnueDIdMtzfiBdGAgFErQsnf6YhhB/IEy1iPODzcmZotD9KD5CM23BaHQu49Aa5DBvLhEeadxeNtZNCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214963; c=relaxed/simple;
	bh=Q3oX87+S5LYZOR/oT6E1uzNT2xUerQH+hR+eqFMB1T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaSNM8e1cs79uJ5+JjaxywLFNVEaOePnkFgjOtvUpB7TuDuEnyOPeXTCp1WagTyz9qggEnHRpRpzMi+swG0BbSGfu5//Lo4UbbjaIEEYdXp6myHQ7hURZ/fqmSXrk4iM7MYJft8uRFHnWEmLlIv2QQs45FBDvl+8EVn37OAnLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAB3w31afdtolgQ2CQ--.35090S2;
	Tue, 30 Sep 2025 14:48:59 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	linux-block@vger.kernel.org,
	axboe@kernel.dk,
	vulab@iscas.ac.cn
Subject: [PATCH 6.12 stable] pktcdvd: Handle bio_split() failure
Date: Tue, 30 Sep 2025 14:48:50 +0800
Message-ID: <20250930064850.1682-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3w31afdtolgQ2CQ--.35090S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4UCr48Gw1xXw1rJw15XFb_yoWDWFg_Wa
	4rXry3WrWkCwsYkw17KFsFvrZF9rn5W34rurn3t3yfGa9rXan7XryYvF93ZryUJrs7WF1U
	A34UZr4rJFnxZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjO6pDUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYBA2jbaP9D8wAAsc

The error return from bio_split() is not checked before
being passed to bio_chain(), leading to a kernel panic
from an invalid pointer dereference.

Add a check with IS_ERR() to handle the allocation failure
and prevent the crash.

This patch fixes a bug in the pktcdvd driver, which was removed
from the mainline kernel but still exists in stable branches.

Fixes: 4b83e99ee7092 ("Revert "pktcdvd: remove driver."")
Cc: stable@vger.kernel.org
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/block/pktcdvd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 65b96c083b3c..c0999c3d167a 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2466,6 +2466,8 @@ static void pkt_submit_bio(struct bio *bio)
 			split = bio_split(bio, last_zone -
 					  bio->bi_iter.bi_sector,
 					  GFP_NOIO, &pkt_bio_set);
+			if (IS_ERR(split))
+				goto end_io;
 			bio_chain(split, bio);
 		} else {
 			split = bio;
-- 
2.25.1

