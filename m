Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919571;
	b=HfaR2lh0TZ7GLi5j4qj5y/6HvUp7oH5l/m3M3cxFFzd0V2oS5UL6yehaNPRxZtsUhWZd
	 qUZfByxJe9+N4MxhmhDMwG34AbBTO2Tfm/1FEyBZfNRX+3BT7Ii8Wq8O2WdoT/Et8D1wh
	 +GQIp1lfsU+KZBm63BW0op8DsZm1qsAIElouaoAD5AuuL3lgCcnxamsd0vdf/zU/uz8i1
	 4/0xlUhl8CApmUXpdJIlJ/7Fhoith+KsUh0MZizZJY3b6slTmONbnJuyF2dJvOsrwbuYw
	 LmPwoiH2b4v91cdwIZH7xflhibaLX+3tNKRQuJMPMzSRh5VBRbuqK2i8UDuWEScGorw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919571;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=bSrm9lXTjvPs0N3DSXO4YUFLxvuXy3uGRBnEIAak0Xg=;
	b=wasIKK/xwvrR7ppJGgIxxnNFZp0DY1n1Cu6U/RBYqKCuibovqk8KQpA7mESUWrc2R4yq
	 qj2SZ9lTj9XCZojbUXEyyzeAmanrRi23rutZ+S/xGhAHYKH5JU3PZ755IfTXyvDCkxLD0
	 cpEV9dhP7qQw3wCSf1zhMRUdWAFDjmk69XDg9XddXUeFvRXL8xKc8lh8zo6IArCFWL4BP
	 BDQTt7shKEm+ImtZAFavoytjnDlurSqimxN3ejFj606t7ecZ36GhDR43nYVeCqpBj00i6
	 6xzxZzfOsPDXLVB7hiaZmkJSVLEm0Vbv2SR9qBbeDf7I43oIDvCIxjlITzGrc17QQPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=j8fJeB4c;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA929606A323;
	Tue, 17 Nov 2026 12:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA929606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=j8fJeB4c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bS
	rm9lXTjvPs0N3DSXO4YUFLxvuXy3uGRBnEIAak0Xg=; b=j8fJeB4cis1EDJNfYN
	2CS8BuotjU28BO79v+4s4XNyPrxImnJFnnqyv5CJ5LgB+Lon2t0FFbpdNCmb59MI
	A3BFmAlmqFKKeP9vRCLDBHgPdI58sYbasaEJnU48xd3LiB67TSkJjAI27PBhw5sQ
	2AYEgIhBKus6BRZ/i5ZqGYvzI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3n316TPxq9b8OIQ--.62964S2;
	Tue, 17 Nov 2026 20:45:48 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: axboe@kernel.dk,
	mcgrof@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] block/swim3: Fix resource leaks on add_disk() failure
Date: Tue, 17 Nov 2026 20:45:46 +0800
Message-Id: <20261117124546.1378961-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3n316TPxq9b8OIQ--.62964S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy3Ww17Wr17Gr1fAr1fWFg_yoW8Aw1xpF
	17Ga9IkrWDGF42gr47Aw1DZa4rAa48G348ury2k3ZI9Fy5CFyqqrW8ta45Jr9xXrZ3Janr
	XF45tr18GF1rCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pir-BtUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RwMemr8THz8ZAAA35

When add_disk() fails after swim3_add_device() succeeds,
swim3_attach() releases the disk and tag set but leaves the IRQ,
register mappings and MacIO resource reservations allocated.

Add swim3_remove_device() to release these resources on this failure
path. Free the IRQ before unmapping the registers, and disable the
controller when it was enabled directly by the driver.

Fixes: 2d4bcf764297 ("block/swim3: add error handling support for add_disk()")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/block/swim3.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index a03de4c4d35f..bd3fc3326194 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1185,6 +1185,23 @@ static int swim3_add_device(struct macio_dev *mdev, int index)
 	return rc;
 }
 
+static void swim3_remove_device(struct macio_dev *mdev)
+{
+	struct device_node *swim = mdev->ofdev.dev.of_node;
+	struct floppy_state *fs = macio_get_drvdata(mdev);
+
+	free_irq(fs->swim3_intr, fs);
+
+	if (!mdev->media_bay)
+		pmac_call_feature(PMAC_FTR_SWIM3_ENABLE, swim, 0, 0);
+
+	iounmap(fs->dma);
+	iounmap(fs->swim3);
+
+	macio_release_resource(mdev, 0);
+	macio_release_resource(mdev, 1);
+}
+
 static int swim3_attach(struct macio_dev *mdev,
 			const struct of_device_id *match)
 {
@@ -1232,11 +1249,13 @@ static int swim3_attach(struct macio_dev *mdev,
 	set_capacity(disk, 2880);
 	rc = add_disk(disk);
 	if (rc)
-		goto out_cleanup_disk;
+		goto out_remove_device;
 
 	disks[floppy_count++] = disk;
 	return 0;
 
+out_remove_device:
+	swim3_remove_device(mdev);
 out_cleanup_disk:
 	put_disk(disk);
 out_free_tag_set:
-- 
2.25.1

