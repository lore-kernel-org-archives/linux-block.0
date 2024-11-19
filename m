Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68943C463
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034208; cv=fail; b=aPLoVPfKklnkG8pc10+Xkq31PjkreAE3CxfuPgPFy+LMAVnHMlKKlbJA8dcNQq13VPhhdNQEGu7Lz/of156/EUywFDYEq/piqSqJvIlMvA1OVL0J2yqRhVnqTBiYKizmqKosPfdFuRKXzdWyeiIJuZl6CTJ7AZ8FXMjDRCPfObo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034208; c=relaxed/simple;
	bh=SVDrSKIV66KQNi/mRW/BeVR6nh3hfYTnyjy4XaXZp2w=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=TmV3XW6Zf1BkRD1GNNgDgv69lf3bVX2ac2uCYevf+db8VJkift3DCCuQUoKmpn6SVerZyArMOj9EHIIGkX8CIKgaSb0fiow6kPSxj91/OCzrVwNyUa+xrhtkZT4Ecb28V1g4N/sChkVQbdOpXR2K5PRH226OilMxAlYyvy74+Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FoqzgZ1G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ox5I4b47; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FoqzgZ1G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ox5I4b47"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGMXpb002653;
	Tue, 19 Nov 2024 16:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=CFdCy1B9//s018R72n
	fWGbs5lEQI8V7pR5ZyUrEW4Ak=; b=FoqzgZ1G6y7BuwdkK1H9A7Y/Hl1aFniTwZ
	Zrnosm5iJw9RwGKyGcwUHMZDAfo+JZix4AmOVCvEYRNlt4a3QQEAn8gaj77yv9QL
	xTEz1dDPjNp+DiHl5MrHKooXOhwCykFKiBseChPtkkhKA/zcaJNDfUsjMIu5n3ui
	KNE2M7W5EXpwrrkDK9pPBhwD1H+qS5MAcRbtQof5NLDk+u6PtNg7MbtHxBGQ9nNb
	7qjhy38VIEp9R5hCovsZF2DynjUL5+Y7SB0GlHyMdha+82PJQJ0kj1ngVuHi1bNb
	mzNQBSsbwz6KxmC/pPzqtXSnCJZKKePdk6b8THkdF0e3vhFMUi4Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebwenk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:36:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFRveM036931;
	Tue, 19 Nov 2024 16:36:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8tepc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eokJ6dhxurbrHFFOeQQugkk5jPvk13r0p1K89DHBhc0SuLryAKR6+KZs78qePvJ2zSAAuZ4/footaC2zm5iT/OpWvkyzmTLjq7k6Miylf5Mr0m7HCbJyXfp10iBbsymSQaLKdQO/L6hfsKIpfCKdazwJzKgjQ4ClZpITInhXa5I1wdsplN2B7ok5yrg/9x5ShkCBWT4pNlgz0XLg4tyULU3EhwNUoYgcuM8Ail8pW485kHA9xuWepHlQ0jwvedZwF0D/SvUzSc3RB22IS8m3Qdi1YjgLFCLUqqdpuBw8VR3p6nwRdCMMId7dlXAITru9KoLzThlHzRvIKnvKFLrZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFdCy1B9//s018R72nfWGbs5lEQI8V7pR5ZyUrEW4Ak=;
 b=VWvLikrtvNnotFIXXiXe23xlZy4uRKQ3tabzfIw9G32lxCoaP4aLrIeHOtGmwVCNjGv2MOdKl7gn8CR+qrML3gtouCVINHKm1LiYAdi7BXg/biBjOMU8SNP11Fdgt47YXbVI0ujQxSwBvslU1kSQO20J3kYkaSlNZOukq0ev+IkIYDErPu/k5MvyPvUDlGo3jpruvAFhAw+V0b61mRYca5ChtiTAtEbBhqSjDUbFcsb+1ETaMFb8qHYu7yM1xrWCkVtMJihtXVzfc3v+1oPDLisiE6hOLcqUOXvL4Jas8E5ZN3CxfdQ/NjvsgSBl28dOffc7G7pzeQL5zkx73FXTog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFdCy1B9//s018R72nfWGbs5lEQI8V7pR5ZyUrEW4Ak=;
 b=ox5I4b47OZ7kfTcdrfvsz8lUub5OzuX4YhTkZNTH++Upx9DCEpdF0bsGz2RnJ5tt84MFk1oWjK+HsjeKUaMe08Ue+DhkXsIFlRZYcqsneXWohxZ2Qnqt7S7fzumZTGyxDQOnpAGcFYMotnzNlSw47dFLyTxts5pyg0jPGs5m7Bk=
Received: from SN6PR10MB2957.namprd10.prod.outlook.com (2603:10b6:805:cb::19)
 by SJ0PR10MB4622.namprd10.prod.outlook.com (2603:10b6:a03:2d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 16:36:32 +0000
Received: from SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c]) by SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:36:32 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: clean up bio merge conditions
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20241119161157.1328171-1-hch@lst.de> (Christoph Hellwig's
	message of "Tue, 19 Nov 2024 17:11:49 +0100")
Organization: Oracle Corporation
Message-ID: <yq134jnrxj1.fsf@ca-mkp.ca.oracle.com>
References: <20241119161157.1328171-1-hch@lst.de>
Date: Tue, 19 Nov 2024 11:36:29 -0500
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::21) To SN6PR10MB2957.namprd10.prod.outlook.com
 (2603:10b6:805:cb::19)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2957:EE_|SJ0PR10MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: 63817902-acb6-43f5-1f8f-08dd08b85351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pet+xblITAuAfLVKerU9k3ddhHSQTUOFzjGALnj6wSdFf5hohCf+RQGQ6gqS?=
 =?us-ascii?Q?jC2Ftt0fb+gYJF7RbgFc7mhTKUzlBvKQSWhWWTkSb+B7LNsMWuM/JEFh2W43?=
 =?us-ascii?Q?rii8rvwwwEvSMjB13Q/GAZkI6kluzZHrwu1fLkWrllARpXTLb3AvAGljnoYg?=
 =?us-ascii?Q?1+ACgTSyKliW5D/SAVh5GmBux0LYummEqmKk2i8IpZzeOmcbvxh/EX0QBhvb?=
 =?us-ascii?Q?Bg+oXePVgAAK6mEBH5E+g9ISoQlvHvEePIoTpDpGExzemG7Edo4cOHxpTet9?=
 =?us-ascii?Q?6cVQwJDOJYzH8uLHpBqBF348aulyUUjHyJq5HUkpOMxz6n+wLHHrcHu4dFJX?=
 =?us-ascii?Q?r4tIEPSDILAAZcwCuN6rnf0BJnGoZyihHhvffUCMVHqtPfUW6yVvwQk3CMqZ?=
 =?us-ascii?Q?07uyAhOcAtwVGD0Ndu+BWKoysG0cC6I+FqZGTSE7I4GiKRfN+jcIj+gTJJaC?=
 =?us-ascii?Q?Nsnskggi6C0H3uqcvynfTJI/G3XjIFBj5ipR0XnLWU6lGIjjNvernz0uzOJ0?=
 =?us-ascii?Q?g5w+JwtTDPyczC6VqhyEIJkwggvN2hMD3w0Zos3FeDjQ9nlTBB/02svis2rI?=
 =?us-ascii?Q?7L3Cdv2vKO9TVTl8KPvMB/FLjsKp0eNWqZq35PNSTaYMNHhts8dzHJZyIB5f?=
 =?us-ascii?Q?pCXcLS7NVuubnPSR3mo05ZR8SV+ztV2BNEP8FNLdBjkDv8Gla7IjSoUrOS/T?=
 =?us-ascii?Q?OiS4Wqr6FdTgbBBQdAo0xoyrWMa/XJ+fpzE89eDBgmK2cLJw0gJeC8RYlTRd?=
 =?us-ascii?Q?xW/bq0u4KxeGwMw/huhO/11tOr3Hts4mtjHsujVSh27Axohu4crUkJLXXhiS?=
 =?us-ascii?Q?8facMODgwYaysanp8IMrtAxG5jnm/ntWk/6znKfTF17sSMCvLr6RGipgzgCB?=
 =?us-ascii?Q?LxJrFUP6XZd3CK5T5z5jEXXBDmgaxdd3AJmEpTjjy1jdyB42jPUFLaGwcSgh?=
 =?us-ascii?Q?mj+ZHXk1GKJZn2XcG+9Xk8rqaJk5732qONnWH8Wt86c3ZSXmEMCr/BWiPCri?=
 =?us-ascii?Q?2Gv5KSsnTubYJ5lL9p8f9ruYfgvhvYdlS0WSbRO5QWImk8NaAPyvVunH7aFl?=
 =?us-ascii?Q?KyLjSQAK50FCzX3d+OT6uWyGNv0B9ccO9BTa0IxW6o+bFl+QOKygqbBzqRQ8?=
 =?us-ascii?Q?yUjKt/6jBKra2T0xCvHy3y05uM/qyT1XllwMDLV/y1uXLXUWwrjtoX8tH7Nv?=
 =?us-ascii?Q?fEYnvOzZIoTQOtaR1BLayYU5oMGvGV82Ah2PTfc7tfZOP90I3P5lLb284CCC?=
 =?us-ascii?Q?hK02jFFsfbxTaeZEFzbo+q357TTrL06dQI/7D6MTdLvtBpozelTwkeZOjCt7?=
 =?us-ascii?Q?tHLHyI8nG6pt3GRJN4aWooZN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2957.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4kaAcRX9Mx5pZzD5fe8N7hxjMvFMpHtSFlrPf/asjXPl1zdnPA+ImsXfVwaI?=
 =?us-ascii?Q?7Q/SAQbA+ugwrBcXrVQ+9zxjOk300Yv/FWX/oQCFWp4LRZWepsBf+7gUiq+X?=
 =?us-ascii?Q?xRPlhAaUvdOqK84BGCC0EAaqm10tpMcwy0DJMLUtKo1OcUzD+RnUKfb5AZcf?=
 =?us-ascii?Q?13Tkyg0Tw03n3w6choNcayLhJI2/gcDzm+z6lE4I1iHzzJFtrIIqLGMU7IJu?=
 =?us-ascii?Q?GQd+LonuNRDR/fDTJUIEY5NZnfjk+zNTdz9gjAc5wOUgMFR/LjvVJPCfBMfN?=
 =?us-ascii?Q?HPer4Epic8nq8nVZFJjJ6BSOfFlVwH0c7hvFql2WXTlMLCC1zQ5FYlOPKn2u?=
 =?us-ascii?Q?k84v4kTcMjZVPpmTqhKjxDvAvB65YaY+VXXM1IRBM/d3pWgdVttuTCwBa3oQ?=
 =?us-ascii?Q?WVdYbE1ylLaQHMtI31vBiD3t2UqfKhwmHDXdAFiPgq4+kOVKEm/KYIoaZsBT?=
 =?us-ascii?Q?ONz/81d2ixFDH1UwvTq7Nze/NszjMNrsNPAYUPTCf8nw6ZV9Sov/KEs33dCD?=
 =?us-ascii?Q?03qgXydFcHG+usTmpyDPk/NqeIjeo3yp0xo6gbJsgSbBGJUQnWymSjwKZJ9W?=
 =?us-ascii?Q?Rd54E8xCzWAYmKPIkrIuPlfA/iGCOUvyM74XwqBMNcteRxiGCuPHkTAsIK8F?=
 =?us-ascii?Q?ac2z5KVKXe9vzBCS6pEqOyYPrB9+XYnWzGpc+ueNV9emvc1TeVkYBE7daH5w?=
 =?us-ascii?Q?mShLAtml3xLyAUIx299VhjV6n5R9oLS3l8cJRg/MxQBiO3Cq9BW+Ig2oYp+J?=
 =?us-ascii?Q?oQicZ6zzN3DlEBlgHDfgRcNi5bqLl/0pMZciOX9nxiYLfXMv3JotGgZqJik+?=
 =?us-ascii?Q?aSH4vsfsU5Y9jYZ9Z1NZ3VT4WlNzF4x+wfmQVpQEfG/7V8kPOue8AEfKK5y5?=
 =?us-ascii?Q?AM/NaYGuChh7xEBq9BZTDEj9aGaWkCzrUEvwXiVUWEwKpMWO92X4AYLJSYoE?=
 =?us-ascii?Q?igSHUQjwXH+SiDpnSRIapPLbT7G4StPx5dwwt1tbVkEBxqLBjXi/Fi0/YHGM?=
 =?us-ascii?Q?HNk5mk9bXdH53JEw3HXTK2Ouq0tcxwld9XB0LLzWt/EpInfHmWC1xShBDq0v?=
 =?us-ascii?Q?IfET07vfGLpzDBMMRHGlziX3Tyi1p1hAGr+B5lT9zFHv5s86jyWAOVQmtEHY?=
 =?us-ascii?Q?DvzlQzOwGTxX5re4zh/eyBVbc8wHqVTsjLHoOkY3PxMZMI4mP+DsEkLTihPF?=
 =?us-ascii?Q?3T3sCnViJ21sSeY2ULzxpTPy7MSBjZ9EAoqSu83BagqLDEmMVTFwdFrtGkaa?=
 =?us-ascii?Q?DOHgnFChO9wE3IBDHcajgFNCB1/6B/n7VNcEmZhObMRc/xgMcgGN3n+rX4h7?=
 =?us-ascii?Q?ZzQhQ2dQYYJKWMKYcVKZ8VkkIKVK9LUnrP0pkp23iixCHi90Vsbx/jaic3s6?=
 =?us-ascii?Q?PKlDQg9Yd714ZVicDBBTXd9txuuQLWEZOEp6jXtcIXAqjJnMqdQ1NMpKg+iK?=
 =?us-ascii?Q?pE5GAeG/r3fjclohGUyT1YyI9mJw6Si9Ph1bC0vDIIdOxQW6Xdl+5neytT9E?=
 =?us-ascii?Q?Y+rxIPolBW/J36wLFKNHZxPlUn237lrsLb4RjydHVYR/a9IOrPELXogVKZr7?=
 =?us-ascii?Q?T33vlLd4L4TU7dWnICDoqRElXpx26ozXNOPMc/0PP/UIctLvrWvnNLfXMTuJ?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ildGDgIFZfPugmNL5yHvryB2ssNeX75M12P8YkSKqZ22O3JLRJliLZIcmRIo1KdQfa0Zfl3xgtIn7Ksp7KiPH4U20odJj8tGdm8uSqEZuV/fJgUl3UZ/5rwgpKxUNBvc2PK5OIMrCNtYijwNv8tCD4CKCJzTvsZsbDRtoAJNqXcX6VcRCf1BgOybATUrbGL4C6UmE2cf5YpPIrjRA0SsaqbwU2ytGKg4XTplB5DPlXiRl/9ibqa8Xi0+9Pgk4e2EwWL6hMonc46VvaT1qioUIPE5IG2M/sBuDSOAUuzo+sZl+hJ71JIsQrOxNdBkBy80tMHPBrHF8ZRg0CynwkboP+Re90vlv1iWJxqTf5/czsXOZyDTIAT0JbDieL+GqlJn7fAQ1oZ04TFeTpiuUHTVV3oBVWz6qX8ZCTeV51dy3PESVQw3J7KMfFfL2191qBLO2NGZPGAkaRXkEhfdpivLtd/K/+bme6Nt/zqfOYYc1hDpuJZIbtHZg3MjyC/U1PnGwmqDbaPUHo+JxbnmVziEo5/OvKCTNXIJRrZTxpKGRH20INrEdDCwO0752Bu6jJFKrpNPPbV2rDTfe0XyE1aWo4qlT7pmfQeqrDTzQBC61W4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63817902-acb6-43f5-1f8f-08dd08b85351
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2957.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:36:32.2229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brVCMPrG1CVQuhtjRFoh95xCFtIdYkj8VqEslp9Vlm98uxeMChr+SvYbnTNLCmoS953A7K7nyEyO3Yt93n2EzUFGjWcmxdrMjY8+fSQzHdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=847
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190123
X-Proofpoint-GUID: DDWFDydyacI-SH-aC96mBwpKy6uoNVk4
X-Proofpoint-ORIG-GUID: DDWFDydyacI-SH-aC96mBwpKy6uoNVk4


Christoph,

> Dan's smatch run pointed out that there is no need to check for a NULL
> req->bio in the merge bio into request and request merge helpers
> because they can't ever be reached by flush or passthrough requests.
>
> While validing that I also found a few other odd bits directly next
> to it, so this two-patch series fixes all of that.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
