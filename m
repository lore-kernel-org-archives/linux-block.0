Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10781F937
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374126; cv=none; b=UmuGa5ikcamZs4/4q5hipO6oph3g+y/2XIO6B/Defa6XGFd1v0FJRXD9lIR8AubQW04oJW6m9WPQwBem6pLa5t8bPpRlKo8NIn+VvTyrAAfEcO5jyFMUexT8DflJZ4P38mdxT3QLdXxcZ1ZIkr6d4lyLO4ap/71tvUsOz3OMoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374126; c=relaxed/simple;
	bh=8jMOZAZDfcRpmvHeIERkLHeruFjM1ee9CG7CGcYIDNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=StRHLLSor7pBfdckTl+gdPP2Ns9mga7t/L1ZKO+tn3+sDeJuhr1/5JmJAMbBVUF1GgLrW+6gbpQDRrzJbAHiRR5A7/ZqBn0MEXeXHJHxMRnsjoSrms1lSOMIn+QoI71bTNVoJ8b4gS1LCNACjpN0CL7iysfNzAIxA0oeDZNYNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wyp5606gJzgYd3;
	Tue,  3 Sep 2024 22:33:14 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id CE0D71800A7;
	Tue,  3 Sep 2024 22:35:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 3 Sep
 2024 22:35:20 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <axboe@kernel.dk>, <hare@suse.de>, <dlemoal@kernel.org>,
	<john.g.garry@oracle.com>, <martin.petersen@oracle.com>
CC: <lizetao1@huawei.com>, <linux-block@vger.kernel.org>
Subject: [PATCH 01/21] mtip32xx: Remove redundant null pointer checks in mtip_hw_debugfs_init()
Date: Tue, 3 Sep 2024 22:43:54 +0800
Message-ID: <20240903144354.2005690-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Since the debugfs_create_dir() never returns a null pointer, checking
the return value for a null pointer is redundant, and using IS_ERR is
safe enough.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..56f3bb30165e 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2275,7 +2275,7 @@ static int mtip_hw_debugfs_init(struct driver_data *dd)
 		return -1;
 
 	dd->dfs_node = debugfs_create_dir(dd->disk->disk_name, dfs_parent);
-	if (IS_ERR_OR_NULL(dd->dfs_node)) {
+	if (IS_ERR(dd->dfs_node)) {
 		dev_warn(&dd->pdev->dev,
 			"Error creating node %s under debugfs\n",
 						dd->disk->disk_name);
@@ -4043,7 +4043,7 @@ static int __init mtip_init(void)
 	mtip_major = error;
 
 	dfs_parent = debugfs_create_dir("rssd", NULL);
-	if (IS_ERR_OR_NULL(dfs_parent)) {
+	if (IS_ERR(dfs_parent)) {
 		pr_warn("Error creating debugfs parent\n");
 		dfs_parent = NULL;
 	}
-- 
2.34.1

