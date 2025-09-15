Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BEA2FC037
	for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932520; cv=fail; b=UoMAvYHWpN6d4xbyELWsInZxdWx4Lxoez9wEjttUPIKKwH830IF9NDAijADtHOhHqwRPc+cgtFt+IHkyLg7m9vUFprM5QIpjuMo3MLRDfUp2QCUKMuz3nau0iOxwFckErEjXvZHeoT/uFLFGeqW+btn1bOlsLOyREohu9UgX8pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932520; c=relaxed/simple;
	bh=SYVXq6q3bR3Du6NLvk9KPtmz3HjqtEaFfNF5pgw6zSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+UyfBMxTDHtufIPbAOZF5VFiDUyS6hBjKtRWR3NWrDaSuxosxkZGM4g2OGmf7r0UCsbrjSpm2NaGDdys2GS5RvsCJvTvw1yxZnDJTrET+Fy/18icKcqTSgySBBiUVlDUXvqdanU+2KrLE5MUKM2JyZmUdHbTyf2MJhc7m02ODM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QGSsv3cx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EeL55Kp3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QGSsv3cx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EeL55Kp3"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6fpFq023188;
	Mon, 15 Sep 2025 10:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NELmpGpCHBEEoMV0tzPUxUczk1RopVk+sIV18UVZNCA=; b=
	QGSsv3cxyKKXyfhvLzUnz7j/yfOe1/LTRNIBjEQ4TP9FQOrd3740TSMKtvb53nNv
	sk800IDw98/PwWQworoOYL6nIWz269qospoksCbxvsf8VjOWqkUig2zHjPvhFQfp
	KsK9D0DdZE71/0+foA1AqZxpW677JzCj4+ZVXIlZHg/jcSbxQ3KJ0G4lhJM73ybG
	dzdMBdhTW1YVVQX5gcUOLsxL5dHcQ+BlRu9vm9norIrOYG3pTJhWhakf0gmrHanA
	wC0JtSo2Bmf33i2Puq4YYbzaqOprf1ASox4Z3Jo6CCqVUd7RQxc5OpTUknu1XHf1
	SK+SMtHqvcdfFn2PzgP1aw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w22ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:35:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9DCEh019137;
	Mon, 15 Sep 2025 10:35:15 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012025.outbound.protection.outlook.com [40.107.200.25])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b37u0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUHfenq5qxN3qLPKJGsg5MaQQs/bpSP6QAVAIHOsyFVqWu88JbVyMx6qLBN7I+74l12XnDNlUC3JHjJzOP2XcEPaTBZQ+HWKe4fNS2plupMYyQEprKNS6eXZ1yUbCUMiFB4k+jOOliW1MBV+Z9DsLrZg5QjMCkG2bUJkDsPVIjPPRMnoYx2OFENV6+W5lHIWE7SyQjsWBAGACdWqA2yAUvjkjJx5gzvprhXR77/HI/E+gNl48Arp+Wf8LIpDum7MjPPjKlimdbn7hwjRJiEkLmfpWacKL76+s7qK47/ljZ44wt/IutkxAG7swnQFvyw4Rp/W6ODjMJRUKX7BN9/5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NELmpGpCHBEEoMV0tzPUxUczk1RopVk+sIV18UVZNCA=;
 b=btYTKqFwVdh+toE4SAggi36qzUHkcoPaLQg5/z+/GVONXNE4DIPtJU2/z2QmcC2bzQm6QGd48cZzPRsU1apk03ZpdXTJfSfWT9Sz4LkAKlmCviV461v2Dw9eLf3XoN/ziS3JQ79sQtn5JCff0x+paEHdXTTh3448/UhLOBiTBL6WdKW9xbxEyOvB2xs8r0tIHf5zi/6lT6B9EYhswlWJ5p/hPKXxPyJdIKlrIuZfpkm/Iw+4lbAsoDaFgcNTwcBjXCCo3Iyq4fsFBE3wmrnduq4me7nkis0/rVeF0V612RAzoePSCikexHVpBsXSUevuGf0zzjHw+gPcB/P2wDDBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NELmpGpCHBEEoMV0tzPUxUczk1RopVk+sIV18UVZNCA=;
 b=EeL55Kp3uFxwblRwNybHmk2uBzN+M0xbp5/tzIsoBEhPVgwwHUOXGvM4SQVXqzGRlXABSQgbGFevfAuOSdW05QnbsMplftqZV4WOuMBds/HcXKOqwprrXQAazrWQCfbc5pXqInXKdNdIEjf5I7TjRu+peQsjhc2I/Wc30n5R24M=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:35:13 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:35:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nilay@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/3] block: update validation of atomic writes boundary for stacked devices
Date: Mon, 15 Sep 2025 10:34:58 +0000
Message-ID: <20250915103500.3335748-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250915103500.3335748-1-john.g.garry@oracle.com>
References: <20250915103500.3335748-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:510:339::28) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY5PR10MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f68d4d-a006-4313-6ab7-08ddf4438dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zd7uqa1E3T11IjyMr4iK2F3u23BTcVV4b+l1TrzDiIPoLfvFj3MkPXeNIgV9?=
 =?us-ascii?Q?olGko3cSoacCgeHw51iPK/FQmXtqPJn513rVJRQKAp5uW7ji8BVlTlkTQuwR?=
 =?us-ascii?Q?TWTeKvmE10hJ3xMJ2WxXQGDi4pxCgz9bjWi5mZpTzLBLIxIi7kEgeSkjdCCu?=
 =?us-ascii?Q?vtLOP5EpxfgKQIIE8qcLV8zbGB2Jhw0A7R2UZkLcdP5+H0LjNHhqBtJ9rmX9?=
 =?us-ascii?Q?FnxSlPRTqiRaGFK6CmZq1w/Ef3zKFPN7bEQqfVTLiJMv6dG1JEqdmfGdcxdN?=
 =?us-ascii?Q?KwqqLHwe9r4j6mnqTpL6sKNTS+bCCMvjkeHpl9ZLAM9+1SCYarWoChvs7npw?=
 =?us-ascii?Q?CUTUGmDdgVCtqSac57o0wEqU7gIMe3KL4N4WhucUysKe5J/UtRNthn+3yp35?=
 =?us-ascii?Q?a84nA/t4yH+/M9QcbpFILZjmegMI63KdutIGs+ynJLE+veJjuhLnXYaGTnLT?=
 =?us-ascii?Q?heL5I07ptsOnq992/E9s5zlMAeXqRf4FPaRhDFjfKwl6HbgBzXc+CNB/h3sc?=
 =?us-ascii?Q?/FZqj7L+oup6+xaFneTayR1qleDaUwAVsjggnLND3dtTU22VvhlnfPOIJkFB?=
 =?us-ascii?Q?ihCGLgqmJdzpnis5OoemKjlHFrjJ3SWfreR7KZbxb8w/p05U7WBw6PMKUaYo?=
 =?us-ascii?Q?te3sw+Oau/5EiuPjR+P7gTBs87WLkpCYqoYRraAjOHRAaGw93haDUjtSOL22?=
 =?us-ascii?Q?/B2nUMZ2hPVGexNRt9HVwxuIljIZx1QX1sL0qgfuaX/JOv/tp0ElFlzrpOiP?=
 =?us-ascii?Q?Yi/uWKXCkey0ZlaxDCSxofxwd9zfM0SZYoT6OGOVJ05YRgQ6ZEZEo71qQd9M?=
 =?us-ascii?Q?NmSssuioUULcYrwqoT6bP579Rf4g4h5DLYLnD4nc5HNbfqCVuVrI9LzuIes1?=
 =?us-ascii?Q?GHDG4cWnG2uB91g9hGEpoLZ7goseNAclJYP4UuXeBqFs2cxsm7k2cieEraxl?=
 =?us-ascii?Q?z1mhWbDXpQqbhRje4SYQkPzxf/zMt19g0jC1cNsX5XV0XpdnJSp9/gPEPq1F?=
 =?us-ascii?Q?UUuD4iHbldIZTYZTBWKc9Y40iDx5mrl60HoLtHpBtJha52P5V8IvTS5euoDv?=
 =?us-ascii?Q?xNyPSwh1FfDW+CyWEaEYb+ltFOne5KN2zxXgGsuHxt1RHVnOfFLcpt5ZIxBJ?=
 =?us-ascii?Q?EYMT4pGB/Yl3wAknkEOiJvkaqUh5PgilKlDx4DXSt3PvxsX/trPngKd5fUUV?=
 =?us-ascii?Q?sGzCd3VzhISHTxnnnk+d5lZ2guOyCluqCFgah1n9coRe7chQ1NGuRTRlFOGN?=
 =?us-ascii?Q?v+Dqtyr48y6WQgNYs7at5bM+ouAnRdIqKp3ZzStnQykkwqXy+3RAWaNd4Lny?=
 =?us-ascii?Q?VHaNX//VzkDXod6EAjIif7N+tH8vD+9Va/mJ8HLxzV27Ky2Ohsuafts0BEPU?=
 =?us-ascii?Q?TtPHFQDlph/28HTlTCWIKv7Ewx7BxqMJP2Q5CszkpN8I7x0tFdahq049xxzy?=
 =?us-ascii?Q?GLtLGCHnilI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VFt9r4cdfFPEJMIA+7/wpCTSYHRNwzJl4e4O734U1Cw00wLM6tVW28k/tIC4?=
 =?us-ascii?Q?Oq9lqupaaOGc6qzspDweriEfvPq8typtrmiZcwSZKiVpSlw4DvpX9GupCG23?=
 =?us-ascii?Q?9B2q821Yg++FRf+A9jZ+ILocA6SfvE8bV6ho/voyMNkvwyKtt0gfja5Oa6Y0?=
 =?us-ascii?Q?8rZjIqARxVmrIWgzFv1YnksD/hTgn268oaduONROvdbpS6vOmT9sA8oTyGYC?=
 =?us-ascii?Q?TKCJs84o/lJaPFLUjH5xW20w8NNmuDVUScSdfhVPcQLKtnJv65aec7HRFwM0?=
 =?us-ascii?Q?qvtwf9NhNnF6bfeR+AKa7V40NczSye9/9ctLEZ8H2Kbsa2tzCbZUhde+X1PU?=
 =?us-ascii?Q?qVkgnEwaoGQc/ShpHQQKJS2JhCfbQu7r2oKVKIOO0rvEhBcdiz6oJf4ousNN?=
 =?us-ascii?Q?ETQKfaszXJe/TykDjy/QQI8nf4aYHGLLsVLall4Li7EbM8gR+SH6I0EgGepU?=
 =?us-ascii?Q?LGW3T+1Bxu0dHExehkV6EoGltVJtmLki8TzaRfRZsdd3115yC8wmW9ZWOTy6?=
 =?us-ascii?Q?+u37GgxdjxE9qsw0+AFr4cB20mPF+bMZgaSKadqwu2Eckb8OLi9S86W1bEKA?=
 =?us-ascii?Q?Lg/XNh887SYj4mlYmWm94nSkI0UvNcVf6M9gGm1aFWEsThCcZ7YD2Uwt+NTs?=
 =?us-ascii?Q?MsjyM18B6rF7tKchxYTYRi58g3FTaNoBh1BgcAhx9qRmJNaKJsgspb+VerOz?=
 =?us-ascii?Q?JNwDrV7j72kI7XUihwmp65XmDmtsFJU5XIgiTEbZ+KNk4P6q7umwIglNr2SG?=
 =?us-ascii?Q?4N1BbEpJQuuOZPZirg/j6jUJjaSGiJHwdoBiGajMDjrxIVVZspgiiYtrhjse?=
 =?us-ascii?Q?/BX5aE8E7Knu35pla+SAUYyfKpV6IitgtKR7wsaQ9VYTGvcpZFIzQ+jKCyWc?=
 =?us-ascii?Q?XIONiLeuDU/70ph3CbPNIqHrVq47AKRWznfy2/ZvmWvjIXScGlxQVF7hgGJs?=
 =?us-ascii?Q?gVQcJ6DGl8bI+m4AmGAhJ0aSQh8G6tmSn7MNz4Rt7QSREDml9heIu0R4sz7O?=
 =?us-ascii?Q?iRSEmyLrdVfT31yU/WVe6fLd60sMqBU34Nbu/ZDD1xlpUFbqS4yo8aQhY7Lp?=
 =?us-ascii?Q?4npwNYw3Z6jCgkrFt5C/8Y+ofEVZjQZxPTUkTSRziHA9iOkT7RiFFUo0SRci?=
 =?us-ascii?Q?hrnmtV2ODvnrhaAIqCRMKFwrtql8iAkWokK2HxsJiatUZz79HQ1f1o+BLLoc?=
 =?us-ascii?Q?A6Hkrk9GJMzpFxjPpWcA+4WOXU9s6tlG41VQytGiJw+uxrB4gWXNpLjtof3j?=
 =?us-ascii?Q?9/A6kCxZ2TJVH8htqSZiBk5GGvPy2mf+k0S78FpMv84vz19Zyx8LkrNXawF2?=
 =?us-ascii?Q?Xuw9rQaNCsz4Moh++wZPGAKQAGdCvsNZydCDWACIEpLLpCuRys1veIqu7T5a?=
 =?us-ascii?Q?J1NsrUFDmpdJvk7PfNU84Uri+eN/fyVD8ZrxVSDlr93VG2B0vHDuSBP/TkTH?=
 =?us-ascii?Q?8cud+eO+kq3ZGsrxfx/y05agRQTyk/iNZndBMReMzRwSaP16c4CcZ7l7S7zg?=
 =?us-ascii?Q?DsvYvmhnQA0UGUYCvTJGWjfQSkiarweCLcl998TPuO0JCBATDXxPM2gz6+ro?=
 =?us-ascii?Q?86HPvFPU4CSuugfBcMvAgggLjTSTN6R75hNbJLhHbaP9+4QK/GlN75ISJTlK?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jPBKwOaSxlCEux6U1gCU21mw7tZ34UV/7tLQryrggK5P9h9BsEI5hMMute04A8/BdhCVHQME+53yfJlJZgkV2zbyLkg6FXVeR5wS7Gy2e6CNp4PbAvj02eabaJwgb80zng9Ct7T3dSymVc8GV1YlP5dRoEOqSPkES1sLRxvQ6ajlDhkd2l401T5h+75wERubkSmw4unQNG9QASuqTk62GvXAAxroxJqWcP9Yufhveu0XH3imYEBk99HGhQFKNVkPmRO2N1YhMNzjW/Y/cQM9Li7mQmFpk3mwI8zlUBWRDXONjRfgF03y2fy6ytAbWdK5F13XCOvhOS/FhCh4Ej9Xk14FmMQRZRimJGL1MiKBLmtGSMZrhz5OaEsiws8AXN85rWY46xnSaV9s7RjP2IuFEGbT4ywSzAHiQ85z1xCLqbLfERsp7qf8LxywI/yHaWT8opjNWfTw7v/0T47hdTqAuaoqUJ3evXsUuQVnmD5mmS6+JXfmc6YoVCiqX8nRr+r7DqCaNByMoSwpwbazlmhghOt5mPgTbL2LybrbN5nX+zD7vdqGK3Ds1RHYV8hJp6KSLDfytJ9DnK1DNPbW15N1gcLYIgFcYSL6dVZ/YWsVxjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f68d4d-a006-4313-6ab7-08ddf4438dbb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:35:13.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZADBB5OYXSgZNVlUXG9b7pYZdU9LNCQanoSFzB/ki9YRmt6Cqk/6v8tRwQ2CmTNY3M4Abs9B+gRRGQZwfxEU9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX0vBxmbpr35Rt
 4doULkW8HMmaYEM8tRITOqhJph9fUDTaHHEzRYTWO0AD6/PNYmBbp4KCp1lCrHmJO+yfK70MpQI
 WHRojDLLG7klLVgy3ol0ldjx9GjTANfgYqTnpguzW/wZXNldIfzuO4sjJ+Y2hbg9Laht8cOBsKG
 JO+kiwMdXDhTDtppjpSRFAShMt6cIS5zwbAXTOtvCQj4tlC8u9U9ePvJ4k0nxXJBaQbR8rNAZfV
 zXOavH56MjAmKgyCcrzvqPc9cYMcs/+GYLGuShZIr1qhOKoYsMmZiZlhGShitwvi/oAmvWCiSBU
 A3f6evewc9iJ89bOkOMk3HPFdVpH5891VyQsG4wihQFfvC3VldNmlSx7PcWDLekPwtkt9fiV34G
 1+TazBOk
X-Proofpoint-ORIG-GUID: IsZj-iMmj-sEH63Tv70HgaaUQyDW2oGL
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c7ebe4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=de_1I1UatPEbKzJSOAIA:9
X-Proofpoint-GUID: IsZj-iMmj-sEH63Tv70HgaaUQyDW2oGL

In commit 63d092d1c1b1 ("block: use chunk_sectors when evaluating stacked
atomic write limits"), it was missed to use a chunk sectors limit check
in blk_stack_atomic_writes_boundary_head(), so update that function to
do the proper check.

Fixes: 63d092d1c1b1 ("block: use chunk_sectors when evaluating stacked atomic write limits")
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 693bc8d20acf3..6760dbf130b24 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -643,18 +643,24 @@ static bool blk_stack_atomic_writes_tail(struct queue_limits *t,
 static bool blk_stack_atomic_writes_boundary_head(struct queue_limits *t,
 				struct queue_limits *b)
 {
+	unsigned int boundary_sectors;
+
+	if (!b->atomic_write_hw_boundary || !t->chunk_sectors)
+		return true;
+
+	boundary_sectors = b->atomic_write_hw_boundary >> SECTOR_SHIFT;
+
 	/*
 	 * Ensure atomic write boundary is aligned with chunk sectors. Stacked
-	 * devices store chunk sectors in t->io_min.
+	 * devices store any stripe size in t->chunk_sectors.
 	 */
-	if (b->atomic_write_hw_boundary > t->io_min &&
-	    b->atomic_write_hw_boundary % t->io_min)
+	if (boundary_sectors > t->chunk_sectors &&
+	    boundary_sectors % t->chunk_sectors)
 		return false;
-	if (t->io_min > b->atomic_write_hw_boundary &&
-	    t->io_min % b->atomic_write_hw_boundary)
+	if (t->chunk_sectors > boundary_sectors &&
+	    t->chunk_sectors % boundary_sectors)
 		return false;
 
-	t->atomic_write_hw_boundary = b->atomic_write_hw_boundary;
 	return true;
 }
 
@@ -695,13 +701,13 @@ static void blk_stack_atomic_writes_chunk_sectors(struct queue_limits *t)
 static bool blk_stack_atomic_writes_head(struct queue_limits *t,
 				struct queue_limits *b)
 {
-	if (b->atomic_write_hw_boundary &&
-	    !blk_stack_atomic_writes_boundary_head(t, b))
+	if (!blk_stack_atomic_writes_boundary_head(t, b))
 		return false;
 
 	t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
 	t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
 	t->atomic_write_hw_max = b->atomic_write_hw_max;
+	t->atomic_write_hw_boundary = b->atomic_write_hw_boundary;
 	return true;
 }
 
-- 
2.43.5

