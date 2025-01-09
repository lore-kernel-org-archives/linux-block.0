Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EC216616
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422818; cv=fail; b=OYvP8V0Z9wlgaHGHhl++KHWCp+WY6EPZmNqSrYWR89V/vgSQ9F/Ac7tdNezcrpKkvTBvemu9SmM0Exzur6eMj49KrCZKmjYOxGDp7C79WMKuL7SrQkj79o8FEcBz5k41mQ14jbemNnFmxxlG1yU81efnhoKQHth2Ze/U64TwU4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422818; c=relaxed/simple;
	bh=wMxlyyS2Aooztb1kdX3mISCabrpdEWl/k+MQv2ubcYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEOMfuhfZpFvVltaMI+ad8qEiF03besGdYufMbZptO69s8fejW19zLfIqUJpAYfYY2JVBRBPYRmDkoM2ujhxflElp6IEM/Q5kxHNDrJw5BKg7SpvwgWxqJngmsXMNkd3wNz71Yt/0Y7EeZAXyWNNVUwylsTX8j9vfZePdMhiO9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LPZ+UpJ9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EjseV++D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LPZ+UpJ9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EjseV++D"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5098ltQT026519;
	Thu, 9 Jan 2025 11:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XATyJ1QSEkvh48ZVfIZN7Ix9lkUPvB5y7dTXmdPX5hY=; b=
	LPZ+UpJ9UXVZfhrz2DUgQg+aWnkAsU0tLF5Et9b3c1Y3gUvv4jItFt+pAnsHwPXZ
	ytsbXHCuiOUR0Dv6POt6nNP+OZbjUOq1Vq04FSiPylNBGuz39x4PCaAJmfnpmz4K
	wO6iEDge+hOLfMhVnkaPB8lw8OIl6UBdaw+VHjuGlacYdnA662TXUxiRQx4bB3tX
	Hb9Z1FlvuY8/JsJirKDOSAmW5SazyCFHg80JC/Wei3TsR9rAFY66HIEdnLjf0TyH
	nOK/At6SZl/FbYuUkhnZm5ogF5UnKVfrAPOJIwKv9dpJzTSThq4chuVOgieLzr//
	mWOYYeoVfX/1DrPrpjcLDg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442b8ug880-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 11:40:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509Ak3ch027555;
	Thu, 9 Jan 2025 11:40:12 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xueb7vfp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 11:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhUEOEOruEjGMrQTnrWriujOG13leCh6o/7rqe16bZfFZO+h7L+QEHmLvlDDF6qfYqIqDIQ9uWclLmWVAl1FZ6d1Ro30oRlPoKompDOJgL3n6BypLdAfxatxTt2mCQ+0GbggBF1h4WRLfa6PIXOFL3MnxDyKLYrD2sTWdPR8SRTZ72TrJdykUlpgrRRyJSUws+dohL8Ir9o6Q6iALstSPgP+mlJ3cRmrRcaaW+6GmXA26M3HQ2W2ajj14qNwX0RUpD4nYELZXjvdgVjKNvtQcxH8rM3wgXl1ETSC/BujeURdSBo0npMVPfnWkkt0ZbCd+b6OmF5tcVsIUho6lqhNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XATyJ1QSEkvh48ZVfIZN7Ix9lkUPvB5y7dTXmdPX5hY=;
 b=ZphieErOyrDnDiXalidULNZm0fcZ78VXE7WPYiB74L/Eg6GKao7catf1xMtfUwMLNcz/H3Ww5LoWW5dVqEH3DG8ymXTxUiwlN7hkwSSyh2+AR7+hETkQbMEm+Qv+/eIO4YSiEvpQYYuo6WHwgIu+wHEZlbnmzvLqdzFedCcD8X16JUMWdqvkCklSN/yQ0uIa7ukGO5PtL4iyuEARUchLBDq626faKGeU4LM46FXzpatJt1pIuk/ybGKapJCwqK+hCQUUGqiW5wpIzuEOCPcRgF3JFPosYLiQ6keE7Wm1J5g9yW8om9Des08rB7/g/nolZCP4C78dRsi5Typpotanuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XATyJ1QSEkvh48ZVfIZN7Ix9lkUPvB5y7dTXmdPX5hY=;
 b=EjseV++DglXAWqrIBfdDtcGK//XAyJXgSJGSj0AQuIPBRq8zjJ0Ys27K3LDDEKPur06nidP9Rd1bzLn2ortGAVzyy6cpPaUev/3pszcI3pkaHrkzTTxseqNEft0MSDEh7iVrXPmck28rzZG0Md28Ioj7Ek6lJPJMI5PbSsGHlGM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6067.namprd10.prod.outlook.com (2603:10b6:208:3b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 11:40:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 11:40:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/2] block: Ensure start sector is aligned for stacking atomic writes
Date: Thu,  9 Jan 2025 11:39:59 +0000
Message-Id: <20250109114000.2299896-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250109114000.2299896-1-john.g.garry@oracle.com>
References: <20250109114000.2299896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:408:e8::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 8defd67c-7cd3-4d81-0103-08dd30a25f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/EiNJCR6u44giphtjPXqyab4ZCW6xP5lvr7oAowiufL7ATlL/jvXZjl/VLae?=
 =?us-ascii?Q?IOA/mSK7QF7weowoikvJrrSYcrRpY5YnwFYHdePfYvNoyWJb0G/WOVvhgqj9?=
 =?us-ascii?Q?LnFLbdqjyEqPHklrrSC6cs85ARce3QttnQn5gmUxM/BFO8WNFfBtC4kucmdf?=
 =?us-ascii?Q?AXJPlRUYyvIA0YwcDygkcxoQlp1aaOwnRoFpTfylkdMWoOvbbFQgEISyXn97?=
 =?us-ascii?Q?qmCakQ9yCrd7GB+ms0hX/2Q+Ukd6bW+sdNlgKCCNUllPAihS/lu0GPvhbfKd?=
 =?us-ascii?Q?a+/0CI052Z0Zo+FOkb2pvRXZoaABmyaIv+D3pFNPayrz6y4sC+wq4pMOPu9S?=
 =?us-ascii?Q?FCBoHo4B5Ggzm6ztFyK5JCoa/5DaRxYeNAh5AU3PES3kTYHOL0gcQ5nM7q1n?=
 =?us-ascii?Q?zwYkZEWEPGOGCJ/75XMbg6UeUnx14dwVYw9CTbDiJEIX7U1d0nEPsNaG3F1L?=
 =?us-ascii?Q?8qiG6R4I6ps6DqMwVPTBBM9SZjT4qXCWerjB+9dG7eBQeQBXFctzJBg0MjBx?=
 =?us-ascii?Q?0CHA2RCVZH7pkPct1wRcLlglN8/QawAJfrX0v1Qyt6o2JB1jR9didUcTUrhf?=
 =?us-ascii?Q?WHNbtr2IpL2PBVK+PyC35WQH9TX+8BXbkLvO1TQmUg9VVUjOO2ywcujSYK3X?=
 =?us-ascii?Q?n2TwqcMBsfnEYj7ze6jw4p3KoXCRHmaIvg3VWTNMWXANgI2zgZGFk62aM+w+?=
 =?us-ascii?Q?CBIKPKcZSmDU0Y/9q6SxyeILgMCraZ2XW4CXD2kuURzZpPI2LsJEMSU6p0+I?=
 =?us-ascii?Q?WFSiH27AGVW9UecPwSEGHfIp5j10Jtkc1qdR1jyllaspLua3eoo0+6V0LMV8?=
 =?us-ascii?Q?74fu65je9+zSUzbmzD9dWM+OddMiNeE0u5tF2R+1qLE/TufYYBAMO3GCXzjT?=
 =?us-ascii?Q?sswlIkTX1RI+eu4bRKqFP8UDO3ZNQsGB0S0adSFZRIapnPjiFyqKvyFff9JO?=
 =?us-ascii?Q?7fR6yrR3Uqegf/vkv+rcm7eYxI7XuGhustR31vSlA7LmAmpcrIaQkX9UAcdz?=
 =?us-ascii?Q?SqmMAwyBbL/kmKJXN4lsp/vtqjcLSp8AWvHcJwGxjr+onMgsFz8bbqZFP8m1?=
 =?us-ascii?Q?xVoxKgKOQxzuvRkiBCjaf7jOIp4ycvHmwX1KwaVMg30RrUMmqlcSZkwsc/5I?=
 =?us-ascii?Q?JqDMEpHdDf+bapOpW5ztV3ig2ERG8GejvihrgsnB58EZc2/a3TwOtEymmZrS?=
 =?us-ascii?Q?V5Q8bTFbAIQQ/i6V7GpZ8oeRttgolbDB5BH4ieplbyCwEb6jF+gfhI0GmTgM?=
 =?us-ascii?Q?fRx01mvhjHx/yTyqpGon0bq9H1vOqdz/HQdmwP9H6iTpLmIptsPwEtC4Z9oE?=
 =?us-ascii?Q?rIAQ9vlBz7adNfhXEPY7j9vqIqpc3KYr1EwmZnlBIqE43Wl4Txi/rmt1S1TF?=
 =?us-ascii?Q?L6ZrrTRLT3s23kgneUDuKsfFScbG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CnbmjOhNs+wjr3FhBrAxDEnYYYUTbvQFQ3cBqPh2eLN1rlHMJ4ocaGI2ryev?=
 =?us-ascii?Q?FMjxtYuJTcYdxYgb5b8eoBRetMcg6e8kq+dGbt1kT5EMO0JNZM4KBrPdHXFA?=
 =?us-ascii?Q?eNgZ9MlH/emG5LdJw2qlOV7Jw4P8g3Unu4UTvlHr+zpt32iiP/pBjIb6wcNw?=
 =?us-ascii?Q?4OtUSRU7Cwb7j+bvphWu3RfmlHDF6sh/4aTy0i2UmZyg+Lz7BnJ0GvmKXpyD?=
 =?us-ascii?Q?p/3par5SvXapF7ETSEep9zJrhKzTqP6FtiWUQjmJEPn9JlEFpLlOUQXmFHAY?=
 =?us-ascii?Q?g3oK0AkMngboVEbc82Fp1k0kyxvok0IBqhqtGFjpU0ZMDznztXlr2//mHftL?=
 =?us-ascii?Q?MZSMUdYSd77bPva1q+4wLWQBt07/fG0toxk0Bdk3XaRvtUaoXLE3LUPeYojW?=
 =?us-ascii?Q?/lD/C3DtYjadtciO5E471Ezo2fNyV742yLg1WSAlSN9/UmHXC8v3SY+6uV+j?=
 =?us-ascii?Q?TeiJz9zKGYYuhuXbiv3k3vYch3gwzYr4CFMjawyrHyku+OVcQBEUven47ap6?=
 =?us-ascii?Q?HdXYErm0vS2+g3tRMfQZVtAuh27ccYV+LxTLCBd0FVp4GaxyIR6Wy07ew9iZ?=
 =?us-ascii?Q?L5QSl30wrbD0B5gAFFWDeSsf555on9P3HTuHMYM0qutfaU5wjIB8F7nRp6Oz?=
 =?us-ascii?Q?kXfPjOWtmQVPU97YylFbBkdcQ/cU4F5ap3mUseeg02ueBT4C36gvl6XzrRdl?=
 =?us-ascii?Q?ehAK4sEosc9ze67+Yhk4x8ECxT1VtSObIgKCIZeoqO0AHRJxXbUa4l7XZLCS?=
 =?us-ascii?Q?4jcXhygJB1eNITn/l4oH3/0bA1/UeiWmQJ2dqJgMSIVcrz1XTfwwmo28O71f?=
 =?us-ascii?Q?dlmTL2VrX38gwIxvFIasKhGhWb7MBhIYj62iPfPlGZVuO8EQKekCBFtEOGnm?=
 =?us-ascii?Q?LdGGoXAA1yRGOFaF9z5U/102vAO07JcHmSRdh1oTH2d3HzBaiho6vFO4Y6Bi?=
 =?us-ascii?Q?7hoLp8L2QubOpM1FVaau1n2dUkw4FziQwKzNRZF2PBwLD2FTRRMNY85kme85?=
 =?us-ascii?Q?Ny3WQ50aA8xgHctrwylAAHJG1vJ0FrgXW5x/mDTlJFUQyB3zCJWQeP0aRvNU?=
 =?us-ascii?Q?QR7yNTf7S/iMO4SMME+eRCp/0K6cUWEcywfpT8s6qWc08oZCjkQ3PynwxU9p?=
 =?us-ascii?Q?sa/BKzfx11jqrOu4FE13W7/RVNUXTcSE/QiYqfAuPiiS0mmHg6piRkg2OG99?=
 =?us-ascii?Q?S6dyBL4RnI4a4dWUblmXOLesZrUBFgf8ee9mNMMnx++iFqu9EF+IwlHl9MOu?=
 =?us-ascii?Q?VqK9Qe2iU3v1eGWPcye3GEyVZb5maARVb1ekHbze7UXvEum+nIpptLGT493Y?=
 =?us-ascii?Q?icKe/JaGsF+n32oKVpT90NMZcMfc0oDGfyfSNH8OZg2ymc9h9uxfV3gp9JZ7?=
 =?us-ascii?Q?A2yP0vrlxWGnu6X3oyFeWmPLPf4uovZ9K4eGZxxRBL464ah/fz3HZ+S/WExE?=
 =?us-ascii?Q?qb0MjmJ8Kg+tPNOi/jdpf3xbHGqfKj5lSYWsb4uXLMTSI17oSNm44ysvOC+I?=
 =?us-ascii?Q?v8Cxl/v3OLmRLzSo2sA5AziKzZimUMcBBXcmmpXkgtBo4Xi8a1zK2qphywgg?=
 =?us-ascii?Q?tOrmldytPNNtyfqf6bJ6f6B63ZRNQfeSjsm+F6xHKOODsP3guzcplgw/eRe3?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	suwRs3BgWv75FbMSOV3OVAM/1bu4VozJ88/v3SG5qo8oGRrkiptoouumkJzbhcx/pZSu4xXMYAsRaYseJf89d+ziapyG05FOkM0R2KVcMLqi1bdNgdrc5RUovIiMARu1NzWuABMEHdoGD3sJQ8r8+RFEIVC5lW2W7Q0Hr+dtxIlyqghdtW9gykcU4yVmTm9rMMa5PPvuo3xuCgMmcg9efN0rYTBz9bjH5DDSeeIQY/7n/GhIAAuRcg9IRZIDUejWfOAput7FWZJpVdSklU84aKlKFNx1iZZCgu5Fxbf4+h59FiZbhRAlXq72eJDWgl1SZk4daMErcfVKwwNfkCwyTwL7gxGDTZtdMlVVVLm+Buz+hMsxzqUYvTjYeSxCDzJmUeDr9ulhWx653k/XKd8Nep8jzP5TpogZwxISS+GHSJaWaCoi+0f7hJIV+xpxf2pRE72UwYYANO4drsb0dlkbNa1KPB6truxuOu9rKwZFxBrQr06Cwaj58Jvvke7MYAZc6tOoMjL5GN4wu5OvByjemyugY42VY34hpmj8QKUPxJAhgng8sTHAdgy3i5PdVMhfKigg1OY1efH4qDBNlu4Nkc3znm1eq8XuV1AWlDrrJKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8defd67c-7cd3-4d81-0103-08dd30a25f7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:40:10.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ky52bGJlGC9OGrq3NTeitUWpwWCeRPpbbG5QDQj35EvNBloEE21FoNBJyQaTDISi991Aj+LImxOlWDOEQpFdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_04,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090092
X-Proofpoint-ORIG-GUID: jGhXjSt1BZ70324jKxfWBrGbB437IAu5
X-Proofpoint-GUID: jGhXjSt1BZ70324jKxfWBrGbB437IAu5

For stacking atomic writes, ensure that the start sector is aligned with
the device atomic write unit min and any boundary. Otherwise, we may
permit misaligned atomic writes.

Rework bdev_can_atomic_write() into a common helper to resuse the
alignment check. There also use atomic_write_hw_unit_min, which is more
proper (than atomic_write_unit_min).

Fixes: d7f36dc446e89 ("block: Support atomic writes limits for stacked devices")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-settings.c   |  7 +++++--
 include/linux/blkdev.h | 21 ++++++++++++---------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8f09e33f41f6..a8dd5c097b8a 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -584,7 +584,7 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
 }
 
 static void blk_stack_atomic_writes_limits(struct queue_limits *t,
-				struct queue_limits *b)
+				struct queue_limits *b, sector_t start)
 {
 	if (!(t->features & BLK_FEAT_ATOMIC_WRITES_STACKED))
 		goto unsupported;
@@ -592,6 +592,9 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
 	if (!b->atomic_write_unit_min)
 		goto unsupported;
 
+	if (!blk_atomic_write_start_sect_aligned(start, b))
+		goto unsupported;
+
 	/*
 	 * If atomic_write_hw_max is set, we have already stacked 1x bottom
 	 * device, so check for compliance.
@@ -774,7 +777,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		t->zone_write_granularity = 0;
 		t->max_zone_append_sectors = 0;
 	}
-	blk_stack_atomic_writes_limits(t, b);
+	blk_stack_atomic_writes_limits(t, b, start);
 
 	return ret;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 378d3a1a22fc..b9776d469781 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1699,6 +1699,15 @@ struct io_comp_batch {
 	void (*complete)(struct io_comp_batch *);
 };
 
+static inline bool blk_atomic_write_start_sect_aligned(sector_t sector,
+						struct queue_limits *limits)
+{
+	unsigned int alignment = max(limits->atomic_write_hw_unit_min,
+				limits->atomic_write_hw_boundary);
+
+	return IS_ALIGNED(sector, alignment >> SECTOR_SHIFT);
+}
+
 static inline bool bdev_can_atomic_write(struct block_device *bdev)
 {
 	struct request_queue *bd_queue = bdev->bd_queue;
@@ -1707,15 +1716,9 @@ static inline bool bdev_can_atomic_write(struct block_device *bdev)
 	if (!limits->atomic_write_unit_min)
 		return false;
 
-	if (bdev_is_partition(bdev)) {
-		sector_t bd_start_sect = bdev->bd_start_sect;
-		unsigned int alignment =
-			max(limits->atomic_write_unit_min,
-			    limits->atomic_write_hw_boundary);
-
-		if (!IS_ALIGNED(bd_start_sect, alignment >> SECTOR_SHIFT))
-			return false;
-	}
+	if (bdev_is_partition(bdev))
+		return blk_atomic_write_start_sect_aligned(bdev->bd_start_sect,
+							limits);
 
 	return true;
 }
-- 
2.31.1

