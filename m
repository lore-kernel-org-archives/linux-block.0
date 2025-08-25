Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA61DE2AD
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149543; cv=fail; b=paABExge55ghdXt156Q1/Nja0blWFOJIt6u23bWurUVPGKTlD/wULaiMbay+eSj3XELbbTkVNbKCXDZ1CCCplZ/n10Na0YZGvXZ+vCM/vZ/3WnSpcZNS3DAmCg25CIQu/mzmrJk4MpAXbpJWEvkXa1OBUkyAQ242N0U4AQ15vBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149543; c=relaxed/simple;
	bh=yKT04tUnVog8fS4m2kfDkJd/DuJ2NTGXIGSXyRht+m4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=h4ADar6/v0heBx8UwRHGd4xJC9qdfqdUvGIu/6JGbl+FqzSwd5zZI3tgGBnqH+X8DayzmjbXFuUsdQhvP4qiA0N0eniZd3IqFZQPPBN3Ps6Cuo+bTTmueyiVAAW0Khp1eKuftn7tui+sFKRJ8Gv/jirf/b68h12yr8aWRJo72Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LJRPHfV8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QJ24PD7p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJRPHfV8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QJ24PD7p"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PI1VBr032305;
	Mon, 25 Aug 2025 19:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=24FFjv6CxRWuaNxxEP
	P336ZWGzWOiHQ0lZzpnmUHKi8=; b=LJRPHfV8/fw3Hzh/0bDhPptJYoYQM0mWIJ
	MkBXMmOV+efmVpkCHKz7/A+l/LOhi6ISSWBE0xLEtZcuhSS1yLA0svZI0RPPJ3vN
	kpKXA/QPNKw9xwzHCeSkyhCCECsPdw0ULcJv29y/fJMA2fJGuE1S73LsF1gEdIp7
	5+8+t4Fb3GUdvygYEJb+TTC5bXjllBtSknHrGDZsd0D5lmazbg6XAm2oEyMsDU/P
	TZHTUFlWTC7ZpWfLV3M8EyeMQ6X7MD7obF4xdnjdFHwZaby42kcoO7GHWRIuengR
	wphdoUjar0VQS2AJu0FrrgUEIeMPIHFv3YQRRdQhe7+KqU45pwRw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678typ8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 19:18:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57PIms5P014626;
	Mon, 25 Aug 2025 19:18:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q438kp0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 19:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzDxv0Pf0bxqcNHY3ZUrSLUx5uQBAAd1tO1qbX8P41p1CcGNLJZRj6jhrcMsmuO76SdtY5/CWke8Z21sfiEL/DjASWn7VHSxKnx1lIkHqDDcxsby3fFmL5ssT43bn9dtZv/4+SeYF/q2I3KDngDxrlVbP8MEN2ib7MB9tH+Jd3vcguxzLOJUNOWpe7KPXFkQ1ckzV51ophQ1lyrKlQp7jWqDcwsCMQnz3uuxFcSPjlWRHmmKdz52hlJ1Rms03qJToI0xVcthKq+Gx3QsGGci9Up7My61yi/OgN4iT0Ejg9NnIX1RByOjxRH4Uv5WdudN+KfW5d0hhhrXmBTUILiwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24FFjv6CxRWuaNxxEPP336ZWGzWOiHQ0lZzpnmUHKi8=;
 b=Y71mvxErQAxOqGJlUvsHwlw5OqlcBBagOatq7qJwsP26s8MFaMOYls7pssZbic1M+QRqnCIVcbSzJrLf+KX5PLgdZWvrAdCjL5VP9HjjRW9T7wTL0IsW14DL3cO2Xx9tnUXtcI352RQ7pXw1HyLQZnFgDe3pBc1JYouGr9yr0DoYhP8piGUjeuXKl96yZw09uwv4hUpGfcrs2kqeA5yV2FE6Pm5GXGIBFSfmL4YOOsnpkprCzQwVUl4GZFrbaQhXmtqDbTVc5shalkmIM7MxHXmRDUgF66+x5cgss+vBZBmlvyySq/uuYC6maHbRDQ+9kCMHGlAsClw7QFM4Y5TpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24FFjv6CxRWuaNxxEPP336ZWGzWOiHQ0lZzpnmUHKi8=;
 b=QJ24PD7ppx3rTCr24kFfILE1TiGSokNvgFkyJRroit6187hOIAzcZYauLQKo1EcolsYTcH363XDHhAYFUugsx1F1ST8Orw+MgcSldbTvHralkVW5FmtqoE3lWRYP+urjvrWUd6Au0AmW5zbWm3NobMuK17JoRrPE4MjI/h1jCwQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH4PR10MB8028.namprd10.prod.outlook.com (2603:10b6:610:23d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 19:18:45 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Mon, 25 Aug 2025
 19:18:45 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, ming.lei@redhat.com,
        Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCH] block: rename min_segment_size
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aKwtMbB0LQGURNMF@infradead.org> (Christoph Hellwig's message of
	"Mon, 25 Aug 2025 02:30:25 -0700")
Organization: Oracle Corporation
Message-ID: <yq1h5xvqkij.fsf@ca-mkp.ca.oracle.com>
References: <20250822171038.1847867-1-kbusch@meta.com>
	<aKwtMbB0LQGURNMF@infradead.org>
Date: Mon, 25 Aug 2025 15:18:43 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH4PR10MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 095d3df0-7ae4-4607-6940-08dde40c3637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZtvlXmUl2Slc6Qx3qCCkeoniayNIJz12O8v4b4fhw1+9HpWOklE+94CriJDn?=
 =?us-ascii?Q?TPj2uZMQw9D1wN0/jMvRmd5rJjfrcoMtcvJWt8cv7gatjp4r17L0p5R9jruR?=
 =?us-ascii?Q?ecpt9I2ytMl3+TcW4K6d3NOI+stBgZcYmwD5svzssAlXfstDHnzU/sWkmzkY?=
 =?us-ascii?Q?73O0S3QEnJEClfjbfieSgAfLTgry4RyZF/uUwk1rYJ9QYMojCelPZMdp4L1H?=
 =?us-ascii?Q?BZ8IDP4XMhcSsOvSVJSHEwqDVD0Vxt30HK067+f2etroa0KSL3CPcFlTZRw0?=
 =?us-ascii?Q?HlY1WAz4EExDq1uWYgaL9Iz8VG+yGbQNOp8SQ6Nr9g4YuJMNjQMkjAagj3kB?=
 =?us-ascii?Q?CAMMFF47abeXaa1TVpYZxetQtW4e7qAPCkch2A3OxOq+e/eGm/ZGtO8fGqha?=
 =?us-ascii?Q?Hnmw7fbVs40aFBSM3YWsbZPgD4i4WZQN8RylgLDBAGdpCHdZGwnCPF4rIDf0?=
 =?us-ascii?Q?mcih+VvnXGlmaNl7f1z+HLuUHMEQdwvIaV2cdHC4taVJV3AbsefL8LzIgKha?=
 =?us-ascii?Q?TAKLPPuf6hgiwg+dTrRrHl1oqFSFJkWOL3fWcFmUQLruDbvAoBcddJlPK5r6?=
 =?us-ascii?Q?PFDanSk685ikkeW6TIXNQ1QPwkkMsWpkgqJgA1AN1WydNC11Y3o8Y9z0h2wn?=
 =?us-ascii?Q?pWkTekXnOfux2nmDA7UNHR4JMufMogVE2s8GUYbPHHTkAu2yAmU0DT0Ca3Md?=
 =?us-ascii?Q?3WH3/oSWmm5p8JyRh2L/9u3XXWley7+w1LfgT7ofKeY1AHBIBg3L3S8SN42m?=
 =?us-ascii?Q?9b0qxcvJhPo/wRIJszjaX7IZ6Cs3N3rykbVakTXK4ZYX9QJs/akgJTqQlSLP?=
 =?us-ascii?Q?1AtiG17FWBAcX+V40vVHznbDtdaPABZK5fTO81MbNBIr/imehHGpfERpy/yG?=
 =?us-ascii?Q?6K/tbnl4RGYZD8krPvEvpU2+bE+iYky1UiONlhfTd7J3Y9KhJeujzzVGBhib?=
 =?us-ascii?Q?//wNpaFoYUDqC5JjW9aPjwozWO72RGBQ66/Rqud66jzlIrSQd+M3Il9es9pS?=
 =?us-ascii?Q?36oC4rGToMqlkkZQQqNuFzyANJMTvNsvYiITCraCixBrygp1pDTALdLM3eyR?=
 =?us-ascii?Q?fMBLUw88G2BklCRdBCwO5xHtOa+vKsP0Oi1BOrEXLvUv7i3xlJUgB2pZ6MWi?=
 =?us-ascii?Q?eV/YchAHe+rwnqnN0uQgCHALdJxeTKl3czVDKRJ5uDr8LQc/qH4JvH5EGlJ7?=
 =?us-ascii?Q?3uP1uZWGVEYgQwN0nvnhMfBTKPc+9yyweGyoRAdKlkklHHtIwJ6d755i/iPi?=
 =?us-ascii?Q?Wxf6ARXrVfp7wtlunMF1zkwM/OqE4cENslaeS2twGOVEUCS+yyknkmK0Dk1U?=
 =?us-ascii?Q?dx2u2ySVwmVl7jK4ouFWoXw384wgygDfSH+85RghsNfWA3Fo158GDkwBWvYR?=
 =?us-ascii?Q?Ic+IODfeuovwLDAQOhyr2AEcfd6y9Caw5+dnCqebFmC+qyQ87w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6nS9uEqzC6ger8HXokUGhOf2NLmdBDpOr6dit/pnGrIr+jijLTSAvRBQutoR?=
 =?us-ascii?Q?hikoCgo70OmrEGQ8XhESAjPdM3uDjRnEbdn2pQzVBc+YuWdZJWTrxWzQXz4t?=
 =?us-ascii?Q?6nhaRSuXpXyc60ZtHYL4Fs8ce7Bq6JguJiwXAMwnlgWjhYAMp4LGL5DfAXoI?=
 =?us-ascii?Q?XiYaqysCD4iQvBDobkpZB9Mv00f1+fOPzeYOcyC9rqArN/K81reuJ2mVx/Su?=
 =?us-ascii?Q?uJuHr3EXH1nLpqOytc8J2nZAfju/2AJVlezC4nwrWO1uk1kE64upad0fm1Yn?=
 =?us-ascii?Q?WDwauDs3BcrACkTsYjLa3kRRbilpCazI3PiJEGAr9oYFpLPtEMHyqIyTh7Sj?=
 =?us-ascii?Q?1mtfEpIaWL9iIvJ9zgedNI5cTKc9ENLSkzLWdEWa5rEGCFQDEd5IuIQtUT5U?=
 =?us-ascii?Q?cpWaNwVmz7OhnbzfPMpQp7/MS1vVZ8RB/chWxEt+hfarhpbr3FsaWuSlVhh6?=
 =?us-ascii?Q?B9R+EYbIndtJykuEFcpz/vn19xh16rSMix7qHPEVSwo5yDUhGtkWLy0BTqUf?=
 =?us-ascii?Q?Zqmlw0iv+suZnDdlHhSELuMwnOMMpl4iJTB4lMvmnCZKUvek2BzsmLUQ3k8x?=
 =?us-ascii?Q?aT9MoRR/1LL3LiHhHePib7rTcUEl4rj9HDxedOvgbikm5pQv0I8g2k3o9I4r?=
 =?us-ascii?Q?knKyo+XR3alwut3knsvJgG9kSs+m8H+yXwLH0zAWh2ojONDmSJiG5jwR9JKB?=
 =?us-ascii?Q?UfFHHdbRwL4kyYG/y/ytOZHQRP16aYfnLGCiadIyQ7X/vFmUPMz9oYpeo7Cm?=
 =?us-ascii?Q?wQCt9M1lesVpiV+zNPtteBoZAPWIVXhM9T07bFi8JOtopK6yYCm0jN5L4X/F?=
 =?us-ascii?Q?4iEJfEEIS5Gw/hkVKI3h12sBhWjuFra6I+46QD3yUsyoVUK+/cz1G/jWH89X?=
 =?us-ascii?Q?wRmiANNMkef9TTLd06K+XmXUjD/jc8EQWXcgSDxOCBsGok+Ev0QoiNSlS82h?=
 =?us-ascii?Q?WEWS8E/+KmZRbfaBPZosAC8iGMT22Ck63cnPTylfUqq3InZ9AYeH1+ruNqFV?=
 =?us-ascii?Q?rkzwUnmJ5HspU3wA2/XfD+ruJSCKoQ9K1aOJ8rO0gyfwdB3errH/ENoQbKcE?=
 =?us-ascii?Q?Ot76dCpG61VUTNoQ9zQFM/Wze2LZj80lIOmCkmjvjCmkGfwHBzSHs26cqGWq?=
 =?us-ascii?Q?rnXb46JSssO/ZFK9e6fCRrvFUxexTDJXuMwa40wyq881+UfU8HZWhjgDJsZQ?=
 =?us-ascii?Q?uZL5CC02Fly+JKIeVEI5a1SOEcjQq+/Kj7LM+dq/dbeUYRGpRKQNnxeLhPbs?=
 =?us-ascii?Q?bFaV51dEHsaUdOTwVRZpMpJf1HbU2NdvIYSngogo8Zp2f0TdZ0zm8kRStHbo?=
 =?us-ascii?Q?zbCudV7HB6bdVVGqoGAoH3qwUFEw9qBsws8WMxY4IeHAqUO/uN3jIzJHWMF5?=
 =?us-ascii?Q?ubDbgn6s7TXaVJR1iffXRxXWepctfVfcWjXiffmaNotq/SiCiFBXXfceM6rg?=
 =?us-ascii?Q?kiI/hnRV0lFf2RHUqkX9/YIkuljs2xlGfz+c8iWDwMEjJ0lCHjWuPBhRYctd?=
 =?us-ascii?Q?euiJFhMR9a8mcVF0Gx1ojv1qJjnamUqeJNHzZmXvN7DhqLOsPVGJ3KUTqZad?=
 =?us-ascii?Q?3c6vllDh3eTbm8xi1Hc3INqlLooY+/k7gzXHZXFJzhkHmJAE4AyJ/XJjJkB4?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vigPaeWmkxEgf9RRi5lklm+hcJHkQAUPV1nrAJAeXXyveh1ZSYds4qNCS2EivViy1ZoHuIenNgVeM2yIrfGekcz4OF5X4v4BITtF9QGYcguiPZoJ92p/McHoolMH1KT72jjLLvdzunIavT9IhyqiIIuNT2Knl71NThU3XzYcu/aBKksPsvhJM1qFBwRSyTKBMiTL5uO4LmpOtXYTXb3KAZ/okqWCYQJKCKXKyZJ4TVNoqB5SaI5nIx/Cvw/0aUgYWwKhpHJl/1V8FNxoCiRuT4L4w70NxdDYhntP18kC1fQWv4IPc24jDlLTOxdd/Yoe7kNSmFFvR3djbPicf912LGXWG7Jbi+YwtyD6Gk5Og8kDUt9Jc5vW7ZuQHq1W4dAytWeLZI7tp2yLoH3yuIAxpyNkNDZVkI+D3O5N294LldFZSUUmko5fENpgwY/BW5pmOB74YAyE+0CHpADoeFKj7srwXZnZpL42MQX+EHJHKepLzhvg3XPd3GJsxAKAupJkOpeAYBF8t73ikjsNdieiWXprPuAlvgUTUUMtVCUr/O7JjpY675YCNEh8JwjfYhvV8YkWRHHhWyC9S7AZAcT/v9qiaAHAcp/xtkefQoMKJUg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095d3df0-7ae4-4607-6940-08dde40c3637
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:18:45.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AySMZ6Zqg/eLUMc8j0yh2Y7Gzy7MF3DaKHcF88WBi9iUpg35hQYSAnYuw64jtj4Yul5aQyOoMOInh5mSukot+wTGUDBU5GCEMQZABtkByOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_09,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=706
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508250174
X-Proofpoint-GUID: eB3wI6j1k8-oz_abaZbOEVDtmVjfU2ua
X-Proofpoint-ORIG-GUID: eB3wI6j1k8-oz_abaZbOEVDtmVjfU2ua
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68acb71a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=xt107Gsg4BJVWnBwytgA:9 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfXwJcXoLvXwi7B
 rXfsVXrb7fjR3vn029378xq4apAI6D15hUKgZKgrnCQ+bwGReqAF8OgjGqhDsywJ85iIasv0oLR
 R/x0sEbH1ahvrPUsF7R14XsfLZA4Ui/AYfBcewJ+0/Lx5AKA5x6BlTF6m2YVFyl11Wf5GG6HwAn
 kaS8c7zQad1CM2BClPif1Ei6jT0O9KbMmI8XVdf6uUwBKI7uxU/gSr3S2M6hHLx+0aOkHBHeaBc
 uvxelR7W4hkROsFvfKbm0LTjmweEvr24uWh88YFAaKpCIiYaDUxcVpw4KgxBiB7TLyp3RzOE0eA
 YV4rm5omC9o6YIvdM497qvP0dtuxPVde2C38ZCY6IdByZRNTZNtPq5lopGnkE6hsXfRnQ6aqm/A
 CSnRRiI51Wey3+k4354mIqBJquqj+w==


Christoph,

> But max_aligned_segment also feels wrong for that. It's not really the
> maximum alignmnet, it is the fast path alignment. Maybe something like
> fast_segment_granularity or nosplit_segment_granularity?

Maybe just segment_granularity to match the other granularities we have?

-- 
Martin K. Petersen
