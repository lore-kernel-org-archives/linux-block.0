Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2E657D8
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426983; cv=fail; b=FwvZFvgNI2q5C7JUig+KRFpSsreMYE8zEmuLPKoTkBMdRWV4oypWpKlqQFuL7SwgZlOj0Q7nax7A6fb3GfFRrdtzb5gg1wIpUMqTOpA26xOaUTYMRJdR/b3IffgnCJWCBYQ8tqY+JZl5s0GMPkK4lVVnTGlwK2aqzsK95Y3flRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426983; c=relaxed/simple;
	bh=M+Pgnpah5L28q6la4AEhrAi+l47gE/EazAOQ1cDsh4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lc8r922OfyxNYIWWeBB6Q16s33xeP/KVabo/fVKFMtTBMxHUvvZ7ZWe63flnoyNtVtZXOworPhf00PRdnf8o0ib2obNResahMSPzug6QO8QsE+BJHD0M0ywLdy2MEqsEVnzeGXmblLdOK7gVM682aqX3CK+pOueaTTouTmQPxx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b2gyBq37; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tu1yHcYq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b2gyBq37";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tu1yHcYq"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41K8xGST015280;
	Tue, 20 Feb 2024 11:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bAOIVAxmy1zbb4YwpreLINEPfOOwyew4gEKK7U0/PWk=;
 b=b2gyBq37nVvb7ADU5xKZomdjucMdCohPtFaUBwxqG+IxlGOXL3ScZpvfd1bykjSt3zf3
 Ha/8UEuBhWsi4pIm0qG1DsXfvpr7QPnUUz2vjG7pHq1KkufFGJG+gQcs2RkrN/Q2jRsf
 ek9QBsoK1cGb3v4A3D3VQhqfKv8/S3dCfwVfyvQx5LDjUNj2xHoi6G8FEP0q/KDfvBuU
 PxemP/qp0RvllqWld+FAgb7KQFIZRomFh6fwKvmgrU/8x3ce+xQGUHTnCILlyzMekhR8
 vR7qd7HUs4uFPlSvTHTt0DxTPu/t1pRnpxUnOXWwMrtzowg8ieEA0xhboKbnFHnI7NaG jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd26f77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 11:02:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41K9nKjD032479;
	Tue, 20 Feb 2024 11:02:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak873a04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 11:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcWbSWy9Ywyz/wLApgb6M+O6DMQeadWnPVBYMpDdzWsV900yLBfmKGiCADXxQzGigkXlPo3ngi37WrMO84AnmcMpVWEojqcP+INu2CJCUTxYE+uZpuIscy5qH8LDYN2sU5am2QgL3U8XYDofAXeaToN1IJ+72DmEuS90u9YbaYzAlRTO3AVCmPMvLRFLtkswtfLOGgwQ+rjaGw2Fo69kI72fozrdpU8Fhjg4YD8vjmbRbh8KPkdTXD1ha+Ws3zVBT40dpoJuIGClI3W5KVtRnZljmc4oHrACszDBA93ptaht2ATIC3BflVYJF4jevbjxKuSXjmQNRhtO5LzvEa9ntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAOIVAxmy1zbb4YwpreLINEPfOOwyew4gEKK7U0/PWk=;
 b=cbbthHtiFlJL3onlez0FhGkz5oDkAaMRuCuQjXHnFYr9KcfD8QW4lBT/MXIdCNbs1iUv0kDlJ3PrbuQUeli7Iei9gdEg9TEd7fFfOHC0Ugo2maZ+bV+jILhdbZzQDpwe0goB0pBfsUgCmwWeMFtIl04X0fQgKZina46xihRdv1j1CkG8D0Im70WF8Si8wd/FY1OtYn1m8cKg1xq4HIO/ttMbVf34EI/JOVRw58JYxII498/a5DyPKTGpbg8nlZc6bdN4HksrpHRKWLy4FB9CUthKJA1d0n4pP8sikxZqgLC2LzpbzPInq+pabZNewigUXSjxesVwHsXwE7jsk+IaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAOIVAxmy1zbb4YwpreLINEPfOOwyew4gEKK7U0/PWk=;
 b=Tu1yHcYqSSiOP9ktTAC/GFk8HMNobJjvDKN00lOg4EvZX0UbcwOOxiLvz1VF7aKHXsICIoas25ea58gIyPdfZTZbQIpTG6+RY7woHDXJJyB6alZ0MIM6Xk9bzQ2Hx0V7TJYbJkkDgtfcfjtQkrygN6vrT4rlofOeNJc+KuMWnuI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 11:02:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 11:02:49 +0000
Message-ID: <59c1910e-ff03-4c44-a182-cfef8e6e01ed@oracle.com>
Date: Tue, 20 Feb 2024 11:02:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] null_blk: remove the bio based I/O path
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240220093248.3290292-1-hch@lst.de>
 <20240220093248.3290292-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240220093248.3290292-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 92684886-4e7a-4b3d-b994-08dc32037a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RiDQ3RubLFJYnZ4bgvgSXdQChI74aNwGAkoujcA//hQSR/EY5jr6OaohhHiNKh+ngLWIg1+Uuo1sfDvPEMhbTMwpJBwDjFf7lanUyYHyi6rWmZxRVXaRlCs4cnMo02kuybclEFBDjkmwtNT/zenq/hebrvYOekbeLDtSfrm+nGqSxZMd4/sHZ4YUmab2LPJzemdcEDyaikQRt8npWEUg0Md2/imCkvtnD22KPVIReGvQrc3agUdVcUH0VKaaTdDP3UQJBcmkxV80KvP9gpLFEtQdVPJO/nhUBftO1Nmyi2xbQgM20Mqo2330ptQaKqQezaOvjW8vqWi+uDuLW+5JZDDG0lMEmwFXhZlPyTwFI/VKm6VF+W8GJGSYq+p4dTWrjgsjB1a2HcyeX9XC/P/a9TYDYN6lmz6L6x32R/5iEg7bVamUDr9XBWLsLET/Ji8/ihfsRVLXYrxAMwr/wjr9BOLSWJiWRfAlhEhzW41qvsMzfLYzMQWOwir8LagM/ha55GiegLKl/HQMKWw7htvKGurbgJ/pv392zhK7UqIV0xU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RHd6ODlrcTFzUUpZQ0dHWUZlZDZGS2YzVTNjTXhKTDIwb0VHZU4yaENBaVJp?=
 =?utf-8?B?WUU1cW5VejU3SnFPWkRwMVhvVTg1UUhFdHUvZHJNTE5CdmdqUFdMK05vQlox?=
 =?utf-8?B?VWJrR0NiOHVVK3ZIbFJmMmJFN0VKSmgrTUN3VFU2cmJ1RjFjN0ptQzFvUmF1?=
 =?utf-8?B?QlA2VmNKV0FlalZmYmtBNTRiK1psMXBxVWt0c0dBRFYxbU5DUEJPQ3U4aWJW?=
 =?utf-8?B?TzVidW5sVXkvRDBuV0RoZ0RRUTZnQjVBT1grME84QTdTeSs2VzBnbzA0NWxx?=
 =?utf-8?B?RDRFQm1TQnRZTmpKVnNnck1ONjdpWGwycGd1eWtuM0krdnV1RGNDSGNOVjFn?=
 =?utf-8?B?ODZrNTJRWmV5bkd1b0Npa2ZFNElJYXVoaEE2S2pjRWxhUHZwc0ZjRUI2Sm9G?=
 =?utf-8?B?TTZ4M3MzMDhSdlVHQlhxcUNPZWYwWmxKTVM2YXM0WlJvbkg4MEpRamsrU1Ni?=
 =?utf-8?B?Y2poV0ZGZmhuMTFVbUdhcGJuQ2RwRmx0c3kxcG55NXhCaW9JS09GbnFTZUw0?=
 =?utf-8?B?bHVOZHM0ZURxTE9rV081UjN1bTJEU2d3Mm5vM1pFUkpUSEl5MEpjNHJOSzBC?=
 =?utf-8?B?Si9GM1A5WEM2QVNHcXAvUDlSMmUzU0htbE8zQWNzWWo2Z3MrbFJxS2s2c0RH?=
 =?utf-8?B?M2t4U3ZzdEFlSFV6d1h5dG1jKzlNN1RRRlNlTkljWW5zenN5eEpveEFqTm9M?=
 =?utf-8?B?MFRwMWsxcHF3UjRFL2FEakVWZ2RmTy9kYkdMcDZpSVVKUE44VDFyd0NsNEVj?=
 =?utf-8?B?VFJwRndtTWJ1bEdlWUY1UTJhSWZVTW05Z05iRG5ZZ0l4MFpQVStURTl3TDk5?=
 =?utf-8?B?TjRxOXNwdnd1aTFQRFJyMjIxc29qaGJkajA4dDZiUnZlRXlBblVHUmlNaDY4?=
 =?utf-8?B?RUVhaCtrNVNkd3dOZk1ZZStMcGh6eDgwU3ZJSHZOWjJNbU0zRlZKUGdmRkx1?=
 =?utf-8?B?eEE5MFRFdU94M0d0VFdhKytIdkp0cU1YZ3VqQVhOeFEvQ2JQNHVkVG5LSmUv?=
 =?utf-8?B?YTVHNGcvYjNncGFEdDhYbUNXNFFLdEFaemVwK0Q0WlZJVFJQVGdNVUpPZUIw?=
 =?utf-8?B?cWN2bE9tQlZrekQrZXFvSzFPRU9uOTJJK3lMR0daYW96ZmZtQ2V0UE1ISVZr?=
 =?utf-8?B?blppWUE4dWdoallEblZOcVpUUUp1Qld0dWJLa3lMRzVoRmEwbDBTWGdSVGc2?=
 =?utf-8?B?TVRQOHhybzdzQkJFMXdJMTlsSHhqS3BwNXBQOVB2bDJFTXo5c1RTOUpGRENF?=
 =?utf-8?B?cXdURlFhbmZndUFBaG94Tjh5bnJlcTJRZGFmd3psU3ZJWndoRlp3WjNLNXpq?=
 =?utf-8?B?Q0Y1K3VtQ2RGOXVQaEZ3VnY0NXoxdnh2M0hOK3dzTGszR01nRnh4L1pReE1R?=
 =?utf-8?B?dkhOYk52RlZMbGx4U3lhbkI4dEkxS3gxMjBFQUc1bEYxQ2JiUWI3Zmw3U2ov?=
 =?utf-8?B?WkQzSXh5RHBDOHU0MmtUdmhHMDVEMjVuV2RjYWJTMWxIdGl5dmtxd0oxanUr?=
 =?utf-8?B?RWtyeStaT1R2cWR0NXk1bUp4KzhHYndWNDl5UHJscWFxejZqWmhhT2xuZDBP?=
 =?utf-8?B?VUEzWDc4ZUk3Ri9kNm95R0Jrak9BZ3JzYVM2ZjhtMkJXZlRpa0YwUTJBRmJ0?=
 =?utf-8?B?TDJDVlhyMFBlakJHK1pJWE5RMHAwODN6TkY5R2s1aFhaaUdCMVNrUU85N1dN?=
 =?utf-8?B?VjFJdVZWTlh3dDZvZnRnODNUaVgvMUNjOUF4dkJJbWwyVEwvLzJ0SUo5MHBu?=
 =?utf-8?B?UTF5Vm5QOGxpUGt5NTBmMVBGVkpKc2lRclh3TGo2Y05kT1ZVUEZTa2JnNTU5?=
 =?utf-8?B?MmV0a1hMQTNMaVExSlNDU2JpNkRJVzgzckVhNllxcXYzWTN0eElPOFRiNGxI?=
 =?utf-8?B?bjVranphS1dNNXVqam1tUHlIRGduM2JoQWhEbGJ2Rll5b3orTUQzWUNuMUFQ?=
 =?utf-8?B?M0owalpIVW42VDhvcnUvcFFieWN6YjRJd2l2Nm1FTWtrbmRDblNURThlUFZM?=
 =?utf-8?B?UExLVHVhcWVFcjdQUFFma1FBN0JvOVZ3N1J4V2NmRUIySGFnWXBVZTY4amxW?=
 =?utf-8?B?dmFmT0U2cTBMTkJNTGwrY0x0TThkYXk3U2VaRXd1U1FvZ2ZIRkJ3U2d3dHg4?=
 =?utf-8?B?RW5Rbi8yY0MzcklvRUltcWllV3B0Wk9xa1hnWks5bHlmYlMvdlVlaEorMDE3?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ET+gEucU1Zry2xq7g030tmR5HDAVPCKNFUP8cHbMLh10p2RqPDsvzGzFNa5qBPFX8x24ztYhZDj2brHjCwqXuJnhwdhbeRYHukLkAjHRLuqjuRUuyYPT0ukHNHaoXH3yNfQfSHxfs7OBl/YZ4c5ybSXP84Nrhd+psDqTxJYyNYOKqLKvxUUvrn4/8LwYaGxGfQ/c02ElfpNenrIpjHsMuLZYIScHWABhCsisKVTy30b/Ltw7oGzCSxFLPu9rP6HFMqaOfWHKE4GrBY2YOue/BTOqroFWqpQbkLWrvCPZ/AIvHjHwhmKmOviv+Y9iJsvvZq7K7SBDUlQn1OiSfZbv58SbnttNxOgnyhGNVjNMcYk8DwiaSuT5cJYjxjyyUyRkgOawgLtdGQjieJfzf2ahKQUUcgJ6dHTNFYoXZQ5Sxpn/0CBYLOYHEdPHw9Iuqw7xK456G8H7SUx8lCmX4SObxhaOOVo2rZkSCA/YZdj95bzzjg7eUL6wHtybqu+GRF9he9E/JJzcMvy+jM2GoyhUz7LDN2avCzqJ4dGQFBAnvD3qsHHQ06h4g5FWRo3LH2W7CFIVrpGdrpne9a5mkt4IWP/U8EVAd608wifwn/IWyd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92684886-4e7a-4b3d-b994-08dc32037a2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 11:02:49.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKpuhqxcVifRn6bQhFu/bG5EC2YUvm4/JMzGKr007q3C1uOfCCLo+swkxJi5b15vX4sDfoQxf/pg1qrmlMjtBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200078
X-Proofpoint-GUID: D5-ePJohTuiKeY42fCCRkqBSjcxUbNEd
X-Proofpoint-ORIG-GUID: D5-ePJohTuiKeY42fCCRkqBSjcxUbNEd

On 20/02/2024 09:32, Christoph Hellwig wrote:
> Note that the queue_mode field in struct nullb_device is kept as
> that is simpler than having two different places to check the
> value and fully open coding the debugfs helpers as the existing
> ones won't work without a named struct member.

Are nullb.queue_depth and .nr_queues still required? Now they seem to be 
just written but never read.

Thanks,
John
