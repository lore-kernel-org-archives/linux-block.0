Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBB811F2
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533784; cv=fail; b=iuE2/24Fbi8rXlpj6dvkNfBS3nBgtvoTf892emjNfQviuTpq1YxtxFjtWWDo5bHP69x5Sxg2l5g56qg+VQmLnNHUwwAGi5KQh6b2BJK4NbsGLAnyWuLAYaGgnSbOY1pwsjWCzz/JzuWNP1i6CNQbYPW/pqTpmJBvU6fjCAgqbWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533784; c=relaxed/simple;
	bh=91oyGjp9GwcEfGKlzIA5yr9Ys2EDdWCNet3aIkuR7eY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pHSSbZ/2EPnDEpYUCSGavtGTVW8O1ct4xoqGtDYTj1beHbZbfsDOYElNX0uub63CS6vUuX1O7fJvU5j8vQ/dRA1pzzOBbxz+0Hd7gOnGaM6hifHzaST0zNdhN72YWbnHRuz4Zfz6nCO44qxSAc5CWg7x8e6eLYoDYP4bGcX44/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OyF1sOl+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Einii64k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OyF1sOl+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Einii64k"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LDjG8p018032;
	Wed, 21 Feb 2024 16:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YGOGe+BFCtxJb1vWhRY2mNxtv5dp+BCeADYJEhs/CKw=;
 b=OyF1sOl+O1HpNhSWxcat7vOHGr8GghA3uTGxkE2c5t3326VlwasVjFYkLqRyA6tcvYGE
 EsjV8AKhR06Bsk68lIdI+vR2HCttPkLoOF44yICwW7FGODPDUG352IX+ZU3zIWfCeXLV
 vS7gB91cJRNjimVaY6jdg4PGJvDOQJtsDCCoYkhsdwcA/iNrFAtCDmEHL4v9YRWOf/gF
 YSOFW0JkW7FWANVVp12zRcKVEDTx7+F1n7dO8LhwNpsFML4MfBFE9K+MphpDxmoZebKG
 sHZdVWoOrEfO88qicQfGzhIDQh13pctny8oE+1jXAPnwhLi3VpMNvPYqwLHGRgJY9uLd 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvj54g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 16:42:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LFqgLk007094;
	Wed, 21 Feb 2024 16:42:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89gff2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 16:42:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF3MUKKVwBdx1iWqS/At/YrNuhZ9mDnakbKPt/IA9Uqetp6aIcPTbiD339/+JEKEtATM2wdCjQ66MHOdonzNEnw6hzx8nUNdXN9FXJYw7mNwGy4++m3m3akfktDAO2AYCNtyGRMzzcH4/jzillvP+k6hS04aA+a2cAC4eaUt6r9UPyPdnm7MgLk7Qe4v/dRsuoR6i4hecfGNqFEABAsJn8xSW6u7J/gA25MF+9qeokAKLAsv8AGXuEfTOQ7TCTDUauukOOuzdiyVro7PVw66+Pf+bdZdhspOMeEQhd7tBz2NUbLa4bpyAZwrlxGTj6m/gFii0KOVGeZkP5cK86s0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGOGe+BFCtxJb1vWhRY2mNxtv5dp+BCeADYJEhs/CKw=;
 b=lvhTfVcjEmMJaYebNj/dHbRlBYFxjWsQkhUpNA2Ue9UijiPDM8oCrqm/ZFO7VGpbbFakyF4wPirMCFrSTyE1v1M5anQ2LFTieLg26GmU2jvT8BwMf6fcaDN4GUu3yS0hELH3MdxbCeiDV20uCgRCk0p5qWBmqZ3x6SPdPZ8bsKfO/zW5D8ViKDNgX+603+yndBJCip2atkbPerBWBybIUfU/kAcDDiznP3B952DmtujMP4uiX92n7brVHQb1k/3VdeK9vgfRP1nSZmx16Gdl13onA+e9bQ177PqQM/oYj/ZGDPwa80O9EJYfLy1YGk8e5iZo5dUoPrIQuLWtXf3eIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGOGe+BFCtxJb1vWhRY2mNxtv5dp+BCeADYJEhs/CKw=;
 b=Einii64k/TG4taAVqDtqsaFUodakcUqvdNRin5wungMjd6j7IlyBQTTLNGnMUI6SKlTAEYM66Dr+CqsszlTMOeBSGLSFFPjgRbE9UZAbASAh5ae0N3/YdX00pdoZYK2aEX8bOMJhJpMZPWrnRz8YHxvqZzswgNUu2KA6JMA20NE=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SN7PR10MB6361.namprd10.prod.outlook.com (2603:10b6:806:26f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 16:42:53 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 16:42:53 +0000
Message-ID: <634dcc24-d02e-431b-afe4-277f06bb57c4@oracle.com>
Date: Wed, 21 Feb 2024 08:42:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests V2 1/1] nvme: Add passthru error logging tests to
 nvme/039
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240220233042.2895330-1-alan.adamson@oracle.com>
 <20240220233042.2895330-2-alan.adamson@oracle.com>
 <emp34ucgyak4r7ajed3nrk4npbwgv5hyfovlv7mo434m2e7cq7@m4itoplxugis>
From: alan.adamson@oracle.com
In-Reply-To: <emp34ucgyak4r7ajed3nrk4npbwgv5hyfovlv7mo434m2e7cq7@m4itoplxugis>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::29) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SN7PR10MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bda8519-382e-4f32-c639-08dc32fc2605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2HRmZnwn5VFf4e1BdRSYsgU5JDpyBehg2VqXwdCaEm1CTDG6cfTyZiQ8UZPzTvVMcBbmlT0RJoUBrN3JzocZCbsPlBZG8PYfnX7nlKpTAURxHiXedDmg9HH/SV2BphhqezXV81zVyvlidpEAIqjab+QSKcxBQJfIr1UXd9L4hmC8kDwKgwToQYxTFJj/Bly0PFVSCI0MXZuQt4ZnzBKwX1QH70PsCzRTYWt1XgSrClfIdKOdzXos9qXtAMzPClvk3WDvXOu9WzLr7PU4hglvdvgLSk0iAqTFQCS3GpiYKPnyKOosQt7X0mjgnkllS+6VCGI1vpaWf7XPZDbnf5ZZgK62yFqbS6te4aSx7dQYCW2GWFvQEAb2I+T5u2my66kDm5q86evuhvKm1rcuX/wYS0+7S8Z8M7P2xWZ5ViJalOfyWEnhAwMABE4GRrgKsULtT2JKiGtkOVmceX0ASW0ozavk1FPaD2qJNWGfpGm5Fgjqc2ZFqDbV+5x66+b5r6UaSncrzFTVf/FGWqhZNccO3lowNR+/R+qM8bHfQzo+GpI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M080VlJPSXVWTXQzUVpNZkdMNFdnblBaRk9kQzJLc0NzcnBWYkIwTHp0NG1P?=
 =?utf-8?B?dlRubWtVd1dRVFlPV2xPMTMrdG1WWWl2V1VQaFBNTWVCU0ZVenZleThUWFlM?=
 =?utf-8?B?Q2t3NDlXL0pmOFlXWnU0YU5uWVY4a053cHQzOFhjd2RRcGp5R0s3dW51VTkz?=
 =?utf-8?B?MldFclFVWjFEWHlHVWhLUVVubGhsZXRRRmZSQmQzeXE4clVlaFZkS1FheXY3?=
 =?utf-8?B?RytNM0FNRGRqN2xlZ1hINDBOa29PNWlYSlNzSDJ5M1ppdlpFTUhpMlN3MlFF?=
 =?utf-8?B?TkxXNEc0ZnVWMTZId1dlV01hOFJTbWxmMXFsdGc4ZG9nUFJyR1htcEpLSVBy?=
 =?utf-8?B?d0xDRzhIY2c3dFZWcVFSZWNldVk1SlFZMkdIR290QlN2TU1Fck0vME9SZVho?=
 =?utf-8?B?OW5mOEQ4Q1NSZjd6ZkdHb3FsWitlQ0tMZDVJaWxlKzhmZ3Nxc2toY3YrSGo5?=
 =?utf-8?B?VHRtbFdQcGZxNk5yU0JXWWw2d0pMekpYd3djU05qQ2lwSlNRdXRqaXZLeXIv?=
 =?utf-8?B?cllNRDRTUWdtdCtTSFZkZmlXd0xWSnJsTlQ3WXRndmZ3cUUvNVM1bTdDSlNY?=
 =?utf-8?B?WG1tb2hkM0ZuUElQM1VVQyt5R25OZCttVDNMWno0aXRYMjlBczBISUE1dTk1?=
 =?utf-8?B?cFJ2VDF1SHlPb2FDUngxVWFOeHJWWDJPZVJuZmxJczhaMUJFY1YyaS9GbC9S?=
 =?utf-8?B?R245T2N4YlpINU1SbWwzZ0hQd25qMzNoMHd1bDhxbFE3b25pWjBzM0RUdmli?=
 =?utf-8?B?YXFzeit5U25MdmZRTHlPYVN6bWkzS1ZvN0g0dUFLWDJYb0phNG1tYlcrU21I?=
 =?utf-8?B?RHpCTFRRRlpwT2dDZ28xUXJQb0MwU0pycmtUVUk1emdtRjhlRlFZSnBYc0pZ?=
 =?utf-8?B?SmJRd29oc2NaREpFSUN1Smp0MnMxTmNlOVFya0JvaXhiU21UQWNTS2U0aitr?=
 =?utf-8?B?dTZYNVhYamNtSFBWV1ZQYnZaUDYyWDg0SEo1S1NWSEtZdTZLRDAxdFIwU3Qr?=
 =?utf-8?B?U1VKZGFjbkFmN2NsMktuSTJHV3RORXNqMDhrV1c1ZU8zRVhvSGc3OWwycVo2?=
 =?utf-8?B?KzR1T2Y0SFpoM1RwaDI0SEs3alloWnVCNmtrMEVYdEVXSkFYK0VQQzV2eStx?=
 =?utf-8?B?bGJ0M3Z2dkpVaXNGQ25RNGdrcjBXQnNhZUlDQllhUXpFUTJyV3FMVFJPdlJU?=
 =?utf-8?B?NlNRenhRR1BXY29WM2RaRU1FRzJFSFg2a2NSdGdoZDJtYXZrbmNacmpmcG1G?=
 =?utf-8?B?ZkdMWDErbE00TUZlNUhqNWtpS0tPSDFGeHVVM0tKVzBPZ2lLZGdpcDlpYmhj?=
 =?utf-8?B?Q1ZOOVl1L1JmZVI2MTRUSFc0UWZWOFEvaktFRVBUUlZ3azFSRExmZFZaWGVQ?=
 =?utf-8?B?NGR3NWVnQUhaWkZWdGIwdDRqSDZpRnBSdy9taUJzdzFvYUdqYXNwY25sRmhO?=
 =?utf-8?B?Vm55dzdIYXFBUGVkZ3JFRzFCTHdnK3ZuNDFibm02U1hmMzgyai9TZW9qclNI?=
 =?utf-8?B?TjZDQ01Ud0tQWW5iNHdvMldtcUJBV3NQZWtZWmZOaVh2Q1REclVHTE5mNlVO?=
 =?utf-8?B?bnFzZGYyZVlKSGNVSGE1ZXpUWHdiOE9uZzUwdVpIZjhPY1Z2bDNSK1N4Y1NF?=
 =?utf-8?B?SFlYc3hEejhLKzkrckR2T0RURnJ1S3cydTBxd09sd0N2T2VvOGJ2OFRBY0xF?=
 =?utf-8?B?bm5mbWx0ZFRvMUZmMjY1amxWVU9yeEVwRGZUTGRtV1lXWUM3Q29KMW5LZFJU?=
 =?utf-8?B?UHlYUmEzbmpxK2NpbnZXdUROR29iY2xIUDQybGdYbm5WenZxMmZjWmZVUHFI?=
 =?utf-8?B?NWFuUFp1U2hWQUpxaFFDSmpvb05CUDdoWXByaWNnM3RmSWZxN24zMW93NXZB?=
 =?utf-8?B?WlRaREJKM2ZCVTlqU24xRlptZ2ZiSlVzS3lXSVpteDRMMUJDcVlaUEhid2xX?=
 =?utf-8?B?bWQ2MlRYaWQxTFFBb1p6NzhXdFhhRHlsWm9yVytBRERiQVJFM254VzR6cG5C?=
 =?utf-8?B?NEdrWk9ybUVibHdkdzduY2J6b05YS0FJTmIxYmcrMk8yMSs4Mi9IYktzOHZ6?=
 =?utf-8?B?d0xucXBFMWZ0YXo2OTlsN2d6SkdCdmNlN1doeVRDZnNzMVdHQmNtWXdOOEo5?=
 =?utf-8?Q?P0zP2GEQfAKUGHQgGvIoZB5oS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Gq+sDQbvgNy+J5asDozlBTBB8v9/ruL2kagHbCGkpc+Hui0JG+8+d1P529KaEOhiEnoq2892DRI02y1wyU1vXMWyEvYF+4qljiIsQ7UeNMyIvR1fZhrKD2dX6s/5qdlCZoWnGhsuQZ2gId8QSqHAsL9VT9k41geENGAHAhBuy8SvEOBHnx56YkvSXpMqZY73+t9wS4jXt9GcZoG0PfsLdQ1L6aPgxvuPFtK91YXHjRe5Fa0shOs1yl8fG16uz2ERyTqp/dYbZCFvc8FDESVgBPt2+3vKJOc8BHRhxmlogYHkjyX2JZ+aIqYMGewlIuZ830aFHHA/XKAHl2y9dl0X3hbdpL6AOu4Mz9xGHisasGLMi/SKcPng9I8CSlQD7ahV1TOw44f7VlywAzpUwUcw4jkrnKZvo6q8oVvNw6toqxYJj0xwlicEGMU5/xNrOJACU/hNvXKMmxVNioVzh8+ebIh+iu1wS3MHxJbZZdJ3RWa1szKsCV/z4b7h+1SCMxoKgFpYO3/31irZH2VFrtxkXR4qvXyDFCqxyKJL9sU2/HQFkon1VbSfH5yGTffeOGt1Ne/Ytl0pW31jI4VzE5cJa2mAe8jI+NQXySw9TuLnERY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bda8519-382e-4f32-c639-08dc32fc2605
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 16:42:53.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFBrzcmS001iHk7hug0stzcSLV+BjiHxC6LeJMwCBFlXGBBexLgjIVnEXuzjLeceMBp4/U6Pq6ba1J96uZ9O9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_03,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210129
X-Proofpoint-GUID: zMYfkDd_-Gm_b6X9Rd-tDzCB6YD9BXzS
X-Proofpoint-ORIG-GUID: zMYfkDd_-Gm_b6X9Rd-tDzCB6YD9BXzS


On 2/21/24 2:41 AM, Shinichiro Kawasaki wrote:
> Thanks for this v2. I confirmed nvme/039 passes with this patch on my test
> system. Good.
>
> On Feb 20, 2024 / 15:30, Alan Adamson wrote:
>> Tests the ability to enable and disable error logging for passthru admin commands issued to
>> the controller and passthru IO commands issued to a namespace.
>>
>> These tests will only run on 6.8.0 and greater kernels.
> This v2 uses the kernel version as the condition to run passthru tests. But I
> think sysfs file check is much simpler and more accurate. Please see my comment
> below.
>
> [...]
>
>> diff --git a/tests/nvme/039 b/tests/nvme/039
>> index 73b53d0b949c..38a866417db9 100755
>> --- a/tests/nvme/039
>> +++ b/tests/nvme/039
> [...]
>
>> @@ -155,6 +197,26 @@ test_device() {
>>   	inject_invalid_status_on_read "${ns_dev}"
>>   	inject_write_fault_on_write "${ns_dev}"
>>   
>> +	if [ $RUN_PASSTHRU_TESTS -ne 0 ]; then
> The line above can be:
>
>         if [ -e "$TEST_DEV_SYSFS/passthru_err_log_enabled" ]; then
>
> Then RUN_PASSTHRU_TESTS and check_kver680_for_passthru_tests() are not required.

That makes sense.  I'll make this change.


Thanks,

Alan

