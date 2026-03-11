Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466D2DC76B;
	Wed, 11 Mar 2026 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773191456; cv=fail; b=iaS9fECvtV1KQmi3jy/A3tbGaCZNlNXyPiHs55HixlrtLod61lnBVJsNeS3+wXCpsbZ0qNKxQJheoixnOSVTQHkvQa0Q5d2dmqfqtdSZDkWmTN15ejHzck6aMdNH+rb+0BrfR7iqxn/lf23ytUHim3DkfOYp6NFALZA3GJVwU3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773191456; c=relaxed/simple;
	bh=0rrGU85vGzuwW3AMbYO8vYTOYNkEzfoTMJ2Nju+BYDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTNRbFjeAJlh/QXvcMj+4023krHbW3F5QODDmL76JLmSSop0YEArrGQNNzqM4HleeOwFj0X4Tf0vE003Cv3uEg+LSwDgHvJlxCEX5mE1LIQc4wyLDUAKfY3otA+7FzL8TviUM1olyprHB6hdMzsWsvKIsRYQFkyPpdbG4GMVcFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DiksSbxM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dnkWxPo2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DiksSbxM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dnkWxPo2"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AJ81SL094052;
	Wed, 11 Mar 2026 01:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=w/q4QSmuOPgMQ+Ilz5
	FYrjA1oYgPXM6MWs0MfWcZzGU=; b=DiksSbxMFl/vFB2PK00LBdzYPOQkYB/Tb5
	6443LxpO4FELS4KUTk7PHVT/EK1eo8MeGZtmJ82o4tK29A41AGJ2rM5XL2I0kE8S
	/dceHdEXeLyYmLZjPmyUiWQsuUzdyEmvQzXnyU9qMqDPFB1gxsaK5GKBoy6aWqvl
	jp8R0ZHqza6hyT25ZQa7NlKAqqchYKvD8C+TOR7iXv4hWUPa4otWzHH07cIEBHEa
	9FYf6VRohPJ41bkrQNmIWxdCoK8/Wj+zs+0t6r9Rf4QSAteH+UpQ/eJYYJfPSovK
	Qqji37Be9qMy0X2G9vOFKO92ZHHXa+j/yLsxs+o4Bcdh2ainSXbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmdkm1p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 01:10:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ANevgb022928;
	Wed, 11 Mar 2026 01:10:24 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4crafavasn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 01:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+F/F4tt+Xn0/Whn7jYGAvRsZda6ahkZDfBE9IPd451LY2c7iGo8pIRcM3XWeGQfgTQeaj8tS+6XDkF/ua/+kOV42layNXwvHKm8afeZ32VGx5OQnxmhDnAGAYWrzUUuiyHHoyLKtCUa7+3l3oJF61S2oEzLrTC5r565swAh52s22qD5cYbXIFqbkLWHZqsenLqCRYD9+nGjg9zvRocabW25CdQiKQTnFaCD/d8J3F0b6z65pFzWH2b93JErXpmNnhZuryWmcJEe30fZ3joxm9kiBIio0PlO62Mfg/BAV+mAHraREu9d93mqq0dWVXf++vhUAoP1Xs3N2JDPplugSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/q4QSmuOPgMQ+Ilz5FYrjA1oYgPXM6MWs0MfWcZzGU=;
 b=Pc/1/Gi/FoyxyIAVUziPdgh0iFuMyWrj5MTpPK1RDxPCMGegwVDVn0fubneptIhGU3EKuZ+p04bsaiMqHnO/TYo0GHRKjjVdetOADkCOPSwoepOPtDllO/dWXvUAqOV7RfsUcO7b/xe78SidH1ro0N3EB0mGNBnDPFgCkq6rNM/i9Wt9WxTvBV2Hnib/ItMJd7mWqQfGz+p8uwkIOOCMmqm2mcgLspj7sfbeU7IejWnuMdDoZBT0A8Ectx8SFaFueL2n/bwr3rFmdLsSek5h2iS5pWXKWsSQIX+6FzLrvUEJdaH+19EqLk7iuLNuNIE18GVjS9/ubiqWIynGTxwHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/q4QSmuOPgMQ+Ilz5FYrjA1oYgPXM6MWs0MfWcZzGU=;
 b=dnkWxPo2iMdMb7jnElOSFYgZdAanbT7jHQ6IAllOIr+mw/mAa9931X6+eAs4UlUxKQmtFZzHLRQujJQeuDABj2D5Jz+mr9FrrSj1qjaMBXMROI/Z5Aatje5aSVX5LSEz4OFvZQnarSCNV8Ou8C2PlgDVz/PUNfGK11up9tcR54I=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB5141.namprd10.prod.outlook.com (2603:10b6:408:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 01:10:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 01:10:21 +0000
Date: Wed, 11 Mar 2026 10:10:13 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Hao Li <hao.li@linux.dev>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <abDA9UrJBT1wXh22@hyeyoo>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
 <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
 <aapeVb_L5zohWRRe@hyeyoo>
 <d5cd4eb4-1703-41af-9c71-842ae33edbdf@kernel.org>
 <aaqq7YmUcOht3GWH@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaqq7YmUcOht3GWH@fedora>
X-ClientProxiedBy: SE2P216CA0135.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 09709f74-65b2-4318-566c-08de7f0af74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GcBXKiC9vDtQtOt5eW16yWVpggWAUs8R0zexTXYbCPjF9gHtUI7aMLhc0Oxt5dHOoQlYyqiRA6aaPPF6K/eh31l+o20ZRPP0Xln09ZglI128eh+rP8GKE2Tq1lpt/V/3DlxKn+chriQPosP2FPSIaBB8BcaqY+O5CUrq11tHedakOuDK+ENnkNHQdBDmi6lbdnmcqskXdYQ1SqLLxeGAVlcdjJG5Zkido1YuTJ9c8qBs6dJDgrPtQJlbu+Ltf02nwlKy/NGCbD12wsYRW8IaQZnYFebAb7NuDuj1invr4d5HKLx8ThWlzyVxTCY8HvhJCVhMu67WioAIxNOAC7f0o0gM6ZOnbX7RxnU2lM8jjrmCLgXunqLpqBFOdsuqgKNzmJtgrrmTFknMkjXn4F23HMjv0CPKQ4UpcEe7eUptASWt4FPbPWQnPSnR66Ie8rTWzf/+sF6YZ/2ZFLj96PBAdmw6GYC8cTR83Xienl7z1iY4U+WzMEKdFsr4WhyH9GKzQfXRW7p37+yqtVkeG1lbQVyDOTKcatRdKYc5Wvw9bNoTywWr4rl8F/FO6uLGLoT7xKLl6zkXdwXENy8HMT15E7M2miKXbhbETcvC44qtZxq76IetftJl3cSf3OeYeX9s/KGlerEq3DqYVc3z0OgWGaucx6tyS1M+X5PL8Lo2LL0vZB6g66Bup/rKNs3P7RTr5R+mGgMRdTleXOnpBqjN5r70L8eu3Nv6ppRuIMTDiYlukYRzboC90aVsD+OQ5Bqc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0f8wG/IXT+AF+quLQAEw4I85jsPrlgdFrD0qQCC0SXgtmBguqfWIpbUhxIkC?=
 =?us-ascii?Q?xNOMfmbMS14Nfbp8JQ7tFlbmhXfsw9wFM8aPr5bplU4bLdUYSIU5BQnzW98b?=
 =?us-ascii?Q?vSWu97uvdpIhfuEKp1QplzqpTE6yBnJT4vXuXM1P3wiPYk5q8zQoL2tGTKUT?=
 =?us-ascii?Q?pwIemVw2MoLcJzHbUEeekvGViHBNy1p7JiPPhBJTOhDi4aJjQcCP8gtXCFJR?=
 =?us-ascii?Q?eucJqoJF31qgemYC06fiuHUH7VQz762U59uYbOx/qr6vfTx+S3WdWB90jSKj?=
 =?us-ascii?Q?BHJS+8Ztko8wVGS4YDBuL9zBjTOW3PI9fT/wHw9C6vqc0j5zRtdihLYmAH5j?=
 =?us-ascii?Q?EaVPmxQorLlvV7WUkTM7Pzq6RgWhnEzxbzfkFstcXDpie4WMMBdH9nPOhDew?=
 =?us-ascii?Q?0Sip8IEDaHa1yuK/rzHdvwjpRjttZ805fY9Y5Oq9BO9zl6Zhw/DO25AaGo8B?=
 =?us-ascii?Q?m9D+I6Ar+5t+sxlUrQjBkmyVtV03tmvVoJi/XCoDjDki1s2cZ/nZtyPVbyD6?=
 =?us-ascii?Q?pmKfdK76Ky77WNOCSTkDwAcc+73/rKTqdNKx/6ensPCXS6O+l7NO/5fBRTSl?=
 =?us-ascii?Q?aX6cq72dicpNMABXFAxNT1kMXiLerZpzeyrq6jE+G1HGhG33X0Nj2bZS8Jqr?=
 =?us-ascii?Q?dS+UogrOOGEOa5qK2HP8VEBy9n28wgy7EY//HfzFQQiKx9xBZp3lykFRX9ag?=
 =?us-ascii?Q?0lZUMEMhSUnh1VaLKV+mJtWcpXpCNTsX62Nc97vKbAEs1yOH6FXzxoBA6usp?=
 =?us-ascii?Q?AJ/GdrgekRtIctTWwx0HX9RA9xFRRYYFvCLrk5xcTeBihjfXj4FQrQLEX4+J?=
 =?us-ascii?Q?DVoOoX02XIhh8Xlk8IkfNrWjjqSdhAiOD1xeOj+HArvg/L44Ie+Tly+HvvJA?=
 =?us-ascii?Q?GTxtrXK1ECVusry1/0zTDCezofRhrlz6taAq8QApFkOCHu00pp/ssfLreYbL?=
 =?us-ascii?Q?iosAZm5xsBEwFOyeWn3vF7V3WWgz2EY+Fiyb9ZOhQr50TyuCBmiNl4zoSQOC?=
 =?us-ascii?Q?TVZyHuGxrs1/pcLLNVbHVIek+0RhSi+sHMfsQrO4MVdGlKUiLyQlh+sje6i0?=
 =?us-ascii?Q?HpxwfRS9hXdcC8igRKO8j0liSi/+RU7x0+90sbWc0O2uD562pDvCTBum78WB?=
 =?us-ascii?Q?nVvxI2vY4aAEb3lmFBWOsEefg112S+95ExjRnH1nv2pM3vuQwIjuFHrywRC+?=
 =?us-ascii?Q?DEP0LrPcfvy3u5ObW1CL+yugoKFXbKFYnQ/by3ewkyiJD2s9HyGi/noJu+aP?=
 =?us-ascii?Q?/K2CjuzhebSSSRliOm3nzFn5SY45oSZK5/WNXpv3siIpAMxILwWd7KvX5295?=
 =?us-ascii?Q?cXTQiDyKKOq28RvIn2jjMTCm0mxi0iaZnELKYfn4dvWxpI+cFuciBwaTdB81?=
 =?us-ascii?Q?6peqmdtZ7YgrRVwhuYKaaJ/gg70UCJa0/ds/RssXihgZbutVxy2t2JIE7L3n?=
 =?us-ascii?Q?CvERH/7y2uw8iNX8LJXTwyztE/yO3Hrf/BVxhj4dfzpMVEir2RYUYFwRJjMC?=
 =?us-ascii?Q?BHKpYpOvlh/xisRBPH/k4NwZlEQM0KNBsW+PqC0aTi5DSJ9tiGqWhxUylmLt?=
 =?us-ascii?Q?NhuymqSfwdYQR3qF0mzP6aRCx8OBompRcTzH+c7SF0NEbC9l2A/BSdAT4r8j?=
 =?us-ascii?Q?HNsF+QafLk0hFT/BLuNQqcZm7Wtjkjt+GVe1OS4Bt1jG3tIJ7R8LArnNGqjO?=
 =?us-ascii?Q?S6mkiQF/3HlXjpSlS6hC16LB+dYYeSFP39TgAhsYo14Za0aWrZkhvvoOGyOO?=
 =?us-ascii?Q?2Vpeevpo9Q=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	daIUtHLR/LCU7BYcbzM/nEU/yxC7q/KIxpv8KtPePQuqyd4T8+wiewv5g6NNg8HXVnv1tEZEf5IHyVBcNam/97S8vOy8qLcQKG/b5Uw9dvShGP1jZ5HLIPamUujl0RXROkdA9uqwGooFsLGO7Jm7Rz1U5uYyzCu1t7q0nab5zOqLotX7meBOT4KMPGiAGixZTxeWT6uTGkTjV/yWrBoy5MvrDn0lm6z7uLJMWgTE3DLPjhWPBJF7ubwUiUHTl02eaaB5+ZuFumODi3dcWw8HMHDOphw+THZ+teeSTLN47cLrXANns2o1rk6h3i26CMPYaC7/pXIXUUL1DsWwodnUNA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3i/oHIGCtHiAl29vDMyxayREsPW+spMVx2djEiYW0/paYuS8R5eBpKPwvleW8nGyrYf6bfxL9ml4GrkFKxFRusYVSbq4E4WUzKN0SNGWEYME4TGOma8+gUp7cP6Abnq3Gv+7+Qc64V4mPsLCWqBgKpMvdlGvGSfqfmkuy7saAat4lWXIfDZsxJimj9IHI2bZQcfJyy03mQJ+xhCmmLQLIDtfbqADhXO3u8u+MiyYnr9YorNNOE8Cy3l0fqM3HRfb14ixMdf0mkqNKotM+OXWS1Y4AHbJ26Fg6xrZJVlhiRnZ3WDvH75gHOfqWEoyUmnw2bKxXoio04r/A7mnB59bgCsdu+Bv9JK1GP1JepIqngtfiBTATu6Ri335/m+P8aiaBjZrAOtPCcapUVCxWpS110JkEtyjqczRlsgeiMMbSyWQHogKcSRF5gZp8AGCPah7VdbwGtdh4bp9t4CxpXjB5uUhNwvRFLlGHdMVZjnKOYS9bA2dmDQCwEuZY8b6+12J25iDmBtrwVzrRVB+9CUb/2hwzO4zE3mPEzQbzpO31QAbTdIESoC7nEkrXhninDsMThhWKW3qVcFZP4QX3tOW+JcxZElUoJ9cqzfwHtksB5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09709f74-65b2-4318-566c-08de7f0af74e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 01:10:21.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClBm7YUxNSia/v6lt48ssXSDZgIpgTCzzFESAS/lUfcAqZ0bpDWPDXoGJjYRRrzBlZgVVHOIj4ju5UsYce3fyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110007
X-Authority-Analysis: v=2.4 cv=MuBfKmae c=1 sm=1 tr=0 ts=69b0c101 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=8UBSQLxVApZ62R__0YgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: I01M45JcsSsUu-U-4kUrV9u1SQSf10mW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAwNyBTYWx0ZWRfX9JEGCQCwCBtM
 xgcpKD8GFykH9WQotFLNAOrWNdYyOFfad0NH/+cd4dZxlzMbMEn57PzNdnonVm1f4iJooT7lcc1
 9gB9JawTEY6Svcsg5KMrNFvTspPXj4P+ANG0y9TLbWsTEp4ZjqrTMZF2aowDEMxvGgSLFUWNOq9
 D3T7jUBshUKKnLfoHU7qLBHxhGD/2puS1u3iRdg2mOHcaEHSC0hN3netQVMEA/rXCa9P6v/UsQ3
 6go8Lg5/dlcuS7OWredFrOoVzyMgwAtNoDNoziikYRwL0NwqATJWsqW8ID1LQZk7PBrA48D1rmf
 uWgqbra7k/Mbc03Sui8gL4/1kn4caGu8S2YvRcdU9gBocihE8S9cLK2CwtjMxkz+71+jwsguXr7
 1q2Mkyzd/+z1kHcveunFJHQBad1740eYtJWx2W3Nq9bAiFUr0ZZDbxq/ApEKfXcc/k/ANyB4yV0
 M6wBQoEqxLVVcn71/MQ==
X-Proofpoint-GUID: I01M45JcsSsUu-U-4kUrV9u1SQSf10mW

On Fri, Mar 06, 2026 at 06:22:37PM +0800, Ming Lei wrote:
> On Fri, Mar 06, 2026 at 09:47:27AM +0100, Vlastimil Babka (SUSE) wrote:
> > On 3/6/26 05:55, Harry Yoo wrote:
> > > On Thu, Feb 26, 2026 at 07:02:11PM +0100, Vlastimil Babka (SUSE) wrote:
> > >> On 2/25/26 10:31, Ming Lei wrote:
> > >> > Hi Vlastimil,
> > >> > 
> > >> > On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
> > >> >> On 2/24/26 21:27, Vlastimil Babka wrote:
> > >> >> > 
> > >> >> > It made sense to me not to refill sheaves when we can't reclaim, but I
> > >> >> > didn't anticipate this interaction with mempools. We could change them
> > >> >> > but there might be others using a similar pattern. Maybe it would be for
> > >> >> > the best to just drop that heuristic from __pcs_replace_empty_main()
> > >> >> > (but carefully as some deadlock avoidance depends on it, we might need
> > >> >> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
> > >> >> > tomorrow to test this theory, unless someone beats me to it (feel free to).
> > >> >> Could you try this then, please? Thanks!
> > >> > 
> > >> > Thanks for working on this issue!
> > >> > 
> > >> > Unfortunately the patch doesn't make a difference on IOPS in the perf test,
> > >> > follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):
> > >> 
> > >> what about this patch in addition to the previous one? Thanks.
> > >> 
> > >> ----8<----
> > >> From d3e8118c078996d1372a9f89285179d93971fdb2 Mon Sep 17 00:00:00 2001
> > >> From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> > >> Date: Thu, 26 Feb 2026 18:59:56 +0100
> > >> Subject: [PATCH] mm/slab: put barn on every online node
> > >> 
> > >> Including memoryless nodes.
> > >> 
> > >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > >> ---
> > > 
> > > Just taking a quick grasp...
> > > 
> > >> @@ -6121,7 +6122,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
> > >>  	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
> > >>  		return;
> > >>  
> > >> -	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
> > >> +	if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
> > >> +			|| !node_isset(slab_nid(slab), slab_nodes))
> > > 
> > > I think you intended !node_isset(numa_mem_id(), slab_nodes)?
> > > 
> > > "Skip freeing to pcs if it's remote free, but memoryless nodes is
> > >  an exception".
> > 
> > Indeed, thanks! Ming, could you retry with that fixed up please?
> 
> After applying the following change, IOPS is ~25M:
> 
> - delta change on the two patches
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 085fe49eec68..56fe8bd956c0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6142,7 +6142,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>                 return;
>  
>         if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
> -                       || !node_isset(slab_nid(slab), slab_nodes))
> +                       || !node_isset(numa_mem_id(), slab_nodes))
>             && likely(!slab_test_pfmemalloc(slab))) {
>                 if (likely(free_to_pcs(s, object, true)))
>                         return;
>

Hi Ming, thanks a lot for helping testing!

The stats look quite fine to me, but we're still seeing suboptimal IOPS.

> - slab stat on patched `815c8e35511d Merge branch 'slab/for-7.0/sheaves' into slab/for-next`

Does that doesn't include Vlastimil's (fb1091febd66 mm/slab: allow sheaf
refill if blocking is not allowed)?

Next time when testing it, could you please test on top of 7.0-rc3 w/
the memoryless node patch (w/ the delta above) applied?

Also, let us check a few things...

1) Does bumping up sheaf capacity change the slab stats & IOPS?

diff --git a/mm/slub.c b/mm/slub.c
index 0c906fefc31b..5207279417e2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7611,13 +7611,13 @@ static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
 	 * should result in similar lock contention (barn or list_lock)
 	 */
 	if (s->size >= PAGE_SIZE)
-		capacity = 4;
+		capacity = 6;
 	else if (s->size >= 1024)
-		capacity = 12;
+		capacity = 24;
 	else if (s->size >= 256)
-		capacity = 26;
+		capacity = 52;
 	else
-		capacity = 60;
+		capacity = 120;
 
 	/* Increment capacity to make sheaf exactly a kmalloc size bucket */
 	size = struct_size_t(struct slab_sheaf, objects, capacity);

2) Is there any change in NUMA locality between v6.19 vs. v7.0-rc3 (patched)?
   (e.g., measured via
    perf stat -e node-loads,node-load-misses,node-stores,node-store-misses)

3) It's quite strange that blk_mq_sched_bio_merge() completely
   disappeared in v7.0-rc2 profile [1] . Is there any change
   in read/write io merge rate? (/proc/diskstats) between v6.19 and
   v7.0-rc3?

[1] https://lore.kernel.org/linux-mm/aamluV66pLIdo66g@fedora

> # (cd /sys/kernel/slab/bio-256/ && find . -type f -exec grep -aH . {} \;)
> ./remote_node_defrag_ratio:100
> ./total_objects:7395 N1=3876 N5=3519
> ./alloc_fastpath:507619662 C0=70 C1=27608632 C3=28990301 C5=35098386 C6=9 C7=35782152 C8=115 C9=31757274 C10=32 C11=30087065 C12=34 C13=31615065 C14=7 C15=31798233 C17=30695955 C18=128 C19=32204853 C20=64 C21=36842392 C23=36212376 C25=30013640 C27=29055001 C29=29990232 C30=48 C31=29867595 C36=2 C50=1
> ./cpu_slabs:0
> ./objects:7232 N1=3816 N5=3416
> ./sheaf_return_slow:0
> ./objects_partial:500 N1=195 N5=305
> ./sheaf_return_fast:0
> ./cpu_partial:0
> ./free_slowpath:20 C4=20
> ./barn_get_fail:260 C1=6 C3=26 C5=26 C7=7 C9=5 C10=2 C11=26 C12=2 C13=10 C14=1 C15=19 C17=8 C18=5 C19=19 C20=1 C21=9 C23=22 C25=11 C27=21 C29=26 C31=6 C36=1 C50=1
> ./sheaf_prefill_oversize:0
> ./skip_kfence:0
> ./min_partial:5
> ./order_fallback:0
> ./sheaf_capacity:28
> ./sheaf_flush:28 C24=28
> ./free_rcu_sheaf:0
> ./sheaf_alloc:178 C0=4 C2=9 C3=1 C4=9 C5=65 C6=4 C8=5 C10=8 C11=1 C12=4 C13=1 C14=8 C15=1 C16=5 C18=8 C19=1 C20=3 C22=10 C23=1 C24=5 C25=1 C26=7 C27=1 C28=10 C29=1 C30=2 C31=1 C36=1 C50=1
> ./sheaf_free:0
> ./sheaf_prefill_slow:0
> ./sheaf_prefill_fast:0
> ./poison:0
> ./red_zone:0
> ./free_slab:0
> ./slabs:145 N1=76 N5=69
> ./barn_get:18129029 C0=3 C1=986017 C3=1035342 C5=1253488 C6=1 C7=1277927 C8=5 C9=1134184 C11=1074513 C13=1129100 C15=1135633 C17=1096277 C19=1150155 C20=2 C21=1315791 C23=1293278 C25=1071905 C27=1037658 C29=1071054 C30=2 C31=1066694
> ./alloc_slowpath:0
> ./destroy_by_rcu:1
> ./free_rcu_sheaf_fail:0
> ./barn_put:18129105 C0=986015 C2=1035357 C4=1253502 C6=1277924 C8=1134182 C10=1074529 C12=1129101 C14=1135641 C16=1096273 C18=1150168 C20=1315792 C22=1293288 C24=1071905 C26=1037668 C28=1071069 C30=1066691
> ./usersize:0
> ./sanity_checks:0
> ./barn_put_fail:1 C24=1
> ./align:64
> ./alloc_node_mismatch:0
> ./alloc_slab:145 C1=3 C3=19 C5=6 C7=3 C9=3 C10=2 C11=18 C12=2 C13=6 C14=1 C15=12 C17=8 C18=3 C19=12 C21=2 C23=5 C25=7 C27=12 C29=15 C31=4 C36=1 C50=1
> ./free_remove_partial:0
> ./aliases:0
> ./store_user:0
> ./trace:0
> ./reclaim_account:0
> ./order:2
> ./sheaf_refill:7280 C1=168 C3=728 C5=728 C7=196 C9=140 C10=56 C11=728 C12=56 C13=280 C14=28 C15=532 C17=224 C18=140 C19=532 C20=28 C21=252 C23=616 C25=308 C27=588 C29=728 C31=168 C36=28 C50=28
> ./object_size:256
> ./free_fastpath:507615526 C0=27608438 C2=28990052 C4=35098103 C6=35781903 C8=31757101 C10=30086841 C12=31614841 C14=31797983 C16=30695700 C18=32204722 C19=1 C20=36842201 C22=36212117 C24=30013416 C26=29054742 C28=29989974 C30=29867383 C31=4 C39=2 C47=2
> ./hwcache_align:1
> ./cmpxchg_double_fail:0
> ./objs_per_slab:51
> ./partial:13 N1=5 N5=8
> ./slabs_cpu_partial:0(0)
> ./free_add_partial:117 C1=3 C3=7 C5=19 C7=4 C9=2 C11=8 C13=4 C15=7 C18=2 C19=7 C20=1 C21=7 C23=17 C24=3 C25=4 C27=9 C29=11 C31=2
> ./slab_size:320
> ./cache_dma:0
> 
> 
> Thanks,
> Ming
> 

-- 
Cheers,
Harry / Hyeonggon
