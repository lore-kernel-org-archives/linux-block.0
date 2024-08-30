Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010068.outbound.protection.outlook.com [52.101.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E81531C3
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005964; cv=fail; b=BaD0pJ5PZiTrsBNhrpsYLQDAb0cKAxhsLlnkF1gQT+8iHpGXcxkTbHsmoz/j9FFhoYyiUTcoqmNziXsHplARtDqfTID1DJLPRTmXtTA8GUStv8pl3gEcbkq6KmHjXtQbtgNH3oRvLrH1Y9y2QqSJF5dLzJVQ5m1VEjcAODcvO14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005964; c=relaxed/simple;
	bh=2BM6V3Re7VVbWERWNsJp3+pVooqoIfUswe/rSBVjxUg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=piElveH/2yBqD93C95IgY9V9Db57f4clRD9BMXd/KBRGzB6/tS7NtEGQysEUZl63rqhAeRS61FG7JUUNjgX0jnWPIi39sIiX4CjpwrgcjhcMCSBBx3zrUrJpW8sFfnh8iKhvCMywGQAtHnzdiJ0/Q3cLPDAyEcJ291YShBLUcHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=DyKsr0Fe; arc=fail smtp.client-ip=52.101.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="DyKsr0Fe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LECj7XttqwuU6nITwg3pjMhpzV1NdXZIUT1Bg5527fSLy3ti712TU2zUmQPd+SyS6avuP2uMS9szRf3/rrzpu8kWL1x+BbBxBmMYNmRRuXC4mSemqmkvt9Xv/B2l7wJiQrYl6dlX7TfvlFh6xOUuET43jSWAtI8o+XnxSSLsRjPczFqXpsgFxD35hbztMwpau/yk1q6sQ9jucrFClHY4urWnW3sTq/5BbQa7dd1YrR2LmNio2+lElRK4ssc2gUzPjnIK6vC9uaN5ImTpDvFQnSYzXKwkVo2xYR2pahtR2vabDZZJa9AqD+VDTDFFB0IdARW8I98vvWLoaVnudqlOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmCRlCE15wEQQnA+xdePGI7BQ4SMimrsiDyyD+cF2bM=;
 b=IUp3sQbQPQB28DrDKQXJQl11nnzX1+mUOZDANMFJCo/+w6WxjSUl/gYE4HkgCqJGlGXCVgSc3c7D63Sfdhe4GeU+oslYygeXvlRh9LIny5ut4tpJCFhrRKpqV4QLGVMK7XBDin6QLKg1fuCIgAKNtJoyT+qtnzwPFi6pEDX3eFOOkGwtTK5+16DTXHma1ORwBtyczC47e2ksU3g7CloAoi35u8T82DWSPlWpCWM3+Ugkri7Oi1JFQMDu/AJJw1+kpUfWod3v10e2KPs57/wr0/ctz8qMHcaWCgUwkirziLP76ZUt3uv3Utrtu7CToVjLnDDXBHESeIrLWIDHZr6xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmCRlCE15wEQQnA+xdePGI7BQ4SMimrsiDyyD+cF2bM=;
 b=DyKsr0Fe3D+RIXxsFacr8pAyEEAtkRBcke+yEj19BDJxr2RtblEy7JwDZRY+c+A8MeySn0kwCi/4ZvOwTHCkouV4AOMWarlCbQVJ1ePVPyKOclMPDrhomaTaU9x01PU5mkywxvhT21fUb1BHRzDWp0B1QvCxfMpl+RsNSVZtt/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
 by SEZPR02MB7037.apcprd02.prod.outlook.com (2603:1096:101:19b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 08:19:18 +0000
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9]) by PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9%6]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 08:19:18 +0000
From: Yongpeng Yang <yangyongpeng1@oppo.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [PATCH] block: eliminate unnecessary flush requests for bio with flush&fua
Date: Fri, 30 Aug 2024 16:18:54 +0800
Message-Id: <20240830081854.487023-1-yangyongpeng1@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To PSAPR02MB4727.apcprd02.prod.outlook.com
 (2603:1096:301:90::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4727:EE_|SEZPR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: fffb6a66-bef1-4c8c-5aac-08dcc8cc713b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WsU/iV/Tei2lyY9swqKM259zacl6LLs8QvU5nf2Vm67mGjp+Q2DSPmncoCLv?=
 =?us-ascii?Q?YZ9jbJg+vNUo/UM2nCFp9Zi02rGYTa3hNUDF/eYfN1oAm7eZVS9uSyMDey15?=
 =?us-ascii?Q?I+nnX2Aer+ktoqpdT+g3fQkMh2rUYnac7z8ie+ZpOlravBszweOTLj97vRRp?=
 =?us-ascii?Q?+Iz6bCigPW8+aGsyAeNuXy2vrvnoOUbu6/8782XTrTyztvOXCiUH+FhAV9ho?=
 =?us-ascii?Q?mqnnFUjFyi0/LgOR2CfSsmLlJE4iIR1D2IHsPPMWKT3uZLS2IvHWt5HDyjy3?=
 =?us-ascii?Q?6BRCWB9fXs7+n/mKrORNGFjwaMB0DhjKTmXwTOODHWl5PKDB7QISoKspFNrP?=
 =?us-ascii?Q?kJCOXYi2EQCgbb5wBLd9pILZXkqV9+63/lWE7UWB7ZJWcqloQXv+aWB17toC?=
 =?us-ascii?Q?cCe4OwI+GM8iX4iRgNB1gF62JrRi3lBiHzP7UqEFZnWmF3BUt+aTWsUcblxp?=
 =?us-ascii?Q?+6fI0h5rzcVvJ1g/b2scp75lKGeFeTAyJN+a7CpLMZAxs0R+qK+JkZSz4ys5?=
 =?us-ascii?Q?VldBfMb2XgFPsBC17Zd5QXRbiwh2n6r6ozVtfX4YnToTMPeDpXy7CXOXReBz?=
 =?us-ascii?Q?Q3aJi1eNjyfWWbtgDmzy4G7Vn+I0fg3Dx130NgSFHz5FFVokD8DvbFwkUdx9?=
 =?us-ascii?Q?V37MPE7w9+TlRbv0JMxTkEga9a15Bmp5Y0aYdM7vYK9dWqTc8NScaG1eiPZc?=
 =?us-ascii?Q?kvhrpTIKqGZrHvgEPSPkFSMBYeDZCqcDCbQwbn6slhiDlUsyQAGyA5ugOzO0?=
 =?us-ascii?Q?9W5U4jwxvIQ8gFOQN03qGyB1pPq1ff3xYt0fCAfXeqJ1SsJQdaZ1wE6OHu5T?=
 =?us-ascii?Q?dtBLXmqJJDfKrPvNdVYCICJYVhckzfo5HBJZqeLYDreZPTI3srmC0YJeiZug?=
 =?us-ascii?Q?nsly1SZHFoxSj9wUNlf9rc33fzUyDurkx7XfgAB9+RIoTEMNugDI/ip1vyI2?=
 =?us-ascii?Q?ksZBr4Wd8h1jmhyK3bcQgRozuJKaFjiIa8hLBniXgBBq1HK++cFVMIgM06zD?=
 =?us-ascii?Q?JbmXLgeElNm3KpYD67Xyhdgz/DsFwFyqLfzhn5uiPBm1OKZzp8XOoa3VRMpt?=
 =?us-ascii?Q?K4i38mhHwJnMjxs+xMve5Vpp7b/tFZiYKy/AEjRe+QBLB/img91hZtsMhYot?=
 =?us-ascii?Q?AIK+22/+jds+en2Sih7gmbwbdChrffiyn/gzU0KJFpoxfZ0CUcTUTlhIWija?=
 =?us-ascii?Q?vNcCNaKqLGU6RhLVknskAYhHuYyk0/riam8qwWzuMj2zaXJ99RrxwhwzSj/T?=
 =?us-ascii?Q?vtJiPnjuudrueLzUXizW5cAigN1nv/Uk/n4qmdy6jXngk6b6Hq+onJ3mlXcu?=
 =?us-ascii?Q?8wT9hjq+nezMXNyD64pAgVJXspS9dDCR15iGO8v1B9cpbnETFzDtDoM2rOdq?=
 =?us-ascii?Q?zrYaEJ38TLibuQo+L5feomu04L/Un6MXcH67dU82fB6pKFA54A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4727.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1cVIyyQtqTadf3DHOPVqmHHRmJJIrujnzRacFi1vbn8QgEHCl6c+SDyvAPkP?=
 =?us-ascii?Q?Mg5VzkuqIDAbrHzOa7pxFZlRAoDu4vrPuP5fWQJVvdJv2Bnt9CTXLg9T03kH?=
 =?us-ascii?Q?MGHLTMeqXB//aOe8lCoCopvxH5RJrnPwVrOS08IkjskQIN4NiVYe+gd0xi4V?=
 =?us-ascii?Q?vjd0mqFS9MAB/3jiRF0zRZU8D5a3QTIignKCNQqhDXzY3wMj485Veb+vRHwF?=
 =?us-ascii?Q?MBa4VCqhx8S8sccKBrfmavCCUws2VlaU3FTPxb5FmqW+Q34hpChfU4yhXmsQ?=
 =?us-ascii?Q?mfo6HsbjsXj1rDxfTxck/q7Q3NMpANejvJvSz5EsvMa7MrtzHtjDkv+1ZBZT?=
 =?us-ascii?Q?dChUJl4CaDQm5Bhm2u9L99BQHMTMmNnvms8w/JOkVBKBdVcoTD3iQYyYS4TT?=
 =?us-ascii?Q?9BQKU2/2ncO7lE7zjLfZGUtjiCnuzLFPFnhQRESLlhFH2I0nFqR21fPUWe20?=
 =?us-ascii?Q?InGHYq4zy+rZam6uTjYlFNHWczY7T/huPsUs2AzDPI+E+F549DvPmi/yYhEe?=
 =?us-ascii?Q?HoQnfK3noeIfcJFapV1xyyllFN51+Z/5h0CBJ16lCaR9WLT0czS4PN40pqqE?=
 =?us-ascii?Q?Tyy/XYEgi/zgfpweXHzVbKUbABKwBI1A350oEiFMDt0QLzNtPK5hKtBvbnen?=
 =?us-ascii?Q?kt+GjX+DUMFhcosKDaNFSNsOYe2mbdNRDZBH84Pl9Pot5aqGuviPZX0UNCz/?=
 =?us-ascii?Q?t9tddHs+ZHhVQuG/4Pf9AE3MfIv0ByY4UeHptmZo0jOay2fQunjFPtqBm0Jb?=
 =?us-ascii?Q?fcOlb4gSbb9OXwvq0E2/y8WmEdnDL1NnCUMxC/ey1fBq+KjxAmA9Avl8+KKV?=
 =?us-ascii?Q?zvyA5TqePhe1BA7FGyiFd4wlZ8VEkpOBAnE989s29ixv4d8EwyaH7AVGHRnr?=
 =?us-ascii?Q?JgzK1HLVSPb1uOSftZAe5qrQwWInSno+MSTzh7mK2BA2dEYr08gKWGAA/yTV?=
 =?us-ascii?Q?bfJtbkcL84cdMpNOakbxbHVZy99rvdtkflag9aWl1kNh2FZAtJ3MXVd8DAC4?=
 =?us-ascii?Q?9UfLatKGFU99SVYFGezSg0P+gNsx//Yc6r2qwkf1yvJFe3sUUBqKf7bmsLQu?=
 =?us-ascii?Q?7uUAVXhTr3/U7CJYjN+WyryS3cEr4zHRyLr+RTb3VeQgjDfeQsz5NI5UUefq?=
 =?us-ascii?Q?DugBxz1tCr5HoKZ7W9z3TBExf55ktj8D00sMOKyWvY7zYNoxf9Khx+ikCHQz?=
 =?us-ascii?Q?O3VGMGUkOg/+eijnqtRkxgMIe/4p7T5uFTzefHCcgqOFzpEokdShCLSYvhGb?=
 =?us-ascii?Q?lQFhLBasSdlUaLBsEU44qQ7HEpDiJHkuCfB7WtcwVnNvjDcbxn2MJA+6DoV+?=
 =?us-ascii?Q?zIQtmrZFRqbWqC19O6w1WNXkJuV9bElgmYzIofzEHfUSEdFYt4UHYK0EtLfY?=
 =?us-ascii?Q?8FEqNWfVqxZUVc/mDqjpOcy2lezF3dHWsUTF8/pPMihAIXMlZFMMjevupMoE?=
 =?us-ascii?Q?awWudJzPUkRgfNB+6afQxFHfRDkCIemM6hld8Nr5kMNeaCdz/XmY3LqOKCPY?=
 =?us-ascii?Q?khgANLWGUEp4NuGVEw9ghk042Y9lht/FsbqKvRN4qvW5wWkU7LAVcgVZmDk6?=
 =?us-ascii?Q?jKswTTxl4Qj8kI/Yj5I0UHgkLCacV+Ms8wAoHqD7ya8UdFxWT4qXfLO4/TXW?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffb6a66-bef1-4c8c-5aac-08dcc8cc713b
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4727.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:19:18.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luhRJbaOW89iK314auXWexsmnDNGoJtz/hxe2L5RPPEugVFTXy8oHYgYbbLqxbMiSNbyQAV7+N/snKaw8wZqtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7037

The write bio is configured as follows:
	bio->bi_iter.bi_size = 4096,
	bio->bi_opf |= (REQ_SYNC | REQ_PREFLUSH | REQ_FUA),
	bio->bi_bdev: dm-0(dm-linear) with 1 slave device /dev/sda.
submit_bio(bio), device-mapper will:
	Step 1. submit empty bio with (REQ_SYNC | REQ_PREFLUSH
		| REQ_FUA) flag to /dev/sda.
	Step 2. submit bio with (REQ_SYNC | REQ_FUA) flag to
		/dev/sda.
The blk_insert_flush function will trigger sending a flush request
to /dev/sda twice if the request queue does not support FUA. The
second flush request is unnecessary.

Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
---
 block/blk-flush.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index a72e2a83d075..606a6a5ae089 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -445,6 +445,9 @@ bool blk_insert_flush(struct request *rq)
 		fq->flush_data_in_flight++;
 		spin_unlock_irq(&fq->mq_flush_lock);
 		return false;
+	case REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH:
+		policy &= ~REQ_FSEQ_POSTFLUSH;
+		fallthrough;
 	default:
 		/*
 		 * Mark the request as part of a flush sequence and submit it
-- 
2.40.1

