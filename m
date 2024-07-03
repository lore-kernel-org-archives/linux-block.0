Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F691D272
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719972848; cv=fail; b=Uo8MhC8DMO7sfFmGNd11Fq6/EeaN3UWB6MNSLTwZgpmAx3UJLfUv6nvLGrj8mVGID/vbadxWdxbJsXF935Ipab/lTql8zWZgmsTGU5rsiC4hcljCRoQ00Shhf2uSw7cDqewvZiGYAn6Q7+jAcgh7Uj4kkZOSPSKMg9cuS5VXC7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719972848; c=relaxed/simple;
	bh=KGOTFoqZA9nq6iXKB4rkhiuMtJ5XdE9ygq7HEPLNh/4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ePENjKqPBaktVlIDe5QCrXpdG5BQHGPvYVZ/FzdtoH/Q4vfymmpJ+7xDj/m+rULdv50LMWRA+63Oe59qr+1mIge6dF7im90yGpE2MWmJ57pxxT7OqQBOuybZvxQokdlPYghOv1zySueBkj0hnPheXl2I3ipfz52nQOz5rpDPD2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XHohKOPl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WCHMM3oa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XHohKOPl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WCHMM3oa"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4631MWYS028379;
	Wed, 3 Jul 2024 02:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=TroQ13ezZZ9/r/
	NzEToLgMVEvENyb7OpQ2pvHq+c7EQ=; b=XHohKOPlmq1+HU5azRzRy5aRNnMWND
	H9va0R/xL2/ougrGx/7UBcQxZxgC2h30GPWwS2gqaqykQS4dDQIllsoVZ2KAnxPT
	fM0aRojQJa7etyJMGflAAE4asCL4BYxYpLIlNy4U2PHe28bkQrxxVKMMGWReqfxP
	5ti2s9bw7HDSay48YOp7nRdKGHQmSrw8+EBo3Yg2p5emK3yRcGUBVuUrtqPEhEOR
	uphR9sNp+6IPblidE0AVB0pZptwI4z34qBPdSl4lIFt2+l/82BuBh56k+XQtgiSf
	86lC84FalftTuSWrs2O0yYT3eP3l7s2pExYlirCG/9HQFCeEiPTP4wWQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsq1xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 02:13:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462N6u9O010907;
	Wed, 3 Jul 2024 02:13:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q8mp70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 02:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFFHzy+TMhnu1pDWLJicP4KpbCJzRLtkKTNBF5ok6q01fgFfOKiJT7mQ2Mg4cqq1RqNlTfHg/WIna+KONPE5FL/s3LPkjOoOwAgj5ZgOJGgA99ttQDWRdhuxqjRgjWgcUNoLCSL5WCBbl0D9JlGxiZPKgiFPiVtHOSa4BOv03GAyR2LkInrBkTNnoD9S2b8R7Xjmr65uNYQVfvX6FCJDJEeShfWLjEVJYQ6odMdZK9gQHJwwa4YaAgJ3XPUP2uDfZR8Jf4iIUx1+8c7611oRoJ3RP/gakpa9ghfnhSLu44OrYbMDZrd2swZrL7aT/rbnfagasiPoTBXfBUwZgbubbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TroQ13ezZZ9/r/NzEToLgMVEvENyb7OpQ2pvHq+c7EQ=;
 b=hPreBQ7tsviI4wfShChHA80+6W3Gku7+y0PRi1NHOvUi40g15hGAl0ULMWO2zKdafExEftLfABtABoxqKzoFBhFD7knXQy0K+m/H996GI0G0t+Cx6J1OZQj8ehK3FjQnmDz8XGrhSvrrFKNbRwB195oA4Ux4nVVxRM62TdJoVVItVG6FYQRrzpZXW4qrK57kOfTEnwWDfpOEtP+PZ415IYE3wOL+6L1m4w7Vj/FXXP+Z2kxe/OUG89E50fC1c+M+Jhmr7LJrIPNwk1C4mwTxtoZXLId6qkA5EAv4anOYEHkaPDfUsv/wstGfzuej/xGD+WtlIgDip52esgcLLBu+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TroQ13ezZZ9/r/NzEToLgMVEvENyb7OpQ2pvHq+c7EQ=;
 b=WCHMM3oaII5pXGq+eYhk8q+RuII2ayMg6QvFq8QSqnswnXtsLsNV1AGshekw+BVHch4vZehHzS0avnR/XE0uYtmdG8txjaaiauJupEBNotl3txQtrfMxvXVgd0nLL5NfDpkZA+ZFrNdHRj1Z67ML6msuXH5Ls+EeFJUOdQn0wmY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6486.namprd10.prod.outlook.com (2603:10b6:303:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 02:13:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 02:13:53 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        joshi.k@samsung.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: reuse original bio_vec array for integrity
 during clone
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240702100753.2168-1-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Tue, 2 Jul 2024 15:37:53 +0530")
Organization: Oracle Corporation
Message-ID: <yq1jzi3cjko.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82@epcas5p3.samsung.com>
	<20240702100753.2168-1-anuj20.g@samsung.com>
Date: Tue, 02 Jul 2024 22:13:51 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 77860a4e-c31e-4584-86a9-08dc9b05c8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GwTu7N47RZFrnfHF46qtZjXf+V3o5yzFdFncg44isbw3+ZOu6GFuMClpH20P?=
 =?us-ascii?Q?5ltdheBxNjQaX0+SBYC50RMLxc3Z5jx808uulIA4NSd5xNmfdyOrA6Y2uDSU?=
 =?us-ascii?Q?IEI4vw8MzNwB7FasyzLsx38n2XbA74m0iUSqT/lmdbl+MYq25+EVBK3k8vtA?=
 =?us-ascii?Q?PyxJQPLBUgRzyn3cbMiv1/BJAfkzQ4dz1d83Fykpr5cSz+Cwu6/NOEu7BEH1?=
 =?us-ascii?Q?5ekOIhIEG+R6d6AEkLbqHdFdFZuXz5EGZCPdkrMfPciZuOl5zjzeBNe7lxZA?=
 =?us-ascii?Q?hAtLS3MqihO3/EkYX1T8TiOr9QhIlX3Jwsg0HGbMy8lDTBxmTpXUrGW9ljT2?=
 =?us-ascii?Q?adeFaHQtA70lXAR1EQZXsomhnGgUTWB6jSadIB6agUxKWUJip4UZnApTHCkT?=
 =?us-ascii?Q?iEiI3W5iY5R5BQuNpFxuGcT6E0eqxy+XDU2CESynapdRuOCYy5KH+FNQ4CeH?=
 =?us-ascii?Q?NHUdz5sdMrbG+UaWRjYYZiO/1rbcBtA1yNHnRhrbmRNOlkiXTMG7oRF1o4OH?=
 =?us-ascii?Q?axpYUDOjR+iEkKOcyEx/fkvA35hQ4Hv4WEmgjzi20ACOCPgkQfERSd8cmkl+?=
 =?us-ascii?Q?U1OnuyifdJvz97LAJ5+FwUYP4IPq5bShoZvapUwQFFuLlijNbwxOI7t2EAGD?=
 =?us-ascii?Q?lgTyfyh7ggKpUy/D6LDa0v5RmnWrF03T6ttlmrUf3BjIToluf+3XgzcvCccc?=
 =?us-ascii?Q?b1XcTOEk+azo4rH8/fUlkPkecyS8iNlxYf2NdALAhDlMYtlI1afytEs53uSk?=
 =?us-ascii?Q?xA+t9UaCcYPC34s96OYQWNP2iENGjWrB5A9EQwAo7GxLLlVS4B4I+Kn5l3dr?=
 =?us-ascii?Q?Rm5oW6GVZUd9KtHXzHQKD7nJdhpezZ3nEVnbbeqM2MPOcOdBlWjRD+l+6Vjs?=
 =?us-ascii?Q?nUg6x2YNVA6UWPL+e9CGKwepMKi7rDxEvgwvD7TBHhs2GE/VV1UynP3GkuTH?=
 =?us-ascii?Q?ZRd5kbg1k+UXhsAC3nDT48/5Ivir8NtYQqX2muF1DfSdDxrVfvAMyYq8BHc/?=
 =?us-ascii?Q?D6sgiAw2QP5oQvZ6t8waCJycZVRLlqQN4bIoLR9vlqN/2uxxXqb3HyHKKOCQ?=
 =?us-ascii?Q?NWEypIfVER1bJGuHpOPFApP+1JTFVb7+MTUEeCyV4rSEOjz1SYyqWmLSV6R4?=
 =?us-ascii?Q?bD+aSemqEPinKeaOgRGlt6FBU7YzP6z7LNjTkDJmmxTocFcLMoEwTzjzT2UG?=
 =?us-ascii?Q?mdPies63Bv0UDG6crVBkJBVTo9sGX09iONOMN334JaT+gW6+WvCusKtr4A+W?=
 =?us-ascii?Q?3eV1oZCfrIyKTiaL6rejBkhA1+VN7yro+DqxJYGSpCxWtkzqkCh6KqNYE/BO?=
 =?us-ascii?Q?tAJWgr1lPGzteF0Y7DvvX5/WtkBc6d8IEQ9YdXrrnAjyCw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xul7jPl+rOCV4VXeZ4o+BTl98fw+wPCyCdQ8hbWvDHc+oAviccwcEVU4Jel0?=
 =?us-ascii?Q?2vb84MuUSUYB0q399y3u40cq0fN7POEwoVapR4p1YnY3ij/rhj76ZLkiMoQ1?=
 =?us-ascii?Q?Ibm6WazpIpfHNOeViMTHp/TTukKSmmn/9CkxKsSNAVzxEm5FV+tYcxwmf/qE?=
 =?us-ascii?Q?+QrPBatnqrG8aqk19/lIHJe8Z4dCqT4e4di84QqAR1XqNLP3dBloXjth1I/+?=
 =?us-ascii?Q?KtFHmuyQiQsAXIJymIxFgAth0YZLCI9izxpBMWIEoZJcQ79VL41Us8r5eKO2?=
 =?us-ascii?Q?kPbEs6LKXvL0kIdhXmXP6TPgLPr1q5C9k/GGbIKVgjYu/qgnBEIZxHBxzAUj?=
 =?us-ascii?Q?aBT9EiZGb5geO+evueQjOajPHx1AjuapBKq5bg7HbB7vPY35IbMXIh2ehrsW?=
 =?us-ascii?Q?J7a77Fgr6PxxehVSfx0qS0TbCrs1oWIBmNHNjpjVwj5xEwXY4UI5EktSeNUv?=
 =?us-ascii?Q?agWuTg5xzl5n7gtcIOyKAcZk5QeiOf+RgyDBqxzPS8sveRkOBHaT6bVf+rVM?=
 =?us-ascii?Q?tVXC/GDC+Nu4MtXsJ3q1+FUpiNGbPimVbxA+PKT8TFUTyvOi8EvajYxOO82v?=
 =?us-ascii?Q?ZDe5yEDRNn/mNKlhB/pyGiWtsCOX93EF+Mh7FH91t/Q0zCmRFVbL9wj6udBo?=
 =?us-ascii?Q?KbEMSF7D855GPpecSjynSsqaho5XAhOCgMXlg1e+xgbBgYDL6V9kDcXySfxk?=
 =?us-ascii?Q?TTd+ZaeFfIU07PqOkVAAObFQeMozLZ05gcp4J3GsEAd1H+i21Eif4KwQ6+fB?=
 =?us-ascii?Q?xUefWmukTPenHfYaa3AaQeJhNLyq5IQ3LNFI3Ek8PhfatikFpRi9nsCuKkvd?=
 =?us-ascii?Q?1sDGaLRuYgo+aaSEYUAsAR7Ah7DS1lN80Uf4gKDZ6FSUzl9HjB4rd0MMQ+CS?=
 =?us-ascii?Q?BqoxIJ/l7yjwlL3oKRiC0xS64QdnkGBt2sudLwOYChVNcNTmVcIjouNF5ZMH?=
 =?us-ascii?Q?QLu+G18WqyM2sNTPkt9KOtZopdLt5tVH6CStBGkyx7g5H2knfjqehNbD0N6a?=
 =?us-ascii?Q?0UDszbjlOsC01Z363HuXToxqzd3OK5+ZebYcTOWiHOaIHFwQN95i/KMXvADW?=
 =?us-ascii?Q?A2r4K8GRQ8Zc2XASF6Re5Lf9c3kSMFP7xFt4R9oXuysEbYUrMVbVPSTnQUH/?=
 =?us-ascii?Q?whYKGNiwj2TP8JBH1VhAw84CzTlAZkP3kWgPjr0nRef1p+Q71nF3hzJM4Qk3?=
 =?us-ascii?Q?MiPdXGIlUqqiLGunQUC0fTliDdo5XHO5ohvo0JBmfvZG8+Wutk4VVOannJ5C?=
 =?us-ascii?Q?yxjihEj3aCMqrH2Md8D/xVV/eUGGAQQmIZUklBvX87lgnUoV2teS2fToWONP?=
 =?us-ascii?Q?TyjGQNMz6I1UrfQUTykVm8fgLM1p3YaZlWgXSR7o57tBg3k3HAR/xd3t986c?=
 =?us-ascii?Q?OwgdWspWbHrC56vKdjOUJmdogheZu1klTO0czkd1X6fiiqy+d1+3/yLKnaPp?=
 =?us-ascii?Q?x0D4pTkVd869G/c3Mkxo6D/3/PgIS+bGRWit5GZNSCiw5QdB7v9OsfiCQnKH?=
 =?us-ascii?Q?CE59dPdvi7V1RGU+DVzIZjNtoCHYx7Hc4y6wMQLWk2CC6cwqeNxg2Ow3Zru6?=
 =?us-ascii?Q?wWrjOkeDrEq1FgF8YPMKubT8lz07q76mE8AO4yPrxXx5ugvN1skR7UyQViFE?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	u91gqRoRuFa6vsmlcFU58qKXI5ReLMwDXDLcepAMKziXrUu0uYTnBqnV/EqdkV+d3hXQ9ZmQzTBjpXfZgJETmrFmUBbS7azwrvQ56IXvsxSzONZaakJJ+ejJ6qAUXtGRZnNt2AEoVb74oZRr9QWwuydpVaEsX363UarU13ILvyRfoyRSfSGpZrvbPt1Dyj3ECcFpgoHX8JlfY+mxMyCzM8U4lrSFhSOjFsX3gks8ISzw1PCnWXRSk3TUg/zBpXeztpxpu/1eR6wzH78Icg+s7SFMKgzRNbvIooW/GWPuUg87+qOq/2JXfZtsUVuUXrH77s1FnvHHEXxHivhyamFDHtsWmOcAbkyztVS0ByISwPW8hRJiJeTs8zoad21tlVl4vgSTBS0gEs9z+saN0E+A6ywb0PclBUph7jKQ09qfl0fyZfDRLQUZjmHh/7vAPK0jot2t4yeKpo0xAihDjbbAe5bQa+t6+HXZ5XbMS/iKRlpKSgGIBD19F/VG93PREUfPtkPsNlx3CvmTqYSnc7t2o7yP9ak3ipymb69cVJJPg1XXHstBI9Kl15tw86sgn8QW730+p9LJEoM/Ls3EX6Sd3+/4e7xfhT5FwWrafnerm7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77860a4e-c31e-4584-86a9-08dc9b05c8fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 02:13:53.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pT/J9y2oVyTq4WZbbnHBuJxVPEG8f6HaTX4NpIqGDhr5Jw29T+uC3Od9tDTQ5HG1RA8eY3bEQ2DNU1eQMkQ3bShpVem5DHJ/Ta5TtzhyooM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_18,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030015
X-Proofpoint-GUID: eO__tSM2UUVjqQI7kUBt_m3oBYBKscb-
X-Proofpoint-ORIG-GUID: eO__tSM2UUVjqQI7kUBt_m3oBYBKscb-


Anuj,

> Modify bio_integrity_clone to reuse the original bvec array instead of
> allocating and copying it, similar to how bio data path is cloned.

Pointing to the original bvec array when cloning was the original
approach. I'm not sure how we ended up copying, presumably that was done
as part of the iter conversion efforts. In any case this change is fine
with me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
