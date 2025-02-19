Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A022A4FD
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992660; cv=fail; b=acTMmXL+iNhgZudW1aGcjMXmKbtVfwmJsyWJOBiyV/23RhBMCTHYNok1tCWBuRqVwEGAwYewYWSKe/bUG0pxalEFA4H09+l/pSKGKEvMKus8K8KkMpNnkAA3gs3MWXNqfvJH7I/3vRC0KtdM2j/FLSIGRsfLJswjriTDesMRRGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992660; c=relaxed/simple;
	bh=2y6etyqME32C8x247wJS7hpZXAVAN0hHHAwpOg7+T7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eTv5R5QFTlzZXOpOvSz4BEg/Txq+9ASs5Xx47L3kzcDJDkPhqPgjgybb7JY2ioGhWaoC6coagZR2AEDigzr1zngVSXxlwoMBtNFpGVpkDTlYS9SyzbMtgJByZEBc/lXGtTzLOBaClwkxTPsBq9wvsxhkzgXPmaYaWo9TbsoXVrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h5oqkZlC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XtbFPLi2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5oqkZlC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XtbFPLi2"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JJBY7r020871;
	Wed, 19 Feb 2025 19:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ErJhotKE6JXQgJ2rfHwkNgzrJUsJJdZ8AqljpMLvMgA=; b=
	h5oqkZlCFRKxEHRJBbJNQqgLKWQZnRhbEIz0jtnBtfom1CzGJW+oT2AaPaaM97rc
	hGH0TjoCIEdgfyjtNsN0vclR/CwXZBjBTJDzbQSE71A38vwo/vkYlgAiHSIFIf/h
	esWlAyLhPuIG9TbQcU1QUEncjQhIMoqSGCfDWV1HHC6JSsU8We7za/OeLAZxK12s
	VG9ckgRFmt4ZKJ7MUEmru3YFKNNT64rX/jebAFWNM5uxkyeXixbYajUG5GIzEeKj
	c05a0U7ds1FAaB0//6ttzALIKv69YO5j2S7qYuP1qB3XGZzTJBd6TRAD7GOJVkpw
	LnD3pvQllEjEDXjZdPxuBA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00njgny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 19:17:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JI1aee012031;
	Wed, 19 Feb 2025 19:17:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b2wmef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 19:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNMi3hkLqDHvuLc0Yw/e+mZ9xQVyfqYkz32HCiZBaMmY1NGRfsgy+8oHyQi5q1TGMrcAQ9Vb8LEChcEf9XnPM3NKa2CyRTi3Vm/ox9soAFSkt2VGpT8SdKhv6gR2QVdcve1aNH3fn8zT+s/CZ/4pRHImrcR6MjAwas2fRY8K/9Kkmfs/Xz0vd7IsCEhjEw1yawKvUqSkO2Rxa4+SkSwcZrGfhvvd1PALu4Yu1lWPf/CFNftUkYhiBg5WghHFJ3ZqH1eTEcR61yuEKRy3oW20FflkuKJVSsVQaXKc+fGHL7StvXA5XnRSdXBKmRWXv+UbjEn20mxxZ5XoDvQtRZxotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErJhotKE6JXQgJ2rfHwkNgzrJUsJJdZ8AqljpMLvMgA=;
 b=GXQQ1WE6WsY3F/DjnkoM8pOwyxcXf8YlDwzblouh4aafaAe+j2gv0hDM0mJmDxSbwedosJsSQznPcJhkaAigIPDWYuHgp5gu8CMVguOzhV5871zyf3UoZOnf99Ieglr+D6vQfK61VZ/onr0Vq+pRRq5MsicRn3J0igZyKsRV+B8AZq+aCdubyrQkquCsYVefDIdHlvc7rkkrT8al+bPKvSfRF8LghXQoEex/tFDqRnW67rNhY0WBIookfFBuJsevXwMn0Upa4b1Zgl61HT5itS3jEOtibeCFrm4wkhbZRleCbqXEPXxHGvojICV0c/hI0Gbmf6nIlMyK0BLl23WwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErJhotKE6JXQgJ2rfHwkNgzrJUsJJdZ8AqljpMLvMgA=;
 b=XtbFPLi2S+hGrX9XdrW4fbgTSwRHMkmeXDJdUs0QtrOCeNkaei1d0fM8yZFQXFwy/47+Mef66F6N7rsEwXRBU/4gXZFYZhKLH0pRwGF86KffLv3r7mN2GPiEYE5pbqrVUk3sHow5thppOO4sjF6IPdtNYs3E8aDl/Nq7tfqqwP4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DS0PR10MB7407.namprd10.prod.outlook.com (2603:10b6:8:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 19:17:34 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 19:17:33 +0000
Message-ID: <92239c7c-e7e8-494c-9bf9-59a855d70952@oracle.com>
Date: Wed, 19 Feb 2025 11:17:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0555.namprd03.prod.outlook.com
 (2603:10b6:408:138::20) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|DS0PR10MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f977642-7e3c-4bbf-facc-08dd511a0f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1B2SXAvRUtUN09TUlFSbVA1aERoMDlOUGpKTEdiUW9NR0RiZ2JMWi9kazBI?=
 =?utf-8?B?czRlZWlqRzIrS2ZLc2twU3kzK1VhNXg1RURMTVd0a3d2a3NidTBpeVhXcEp0?=
 =?utf-8?B?L21NSm9SajNuc1BSK3I4eDVRSFIzS3hqekVpVmRDL0M2NTV1cTFqM1U3Ry9m?=
 =?utf-8?B?OWxYZjlMUnROSS90OXhCSHRHNGFETm95SmxLTnRZOEJSSTBIdFV6RWNRVVVr?=
 =?utf-8?B?Z0tzdW5FekUvOE5IVFdvWUx2aDgvd01zckltd1hXcHJIMjJMV041RlRBS2JJ?=
 =?utf-8?B?SG1WN0FoWjQ3aDhISGV6VFhPd0xLNU1QVVJuRWovSnJ4NDFIbU9NQ1lOVnFi?=
 =?utf-8?B?aDlXYTBrUUlRMGpNZURTM2IzdTVMcVoxbXpzdFdReW01b3IzalU0QjR6ZTl0?=
 =?utf-8?B?NmlMVHV6VTNESzdHaldxSWZORWRFSVlIc1JtdktTd2o3STRJSHhDOEwwK2tO?=
 =?utf-8?B?R05EYnNaYnhCSE5xSG1Henpkb3pxekRGTDNwZFI3Q1dIejQ3NENRYk1QeUlq?=
 =?utf-8?B?S0JRM3FqNDU1dHhlLzkwd1BHd1V4ZnQ0djJ1OVJEWnNXVnhBNjZpclhGOGts?=
 =?utf-8?B?cFhqSWJlTjA1N2RkRHQvYitlY29WRGtvUDRjN3Baam9xTlhRZUhoN3ZvbmVY?=
 =?utf-8?B?VjEydVZPZFArTjlSVXFjTkRlbk1hZVRGTXdmWHVJS28rYnovdGdBNHNKL1Vm?=
 =?utf-8?B?cGREMGc2TktCa01EWUZOeWxHa0JmT3JveXBGNW5tVElyMHIvaHBuRjZ4eGx0?=
 =?utf-8?B?UmZsaWpGTDFVT3JXQVRGL3Q3TXh2clRzVnpzZGJ1NlRDdkx6K0JhdUhBdGRk?=
 =?utf-8?B?ajVFbHRhY0dIZHdCa0RNQTJVcG1udWV3NDRBM0IzL0R1QVlqQnJ4dFR0M2tk?=
 =?utf-8?B?dWl0WHpZcGVsT3hDRmJnMkZaTVdMWndCV3VMK2xnSVE1TW9hQnRNaUg0T3JJ?=
 =?utf-8?B?dEJNVmp4M1NvU3M5dHVLdjhCV1JmWEhFWG05dVlBRk42bks4cmpZRktpZUxx?=
 =?utf-8?B?SWJXN1g1T2tNV2pPczN5N24xUXg3TjkzbEdQRmtOcHJkNVhub1R0c3dxZlQ3?=
 =?utf-8?B?ZU1rdVlqNUxnNERRaHY5MVJlcnRyc2g2VXZHZHBTUFhZeGpzVjZCaVVKTHJ4?=
 =?utf-8?B?Z1dCakF0R3V0M21tcUhodHJ4Y2hwK0dHVVlnTXpFeHFQNGdQQjZDbnlGTFY4?=
 =?utf-8?B?Q3lPV29GSE1QRldXdUsvcnRBN0RXZ25hV0hPQi83NEMxY0hDanR1TWY0MEVV?=
 =?utf-8?B?ZlhoQS8wenpPaU50VjVYVE5IVEZkSURKeEhYcnB2enZVOFkyM2cvSzJGYjhP?=
 =?utf-8?B?UWtRTWVZUHFyZmZ3MFEvSE1nYmhDVk1WY001Z3pCU2s0cFRiRkxIZjlna05y?=
 =?utf-8?B?OWgwakRQWndVZUtUdlNLTnhDRjFHeXIvdjV3MWNjNnZRbENtaHlTTDRJeStV?=
 =?utf-8?B?QTRBUUpwUEJlcHZQeHFPa0krTXFLT1B3MTFjSkUyeHJoTHNMb1dHdWszU1Y2?=
 =?utf-8?B?Wi9ONFk5UDFHK1kzL0IveldFd09sZnMzdlJyY216Z1NlVzFsdWtKQUcyMU96?=
 =?utf-8?B?ZnhvNXlSM3lEL3F5UWJCY05YblJSU0FCTDVxN0xyaU16eXpveUw2OGZpamx2?=
 =?utf-8?B?QjR2QUsvZWh1VG9mSCtaUDJ0YVFSVWRTZWVvdC9vOHhKTHhES2V1UTVucVRz?=
 =?utf-8?B?bGZ1YnNDdjdhTWY0TFlhTXdWOWU3RnVCS1lRTU1nKzk0TWRMVDZPdXdzcUhE?=
 =?utf-8?B?VXBFUnduN2JtL2ZNaTBsNVIwSmR1ellOZER5TkhhTEZSYk9QMEN5elB2NG5N?=
 =?utf-8?B?UmE0MmZHNWowQktzL0FKdkFLanhpS3AxM2Eyb2JjTWxTRVdOb3BQOGhKRVBU?=
 =?utf-8?Q?zsX9E6jCuy9WY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU84cVBhU1lJNXQzOHM4dk9vZjR6Vkl3M1FkQ1BuRTdzaXBEd3JsS0g4U2Zw?=
 =?utf-8?B?U0kvRDl6RlU2aEtjWk9FUXltQ1VnT0J2RTZEVGlYRGJMaS9NNlRVd0VBYnNS?=
 =?utf-8?B?bitiaGtWNGtQbVYweTdva0FoczNmZ1pBb2ZwaENGZUw1SVF6WEowWmlPWHBV?=
 =?utf-8?B?eHVxZzE4eWgrcmNoVlZ3SWM1UEVGcnZTQ1NudXpZckJhR1k0N0hpV2pXc3pl?=
 =?utf-8?B?Q0RteHhrQ3hmVUJWUFNEbm1vZWtLWitUNkxGOEl0eDBxYWZxTHg0TXU5R0s4?=
 =?utf-8?B?V3dJdmlvKytJYjQya2Q1VUt5RlVHa2RWZVpMSjJwTU82d1ZHVjljbHIxR2RB?=
 =?utf-8?B?YThFdDE4THA3SW5OTjUzdHZoMGptMVBjV3VJNDljOGdKSnlqVS9jdnptN25Y?=
 =?utf-8?B?YjcrQ3J5NnlSUDl5R29UY29qbFl2WExPV0ROL0psU3BtUHdYazcrak84cmpu?=
 =?utf-8?B?NmtuTzhZNXJTdnB2Z21ibGZpb3Y1RTdYZjJ2eVp3a2ZXSEZwSUFVMktxOW92?=
 =?utf-8?B?L1FCdStWNmdxM21waTFFUTc4UnZ2N3NZNUlEVHN5OGRXYUlmZEhHSDFoNlds?=
 =?utf-8?B?S251UDBjSFpnM0pCaUx5dmo5QUZmZXhzZXVaQlUwSm0vL3hvMnMzZmx4ajFv?=
 =?utf-8?B?MHkvUFJKL0RwdTdwMWhwL1FvQ1lDWk9PVkkwYTg2ZURObUNnT3YvUzB5Rktw?=
 =?utf-8?B?bnBtK1BZVm9pQ2FabG1vNmFBcE9VMnlRaDg2ZkIzSEdUaGM2bDZvVG9uUkRN?=
 =?utf-8?B?bm00d0tHV3J3NGVzbEpJOUx1Z3E0a3NpQ3lqanBZVDQxT1JkTk0zLytweVJ2?=
 =?utf-8?B?eU1KSzZRd2M5SWtLWWJkR2V2Z2kwS1lGdnUwcmNIbnVxNTcrRUk1a2lZOGZH?=
 =?utf-8?B?U3BaWkMvR3Bsa04rZTRNd09RUGdWaFlYY3RMVFVIYzB4S3NScGJlMDVEdGVy?=
 =?utf-8?B?RzJuUGZoekdzM3VyakE2cjZuRmN4SjdJQjBLcmVDVnVEdHdEYjdqZWxzZ1Zh?=
 =?utf-8?B?MEh0SXQrR0xCaGFNdUthVkEyN1c0MEFOUklkOGl4ZnpYc3Nab29GTFR6ZGl0?=
 =?utf-8?B?TzVFeGxzK2xlaGdJelZCVnVqdEcwVXRnVmJVYWFDa2RxdHA5Zmo4d2Z6cjQ5?=
 =?utf-8?B?S05yZk5HYlZJWnZPZkhSaysvNlV3YlZXUGR1cjVnTnpZa01QMGFTbXlablJE?=
 =?utf-8?B?WDhGeTc1TFoxSEFBMWJ1K1NZZjhWWFJkR3o5MjRON2ZON01jWjFETmkram9K?=
 =?utf-8?B?ZUREOXYzODZGcHNkQ01IZHVUWUJ3REZRaTBMRFZFV3RJQWIzbVZzK0QrbzNN?=
 =?utf-8?B?N3hNQ0xWTjh6MjdqU0IyZzU1MnlWaGFqcUlOQ1VtaitkbnJ0SDZBSHovOGlO?=
 =?utf-8?B?R0pDTm9GMXFnWHBhSnpZWXNLaDk1czUzaCt6M2pKUCtYdUZkOXlZWlhxUlBO?=
 =?utf-8?B?MXRJYmdXcDhYYXA0cFBPNVRHWWpkZXNvb29nTXJsOG1zK3BUd3hoY2FNa2E1?=
 =?utf-8?B?UXZqTkU5SUFHcTlmbzZuWDUvSllWd3d6dDZRMTJQbjNXcFhaU0N6QnNpaXox?=
 =?utf-8?B?eVlReVR3aHhvYTYwYmtsQ1hoRkNldWsrL0hmV2FiWkhkSVhEYitkOHJINDRm?=
 =?utf-8?B?bXZqZFFqR1Fac3RheTVyallYZng1ZksyeDNUTGM5a3JTLzdyVTZTV01lVW9C?=
 =?utf-8?B?bmZ0Q3Npdm1UcEJaRjFVb0xpN0ZValVneGRkZFhPSjFSUnNJSFNMU1N1RHRO?=
 =?utf-8?B?MmJKZjREQU50UCtENGhjajFadVVPME84TGJYTVhvZnBTWGJja0pPZm5sSzda?=
 =?utf-8?B?bzI0S0hRVkdRRWxYcWg5amZsb0hvZFprL1VXTjBWelp1dGRGbzFxY2pUZ2M2?=
 =?utf-8?B?VVN6T1dKRURxZEFqN0tvb1MxSmoxRUUvY0FYRTRDb3ducksyN0cwLzlFVXE0?=
 =?utf-8?B?MTdrdjgzWnk1OWpEcTRrSFUzOVRKbUd3YWN2Vm5EYmF4eTFIMmowWlpKc0JV?=
 =?utf-8?B?QzdhWnNobW52bStraXh3eXBxaDN4N2RJQmlRVnovaW5EcGVYV2ozLzg2UFRo?=
 =?utf-8?B?T1BqOVZpN1U4c3pRTUlkYWZpbkZBSHQ3R3FlK0tlZU5HRkY3TUo0aWcyTkc5?=
 =?utf-8?B?clRRYlR5Q2Z0QmRzVXlMTjFtVTJsczFrOHpEME5lc1dnSDF5Zjg2Smd1WGNJ?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s5InbF72KC6TcEc0NWn1rBw5zSjuYHNvmLrhSxnPCYEf1vbJUZmrKY8stSdMHouaVrwcPUgM8bqtuoFRUfcTd5R7LeDJJ+eqhNtdalKicqqkGzEdNTowrNQ3608HTRoJ8H8s9XFxr+NP2+rfcR5/ji3IryS48WUPtGS1SLbMRoJ2fWbaAniqkg6cdD5Sc5px0llUZlclgosLslynFXld2ieuLtKupf1WElLTS7FpjIpXaquAzf9sHebdrdx33OLuOMTGv8xfYHueo80h8WM3vUmd8S1mvBLRAe1PypPBFKUEm+igyGRKjhX/21/jOtSZDFrE1bR8pxPLhFGerjpdHG9CR6k9CZWLzJtA44xLVgyczxvfRUTtZyanDcLnUVibWn7jt4scMqY1gG5sF+orGhJ/k5TfWD1Q3c7Ad0Sd/+v7U+qb5vSdNnNYziQcp5AaCEfUmnUDR8GatrDUKL/l2h/CZrcwfSlxfmF4492HCNmYL1vbZR7hFBXLSq/WmKzkA0yAyrozSM/kkAilvlA8zAwBMj/58WiNyIhurl3nn05JihlKtwK6oEYLe8V+ILeEMYFdi3KAt1xoiZQttO2YgSXnvom2iulSgGMuniRsLq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f977642-7e3c-4bbf-facc-08dd511a0f9b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:17:33.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfQ2h4uw956msqMSzuHN3jihzzlpzm7Gg1xdqr9zBsLx8TxwWUdhJv9AfLteBdWW6wApevglTTZihazeTEwfAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_08,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190149
X-Proofpoint-GUID: YwEm3a7nRjR9jR-ZzjG79Cw41V5RGKb9
X-Proofpoint-ORIG-GUID: YwEm3a7nRjR9jR-ZzjG79Cw41V5RGKb9


On 2/18/25 11:26 PM, Shinichiro Kawasaki wrote:
> CC+: Alan,
>
> On Feb 13, 2025 / 08:18, Jens Axboe wrote:
>> The conditions for whether or not a request is allowed adding to a
>> completion batch are a bit hard to read, and they also have a few
>> issues. One is that ioerror may indeed be a random value on passthrough,
>> and it's being checked unconditionally of whether or not the given
>> request is a passthrough request or not.
>>
>> Rewrite the conditions to be separate for easier reading, and only check
>> ioerror for non-passthrough requests. This fixes an issue with bio
>> unmapping on passthrough, where it fails getting added to a batch. This
>> both leads to suboptimal performance, and may trigger a potential
>> schedule-under-atomic condition for polled passthrough IO.
>>
>> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> I observed the blktests test case nvme/039 failure with v6.14-rc3 kernel. I
> bisected and found that this patch in the v6.14-rc3 is the trigger.
>
> The test run output is as follows:
>
> nvme/039 => nvme0n1 (test error logging)                     [failed]
>      runtime  5.378s  ...  5.354s
>      --- tests/nvme/039.out      2024-09-20 11:20:26.405380875 +0900
>      +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   2025-02-19 16:13:05.061387179 +0900
>      @@ -1,7 +1,3 @@
>       Running nvme/039
>      - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
>      - Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
>      - Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
>        Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR cdw10=0x1 cdw11=0x0 cdw12=0x0 cdw13=0x0 cdw14=0x0 cdw15=0x0
>      - Read(0x2), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR cdw10=0x0 cdw11=0x0 cdw12=0x1 cdw13=0x0 cdw14=0x0 cdw15=0x0
>       Test complete
>
>
> The test case does error injection. Test method requires reconsideration to
> adjust to this kernel change, probably. Help for fix will be appreciated.

Not really an issue with the test, rather the error injector is broken. 
I'll investigate.

Alan


