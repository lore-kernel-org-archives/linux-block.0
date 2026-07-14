Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E791441021
	for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022253; cv=fail; b=KfWIxO5nLtonOIJjS91Wo9urtrmRpAJWvm5M4VaCkQ8qncE6M7QS6HJbjWqiUDZpoV2Qs7yLJC4O8axYKwsq5Pt4k5X+LnuxDs543NzPtpfvGy3mLAndVCuMBDEvMlGzZ/I5xjM9Gk2k5GGvLrZ1JE473G+SVS1+LdZniGHOHmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022253; c=relaxed/simple;
	bh=qCHyXDM16aQdwK7zRRAY6rrCadBj4oeL86Ls0tDkico=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ho1xp3o78n/DASo3VeC5vlfxqIHNatTMi0UW8B+GzcDwd2r7dt83iT6Os4awFclGvUdKJakf5HOtw6IRaRmU6fLr5qNrCRjcDxHtcb8EynGODQRd+5FOr0lnTaI6Ige79Yru8g5wlKWWBuiITvVAd7axL5XpetqVmpzfu4scLJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bMQVUtgF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O/ahKKMJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bMQVUtgF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O/ahKKMJ"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DN4DlW2553080;
	Tue, 14 Jul 2026 09:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=7xKGr/HrwpYJNxli
	Z4WDv5T/5R5FHrdex2mPd3AcaYs=; b=bMQVUtgFEFhHMLZTneCCUFohSAk+lpTQ
	TWprQnYBCv5gTrBRXMCcjWQ1rmlrl0scny0Rvvlo6eKIS1TaVQPaNiu4eguydOYb
	JiW/GJyT/ZGafuHcnFyCppnPJ8hI5KOgdskGMX8LtsKvBn0JTij7L/WNQPxrsQJs
	vh4yq+dVsYGu1gpuR2czDY/fQbXpgFv7D8SP+Tj8rYyySX1KgLpsm3kcu1RlIwIp
	5Y0StH3raDmGS8gpKFJQJhJd7zaD68Qwc3T6omtIIqvh1RA5fvutYCnKPUQAYxHf
	WlYFzJup8vqR4oO+X+JUokgA9kWSig40qNnKISojXVp12e2ll2+bdg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef0us6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 09:43:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E9hAZ0023050;
	Tue, 14 Jul 2026 09:43:58 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9dyvpn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 09:43:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APtsorkr+JrI7WFN667KQtfkoFCCP0io0J8SUFxwjJoLE9FIyulYvcoAn+aflg4QR+FUw0ieUHnt48l5ngDa9nXcEn33Yo16ITzAUd7487k2HFubM8kE71gKL6X2AQJJx0UG9P52xsm7Oe0JfUiXhlheZyKomg3M0DlGxwVMzb5P/61yGeYF66G5h01lOGrRNaWIiTqt51BOqafTdU+V+MYc5HQ0P+3MX1Sxzzou4EQqPGB5wSel3RN0xBaJCcMulwlBqE3DWf/SjLlm0OVxAED52AzFip13WRIuCgzIinvMNz/LqS1paTWOMk+gajFFVNj6kbpr5WnvZdWN46d5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xKGr/HrwpYJNxliZ4WDv5T/5R5FHrdex2mPd3AcaYs=;
 b=I4yWC9ThVwkrnFUELhtQIG9+kPFluUbn4nkmdAmZ+LNJ90Qxz0qy0TD2AONfcOAIHo3u05Uubtol40PZSYUrqyaTfKujhXxp4anFRmrQblPalD4HiqVzJhbtibNdP8EcGcRNOUsiXez5uvrLiMY1ogYjG8yM+XaN+6jp/G6VvxUTC5p+F9GjjUiW5Gip93Kuhxv7lLwlFu3Gcib7QXdW70v4azCX2fjtrXwrqhhXIqsjVkLQNfFQr1QcoI5le7QPbZcrCD6Xhv9WitUgYZNoXusCe/L8EOBkDV8sKyKLBK3YwcUX0ENUgVmukdRX4cuOeDoNUFWl7B7vISp+7LPqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xKGr/HrwpYJNxliZ4WDv5T/5R5FHrdex2mPd3AcaYs=;
 b=O/ahKKMJbNtt9kX8SRToAknMwpcfMfd7PSBxhE+TY/mulUdCN6S+Av6OHqHdnPmyh8jXUcd3e4pVSRYzen/3Kr2jFLysEC3vtH2koWVFQBA75oHxkFRV7CkUT1fL9Dj0S9b/ujxXUK2dNVxUvSOdWVe1Fu1I2FBucZcgz4gzy5o=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SJ0PR10MB4431.namprd10.prod.outlook.com (2603:10b6:a03:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 09:43:54 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 09:43:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Cc: hch@lst.de, linux-nvme@lists.infradead.org,
        John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests] nvme/069: add a test for multipath cdev lifetime
Date: Tue, 14 Jul 2026 09:43:45 +0000
Message-ID: <20260714094345.3370884-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::27) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SJ0PR10MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be362d5-6b5c-453f-f252-08dee18c6b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zv75oqFGLkXnK3u3KxT6d/ZdLBjEKe5qQxdOdCehQl77jnFRV0+MAk0/Xb+xHUMsBANmOYGXaC28evVNjdu/DU1iYgF4M1AIutN/WSezK0jLWeN6Bb0Lr3Lmqu324Dtw/UcCfTs3RdLIIXPJHj/7CY8CiCmQo0SbWuPfeURU8AZ9BQNkbOxpHuzNRYzcOuWhUXRMiP6QVW3vIczXGIjicFX0cs0XeDcaiiAn1olYLyD6r0jVl4bJQ4Tfqlm7bZkik338J12Zls/ToZDExbxFm6d0KjgMRZ8qpvMZzEATH0OYl/WNBAvkMcdQp7w/bm4oFUydzd+dZy6AJdSsZRnNoAQkkRI28oZIe2UDcRd+VOj0spYM4HyWbiJhdOvAqm/cijXuvY9ll/3O3chMn8N0S17ly8W2TiX45EbahmGW1hewe6nnlyUaTFv8MiEVN0z1IU3BAdZ+ramuGpf88F7qjhb7b8Q+XqOhX/48ciw7ku8TVqBJoqu0umUFJFs5x0/6MExLFfhbu1UOTH167drN+zsiI+xikpKOJJWeYn598qZfrQcl7RKAmBXDGae8iTIG45W3nK39YnpeRoG9iFScMZOZC1Q56NB4tGx7WHjTZ46qlNlXjfRNKbimP8FbgUdn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPVwqCF4zVAsO46gtUxX+yz/dSGxeEYqVBQsMcFJOeYxsZXFT5HpE8eiHumk?=
 =?us-ascii?Q?Nlv5Vjd1LbzAROwFma7RPsAXLJWHjZ3IYysuJGSgdbfixqIxCs0OR3Wk6UB4?=
 =?us-ascii?Q?XVbma9IB5SEHOIZO0kyrVOFBGLvhwge4z+bvx5P1iVP03JQdnuuB3kc6Q67K?=
 =?us-ascii?Q?J4k9yaQVkx4Ll4EJ/NQh8gOcEWu8sM/8/2JXGyDwXYaHXtLQyk/9pYT5iScm?=
 =?us-ascii?Q?9AaFqgeXyFtm8Pp12czGwBP9WoMlIVspvc74vnlMxjM6mkDrHygmoHSk6Thg?=
 =?us-ascii?Q?86ZBxaoIXd65LD/WBob6jo4rWysL3xOtOn2Hf+x2Whw0iEireJAtnlzDs9+G?=
 =?us-ascii?Q?5a9ZtKbvw8HognVLiZE6AhWP+LlAjR9fVRKWoI2yv9Uscpb7dzrRqw27rUyz?=
 =?us-ascii?Q?chiI1mrMi2pxI0PM7yDprRnQv/k9L6b2VeOdr76qxK2KWrMoR7yrTWGHR/dB?=
 =?us-ascii?Q?Ancgod5CeW/wzb+zDn/SepvzaNqNJbBW+6feAMcg6dqBb5yBvRkzH8AgGDnt?=
 =?us-ascii?Q?FBFnl/PhDH93B6f92YS4qXbbie81nDb72OgbOnRvj5blsvP/F7mv0Fe2f/NW?=
 =?us-ascii?Q?fBGL5NM/PxSSq/PWnwC4j/MzYflzQFi2gGz+pqz5FRL/o0X56v3DDTtyYpPX?=
 =?us-ascii?Q?6ejY+T4jQdcXKv1ceSSbD5zqknT1N47lR6KYf9WFShdC9tdrYKp/drVleMUy?=
 =?us-ascii?Q?k21P4pAk1XKN8qeGU2OM/H+RwnlrhYEyw+XdpGz4OCZ0arin97N5shywQHWo?=
 =?us-ascii?Q?r605/IfEGlcwhWrtCoWJhLuJfyNrsl47a9u6gHIVobXIsi7ajxC6U/TOc0fV?=
 =?us-ascii?Q?z7rFr0qeHehFexZiegHPhVczuyGbdhA43mTD+olVuOjYWBJlD6w8CFvEXOjq?=
 =?us-ascii?Q?tp4SIS2raVoQaBCE+9dcHUt0CVtk3xNd4r/DpacDzprXFAlHFrQ8LHV085Dv?=
 =?us-ascii?Q?fKyICEBb+mQf6TocgmBRn2SzTfnYIP+0XDVOBJAqL8PF+wNgdtVW4AU/J/XR?=
 =?us-ascii?Q?aKj3QSsRv267/JMUVogdKAouQ2rVwxiHFvsMERE2OcMB/wHaVTunv7k+xQOC?=
 =?us-ascii?Q?3kf83GwOcojxI6p8PYvO2ZATmrv4zYqUxf+YpF8kwcDr8JhV7BBwcATHUMW4?=
 =?us-ascii?Q?beG94WCfKR0OC0F3+eyRVBt76HZJZr/qk2h0ZYWGUh+tXGTAoF6fDF1jU1F6?=
 =?us-ascii?Q?9ntvJ68KKFC90qf3IRIx3Xm6OrF5FgePsgLQRG7BgpixPGi4+mhCXSqYxSrO?=
 =?us-ascii?Q?aPgcI0Hjr4B6s2NDL1HyM+oKbD5faV0D0hkcF9FXkcwCyUJxiPVr+WuU7qim?=
 =?us-ascii?Q?gPsu8y3u6tpZLXwEEo4SUv9hPjyBVitq0vvOALtYsYIZUDgF7Fhw02+LYAzQ?=
 =?us-ascii?Q?we+5ApPnaEg2DprU6wCJzIq43LWov9NYFmHxMOs3IORnCFLQaeN2x/Nj+WrN?=
 =?us-ascii?Q?VaVT2nvelZRxS7sNfNMItqIsfE1ugq9yg0umoGfarKXLkHQkUG9gCixfGJjL?=
 =?us-ascii?Q?nAG3VBL/0yWn8y/O5SHu9cQ5wc1hzgta1iqMYrhogciuSya3FzPtjAzkRvDM?=
 =?us-ascii?Q?hIko0UPx8c+rnWMgmUxxPWdafAV8knvJViTjOA3INmPx691JqBa8HWRb68sD?=
 =?us-ascii?Q?zUNSJlopms0rqwlyFCrSjtngvOXqJ9/v5ShwQFb5FONU0bAjg3QS8uywesrd?=
 =?us-ascii?Q?rrI4WGtYo5z3dniOUB3roc9M9JRo0R3Ssj2CTZPB03PQlV3GMLLqXlLpjdN/?=
 =?us-ascii?Q?4EEAaN1+bQw6owmTl+e1ezjp95ZtiNQ=3D?=
X-Exchange-RoutingPolicyChecked:
	C3OR/o0pPrjHk/ewPhFeB4/RkfwZ//pr5Y4BYnBbySoXZVd6M+gK9FehEgmRX2ScaL4e9QvF9k2gkJ2CDt+nabrlbMPh5zjKA7DAw9YIZFXwbMQJbAmHpUFpzdUJ5IsMhumPAjnjobASYCLG4ZXQJ6aqBSHsMPfug4mSuf/n5Gcls21t4rXImxR7olhu2YIutYfL/BZfNVorop2hkbXLy8PtunZdPCd6lhOKMbsGseUWBgR+ThxgQcx7EiSEqTu3FgZ1CXd/SodeY+aKSDbFTz7IkrIY/XE9g0ssFKun3YCLKrFVm0xetCYAREa6oFfFr9IL8ZAn6ZPvUOb/JPWBJg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W2pzOC4IbY5lBBvRsqos/Lrpie9FXOL/NrRj3YIrMD+hL7p63FGKk8IWuEjVskTCAgvX3BETO2KdTblttOV2ds1FyqqouaMIejUPZ345XkBsuOkHAGgVswgZWtWgyywUMrGz5owXqq1tDoD7m7pQ2hq2IlI3zlb+Y+dGvaHRiQXfkfLh6e3vbyK/GAiwjOs6JlAJfj97PlPCoYE9wk5DKDCC9tpkAfm2LMlLzeHKSYzflhB3mrkJs+sL+NDzdocJ9BciyqTqEFBvnftjIfg+5hpwGdxNklzFanANnvNYRfvYM1ZeTZ10fkXGR3NVihJbRViSTF1nvd5dUuKemo4zW1RAYKmOY9E9SNx1DxCg/Iwa5NGBWAflYaw1A1e9tDKGXLV60Qv9FZd6y36Y1iM+aYXSk7gsJsckiwY8PFuiu/YEtusHEti5/uTQc6TLDqVbe/4XfFaGXq2coTlhLwB2i963m4hMBuW6KGMhcLs9tPd/hbpx5tmT5b8OTULonAu90K/xZjIf4diSe6/MUsgDsKOm3Q36nEPReM98UFMBpU5l1cqHW8fDBdAXGbWYWs/ImQiN/lY+ETmMIwnhz/RQ+h9uI1AksqDS26U8eVkwY9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be362d5-6b5c-453f-f252-08dee18c6b4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:43:54.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SfJWv4Ps+/3Hntbrd1fu6EAEqKIWQEOqmhviNZhhENRqc8ZbHz8DrcasAbfG0c366wZxS+ms0v825WM9pjXIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140101
X-Proofpoint-GUID: MCoAulvSgOlKg8oF8x4owbEMz8-y1z2G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMSBTYWx0ZWRfX5SXiNdw6XbS0
 KYsF2yb0/K0FGnoo4WMURsabi+2a93wupP2u+S1iqbSEXmtLNDCYa7vcjyWzE2TnMcOQgO4NWIo
 wUFxT93qAvJ9TtlcnXvMmW3pLuRSqhQcuJSeJXX2qEBHg06Nnq76
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a5604de cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=QOYSxItt2YxLaTtbhTcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMSBTYWx0ZWRfX+r0RqCpmJaCm
 f/qmhCIF2H+B2FTNi/H95q/s5eykMpC0NrRuZUrdtRF5I32UEJ9NoQaVQPRT1SDK3OO4SxVGGPb
 knwOF7hwlDYe7j50sCSX8e8j3KxAeB5eXdqjDDUWZXjMnBan0Tellcbzcp/qM6eapbbaoGrAo4r
 u2/abHK/KuARc4j/FD9oSP82eXRqknzH/EKBckBIZQvNImeB+UZFK1nva4hlusV3eEmydnZUkyf
 v9H4nOtOz4ozvFbrdYUocop3S1/ghSYed7EvcdUG4va5kMZB30VOE3K8iMqULnJANC5duvnwGc9
 Wefzvdx8/CptemNCt8LW860KKY/JTXzEQcFQz2GhP1x3V7mmk9Cz4lOg4XvVR37cgUmOFs29n88
 fw44kDomRd/xVAfHnByHxR8jn0n3zscvK9N+7muQAWGgy8+N1ZA7Tz8ezafwf86D5RIDZAujokE
 32mym+556vJm17l8C7Q==
X-Proofpoint-ORIG-GUID: MCoAulvSgOlKg8oF8x4owbEMz8-y1z2G

From: John Garry <john.garry@linux.dev>

In [0], a fix was proposed for the NS and NS head (multipath) cdev
lifetime.

The issue was that fds for the nvme-generic cdev may exist after we tear
down the nvme-subsystem. Issuing an ioctl on that cdev may expose a
use-after-free.

This test recreates the method described in [0] to expose this issue
for NS head cdev.

First a fd is created by opening the nvme-generic cdev. Next we tear down
the nvme-subsystem. Finally we try to issue an ioctl on the cdev - without
the kernel fix in [0], this should trigger a KASAN warn.

[0] https://lore.kernel.org/linux-nvme/20260713104238.3034640-1-john.g.garry@oracle.com/T/#me118851584fbcbb960795d0f04e2262e5a295613

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/common/nvme b/common/nvme
index 15e9c3f..5951287 100644
--- a/common/nvme
+++ b/common/nvme
@@ -300,6 +300,26 @@ _nvme_wait_subsys_removed() {
 	done
 }
 
+_nvme_find_subsys_nvme_generic() {
+	local subsysnqn="$def_subsysnqn"
+
+	for subsyspath in /sys/class/nvme-subsystem/*; do
+		_subsysnqn=$(cat "${subsyspath}/subsysnqn" 2> /dev/null)
+		if [ "$subsysnqn" == "$_subsysnqn" ]; then
+			subsyspathbase="$(basename "$subsyspath")"
+			for nvmegeneric in /sys/class/nvme-generic/*; do
+				nvmegenericbase="$(basename "$nvmegeneric")"
+				devicelink="$(readlink "$nvmegeneric/device")"
+				if [[ "$devicelink" =~ "$subsyspathbase" ]]; then
+					echo $nvmegenericbase
+					break
+				fi
+			done
+			break
+		fi
+	done
+}
+
 _nvme_connect_subsys() {
 	local subsysnqn="$def_subsysnqn"
 	local hostnqn="$def_hostnqn"
diff --git a/src/.gitignore b/src/.gitignore
index 988d785..af9ebf6 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -14,3 +14,4 @@
 /nvme-passthrough-meta
 /ioctl-lbmd-query
 /nvme-passthru-admin-uring
+/nvme-delay-ioctl
diff --git a/src/Makefile b/src/Makefile
index d75daf1..4779ffd 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -18,6 +18,7 @@ C_TARGETS := \
 	loop_change_fd \
 	loop_get_status_null \
 	mount_clear_sock \
+	nvme-delay-ioctl \
 	nvme-passthrough-meta \
 	ioctl-lbmd-query \
 	nbdsetsize \
diff --git a/src/nvme-delay-ioctl.c b/src/nvme-delay-ioctl.c
new file mode 100644
index 0000000..8699afa
--- /dev/null
+++ b/src/nvme-delay-ioctl.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-3.0+
+
+/*
+ * Simple test to issue an ioctl some time after opening a cdev.
+ * This is to test lifetime of cdev, and whether we can handle
+ * removing the cdev while we have active fds.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <inttypes.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+
+#ifndef _LINUX_NVME_IOCTL_H
+#define _LINUX_NVME_IOCTL_H
+#define NVME_IOCTL_ID		_IO('N', 0x40)
+#endif /* _UAPI_LINUX_NVME_IOCTL_H */
+
+int main(int argc, char **argv)
+{
+	int fd, fd1;
+	int count;
+
+	int delay_seconds = 2;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s /dev/ngXnX", argv[0]);
+		return EINVAL;
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	/*
+	 * Steps:
+	 * a. Try to open device until disallowed/gone
+	 * b. sleep to allow nvme-subsystem be torn down
+	 * c. issue the ioctl on original fd
+	 */
+	count = 0;
+	for (;;) {
+		fd1 = open(argv[1], O_RDONLY);
+		usleep(500000);
+		if (fd1 < 0)
+			break;
+		close(fd1);
+		count++;
+		if (count > 10) {
+			fprintf(stderr, "%s still present", argv[0]);
+			return EINVAL;
+		}
+	}
+	sleep(delay_seconds);
+	ioctl(fd, NVME_IOCTL_ID);
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/nvme/069 b/tests/nvme/069
new file mode 100755
index 0000000..46c3e5a
--- /dev/null
+++ b/tests/nvme/069
@@ -0,0 +1,49 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 John Garry
+#
+# Test NVMe multipath nvme-generic cdev lifetime behaves as expected.
+
+. tests/nvme/rc
+
+DESCRIPTION="NVMe multipath cdev lifetime test"
+CHECK_DMESG=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
+	_have_kernel_options KASAN
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local nvmedev
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+	nvmegeneric=$(_nvme_find_subsys_nvme_generic)
+
+	# nvme-delay-ioctl will open the nvme-generic cdev, sleep, and then
+	# issue an ioctl.
+	# We tear down the nvme-subsystem in the foreground so we can catch
+	# if the ioctl triggers a use-after-free KASAN warn.
+	src/nvme-delay-ioctl "/dev/$nvmegeneric" &
+	sleep 0.5
+	_nvme_disconnect_ctrl "${nvmedev}"
+	_nvmet_target_cleanup
+	wait < <(jobs -p)
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/069.out b/tests/nvme/069.out
new file mode 100644
index 0000000..cd2e1fd
--- /dev/null
+++ b/tests/nvme/069.out
@@ -0,0 +1,2 @@
+Running nvme/069
+Test complete
-- 
2.43.7

