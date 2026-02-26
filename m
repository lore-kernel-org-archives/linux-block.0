Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C163815ED
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075602; cv=fail; b=noxZgPpoDxjQ18996GuqsjC1CsPREQ8Arnkl+04/W2zxwxs4RWQu5VugsbRyhyOo493GJnENQJRFIxXgoL0PueUmq1ieV5yOiF+C7Xu3NeexBHzh6Wx4/bxo3R7QOG6qQz777CqLLiQOOGcRyCjJ9VFmxv0IqGbtoDWPcHv5hAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075602; c=relaxed/simple;
	bh=hW3vVLLk5VIq6wY4ivwAxI9dKOKjdoqzUQyTSARMRdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdS1+tw5mlyuglrLqc3KWNGJ4ARcdrzJ8q6Vg2HxA053Xi3saac0XT+RwsR9wRsPXe8/mbI/VwyknfOM7Bps62hbcTZecgCZcCLheKg36VElfqjUllNVJjTY0OaU/+uVoaqirKzo2wM8Xi9WUUsltWyQh8UB3jMdc9TkuHhOjmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kAkXO/jT; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kAkXO/jT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFZEwhb9UTOe6GKUrj9CALExGWTWlByQortUxvUDFH/KgKbztT5vBVtfnHEwi77YRWlmIexXnPi9pfkvVAFdn11I5Fgrl56AaSL4OnJrMzq+xsBU8XIoIgpDKOYoBrT3x3iP6417img6UnhMtPISK3NwFRNCirpCHVBBz8FU41gGirO0ySqeItD7ikhbe0Z7oZ0zDZI53tgc6BznFCjV7/+qPXYqb+FHiYdZk6PLacM1Mha3eLCjPrun7PUIc2xQBcOTLfmPgI9XUTyZw0HcTqz43ouKP0XkZ8DgGFZmxuok7stHKqdsLBXLk8maNTn8nDh61utNFra4eNvgwhn64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e8TUli8dzyNJnmcU4YHeRMeAb+Njk+TMsoHFCA0p+4=;
 b=L4Jpmzc9BaTzdGZ3cG9rTC+nVFL555Hojz7jaCk0jjr7Hw31Jae+iigpmUcxb2zz3D9HbxSDrXIG7aVpJhANGaaXe3Neh8gjafkwJxugrRBMK06ovKI+Tzs/hsDXl92BOo6Cp5QIKIpkXcHrkEZy0mlERvwReuAKfsUS7Xs63zI00X3FME/ld5X8AXIyU/UVEIlsQPkYkG5SyYmvthWADnj1YrCKx7mTU7t+SyW2v/IQO9gNcYqimqDxluHeld6OYcMDoI9YF4chhvdnHy/B8XckfrLmILk3ULFFeImoepVclfVJSlsNNbsv0fRgDQJwM2zRTNJ9ROHNYwbsbTBkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+e8TUli8dzyNJnmcU4YHeRMeAb+Njk+TMsoHFCA0p+4=;
 b=kAkXO/jTh82IcY+b4NYouFkPDlWo88U0P4/hweUXEeiZ/n+OLKu0UsKKusQUlzvtmzmbQhmBq9yZZkq6rJ84pAFPGMJeJLE+oYZ+79LpTK7iAUVk3ElFAc8/PQNGeDoPBtqpjVJJ+hwPa6+O0/cdv4HLJZoPa5jiApspjMmVEFF81XuApOMkOYoMVQAMQlSbUmjr5CiHJcEAkvCTDeIQK0rRYkVHG/xHsp7eLboWTwS80ocTNDWQenyT7y6HaRg1+IVr03HgvIsyxqOqbArZ5dlM9+U66cXu7egDB4RQ5vu4m4Qc8CGZdqZeqaCBQrzSzyo8QjLqyppmnk75Y8quyg==
Received: from DS7PR05CA0043.namprd05.prod.outlook.com (2603:10b6:8:2f::22) by
 IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 03:13:15 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::f0) by DS7PR05CA0043.outlook.office365.com
 (2603:10b6:8:2f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 03:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 03:13:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 19:13:07 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 19:13:06 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <wagi@monom.org>
CC: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	"Chaitanya Kulkarni" <kch@nvidia.com>
Subject: [PATCH V2 1/2] block: move bio queue-transition flag fixups into blk_steal_bios()
Date: Wed, 25 Feb 2026 19:12:42 -0800
Message-ID: <20260226031243.87200-2-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260226031243.87200-1-kch@nvidia.com>
References: <20260226031243.87200-1-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 10679230-6329-4c1e-4a7d-08de74e4fb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	cYgcpIJQiCX/PipUxrbFDkAuWU+ZyxRi+xkQU0QcoHY6wCBsbs75bVbmrkAPNS4P9M3S7NNHcLw2ON4iB6BFYbp2jWqeJdULW/X+TcJnyck/g0egrLTRkhwzh3pXwAtRSYprlSmBAI9ZuaprR4KLA/NQZwq+pRXscfTF+ohFp7K+9jBH8ddvIvWQltCSCZakuy6+bLCaQV/IAjkibOeqIOKzsZEVPPJOh8dAS3zp1PNLtD7xmQaLVwatVEmxjdMgTuDWn6KhNh0eNlQW/WAxYGMfwcm9+6tc8hBUOzT/AtjpgjCM1H5xy73eN8Skwam3vH+RcvnxwrXCa22/HNQGKDvbshtV1ABdgMmCKTxYaHgY909FE/Jp6+Sf5gVerSv25fZEwnonP/hvZlEMzXCViHaYhuMy6d4jZq5za9rlpNix5gIqeZRu5+zvW6QO3EsjLl8nyRX1jsOH5leXjFBR2LtKoormLF2PFYpXz4BimgSBfvX1gIOBGwIuJauV9Q/Vzz9+qsAwdYTNPYE9OT8CtYmYuM6C6uSqp9iNcmeEKv+C+sGqwK9CJ8kJ1OPrZitb7J6wz3wxKm1tQWwMLec3EUIjdZaTyt3ES4/vUAZkrrk3qFs2KaJrUQtMAFJaOEXE7yLHtHqQ72SY7epUrzM9KPDeCFW3nsWB+a4Jgq92J27e1lCVvB2fWZVNwRXJZ3REFHxDXWRsk2LLfgkJ77UQ2MP1/3CfejWiCZVsIpXZFPsrR5G4+3gvUdQ9afSZIKBagix3EMezMzGO06rqo8NiaRxEtwrgZ4d5vHKLC6+3ZmiBKCo+LrImVjpUUnDbxv7aFuvKxltHn38LyUAq9R6Slw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i8cf8x4dGuc+UgDsHrnqd0oj7jaANTN9843EODGDU5nrooxNyEjZW64ymPddj7JsBRIrcJuyHfJH8Ujp9kLsP1X0EUJVXKqRDn5fxC9ES0mjGq+dI+0DRz/jiwIb/EwlBU05X4zrk0WtKUhR+DVAcCYBGLCyX0K+zZW4/xiiW1XKGxwFvmg84bz7L6BRAiCjBvjIeUGcExX0YaGi4mYe24uocMfH/m9usqbiNJtKHmBIwM63+HNvg5FJ8cRjVLnkNklSOvOg3O4eRJQ/C4L8t0t0iQAAYhxpJiYChA5DPZTrLM4l0q0t321V/VvRvSiHcs0bHG0Pzifr6IrabEdTZQsRjLJG5/BvJrwEhsXhMP+eubRYeXDddRnTPJeEpn9xOJM9wcgaqY2civyo7NgFt36O2ahiXpQEtVm6/39UShkpdXtBrrKYjWiDmGDQFXqr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:13:14.6448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10679230-6329-4c1e-4a7d-08de74e4fb23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1

blk_steal_bios() transfers bios from a request to a bio_list when the
request is requeued to a different queue. The NVMe multipath failover
path (nvme_failover_req) currently open-codes clearing of REQ_POLLED,
bi_cookie, and REQ_NOWAIT on each bio before calling blk_steal_bios().

Move these fixups into blk_steal_bios() itself so that any caller
automatically gets correct flag state when bios cross queue boundaries.
Simplify nvme_failover_req() accordingly.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq.c                | 17 +++++++++++++++++
 drivers/nvme/host/multipath.c | 15 +--------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a29d8ac9d3e3..419b5c768af2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3412,6 +3412,23 @@ EXPORT_SYMBOL_GPL(blk_rq_prep_clone);
  */
 void blk_steal_bios(struct bio_list *list, struct request *rq)
 {
+	struct bio *bio;
+
+	for (bio = rq->bio; bio; bio = bio->bi_next) {
+		if (bio->bi_opf & REQ_POLLED) {
+			bio->bi_opf &= ~REQ_POLLED;
+			bio->bi_cookie = BLK_QC_T_NONE;
+		}
+		/*
+		 * The alternate request queue that we may end up submitting
+		 * the bio to may be frozen temporarily, in this case REQ_NOWAIT
+		 * will fail the I/O immediately with EAGAIN to the issuer.
+		 * We are not in the issuer context which cannot block. Clear
+		 * the flag to avoid spurious EAGAIN I/O failures.
+		 */
+		bio->bi_opf &= ~REQ_NOWAIT;
+	}
+
 	if (rq->bio) {
 		if (list->tail)
 			list->tail->bi_next = rq->bio;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index bfcc5904e6a2..cda8a1e21f59 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -154,21 +154,8 @@ void nvme_failover_req(struct request *req)
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	for (bio = req->bio; bio; bio = bio->bi_next) {
+	for (bio = req->bio; bio; bio = bio->bi_next)
 		bio_set_dev(bio, ns->head->disk->part0);
-		if (bio->bi_opf & REQ_POLLED) {
-			bio->bi_opf &= ~REQ_POLLED;
-			bio->bi_cookie = BLK_QC_T_NONE;
-		}
-		/*
-		 * The alternate request queue that we may end up submitting
-		 * the bio to may be frozen temporarily, in this case REQ_NOWAIT
-		 * will fail the I/O immediately with EAGAIN to the issuer.
-		 * We are not in the issuer context which cannot block. Clear
-		 * the flag to avoid spurious EAGAIN I/O failures.
-		 */
-		bio->bi_opf &= ~REQ_NOWAIT;
-	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
-- 
2.39.5

