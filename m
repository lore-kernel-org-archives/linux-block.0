Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D912C48A
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389458; cv=fail; b=fypPlyisA5d0N81dsejXioShEwr7xRf4jKXmyb9dlrS6HVEnR7uZQh90FwXuvpHBQ7rNtDFjCH29Wn+10kj0+tsBjit2qgqYf6Zh1UKWC1UelWHepHMwGf9gCaMKLbBTkkQ2hEbql7+w+GyFZtvkV/AErf0HZls79N3OG+zJD24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389458; c=relaxed/simple;
	bh=Jw8r5ZFmUqXkri2x3U/mSxG2Z3nb+LxplpbydjmkZKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mf3CMNLnkzUg+UP4suB0Q3MAUjnaWU1OwUkpr1V98PdUSpE3MKiYqH6eej7muLGszTNWIZs2ZQbki2Mg5XJOyWJtLTNK706f3akcLzf2mEy780bdUZabucwLUwfIokyDuXQVn+X/aTNRUajKXBPhqQDCrlzE8lURQ42Y9Fs4hu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m0/bCIJt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bOL2+pzl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m0/bCIJt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bOL2+pzl"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBK7xN027052;
	Fri, 19 Jul 2024 11:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=6MfvbxRTNmFuPxN+BbEGIPxPc2ZC9I+gHE49eoqu1wI=; b=
	m0/bCIJtOiaRHJ268sR4oeS4P45iN0VxpOOjqC2snR3IDLJ1CzWFKLQT43rfCvSM
	BduoVhWdpNqM46Ex668zPCyhMAu0qLxqh6mPuPAWZp7MXFZFTp/fZLtSz7vAQhT+
	hPcs9+JEOzpi91OTbRcnDcVrF5ZQEz3wlRLcdZzg1H9Qa1TCSqK4DlFb65wVqjv5
	AYQjXp1U5ndG2SixXDqzy0pWVQbRlQTqrrd++73nA7OVMU6cFMBri9uUHHqptztM
	FsQeOeVJBOmcqxWbAWu201GXFq5MIqNGSUesmZOocDGL/bBW/+IwhTUkMU3VY2n7
	zFIvcOYNuN0BDs2wQabSvA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq67g1r6-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:44:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JAiKia039623;
	Fri, 19 Jul 2024 11:30:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexj2pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk1GxaSdcePOmFiv6khMDdfx0fZS34mC1fmuTJcHuh73KGh4yIDfvpcQcViremnHiv5UtOpu9FWVrT67buWGO+zmbWOGlGrYcdUKPVwojYs6P7akk5t0I20aRq/LXv8MjMQQi0fd+9b2SnYSZXobis0GHx2jXk4r3i9KQRokN+QxCG5SmgwMUa1rdxQOGkTdZV5i6P6wljdsc93BmnroWLCMqFVMrG6Z2LiqCMoOBuc+AOSrsyiMLY5PJz7bvmcFjI2vmpsG21hd/Xb1Z9XjZmcO3vZikdLRl59bbaOsgv6dKqquRLBb+CRGjNWClGd49tynrckclZjeT02JovPPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MfvbxRTNmFuPxN+BbEGIPxPc2ZC9I+gHE49eoqu1wI=;
 b=x8RkEwKaWbXvT1utxR3kbEKPZV90U6ad8bSRs04G6xcTnfiPKmQ3FEneuR8RmCC/HSFT2x5zi/LPX6dj7lifC951GdQZi8wjGj8g392JPkqZj6rSvAOGB3bPi03JFmfqfskuqFJkHrn+32HXMT6ENeXY/k0eocgcqYRFB07Vy2rBN5uavIXtQKiEDzpBEqXMTZNN9h/pwptBCJGAhlzkSVdI1WB0gWGzzUkzL3PIpRb0dsYxnnhNb+mXNy4Omxjxa80X4iOYys/BsA2dyXd/XhQ80j7rAjQ0Czlh5F/R9czFRbU6LIXk3nlJpKCw1bANX4YzoG3onmxdNqIScxrRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MfvbxRTNmFuPxN+BbEGIPxPc2ZC9I+gHE49eoqu1wI=;
 b=bOL2+pzlQh6i0b1X6hkfeDb4Ds1qve2uSQh5xFQEbJ47eRu6JJYtRw6SLNdfZlyhb/YmXOup5wq1hfoYyqF57a1oxn4N/YElRj6sz60gKgKeLS9Y3DKFE2VDg5Wpn9q1dFB+oHAR4b1OQ3hAZ9WhNiPEiteTJsv60FNGkmjw3xc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:30:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:30:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 11/15] block: Catch possible entries missing from alloc_policy_name[]
Date: Fri, 19 Jul 2024 11:29:08 +0000
Message-Id: <20240719112912.3830443-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d03682-415d-485d-b616-08dca7e61fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xEbwjjpXLQDwAUSk7NMuvtJJ9nLZkTlGyu1erPX//Z2cnXXaQQR0ics/C9BM?=
 =?us-ascii?Q?uZDRR2ObCi8FZ4Lj6EAKdLjd6PISyvXKPfCNXJdd+/+8tfICO3Bf7G6KJ+3m?=
 =?us-ascii?Q?9tIaHzGHGNMg493j45GDQLje+dUdWGMiEsXpyr6BWjWP8nh0YK6Yk6pQv1Yb?=
 =?us-ascii?Q?iu03KfkRDjIwRISmGnuXoOMvLmtWcMrJEBCOPNvMshItZb2/yORMtTeeUkkZ?=
 =?us-ascii?Q?byWX0MzKokLjeePxjYmvCZl6ywO9ie6TqzS4yYKDjPzlALvPad5K6w22HoZe?=
 =?us-ascii?Q?Tz+Vlag6LHaVXCcdDThLmiwjPVBRRifO8TmUKDi5Vql6r29FR0ZXha4Bbavt?=
 =?us-ascii?Q?DPESwUoAxjuzfpsM+sOCyRW5o+JR+ZDWZiaSupkAZOvzEjZW/Jv/xwDhYiTP?=
 =?us-ascii?Q?EHvNECPOpe8rPISALGvEuMNMqypnCJ0Tzry2/85PmKvr+kC7Kh6aQs1nTCUF?=
 =?us-ascii?Q?ovzkpLzPZV4x6SUSLXs3Qb09SFFPHkA414DaAR0dw1FRwDdQJ3BOhf5GUX4o?=
 =?us-ascii?Q?2naWAALiaZDOAOvZL7Inh6LXFztudkKYwRobUF4ermfvx0xlcb+1h9uHfMFw?=
 =?us-ascii?Q?SXBV5c1uDwIlehergZdD9UocYywJa2dmG34HwaYj4V3I2kd9Djhz6FvU1YHp?=
 =?us-ascii?Q?7n60xKKiy5Oo4sFomYpUxSaM8/xwrvFfv7XVw9zcCog3CFMxvVmthM2ZBC4v?=
 =?us-ascii?Q?rTeOJevhEjcQcjuIjw5LyWISynrRt+51U2F1jrKJqClerU0fTjxbTsJ3sAq0?=
 =?us-ascii?Q?i5Ocwft+9SMFSHjAYaMS+VbZQDvtaqNkZVxqhq8uy/9bXj+7QgPyoEmDT9kR?=
 =?us-ascii?Q?166tDuqPo8HPK/tqkFQLJS4544absO25I8y61E/6oTO94GlT/gYpL4xtyYqG?=
 =?us-ascii?Q?PXdKoonudc7WbYSlb0O7KgisKGoEttaBEvPgAyLY/BOvdrw/21BOkWlJ3i4M?=
 =?us-ascii?Q?usASO0GmfXeiSqLPneAIq1tChYOtbSjfwuAvlQBoX4XLKi72NHFcrNVoY7Cl?=
 =?us-ascii?Q?/13t7bLnT0g4DLd6Xh5JGcXfGR8L2+ygEt4xCr6AeP2H55kbrP6zg9u9kJqS?=
 =?us-ascii?Q?F0U9tHADREBzsmG7qwY9i3vN4TzO0hct6E07B78RfZO/dJ6xUn7BGwDEsB+r?=
 =?us-ascii?Q?gG2s4U7klGpN1iOtSyNvTpkdSidiKZGxNwJDoufSKC/P3lBx8YeE/u0uW6QG?=
 =?us-ascii?Q?Cl5PFzhoMTy/WVZx8hlnuR0VO1SkkRcxMrntusnHdlVNsZJtX7mL0Dp2bA93?=
 =?us-ascii?Q?QY4LX/mRzhbAMIg7QApfC1US1Hj/4SoBPlzo9EScH6i0Lk983cf8EvyT74Db?=
 =?us-ascii?Q?Z6jMSWEDFM4ilBy4lb9IpeowsRr/c3yRbTPVK6bxxK6WzQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vP3jSsj2s2V4lkjZ/i05JARVX1+nsxFf9IqZvdtVNZuVhH3Ya8ywOdT7JB3l?=
 =?us-ascii?Q?jAPfepQ8FVXuyFVIV7jWpoVukTeJwR2jELrXbBR2YNBADa9gModDrj1Ctac5?=
 =?us-ascii?Q?ULYpY4+AwbXMWCxTnHSPXTqKJx3ciJy6o+Ffi3+Z3Yo6e/BeGVDbqhYhNzrw?=
 =?us-ascii?Q?bL5/Ny9GycVMpPtv4+nq0tOVEafs+gdM7tSNKApFrgWHdNJY9OkNX31cOCz4?=
 =?us-ascii?Q?3xIalI5m3eOhqDFbwE2Qy+vWMG3UtyBJoc9ZhCZkFrPcEnNuEXBIpq8GQJlx?=
 =?us-ascii?Q?QgJyfqiqpSIeYDh6wlbumtr7dCojWz2P7FQJlqzgLkXV3DJpGbG5Jq+h9V77?=
 =?us-ascii?Q?UVifsVM6U1gjtHi6/1fSHFIxC3aQ9N0oBacnU9VbF803NVUojwa5yHVDmcXJ?=
 =?us-ascii?Q?je00bcRDcPktUjL849RwbeHwUSbsOV78+XgdHPR/u0Qy6l4P072Oe6N6eeJI?=
 =?us-ascii?Q?Qpmoo3C29xSXgVD7yYpha6aAkoCJFQPulcS2FEk3gxUcLhei0BXnCsQEfUeY?=
 =?us-ascii?Q?nclpREjtC0RYpHTdROcyc3YK6emYwtvOV6EzR1wSm/j474k+BNKqCQsD94m8?=
 =?us-ascii?Q?ALIDpLlAQNYFulbamIaQlwrWIqqg1E77wOhzq/kqAazVDB2E5Tf3gXrt7Q/t?=
 =?us-ascii?Q?nncWX+tvGHpIFWvzUEZpQH4f3mwvJ3K4R2dcZyHu46yVQwTx61GQv/dcrhM5?=
 =?us-ascii?Q?EBy41GEas2tBFzQbi7OMt4u4MAyF6SROuoSiRzrMiohEaJS+xbKDtbTJklxb?=
 =?us-ascii?Q?wsqd8tqZTqGCNHs7VpTcq0mOip84PS+T/i4+Fc+QvDMuNB7poPl/d5FFVQXN?=
 =?us-ascii?Q?BJDF6ImiQZto07CZNkkMHBjlKaJLqNRYOZgXB0DsRs2OsowEcqD9Q4rmERAB?=
 =?us-ascii?Q?jevSTW1bnDlbSS1eZWtpnm/JkVZIpcIhMmtcw6HWQoo5XmE/J44lFZPp0pfy?=
 =?us-ascii?Q?rTntDaXxrRSpk+QuwbacqJQ0VrH0Q4ON5+5UHB/huoyxD07DCoMhB+l6GSjF?=
 =?us-ascii?Q?5eehR4Qy0DFw8Deb7EAGlySrUAAdV4HBT57ehsRFCfnDyyXR+csm5S/8qjic?=
 =?us-ascii?Q?DjnQ8Mga4Q48H3KrnGDQokH+t9yrCcEJW775GXVp9IYI902I50BsAz3+H8Ng?=
 =?us-ascii?Q?AUvMD8NBRyYMIMF8JeSXnr+toNCFO9Ckh83FdR9af+Vrm0/xNPcwrAXtBrOv?=
 =?us-ascii?Q?B0jhgLtXfn4FLx+kHtw+Qp310lKIQWx06lS6yw+GqSiUuVNWaZxN0NhESoTi?=
 =?us-ascii?Q?tuPg/BLkU6Y0x+gRIrOIGNA+WF0N4UXdwX1KNJkRUIbC5SX+ggnDPyy53wGF?=
 =?us-ascii?Q?X5VYchQilJkWOLhrnNjvn7pkOTi7dKan/EYLTYODLxHcJh51TqXxlo1MJ+M+?=
 =?us-ascii?Q?7CmLnZlowcCdzRyfAXFnyhZh8/ttPPfBeAN4rPqsdEJcWVkCcPPdswMl0q2g?=
 =?us-ascii?Q?avYUbrUAx1uJeoTbnJr7cIZ4OLV4738LrtsIlvuRtnJaYTh/MEjDoskO0zpK?=
 =?us-ascii?Q?j+4+YvDFe9HDh7BOacJzNVcg6dSEUan0EveNg/skuiHIFN1Vjk2i7P6QCE9+?=
 =?us-ascii?Q?cAFtqgrvhb6bVcM35mXlQtRt+POSFY9d7yloqf8DbHc9bSS2jNvHX64sON0k?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QwfVVPXrmbjZ480IXy0nKPj7SicWPZ1jU8HkIliC5VWAcs8HV/xx+QnymYfnWXlJQM0Xd4QR1fnWGSYdX243rmuCfgmCWBTDkqygi/JETzGEkmZ7dkIDOGiIOaPxL0yiHFhGYLjjNegXTteaHm+udk4SDva2eWQiw8J0+QqFRsS9W6oFVIVXXRn5Xx1TAVXkBAX6flmkNtahN+3RfD9lpZuGdb9qF5blsqMhHaf58gg/SLgEQHpdibYGnv2tqr/3qu3eNgWuei+P2IB2MTw6aQRU1pL8DlQBY142FwHjvJluykdZCpCMb31cLUBrURCu2DMZXjLhoJqVVXOQ3tQuGG6Mb/Fz1epiS8hlyctpUEn1+dkGl2KMWLP/P3Fk4d0wNv2hu86CtJ2hdkbCa0aic4lRyyJiA2+RAf/VcNYOKNzIeRLPYIGbLluAHtPsrFBsEhsuSj3cGQXMxvgGWglp9TOGcPNsZaNW9Hx3J/giYhqHK8VPkAZ1WGIzc4dqioJha/U0A6S8sjRaW3TGo6MRxlhELzLPookbnkQxHNXjiUm9MzGCkVHXuc+voUZnokDhqpOew4lu9OX0mdOVcarVCJGy5w+/g6zbMpcZt1uI0IU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d03682-415d-485d-b616-08dca7e61fe9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:30:00.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KhaqmBNSd3PxpbfPNJ5o08wBW3RcyoN7r99vE9QgWXOM11JAcuB3Of5+9NsUkBkLVPab/EpzeF+UPd6QCMvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190088
X-Proofpoint-GUID: 9UF0I8eOOEqVLjRYDcs_iaAzS639GcUp
X-Proofpoint-ORIG-GUID: 9UF0I8eOOEqVLjRYDcs_iaAzS639GcUp

Make BLK_TAG_ALLOC_x an enum and add a "max" entry.

Add a BUILD_BUG_ON() call to ensure that we are not missing entries in
hctx_flag_name[].

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 +
 include/linux/blk-mq.h | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 8618aa07ba2d..312e8a40caad 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -198,6 +198,7 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 
 	BUILD_BUG_ON(ARRAY_SIZE(hctx_flag_name) !=
 			BLK_MQ_F_ALLOC_POLICY_START_BIT);
+	BUILD_BUG_ON(ARRAY_SIZE(alloc_policy_name) != BLK_TAG_ALLOC_MAX);
 
 	seq_puts(m, "alloc_policy=");
 	if (alloc_policy < ARRAY_SIZE(alloc_policy_name) &&
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 27241009c8f9..a64a50a0edf7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -278,8 +278,12 @@ enum blk_eh_timer_return {
 	BLK_EH_RESET_TIMER,
 };
 
-#define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
-#define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
+/* Keep alloc_policy_name[] in sync with the definitions below */
+enum {
+	BLK_TAG_ALLOC_FIFO,	/* allocate starting from 0 */
+	BLK_TAG_ALLOC_RR,	/* allocate starting from last allocated tag */
+	BLK_TAG_ALLOC_MAX
+};
 
 /**
  * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware
-- 
2.31.1

