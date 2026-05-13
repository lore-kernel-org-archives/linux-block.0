Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021076.outbound.protection.outlook.com [52.101.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AE29D265;
	Wed, 13 May 2026 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633721; cv=fail; b=Ps3fwQN1C7++38D1RoFm4y2br0+NgwymilKkfxStIQyNGSUaUUukV2Zk89kzXDxeF991bDkZLXAXkTMUYrQdqBclFwNZMCGadJqEuGzgiva3hsqudNP9aqR/Czo4iIxBRWOz4VefeN1vUgXL5Vm5oKAKAATdm99qVhEVhnAKgoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633721; c=relaxed/simple;
	bh=jENbK+vrYb6YqS1GYa8XzDXhjvifp1BwR+fmi1nKfLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=phZFqp0LRMZ73rI5PNG744WcCGdHLjtNhkMU2wq6j8zrQ7JVRkD9fNJn13GYWpFuxN/XsURcvg4wj0yj9xI4JEnPIUMYeemPUcWhP9HvT2aao6NC2wLajIAiPPH+HQNep+jVOoO13sV4Oddz6Tj3lGkafEr0AjlppvRXop5gqQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up3HR9doIHYf6CG2ppp14shVl3yriRqvFADCtSPBbhiWd2dkcvDuuVMNlg7q7SzllBsUwjQFCRPktm57OHy8xuBk+IjnKBMC5sj/EFtwXHETArh+3CNpd/7DuKet1ZfOinoh+s8iyeGOy8X1IVF8zgyIa7Y3KfIWuxX5vanej1NSL2FoBCQ6rgaM6aQ9wDBE87u/eJUmo12ZPD26Sl2HWjD7ebhSzawc7vUGJsh4fKPKLMGm+S5kO6xrNKQOXHsWrtI4uOP4CEOEYIzHgcuTdxcIB1aR6AqF/87zhRL6aX85uiLrD8narsIA1gj2oFThN2aAmVZrz8giDXosujQF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K43Wuedv+u4rD85xwRtYGV1orY+Mw4iD6rZzvgYkw9E=;
 b=aJkkmp65jIRyRBG1FdeRU1hZWBqD/PpK+N2FI1zjPm+XEBWPYb7dM9uCN1gFPYWLXHL820dDUcuss86OzWAj+X9RJaOBBBk/cbUq7MfjuuWjr4uU/otT3pCoJPrYSabrRt+zEXqe7nQfq4qV7lNdsi/7iEeJKXasJXg2kNmjHZ3a3YkxFmLnHw7kDTF+BXXwzVn7L/fZqDFPnlIbNDz16MYCjyZ9a6D+oL1BgZwQuOb2cRFSsq+yD8Q4nYTbpL1ZFraNt12Wpyj8hbEg4wN4KuLpeJZRrHgB8Fg2bpKNCRrdIzPQ5ufzP6J9GbvODyMyjchJzraRbbgh47h3BE/9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 00:55:16 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 00:55:16 +0000
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
Subject: [PATCH v13 1/8] scsi: aacraid: use block layer helpers to calculate num of queues
Date: Tue, 12 May 2026 20:55:02 -0400
Message-ID: <20260513005509.135966-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513005509.135966-1-atomlin@atomlin.com>
References: <20260513005509.135966-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0730.namprd03.prod.outlook.com
 (2603:10b6:408:110::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b49c0f-a4e8-4e6c-3634-08deb08a4c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1s/owUpFL2xe5Wz5zk9Ii4ysHWMyVqNwJLBF3r95figXD449Q2CugGisU1/OSGkxuigUQmCuzba+BFcANDmL/zZHLLnb8gbc7zt7gxSsCpv4ExiJs3p2Pwv5MVFMigalWPd/RxlwbN9mmHqn88GVbVL9C+4HPyiDRXK4IPzykQ4BSqnReieww9KOBN3TCCL47/ynQDJcOEOt7AxZ9PawhEla9d0a23aVtrTHJLFTmW+rwSAQBm7TU48qTxVe6GG5eCyObCs0qILmQ8IfGMSw+aKOky4i+tPS8nrIxF36E/CwEGd6IPHBh0qCP+7FAnlEce7YQ50Y8658qOUlHY/HbrTFoUKoPNXydzaeRsbfq+oVMl+VVnwhrX5TdWBVlrLsCBzTqchuacd8p7AuU+P/vAlpNl7tmqzLChRLjjc0yi9FAEOxHCftsC0YYtX7e8v5DJSn7RbsvhvEQXbU+H7YXnzRfRr+qHmXtFDeCuHOwQP+FxQjprjhnjQf88DQLmdszuQRHBmcAdquBOpYRSdGgdYL9/ZijY/eUYzjZkETkMAioBTf9fDWRM0FS1p31bo88iYZTxYFkbN7jWjySKrRgD6EOaSOofFJS/msB0DRBzDZVu+hzwT+G7/gKATimuvUYKlcqicpSWzro1ast+rnHadsNtrWBTMvjTMD7DEchircuize85EZCNH4lIRVeNmT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLToUANhGFueE5b0izaBYL1A/cZA9wyXGsXWNeNjorE4Ypf2OF+TQrjceeFU?=
 =?us-ascii?Q?NHXj8jVnwVbtvDrpjyBDOAWYOnHzinXpZt0fD5Wsz0QrWzSNeqLEcACBTbK2?=
 =?us-ascii?Q?nqu5wfWt2jFnZlZ/1A4om+wn3wftPA3McVJrzHNtOF084qRDgwAZPl9QUzIp?=
 =?us-ascii?Q?80mAVdtbNItyLha04Ga4hvMGaMTVWRAPJh5JEEJVMZT+mrb9SFKN7fIKZn3r?=
 =?us-ascii?Q?YPASChMDMgZYSpFss7t39R8pFbzTOd2br7IJW1k2nh0ZSqOBqxjoGuULRcrl?=
 =?us-ascii?Q?La+A4oN2BcSwh98LgxHxO/Q1Qih5xPog9Sjs1ZqAWcgJwxEmz6aCFJ4AWcaY?=
 =?us-ascii?Q?XLLyRJpqvb2fCFS5GksiDBeEvFFUZ1/sH7QOMEh6Zp83moSFc8UOSqp03qAa?=
 =?us-ascii?Q?MuhP3wjv5nqSgptLfR7zYuJoFxBMS7rONkwMBXX2xCikngrBY6lipCEyGHIg?=
 =?us-ascii?Q?ezHsZuV09A++6NU+HWSDyklbjNKnW1pyNh2FE6NZ8pbyuCQznsAcoEwu0M13?=
 =?us-ascii?Q?qW3LUFsvHI1lPYizA0suORH/p8B6Ov+6/cR0EsI4Z7L0CeBAzqNqJyx3n/gY?=
 =?us-ascii?Q?H96XUytoNZmTpd5nHRqbQwNIfSVG83+1JsOYNRVfE34sAwJkPzCZHf4dK3UV?=
 =?us-ascii?Q?JDNYeh7sfxK+sqkX8v1gMAZUFAWy0DE51gSO4Eikm4+z1/YXmfUqTcu3cdT1?=
 =?us-ascii?Q?nJLwRr04MWG0x6ropGF5IezncXcxaFwpJzVX6YuQyKR0oeHqdUAXupvc6xtw?=
 =?us-ascii?Q?lMEuwQxMAEr7NMmjBLhUQa/sQYbNoRGR80Hvx2pZyQlGCSjNJpfYDe7A/8+L?=
 =?us-ascii?Q?nRY1NFpTnKVVaX9iYjZBHbrX6G3rS02f4O0b46d9th18A0hKQ47/Qt91ROA8?=
 =?us-ascii?Q?SP8pNDUcOW/Z/vRd8tPAWTXjycicRxtrv/OJv5g37hqj9/W7Y9ay9ESweuQ/?=
 =?us-ascii?Q?oizgI/piwKKmu2Y/JTX09WqIbUxXSOwPqso0DSM84NKEnCEd39qb35xD6IMy?=
 =?us-ascii?Q?Z5qn8SOa1K9YElZhoQtCvLB0/eneDM1we/NcsHzjLuTlPEW6SuLDgGgQefs/?=
 =?us-ascii?Q?TG3gJJ8/EshfQM8/Il1XKt3yD1tY3Me8a9jHXDy9uT/h+2i+Qk44lULccW5u?=
 =?us-ascii?Q?lHJFKYRkzFCMXzNHPY2sFDytxutlMbEtxms3QjK67G8IY0H1c9QyPhf4CVBv?=
 =?us-ascii?Q?pUS72kNgauQfY5gpTwTonqSIrs3zwrSLohhF/51k3gKnZc1BuayZ66TFRuSJ?=
 =?us-ascii?Q?JEyVxPzHt+yT7oORKGnXChNPZw0dXSOa4RsPU5iKIIUmcvLEpcP+hy4vu/W6?=
 =?us-ascii?Q?udiHXRZ02+p0t8yzliX+94kkopBvdv/sk8wdrPvE8M7+R+LjWe0HGybXFMeW?=
 =?us-ascii?Q?AwSXKMfsjA4Y4kOi3AulC04uoet3q+riAoaQWw381rcc7n9RmWcNa6v6BagN?=
 =?us-ascii?Q?nUfz84j/CPHcveT9mk6XbP8IFV7tzeobxCty/GzDZeZqhqM39mXwJAJ+ZkLz?=
 =?us-ascii?Q?NoNMIv1gsbEeSMdjDKcIpNPXXSmCI4QWdXt+oRY11g2mkpwAtpBIvmSR3ql6?=
 =?us-ascii?Q?C637QQc8Hg5Mi3rlH+6Y/Orwm5mfn+2BzR8pDKa2oMtce8Dmed/7P8Ge/qPx?=
 =?us-ascii?Q?HD57YcO3/D74IR3gJZ85t0RW0pua4VJzqXSxMMz9LN0j4p8UV332BWVWiTaP?=
 =?us-ascii?Q?oxyzYsTiZTj3tuOE0Tn+etqlAvKRH9cUWjZK5HENi2dY6ODFltELmBt4gEL2?=
 =?us-ascii?Q?mkuT0twryw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b49c0f-a4e8-4e6c-3634-08deb08a4c2d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 00:55:16.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0is52D1pf/1qbblfHf1DjNOywOx/FeUq3kCBa3NzPzwDy9JmhGb2AXWei0CEzq90npeTDEwC4KlDeTCEgHeXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4226

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

