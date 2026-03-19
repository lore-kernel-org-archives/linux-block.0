Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660A2E4263
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929199; cv=fail; b=W1rtp2RabWlrDnn/Ng/jQHGHxrkd1z5siMnZypFABiCTQmJ7Mw2dz1fe1PW1aYw1vufDnKBhgES9FcEQO3t2nxBajB2Fos6QCyGZAAB2rczkiM3C+PFNE90BW7GxoksVYJtwxsWqN7rf80S2w9buQwbmHBLAk17tAhYJ2a1Cbj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929199; c=relaxed/simple;
	bh=dBHVNrSucSAwv270EMLxio1ZvqLuFnc8SfX4YQJavrc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=a32fI9jDQ4w93iqwExoVhPVaimjxi/nMsfCc6ovqz7NtCsd65mhR642dP7g0CwVvmP1b6K0y62QdO3bbM+bHiV0tyg9PSw7lTxqoZUyfJALNOiGwwPqy+v5Uj67iIjLYvyChGDU8CINgzroShwbpG5/R8tC7LU3rkoRklFEqhqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PkIpnhbZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=daJ5x5s2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PkIpnhbZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="daJ5x5s2"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J0FG8o313531;
	Thu, 19 Mar 2026 14:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WQMgOsIIar5jm2fZAD
	1e9t/0W8PzzyQATHciRH6y6U4=; b=PkIpnhbZHhVX0iLDaMft+iHQeiPoOb0xI9
	3IdFDeqgjJD0TKNtRp1wkJeH6ViuJe4zQ8+wTqrbL19XR0TU/Zozgvb1xoezN1Bv
	fdBsnBJyW+9NWU4TdVbXqmmkh7p+bhwBv++2za5cuqmImFExrrI6gcJexOoL0a2k
	L+uM8A0HqlaPkHHi++z9FNGHB9pcsev5got5a9a/9kRDplsISDaJC94pND782La5
	rt6Nx5lKjpLdiEd1GZLF/0mcsckFz3/PDxJhbkJVGzMFu3C2zKPbI3wXNz2Mnzzz
	L6TYK0rwupznHHd02Oi0whsOKRA1yVk6Dr3sYlVcPvKTH+UdtWLQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvy9rysrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 14:06:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JDKdeq021887;
	Thu, 19 Mar 2026 14:06:32 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4raetd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 14:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDsDnKFj1KkNsFT96XoIpiy3hFG4nhtyK8bSdFup3QyHFMYXPkpW2WccYuhRjJ9/1puC40M7YsWy5ZfWl6doquFuTw6g6XPt+tPRZnFpwGRKpXYs4QDNoqSESGg+vo/CSTV+QPd9ZkGcqK9P8aSvivSctECJNRPhx1GRjXbkjG2nSthS7LV0bW7COBniBzEBjaZ2i5716FTAhQ7jp5jOcuXbcPqHEFNHWhPUxt4av/ZgaTNkVzha8YDwHyGd+jnRos2rX60fJCwduylBQAOzQkHfnmO8dpMUqINtfQPGLQQQ6kR0h/XPr/wxtqXak1RQwyrvmdtWYiV0JJQLg4eAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQMgOsIIar5jm2fZAD1e9t/0W8PzzyQATHciRH6y6U4=;
 b=Wi9iQQzKmbmjG5g/bWPTNnDf73VwxolsXGyznXTNPfZswHUF3LvkfS3PA3lKhqgpmysJAN9V5zLTSnJ3+MQaHZaZh4frlqZYNXgWUEhVPqX599hkXze4wn+l8merEVmacthqAxgoDB2+9BleVTKQwBhFGG3cVh1ZpOtDBVnILtvDq3Ojj56VVYn+3SnCZRyDPnksB8/CZ4p2saUlkMeG54kjNOB/+QkO6l8pwnsMJgAmxpwWLn5dKOj8unE9nbe2mf684qrhNSP4QS12qYPih8ZUSxkqGbLu7ytctpiwiKA4iAQW59ijkOQngNqPHKaoCR87RqiWhe1gJmdEyJ8P+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQMgOsIIar5jm2fZAD1e9t/0W8PzzyQATHciRH6y6U4=;
 b=daJ5x5s2XJSVMwdmpjjs0vEoHEZ5+84M5fprGXnLzHUH1fXvQkPlQZkHC2gitRSs7sUhdJJKiNzpoL1wWmesnflACO5Ea0A18XO3FIF2YD7WSZBlhHfLNfodigFSq6HVlSaplsteVUwggksyMFHQVXdR8kyDpZ/rwzg1sFgKCg8=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS0PR10MB7127.namprd10.prod.outlook.com (2603:10b6:8:df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Thu, 19 Mar
 2026 14:06:28 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:06:28 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] zloop: refactor zloop_rw
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260319060246.2084931-2-hch@lst.de> (Christoph Hellwig's
	message of "Thu, 19 Mar 2026 07:02:36 +0100")
Organization: Oracle Corporation
Message-ID: <yq1341vncbs.fsf@ca-mkp.ca.oracle.com>
References: <20260319060246.2084931-1-hch@lst.de>
	<20260319060246.2084931-2-hch@lst.de>
Date: Thu, 19 Mar 2026 10:06:26 -0400
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS0PR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aabc4b5-8f58-4a07-1382-08de85c0b712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q/cQX/EFoIR6QfSG4ixs0dz2cASzVadZTUzS7nGEsynxkBJ7Fmrt4TTmKfdc7RlUD/JLo2+XFFGlr19PTZYHQkmziZTeYverqs0iKy/YNgG45Fk9o6dka2lSQgv2iEykLb4ydlQhv471oyTVJipPCQv2kBRArY4SDjHW16GecN9l9VKNLoJq1lq8ZfAwDWSJhPImIWlxDCmpfMbnSoilWxNVDvu6VJuyka7N1rW9DgzCyNwPFg1u/GazwTaPlZN6O3zrvQNY1qlq8f5Lqd9Omd+LB2cacwvrqfWBOv3GXSXgngPGypvJCSZUkAJusCFwpVOXWSHxOvzVTY/w9OopJoOem69IxEEZL/ArVqi2yNeIoKWj7sf64HSjC9MC3/K6dhXq39+VcFP3ZYDztIYoOwE1qg6b0LPcz8GV26A/HuDp0ccyvEXdDD+Fsk+hSBxjFtr9WQ7bTvYIpuqKn11ckuFtkc2K+3e/6LbpMjSPNlkMzjDKfzyOxFXAuuR6aifyUzQjhFiWQyKFN94XTIjR0ywBQq4y7xaw7kNE6yBanuoTLZ0FGyPlACxN1OyQNcuvR32BEeBExQQQtjJw9fR4tUdq6w4psSaXE0yX/vjSkg4DnX2+QBeILN7A+WX1fpJZX03XjdY5bou90pvL67IBVWdPmw2ZP2vQqv0GzWJPNcXbVgxRSBxL1G23edSOvuw/wNYbQuVcONnUXU+pUQW3iPRHdzBFsrWWyx3F41u63Q4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tFA7bmkjyaXCtJp4WsJDZmIk3BgDcWf4peFBj9ZmIyKMBx333/RZgua1r+Li?=
 =?us-ascii?Q?lcbELYc3JqeImZUTglix/3eDVM+tADavpREVSI5FL0u6mwLMadhuMFCs21zJ?=
 =?us-ascii?Q?Cz7ySKtShZHZY7xWNAAz9XNhGoVWBByYo+VedZ0LIo7dRlLZcJ9lXV5y1WRN?=
 =?us-ascii?Q?5GaR8iqJ7GsvIzJZCPKtzcMqUNYaamLkFnjjDKVK03YGSEu1+2FNIGVOr+66?=
 =?us-ascii?Q?OryUwb0EpPaqZWtEm/17W61jMe7R7xdA39FJBokHi+2Jqf4Cv4EqbuzhiqC4?=
 =?us-ascii?Q?DAWbTS1BxS4P41J2pmbgaL9E4oHo8xNHK5w9eIJrFxZ3FfDYT1Y+2LZ30SK1?=
 =?us-ascii?Q?ivQ0dqjF+5oHrbMFoZ9zPlUTA1QGxbZ4aS0GE3XX1YyZQvTf/lSHviQ3ZaVP?=
 =?us-ascii?Q?32ZEEP6WNC/AMmYDDX6170FGVUz6g7K1fGGQl3yk5tu1nYnZM+2GEeEIR5al?=
 =?us-ascii?Q?65qzACNl/dH3RzptXX02And0PljaOQYFA5bKvIaMI9e6tV3+JiQWyC3BeMfv?=
 =?us-ascii?Q?y8+ymF5ip/i883SG506L1/knzSG//0kCVwT6Vh3On9kIjlSYVShjVcr4AP39?=
 =?us-ascii?Q?CglIbqcUG5qz3h5+bh3nGJ8lQyVCfknaB78AWDD+D1oCbkSI3QP2IKNZQD8Z?=
 =?us-ascii?Q?FdPpezh4eobMY30T/uBQvJ4NYR1L9d8GWFWyMWuq2wZhbZ2T6s3r9XEIWk/X?=
 =?us-ascii?Q?e/xHms7XAFYQPqp8idgLkAme9INg/9DvyPGsx6m5wWqOYOvAzUeEpXBMMhEE?=
 =?us-ascii?Q?EJa5vteGOTP7C/ACYKdLSQzR6hb3Y9TEEwBpy/J0AF7jS+jev4ogFdUSWnrW?=
 =?us-ascii?Q?gg5nUowjdubjRhhKegTmwDVKfrROociCGW5wMJdpLZjE3Glk2V+45zkcUFMA?=
 =?us-ascii?Q?fmBTot6FZph9RBK1UGTenka91DbmzQRroulApb4MPfnrP0bIod/Y88CqMnuw?=
 =?us-ascii?Q?9kUDX1pZM9b/wGkzgKzlerhG6wtxocCC7h6KiEpVkxxq+DaArviDVChMnud+?=
 =?us-ascii?Q?/LDrcKl/9Z51k3a1V/WPRNQ5lcmP+efiMgJ3ZV40kYD+19XmXDwTmkwoFLEP?=
 =?us-ascii?Q?uqm0LAYche/kqVC6vomiXrVirIrdA4YdQEXOF/B13pxvOmb9ZSnamxlE5DDo?=
 =?us-ascii?Q?VXe617azK8+Hc9dkHTHW25IS8D7IGP+dkEK3Is8YFgkCzOcssFKtfzr3auJk?=
 =?us-ascii?Q?kwoMEUekNAxtHoNP674M84ZGAAZCaCe5XElNAfmgIltUe8rAVr2azUyupUY2?=
 =?us-ascii?Q?X9uog7hQ7pOmNQw+Qs0sj4iCjC8lJGbK9Q0AVlhntj7sbc+v6UICYnlQqWTh?=
 =?us-ascii?Q?Ug341ANdUQHE8E5rklurY4Vhcgu2ciL7nXXSRUQUmAW73G+YedSCP1gxyPOH?=
 =?us-ascii?Q?DtDAEPuXPk/UV8ke4/fsjvT8y+4MSs3CVVEhi7Szm27UMenbTiebjlfR9ESD?=
 =?us-ascii?Q?B4jHVRnRDHU2JsYKO/RdqMzoD1lewoz1IOH1kdTNmp3bVW/BfrK1wAsblZQA?=
 =?us-ascii?Q?UKEh2FlyB/Frh23/4wq6J+ZHlEJISq2lAXyKzJiz8vctnGycw5XRrrQQ0bMA?=
 =?us-ascii?Q?2UWzQYddPhH+PAOqwlisvQuGHT9MNmexk+/aYemG7ZXIkAkgyTFEN79F/1sY?=
 =?us-ascii?Q?CPQvN4ifrfZPd0N1a9fBW4Wr16CaVzzcdHh3+6tb99EoKzCU5oh3riCW+pAx?=
 =?us-ascii?Q?5jbAXmzNbL3/V4njFQVbWpO9SuWoSkvFQC6YCyMkmoy5C5uKgFbhm76J7H2D?=
 =?us-ascii?Q?5Dnj+qBQCTKa8iuEZavmJiX1fQU57bA=3D?=
X-Exchange-RoutingPolicyChecked:
	m2lo4hJKFUtFfqD9yigymhVZ0mOBgI3BDaWAd0mx8cXDEp6jVDVCJKVAUD/lfxz3IV2GO9rs9JfJ6M4dARyuuZTl42k1JkFe1+G3fIR5Xl1A6YNwnPW9RZ2Z2NZ7sdxTiHU/2vZIksVEHU2HGVKXYHgcZFHouFBxiK3Rqky+epQfVgY756MYFh3cOM2/daDKMvuC2KKb2BzNH3TTf/ODjwzYYNuE1bZwxKsNGopagnqDTrt4tz43LmpLL7Z0JV9I440h9HvOrHxy/rh6j9Bweb0SmOtswAqcm1/DIR9aETZ8WTj8r4HmqAxiLJjJg90avoXgUuQbkOVcQPAgw8ImPw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kcxh3hM4BplKFOEVpQiVTs4XS9ZbocJBIayTtE3lGJLM59uv7NT3D/SAuEVrTYkgW+tZQ/cXqa5Wm+a8U2dHCXFoouQtODj/ATKk8Z272DSukweqGfuE6Spb4gTTCwihHLl9E/ozB7AXNoNaNsoIw1q9DOhWsIAFCj4t+MWUg/2uCP3RT4kW7Xtn8PTgVBIYMEWjGGixSpnyH40oFgTvRrTNrVTOhtEKvHOA9MClAGGAYQJv0JapxkGEfcHpMddw8+kpAdYTGwhMej/pE+SKeM8+Bw+RUoprSuAQq9JxjbrYEYxVKHtwgnlhR9LLTpiWSaN+voG4CrjiQ40inhHVrnn3aeD4vdefPNuvj/DA4V0S5EqFvpYIm2AhhbVcg129VHrg0iMHJfWs8MoKV7IOoUWBtfbArushjdz1ZDPsBoO2skV3EqdS6jruNge+mbAcyCSjuJpOAV8sRLor/sTiJNBRUW899DXgth8op8wEps5K30Lc0LDqLCr0LdbM6e1amseQ6ZXFGSvmRHRe/LudcBdyIzH3QyYTTCeF7UgDXVSjECP7eInD4ZvjZUG+CbBQdSF8YvOb4ZgTzMwzUr/8Chm8LAdGH8Q1lyPcTw4ZGhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aabc4b5-8f58-4a07-1382-08de85c0b712
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:06:28.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McHV1W0fyVRDGN84bv3uxQMIbh0CMLrQJNSDqGNVAn5wzklsvp2+3hduUX3jWcAos7r/qG+2Zw8ZX4wxwJY7REiagadYfaS8+eKAlsvpG90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=884 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190111
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=69bc02e8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=X1r10Pczp0UkkyFo7J4A:9
 a=MTAcVbZMd_8A:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13824
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDExMSBTYWx0ZWRfXz5KL0ESzD9SK
 tip+sAxt8P8EZEBWl8Y2YdIvutGLK3ATI3+Mr/xQM0aJZHpQQpJTOMqLFZVegPaee4oPS50mVJc
 7Sn9/5pLATJu699lmARC4LDApXc/zDDxXWFU2f8NUJ5dkoOqKw+WYuMsobdqCmS8N/Dvci85cKM
 MP5eUujE5VuQF0bXv6gqxLY8fCS8I7RWzMDPQsZjHqo5CoUMd8hlsurGpYuq8M0KvCUb+WaLtfz
 J2xdU/CgKnuuf8Z4nwHjMjM51eVR3jDNeI2vvazKQ+QnIRl7RFEVf1VmUv/sReryppu04mPMCHw
 HmLE2DIbYkiFhrGNhfSdYsGPpcfuKaXb6RmjtxWlA7OKHoxp7Ky4TTcGOcrhpCgtPd0FIvO9kZs
 cWQHtuONAwH8kXfhnYcT6HwCHqw28fmoLh3q6Ikqm+oJq7/4BKHFQWelrQpDXLL+1HD7iLyG7cr
 /u2xXbtcwgLk0aQ1pWL2K1CrZlk3x1d13obD0wuM=
X-Proofpoint-GUID: Sjrt_kEl4z5NVknAJCSzgI-KJICXmvJs
X-Proofpoint-ORIG-GUID: Sjrt_kEl4z5NVknAJCSzgI-KJICXmvJs


Christoph,

> Split out two helpers functions to make the function more readable and
> to avoid conditional locking.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
