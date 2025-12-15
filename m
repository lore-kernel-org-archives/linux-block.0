Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C7314B93;
	Mon, 15 Dec 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793904; cv=fail; b=pJjnQ2B0Few+mBmkP3R8jY17CeTAfKdiy5RsgeHvrmgJnvacHY7rCxwIj4gXpfhM7hSXs6eFyawQIABT0l/xPbw5PJIpEnNHpQLVg3p5Q4jlI68US6aW+Z9zIY76IBXZwr7h3H7vpiLtcKxrWpS9v5jLY0rryID/GaHela5jB+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793904; c=relaxed/simple;
	bh=yWi5onDJLbqqA6YjLErhbUUxR4m9EHmz/yLFaOzE1wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tmel1k5owv4YJjs/ZHe17NSNz07AwQKRXEAmu6C+/u0CvwYKi1DQtFuKPh/5Vo6g5yLAXybMK04LFw95QK9OjXxmCQImMK7CsMqDWvr9H00qjLGBNIydP1ogreiUBa29hkXOsUACNoBa6SOBc9XEuiadWpFYwsEprwkaSmRD5tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cbtYqlaH; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cbtYqlaH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOsj6GIGjrMNA+0pAIQ6I5Cq0RBVOl9n4nZQYtDur7co64y2uLvr+A3f0x08iulNZuinQHj1BRhYYeQb3u0cBepoAotJOWFmS/nibA9Kbk+TW2R87ErBqpIg7U3lz23CcfoWg97q3hGpv9jqVHdBLcsKANOJAxwSg1DaMTxAWM9Ckh+t4EdfU2pTHT+OE4wp3QkGzwcP1Pp+p0AruBq6q1ariBgvPuyRZ9dvUOmyS0QKb3v3v49521TnTJlTsY53JPdvpUnskzqKUZNSgdTXgOxVf36bdxGTOm+1s4H4hqpdR5VNzeUp7PUwS0YQn+V35fVKBKaK5NE2kNxcHvDlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTrs2GIB53dnHh9yIO+gk2N1iWymj91uPg/b/hUtM+I=;
 b=MnDHRCJW7PCponxBgBw1ntSju1jJLaFT7h9ftdpa2MhjUuGDt1Hm3gWxtXFeSP3ICknKY6j0kPfphgXIyBYS5/p4NNT2L/MuZ49s6G9jATUXCADbmxP2Hh5MiXIfmRcwsx5fejJBTkAfWl741OGLxXzHotBGNG2BS9KpfVFNBHdNDh/ZqH5Nb7lVOHy1WgalKDDACrAgmWC5RKA6t0si5KnrpbuFlBqr14DqWKVrVZGpZD1JLjkBdbNMByyHaa7HFgziHyJ/N5s8sGdgESD+syo8AFCbMqHYxe+eznSs2yDVHphEV6Bff/g3Yr99fO+6lq+zUTXbl+lYT0e8Pxmx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTrs2GIB53dnHh9yIO+gk2N1iWymj91uPg/b/hUtM+I=;
 b=cbtYqlaH5R4zrjx4tVYJHrb9d0PDNA1OZi38Ln8DjbT7BY+Iy+NdEWm2uL4UoPLUwrQrat4dP/Lg1tkUVL7zWLv+9zTuz18dbxKKElVA57M34s2DmpKoJpGP5giLr9Y3k8L6Eu4G5FrgP/caErsdDGjI8WPUdSJ8524v9Pi+O48/WZVe4wJJcRjZDLMT8RED+tv4lH4I2MrNgSW/hnhL2J/GYjh0SyQTCfVBvhUOy1wWLbtwXMkmDeMWvXFHvZKoTzgWSFRDq/Pp59OHvUODXAsj4+EGqyj3OmA6HTT1KWQjRVTkrWvrfd/1YCxLX8odDRP7vuar7cV8n/xDotpW/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:18:17 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 10:18:17 +0000
From: ziniu.wang_1@nxp.com
To: axboe@kernel.dk,
	ulf.hansson@linaro.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 0/2] Optimize secure erase performance for certain Kingston eMMC devices
Date: Mon, 15 Dec 2025 18:20:08 +0800
Message-Id: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::19) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PA4PR04MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: e21477ce-525c-4018-1667-08de3bc3436f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ty3RLdZsjtS+VlzdFEqHehA3pMnsNUasku4NSDLQT4dIq+ZGmmQGvAh0g88x?=
 =?us-ascii?Q?V/YfXdgzmeELp4XYqMxPZoriBKEWBSlzsyhVKt/Q1F73C8IWvY61WEjSCOqQ?=
 =?us-ascii?Q?1kUxQr1cNx2UXMue0u2vtTRK9w4791XDbM0NasadBm+rTuMi3QHctrlOl9cr?=
 =?us-ascii?Q?I9YWmi+498euPNBdVUKQRxt4b+nKc7a+aBeBCPytAtF1ahgUirF8rKsOx5pU?=
 =?us-ascii?Q?3tpEfBYw19a2fj9ZExlIk4XKOyU+eEODsLhrX1mzNUjrGCvdtU0pXfYx2r+1?=
 =?us-ascii?Q?NV62h4Vqm2802dckQqrvAiuLIfs530LidU35LjEzHRFcVws4cNyqMBFGBhu7?=
 =?us-ascii?Q?UCwukOp6wKokc0ObeZGbNvL62wpW2Hp2r/ivLb8y0LWNYX7mhsxJMAhZ3wSV?=
 =?us-ascii?Q?XJT5beyNi8wZC+idjeyCXXlrk4lRKQn5c33i8uHoRGgPVihQIICOlZZvdOhs?=
 =?us-ascii?Q?PUCaj/SrZ1xHqRNOF6UNQ+qvh74GinovJDRBAOPMTfLrwWtSLj2lWQPhJSGV?=
 =?us-ascii?Q?SLNK/ctsRdl8DEfWOsoEMJ72MqHso7xAfeztSMJF+imabE6ZHig4tP4hwrVd?=
 =?us-ascii?Q?RIllTrA2FfK6nE05L+Z/4UYe4bqBChddTPBwrZE291sXjsth3+g8VHVb8NJx?=
 =?us-ascii?Q?N6R40Ogp2UwEY/2OleSc+1Nj9h9AjHd03qyLOMbJcSMcjZ5S9sq0Hl2YVTNV?=
 =?us-ascii?Q?T0Smi3H9evMUFsjJYcENMm0HR9eLlO5ryNHxg7A0Md7hN8QPfgIk+UvWxHp9?=
 =?us-ascii?Q?02l75aHRZQJ20kar4Vxgh2JNficQ6O6KFEm7NWCNqQBOiNrNAzj/DmZuT8rs?=
 =?us-ascii?Q?Y3yz3ze/GMKBwCUfntuG0XXa2p8iGCPJOa3wwb6fhPSm8yaZMmuGtzTnhGOH?=
 =?us-ascii?Q?BGKVij8mtmqUIX3aiuo7LaVVICr1WlYWv6aIq/N9oUsoVb65KsLm+lpdyxRj?=
 =?us-ascii?Q?0I+KEhfTcP7jMopjDGM/myc55JUsaaXKzAlbWd49QObWtsoVkhbQyx6WrBTU?=
 =?us-ascii?Q?QAKHMWC1eGNMfxun/3/cgZZ0c+18y8ZhKbsupn2A1yiCCIp7IOS7dglszUM7?=
 =?us-ascii?Q?pJ9gxYL1DG8YGPa8JhsuGqbfp5iEg5ea3Ic43/louXRHL3Uzl/96vqxz+HpB?=
 =?us-ascii?Q?s984TbmL3GwAjt3GT+ffdOMGt91JuD0AxoVc+8dDNHN5y9dlNbulAZAUT/kh?=
 =?us-ascii?Q?VOAeztDCaUcfIVWfxtP85xEAkT4S594F2R4IhmH9n+QWi4TAOS8hsDjv7V9b?=
 =?us-ascii?Q?9Qa3vS9lMUynzqEtrs3DrcnygEivlhvGiaL5007XKEvX3RPZ8uZlZZuDONLI?=
 =?us-ascii?Q?8MDZE9+CnVvz/rhruko9tj6TUP5JlsDr3TDPL87O7nPeZgkCOxJQhGe+yX74?=
 =?us-ascii?Q?gsNtlI8lWgvFeIeCzDgzCDn3XqGfhyy1lyXmVnMlF+jEWUgwrtfKKqCu/FBw?=
 =?us-ascii?Q?WiyYx50RptwyNZE+auC0MC99q42X7Ge0lpcq7rKNuDxSOw4OkGjgnXMdnVmV?=
 =?us-ascii?Q?i9HDN6VjT4Jg2XUluzUz+WkSokZC0fGRpu+U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HuBwbq8sihOvyfE4FRHh1xvykGk6kFBKZ2bZEGagz0Q/lzMxAG7BrlEhz7Vt?=
 =?us-ascii?Q?jExgqFn93dkj0Z1J4jcLCXC6vQ/1kD8ccDtVxPHiL6BtFyt47RykHsy/vHMJ?=
 =?us-ascii?Q?OKe8G46lCCoIZAVz+nD84ZFwzJU3osoXDcebn4okn/MbFNmTTypYY+BS4A0U?=
 =?us-ascii?Q?OwPsjvJkRgzJ9Mfjny2gql5S6sNeBFUly+XAeE/hxgUUTOiYx2qPoVlP9JWU?=
 =?us-ascii?Q?NyEByu8Zs/GAEYQ6C0S9PPr4Lcq/2EQQLxG0N4lnuXqYcmUYXndMrdqyZovk?=
 =?us-ascii?Q?6+N4HypMlFTywik1Swha8xw+yGNBc36EHP2PO0+uQdFn+ydghJVvMk06G19y?=
 =?us-ascii?Q?qTZ1r6OibqaoiEMfZiMG7EHANuAfElzWwRwTMjoLY0KxCS74+3Jbl5ovv5WV?=
 =?us-ascii?Q?cD6mcQPzSdM/KRWr507rNQE3BpsULIDA7f9LXscWTUz1ouPKcditK6wafa5f?=
 =?us-ascii?Q?b3iSr5O/zuCy0fIiaswU0OpcbSrTsEPSjoZ2ZZRpJEgvB/7X/Jhy9Va2XbhH?=
 =?us-ascii?Q?6q1QAifVKHt0KmHT5ahTqurCrATi4ij4J534Pf7uTTakjJUtvJMnYu4VoFCq?=
 =?us-ascii?Q?hIoBYn+zrbz9pS54FJ1Pbs6ANFIliyTTMzB2W47YKHcqxMNNQhyiJMMRNb5n?=
 =?us-ascii?Q?KULkH3hRJW4rZNxec4HNIJAmX/vd/A+wReOziq8+ejqxeW2+ZS4yEHDFOxYE?=
 =?us-ascii?Q?m+M9pDLYDGnTQxRxyWj8tSG4WmHUSD/Y13pQgNPqWdV6sOmvjFMAYQxW+RyV?=
 =?us-ascii?Q?3nNj6oN7VKljZ7OpNrwqmd702buDmlsfyge96Vc0smsseJk0EclEHtrhiH8U?=
 =?us-ascii?Q?g+TxIXoCUyhMIrSteMDk4z3Lj+w7benu1LcD4Q4TAITjffi6Z5iXtqrKTrKv?=
 =?us-ascii?Q?L9RALypxG2nxxVahO1v/kAKLavkZcNt4QiQ3g+9dF5k+SKGp3BlBlrxNwGl4?=
 =?us-ascii?Q?ySmQLy/eGYvqtQGZMD8+sM1UC3OpXApJLpz38f4nmd5ECLqYJpHl1c1SY+PP?=
 =?us-ascii?Q?lIymnxz/4JYajPoGpjxUVTyFt8hb+DQJKs2GkCqIDGcrgc79wI8UOT+G91XF?=
 =?us-ascii?Q?MKnfExUNo6wHirl2Ohrh7W4XVO6WAK1o2ploiU0yISMzCHCHHryJVu9xEo53?=
 =?us-ascii?Q?77I9g6JzeLqLJHux6cpr620Bif3tahBWK+wozXHabDxjuqjCVolYm39TrZs4?=
 =?us-ascii?Q?2Cds8REg3A/vkkmMDD0CQNQ3y5Sv6IN5WWtxRNFLsjcQS+9ixRwti1+bpbxq?=
 =?us-ascii?Q?K/alOpA2P35yP2NMXaIZeIxDG1P/6i/fhbL7icob1IlQaFH4qcaQpCF6dghI?=
 =?us-ascii?Q?Ycc+FeBMwid+4O5Kwva2DMtMC/vtR65qpfhjMZV05CToIjZtXAOfQbgEdEmP?=
 =?us-ascii?Q?j9t515lNKjqmp/PsiubVUoAzUG8/GCFZbtNEPzCtiEzr6QP20PWufpj+c8Vv?=
 =?us-ascii?Q?8RHPEtPDU1y1Tn/qCGynrusEkWxAUTvA1/dYHnzXmHiWL/Wlt02nl0IPInZ+?=
 =?us-ascii?Q?Tq+HMMb7+jCYm0jrEzFWZ4MRGBWJXNCtxUyg32IM5jhBKTVxQJNxD4FTbrdN?=
 =?us-ascii?Q?uxfolXua1VbKvuH7E9Cwna6jeghq49buSn6ecvh7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21477ce-525c-4018-1667-08de3bc3436f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:18:17.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGNz1vg4jFGFvZnUMywp2IlnplXF5Zak87LaSoGCF20/2I7nE6K0PFwmBFbT+YnzJjnf0807LILD+/x2li34zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438

From: Luke Wang <ziniu.wang_1@nxp.com>

This patch series optimize secure erase performance for certain Kingston
eMMC devices (IY2964 and IB2932) that take a fixed ~2 seconds per secure
erase operation regardless of size.

Currently, a 1GB secure erase requires ~300 operations (limited by max
discard size), taking ~10 minutes. With these changes, the same secure
erase completes in a single operation, reducing time to just 2 seconds.

---
Changes in v2:
- Rebased on v6.19-rc1 as requested
- Cover letter: terminology fix (command -> operation)
---

Luke Wang (2):
  block: decouple secure erase size limit from discard size limit
  mmc: add quirk to optimize certain Kingston eMMC secure erase/trim
    performance

 block/blk-merge.c         | 9 +++++++--
 block/blk.h               | 6 +++++-
 drivers/mmc/core/card.h   | 5 +++++
 drivers/mmc/core/queue.c  | 9 +++++++--
 drivers/mmc/core/quirks.h | 9 +++++++++
 include/linux/mmc/card.h  | 1 +
 6 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.34.1

