Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DA157A72
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523171; cv=fail; b=M8A9hANcV+6xN/LBzRBUrtdkfet8vOeQFJXw5Q2QTbdfnQ9Ku5ka8J8yD5fFKNyPZRY3UGI2bnmgbX73/pc8ug1cg7qab1puK9njusL3BUDeZJ+FIwFgO9OHkP/jvqANdChswr+R+SubqrsShzZp5Z/p6lQ+/j9/pL99TIYc8J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523171; c=relaxed/simple;
	bh=0gPrLrf5GZLiPez9+kIcQXccE1qWHGFyueiHuHdacio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILYMEZvI6CYSKuEXrHeo6sZRCdHN4CUcon8qFz0W9zqlpdC7gddj4WJvWFaBDOkIP0gQc8TOB6Bp0c62EGMueOwW5KADu0N4L2OFAud3FT7cRyYwaaq+zP/QF2SgzflKdx7g/KiOQgZU5QNNL3TPPcKrYb/Op/wpmeSDAfLVOls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z2zObFPI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kgr5Q1cu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z2zObFPI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kgr5Q1cu"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tWnk029526;
	Tue, 9 Jul 2024 11:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+sySfszejTwBfYhCRf0axrDlVa4OKzsyUDayVCx3RCk=; b=
	Z2zObFPIrILVyn7B5pRC4OBnkcth81P4gGN1C5mWjkhoBkrt9ljq5hp1oEfGjyX2
	IKqeiyy1vfTruxetH8i76vNc+BD56AUu40iv3tFK64CV6dKws224P7WnZrNTir8j
	ukjiHt/Ik2F/Mtr5Md+zo6J2gc3ngFa4xshvfZmgy/gZDJjrMsh1oURok/x9H6dj
	LvmewbRRsJE9NrLnkupycdlO/abRC6j0LDEtADcol/C+9umrNdDDwQ5GTbIwQche
	WTJFOmttRNcn4MEdIewbWH0fY/2lPnc4NOAiMtD8/9SEwNETTp8zeP/YuHQxImhZ
	V8a+IjYca0Sq3z/uxdd35w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsmnr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4699Z6Je007435;
	Tue, 9 Jul 2024 11:05:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu31m3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:05:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKyzc1/0R8zrr0vykKlLM4PmYwp5sdXouYCjdEo2LwBoGvWSjO13VzEs9k6BNk5oKUcAKQ25+MpDLdkxujn4zVKg6og8w/fnhM8RhGzk3AEM0pcERvc08X0B7IfEKjc/7mZzdAH3sWEckfsue7qzxrU8K0jfwPTuZR1iaJQ4kpqzk8MB3seojphV08Ay4+HL+vGdbbB9GzHd9n/vKDlgDNy0Rbu9pIkxTCG8K+t89Xe19LFW3dGmZifDYswaDPMPVuLg8Ll4h/pRHb2O1SLznMML33yUEHCxZtZvhCgO/mIqrjJMqlRfyoQPwQUG9xqrpeBko5snDseUeYKumwRyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sySfszejTwBfYhCRf0axrDlVa4OKzsyUDayVCx3RCk=;
 b=S1iuF8dFAt6Q+vNg+DLSlSlSD5bDUPdxCRktdBCozehU3GI6gJ69hARwIaeOuFsfv/J16gFHF4VVhsysZe3V41RD1C1kymKlJg9HwCAt5eF5gxMfk881xgu4FIop/bneXH8Nbgm34TjqKu9iTzJ8FHiz+qW9mHFriWs4HhJpvucUxA8G8DQV3k7Fpfv1mWaWsTkLL62W5i8IGBJmMre8Fv/BuVSOLe9hqTb53l86dezv7hJpKWOXzAq1fqnLiOBGo7ouFuEZnaDsWefZZm7KXjllfrrpotA3MVfQwKgluP8FuIPhqerkha6VR+WiSeW8z1R+UeF/PuC5q/boSi74jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sySfszejTwBfYhCRf0axrDlVa4OKzsyUDayVCx3RCk=;
 b=kgr5Q1cu2kVwaNudxlLWNKTBqCL5B3zC+8C/GeLmDxYFJDt5HrbnvIQTdDqO/VXlf9rpfJvx1nsQURD6TbWQWY79PORvjeU0oUB+g+aZ3ITE2v7Ov3TRz1v9QZo2HEKDhO7j7/GM1sO8yohJWFhikr5DAGR5tCuUTy0yOh9gwU0=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:05:56 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:05:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 05/11] block: Catch possible entries missing from hctx_flag_name[]
Date: Tue,  9 Jul 2024 11:05:32 +0000
Message-Id: <20240709110538.532896-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:208:32e::35) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf140b1-6f13-4321-581b-08dca0071b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ryk06/9nkIG7WLWfhWxAyQCdYUNx6oaKekTll7KGjd3qkIQa8lL3M2Ru+yIa?=
 =?us-ascii?Q?nCptMLlwhcp4t7/GvyiRYYXmKE42m+h622KWS7E3Qz0u+kN4yOypmVuUnzv+?=
 =?us-ascii?Q?4ik5UNWRI1AiV4bnKsBRd6srq/47plzUC1YZLG/39Jz/qr5dWF5UsVeNhcej?=
 =?us-ascii?Q?oQP6fG39eD8r2Jp9Y0hajdqO4T3Ya5yWNgQ8TYB5mmDuSyCPvFKFKsU2fjQe?=
 =?us-ascii?Q?1JQG9WPn0e/sSRJ2CZaTJqVRRameZmjm67i0ya/wnq2bKFEh1iSJiM1A4e9r?=
 =?us-ascii?Q?aZ9p3wPLMj1240K4fZSf5b59Qc3mjK5BxcyezaxIJMF7VNEzTEv96SZwihYZ?=
 =?us-ascii?Q?DmkC6RUWD1imu9j64AYwDHhhXhrJVehVMuHQAyfUsQx++YUnRdgRuc1xCRy/?=
 =?us-ascii?Q?z2u6I/YYAGCuPcy7ucN1iAMf4A8F8rHM0GqWOGpe3/JdcRhdnamn0emSDZop?=
 =?us-ascii?Q?tw8CN0O9rnelpfObq0NazBiXAGsqGaXshNsnfXfvjgjG/1JuZqY2yom7ZM4S?=
 =?us-ascii?Q?vDoDHGWTu1mtTe0OnSSXWB2PlNWUyfUaNkHFW4OIVwxSKP2aQoUVgI7e61SK?=
 =?us-ascii?Q?6cblXBKdUTPUiau7Ufx63PbIeY1JYE1PfI4Lm5hq/R4efF8PXCzb2YDAnZ7K?=
 =?us-ascii?Q?uG0HIJ4SN/uJNm2F3stu373CsMGK2dIiFrGVPKN9dtim8/UFG0KRMLNV2kDE?=
 =?us-ascii?Q?waPlwx0Ol1pUhAxQ6YLZw3Slq/JMlTcXfcGdwXqzZjg/PyG0SRWI5+7ahnD3?=
 =?us-ascii?Q?XcpqB4Y5k6sa3LC1ZVHcQd00CkU0dr2I78WJnuEJ6EBwafJ3BP//3ftnXfi0?=
 =?us-ascii?Q?1mXvGNzyiAAvDifxedAGecVmbdHe6zIV7aHrG53fnJeRVbnDqZYmd8x4NrBo?=
 =?us-ascii?Q?YUUid2o+G4P3qAuPn90rqp7OisdgMxkwzmH1i3m9iNJKfjn3SuAXP5f2o/B+?=
 =?us-ascii?Q?mW1+QCix9nwLLetrCbI3unWkPGWttnBJfRZlvGJZP0S37HpEZ6X/Ww80TZ17?=
 =?us-ascii?Q?qfdEf/Sfw8pgacm3QzuFUe0MvMXnNkQLsatRxZogDkiPTrCm1l88Fe7G7ooU?=
 =?us-ascii?Q?Okb/3JmfCqJ3ZNQIxjBGPHLvGpXpnQWAjkmqvt5tpyQcC/Q0E78cpZR4zNC0?=
 =?us-ascii?Q?9Et8Y7samcmssuXSXsU26XXs/NVXYZazj4PFosk9PJc0ZPx6GIdI+6W3dlgf?=
 =?us-ascii?Q?uGNvZB3QoIvyFjG1EdmjMggSNpckAyJjWi3qT/nBnWAAotiJ2vM4cRo2VFYi?=
 =?us-ascii?Q?Jrlleb5j70bdCVmB+cZCMOSQMeqakqxMHh7yqrQ8BFwAuxF+D4daSbSR5EPN?=
 =?us-ascii?Q?S4s4pwnBw1FBJ3fP2DLCmWtNv3PDRp4Tlxj4BEg6QGT45Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H7Owuibo28NDLdS7v9OB7AoCjLxPfcqScuGXVX5cZ+0Nriu5uHsZlQzJI07B?=
 =?us-ascii?Q?rnXy1NswT12fGR2RvJbIWO2OQL8fbfEuAXzGRFLCSihX1u+3+xhvJzZ4TC6F?=
 =?us-ascii?Q?LGBwFRhNqSNFPxCA9v0oE2LHsYOlt36M11LZ2VWkrnS+DgJiddipJgbflkvz?=
 =?us-ascii?Q?fXRGWhXgbrhjk5YI0gxJMDm1N5D+3JOuCN6MlCKNbi1TbLP6uVFJnbMeQLMX?=
 =?us-ascii?Q?6N0apyw2lr1Ae4SlYCuYs6z4YWsqF1dgHhUE1mGii0Sl80CV1RFw+Cpyf//u?=
 =?us-ascii?Q?IumntM9M6S0nlhu4c460at+aFhP4Svh3tYK8NkPfYNpIbBzFcJHJ1W+knDjo?=
 =?us-ascii?Q?XdmiV8lCJBNmvujBs2TFCjZ3riR9wKj/vjzZAZkXSoDgsCIK29BtgJXJtxAG?=
 =?us-ascii?Q?HUADorU5WQ8YeEGWZyxIpfI3DpyYnEMDQGDv9lW0eUwC+EhPmpbkGoR63XU0?=
 =?us-ascii?Q?lAbdxp3GORNEfHJGLvcvTKIDQrEkJzP11fIsRqrjfbo9PDeptH15zDxIu/K1?=
 =?us-ascii?Q?WlQYMPRuD2K+ldUuAhkVH9M2mYWzZBwHgHysjWu25V5PHxpMQjirkEJacoJ0?=
 =?us-ascii?Q?5ndy9gG1+23GevrAuttYcUpheymIQAeNlrNedXU4JN52T8v90WyCSYp5fbps?=
 =?us-ascii?Q?TiLMj3B9lGNvFAK0FY3OWemBIWwYK3weNaT85PoUb0lXrNsK7pzqyXW60TrP?=
 =?us-ascii?Q?dMeUcCnA2IQSWwgefjwj+e86zlMVwXZrRbLHdBj2wVUD7vU+kMmCeJFXLau1?=
 =?us-ascii?Q?RWOlR/1+G9H80gMMP3bSO3syVUPjuihTmVmzlNb2nNIorDXGiGCL4xcXtZuw?=
 =?us-ascii?Q?N/ZTfhXtrkT0Ficr1Oe1nJeHMC7XH0iAHo0bBWcZe8J72Y9PVxNmbU1Qh6my?=
 =?us-ascii?Q?f7Qz9wF3pA8vMQQt3CTjqrsLvoaqq7Un++iPjThvCwo1HRzmUpAgkJuS8mt6?=
 =?us-ascii?Q?faf1M2poPXGG7t2d8rKK0W7HjUW70pazgkhiEIa0HAoXvyZdbDYJ3JRx7WuT?=
 =?us-ascii?Q?j/zs1mmU/t1rNEkRevbktQsOtS4s3334QykeYVboT6OAARtGdlCYPbC3vXJP?=
 =?us-ascii?Q?M2rH4gv4BYpE6+i9hjNaRiN5jiBxV5EO+zkpymDq1j0wKFh45jGZ5TFId22b?=
 =?us-ascii?Q?tp4G/HBqE2JQORPb1i6VPTRI4ZolReXsTH3O3QsOz8eZUHEkh9XTmVBtDEXs?=
 =?us-ascii?Q?vRJqRCXeAYM285YfHGzHhih0fCIdmxaviFY1L4Fm3dEFaBiGtawRfm9f8fpv?=
 =?us-ascii?Q?Q+72cLz2/Ee8RdOZGXOalqyjVttzEtdMUzBl6Du0/sSCzXPEgkTnpBCyekaT?=
 =?us-ascii?Q?HqLqqUfxzllw2cIcrNmaKUMFKJRgviGSYAaz0aKoNfRpQYWSNm6p3fKHcgdP?=
 =?us-ascii?Q?Qx4p+/Y/RnILd2u2lJEo/F7mAVTUP9ItfqSBPqqJHaT2vTUqEvkWoTRy55v/?=
 =?us-ascii?Q?4J8YH7BKi/aM5kIzbDd4HOFuoF2IF500ORJytKLTnH/uAcEPmfUjCRsGWdH2?=
 =?us-ascii?Q?udZycwPc6tj4y2u10GaUvibYuueKChWaCTN6AH3YE73qcaf24JpMqcvxTLWc?=
 =?us-ascii?Q?/3EfrUZOsa0jBYCNEhihTBAV29VyAEZBoSDCACYQ1Um6TDippA9nDwZnDrBv?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PMvGg1IB670+8zfjSuD95oxfeMMHErLrwabODKwHUVVe/gWnI4shJBWZ8unvKLOwuHuAVTzWFCYOWJZssn/jDmbz+jMWn09S693/H2RY/GaqAcXQdQ0LlUEJiJLmyXUKFJxPK7EGcFZa8Dl8vaBono95EABtcJQ+o06XEArbxTZmPdYD/S9Jh3PsZoZTf/8iuCKZG6cPpyK7N8XemPBLh7fqYIjvYEyS8drRXOVw8op2Wsgp95Ay8wgu7AbhlchpHH6kBWjt2Ubr8ChB6BhcJcuL0Q9NhHQu8GahaD9kyNfJgN7WMmTIx7yqkTYJ8gu4s7Gaa+SsAgmPPKgyoIOogUU5yIj1Rj8+0SFilQkSm47kskZkUrtdJxreNRcRBF4iw1dAp2VQidJdSfgOzi47LmuQqcDTwnPavdhuSJVlacoy8qzetYlRrmZJq7CDNJYXAsXaQ5fSo2kHphoA8wjwWmdEuTjhliu/pomhvH0R7FUBVVuMK86+7RBcNE5Mwt0tBrrZexAjk8H+0NmcpSlq7n1bEnTuna6lNxWk6EGqUmKJl+6jXmXF/I7DMFrnEUKkn6GfHQo6L8RCZ8kbLlpC6Bj7LfEPI+RvuP2S1Dq9v3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf140b1-6f13-4321-581b-08dca0071b5f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:05:56.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKTEJPQczkHotcUt2AT1Zi/BJWFoJ2s1BmBGYmKl0nEMX44tvGl9HwYi5AU0Bw/MXAz5koIbOCkjJutnYm6qRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090076
X-Proofpoint-ORIG-GUID: bmAJWwhRO9CLmeQN8iNqvg-2VPfm2GZA
X-Proofpoint-GUID: bmAJWwhRO9CLmeQN8iNqvg-2VPfm2GZA

Re-arrange members in hctx_flag_name[] to match the enum in which the flags
are declared.

Also add a BUILD_BUG_ON() call to ensure that we are not missing entries
in hctx_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
BLK_MQ_F_MAX is a bit odd, as it is a bit index and not a flag.
 block/blk-mq-debugfs.c | 6 ++++--
 include/linux/blk-mq.h | 8 ++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index fca8b82464b4..74f470d0e1ea 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -183,10 +183,10 @@ static const char *const alloc_policy_name[] = {
 static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(SHOULD_MERGE),
 	HCTX_FLAG_NAME(TAG_QUEUE_SHARED),
-	HCTX_FLAG_NAME(BLOCKING),
-	HCTX_FLAG_NAME(NO_SCHED),
 	HCTX_FLAG_NAME(STACKING),
 	HCTX_FLAG_NAME(TAG_HCTX_SHARED),
+	HCTX_FLAG_NAME(BLOCKING),
+	HCTX_FLAG_NAME(NO_SCHED),
 };
 #undef HCTX_FLAG_NAME
 
@@ -195,6 +195,8 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 	struct blk_mq_hw_ctx *hctx = data;
 	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(hctx->flags);
 
+	BUILD_BUG_ON(ARRAY_SIZE(hctx_flag_name) != BLK_MQ_F_MAX);
+
 	seq_puts(m, "alloc_policy=");
 	if (alloc_policy < ARRAY_SIZE(alloc_policy_name) &&
 	    alloc_policy_name[alloc_policy])
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 225e51698470..b3905b77f375 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -644,6 +644,7 @@ struct blk_mq_ops {
 #endif
 };
 
+/* Keep hctx_flag_name[] in sync with the definitions below */
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_QUEUE_SHARED = 1 << 1,
@@ -653,9 +654,12 @@ enum {
 	 */
 	BLK_MQ_F_STACKING	= 1 << 2,
 	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
-	BLK_MQ_F_BLOCKING	= 1 << 5,
+	BLK_MQ_F_BLOCKING	= 1 << 4,
 	/* Do not allow an I/O scheduler to be configured. */
-	BLK_MQ_F_NO_SCHED	= 1 << 6,
+	BLK_MQ_F_NO_SCHED	= 1 << 5,
+
+	BLK_MQ_F_MAX		= 6,
+
 	/*
 	 * Select 'none' during queue registration in case of a single hwq
 	 * or shared hwqs instead of 'mq-deadline'.
-- 
2.31.1

