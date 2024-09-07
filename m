Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780751CAAC
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725679923; cv=none; b=cINQ8M0gH+scpivq4Vgx7dTIp/CD+8kCBc0Y30up0lVPi5LoRv8vUo7apZGJEHjS0rqiEkcx/d39ZDsP/Fl1U2tR1GhVHvU4WtH1aUq3jt0zW3XtZoygPC0o47OiShRyIO92/O3DT1fuDn5offGQCCLq7MGqn9Va+Hv1E1TXI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725679923; c=relaxed/simple;
	bh=Gg9VBC+GJoMpo+Qwp6egDfeOVXw+fa5iSdUVKZ8DjCA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTYpGgjlshN3QywJhbbnBU43fNTPVr6+gxgLOZV9bRUiQ6ySJ/EX+mugfXCOWAX1CF2exIZsI/R8Fr0F2Efg5MBK6egACKFK7C6RIUdndeDzKHis51oGnhClErbzEBYmRI/VvuVcgG2/AT4BEra0tpU/5cB3hJW2jN+AVXD7pV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X0z8B2MMMz1HJ7T;
	Sat,  7 Sep 2024 11:28:26 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id BF5B31A0188;
	Sat,  7 Sep 2024 11:31:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 7 Sep
 2024 11:31:56 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <axboe@kernel.dk>, <hare@suse.de>, <dlemoal@kernel.org>,
	<ming.lei@redhat.com>, <john.g.garry@oracle.com>
CC: <lizetao1@huawei.com>, <linux-block@vger.kernel.org>
Subject: [PATCH -next v2] mtip32xx: Remove redundant null pointer checks in mtip_hw_debugfs_init()
Date: Sat, 7 Sep 2024 11:40:46 +0800
Message-ID: <20240907034046.3595268-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Since the debugfs_create_dir() never returns a null pointer, checking
the return value for a null pointer is redundant. Since
debugfs_create_file() can deal with a ERR_PTR() style pointer, drop
the check.  Since mtip_hw_debugfs_init does not pay attention to the
return value, its return type can be changed to void.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: Directly delete the check on the return value of
debugfs_create_dir
v1:
https://lore.kernel.org/all/20240903144354.2005690-1-lizetao1@huawei.com/

 drivers/block/mtip32xx/mtip32xx.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..11901f2812ad 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2269,25 +2269,12 @@ static const struct file_operations mtip_flags_fops = {
 	.llseek = no_llseek,
 };
 
-static int mtip_hw_debugfs_init(struct driver_data *dd)
+static void mtip_hw_debugfs_init(struct driver_data *dd)
 {
-	if (!dfs_parent)
-		return -1;
-
 	dd->dfs_node = debugfs_create_dir(dd->disk->disk_name, dfs_parent);
-	if (IS_ERR_OR_NULL(dd->dfs_node)) {
-		dev_warn(&dd->pdev->dev,
-			"Error creating node %s under debugfs\n",
-						dd->disk->disk_name);
-		dd->dfs_node = NULL;
-		return -1;
-	}
-
 	debugfs_create_file("flags", 0444, dd->dfs_node, dd, &mtip_flags_fops);
 	debugfs_create_file("registers", 0444, dd->dfs_node, dd,
 			    &mtip_regs_fops);
-
-	return 0;
 }
 
 static void mtip_hw_debugfs_exit(struct driver_data *dd)
@@ -4043,10 +4030,6 @@ static int __init mtip_init(void)
 	mtip_major = error;
 
 	dfs_parent = debugfs_create_dir("rssd", NULL);
-	if (IS_ERR_OR_NULL(dfs_parent)) {
-		pr_warn("Error creating debugfs parent\n");
-		dfs_parent = NULL;
-	}
 
 	/* Register our PCI operations. */
 	error = pci_register_driver(&mtip_pci_driver);
-- 
2.34.1

