Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5763148C2;
	Tue, 26 May 2026 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790917; cv=none; b=duvYliDw5bCZ0AzVkypx8RTLUwTJaiOvT4Zr18ggFUbdi7p8/4WSHncEGGneJrvou/H0lbpDVtBGgX2lu0Wp0YmuQBADtmoSP+zh5dxESeBosLFh7EMW+It3Bp23YY8negcBf1IYU0/DN9MN6XfO4dCsewsuM1H0lz1n7GNVdv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790917; c=relaxed/simple;
	bh=ybYrIRR85J9BXUQl4JzK/S4jab12sMaPx+vpv4wJt7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPIC2juBF1Tkg4McK/UUHqVh0ef9o3g+fgRR/vQLix26/p4wfXlKeU/LRmxOFOhjzqHhwj8oPV+HKTVjXO2I5HfibxRQ3AoxAlK11CB9Bh/78qH/HC5FqOQKwwVj57IeGgdMi/zp/QgeJHRrZp9OIVcHs5ignS1n3KuibI5DWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnC+I4dBVqIqVsEg--.1580S2;
	Tue, 26 May 2026 18:21:44 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Cc: Josh Law <objecting@objecting.org>,
	Kees Cook <kees@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] block: partitions: fix of_node refcount leak in of_partition()
Date: Tue, 26 May 2026 10:21:24 +0000
Message-Id: <20260526102124.2283846-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnC+I4dBVqIqVsEg--.1580S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kWr18KF4DGFy3uF1DGFg_yoW8XFWUpr
	sxC3y5Ar1UGry3C34ktF4xZw1Ykan7XrZ8tF17K340kF1DX3Z7tFWjv3y5Zws0qr95A3yU
	ZF1jgrykX3W7Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUejjgDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoTA2oVMA-iFAABsq

of_partition() calls of_node_get() on the parent device node at the
beginning of the function, storing the reference in 'partitions_np'.
This reference is leaked in two paths:

1. The compatibility check at the top of the function returns 0
   without releasing partitions_np when the node exists but is not
   "fixed-partitions" compatible.

2. The function returns 1 at the end after successfully processing
   all partitions without releasing partitions_np.

Fix both leaks by adding of_node_put(partitions_np) on each path.

Fixes: 2e3a191e89f9 ("block: add support for partition table defined in OF")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 block/partitions/of.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b60661098..53664ea06b65 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -74,8 +74,10 @@ int of_partition(struct parsed_partitions *state)
 	struct device_node *partitions_np = of_node_get(ddev->of_node);
 
 	if (!partitions_np ||
-	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
+	    !of_device_is_compatible(partitions_np, "fixed-partitions")) {
+		of_node_put(partitions_np);
 		return 0;
+	}
 
 	slot = 1;
 	/* Validate parition offset and size */
@@ -104,5 +106,6 @@ int of_partition(struct parsed_partitions *state)
 
 	seq_buf_puts(&state->pp_buf, "\n");
 
+	of_node_put(partitions_np);
 	return 1;
 }
-- 
2.34.1

