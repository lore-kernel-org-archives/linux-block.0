Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F1261B92
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770843018; cv=fail; b=F3lIy7w7DGss/a4UjFR6rGU8Fjt8fhlDXF6++FTBPDbxprSXicaTjlghHr+j0umKeOcMIMe669q6g070X1zShB945cJjZJFObdPRrPwtkL6EmerEuij35kTk5/CEpCGCG22JJerWUw1JaWqNAb2WO57m4UeQKn/wFpVmwHMM4k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770843018; c=relaxed/simple;
	bh=F7+jxxOnQxD0zZ2PyTIzYwvFKo+tm3G1sJzZL7eppY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=df+xQ3QHD6ckSOwVqpgIBgLGQ7TKqBEAnFjag8eg70okUQgGlRi5NJWkdfRsRmkQbn3q901by2YDX7vnCJ5QoKeEr/LHrWUzc8Hp3saTDOGCKhcX2I7F4JI5oh7hfiK6IKPOqwz4DfxVx+R00JU3VSK6gySAoAT0o4lMOuPQCIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SHMic5FQ; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SHMic5FQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+RkWgbBL5WzzqaZm24+I/BJAb6z7Jql+u9gdoY+beu2qa7VD0vN26NROxneX+rCz7BmvYgHNi6asQ0+YidO4xo2GCwOFAntFRb78e0wmccUcBVYJfdNa3Rgc7ge+QhVZiI3p90bmt435Q5E5ZafIZJWrbSHYiwU0GDrLEgn39Q+c7Cj5eLGTDAxkloqg80hSWg274XWMFym+wnvr42oDPApxK8+cPPZfOZ74myOQZOV+QUKgN9Vz/9SaN2X1CBcrtJxgg+X+AIhRWggLaFKn2ogIu51GoKojEfs9uKUEp/S8BuMm4sv2JFzK+GVImdMUayW+I+KZxlGs75fJDOjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC+43XdUJh2SWXLMwOiYUUF32eFg90jxmYtzrJWLbf4=;
 b=YTo3vlHhNwY/DJ0DIDWwXg7cfImzhRDvFuhBIGjSvyYbRLdKNI0EpNjpIjsdKV9UGOqLkpqKjGkfQeIGDUucYNJV4o8z399M1qFfJ4LzL2POtqhH0p9Tapevtq6XTWE/ZYR2g9u+WdVaPf/T7+++zfWk3b1snVUa47EW6lnnzXuUMUYrh4P2HvJ3JlriD4FvKWg5X1Klkw2iEaCnqBSaNR6FOCQGE1yKHwlsQzly3ik542Md9XAOv+d/Af+otwWvqeFGgVoSBztG72GuzQ8H9TCSRggFsodkHKBRWhZr0c9IxEmYdeJlLC/X5iLu7zyfcA2pHur9MNyvs5vhrzQCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC+43XdUJh2SWXLMwOiYUUF32eFg90jxmYtzrJWLbf4=;
 b=SHMic5FQ+S0FYKM1rOHgCMXDhb0xkiStRODI+V2dAG+C8gsc9ehN6uSU5P5jU/BVCd1NAF+Jc5Yf8F5JgfvgZ39Y9R9LFsA1SShdW3ujymrn4eDT7IGfk3hwy9tAytDrsMTeVy2DvZYJOjFFzAn92bwHOTAIGwxPQHRx6Oh+uq2eTSPCE19JJdoo9IY3pXfkfnUhawJHc4Qn9mCWjICRxPNfrnsZkxuTlFjJggjXzU7AlVZyYta4ZWIqhggF+ozOTCaB8/lYHodzDUVF3jZjf3MBku3GFYqqueSvJz8tPTos/FhONpUj+RvdXGf1XgJ+p2wFllBTfD4kJDMEz4q8IA==
Received: from SN7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::22)
 by SA5PPFD911547FB.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 20:50:12 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::d9) by SN7P222CA0005.outlook.office365.com
 (2603:10b6:806:124::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 20:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 20:50:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 12:49:53 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 12:49:52 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hch@lst.de>
CC: <leon@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] block: fix partial IOVA mapping cleanup in blk_rq_dma_map_iova
Date: Wed, 11 Feb 2026 12:49:44 -0800
Message-ID: <20260211204944.23380-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SA5PPFD911547FB:EE_
X-MS-Office365-Filtering-Correlation-Id: e9778675-eaa1-4b6f-c08f-08de69af25f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2ehQYkeqOzOPGUNuZH4fTJjfbI8I/+QDyUIukEJB/XDGt4SmhYg0x26znds?=
 =?us-ascii?Q?91I8Qj+BpGbXI9rbCOcqcXCxVvd5sFA+qIPWW3RTQb7v8QWK/RN12KZUmWpx?=
 =?us-ascii?Q?6fI/dH6ZDxRBVvCQG6qRjJiZzqJ2vyJn73hsd+SUSSJAxcMHxplvftP8LS/w?=
 =?us-ascii?Q?QJiYnVgI5BtoylagVLhMqr+VyNXtoDW5z80M59IN0DYIdAUQEfyXs2lhzFz7?=
 =?us-ascii?Q?yrBjbKMG6FPsHqT8mSIsY0r8Zk6aFJZ37VOgYOvKST3+XtHguiCWvuQLIHYY?=
 =?us-ascii?Q?i+SZPhzOG60fPce4OSALwHU+U9cKzITDwNiumoVmH0jAWUFesfOFHUYfQK3T?=
 =?us-ascii?Q?5dewm/WicJ7WVn0UvzKcoUtKU9jo92pmnF/HPD88BKnqFdrvThOieblWEcgf?=
 =?us-ascii?Q?xkOzCzxveXHKj5Tbbzyz3TCZzpgQFFs0eMf9gZ+o6ak/l/E2DZi9TJp6E1My?=
 =?us-ascii?Q?N5kEY2eSWJ7OMz6pa3KcGFBCqta5SJAdE+/XZEG0JtHrygPdiH2dKq8bTRAe?=
 =?us-ascii?Q?uBfscXLRUUc3Gg6LyJjdbxCr6VUnVbEff1XtWt6dNMFqq7k4e9BIIJS8Tk8i?=
 =?us-ascii?Q?FF9FQ78QWy3Vlta8u6URHmTXmYdkiRMKYKR1liQf7PSQyRG6Fjvp3alyKj/W?=
 =?us-ascii?Q?2nZUV7Tu86WldN+KPIwTQeK8AG+GJj7te33mo4MT6SE8sHsQdpdy7wkz0SHq?=
 =?us-ascii?Q?XMi7DqNcMxrecQWl+dZrK17jzOSHojFiywu2B7YrgVEXFn6H+h88ABYr13JT?=
 =?us-ascii?Q?p96UkkaO1XaxqVSFcEA08zXG874KpbI8yI0yqcOxelGKUTLGyZ9XANZ2Wau2?=
 =?us-ascii?Q?zGDAgrU2Fpf45Q1sdC9MTt2Bphl1Ye6dDVn2M8Aaf3tGPrm2l5Kr7asunuMq?=
 =?us-ascii?Q?4aMvwB2BYaIA6VGTEm2kK7DIqQuCD5q06KloJ50Lga/skiofsQOhUaBpBvjV?=
 =?us-ascii?Q?AjmmBak5Myg6QF8Cy+PxGptN9FQfg0pvorgsxtniue8DEzwkY/aoDV1YVQAA?=
 =?us-ascii?Q?CD19RSBlbHCv6d8BaojSI29IB3psT90izJIDxc6VSJHcPzGlGWMoqMVjXuyH?=
 =?us-ascii?Q?ZHr0zRTgArfpfYyqJoozMK+H2X+87Ws5EtZ04msnxT2zfl6yQJiv38ToFlCC?=
 =?us-ascii?Q?rqQ5kNCgfX9oEsZ6ubgOHKksZZ2D2jXPeL1rLbmxNxfRULWDBCdtz5EbLpyk?=
 =?us-ascii?Q?gjfiVinZgbLFm47/eYu+YUid1ggebxAuiIa14dP1m/4Y7akOX6fIbfJHC41a?=
 =?us-ascii?Q?Vxb0aLvdYLXJLDg84MWiNGBGcVDQCqByBqAs7uFITx1iPfQasw9IFdQxQMUV?=
 =?us-ascii?Q?Y1lzaLoS6Wu+zhoqC5GbE2q/HteOeXf5Hq5+XIozUEnmRJ4JrJo0XkzFq+Lp?=
 =?us-ascii?Q?lKY5KhM/9LKW1cLi5bkxMyHxk26/pkbmUyW2W0gkl2+KL+2C1MMVC8LmH6q+?=
 =?us-ascii?Q?kXGqDWrQ+wQEjBKIO7i725YMXbtGP9fOM/IKszetAMt03vMOC6oxaFk6mrul?=
 =?us-ascii?Q?ckxzVU8lAtI1GkfJSu6qg8l3WA1PL5yh4DdP8DRpDD8MomZy3LyIK/1sSCDm?=
 =?us-ascii?Q?pgTyN5XRbtjAVkiOrWYIS6TFIQMmlPqCfTU6ekvRJRJvFgwNsnpBAM0IMxzh?=
 =?us-ascii?Q?6ihtgdbexbzogKKUwiGdLMW0oxBq1UIlwEUErtsqdQSWuxb955couUOFS39b?=
 =?us-ascii?Q?GwAzRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zvym6gE0xo9apUtVKMiMDvyQKciMypI245CeZsuIjMg0BlwxhlJjyvFEgLONztXUABv7i7g9ZMP8VK4FXqe1jGkrf3PWfSqninB51+Cn6R0Bz1r4KCnQoNsHZllwP6XppIuUw6pqtFMkqhL8g+uZcfT2KIxUBO1OJLo2ah4G49ZUdPWjhP5aO3NYGJrgha5GB1dYmqCWtOmejaIPHAKm4VR3p/zgCyAJUa+N/pbOj8brJ8ffnjXYG6Om32w/WverhQ38l+/zeTw1wgzBH2AjsFEZneaiiVq+h0GfK3LHXl1JL67z5OYAp/EjDriNjzSiImj/tQNQ5jTl4eJIfnGfOSgb2pxcBIE6IpRDemyLjJXBwy0IwfVAUdJ1ca+W2sa7Td0AXmOkU4Xhscj/7G8kCFmwluQuL/r05+cNwAngq42M515SIkJljQNIU+uw3tN0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 20:50:10.8703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9778675-eaa1-4b6f-c08f-08de69af25f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB

When dma_iova_link() fails partway through mapping a request's bvec
list, the function breaks out of the loop without cleaning up
already mapped segments. Similarly, if dma_iova_sync() fails after
linking all segments, no cleanup is performed.

This leaves partial IOVA mappings in place. The completion path
attempts to unmap the full expected size via dma_iova_destroy() or
nvme_unmap_data(), but only a partial size was actually mapped,
leading to incorrect unmap operations.

Add an out_unlink error path that calls dma_iova_destroy() to clean
up partial mappings before returning failure. The dma_iova_destroy()
function handles both partial unlink and IOVA space freeing. It
correctly handles the mapped_len == 0 case (first dma_iova_link()
failure) by only freeing the IOVA allocation without attempting to
unmap.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq-dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 3c87779cdc19..bfdb9ed70741 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -121,17 +121,20 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
 				vec->len, dir, attrs);
 		if (error)
-			break;
+			goto out_unlink;
 		mapped += vec->len;
 	} while (blk_map_iter_next(req, &iter->iter, vec));
 
 	error = dma_iova_sync(dma_dev, state, 0, mapped);
-	if (error) {
-		iter->status = errno_to_blk_status(error);
-		return false;
-	}
+	if (error)
+		goto out_unlink;
 
 	return true;
+
+out_unlink:
+	dma_iova_destroy(dma_dev, state, mapped, dir, attrs);
+	iter->status = errno_to_blk_status(error);
+	return false;
 }
 
 static inline void blk_rq_map_iter_init(struct request *rq,
-- 
2.39.5

