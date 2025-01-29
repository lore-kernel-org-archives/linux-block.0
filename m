Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1E156678
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160639; cv=fail; b=OQcr3wrHAwvpsH26VbVBDHvg1MDKW4tZ/hMRRCDAX6HHgW+pCdMJOwhMcon9sPT+/hu35VPFoze/l53hKEiHjhBKdxx9M3TSJ5H19WsIcKa4oN5+TcdzLMv/qIlZPP2wAYVPMHRrsq69IWqUv4YfgoSWr0lvsTx8oiuBSfmve00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160639; c=relaxed/simple;
	bh=uUqMLnpbXzfnA5j+Ttky/rKH86yO6vJYCipbeueMiCY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=bLFesXOHzFpfUyFtqClMq6SfAXZMp26VqIUsbKWQRwpv5yJREU+CdFYSvv+91bdO//vt5jqed9+vy9YbvaLynk9NQBbPDz3+m7TzrrjW2gMyWWyoKvseXHey+SNvOvGV5uQskQBQNFQ8n/LmB/tNy+Wh0nC0lQjJPvqse0IzPX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LleM2xQd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J7/TMG9y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LleM2xQd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J7/TMG9y"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TDwY3B006999;
	Wed, 29 Jan 2025 14:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=1G554amge0yXY2Lbsk
	peZZbFa7yKCc1NZfLxkORcEgg=; b=LleM2xQddULmwkTKR4guPIBHY2cSyeP1aQ
	Xacp8PsScyd/ejdDhM/QJWGCegng3g6BID5kK1w8UIdmY5jc/1Yq9vKr9Y/qBubu
	nD3Hh7U4twfwCRwOdXHKg/5D052r3nQHH7RM4hjBloS7k28Yp7xuVRi3C4bkXBQP
	RvarNCBjtzb/j0YlFdWnnw2MqnzpkCL/AOxBbt7sRTkLaj2ToNnShvit49QNcBI6
	wrwnO5aMwRPzZ8KR7XJuoxJJCqbxEoRMslApmKhFP4d3q5vvIhPRyJuqn55czSER
	rvvOjSYvQahJ8mKAWFBGvkUBm2MA+LVr2KBKt3CTo4GAibmdKOng==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmf80695-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 14:23:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TDSeIJ011666;
	Wed, 29 Jan 2025 14:23:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9gvhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 14:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiUcWxVvlazD2RDJMrAL8QbZnsOKIiwQ6h/CWUzuO9J+wrofyV5G4G6PCcyLBXnfM2I4UDdXwd+dK8Gftmu/pEOanBs0ZOz1TnFioQiO/WlkOgjO3XAwQ/6vvQweGSM5yuaV6ueiTNalHjp0R8TipEbXNuZQqVEW1fQjmNgpnDEe7zWDRm7cIFoK3zkQMOzG83TYT/9fin5/B57XIwReTeEVyhKtuzUtrjbtAMP18wiEG1E5e5aVdCZbub8cHYz4PqNsachygYzNduu0DRQVKNt7x3zZNTGz8NhkJ9pQFcWOGOHOziJHEOqc0OUmy9j9XFREb99YR3yMDrswHExo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G554amge0yXY2LbskpeZZbFa7yKCc1NZfLxkORcEgg=;
 b=SWHEiUaJ+xydtM5pDw2zTYESB8Ez3Iqp+agj+EKmromoB495M1S3QI+k3Fwfd3u2dUDarVrjtzxE6/73gXlCFddlpQ/Zb3ZGOrD23VAtHRLtXCkYDpZyiF8X6dR0EnZ5evmK3DZdUcHFMoJgBe/dyVIKucVckCyFDlo65wVb10Ov35X4OJYrBPOhxQFGCP+qZAxkzudC2pcD9crhFHTmUWTcTkEPjYrezNzxwYeZUvKgF4YelZFcTvuQl6MnggY1gXIYLLE2+6BOSo2JXUWgXi62N+DZpLBGBkva8HIwHhp4414I91cUVTi6206AwUjYaXQmrXErkgqJWNNDkqKoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G554amge0yXY2LbskpeZZbFa7yKCc1NZfLxkORcEgg=;
 b=J7/TMG9ySH4ON3+Q+Xtr9ME2mhvPYLW2rWsDmc+cfm5ZAcKpe7g0KpuT8cf+Lb3iHrkzfHNCT3pP6bjE4+yYoXLSe8sZI0L1w8pZQSFghQeAZ+lDgdi62t+4SgfH/3UBozuCgw6ceaTGeaQ5gF/Y6wMDOXHQLhXFtnuIT6kKWiI=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA1PR10MB7334.namprd10.prod.outlook.com (2603:10b6:208:3fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 14:23:39 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 14:23:39 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: in-kernel verification of user PI?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250129124648.GA24891@lst.de> (Christoph Hellwig's message of
	"Wed, 29 Jan 2025 13:46:48 +0100")
Organization: Oracle Corporation
Message-ID: <yq15xlxsqkg.fsf@ca-mkp.ca.oracle.com>
References: <20250129124648.GA24891@lst.de>
Date: Wed, 29 Jan 2025 09:23:37 -0500
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0397.namprd03.prod.outlook.com
 (2603:10b6:408:111::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA1PR10MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: ade72f72-a142-47a7-f4a9-08dd40708624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R8/RStZ13IyyvYs8EQKKQCN5jjTypAhZuts/iczsOkMuNpy61Pz9soMKqsRd?=
 =?us-ascii?Q?E2dHrdLUMuV2Cq9HYVWbQdqCjnb8+rfByuDK3XHfsMgssMGEh/ETAZH8UkL5?=
 =?us-ascii?Q?P1dZ+aY7PuhW5SuwczNlvHGLFhrSH8TH26R+trLwRwcDeCXOtRqmTL362OMs?=
 =?us-ascii?Q?Vt0QZuqmlcvwj1z0CEA1TYCpBY0HYian8JjtFvqIBrwyA/BveW8f95OmOiU7?=
 =?us-ascii?Q?GyK78SGN6CA846t/uXoDvWCsQHk1dzjZTt7Mqz5Fhp3j2a0v5DUvZomqt9GL?=
 =?us-ascii?Q?fjR69di9kX2yBVwQQ/tkPe40YT9GNsiwQU/4oYTkOZXxSA+Djey4+z/Wg7B1?=
 =?us-ascii?Q?/8Al5XVnr6xgeAPsEOlJpKNgoVtdXGVFGEXsYddzH19MgwieQptan8mjis++?=
 =?us-ascii?Q?LfGFqvVk+6QzWDm6Mtgvxd87inyJiH1H6Ip6ombrw/Qn/NP4n59HOHEOtBnP?=
 =?us-ascii?Q?xZOFPCfXomU1DMP/9633Urpn83u/0rqNvtA0SkI0qgxV5ef1xfbTFKbvQrgc?=
 =?us-ascii?Q?mqVo++HIYaqekkb7RqophAd8VVIFTfQZZgbjcmcWLp9tgrTgveE7b/Fr8QVz?=
 =?us-ascii?Q?3Lt9XAyZ83nbg2oTgXpp1/HvVQQvwpBppslzYUFEWjW53GQF2k8AqbKF8aU5?=
 =?us-ascii?Q?Up0Krktz3yeOUO0YJhSuSNTTRTMaAF8EYGH5DsmaBxB9BAA9Ms17bjDE0DfL?=
 =?us-ascii?Q?xZ2lDeu8nU7nenTl1N+SUeBZ/5He/RvsJ8cw8I8JOx3hBzM3fYqo+O99Idc/?=
 =?us-ascii?Q?KOjpE4zdbQqKmia4r+54knnS/Em/UTOET+BKWpBHOPas2Sh03CI0JixDwKOK?=
 =?us-ascii?Q?PMmGd+7x2wlrMveL5Z90jKmde92xbJCu57eLexCt1ux/TI4HgCfv6xCv9xJU?=
 =?us-ascii?Q?CA46Q32RMOXxIi9U3KlNGSXJ64PfwAh33+/x+iI6K5wec5a2oNB7UvNDbixs?=
 =?us-ascii?Q?6EzbhNuRrOv/QWun2K5dYKHVxbUGuZZ/YXeM+2fuTcuea2Pk27/jWzSOGISx?=
 =?us-ascii?Q?vhCp+dSHLCkpW9eF+Or/86RWiXwSv+dti1Vd0WYoUrzK/t8zuzy1nDyT0ve1?=
 =?us-ascii?Q?QtmOj5x2Btu2m57ft42zlwDqAAmntPfK1lQvS7P/h9K0USq44AyQbzhS2jFV?=
 =?us-ascii?Q?VzrXDIzPoENTpLbsKwPFU+5T6JbzBVmpYbI4QLQyXlz69l3alFR58GxfolKC?=
 =?us-ascii?Q?hMiX0IU6t+RpSU5N9a8m67/KO0Cch2qDasxNgEQPXRePNGd5KiS2ZjIgrzkn?=
 =?us-ascii?Q?xKNbjj4NbfMSS9XmFtmqAjlpEwO32I/Lqou4+/Zibt2vNxyECAv9bNUBrwN0?=
 =?us-ascii?Q?k7jg8tkrUSGn1p2kc9TCoMZmo5jlT5q+UEM1eImt7EwWkugj0CxmhuGfRI50?=
 =?us-ascii?Q?Wv+UCAaMV4ElNJf3XhIo22rLcAod?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?14Gh5idyfRAkHUqxtqu+KUmKZdrgGsu3m7ywgx7X08bHzThv2i9glrc6m1qd?=
 =?us-ascii?Q?g6NvKLsrN2dCrGzpcvQv/r76HFxTOWwgiOuG12IeM0XAOwke62RU2FyfYGZ5?=
 =?us-ascii?Q?AYdWQ2VR1X/HMalNCis72s92rjgtBKFaxT/IhBH0YwWNgl7zJmy+jR9bmxmS?=
 =?us-ascii?Q?HRgfEpJk7mRuZ617E9ZDkKtzEiqDd78Ja2yxdzce0G0u3zp2sBnm7TT7KQSZ?=
 =?us-ascii?Q?hVQYPRZaCG61BAHyQjT7uMtxjz60fQwHPRkshO8OEe407WNNdTVmdG04ejyF?=
 =?us-ascii?Q?n6r6tSy7eG4JZ0TZqx6IW9O+rMVWENjpeXbUGChaKcVm8z/tNQ/U1C0NFwYP?=
 =?us-ascii?Q?lNgJ4z6NhonDeB5YvBf2J1htvb/dxj4fGa9CyMnwn/g8UXHjSYUk1LEv25Zk?=
 =?us-ascii?Q?QeLDfXUboodI25sKAj12joXwJ45W9anHFqArsbt13stmiNxkKWpV4RjXsZO3?=
 =?us-ascii?Q?vpmXrhFxtWa5+acgEZBeJRzNmvpVyClIhU0uXpkg57WajIFX5t4ypc1iufQf?=
 =?us-ascii?Q?czXyBPZ8C6H67kMmbhtPDj/1egbBZT3RgJPl3ifZ01R07Nc/L8iQgjunyIcu?=
 =?us-ascii?Q?/4hZMXFbOVXVs9x8Nf8Ff4GWu+8B1eiKuqDUDSRrXlxap5pm+U7DhRFvzppS?=
 =?us-ascii?Q?cgIYvWbz7INPbicHjswYfu1ivkYWYF53JcpSJI+n2GU4ReA11d2gX9N1HSbx?=
 =?us-ascii?Q?t233yJOQQuhAUHUVLO/X3wgAOjB2zE4ubb9fbJ9rBvf3GusNaeD4KpxODnqO?=
 =?us-ascii?Q?L/K0Lw8nFLz+qe6xQUTtg184yE0bs+BGYpNOiqZXOVcpjCFfrOtcdhn5JLez?=
 =?us-ascii?Q?flYnR5T+sKKSQjqLitHSU3+p/kRIC0xproFPE4YzmffcOXNbuZ5htLWQLprM?=
 =?us-ascii?Q?HXK3doP0dyDtkClN0L3kx8L7t84ctC8IFJLLX7KMSKNXH123v3/aedBciJuM?=
 =?us-ascii?Q?pxvPaJ8iYvY2tkNutRGAAvRY6QIPvD4JqVDgQBq7+Qhw90FAi9htfkRrQTfu?=
 =?us-ascii?Q?1b4CB3Ha9c92Q4d9/w2JQ66dfqgkv04shIu29hoQT2Y9gRTj1zfC8YLkDHmv?=
 =?us-ascii?Q?wKa8R8dR5fJTCWR+/Hs7ETuOm/o6KBAr56uevj5wCumxQuP4MreiMI6TVcCV?=
 =?us-ascii?Q?YR6WR96Z2p7V/XlLcnkC2TX4SMAj+t5dBXFjWXC1ggDt85mFQwYbmILi9bwY?=
 =?us-ascii?Q?jX9P+6vpZLTWPje3MX1kAnCmtxtkCc+qVAHK/YNfX6jcV4MIGG+KMHF71i8s?=
 =?us-ascii?Q?ehzB8B/22/ejbrmqXAnBhqqhu7lQScbIlN+6kODXJmrdT6/72B6W9OXQQSIJ?=
 =?us-ascii?Q?UMJtBJCOlr4gJ4MAzht5X97NW0Tr5GoeIRH3GpjXuC2txuFS/mJ6nMt9I5I8?=
 =?us-ascii?Q?6kALRkbDKHUwGZ87dG5rDiwr3lu/rZXHK++Z6W4D/gWmBtonvQjJCff96Dil?=
 =?us-ascii?Q?yW00rf7pz4g2dolwwifcbqoZLLRvzArnmHH9cW2R2JCZRPLi1pMZ78Y2ofqm?=
 =?us-ascii?Q?W0H2yPIDgTwYkIEQu69VuYnvoeEODX+bZPYrHooDTLOQ++HtDorrx3ov6Kgw?=
 =?us-ascii?Q?flEEhC5jQYqH/SvwzvzYXdZ/URZ3XTk6u5/n8g7vHsqlR4jeUL8MhvwwNgJS?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BFMklJSu+UVhTxAJ/uVrxOzJWIHo3QDbc9jQ0BJpWXjzcoS30Ty1lxeBu9sHH+TOwTO6ogSPEMXAMu+wHYYYo8xwGWHTHC0K0XBTmWVpKnKzmDLtvlP24bPyoXMyBRKmlgIENHirgLCfqOuzKJeOzmN3tr23yylgbNnNtTS1FJLQf/iMLZlvwxzUd66zb3ZhrZtYat7BQzogv65N5Y0G1/xjjRStw5iI+ZzHe7AbIlQI/wQUQs8hnEVM6c1yD23yR9gdKmbOws3iIHoX+1uqckmbSiBblS67uo3B/Higa6sXBIfhvJfehBtonKdHNxouBQfVaAhYN4R+Ema1H0PaIyZAK85xyEY+lNj01/NaP4GyHynhfyRUND30ASK/KGpZc5KTTus2P2WyaU5I9G7j5sYeBv5lSGdkMJ3Vq+kphpo+Ilc+v1YvmJ6mlRVS1P4CZAFpepdy2JHmucvb2Ev4FIkBtQgiDu8KGs8L+njwHqOX2CWkGTlslP0ZHAP6840i6VuVen+sd5ZJg1QKcgthuPyYFvRhB6llSeh0JWKvlbf8NU780ZGJlV1I8tAlspbnny0QRT+sgYix4pwcEfkwSD6idMNkFYex377J5Qtoblk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade72f72-a142-47a7-f4a9-08dd40708624
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:23:38.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43HEXlfBYRz1A7QgBs4taRr6I2Y1UdUvSODaE1lJuUaH4lfCFxjuZN/sY1XSGtaPrrdZ2bpuzIANaL/xkyIePe4k6MQYDkS1N517Eg9opU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290116
X-Proofpoint-GUID: -zyaMX38grGX8HmjAhGOppNkVmj55BHV
X-Proofpoint-ORIG-GUID: -zyaMX38grGX8HmjAhGOppNkVmj55BHV


Hi Christoph!

> One thing that I noticed is that for PI passed form userspace the
> kernel never verifies that the guard and ref tag match what we'd
> expect.

Doing a verification pass in the write hot path had a substantial
performance impact when I originally did this. Even remapping the ref
tag has an impact on cache. That's why DIX1.1 moved ref tag remapping to
the HBA so we could avoid touching the PI buffer altogether in the hot
path.

> I.e. if userspace passes incorrect information it can trigger a
> command failure and thus the driver error handler, which is something
> we don't usually allow for "regular" I/O.

Do you trigger EH in NVMe? For SCSI we just bubble the PI error up
without retrying.

> Shouldn't the kernel do verification of the guard/ref tags on writes
> with PI data?

I'd prefer to have things fail gracefully if a problem is identified by
the hardware. As opposed to adding a second CRC calculation pass to the
hot path.

> Also another thing is that right now the holder of a path or fd has no
> idea what metadata it is supposed to pass. For block device special
> files find the right sysfs directory is relatively straight forward
> (but still annoying), but one a file is on a file systems that becomes
> impossible. I think we'll need an ioctl that exposes the equivalent of
> the integrity sysfs directory to make this usable by applications.

I agree that poking around in sysfs and reading multiple files to
combine all the various parameters is painful. Totally in favor of an
ioctl to query the integrity format.

-- 
Martin K. Petersen	Oracle Linux Engineering
