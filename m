Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAC2F52
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720151413; cv=fail; b=iuhdD8ViOSHl6wSFa3H5c1tTNTwvNGU29TkxpYbpB6stAnLY29G79n077KhMQlEoOLPCR8pz/BKxOdYnZSZ6KJiNEK8vyLVu+Lx1HicWVGjD1P1b2BOHyLbX5WfwI3O4RQ0U6+Fz1ntIIu0FKli//5TJOpQvlNuOXKixV1aBPQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720151413; c=relaxed/simple;
	bh=cAfSN7TnbPBl5dk2clD6PaTFkuUdCDzzQ9Q90cuYp2E=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Q6891jZaFYG7iQYOYO4YPvTXYaOYp2cMju3W0gSV1u3VD+0YvQtpeRucoVTbp/MhbJIWIDycKS+X6KgfC6l8ZUF4s0g481O/bnVY2p1Y5ez3fAZLayUrH7dSffflxut+wWGdii1fiJGWuBF73QN59nKM7YnYwIKut7MwV5Qn2T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Prm/Txm1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BvUBJfyi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Prm/Txm1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BvUBJfyi"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DQ7Jq016740;
	Fri, 5 Jul 2024 03:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=VW6vfow64md6ro
	02UWge486n+eUyQDgnjOYwAvByh+M=; b=Prm/Txm1CJrB1kG7VIeWcoJxC/kQAB
	3wEZliN9+jhQ4Mwj/wwdkpqpiSNSFWIKiU3R/FwHH5Z5anwpL0/Yd7ECaF90ep3B
	pVDWKG5g5QqiUqNJAN1yeNA1zYq8YIC9cISvwUyUpknPufA78dE/CiBs4RHwCLAt
	MLYoosHidPEj+C0J42Cs6W1lR0U+Yiu9BnOKJYY0puVje91Ic9/fmYmhilrh7+h2
	FvVNioMWOEYJx9Ns+tXJpL1FrN4hFldS3jn7vQw+iu62SchmC5jo5NJ+zPskIvMR
	w66CAXZKNQGEsCq8Ik4CCv+qHTe1AsJUls/20JrzJ6olX3clqFfk7h8w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attk21d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 03:50:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4650a4IZ023471;
	Fri, 5 Jul 2024 03:50:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n11vtdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 03:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIxcpFy8wThNyciegF4MqcLGB4PpHMNd3zGCbnLcBGJquhDyr5leuPHTKSixAtmvDl5ZJ+bq2S2EHaQhBckXVW5+qBlWYKoJjx4Uk3rfVple5Y89qoTc41l4/LughDUkYUeb/Mhue/lZyxQwGRfsEP9LHBH/n1cQqJBGlqo6ymHXOqnqnlyco7g1Vbxpl3fABG+v2Ofn1X0XucbtLz3RN+/tZ5XGy3qLpdxd/F9TWh0b7Py4Js/HA7hMXHWI8jb7pB4aAdcw9SJu6FhCaKhHwQtJ4zOXPcMcPZpPUrs+BeiHmXqR1waA5wIVf+tyeCaPetnUasQksygxIG8DrAWpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VW6vfow64md6ro02UWge486n+eUyQDgnjOYwAvByh+M=;
 b=NFjdm3DgiGaTD4xlhr+iAD1T+XBmhOp1srZQBPOQLv2q0iiBeeGp8RFu72kPJrStt4v7IoLohI4jPYnmgdcAbMtp+4qzEG76fCp28USqYVbcrpKYBeJeeE6HJ89STv9/zXHR3BXlGF5eBwC3f3eNwR+3c7Sr4xJLlb/PQCIhuPtSVh6Os5lxj1W/IBKV+NUVwYLgcrXLK2YgfMlfEaAoC3NGreYR6or8ZdWZZK1SW6eIsuP/UWamfYDeLDHb9Hg/OdH0LtAcg9xGrboQ4Lvqx5hFYyzJkfPoqH2mHgCl9mUj8Dvxd3JlSJql4atUzLmJUkHLCYWPZP0S1BUeu1PSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW6vfow64md6ro02UWge486n+eUyQDgnjOYwAvByh+M=;
 b=BvUBJfyiUCDvepuWA+V1bPZyu/X7jQ+iXVnlh2SygbbAzFLAg5fHV+Lx+nGkd1ZgTzm4uEciMwDcowx52b3ZEdfKVYifu1lyCrBo3w25nVrH3kZ/Ygs8d1uUW4cZIpFzShuJiVOyWTgoZcM5D3HHAxkZX3QLPqpsftJsUrPJs9s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5889.namprd10.prod.outlook.com (2603:10b6:a03:3ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 03:49:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 03:49:58 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        Anuj Gupta
 <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: t10-pi: Return correct ref tag when queue has no
 integrity profile
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240704063242.GA21732@lst.de> (Christoph Hellwig's message of
	"Thu, 4 Jul 2024 08:32:42 +0200")
Organization: Oracle Corporation
Message-ID: <yq1y16g8q1s.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e@epcas5p1.samsung.com>
	<20240704061515.282343-1-joshi.k@samsung.com>
	<20240704062649.GA21024@lst.de> <20240704063242.GA21732@lst.de>
Date: Thu, 04 Jul 2024 23:49:56 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: b91a6c2a-b728-49b9-c701-08dc9ca58a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+F+0gQ5VBiJx7mDyuwKaVo0ziXhKGafLxm9RXHnXx60Jpptd9CyZGIflN+eU?=
 =?us-ascii?Q?YzH+1aykSkJUt/qpzN40FUguYM69ewEuNIWkY8ZMNo3ekhuSCqB6mg9+X3bB?=
 =?us-ascii?Q?VpxPz0u1NTAVM+Jkr+hzWnymTfAi+SLvW4LaBM/WUReMrP5UMR76YeJQ0C+3?=
 =?us-ascii?Q?yqzb9rg3KpjmCknbxhaCt4uxFyU2xMQhM8i7R2G/5dJcfWlxotajmdH5cuYD?=
 =?us-ascii?Q?9PJQVuneaHxr4aHeyBoFgt7gp4a4TUh1NP041iO3MzrmvhZhDHQNk8+x2toz?=
 =?us-ascii?Q?n0a8Y9DKy4bS4ox3f+hR8w79p19vaDJJr9T++vhl2SUFESN4wsbcLxiGXgw3?=
 =?us-ascii?Q?c/DXLlU1xyGCDJfyNVCz57VOHJCfO0Wgjp9wYLBpukRhnpOXLxuGczNDlGTe?=
 =?us-ascii?Q?uZwDa71WR3BuWDjkxgZj/RDFv01I7yGs/bXXYB5BLftH4XKdPEz3acddkOoA?=
 =?us-ascii?Q?3v9BEPhFxU3D7X41JY6wmxhjRst/5qrzhKgMazwgsVReetwE/mrlz5lC0Qfn?=
 =?us-ascii?Q?oWQZFLzwc4eqGbXqHb+E29gyzRwHmK3WfUa/p8NzV+IWyd2M8qgHjTXmi0Il?=
 =?us-ascii?Q?Ijvq0v8vbDpyo+uWVLzdbUUDJe2qIeIacu4kTrh5qniIYK+J0HsQJiXYLIds?=
 =?us-ascii?Q?wHj/eNQRXDRviGAkMvQ4pdwzjtJ0h66vQfB9Z4y7xD/QfW9oBkAZoi5OGpRP?=
 =?us-ascii?Q?ATx+ufE0wA4F8w9zR0myrG7IIogucXbUd4osOvO5HJgJsQiKbS6zzkEO6Ihy?=
 =?us-ascii?Q?1bdsMSl+j07rEN4UjaV4Th6sIPawa458s5Xrd4kStewLGDuLKBxjH9hLpeJK?=
 =?us-ascii?Q?x/KFGYJFi63nKtVENHGl+TkZ0zPJDM5Z5nh2pMPENQYZ2ksnh6+0L1S7ZFzY?=
 =?us-ascii?Q?CSziOf7nt/JziZeo9PuwAds0lOLZGoNktUsAtyw3Ot9loPhEgobOIJDgitfe?=
 =?us-ascii?Q?rgCkkoGkGYmXSHN4SEdOjZtsk+Y0HrQGdC0U37Yvyxhk2/tyaueoI+tYpV80?=
 =?us-ascii?Q?ENYaqN8Bg2ZfIPETE3sHmyYzlyEwPx6lS3s3B70IuV9XxdYd4q1BGaX4mdJ4?=
 =?us-ascii?Q?zoQgyxcAPdeMyq36HO349RvYRIYFpdKuoNDY2pNpoo7v0J2XdjPxlIS9h2ut?=
 =?us-ascii?Q?CF7rUMXNfSHPy0FFVf5mIjk240SfDH4QBjukqm6BLCWkUwMzH0i9XXzg4drq?=
 =?us-ascii?Q?JrRsofFJxfNtgsB/Pu3Z7bggutHLoJ/8vQGhSSq5xbc5QS7+dVy7g6LmMddz?=
 =?us-ascii?Q?3eB9rhrQ+9cCylT2yu0l6ivFhjpfvB6vJtuVtmHEEZ3wGuKG/zNrZuMrYgiu?=
 =?us-ascii?Q?UHB83QhzU11omCvd/IhZkpswaZ5bXUpRw3L5BXmCyroJsQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/dPdYI9m+rFXpWLHRbJbWA9iCdEZiaABDA5EzT4eFiZMEu0UUG4NOqR2n7Gi?=
 =?us-ascii?Q?6+sX8MOfgxZIrUsYIzcTj7NFEbshBJ00pyVts4cxUQHiAwsIXAT7DycMiYEk?=
 =?us-ascii?Q?CHELl1VD/PXSyq9VMW4CGbiXX7v8E61kdXDR6/P+NvhqNqWVjrz6z2KlAiyZ?=
 =?us-ascii?Q?aUpLrpYZqFSHw52bf2TYxfnZ1q2lAD2OYeGMYTlc1818La4qB1+KkIPgpxH9?=
 =?us-ascii?Q?4JEj7v4z6pPtYSY++kZsu8ky7Y8pXHVNsE0XEGqozMfVKl3JAKtV61wnzHrr?=
 =?us-ascii?Q?ETG3n/8icrcfSmSxPzfBm6vh0QxyQFrqADVFr5mjXBHMEP4fm8G+PCw7CZSQ?=
 =?us-ascii?Q?fF1HDC81UDS1qtmlyyq0b2t/KZh02fa/3wBOkcgZ7UbhGOAB9J43mMgmhw4S?=
 =?us-ascii?Q?67b2NoKxnwE0wsIRkEpPyxwoNFTALyQdrNzglX/ErXaAYnmxhAJVb1WxhFOE?=
 =?us-ascii?Q?hQpiUXHFomg1xrmwQIDXnGlKFuaRJV4c2yRmL3RSO0GsVQa1B4S7YXCgYYZ6?=
 =?us-ascii?Q?WexzLeTtRMBWzhgghjwbIh60/xa5V+z58A1bNzMFGPBCwoe8qnM/or8Dyvqe?=
 =?us-ascii?Q?b8UR+ybnrJKy/yCLLvF8VrIDXQNKURQWBZ1SO/8KCaZLhmoY312Xw/gvy5RJ?=
 =?us-ascii?Q?YtNuuRnbpys3mKVeF7HdTq8hKl6XG/D1hYTGqx54rQIZ8eWy1B6k51qxF3LZ?=
 =?us-ascii?Q?HE2uLeFCmke+3XtElBQlAkA0ciORYBGy9+I3qns/PFGeCaOpWsuwmUr8Dv6D?=
 =?us-ascii?Q?j5uS+Z0kdyitVc/Yf1IwXnwVDmT4aC/jsO/i499Hjo9MGWRJrhx0HnmamuWg?=
 =?us-ascii?Q?aPzPal3FkDt960XThrl0bFvEOWkPAuAf2vUkOZq5niprHIHnvb2ewwGxlehf?=
 =?us-ascii?Q?WuY/RrENZ3VZ9KrNObS6HoZHnuQFoABdWtmzGgLS0ZkPtv4gl5WSbEgVUXGX?=
 =?us-ascii?Q?HF01TYRqNvfO5gzCtVPsaan3V6uZEZ0X+qpRVDIh9K5/7fUH/s8cTd2/d3no?=
 =?us-ascii?Q?Bv1KReFx6G1f296VeNww7EXv/bTw5Qe/63Bfr7A5nn97lDiQxj95Ad8ICXlp?=
 =?us-ascii?Q?XfEg0GmV5uChompIvI/Kamk1PKQS+ajMTOCjpw3cAKcP+tpXmqnrlKOWzyuu?=
 =?us-ascii?Q?sQxZHFuYzIHva+yoWP1DM2uXFUafyvZD2O2klkqqS94HNe7urlHDq4ozr/pK?=
 =?us-ascii?Q?rQiURNrFqvHEH6uGjxCpQJHP2/EfOEmknFmGccKv5SsucS1YJFWKCcJwHZy7?=
 =?us-ascii?Q?F4+V1dzR2AGD2AOHeUwxHYJEJotyVpkmlzAqlwmeUzZr0yW305IpUH7UEPWu?=
 =?us-ascii?Q?RNF8exgN4oMH22uSPKR/FW/zE4qVhuWm0mLvDxA4T1G1j3Ll4OOH5ceWX/H1?=
 =?us-ascii?Q?Ms8l1+eBa/8aKSJvwL5bG6cHwowphSc99FCEaVWrGpzSqS4liHu1HuDSuKIE?=
 =?us-ascii?Q?vQWwzHI2OhUiC5Gmdf/iIn7hIaDl4oXB7QS9VaZn7+F5j3roCMcHRojtlWjq?=
 =?us-ascii?Q?Cj0BAEPEuh6L3gUOAhtvvoX0/fEEa5sbqLbO3hOAUx6PPB8YQ0rjbVBG0FmC?=
 =?us-ascii?Q?65EcaM5Vss8FYJa8/ZwHNycosfIf1b9rtiBi7GHOy4GGGWcrNxkptU4wAYgr?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dl5iE9GB1LA38BkKGpXrQac5ykXfvdkg+nlO/S0I7+JDiRo5Z0YDL34VRODwtpPGPabkqOhQmlAXNDJMXu/ezLW8ul5QEmx8jV8nEuzhb4vH2H1OiSpGytgy47NqR7AoXkuQIUmw9C4fEGEeeiHiiyutJlUfZwphClFdA53wUXnY1OpJA9+p/CHnQXGCecuSqff5MKZPa2UBEb/kNBa9895SHLPJNb2Si8XR6ST7ZiwopGXjX6PIu9NLK36I+PV1EAF6SEvf403fRq82OpxEXaO81k6+ZynHcgxt4qqOZwyhp5dvVudEH/f3BEn9cau1co4VFpbVx53cxsVwwhbeRahcR9u6ZOUKGSnmNwrplgm/JnRMAODtzrmpk3Y5ma9pPUfOAmiyZ7sfWx79ltuzWQg5Rpk8FhkFxpyMQYuZALFe0YIaOy9yayTokSZ6AjAGkCBedPB3tXJrJyEidm7K4HF50LxLVmFCS5K/9RGRcPM+ZhDvkJT3HuRQ1s8I7eTmQhoVJoVE2yO8g5fYFmlBRdEaNHa48zMakv/IkOTuuOKjCyeoFVcFK3w6uYCFeF7++znOzsKV2QJA0ZtuuoxryePNdYslLSrx0h9xgpxZY5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91a6c2a-b728-49b9-c701-08dc9ca58a50
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 03:49:58.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDwSOkbFTZJeXDLZR+1FkXDk2Qt6UtF8TPKXjYQrzn7owh+41U2CzEmcpXk0noe0isubpaDnVi0jvxqmvncP3bhO6t5cY/Dsm1r9DJA/Cuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_21,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=855 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050026
X-Proofpoint-GUID: Vs7CnZapdf4x1w_oYkLcZqW7HNqRRe_w
X-Proofpoint-ORIG-GUID: Vs7CnZapdf4x1w_oYkLcZqW7HNqRRe_w


Christoph,

> Looking a bit more it seems like never actually merged the SCSI
> support for an interval_exp smaller than the block size, although I'm
> pretty sure I've seen Martins patches for it. So i guess we should
> just go with this patch (preferably with the fixed Fixes tag and a
> more detailed commit log) and then sort this out later.

The driver for this feature was being able to use disks with 4Kn sectors
and yet provide 8 bytes of PI for every 512 bytes of data for backwards
compatibility reasons.

I had a couple of drives which supported the feature and several OEMs
were requesting it. However, it turned out that using 512e drives was a
much more elegant solution to this particular problem.

-- 
Martin K. Petersen	Oracle Linux Engineering
