Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550B7EF1B
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723355; cv=fail; b=Jltr98e29DPSqFUCNHlQAfitXTm4rO562RdjJ/iDsr5llxmnQJJc8MxxSbLHcw5z5yhetA44UJnFTggsV96usXHTqwK2uAIxNfepp3HaM32TTznxO58/C66D+AjFPckXV+x6Op2NloweSPKVeJphz+1BxL6kLodZQNCaYisdSw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723355; c=relaxed/simple;
	bh=S0oTQr7joGecKiN9bdK52KctHz7gS4ZzMSVhAVqL0xk=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=m9fYHHp3lqj2Aa2xNOohGZj6A0jsNy4ogJjivXBCRM3GF0uQsd4BkYUDFcPTdjcmwIZZGS+UQ9IRWjayuRloWarLos2tQ6UZGc0/ecke9V+ie0y0qp1Hc0JCM7lHvQJyEEPjhU64hsHCr5Xst4f/zsIN9DA6BcxwmQb9z1EAUgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PCJG5rSN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SWjI+6Hp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PCJG5rSN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SWjI+6Hp"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHCMou009031;
	Wed, 31 Jan 2024 17:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=RSz7LGxN5B277RWKecN0vbQo/qZ04vusmuEFSL7MK7M=;
 b=PCJG5rSN0ejHA305mTNGQgHiPnrRO6NmFhIYpsJmCGRM+q0JECn5s3RpoMq9pqH9JI70
 IyK8i/nSsNDo0YTuxbR+9drhUfuuhD0iOiqta/6kpiDAfwXiU2W5/Vc5/h/5ysAVeVwD
 Nq5J1bsjpNSBRqe3VDQFMOIVtnu6pP6yU8Is9tTsyWZmCMJwrLGZCFMqJzHuwFbDSwNq
 0JQQw0tWJ3H4Jfq/nBMykKyavr4qVpndvLYTqN9gbEW1ZV7WI2eUuamGgmQhpkSqBq92
 xH5mOPmw6gMLX4QjofXna/uIQUYInA5rPfWVWHsk86OrYXZoj0aMurGSouUDw6/Wafro MQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm42h1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:48:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VGsEvY036077;
	Wed, 31 Jan 2024 17:48:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9fnkp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2pzVV3TFNZfQnsihDSv5HdhTIbAbjTBFtE6I9eszMcq20pQ/Z7Ac46qad0C6wvgOl8b1zAmN1a/f1vH6zYabd2ToM5C60zPMqLA0c2C+BcxEKXWIN3uCcz10xWMgAETqUuTS2RM20u67NBjVqgHVSol+7uCb2Qz5sh0CEBjbtkVWfTnBQgPP3yKARhsuL8/A7DcuBkO5XL/xBwyXA/84h9EGK4J5IWDU/wwV9zxvySA4ERtsnKQFKNYRb1mv31Kdhsr9+d+uJuKBYjC/aJq3EkdkOx22BHCxNHiOau+AqsdgVvaB2DiH684Tll8EFqtxeNFPPosEnHc2eJmrTIRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSz7LGxN5B277RWKecN0vbQo/qZ04vusmuEFSL7MK7M=;
 b=RanmwU2Djoe0tOngpdvBYpRWHMVONE7Vl0atIZN2ry89YJLV5gYa+4hZytN4fswqF7acIX6JJE6LqTRd18DOzIoVbYLUv+PYQfWUT/QnNLXSlzT4d/9W+l8Ud632aKi0zF1teK1l6tQc6PtNKUCWkC8322Pan93m4oueojnsoPGZoqSiOy2wIaSBCgjNRzDpDqOkezmNbnMupNYTcR5e1HVuivytWVudDoQmCjRKsB6+sMESt3cz5NTZiFTZo2+UDIauy8vS6RQssrvOASlxyL+5R+UwjQuHGeN8EKfg+ClObPM8ogcZ9taHnTxDB/3jUatlmZl2Y1p7I/hAA0f4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSz7LGxN5B277RWKecN0vbQo/qZ04vusmuEFSL7MK7M=;
 b=SWjI+6HpDxeAnrfW+mR230TJAwQdv1SZC1mVQbnpVyRb0CPj+5m3zKmYMQ9RxpU+Ap+SfhVrxlrlkzc5nbBRpmZXA2kKzAMDdeHm4a1iP/Bjh9yPOC2O2F5DHma6Lihw+emDT3pfOy2Id786VLRdU/EcYudxK/YaR2lGaYY/Ue4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 17:48:42 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 17:48:42 +0000
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 0/3] Block integrity with flexibile-offset PI
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bk91s8bn.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea@epcas5p3.samsung.com>
	<20240130171206.4845-1-joshi.k@samsung.com>
Date: Wed, 31 Jan 2024 12:48:40 -0500
In-Reply-To: <20240130171206.4845-1-joshi.k@samsung.com> (Kanchan Joshi's
	message of "Tue, 30 Jan 2024 22:42:03 +0530")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::49) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN2PR10MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd62ef4-5014-4d28-1801-08dc2284dd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Atm0jX17Oxd/lhkv6wZ0H+u2Ia0uzza2zeQ2CUzK2NWmSM5CMhyXl8/4P67eMN9xMpeIpBoGUWz59MNcwUOdtT/c5zI3oin0M6p+q4FnWLlLqY0kMAmk7BjG1wLE9+hZ7YzNz4TbsO+di8dsZrN5VlgGDyxt94XSovfpABBOd2JyzUPWrT/4xkAD3nZ0loUfacAWD9u1s0TxlPze8N72L1B7p2pjKD/SH9MFlyHKthiMfavypL7gc/aZEWFUqib5rBrRwcH6ZoQT8D9qAa5uq/JCqw9PxVRQ/LGe5psyW7biilnpmafY42pw13IHEJVyZjS+1fWdGiUmuQ51mp7AELUjqTUsL8CaJQRgC6OYjzF+58Wb8wh/hCUZSY5OLw68xFIso0SDnZKklJF7rtigm1NzmroqBdYZX7zxsOmbWqErSdEFFTn8k83fanTrtfvrFWW4q2MTssXTAG88pltANzcaDqX+ROK57xWiG2FIx4EgIhuWmLjkcFNxH14AWzAeIVQaW0d4qBUPtpXST75fpnoe6Q6PLRPYyRsZQIcbzpZKz2qPqWgubQe0mcXdOuO7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(83380400001)(478600001)(6512007)(41300700001)(6506007)(36916002)(6486002)(8676002)(66556008)(8936002)(4326008)(316002)(6916009)(66946007)(66476007)(2906002)(4744005)(5660300002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5MDqY9l3ikmNKHuPl3rlzU0wxBHc9RkZX0tUA+R5tKG7lmjBGZ7AaeEnpxpc?=
 =?us-ascii?Q?dihhzj8NwFfCU+3npMrHKQGg3G8MHsAdtNVXjyEJxDkXPX1QkS5X51EQifeE?=
 =?us-ascii?Q?qM9w+SAmSZnIwf1HMKM7zKVei5hcjjI4mJaeZmlPbEFfvj4n3vz9vkMHYovk?=
 =?us-ascii?Q?d6wWHeE7vGpp7zRjHxLunIn/UCTFNDYQRP3L4JsJRsEoBczafBiLPng0VES4?=
 =?us-ascii?Q?dQyT+LJsm7oSIxOpndEpRKy/321GBSvP03As5WT9KS/qMTVeSfzexwlDFPEA?=
 =?us-ascii?Q?tarbXB7SvkFSJCMSmK7pnROWk0E9G9/JZvBZszGGkRnuDw6zJiEbswKcLZmL?=
 =?us-ascii?Q?nTbWiKQVVXuIEToJqXN8KRUapb3ylumuv49bceJI2CDYSRGB9iW03jnjuDmX?=
 =?us-ascii?Q?DWvCIxinqZP/0Wlw9OmTxs3Ji3glV74pBKLAgJQlrmy4vY36IB+qwEuYRirc?=
 =?us-ascii?Q?pi00eijlxpB2GUV5Mz/g20kVVPBqNRZmK/6zLwG0A0Lf4H8Ci/ihTbDZW/+5?=
 =?us-ascii?Q?2TPDMoC5VRmB9qF9XU4na9l6Da/h41YvrvAP10vO7SFYjRZ8SpMX3bYrYmGS?=
 =?us-ascii?Q?P5g+8Pym1qTI9INVcVALdmwM4vF8I6pFa+BXwHEjxS49gz3JeCb+PEFAoivs?=
 =?us-ascii?Q?JMRa6wzCJ4xdJ03SIRvEYYmV/yonQzn8fjWZdY5f/kGJSgGb8LOHP/J7QbW2?=
 =?us-ascii?Q?eXwoDWvb49kqs9KqBrAeDDUXoLVi2ZD510Y+0MfVGOKUw9D+5jKfnOf8Lmt2?=
 =?us-ascii?Q?PkwYmdDrYH1ESLOFlfF7bSe6Wh31jfC+nDj2Ouj/d/7FSfu6Ak0f0w5E25zt?=
 =?us-ascii?Q?6e8dfAaJAZ/0pdlYGHeBqqVeIWUAL2Pytw/fG6LMk3KnkXAMmPogseqh4Iw5?=
 =?us-ascii?Q?ZYjLruNsPuslPTm+mFgZJFnrm8vkm9v62g+C2K1oq8rTZsgU1PhqWKMMHx/3?=
 =?us-ascii?Q?ZjLWLsgOt9OGOVsnhdctHimzd2UJmXAfT8fxdb2rX8jJfvwcyEl3xRZKDdMI?=
 =?us-ascii?Q?Q9zZT+H9SDtjM4yCxlzBclKDht8r8vmbQ59HVxtJW+Wqq3DaJdORkBC2a4O1?=
 =?us-ascii?Q?dMkyYJls8UYgx5hugqUIC7dgeT1iKCYZgfmgx8FyIYWsfNCpYYWzn+5VWbA/?=
 =?us-ascii?Q?Tl6QFghwe3o7JcH+/qrJWVu2do534VYVAniJnCpU5mZ5I3hXWGXYD21SaWtS?=
 =?us-ascii?Q?00Yaj04iowQD9o/uI9JNGveqyhGKPAAEW5aqdBMuyNChxxhrlV3VA8EZDv2y?=
 =?us-ascii?Q?LLdDH7kQ/f3zP+8sS9B1wtoZwQhjomwbIGB1S05eUtVlgmr6FeTiL93GuBgI?=
 =?us-ascii?Q?GqSF7N0H5JmQGQbS5IQ6v+jpj+vky4FRQvTRxzucbTAea6DhR3ttZBHv/tn4?=
 =?us-ascii?Q?u0QPodcMp7mwAybC4IefSn6k5+tA9KlQqcIgNNfe7fUyspQ4I8p3Z4OQAuZX?=
 =?us-ascii?Q?Ob8zyleMlSringQ7NdirfFyBOnQiTPAmvkLMrfkxEBo7k0XxLUD4AfavPLGi?=
 =?us-ascii?Q?CEwuYsRKkf9ZayE1IpQopdkLyOy73+1rg7pY1O1+Yj+rPEqY5Runyc88UxGV?=
 =?us-ascii?Q?M81i3j4KGwJ8xMMPHDX9Vvd+L4oKDkvjpmF9GU3I5j5M7uownROvwRn+mSXo?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uk972uxzEnirp7jZ8T9Sx2bzIZNABuNZCEFPQayOEdpLU5uTxKANNVyJNKvWTOHT7Wem9wtqgjYBS4bw7csyiWMzmAK5JcagTykwNs7XE/GW957z2bIstWNYULw3Z5Os67tn8MG7xy6hBpEyPLYaefm1gQ3X6c0imajmRKhozA3ro3fVJDt+BO/NEmzZHF8Bl2D0AAFxfdCUqn5pW4DzAqU607SG/GnMfPA94KYq5eb0JDLpy6aNeDyHWwDE3PjsY7o5CMJne0LFC3+4xQ5Bv8CdjzgS/OMK7yiemx4OceMyOrE6Q/uJSX6SFPtLyiksBr/i456YXyE8T8Yuv97kI9/yV3D2XYquDqZSrD53AORDS30HHb4fru7zG8x4Up5gx2VWY9aAbZfGlweZ/rLxklErNzPgVyh8Cd0pkXexu0RiT92S7444OIqrT1KdZ13z5U6K80GaESg0k9WGbWy+PhwDWmVZfOpVEVh/lsCMfKSCHSQg0RLl5g3C1QakZ+je/KohLVyBQnRaeNsn5zSsUxPW12ujkspg8Qh2Y+QCltnjF1uMSk1VAGq+Q2bmiw2Lm7l4wIidqJS2/YK69pFHT+3VrTRH3W/vh7OLwYgwYYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd62ef4-5014-4d28-1801-08dc2284dd0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:48:42.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EekQ/KjCCdJ3LVk630VuBXM6FAJ8aeD9pKBaJvkOKCLYuKTNO2Fqo/CSKkpoaaQ8y7wKqiHd8+QN9RWmSnVW0Pyf5hEoJkLf5DYud21VlBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310138
X-Proofpoint-GUID: gMR78HL_jy1mF-FAxKMbGOdKUOm2rKH4
X-Proofpoint-ORIG-GUID: gMR78HL_jy1mF-FAxKMbGOdKUOm2rKH4


Kanchan,

> The block integrity subsystem can only work with PI placed in the
> first bytes of the metadata buffer.
>
> The series makes block-integrity support the flexible placement of PI.
> And changes NVMe driver to make use of the new capability.
>
> This helps to
> (i) enable the more common case for NVMe (PI in last bytes is the norm)
> (ii) reduce nop profile users (tried by Jens recently [1]).

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
