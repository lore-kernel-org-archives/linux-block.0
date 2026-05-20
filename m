Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021073.outbound.protection.outlook.com [52.101.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EEE39EF0B;
	Wed, 20 May 2026 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313842; cv=fail; b=jHwRxjI0RnEctr1WmZPYufJ1gRt+PVnvtQWXJGn/uEiJtsJi0rpiEnv9gM+m+9NIdVbhNKixSOmXENrHsUSkuYaaPkRC8Pley7T635mwD/2d6eZm8dUIeJSz3xkXfv4R3z1x40uWXmqkaDCeuvxvBkVOH5cZTeuqpQAvI2//Ftw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313842; c=relaxed/simple;
	bh=jENbK+vrYb6YqS1GYa8XzDXhjvifp1BwR+fmi1nKfLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5Y06MtHJwrf4FCoWANfAsO6N8mEXLGhq+175c4BpO7HrSO+LbcZoUOfbH4spqfpQXDChyzy6BaO6jl6ANdUD1S0cgq0D+f67Z8cZ8TrG5vMnhMUu4xNMaDRR1tHjDFPZpVEHjazYHqyxoH9Hl2hWT0LiTQe6nCJWljBTQSf6wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3NGKMl4xpxOPrdH4rPuyOoB8TluWDv4MEhVpktHqK3xa+UhPgc8dp8ro+gOcGABOQlLOOaFcP4SnTqIuKgedhgqT51on0BftjirziAiWLeJ6LGLDfwQ9oKlNpCCg73Ktl/e/xWfBgCh0G7U+vmeQSTcEKcgSNe46FYF5xfrIOPULJHcjuNUWatRHqKCudtPgFXzHIhSBar4EDdThd9/+TzIe1XRcKUDJWK5d1vFM7LtJCHvZyXBFhBK102W85Q9uLZzSZDrH3TAzkf1DCfeCobndJ+XYvEgW4/Ypp2W2RzghJZASiDDNGUuoVOfJtFDf1FJm0MuRm4vqgNoGR9aLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K43Wuedv+u4rD85xwRtYGV1orY+Mw4iD6rZzvgYkw9E=;
 b=BjwDAI6pV12PpGjaOs1RjsxBx2b7qTibDJT0bEWzC1Qi5wPE/6Iam5QO/20HZz07P5tvttnC6EmlkmugY1SN8RfhxSPqsxFImdat7bnXKxgP5j8I/ESqhZ96Q6g6MBJs979F4+wu5tmphGmJ+1XjwNqfnVAdnz/GYeHJpYVS5au5sdgb/+NW6AafDpvDMRuCAEKmxD9GwNsL340DQIWbgi7ozWP+/1GZoczQQj+u4VwXO6s2DiaxItw0ly4QL5H9Cb6fdFn0mCPqH9cEnBNM0nNzWsKb62/eSuYMIbD8WnzyCgYZ65L0d87zc0XS/ufzv8BTT8GTNI4dL6X6FOSIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6626.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:50:38 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 20 May 2026
 21:50:38 +0000
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
Subject: [PATCH v14 1/8] scsi: aacraid: use block layer helpers to calculate num of queues
Date: Wed, 20 May 2026 17:50:23 -0400
Message-ID: <20260520215030.496803-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520215030.496803-1-atomlin@atomlin.com>
References: <20260520215030.496803-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::7) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4ae548-178e-405b-ac53-08deb6b9d42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uIgzQjNi5zWyIOZK7++kBXyjcAtkQbCpm14TyqXmaZgQ/AxwTg6IcGFKy/gBiOABAUWPkSWic31VJ13D75++LqE/H984XKHZDXAeRjtjDFFw07JB8hfDEdZ3O4AjAbeUJwaET+3uT+oLTtBHXJosB7e1C1aXiTkhcZdu/VvnvBgG50pzrVJYJvDJoRD5cwwjohLkMDPC1J4Pqune9lRqN4ygQDbcJ403V2PL9RliwheJDaDBzSTj1U3QCRJsb9SW307dHvD+L6cpQWzre0xhbQb8fP3OrqpwgLFO+THqndXGBajl7ygSrE+dtVXBZj/WuT57kADxsUIOvKi92UPUunZUMU6KsAGmIcETJGdoTM/uWxdDyyDaQFdY1KhQWyIvNPIjltUz8xK3awsqF4m3DTv3Kur29gR2UTj/uECLCeI4obWDgTG8KE4F3ND9FuSWD4Qg4X4rW2E5XGHQi045SkyI6Hedo2uyaZF9U4QNSjyeOMeFuTTDhIbGsesz+H/ecRYk2mYeSrw7baVXtjSDQdMttMIlx0tPUAT9zuG+LSqYpAgBRaKuzGyoF12lb4YSDZHrZB2Ob/ytg571SD9j/4EJeR0nOwuaJ4z3KUtKDB05q/3yZRyuzO19HlREMN5+bIM/i3CHKojL6zE2k5N3zmSjIhxosGlWPd48whTtf8NKQP0r8EB48arO6/SOIIJv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7faHtdYfKNhu6jjC4dIOkxDGRUry4szKKx6uy2N1I11rw8nECEMS2ERCHWVw?=
 =?us-ascii?Q?5OuMoHiSfg0IiY4XACEsEwWRBuQF2Cm6F50ibfgRtepOSI9nSINoZqrDH9fh?=
 =?us-ascii?Q?rnKaknILdroGHS+S2q5ftBENeJRgX+tL1ffRU9Qcy7objUssKufrHIb9YpWe?=
 =?us-ascii?Q?0gwhcfFIpDlNk3ov6Mufu56ie+vyR07v/xtfBvwXTcxl4V3oKrF20/+i/YpA?=
 =?us-ascii?Q?iyfItvoJ4goBCqy2+uTkw2643zwsWmgXB7IWrQLdu6clLu/wjbzV0OCnFDPK?=
 =?us-ascii?Q?ckhdMoYIJcauxfffQydPZCNsh8CDX8kcERKDs6PNRxsc441WmL39URFegwRQ?=
 =?us-ascii?Q?6KWML5DCAFg3VLok8HEhGb2HMGpJUlOmX1RTrjZFL2Aq7PyB4f8FYVwjUone?=
 =?us-ascii?Q?MTKLu9hV2E1VnFyQ5ucEEFLXTKbm/Y20czg1PRNe29ZIjkiay3G0N9BjXlwm?=
 =?us-ascii?Q?5wcemCBQcMTWRCjdzV0hfk0CEILETukWov3RDlewSh/bdhKKy3X8JED9kGtZ?=
 =?us-ascii?Q?ExF0zGllXEmu6R627lfBtAWC2wP+t0BngKmyr/Z8pB4nNaJC5FNKPsWd18jR?=
 =?us-ascii?Q?oML8ewElp9w94XEg73vX44vY3sY9u7G/GqHXjfhxA04aychJSe1dj+t2kfS/?=
 =?us-ascii?Q?44hXZibPvBn7KygFPj/PV5BU9zIjcQ8OtvT18wAHtsEPI1z/EOt3kOx0NiZ7?=
 =?us-ascii?Q?i353q4Kdwub9gihxj+ewEMJ5tXXKAkDlcGYJdzG4COCw9ePrrwdmjJ4VAc9B?=
 =?us-ascii?Q?0Dkgpa7q0RAaqfKzpx4ruPkuxM1cs/XzdmRvQWlKLjkUZS0aA664R9doYWOE?=
 =?us-ascii?Q?4JitvUEF5hqNOijlhmGsjfiwd0UdXotTJLUPMayhTDP4/RSTns8EfOpMkerS?=
 =?us-ascii?Q?zxifN1v/3MJpulElxLDZBrS9QE4IXZmA9MjIGuGXl8rXa5MWqPm1zyx2xXr7?=
 =?us-ascii?Q?EHW02Po2lnhM1wp67zjsMm5anr6JpzCHvwWcEh5NhvsMvlI780+bcak8qo2D?=
 =?us-ascii?Q?TayAmALUXTVR6tfQB877ckQk5ihZVXWUe56AxyRCfWjUVwaNNNldHk2YcrPz?=
 =?us-ascii?Q?9UL192EiXHUwtV2aU9RCnLRojrs1k072WgqHO2JuIss8+W3wdWWPtxcqThZO?=
 =?us-ascii?Q?VavS2FTpLCZjIRidhLZVM0bqfkRpUDWVEiUVUn0Y+/0M0ofsbxcW8BkqGCRr?=
 =?us-ascii?Q?+UD8B3IWaoKr16hDTZkNlHaMpqFjGwzOdooMPXzWveni0iYxE3HW6lRTz3vN?=
 =?us-ascii?Q?P9DQ2TSJymKRpSLuXtmMqxPyNXYeLru0Qjl+mYqFnAwk0CJe8cj7NX+Rqti4?=
 =?us-ascii?Q?sMTXJyF+gbutVbSD6CyxfJyoAby3v/AkKmRVWqwCT4Ats5sgE3Nn3/dK0xHE?=
 =?us-ascii?Q?RBT7nrLsyd84BdW0w1VqcHSUdRuELP3BRDW8UHeFqPVQnoNiZNNaAuoImON1?=
 =?us-ascii?Q?UfxuwjmH05xW/XxmI0UfLao0Z6QL3iKc8xBz2O6Bv6nYj5cZtZeAelbgQm9f?=
 =?us-ascii?Q?q41YXhkBkurOi3821ucReMFP9Wh4HgiSh+81JuYBhcq8UT3TYwvaF7WwWmi7?=
 =?us-ascii?Q?zLbGGZcft8rbjhgGX/twI4/gzepkiwhh2yMmWXO01D7mtOcr+21r/vNoyPWm?=
 =?us-ascii?Q?ieuouBrFBTG48+pQPpwFT6uB0yIoRpha3kKXXL6pOUEnVhoXfVcEkWPzfnaP?=
 =?us-ascii?Q?Yregd6Bs+3uWPtex0K/02hjwuvlsIwSxvB9M8zJzCM40zt0SAqryqTiRUqdj?=
 =?us-ascii?Q?pB/cdS6qog=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4ae548-178e-405b-ac53-08deb6b9d42e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:50:37.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejf6yx07UJ8OQVSjd2O9ovlGsGI9MGEYfj1GLYvUyeR2thIshtqkyLZ8Qyat16fsXyzIMShxH48cqe6wFx//Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6626

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

