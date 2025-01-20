Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23319BA6;
	Mon, 20 Jan 2025 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390088; cv=none; b=MKY2oLG07SXqfYDkmit5d4zcVwO2btSNXU15ahJ7aipgdpI9efEyrnVgw9ObfLXx0w7326I7Jj5HmcnOdcOUkMU9JJTDVDuKx56Bg1nExeJRHQesj3uW50eojQMWINEJ08V3eG/WQSyexA/kPEcvK1gGCGPvlPj/qZBNxiK89xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390088; c=relaxed/simple;
	bh=7A+s5dqBOmuxkxC843S6h9qfugL5aMEJ9Bx0V/C9LB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+EB8G3xNV4NmJTGbyb5R68OF/z2RWjMW8NpmLcS9LvvekQvV0thDUiiXXY1+/yiSdEHPC+7DHbTJ3QyukmwHyWm3ycgsQUPJdos3WT6gdzE+A+Z6U0o23Ce58nKbwpGObL14bAEs4quAfA978nTZ4TPzY2Ah1F6AAJdW4BaNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL3GMOqQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL3GMOqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25FEC4CEDD;
	Mon, 20 Jan 2025 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737390087;
	bh=7A+s5dqBOmuxkxC843S6h9qfugL5aMEJ9Bx0V/C9LB8=;
	h=From:To:Cc:Subject:Date:From;
	b=uL3GMOqQXoOq3Tw1zdy2vLzLr/0KsB1soF/EY7aJr4DRCDzsJ5vcpOziD0V+ZcCCH
	 n4gywjuURU6K1FIJVlIdgqk6DZQI43gjcIn7sR1C0lzzWTCuz4Ia5O9MUtekc1TuDn
	 bR/GiI/cp9cA9zM5ocbbsXLq8Oxu37X0zKvPg59cP6jAMQwIyD4ANL9BKCOKWRh8Sj
	 vy4uEmccBXyTR59XEvj6AZlzS41/T7iIG1LYk7eG/bNYHPYktJfc/Xzo6iCKW5XZFb
	 1QDwaBCHwaW3EXqpOGU9odc1AOL0Z4ckANSQLxI5oYKEJvH5ik7+slEtXrmMWDgIPI
	 QsYDFWe9fItcA==
From: Philipp Stanner <phasta@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Li Zetao <lizetao1@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: mtip32xx: Remove unnecessary function calls
Date: Mon, 20 Jan 2025 17:20:22 +0100
Message-ID: <20250120162020.67024-3-phasta@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iounmap_regions() does not have to be called, because the regions
are automatically unmapped since they were mapped with managed
functions. Moreover, that function is deprecated anyways.

Furthermore, setting the drvdata to NULL is unnecessary in a driver
remove() function.

Remove the unnecessary calls.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
This patch had been around before in a series [1], but I unfortunately
messed it up and caused a race [2], which is why this patch here exists.
It's independent and fixes the rest of the pcim_ API up in this driver
once and for all :)

P.

[1] https://lore.kernel.org/all/20241016094911.24818-6-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20241107162459.71e0288a@canb.auug.org.au/
---
 drivers/block/mtip32xx/mtip32xx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 43701b7b10a7..aa9badb9a51d 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3718,7 +3718,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rv) {
 		dev_warn(&pdev->dev, "64-bit DMA enable failed\n");
-		goto setmask_err;
+		goto iomap_err;
 	}
 
 	/* Copy the info we may need later into the private data structure. */
@@ -3734,7 +3734,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	if (!dd->isr_workq) {
 		dev_warn(&pdev->dev, "Can't create wq %d\n", dd->instance);
 		rv = -ENOMEM;
-		goto setmask_err;
+		goto iomap_err;
 	}
 
 	memset(cpu_list, 0, sizeof(cpu_list));
@@ -3831,8 +3831,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[1].cpu_binding);
 		drop_cpu(dd->work[2].cpu_binding);
 	}
-setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 
 iomap_err:
 	kfree(dd);
@@ -3907,10 +3905,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 	}
 
 	pci_disable_msi(pdev);
-
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
-	pci_set_drvdata(pdev, NULL);
-
 	put_disk(dd->disk);
 }
 
-- 
2.47.1

