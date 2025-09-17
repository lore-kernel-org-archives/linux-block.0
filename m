Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCA1369B4
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095373; cv=fail; b=DF4WsaaK4eTrsT0QYG2m7JaCALNX9nNxRf+YF7Ka3uISMVuQ8fh+1PqW3d4b7bO9Z0vXuQhbSFm4PfivDth369jCq/Qz8CA0alPZ2HBgYs+TNTpAbx79fkpVN5N5afbj/nfW7o/vHhRuhsXe/oS+DT/Gafee3RsDUH4Bdq3khYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095373; c=relaxed/simple;
	bh=MrwH4ILw8A8nQG3g6G47wESfS3QsZI1TDJu5J8o1QzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBBjs6JKkYub+1t5nWY5JoGSeQN9VR5B+vZz6adzpH/QanvgNZfjh0Cy0IriMsHROXpJB1kJ4hniZ+/a0DJqeIuK6HUEcDTcAxSVf/c02IUKjnJyBftbiQfiKAsilLHbQeUW0nZWlvmO6Ke9GFndTbA9dqQc9eJRo3NsOOvMehg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jEPG/QqT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y95/Abk8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jEPG/QqT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y95/Abk8"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLYuQs011224;
	Wed, 17 Sep 2025 07:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CGdRXIMxcSj0okdFiFT88V+FAsvcAaofvLtbUZdPAno=; b=
	jEPG/QqT1DOOznyA9Ti8H+dgmoxtPEiVBRDUO4cAeFIGLfoHD4wewxo01wBhTnR4
	YAL43HefeO3LBej3UHGqXQaNidKgXxQBAvnKenKJsGDtoQtkfZJv8l4ks/tv2tkD
	T/AL+HnhpynSfrEsMk12NhTnl21b4Pb2YBRZJlzNmNzalOMsC9J6FB5cgDWEuXwj
	z4dOz61pb+U/z0nMdQvnkjkPolF4hLpl5Zdd2BLSbDBsAJtegYlM6kigUVcKyD7M
	x7vp132w2TKwemC/AD/IO6WuCA496ShQZ4eJ7QLCJRqEuBmMN2JhMFHRgOaqVIoI
	/rAWVIsXMntXkq/OZznaBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6gmqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 07:49:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58H6MeO7035160;
	Wed, 17 Sep 2025 07:49:16 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2kqs81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 07:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weWjTMMGsBAnePwaSGIKWNuRpwrwW1T37LsMgXO06O00P4CfKhlI0nWDQJ9BXKce6Aludsc9DqLYr8GebL9oozbWz9ww6GNW2RTBO6b5+VBkw/pPyvxE+OwzhNQLQGlHY/YrVYMTe6rtf/PjHpimIEJTPocT6f20SBv2CvNeuX/TRtBSztvxpvWdd2XLSPguxfrAkTLURixY7Fj0xSDWR9AyX7aZz17id3Y3RR+41Tw5BRabY9ZIljZtjkGBbaYfNsSPVd+GAoqg2bZYj3KnELc0zp2CrEpt9TT8+lCrLGRw8SenkE1zIQ8SSndACW9l7yTlAE3ss7pI9ArFGhi3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGdRXIMxcSj0okdFiFT88V+FAsvcAaofvLtbUZdPAno=;
 b=L5lafiImEnQy4VG8auCRqmY5Y3E8H0DDLywGOP9ByANmrVYJe8qrcuZP4DpYazzaWHAwy8BU2UD+kflW3u7FzUKXCzcMrilgMoDPiPQWY1bpiOe5X7+Bpf3m2kSuh1VDQvuwHnvencSieViTEoYUzM2+cLy8anzLQTXDd+0W68WM4eQyx3gV62cDyahMY1WlyH9O/UlT3Cz/BruFD3LWAuX4sg81yF4kXARQ80PNntiRoLOLbDveoGQY+uwX3dKa7EK+CiafgQTN9w2dMxtHqM5/5I2SJDCvr+2Hg6BQvGTvLo181SZm7wFX5xRX/LRxdZZHMrp/iomvva8s3qMa+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGdRXIMxcSj0okdFiFT88V+FAsvcAaofvLtbUZdPAno=;
 b=Y95/Abk8EEGrVJuUmvvof+lIq4Cz/Sl0enAf2Oy8nIySfx9qtsAhRIiLqpagOB4LmsIe473gBfGl1HArshoAyZGQBe2fC45bYI6ZI4GjIvhQwQ5qdA8vLkFyZ4XFOdfWZ4CwmacXv6KseLteMeTOGYH/ZYRef6RCYWdRkEO0NyE=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 07:49:13 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 07:49:13 +0000
Message-ID: <d9880dd6-17ab-46f8-8385-d6080182c77a@oracle.com>
Date: Wed, 17 Sep 2025 08:49:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Fix the blk_mq_tagset_busy_iter() documentation
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>
References: <20250916204044.4095532-1-bvanassche@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250916204044.4095532-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|MN2PR10MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: b1134499-f1b8-4a14-1b3c-08ddf5beb195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFdyZGt4SlMvVzIzV2xhamw4TjNjVGx1MHhseGxyL0Z3bm5qbkJHdkpiQmlv?=
 =?utf-8?B?QndrcnBpUmtVR3RiNFIwTjlKdXR3WnFvb01SV0dSbEkwUzZ0YUxZOEp0MVdT?=
 =?utf-8?B?akY4Sy94K2FTcWtTTkdYZDNENGgwSDhsOEVjNGlrNys4NEw3V0FreDlRTTBk?=
 =?utf-8?B?bzkvS2xSQi9oMHplaDR2TkdQZTZTN1Vxa1Mzc0tJZGxNN3lCMmwraGMzQU11?=
 =?utf-8?B?QWdWVDJBM0t2b0NYOWtOaDZ3d01TbHZZcjdURzM5NWY4RVh4RnhVYkpmTE1W?=
 =?utf-8?B?T2cwOUFucERuQ1crMno0dUNNbDVwdFhnYngvUXpxQlN5ZWF2QVR5NmpmRzdo?=
 =?utf-8?B?TmpVS3dPNXJDWC96cVlFNmtNbkFqdzYzQ2lzZTdhbDNuL3htWC9xa2VNc212?=
 =?utf-8?B?UDF6L0orV05EZ0Y5VnR1RUVaVTkvODB5VGdFVDVsT0VyVWxQTzU1OG9paG44?=
 =?utf-8?B?Q0lDa2grdVBIei9OeDBOcUhYbHh1WWwvTjBQUXdSUGpqZmdNMGx0a1FjN2ln?=
 =?utf-8?B?bi92c09ROVNiNXdBeFhZa1gwQ0tTME9OS3NSMVZQOEtxdXJ3VG5SVFBLeEZw?=
 =?utf-8?B?Y2lIMFVzeEZ4UW14dVdSVjMySGpLR1dIYWJFSFJuMnQwMmZHNVJsQ09jbnN6?=
 =?utf-8?B?TGw3bktkTTBTYnZ6Yyt6MFlLbEh4MnhHRVFrd1VHK3B1Q2o2L29WckRlY0tS?=
 =?utf-8?B?MFBLNzExa3NmZlZudGxvRG9kbWs5KzZsOWkxN0tERlpidEN4Qlg5VmQrZGo4?=
 =?utf-8?B?cDNTV1FqYkhKcWM3UUE4VVV4RVdRbmZVakNPNXJ3OERqWW1KMFQ1YUJneXFE?=
 =?utf-8?B?SmRaanhQeW9ITXAwVEJJVk1GTlZtcVVSTGQzbmM0OE9DRTBLV2xQTTdaZkhx?=
 =?utf-8?B?S1p6WUpXK25Gd0NrL0ZRbzgvQm1GcVlTSDBBWVh4bVRNYVVqR0ZyVEdHREwz?=
 =?utf-8?B?OGRJY2FlQ042am43ckltQnFscEhYa00vMGJuVWxxYS9RMmo0VHFJbFlrRVNp?=
 =?utf-8?B?enBwR2Q5VEJaUHVUVDkwdTZYQlR4Z3YySDBpckY4elVUNjVzRWI1MjBLVkly?=
 =?utf-8?B?SExsODY4TWJEUDMyL0ZTdDA1azJ1amwvY1RmNHVZM0NsQXpxZkZkM2F1V3B1?=
 =?utf-8?B?NTRTdGJ2dE0xS1A2WU1RWlhSVWV5bHVmUXNmeUVoNFBKanllMGp1SjN6TmUy?=
 =?utf-8?B?ZzlHVEdYOU01a3R6c2hnREI1eERacGxOYXBYdU91NDFBbHdjOWUzby9PUVhU?=
 =?utf-8?B?RUpSendiNWlZZXBjWEFZYjB5QUpiV1pEd1N4RGxsbm1uQWhBVXZ5UGVNUG1R?=
 =?utf-8?B?ZlZITndRNmZsRWhuaXNBTHpXeUJ2QU80UHhnVjl1RVRnZHhSN3VCLzhqQlhW?=
 =?utf-8?B?TnBpUWVLTmJFSUNXaEV1dW1jK01kUG9aUXU2MXZMUXVaTjFiNm1oYWNzL0pN?=
 =?utf-8?B?SU5ucng5ZGxKYTExaFJKVHluS0MzYzAxazY3OWp6U3NUSEZUUVRBQUVQTE5w?=
 =?utf-8?B?TkdrVGxhbFhDb0xjLzROVXJKUzhPTTBYMzVGb2ZWS2EzSVJaRlB1Ujd6dmpL?=
 =?utf-8?B?Qzc3azZ0bUV5YitYa2tkMjdWc2hCakZPeG1TMG93ZHE1TGV1ZktBQWdIbnZw?=
 =?utf-8?B?U0FzZnczbjhvV1czK2k1TEN3K3R0R0JvODBLWEdsM2JEalh4cVVZbWpxbEQv?=
 =?utf-8?B?ZGZQMTR0ZFNvWWNJZTJoR1V4WmdmMHBsMk11L0ZKUklYNHJHZ3VuSGR5WDlX?=
 =?utf-8?B?VkVXQU1RRzgzay91WVFxVUp6MHREcWtqeDVFdTd4NE1nbzRtNTZISlhtV1Ri?=
 =?utf-8?B?ZDRYOE94SHN3cDUvUk5jVzMvRjZveHVhQm9uOWVkNUcxSWl1Q0NLTlFXTXhD?=
 =?utf-8?B?Nzl4WVlSYVp4SnpGTlIxUWpBUVZoM0xPMEVESnpGNEgySEhBOS9PUFNHbG1U?=
 =?utf-8?Q?dtYZWIX+hmc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nkl0aTVpaFk5WURpZWNEUmZ5aWR2elJWcHN2SmZuVDNLcU4rZ0xwWUdENFpo?=
 =?utf-8?B?QllHdUJTeGgrcmNQVmRTOGNwRnM2OFdTRVdDVGQzY3RWZkpta04rZjR2enVL?=
 =?utf-8?B?V2FsVzFjblY3Nk1Uak5rNDlHTTZIbGFkSXYwbHppT0JjVXBmUC94QUhFaWda?=
 =?utf-8?B?bm5mY3RvOXJJaWpNYU41YUprZVQzdWFhSWV4RkFOM0ZjNTRLS09QcXhacU5p?=
 =?utf-8?B?WVllMitMd2p0M1F6N2ZiY2lUYTZzdStDU1ZzdVpKWlB0Qno0K1VUcFF4VG0w?=
 =?utf-8?B?elRMaEVyald5ZWU2bTBacElzOFp5dVNYUzhSMXVtK0JMQlRYRGI0ZXNmRDNP?=
 =?utf-8?B?Rk1XcDNkTThOaUVyZ1V1dFMwT0JDakJFNTNJOC9WM3NxN09SWEpCRENqajY2?=
 =?utf-8?B?T3dvNWk2K0lleUEyRTlpcnBwL1pmbkxmRmREcFNvbGxrcVB6dTlEL1FvNG84?=
 =?utf-8?B?VWI0WmppNkNTK2NHbXlYTlhDRUFXSGNCekZEMFU5VEh1c0JmdjhSOFlEeDFZ?=
 =?utf-8?B?VzFvV2pVOEdYWE5sTXdqejR2aGM1dDFOSkZvT25VTVovYUxKcEJSSUxrN05T?=
 =?utf-8?B?czU5dE9vSXBRbzBCZGdwTzR6clRlakZYcXBMRW1lMFdQNUtkS0YweWQ0aTdT?=
 =?utf-8?B?U1JIQlBYbzBsWXliR3RWMyt0aUtmSGpNaU5PN25La3ZJSTFpQVdGQXN3aGlt?=
 =?utf-8?B?ZGJhWHcweTdjOS9jOXlIMWR5VG9TYXdONHNENkJqU1hLdnFEaC9pL1oyQ21O?=
 =?utf-8?B?YythTGM3Smx3RDY4NFh4UWFYS3RWZTJFa0hMTGptOExpR2lyL1BialpNSnhi?=
 =?utf-8?B?SjBCK1djUU1YRHh6WWxmaVhjVW5LN1hWMW1DVE5qajBSUlBobFZJVXJrbGdr?=
 =?utf-8?B?SWZGWHU1UGpiRkFpeGtRc1ZjRVFEODFzMXFkNGtXNG1BZit3VWNzUWttaDA1?=
 =?utf-8?B?Q1pTc2pMNGtCMVRYYkUyNzFmTmMzMVcxOVZtd2VYUkRJZTFqMlExMEFPanor?=
 =?utf-8?B?VkFjSFhyTi8wQTJXdlBKaVNmczlaU3Vuc2pVR2lmNFpvZWdENVhnQy81L2hX?=
 =?utf-8?B?eURhY3hYNWtCd3FRSlpSdFB1bjk4RVB1a3h5NytneGx0cVlyWXc3Wlk3VGk2?=
 =?utf-8?B?eHRNYjFiT21KWnV4d3UzSm8zVytRYnFENk03amZEeFB1S0VkbGRBRDROaUpD?=
 =?utf-8?B?MlQwcEFrdVNnMFZvV2pQbHFEU3JZZ29yYzNHUlNKMDI3Sms1d015Z3VLV0ps?=
 =?utf-8?B?eGxNQ3JEckhodEZ4SEd1b1Frb25tdy94ZmVnRTJ2TklYbWN1dk1UYnY2dk52?=
 =?utf-8?B?WHNRa0NMT1JPUmFIQytPZllWaGliMzQ1bzgwS2pIYjlCYi82TFpWSExVVDJx?=
 =?utf-8?B?bFZNcGNjVWxNS3IvUFJieEg2ODVYK2FxT3lQWE5Pck9ZNWFyU3dDV0tMQWlz?=
 =?utf-8?B?M2hqOUNiTXFMMmhGclBscDc1MlhrZE43TE5DRVBURTlOSHJKWExpVmM3NGJU?=
 =?utf-8?B?MGFBTWdYSGRpUTZKenNpck1maWd2dlZmZWdNc0FtZk54MDBodGI0dEQ3QXVh?=
 =?utf-8?B?djdCMnZlQjYwVysxSVQ4WkdOc1N5M2RyVU1rNEZnWFF2cnh6Wko0MXZMc3FW?=
 =?utf-8?B?T1YrRDZTak05d3Q3YUJ1TCtHaHl0bHMxL0dHNDVCclg4ZmhIZWprSEVGaXRU?=
 =?utf-8?B?S1B4dmZaUHFFUkVGb1lXMU01dGRWNXdPYzdVSzY2SUhVZCtMc3dhcEcwazRH?=
 =?utf-8?B?dXdONzFVRzh6RTNpVmFWNHk0NEtXVkpHVUpaZWhiNUdhbGk3L0VsNTFoNnIw?=
 =?utf-8?B?OVBGaHBIZER2aHhNVDZFcVVuaUxZd1plUXhDQXNYUDBRM04rSVkwYW8xejM0?=
 =?utf-8?B?dEtTK1RBZTg2UUlmVm9LODBKUjhqeklLdzQrbU0rcHFZUGdNMzVMbGlFYU9L?=
 =?utf-8?B?QlFRN0ZneHhMQUpwMVNGemc0U0tNa3JGNFZLNG55UDU4QnJiYUpsZ3JaRkNz?=
 =?utf-8?B?WnF0N3lGRmYrYTFGdGhGeUZ3ZHFOS0d2ZG9EQWE0a1lqeHNkNWY2RWFYVXVa?=
 =?utf-8?B?cUpDU3V0S3A2eEE0Mk92TGM5WDFSbGxubUFESTBiekxhbUdDeFVtK2cvVEg0?=
 =?utf-8?Q?WzH9dPsu1C+EqcJP3hePutyfI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6WEwvDIIRKnBZdQL0WXPU7jFEpcqCI+IieV3k34Teya6rv4hFLtYGbvsqc2toIoGD4OZtuHc5dqwNOcdw88Z+h3MFnHTGWjdC7HxP/UwoSATuXEKc9oCbpy/SJuIn3w4ztii01Jk8VmIytyzsj6XVKl4MyubVPG3WYlZ6BWBFWnJuzJi/TAZhOaZTiFIRyySCGFivAVRD1cbeNw/Gr9TGEpU5FnZT8UQ52GcRuWgjW8kPf3wKIec6DqK/Z5PDqlHa4D1me8EaqcmsJ2Czi68mRl13FTQzBW+gkJ61ZKPzzOuUH2Z6ZwbJSuarKNcJr3O441CaJMi3yl9v8S7X/N6qrkgCPNe3R8geMHhYMMWY+1oLpwt1Z+UeW2UTv8ai8xx1IxDspk3ogNxMoJNR7swGefbiD2VY+lQK09lU03z71V+DuUL7qWRe9Q17pCCyqHtTbiXipAeXUxFlE0Rg4SE+gsew89Dv/7QUQGqzV8DWU0LQMTXMh2jLqSy91PxNhhed0cqnnMFEYzgfY9YN2rCNNylTnkxoesLipjtby50UOs9KED5TGoIeIBKCWTRsD9w4MFFIFsK9Uo4OS0iglRvbAODgrU8fSN/XhzARh8m/eM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1134499-f1b8-4a14-1b3c-08ddf5beb195
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:49:13.1304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cGBOVRBVYZ560n//weCnhroL4GSgpbu+nH+eT5Y4ubSIu0bwXYelM4aXA97hf7PQPfAyQE3Zje123aVRiLvMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170075
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68ca67fd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=N54-gffFAAAA:8 a=cuSo_ndDlSmktPG_8QgA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13614
X-Proofpoint-GUID: CPAA3uYTpu0av2u2w8hb5vthh1Z-xKOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9nzUte2qXgpR
 ClnFG05Za0olvtSGr4NjsCkdyDfWQmTNNW9XoW9wQftk/uprpuuTC9CXzHqFSgIoR+n6cQa2Cj7
 9UZA8BRByl+Ri8J385RJ8AFsraDt1CdIAHocA4VAXxWbkQOFhStjikF8hAtHyb6iGdXl+/e5shJ
 uvMD8bahyCu1U+ODhWkfIh5eV5g1mF/vtLxo5MxZqftjWxLfrduswjZTrYvj09HlwXq9RPIEvpg
 blUyehYTzeBKOnZea4/A9TB+li/iLXqXeLZpAnG3udOY0BVJH1dex06Kdo9joj6SrVjzBwOp/8s
 fs/LObgMyf7GAGA8OfdLTYPkif4DBR1wGY2KIwbgkfdA5v/j987Qb0seWFDx/vZtxYY3MPO3pvC
 X8wAD0DCloCgtlkfwhrbx5AzkZZujQ==
X-Proofpoint-ORIG-GUID: CPAA3uYTpu0av2u2w8hb5vthh1Z-xKOP

On 16/09/2025 21:40, Bart Van Assche wrote:
> Commit 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")
> removed the 'reserved' argument from tag iteration callback functions.
> Bring the blk_mq_tagset_busy_iter() documentation in sync with that
> change.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq-tag.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index a63d21a4aab4..0602ca7f1e37 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -424,10 +424,9 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>    * blk_mq_tagset_busy_iter - iterate over all started requests in a tag set
>    * @tagset:	Tag set to iterate over.
>    * @fn:		Pointer to the function that will be called for each started
> - *		request. @fn will be called as follows: @fn(rq, @priv,
> - *		reserved) where rq is a pointer to a request. 'reserved'
> - *		indicates whether or not @rq is a reserved request. Return
> - *		true to continue iterating tags, false to stop.
> + *		request. @fn will be called as follows: @fn(rq, @priv) where
> + *		rq is a pointer to a request. Return true to continue iterating
> + *		tags, false to stop.
>    * @priv:	Will be passed as second argument to @fn.
>    *
>    * We grab one request reference before calling @fn and release it after

I see other users of busy_tag_iter_fn which need the documentation 
updated, like blk_mq_queue_tag_busy_iter() and blk_mq_all_tag_iter(). 
Please consider updating them also, thanks
