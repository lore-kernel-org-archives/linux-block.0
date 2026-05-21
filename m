Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022143.outbound.protection.outlook.com [52.101.101.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD31358369;
	Thu, 21 May 2026 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406209; cv=fail; b=tBSgd7xHIumo745cFbuScwi5NtM2NLbglPat7q1lFoikYvyz51cUub8HwxivAJQcXCbCuxfZAYU3gUFaN7OcSI1Z0zrPAs2AL1q7TnMK0ToCn/h204Dsd4jpjK5vQFDHFjmgzcVCA6e9hD/32OjJVDb1gRgzRmO17vGSxVfJnmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406209; c=relaxed/simple;
	bh=jENbK+vrYb6YqS1GYa8XzDXhjvifp1BwR+fmi1nKfLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLvPmZO7hbM/3ZQJ4lIBG5a58elvMCuHyQE67ozzAjQXXkl7yzXzvEI2SF0F1QeLoLc0P29q6FVgSrSv1VvnhVFRWDa4KOgQpOkPL/UWKxS1nqymCOngebPYu9rk/Y0Cuez2c3KMjjKwJBAcadDm2Eg9jBd9o6KZmksgFHUX87U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8tViBA0BSKy7uaYFt9K1Id0lyW2vWlsa4y2YfA4ibXftIk3dF4CTAozkO/50rMueNKW62o+bwSehq5QNARgx9c6EI4HE3dSM0NANu3+6ELNwL3gLmp8OMNuLgKG44jCNq3A51B9MuUH43oH0+OO+GBWzMFCS3UENuXqnUw8+Q+yaOXvbISa1dUR2yz1qDCt+gmlglwJ4PF9HQuSFo4DVhVxRCx6wX3nSGaU8UCQ8YVdvt+k0v3hjZZKDjO/qCvM9hhZXbCUqnxnU6I7IeWt5IYOwyeJ9EXKZIg5ImegqodlakEIdkgDvRXxJU22/a5ze+Q10upP9IL3cEVeYQBitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K43Wuedv+u4rD85xwRtYGV1orY+Mw4iD6rZzvgYkw9E=;
 b=lj5d6qN/awRHTRZ1DiZjlFJKLQ/4m3YnwAvu2rsTH8vX0oRb0689NwQ9YfGe1OKQZHw5X3BbzA9qIncbFQQyNM6JVF+7lMr4fuPJaad/RchLyYvbrZHgQKOUz4NwQRUebSABxtBIMubGN+peklycZoMCw4vZU8pOtHAkcqVx35AJ8pb7zesK4Kuql8238Z+SFyihbuaeFvKYuaRi7rB0657ZVizDobaIXLr8WNX1wgLXtoi9wtZj93SoRYo34psp08BwmbwjkVOzvaYKQHK6PXj4vkDbY99+UIg1nT5oQkaV4X+kRssy8/M4cWq9wdTpRqpeBhfTxkVjIZSLCvPFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6796.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 23:30:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 23:30:04 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	mst@redhat.com
Cc: atomlin@atomlin.com,
	aacraid@microsemi.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	liyihang9@h-partners.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com,
	jinpu.wang@cloud.ionos.com,
	tglx@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	ruanjinjie@huawei.com,
	bigeasy@linutronix.de,
	yphbchou0911@gmail.com,
	wagi@kernel.org,
	frederic@kernel.org,
	longman@redhat.com,
	chenridong@huawei.com,
	hare@suse.de,
	kch@nvidia.com,
	ming.lei@redhat.com,
	tom.leiming@gmail.com,
	steve@abita.co,
	sean@ashe.io,
	chjohnst@gmail.com,
	neelx@suse.com,
	mproche@gmail.com,
	nick.lange@gmail.com,
	marco.crivellari@suse.com,
	rishil1999@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v15 1/8] scsi: aacraid: use block layer helpers to calculate num of queues
Date: Thu, 21 May 2026 19:29:49 -0400
Message-ID: <20260521232956.553287-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0770.namprd03.prod.outlook.com
 (2603:10b6:408:13a::25) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f718a2-9c0f-4e79-4474-08deb790e2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5yt7/XWmEypaVU9f+E2wHCZMJFsK/4IvlkgxF9RMxu7jmGGe5l8cCYEzavBCuKS5DSxJJ2g1uaAlpxYG9US/gMzC12cj7DwDQ2i1RGkOVid8JWmg5S6lEdefHVBtLTDzEPBiAJHIH1gYTfduGixC4Q68F90Xy9PvzH0NHs+aA327pJBbJazHFiKC8/+5dxgVC2eZxw0SxoqGZsHrx6FxK1mQ2H5h8nFR9yHyJUBIRdVXEU2/w1f5GGYZE1jUS9AmWQyQr7w33KjcocE2pUfpYtzcYp76XNctH1N+luNHKlHb89zmO7r9voK+KD/celROPvoDLt4OAvF0kBUAgzXQNqQaY0wKQwp8rMkSHW8vwfi+TcuwaRmQ9FWPCsfYPPQ1c5n+HPTA6udmxlb1r/lTx3GA6m+ljyWdxxTC5MQgUnn5TEraPUXDhkFXlaGW5s2OtMUysXL6DfLufl3akGECRSGtATlYveV/stXlqTVHrbyjWjA1SOxFDieHN6RDjkkpSOBaARIlOhNpv7pq77l4LaWX1jHSBELQXGfJzRxwRjQUCsUKPBre0Xl4Up5SOoVHNCxcuhtVOUNoSGeq70e4fo0yyPYc57bJOwPxhEqMJY7if8nXdpqgSiv7PA8lBM00/ZG/Ez8VxAgNYX7DtmzHc5enaHInTSrfotKSQQ7gsQxi4yjEDK06qbZE7D32XrIl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J64W8l5fWY7k+hMWTWg9eDVarU2BHUTrW2ZaA8MhkYCIuKOkA86jPDRcvhAa?=
 =?us-ascii?Q?rDQTWnahzNgwLj1qjhuL4fFe9iXEOlzfNTl2yVVMro4y86lCocmyVp1neqZ7?=
 =?us-ascii?Q?Ga6fnLGQfR2yUPZlW4gF7WNZEiRYQDZgV7XC/hBk3RyMpQw4cc7BvMypGRNG?=
 =?us-ascii?Q?liCdK1OpVq30zpVpxLkCq3ntgFgVaeKMdwnfomcnvtTVj+OfVmzx7CC7yNR/?=
 =?us-ascii?Q?bzZGtcogMhdNwo47NzzE4cTZKHt34CE8vlEs/BefTgvAY3m55IFnTwn8MonA?=
 =?us-ascii?Q?1+St8FoyR0b6OQeVoWZ2rdcuBoBieM32bwvhfA+evzosME/soVNSR9Ehot4X?=
 =?us-ascii?Q?V2HSgM1pLZqUlJzW6smFNnZG7v45wdwVmF+APYhFby/u5DioU0JrREp67vt1?=
 =?us-ascii?Q?OwUZrQ+JTE4RFj/yAv3Q5HldcaW9g/PpTKvcxEiXPsb3mtl6MRv2KFJLk9CQ?=
 =?us-ascii?Q?UnKDqtrO1UVvWt3dhmovReXInqaTdvWvBncBeYoIpwvBxRsvRxKNx6cC8kXA?=
 =?us-ascii?Q?nW+QkvATcsQW6CLtCM36vXtyqrrMqtoY9p5/R0+u88YLl0hn2RDjwbl8LuJL?=
 =?us-ascii?Q?1XBLb9QV0mhpfzFTrtEkRqCFrgZBLp4tbTXNpxrR+ye74kGTkE1hC03yNRki?=
 =?us-ascii?Q?4ZKw6iMlRK0YWSW02CZ/6lRwJZrxZXV6DOXgoUak+/YeYMWCInJaUfBqWSWS?=
 =?us-ascii?Q?Y5X/4oou9pSV+n324pKHvJ38AUhmfNm3ZcutixkWwaBT+k7OaJm2AKSyfcfJ?=
 =?us-ascii?Q?4tXzjruDZLRehzxMKfoTC8JN9XwvSOmldr6heMMb0SJ5lBG/UBq+3lD5qkIj?=
 =?us-ascii?Q?Gx0ITjeLegnaH9Ivf3fwwudtBmQgmTffid7o0reOU+XNn4amdSyjPTw6Hnom?=
 =?us-ascii?Q?PAUFf2TDE5U6sN1//nx06mgYY7kHzBH5u1zfa8dl+TSIM1R06THU47cOz3sr?=
 =?us-ascii?Q?pJ4HXOrPRzVVof+lqN4mRywfGA30JOjkmIDf++Jmz8mKo6rEBWkGzCIA+pzD?=
 =?us-ascii?Q?5C2znHjMm6zQGrr7Dox18s/+evHOqO9LdTfvAMxIV18l4uwRQEdJdW9Nur9Z?=
 =?us-ascii?Q?jM5dIkiHIMsZA6KOZqZFhuHUEA9njU9sRS+GhFEu4L3/ojUWXULfp6cCpmbJ?=
 =?us-ascii?Q?lg+8z6ThXgWXOjeX96tvF8m5CusBmJoPWNQpSxJNTsGycgH4U43850rlaXOS?=
 =?us-ascii?Q?QGyvWBUVRhthxgv8ioOl7SUqefGEU9FaBx/xsp6c45Uqe8g+S4ChbYBkBaHN?=
 =?us-ascii?Q?2i2g/nkbhjvCjFjDaBxgCwHhzFh7Dp/icfUZ1yXlN1TrkzV6lBQ+7AkxwMj1?=
 =?us-ascii?Q?eKEVwL1YoueJg8VlfR7vlCdVmicmsrQgx/MSWQdyTMV7tb+VNFmMYrQ/6OLJ?=
 =?us-ascii?Q?5L9X1xK88u/nV7RJpyQOdPDK+R2/uN8NY6fmpLzwUvXCbnFbzvRdFM9mILDG?=
 =?us-ascii?Q?1Bqhuwu7rXabfNdHDK/avQc//Spr0WlZhQFpfnxzjwxKSwRyxa+jPENBrB1z?=
 =?us-ascii?Q?fEzJTFSTwTEh45VsUTrQ+w2fHYG1nLXpLQsRdmVh6McbYF23omYQ/krGbrsz?=
 =?us-ascii?Q?9BQ6H4kcaZcNKzh7P0HDS2EvjO8ts8orQUK70O1eHRbLJPBX/POIbyz6FLMA?=
 =?us-ascii?Q?BQplsOYJa3HT2wIKrSX/gQ9NQa8huhYrW+R3ITibwVGtdcnD0QiU7SYqMboF?=
 =?us-ascii?Q?j3tACD466Fq6BSQ0zunfmclAXYuyroEjZQ1fNei5XOrAwLd4nOTFlT+qL8jJ?=
 =?us-ascii?Q?SNou6xxSRw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f718a2-9c0f-4e79-4474-08deb790e2f4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:30:04.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVgL+2ZWMVAPRHAUFZ/nSuCeKsl0T05jtoiVs9pOhVLexWgctNdglMz0iA+NMQwMptxmM3HC5drOTSgVhQN9vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6796

From: Daniel Wagner <wagi@kernel.org>

The calculation of the upper limit for queues does not depend solely on
the number of online CPUs; for example, the isolcpus kernel
command-line option must also be considered.

To account for this, the block layer provides a helper function to
retrieve the maximum number of queues. Use it to set an appropriate
upper queue number limit.

This patch brings aacraid in line with the API migration initiated for
other SCSI drivers in commit 94970cfb5f10 ("scsi: use block layer
helpers to calculate num of queues").

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
[atomlin: Drop "Fixes:" tag; indicate alignment with other SCSI drivers]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/scsi/aacraid/comminit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 9bd3f5b868bc..ec165b57182d 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -469,8 +469,7 @@ void aac_define_int_mode(struct aac_dev *dev)
 	}
 
 	/* Don't bother allocating more MSI-X vectors than cpus */
-	msi_count = min(dev->max_msix,
-		(unsigned int)num_online_cpus());
+	msi_count = blk_mq_num_online_queues(dev->max_msix);
 
 	dev->max_msix = msi_count;
 
-- 
2.51.0

