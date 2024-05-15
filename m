Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3262A02
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786553; cv=fail; b=nwY7N3uivMioUHC3JGHpvTGyNywE89HSwehl4pE+ZEykotEOQOpCh4DY9VyWgqho7gtSRS7tAQziGnZ3OZYWxZFoiPl+k2TnKwOs7JfUD/4HllXbaWPeMBLF2PlRf2M15kjRFVo1Wcw8JuwC2mGgpy8bcOj10hP/t3oHIkfBoiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786553; c=relaxed/simple;
	bh=Jjd+s0ORMoPeG+jPS1Bo0gCasAwKYbn5JafTRk4FxDg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rbt50vcEJvcv1GS/UKjWpP2tfo46SqCpszbulDJyPZGhro7Xl5sDZqQXvGF/g0BX2EtSn8EsDPCVMdk4wQHFjutC/f5dNfxrbyiNTmgxroxyKiSm4zI5f3iL1CFgmH0BxqLviEzOMYQVTlXz6lIvKPysATcM/Cfiv6ZodRb8RXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jeDSJ6Dz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PmAGwiR5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jeDSJ6Dz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PmAGwiR5"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FFIko1019810;
	Wed, 15 May 2024 15:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PUSN6LDY3yihFC/9eRF7/zZbFYWoQlHNewblzIWhhuI=;
 b=jeDSJ6DzMdBWCHUS3nSNu9uLn0ONqaRbrJdMFBSnsdQ5R3AYOAc+g2TvwIVxWx8Mxqv1
 HA9FQbUJKF0mMmTuwPXVH8Nh6yZe6rQC5nXyQnjBmb5UUCDZjuREToi3iJSMd+T88E0L
 +sLFqS/3bjhJ/J4d15Ec28CZp4SZiygeIBrGlgq4MJJzboMwl+yg1KPakQFIxM8puiOU
 svuMTbV5f3+jpFKNyXrXqLfm8G7IYIPmFV9U9x0zvsUU+ELpclpHclMxHs6tOuAzQ9el
 yjxWMJg2+xnGJBhwTgI2aN6sUH/FVyllbVhZLYlybdiR9PdezgJSu+tURf+mgRO2A4rs ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7dj5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 15:22:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FF3fZ5018059;
	Wed, 15 May 2024 15:22:10 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4f5xag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 15:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMtkrapLEva/eRGZKI7PYv9rXv10dTwzqFCsJmK2asdnm//Ji4JottqTM35MdnNlkC26fzq5mSzu/teOaocM60IMQ+mdv+exkFonmhEwm4OFHrSvGjoc1s7en05zUPT3wrEtWRgxHBxzz2XWyvD6KHH0UPSs3y0OPGyJ2Ikt2/Z7dpx1dg2Za2kcAdhDsrBVK71tO6wUblJJ2U/LQl6yKhiJqc5C9ZUjROqFdy+DFKjj0kPkjm2UqIKp5yEMHbxUq7P3RHZ+T0pCN5waMoUsRvPU7VooaDmnfxaX6pAthl4HB8Oeb2EmlzsZ9tcxLp8vu1uJ4PWGlP9Rmlt1GmDjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUSN6LDY3yihFC/9eRF7/zZbFYWoQlHNewblzIWhhuI=;
 b=hfmfKGVWldKW0dGKPOKUwOcxYtQZOSeo9AMugaPy7AtayE4xgnOsdFM0MegmbGklauLy80DezupFh553rhfnEx1AlSGwo8ikUA0gmisXPUeKHgwQFmlN5I/MobV71szKuAyDNO36dxsbws5brgeykwbQeGG1u2G8+wj1VFVnonxur8TGmfo9fICUqaTHsAPXPeR1aJem22vuD+9+j/UVB+4y2/o/czJYCrp4rNhcQGvgqqbrKeYynbbJIneJWnLKPeMOPFJ9Td4ix3ylypKdQGJYIYP/lvF477O5kFwYrDTwwpn6GffVL87mvtLlBW3U2fPL7y/W78kwIV9fBEoa+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUSN6LDY3yihFC/9eRF7/zZbFYWoQlHNewblzIWhhuI=;
 b=PmAGwiR5+/hBtmCqPdcXWmIvSkbe3i6OlsS0ylfxHMacTTsM2nvqIL+uOGiDFGOZHDzP9206I5jlyPCMg7MXrfXy57nCYKEU+ZOGzcdZGhjo7HlE25YukDLToG9zmJ8wmNpA1LuxQhZeahhpEup7qc5Xb6Le3Sf+yxFEssgbees=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6049.namprd10.prod.outlook.com (2603:10b6:208:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Wed, 15 May
 2024 15:22:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 15:22:07 +0000
Message-ID: <284658d2-f67f-4b6b-bb82-d3970b5243e2@oracle.com>
Date: Wed, 15 May 2024 09:21:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] blk-merge: split bio by max_segment_size, not
 PAGE_SIZE
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain
 <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20240514173900.62207-1-hare@kernel.org>
 <20240514173900.62207-4-hare@kernel.org>
 <258db2c1-6c08-467d-a365-6b623c208c85@oracle.com>
 <b0ac6dc3-8c15-4cd4-86f6-47273aa7d417@suse.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b0ac6dc3-8c15-4cd4-86f6-47273aa7d417@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0066.namprd15.prod.outlook.com
 (2603:10b6:208:237::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be47997-c151-4c89-4d0b-08dc74f2c87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SEdwTGVLd3pTMExYVmlQejFLYlNlVk1OTmxoS0tSTEJoYjdJbDhoYXBXeVpO?=
 =?utf-8?B?czkydnZvMDNUV0JId3ZzQkY0a3kvM053UlFkaGlUNmYxS096QnRsNUw2bE02?=
 =?utf-8?B?VnVHL1dsOFJZMTQvbTlmazJsbjhGcE9tRHFzcFBra0dScFZRcTY4bDE0ck5u?=
 =?utf-8?B?Y2hVSEJ5THFjSTNyYTdGaU1YR2g3N0drYTJjVGZxS1RVSnA4bmhOM1BKWWow?=
 =?utf-8?B?c0xNWUc2dXFLK2t3NHN4QUVaWDJxbDZzWUJGQWxicTB5dW5jamUxeDBmUU16?=
 =?utf-8?B?enZVcksxM2paaDFPVmdMTklMcG5xZkJIN2FiL0RHS0E2ZkZlNjhqUUNCdG4w?=
 =?utf-8?B?aEFTWDd0WVR6eTNmN1lkd1NNUG9LQWV2N1lOazJRTmRYbjYxbk50bDlaTmdy?=
 =?utf-8?B?TWlqUmg1Vk1jVHhaeXFMN1hMZnNrVEh2S1RJbVB5anVmU3oxQzNBVll2Q3VM?=
 =?utf-8?B?Q0hQOFVpZXdlbWtvQkhwSE02TlRFNkJoZTlKOVA4Sm9QNWpzQ2xCRDRTNCtH?=
 =?utf-8?B?N3pJYkRDS2Ntd05rTGhwL0lKR25TNnNCZ1hMcm83S21lbFM5b1MwR001bkQ2?=
 =?utf-8?B?TUN2RzhoNFF6bjJwV2NxR1dCWFFtSng5d1RkWHc3TWJXa04zUXNBY1lvdTlN?=
 =?utf-8?B?TDNWSTduSXNpMmtRUUZNVzdsb0psWG9PUFpJMFRITkx1aWQreHBrVHJlK3Ni?=
 =?utf-8?B?b3ZrV0hwVUtXUk9TQVNNd0ZZNTFJL3p2VnYxNTVlakM1ZHloUEVtZC9BZUxL?=
 =?utf-8?B?RktTSlhyU1NnSGxSTVE4bE13S1I4Znp5L2svM21mQzZycitKSmxEeW5XQUc4?=
 =?utf-8?B?ZlBKWVREVGVPYkp6aENTaGVqOXlzMjZjamxpbjY4TGN1WFZXMjhjMFJGRkwv?=
 =?utf-8?B?NURLTHBrNXVWaWxMdDYydmZmbkZ3ZWlqbjZWcmF0eDJQdms5SHI4TDN0SEM3?=
 =?utf-8?B?R1VXOSthU2tYaTFGS3hXSjVWdzdYWVdDRmdGUDJYYzd6bmNudkdGa002R3Zn?=
 =?utf-8?B?VjRuOVAwVmJGYW8zUHBqTnh0T3ZiVi91T1dTbjduMXk5TjZhY21tZGVzeE1U?=
 =?utf-8?B?SzFCNkhoZFhWeUJhb21PSXQxN3QrNGNpNHlaM0YwaC9KaC8veGJRdmJaU3N3?=
 =?utf-8?B?UEdjWXcyTlpsQmt0eGI1R3NuTGh2RHhQSnFOQ2gyb25xTDY2NDdmaXc2SkRD?=
 =?utf-8?B?UE1Yc1MyTHVyS2h5VHZ1UnhBeCs5amc1TEFBMHl2Z1Jxc2YvK2FlVHhuUUt1?=
 =?utf-8?B?ODRmK1lTYzNlcUdXR3NJSmtoV2F3V3g1NkRRNlJqSlR4UGJqVlFqWWJrdHJZ?=
 =?utf-8?B?dFNnZ3NaNEJwZjVyUUdSdmJzdEZ4eTVzb1NzZzJXVmxCN2NhdncwZ2VmKzZS?=
 =?utf-8?B?LzYwVG1LWHdCY3hYRGhHRmxxWnJRcElFNEdyTlRWWE5zVmhOa3g1TkFTb2pG?=
 =?utf-8?B?VU1MUTl0cklqVVhSVStQOElEZ0FnUkxSMzdiSkxOOHNtQ2tsbnh2RUhwbEpj?=
 =?utf-8?B?NGhxOEV0NEoxeXp3ZnhYYTBNd2JvTkhKNGJ3U2RLcUhibm81WWNWdkdKSldF?=
 =?utf-8?B?WjViTHFRL2FaY2didFRtc09ia3laZCthbHFTVXdqSzRuQUdDblNqcktPNm5Q?=
 =?utf-8?B?MHh2MmFwYTZMczdwMHl3cGUzL2lsamNoVGNuQUhoTGlRdmZGZG9vek8wd0lT?=
 =?utf-8?B?K0NOWnRlQWNSd0Q0VXV0MXJyNHRTOGt3RHR1blBHdC9HeHM2RGRKWGF3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkxKLzdmNEhoY1VJczFyNHpKK1R4a0J2L3pJN3BmS3dWRWpKL2JtbnZ4c0Ez?=
 =?utf-8?B?UkZxbnlxL29BRDB6YmxyNk4xTG9MdTZqWlV3cTZabjI0YmxacEJrSFVhUHRr?=
 =?utf-8?B?QUVEWUtnbFlvNCs3MnJPWmVvK1U1V2FOZ01heU44VE9hVzFRV3g1cmkrR2pq?=
 =?utf-8?B?Mk8rL04wVHQ0bVZFZHVwMTJzbzBVK3ZCa2hoMzdYQW1wbWVpVjlYSnZHczRO?=
 =?utf-8?B?UGs1YVlkbEw1K2o1U3VRaWo4a2VXeDNBWDZZQWxhMEU0dzVQdjVYZ1VlVmVv?=
 =?utf-8?B?dVZlYllqNVNuQTA0aW8yUDhTR1c1eDc2OFRQZ2tXNTNCTkdVbWJrektVZTFj?=
 =?utf-8?B?cXRWMXdNbzhkaDM0V2p2bHFFVmhYcEIyL0JGcWtvc1h1ZGZxSXhPMm9jbFV0?=
 =?utf-8?B?Sm1sRzZUOSs0K05PdHFQdlFzRFAwWUF5S05FMWpkTHRGUURkTDYwMmJSNXZm?=
 =?utf-8?B?bjNQV21NRm1KZGV3NTJGNDNPWWdNaU1acjZNMHd6b0RqL3ZUTkFSS2N5VDBC?=
 =?utf-8?B?bkxUV2o2OVhkNk1NVytneW9palREVW05THp6LzVDWCtjV01jVk50TDVXU005?=
 =?utf-8?B?cmFCRmdVbXFsR1c3ZEJJM3gxSHB6WU1aN0JMS1dBczVjK2QyMnk1a2hsNC84?=
 =?utf-8?B?YWpMTWtsYzlNa2UxdUk2cC9wbHMxdUZ5VzVQclVVaHFOYlhXNWdpbmtzdC9E?=
 =?utf-8?B?YWpwQndMT280WWxaMkFSNzR1UHJWRWduTytqNDVlMkgyWUVTTUE5WHlOTjZt?=
 =?utf-8?B?MCtPV0xzbWljdkUxSWphTG9BeWIxeEFaWmVoYnBkbE9pUSt5dG1XQ3ExK2ZC?=
 =?utf-8?B?WFFGZTY2VGFZV0NhdzdZMFVSaFJzZ3FrUGxCREN6WVVQOGIvclpYOC8xTU1H?=
 =?utf-8?B?Y3lrMi9BYWoxZ280MXF2Z2MrZ1l4Qm56NGxxcTNGMUhTU0RMdGdISXZUUkY5?=
 =?utf-8?B?ODViVk5jZEV5d0l5WW9VSWNCWHJ2Z3lnazJmaEpSMEgyZG5lcmxsM0t0cVkv?=
 =?utf-8?B?cStWT3V5Y1BVVFNkWkdqZUMxdWpBSFNHU3RBWnB6S1UwT0t3cXBTQjJPeWVi?=
 =?utf-8?B?OHpPM3FJeUJBMHlGM0d0Q2JlTXpLL0NFT2pST0h0VFdSbDJNcjNqNlFSSzBV?=
 =?utf-8?B?SHRJVGR1Q1kvbWdXVGNwUHJYV2dhK2hTaGdqdnNwNG9sYWtBMVowOWdrNXZS?=
 =?utf-8?B?ZEhKa3M0NmJia1k3dnFMemZaTGNSdzJwbGFuSkVuQzdFYmpyenY1VkFWSnlu?=
 =?utf-8?B?S1VEVm8ybjFQbm82aG8rUDZVdmMyZXhxeDdaTURWUFl4N0N3Q0Zrd1A2WU43?=
 =?utf-8?B?RTlGK2I3K3MzNmhGR1dHemNGN3YvcFAvQ09zaVdWcS84ZHZSQWh5dnJTTEpW?=
 =?utf-8?B?dVVMVy8yS3Z2a3NXaVB5WGlaSzhHRmc5dGN6cmlNZjJ5d25veDNyOVFvRVN4?=
 =?utf-8?B?Q2tHMnd2bkV2K3J4dzFzQ0UrWFFNUnFKOEhIdy9oWlJmYm1ReS9iT3M0Y1Rw?=
 =?utf-8?B?NWtTV2JmQ29VU1JSVW4rQnROMVRXd2VLcC9tVXRFUnFoMGxSdHVrNXphZjFI?=
 =?utf-8?B?RVpqRm9ZaitHeFdyR3RsWGNHdTQxVWhsQkYydThWQ0sreC82S3phMkdQQllO?=
 =?utf-8?B?K05xM3pkUGk5TktVcTZFc3hoMFc5TEp2N1NVQzVaWG5wem13UUY5ZE8wTW5w?=
 =?utf-8?B?K0x6T2Nsa2wvR0hsODNsY1VLNmdPRDZnZjMrc0haL3RIeTI5WU9vTHdIVjcx?=
 =?utf-8?B?OXR2NnRhbGo3UVhlaEZCM0k0MDZWdnNadHkzTnhtZ3p6UGJYeS9VNis3VkUy?=
 =?utf-8?B?YXhLYVNKNGV5U3dkblZRaFBMY1BqVm9sYyttSnhaaUdkMWpaWVNJTE41eFlR?=
 =?utf-8?B?b2NOYmJRWDZ2aEppcnFWZ3JZbTh0M0pPY2E2bnNNT2JRSXN4Nnk5Qk1DSzc5?=
 =?utf-8?B?V1N2TjJ2QTc1cnUxTWVvdTgzdGxRV2tlS21Mc0ZKT1k0VXUxeVJtZzNERTlx?=
 =?utf-8?B?bWhpL2s5cmxrN0QxZVMrRlBodFFkVkw1WktVQzNrbzd0SzczRm5xU2YwUFVW?=
 =?utf-8?B?OWtlNU4zV013bUI2cTM2VXhoNkU0YkVKVnZ0RG52M3VReVZBem9TU1RWQkxl?=
 =?utf-8?B?MGh3bnlYMlpIRUhsODhGWGZRbjhjYyt6bGQxa3Zybm5TVXd5bXUwdVhiWm5I?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LbSA2JL03S0dN4pkJXAq5TCk/ToxYia0rX4HQASJKbfQwq7kdinGj62pm1KiRL+M5Up/IYL7HBJQyY3UrcImV6EuOam3LP9mxAedSKOuoK+bu7j1xPi1dU44p0cy/Aei0t02b0XsdOA+R2MuDun4jDVjp+BHCOKb8jgIMByjbq1uxlehg0MI43en6BZIsdBFtncqilug5ZQasc3isM8HWsu8UeMdLxPMMhvIAMkDui7V+zhGPGlsJEyRX+fxCVFvVW1JXMkzinTMuIowCg25f61yQSaigSv06aPHzyjPRZCOuvmQfFn2dQVojaSKPI8Wa/+X8oTfnyz9Uu8K1oAjBI/1gUORSUhqMOzibogBkvzjfmQfkpRI57liQet4De98Hj+O4Iy6+CGncsRiZWWYFDot4/38rDGggiwkkTqkavYMm+oEek5r0f17DbrrucR8RIsuqU6gVytMyaibgN1p31tZckRoHjFzYYRBAEBPxdwJjBlJljEbQMqrBNY1t966fc257oE9gfFv2SzPdRsyH4NVIrG1D4YAbnu/e09CFXaD+1Y3VWqIGTa5hLCOHREXg9R5tcRPaHq9ATSrpfI3Xym4/CqrqTbGNa1YW2QLILQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be47997-c151-4c89-4d0b-08dc74f2c87d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 15:22:07.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGh6dOacyePto5EbG3yYqt29nATWin2q7ZD4pbEuHazO2pE18Gt2vun8a2msQb6Un1/itdvIzBP+daN32BDk8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_09,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150108
X-Proofpoint-ORIG-GUID: Q_E7f9IcQ2z_Y9jQw-SLIVvigfi_bnW9
X-Proofpoint-GUID: Q_E7f9IcQ2z_Y9jQw-SLIVvigfi_bnW9

On 15/05/2024 06:29, Hannes Reinecke wrote:
>>
>> I suspect that you would need to also change the PAGE_SIZE check in 
>> __blk_bios_map_sg() also. However, I am not confident that the change 
>> below is ok to begin with...
>>
>> BTW, scsi_debug does use an insane max_segment_size of -1
>>
> Can you try with this patch?

It's scsi_debug, anyone can try it.

As for Luis' original issue, I did not see a proper explanation why the 
crash occurred. The splitting code should consider max segment size 
already, AFAICS. We seem to be slicing off less than LBS, which means 
bytes = 0 after the rounddown, which crashes. why?

I think that all request_queue limits should really be double-checked 
for this LBS on NVMe. The virtual_boundary_mask is still 4K, which 
should be ok.


