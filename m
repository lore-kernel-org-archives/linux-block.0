Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF92066EF
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493110; cv=fail; b=KhD5x4DJL1qM7OAAdi5YG18EoN5JKl6KyEokmHmbd0RUBkdHYprnJUM0rkHkuEK0zn8WPITEzc7bFIxlPKv+fkglbTXPcAdPZa2j6lqxBU0NbDJrtrFACyY4mY8+hq2NulzwfJTV+AYm+wlMZ6F+DH7lnaCBLaI6xDQ7sAGO0Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493110; c=relaxed/simple;
	bh=1JOd/x/aDadrYYziLjHOn2KCIfL5HLe7o29cLuDEH0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3uH/6y0BVLfoFgsysjl/8znsLv/SAU0U1Pno8y04dVal8FtoY6u/PepT7FEUDX7TMqFBmegr0lVoM3mlGrBBkkQoUDi1HGXy81S4AW272sbtqfgLxZ6ctaFEVeWhWKhaJFNAWbYxsWdbImMU129kthA1BAszmYAcN25gee1z6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R1oW4dqY; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R1oW4dqY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+q8QnfTJ1bVFZlTuY3AWQvNQDGFLO2FhateE9kc+1M0P/gTlHU10iNyfpNL7YKyFXZZ1b1Pcomf/FlMRKA1upyA4nP4tgjfRuOeAEraNNa+QEep+I7Msf1+DWBw2Cg+wMO4A5XUe5nVw7lRutJivUGdD/CovPZil+XeeC2rfyN6RX0u9/O6bW9pWMP4nsBdvB6DYiTBITrnNrK+SUTD45866Zi6uUkTEJnJMYgnxSouienICY+DvMJpMFBlXzeMAfYwiDcWT8roNPDdTJQ8khR/4LLHTqfpoLgIUsdIYO4vSV6R8/6Re0X0iEUjYx8g58Fa6Ei78iKITPI32DJ0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWrpe0Ht8Q8bpi1euIyx2QHlyQezYqmxlxxliBoiDco=;
 b=NgH1qZiZlol93c0Pj/dqI6+ZeXaR5c5y0LxAhWtJPGbzpRneiIqnHTktdLlw9qdQ8nFBI4nYBPkWj/UTAaJr7LM//1NTA1csc8okwPyX1MlqGkRlqCKuXoeycBTYqt6joTnIYYxVPPvgx5RScOiGapKu14W+9ARiBepuLzhDGhvIqT+P97TzGSqcYsfI3vpe9vNOCyMP3nhbX8ZVLcsk2c6tllQLTZe7sCjGm1c1BYQ9hEjgqJEVCUtVFY9bTSaofbkv65gQ1iMzJPQozjlzP6hQ7gyTD/+nB6LmLjJJ52Dy2XILeLrno0Ch6KAxSBPg2+C4q4K3KY6G5FM8cUlT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWrpe0Ht8Q8bpi1euIyx2QHlyQezYqmxlxxliBoiDco=;
 b=R1oW4dqYpClgc2oO2QAxs4+JC9GmDRoHdgZobZGMp0XzXBCpcJExUIKf/UvAUEBtWXKiHQsY/15SsxoOkjmkb01fyyT9MR9khaQeMbA77zE30dj+tcr7WfASYwJEY0DRwRdM9PXjLoIauRyX+QduFlUU+LLxYRYGb4tmZo5POlJUa30YfIQA7HPaI9dJwUt2QPjArJq+lXOAG9UqcUhlw8Kh3Vb6TfE/mrX3IPX/Q9I91gmOvup+U7RnFPJkCRVfw21rJWa9bTKuNrIWFB9q6s7cVkkkiUJnjO42agL9tSlTV+ncfaKiSkwoBH1FO47aMGaH4gJMmg32AquOmVws6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 6 Dec
 2024 13:51:44 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:51:44 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 2/5] common/nvme: add digest options to __nvme_connect_subsys()
Date: Fri,  6 Dec 2024 15:51:17 +0200
Message-Id: <20241206135120.5141-3-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206135120.5141-1-aaptel@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::9) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd31ca4-8d39-4c59-1200-08dd15fd1eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qdTsohrKDtyOAjbMk7rs5aKILixjIllpvM3G+7xV0cU7/JNgpXac61VacGyY?=
 =?us-ascii?Q?79dvL41MmQoBnCRtxAuBez1yG6JFKmPJYTvcFypm+8mgiqnqepy5gassMbHa?=
 =?us-ascii?Q?6id1RtL6ELxl0qwioFQiqhWAkwngzLC/DMdFV1lkxdO40Gao3DM8h4hhplSm?=
 =?us-ascii?Q?JYocvtK5Mk/ivVSAjDfrTn1jbPgaiijb5lCjB25ms7cvhblYl4SxnuVE5FFJ?=
 =?us-ascii?Q?nl9zdrV5WYYTQnbZLP7SkyrQKa3IRSekVk5zigtBWYS5wY3npqHkH9IINhsK?=
 =?us-ascii?Q?oxRfdRLAD3r+CCktPSywkgeeDAlV+h2j3g7Ri5NF7sBOA/oNkSUaN4uC+alv?=
 =?us-ascii?Q?1UAObSXrk9w1Ca3eTkwuEfJZHE48j8+jZgMFiNIXYeWjZHCsNiai4HkqnKSD?=
 =?us-ascii?Q?JZSOjYVK4PjC8HM+jMvpJozbYJcPXDyQMRjmN9sIp51Zikyo/TaRpPYXm2De?=
 =?us-ascii?Q?XuHOxPvww6vRIr9yKCIEBaGTx1VQUS1ctZuw+/1R//h7TDWZAle12PuCLK+Z?=
 =?us-ascii?Q?y5I+CD3clSQO/uH5aJbYRkxtjb31tlf1Jkjtb7b0qoC/Q7BqwGTKDbIlYGPP?=
 =?us-ascii?Q?FAk6yKnDRQmr4ThxeO9gFA05bpjK1U0rFItEi+R1i42jRdMBQ/ZHm0F9+PS2?=
 =?us-ascii?Q?mCxVrz2mLoRtqsiCr7Bki2x5lxzr+PD6MtHVhMjBmkEkGAo7ogXIGDbxyGJB?=
 =?us-ascii?Q?OXw6nseZIXhPQtBOHYRPXAwD2tx6+c8c1SOkIawejkJVD0k/znY4IWyeNkT/?=
 =?us-ascii?Q?u1Sq+y3+xCJkirVoD6x3HO7tgAIK028ZcIFpXqUA82xH+0Ye2Ei6crOQ/jQM?=
 =?us-ascii?Q?O5WD9eFzOUEwRAy7PCZEYHt3zmJ7DWfm9hcRoIEClnjPQdmRwfqQVOqMTqas?=
 =?us-ascii?Q?upEmOYZPCsaZcrUS5r64tPxwm6SxLUG0W4JaOTG+D2eNZTnS3a6F5gEuya7l?=
 =?us-ascii?Q?TDuQXVrCoHZdfZneoBX2GcXHiYagBImsHZGMGhAs2mkLWA+Zxqudoyvga+Je?=
 =?us-ascii?Q?359edhUXISVkdVtWa5wS1/SALKjBXJHmg4iOqPCdS+GvBGCr/0mGRcHnGEF0?=
 =?us-ascii?Q?t3ulprWMP3XFaIG90A5v9mlb4fDZ/winmfAFDYbXQjDNbTXDkPXUE1JSKMHx?=
 =?us-ascii?Q?nwU24HFln20KqGL7kfjmrUd5otXfy2b+LrN+k9UhEyPN7P+0kUZe8zNIZLXa?=
 =?us-ascii?Q?Quqo+f9+AB39G+bsY0PKHekPmpDuvUm7JDt/9z/0/k63rbu1DcFbPzRnJVTk?=
 =?us-ascii?Q?F+47jHru7OUcOIAbXOUzrwihZS+C92XiLbMd9Q6OtzZrdBNj6lkX3M7rFaMH?=
 =?us-ascii?Q?pdAg5CyITQcwokfilqF1nfk1NOnvfqPyrSVEF24d0VhTuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSjdHKQWi7zQt+HcDzo0W6sQKrGA52bk2FKGe5U7LLPKUwYugRwWsDU5Tmi9?=
 =?us-ascii?Q?bEUDMzY1V7GvaM3oeQL0M4Lq1GH3XiKOYkMB2ECQX2lcvIy0EhEMmqLGmRJX?=
 =?us-ascii?Q?uxI3Xik2ZEZmPAhi6T4qkeId3tuEmA1h4i+Aw1fSY1SD4ezOCnDb7nTEEwvJ?=
 =?us-ascii?Q?e1D49ErYJo1/xLiRcLxqFYptrzpLo0VEVMn80YEBNVaAEu3o48vo1ddh10sT?=
 =?us-ascii?Q?OabadxCBAmcJ6AOdey83Rd+6ZTMwfFTM9bST7QcebmNZtJ599Er9KMbBkR8r?=
 =?us-ascii?Q?VB+Wz+o8mAAWNkVGk/s6WdYpcb0nc2T++82hpU6kKdXAqlE3fK9z5+GQ+jVT?=
 =?us-ascii?Q?DBqzAdr9y2/Yw+g6+GPMPYSTt4ZEL3YifspplBo083xo1pti6IX3mQlrbukt?=
 =?us-ascii?Q?ZS10ntfESb+1rcHlEibiX+BUO9zka4WijH/eyP5jT8n2Cwq6Evzbd2HFPLSE?=
 =?us-ascii?Q?TyG3NlONMnhP7Zjdxl3yEbTBWFXh/JBkKs8XtRlWhc9Z5un/uXlrRCpjvKx7?=
 =?us-ascii?Q?ZtebY7gpUQU1znbGSoiT1iSTdO2j1wTH8APHpwIUsRK0xR6gJmQ8Ch+4atZi?=
 =?us-ascii?Q?hrgttb3dmDoF8zWB0KcNVhYZ1JVTduKyUql/lfiQBIy4fkM0TNPvXaaDBvHO?=
 =?us-ascii?Q?rVH0JMaKa1pieaunITf7QTBLILvn+1fZ+gdoj1CAt3RaNbBWWcqp3eQfq+Qg?=
 =?us-ascii?Q?JyJOvXR1xdMnRWqldgtLSCzmReAroCzn/W0/p/1zicQTe6KIP/aowrpFI/W2?=
 =?us-ascii?Q?OhddrtqPCRWJcTHwFzorl3cnk6DPzQApsYem7vMjg+O2EKzFbogeaeqftCLT?=
 =?us-ascii?Q?E1rFjfOXdbtAc/DiRa9d0O4d+RAfgU4troDYWhHY3B9HxuCEiTC8UCIyXZiZ?=
 =?us-ascii?Q?GZHKx30xCIM/mZ2l09v5ag8BqZw7UuD0n5IJvYm76nisf1Kt2XjkbKISPMK1?=
 =?us-ascii?Q?vJZgcHXxEr1WHeL3u+t55QAdrQM0ATz0N6GV/PdIc06ojhLeIzSkOjJ+Z34S?=
 =?us-ascii?Q?EXLMHkYIF1gtg2/l79XwTLdfq9ZOvoPenS4I9tDoRsOlXliFI/pf45TLko5P?=
 =?us-ascii?Q?RGNq2v1SBoE8Gc2L7356V8vqTAWrV5b+nNChFXtIwgvVwqRtOf4HDbzxMmTj?=
 =?us-ascii?Q?IBfHFTdi0MVfwQ8w85HstO5CKbsFQ7fjrM1babMVC+epA71hclbctO9uRglR?=
 =?us-ascii?Q?EM2redge7Kbe+vCXJR/RGSsNkYxAggEEF1W0uOvqfFx+1Q1slwnQdyM85xfU?=
 =?us-ascii?Q?Grq/DB6EWqKlBKTkKye4ap9T7+NCpvCz9UtQnXr0W1zdSHER7PLKq6jneFzS?=
 =?us-ascii?Q?xsIwfQPJ6NL7Y2LVLht/n+6ylFbaaJAko0zoOOtgAuFz/tk5dOCQueeF6Gth?=
 =?us-ascii?Q?UBlPBDEiu+yKzmi7Ac5a9RsmwH7VP574efFHnc3rdaIDbV7FPcGX04aDi+Ax?=
 =?us-ascii?Q?R557YpTpPTl1b16dkgrrWchQ6hEwbBYLenLL1tR1KRZLzhjIDyIO540Ob9zV?=
 =?us-ascii?Q?4WnQuDPjZ6GMRl2lwnBntvoujBYOfmLuV/FZJvfo4YSKw+f2pYyvdNOCXay5?=
 =?us-ascii?Q?ULIUrHUN7rXgmuEY7vIir/JNunTmTjkw/Tpe/UVP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd31ca4-8d39-4c59-1200-08dd15fd1eb9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:51:44.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OaxBS7LIkwa16ZKMNdDMTeuumkjQTz4o9duJpU+9RhOAk8wwbn0h44EEh214EQ54y1BCiEc+rSnBrGmz7KN6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

This commit lets tests connect nvme subsystems with data and header
digest.

Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 common/nvme | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/nvme b/common/nvme
index 887da4d..d909d42 100644
--- a/common/nvme
+++ b/common/nvme
@@ -271,6 +271,8 @@ _nvme_connect_subsys() {
 	local reconnect_delay=""
 	local ctrl_loss_tmo=""
 	local no_wait=false
+	local hdr_digest=false
+	local data_digest=false
 	local port
 	local i
 	local -a ARGS
@@ -329,6 +331,14 @@ _nvme_connect_subsys() {
 				no_wait=true
 				shift 1
 				;;
+			--hdr-digest)
+				hdr_digest=true
+				shift 1
+				;;
+			--data-digest)
+				data_digest=true
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -380,6 +390,12 @@ _nvme_connect_subsys() {
 	if [[ -n "${ctrl_loss_tmo}" ]]; then
 		ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
 	fi
+	if [[ ${hdr_digest} = true ]]; then
+		ARGS+=(--hdr-digest)
+	fi
+	if [[ ${data_digest} = true ]]; then
+		ARGS+=(--data-digest)
+	fi
 	ARGS+=(-o json)
 	connect=$(nvme connect "${ARGS[@]}" 2> /dev/null)
 
-- 
2.34.1

