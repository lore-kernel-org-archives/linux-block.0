Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB091BDC3
	for <linux-block@vger.kernel.org>; Mon, 26 Feb 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931715; cv=fail; b=oUD/ISAzrVEWUEdyYO6NcYp4EPaYd15fao+wCiC88TKQM1dXlqQc0qbfV+v+bW1fHLNkuBpwxVHNnN/JCIHQursdOQ//gSq+99zKJJ2xMEUY31mFCEpqqu2lBJGtxOmaHQQe7G7RISjiYQh4H0ppndmM/5uklSKMTpYPyUVJ+R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931715; c=relaxed/simple;
	bh=D01dVWrk/IMQO0NJAEMXZIhhQxIo64Lj8PccrzLhGSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k8p+iAm/Fb67ef64WIZD118pW46cE0t0n67Zqh7DbTidAwl2SYfdQgaDO7/6vG46SpZv5MMV1aXtN1StA21OoSF5o6dR4D7mhUw3j2VLtQlqGzh2ah04nIC7hVagG4OLXHM4+crXYCmkYlJyerAF71pIMfpT6OwKJIlGtk9oXQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTysPqmj; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTysPqmj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxugE0kf22WKGi/SpeL7bFCKIATg0EW3ZrMO9tSrtSFLfgfU/tsuHqeN0qZLoyAuorA5YZtGHVtZtQTlpxvGjMVyxnsnJtUry3G+j6RAAy+gf4PuiS2MqGmWdkpnfyvvTrpFewvZPWZHK2K/qPF5mUWlt3KZ2qAWxp5ZwQegHZVO6dN5Nu9WuLVd4BNFMq+/wFJ2ytqfYSi54A/v+ORfJii+fi0NQYryXJYXADQdWcLOsYEXlTxbklCV8ytyEMTfIpjL2Wet1j0y1ovPWdrjLD2Rs3jep/IcsjpMUsxeRhw0WZZtI3NdeocKT3rgEoJiUJoA23znQelD+oo+BibqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vRUqx4DB5+aXa6oygXkDmgDxjp90bZnJ9kRgLrw3K0=;
 b=NiZeHrYjeeGeQai/EDEfht2b6Y4tTJ2dRN2M/vfHxxe6nziNahVL42/Mg+NlBBrpTlaabI8QJUeLgZjVj5PXU5i/KEeNYsz2AJBOgUq7zJpfEcdTvwSxXGuD4EkCGreAaBzplluDHyOHncW4D48jVfPTUX9EMra/v6kTJj/UiMTS2QKmwtZUjQzyA+MCMrYgFdlxWTMMJslFqKDWkntucK5FhzKrDsSgYDGXpHcV+aNxyoRD3brq9/XgINOFOzNXbRPSklFZZ0lTpBlYetDwyG5jRSZjN4K/2Vp0LZLA1xOgJb+zHhUMrkNLz0dQcagaaAN8ddRd/DCr5TXOU6N4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vRUqx4DB5+aXa6oygXkDmgDxjp90bZnJ9kRgLrw3K0=;
 b=aTysPqmjvtdhpQIdvLMbVgsfB38T7boo1BHX3p4ezYn+TiaOmjrr4mEdiQUUBJ5YzXlUhteluBeuwd7e13AwFcxeYdM0QYRcnd+Zx2G/HE0weltL08/QNXv7uQnyf9NNwj5uu1jxbZveN+8KtxUFa+uhKnuR1asuu52tc9uyof9BJN9uvtJkgEYwc3HeBHd0Dprpo993zgcjSgJRlImeA9vDb1BVWYO45Gmok3tORm/uLNm4djfSSo4H2rLZAyk9VfvyRcg8IZBRRl9gePsYFbxHxjnrH9gK4mB22bfdnEYlodZYpft2OrLIOHOwSLIEcz7CK9UYMuHm/XtoxdM5+w==
Received: from PH8PR20CA0017.namprd20.prod.outlook.com (2603:10b6:510:23c::17)
 by SJ0PR12MB5471.namprd12.prod.outlook.com (2603:10b6:a03:300::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 07:15:09 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::6a) by PH8PR20CA0017.outlook.office365.com
 (2603:10b6:510:23c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 07:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 07:15:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 25 Feb
 2024 23:14:47 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 25 Feb
 2024 23:14:44 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
	<johannes.thumshirn@wdc.com>, <kch@nvidia.com>, <hare@suse.de>,
	<zhouchengming@bytedance.com>, <akinobu.mita@gmail.com>,
	<shinichiro.kawasaki@wdc.com>, <john.g.garry@oracle.com>
Subject: [PATCH] null_blk: add simple write-zeroes support
Date: Sun, 25 Feb 2024 23:13:55 -0800
Message-ID: <20240226071355.16723-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ0PR12MB5471:EE_
X-MS-Office365-Filtering-Correlation-Id: 940aa49e-67bc-487b-ca53-08dc369aaa22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FoFuaBQKPl5QTjVrHuV77sZ0nUulDQNXz4n7i3Rx8q/8wjdozPKvfJSoAyFoKwaiCN3k1BBOjp7eJLg0unaPubl0MFrBMPaSEWvGJbEI9fpOcv8P3XRXKz9LJOVqZwMcP4hn2eSx0lNFXi9OD/d7ilgXxSHm6d9k1XG2VZY6gudNK2hlur3aOMyGSfUXi2d34Qd+R4G1enkSarDkfhk4LSa59MPzD5P1k7GqmOeH8qDUiw98Nzqtkd2+wjtHHFNbk1cFe4jiVUlaGvCyBdmq8rNHN/mPymHTao6e6YHeUU8f3uyeOpNcb2o7/Zp7OmhxF6QmVbzndkbJQDT7aoqINjra2Chh+9QSZTWe1lMaMOdu0dhiWq9OUaK1BmnNPIEwu5QpQfvL3tcBuV62nXxabvt59Kekku4kpy8qFkUCE/7W5q9OKuJjtqAm8KlBv4n7VAsAMk5f2oyCZ6D2+hEQ8RsyIBuLF5jYqWiIdOiHllnUoax6iD3eUGVWay1uxt2pK7eUZqflJrybNpSp131tE8XyaNYNTlxvo+wt4NRPcNNS7ZGjIK/4MfLdR0m9DaArEQOEUqCiJX29N5jVqJfi/ky4bYClhZu4vEptSktb0xqrWe+0N+XyIgg96Q8jn602uj48sjrylGjgcRpYWB5DWE4tRh/SuSk3h8cg8YVCKl3gW3GFroUZSh0G+UHC55ONxejOrhsgTamlvIIrPI8zbpAuuNiDUnMiEQHqbkYh+zQEfsoYtwMrvHFe65Ppg+1t
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 07:15:08.5163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940aa49e-67bc-487b-ca53-08dc369aaa22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5471

To test the REQ_OP_WRITE_ZEROES command and fatal signal handling in
the code path starting from blkdev_issue_zeroout(), add a new module
parameter when null_blk module is loaded in non-memory-backed mode.

Disable REQ_OP_WRITE_ZEROES by default to retain the existing behavior.

without this patch :-

linux-block (for-next) # modprobe null_blk
linux-block (for-next) # blkdiscard -z -o 0 -l 40960 /dev/nullb0
linux-block (for-next) # dmesg -c 
[24977.282226] null_blk: null_process_cmd 1337 WRITE

with this patch :-

linux-block (for-next) # modprobe null_blk write_zeroes=1
linux-block (for-next) # blkdiscard -z -o 0 -l 40960 /dev/nullb0
linux-block (for-next) # dmesg -c 
[25009.164341] null_blk: null_process_cmd 1337 WRITE_ZEROES

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c     | 14 ++++++++++++--
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 71c39bcd872c..b454f6e6c60a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -221,6 +221,10 @@ static bool g_discard;
 module_param_named(discard, g_discard, bool, 0444);
 MODULE_PARM_DESC(discard, "Support discard operations (requires memory-backed null_blk device). Default: false");
 
+static bool g_write_zeroes;
+module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
+MODULE_PARM_DESC(write_zeroes, "Support write-zeroes operations (requires non-memory-backed null_blk device). Default: false");
+
 static unsigned long g_cache_size;
 module_param_named(cache_size, g_cache_size, ulong, 0444);
 MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
@@ -742,6 +746,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->blocking = g_blocking;
 	dev->memory_backed = g_memory_backed;
 	dev->discard = g_discard;
+	dev->write_zeroes = g_write_zeroes;
 	dev->cache_size = g_cache_size;
 	dev->mbps = g_mbps;
 	dev->use_per_node_hctx = g_use_per_node_hctx;
@@ -1684,8 +1689,13 @@ static void null_del_dev(struct nullb *nullb)
 	dev->nullb = NULL;
 }
 
-static void null_config_discard(struct nullb *nullb, struct queue_limits *lim)
+static void null_config_discard_write_zeroes(struct nullb *nullb,
+					     struct queue_limits *lim)
 {
+	/* REQ_OP_WRITE_ZEROES only supported in non memory backed mode */
+	if (!nullb->dev->memory_backed && nullb->dev->write_zeroes)
+		lim->max_write_zeroes_sectors = UINT_MAX >> 9;
+
 	if (nullb->dev->discard == false)
 		return;
 
@@ -1891,7 +1901,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	if (dev->virt_boundary)
 		lim.virt_boundary_mask = PAGE_SIZE - 1;
-	null_config_discard(nullb, &lim);
+	null_config_discard_write_zeroes(nullb, &lim);
 	if (dev->zoned) {
 		rv = null_init_zoned_dev(dev, &lim);
 		if (rv)
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 477b97746823..8518b4bf2530 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -99,6 +99,7 @@ struct nullb_device {
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
+	bool write_zeroes; /* if support write_zeroes */
 	bool zoned; /* if device is zoned */
 	bool virt_boundary; /* virtual boundary on/off for the device */
 	bool no_sched; /* no IO scheduler for the device */
-- 
2.40.0

