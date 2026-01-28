Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E923570A4
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614141; cv=fail; b=uFHoZGDfQIJzFa9tDn3G+RSF9VC9ST4nncTPshTBYcRbKLJkxk4HA9oEO/E1m4oOwSJcEtr9zsSAp8KgQkQVCaA05KFwpBl3PeiBRZ9rFiWsupGQR/CzBJQhn5P37xrEa37yzewWV4ilqBwJ1EcTNTbN+NvfDT+KBlHolmOIOkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614141; c=relaxed/simple;
	bh=d6A4+/3aDKwx9umUceWAERBflv8yf/VMwcwVzeDJ7lM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iEXPC63GDUoNjygpRbKhhcRKW9MgM1adYqw2BRKf98yCUNQ3BID0sA+9Hr1BHHmKh4UYx3T+wWZ5xeg7fjEOKDmpDPDjSMsH9SmCsttuHVXFM34ntIdubmc3AughTScpVOy7SwSkkGMqE4YG9Fkctwy5EY+mTch8TDx3RzitxF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dAwnoAz/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LyOW85ZR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dAwnoAz/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LyOW85ZR"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4CKap1231020;
	Wed, 28 Jan 2026 15:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2raFG+GKNVCNKZa0yvK2VMZmH1FOgX2GH0BzWlt9XOM=; b=
	dAwnoAz/IRZ67C30h4xUCINnxrI+6R2I5IA4IC5N5M8bzILzxRhWNXszzoiUm2Lj
	N+rzKk6LTDf0MjPcIy7XjPKZDaB+kenA85M0tIjs/MfZaqlik29SQvmtglxjqsW+
	NZgs3meSLKIuBntFuqvdnVD9M6Du+ANWDM/lYJQ8/hK48bqGaghfYdnG5ZQFJ8Om
	cxPKcHrpFKjrSeTfV3wkvra03Dg7LOhKc4qz8foK/YtnL+Jox7nAsApJDMDpjnm8
	LWg9E6yX6d3wPK4AhW50CkPVR8W96+2qUquJ2QmdnwQBM20i0ur2zOeDrut/Js7l
	EG1dzldLczZGABbR1QYttA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5t696ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 15:28:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60SFFVfL010180;
	Wed, 28 Jan 2026 15:28:49 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhb2w9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 15:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp9WmFFiMcOLVQQ4XfaAA4huH0/nyISrnY1ssfQCn72r8FyrgG6obcUqdOYMGeUZ2ZUabuAmoxawFFHrBlSFH3iDop1sxbOWFaqVqtLSVyCXUgQHzeMhv8yo5EyBryXjT2Zzo7n/vzUgQWD6+d5qbOcjf5xc7H5jE739GkT3z/U16C78kh3N3vFp78qoAipIKFU2N7VJH3OLo7xMs3sztBqXavpdqPTeM886WTICkwAOisZJ0oGHxGlU5/uYDymv13aJzfg5ikX2Q8FZSv0lIb2ysEt0ZbnmXSWG3yvzo8kKHStUxlsFfNDbwK9Sladzey5KYkUqppTeB+rxZM+SsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2raFG+GKNVCNKZa0yvK2VMZmH1FOgX2GH0BzWlt9XOM=;
 b=duR6fUmVjZ0OT7FaqPB3ecYqEcBioX0ugJD1N2Z+B7AfpAgdAWzUwiNMrGxB1sSP2A7ekM3VRvZSwdohL6tk79TazSjfF0kqyGwABvTod6HvsvW/O7j45aUZNijJ2dMPgnDXqmbGHKKTDFskT1hkVabskWyaMUNUodqUxe5FZPZyCxvzkmVAHKYIZsj1McB7WHVcA9bIX1Nua7UAG/T4KxYfGwxlqoA76AVE1Ruk7T0SZ1DblUuHwhKDOncn5DLXzkxYLIeSTdTl8xNtaXmsnycXvDjAtgtuV5KKNF1CRaTg1lABUKZSeAhZYbfng25STsxzs+AZ0Ag9WdUvEHYTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2raFG+GKNVCNKZa0yvK2VMZmH1FOgX2GH0BzWlt9XOM=;
 b=LyOW85ZR70U0pN1JXpjDypP2LMsZXGy0iPr5nmklBVC9M2pfC238HBD4/h2f5nH1FC+MiseQW+kpIeH63fy8h6Sj7iG5JD+kAK46gNrYx1TCzOy+0V2QpQz6m6q/wo8bBlmqH/zWfzcU7+FrBfPvYcouzUScynLSbsFoFlqzWuQ=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ0PR10MB4478.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 15:28:47 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 15:28:46 +0000
Message-ID: <a19ae203-bda9-4034-a1f0-7528e942d7d4@oracle.com>
Date: Wed, 28 Jan 2026 15:28:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v5 5/5] nvme/055: add test for nvme-tcp zero-copy
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>, Shai Malin <smalin@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
 <20241206135120.5141-6-aaptel@nvidia.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241206135120.5141-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0646.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::15) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ0PR10MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: aa401388-198c-407a-5626-08de5e81edbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0lKMFVXdnlibWhlaUJ5U2xITlNlZUVjUTY5SStLRDBZd1BpUGZTdzczQjlY?=
 =?utf-8?B?dElGRC9OSWZWTldWZUk4eXQwWVcxbUdiNDBvdTVsNWxMUTFhSmFWL0RkdEdW?=
 =?utf-8?B?djRYUDhUdkdBZHNneGpmTEpqdjEzd0xiSEVzbXNwc2dOVHBhdjFtSjRrdnBm?=
 =?utf-8?B?ZnRDVWF5WkRmRjU0MEhoZXRrWEZjVjBTalFBZ2FEZTRVa1pCbmU5NE95MDhM?=
 =?utf-8?B?bWVvSVFRcHlzcHFDYzRpS2tsSW1ua0pEdm5LVVZOaDlrcDZ3eFBNUTY0MWNP?=
 =?utf-8?B?czBSUUp6azRKQjVoRitXd296R1dCS3ZUVTZ4aExDT3FpQUVjREx3cmMrRHNq?=
 =?utf-8?B?eTdsUE9IdlpuQktIQjd3aWtJMkV5eHk0Njl2RWNBMjRpcGxrWVZUT09BSm84?=
 =?utf-8?B?Y1p3UXNVZ3ErNHFXQWFYYm95WXBsWFd4WGpBWnZRZ25jVlc0eU8rVUpzS3ZN?=
 =?utf-8?B?RDN3Z0wwcmU4WXNUTU5BUktTeFBMalZ6a01yU2doQ05FVHRNYkVaelI1a2l0?=
 =?utf-8?B?SjlEeFhBUDZHQzUzYThGZmNaNzJDVXFYY2x1TzBIMG41VEtYY1ZlQXVER3Ix?=
 =?utf-8?B?djEwdHU5YjlsdzJtTzFWNmpXY0pJWnRWNFdRaEJMcGJUY25OcWJYWUZBTTVv?=
 =?utf-8?B?TkZUcUh0V3pIdlhrbDdVQ0ZFZHB1S3FjQndZUHY3L3h3NTF6V213Y2tVWkxm?=
 =?utf-8?B?KzJoL2hsUE1NV01ZUWZ1Mi8vU1R3bm54bWlZOUc0L1FRUm1JakhOdTZlSEo4?=
 =?utf-8?B?UVA4eUZiODI5bmFLS2N4YVJUaGZHVW9ucnRJaytGdm83SXA5L21tbFRtditJ?=
 =?utf-8?B?a1YxdmtoNGFYYzZFaWFFZHNnaWRMSWIxUXVkcmY4TGRCK1VzT1lTZXdERzQ0?=
 =?utf-8?B?cTVwdGFySWNVV1JseDVCYTN6U3d3TTJIVVY1a2pQYnBNR0VZbWNRU1o1b2VE?=
 =?utf-8?B?Yk5LaWU2L3M3dzVHYnFxdHZVWitaejVOU1FTdi9qdzVyQ1VXc3ozMTlJRFNS?=
 =?utf-8?B?RDVOdWI2VFVjOWlSK09UWGV5Vjk4UGZ6emNWdHdvOEw0OGFEcjVhbU9MOEhC?=
 =?utf-8?B?ZDkvTzAxN1BQR2cvdHo2d3BnRTZVV1o0V1BhNUY1cEdwSTRUNzUreFFyMFFT?=
 =?utf-8?B?WmtWQ1RYUk5tNG9RcVAydFNTQ0phU2FjK3lvQTErZ2l3dzc3bmtMRE4zbWx5?=
 =?utf-8?B?eG5VV3JldDVqUDZHbTR6V0krcHl4VjkwMTNNNDJxUUVNNFgwb0pybkc4V3pa?=
 =?utf-8?B?eUIrbW5JZzBCc2ZxOS94VWFDWjIzOHZqbHlndi9XMkVxUDBuQkUvUVU1eURL?=
 =?utf-8?B?cFk3a2xvWmdlaXc0dExHU0VoNkZDYUUvVzJlTS9PaVFnZUY0RElteWRrbXI3?=
 =?utf-8?B?WVhQZ1JDLy9FRjUrYzRlYWlFa1BoL3lUWU9iMWF4RFpyb3J0b2ZIT3p3ZEt0?=
 =?utf-8?B?Vy80SE9IVVo3Ly9UKzZ4K0RjRkoxS2tjbVJvRzdCODJIQlplb25taVYxMEJu?=
 =?utf-8?B?ZzJIWnBRczRTclNnYmZVM2EwdFZObnBqQ2RiN3FyVWRoZDhlZjNQMEtGYWpW?=
 =?utf-8?B?NXhUOVlxWDRHLzBQY3g0TnJUdDBLUC9TY0EwMzd2aElvcTVkSkt0MGFYalV5?=
 =?utf-8?B?dytySnB4bUd6aTJaZk8rREowOGd0dTdIYWFsYXlKWTJYUXhTRlRkNVFxMzgv?=
 =?utf-8?B?WWhWRVlxamY1c2F6M2t2SUd6L2NsblJrcEp3eE84bi9tM0lQdVhnV2pTeXda?=
 =?utf-8?B?NDBkeG1WdVl1eHFzZzI2dldsV3V1ZzF4a0ZSYXZpYVJreFFqRktUOFRVQUtN?=
 =?utf-8?B?TnpvZ0RsbWtac2VRR2d0MjgySC93bUkxVkQvWVI0NFczcE9ud2tKMlpDSmJq?=
 =?utf-8?B?ek9ENi9GR09abkdYVEg2WWlYdTA5enY1SHNrRFh3RmpGYXlTU1doTGdzVmU1?=
 =?utf-8?B?NS9XTlp3eEJqOHQrQ1pWWm9qa3grNXpBelU1ZW9BQUd5NkwvOUQraVgrbk9K?=
 =?utf-8?B?SGJIUENVU2QzUG9IZFZJbW9Ed1l6dXVPUERuelkyd2w0eG51dFp6VGc5VGJN?=
 =?utf-8?B?S0FhUTB1M1BQem94VWhwM0RIQVYxYjRwODBVSHlvd3A0NGdmaEVzMDl5MkJB?=
 =?utf-8?Q?Znoc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak9Ob0xYMFJkdXZUSk16b056a2YxMGpRRkJseVd2TS9qek1WVzdNeXNpaWky?=
 =?utf-8?B?MHhhL1Z3eUU2cTZTQnlNdW1DNDhrMFFhMmhaMk05VmlPSmJKZThjMzRlRGhr?=
 =?utf-8?B?YkpPU2tKRENLcUxZZXRyWmMvbFdTdHdEdmlJVDYveW9EUTMrMVB6MkhKalNi?=
 =?utf-8?B?L0ptYlR2bGVCeDBRQUp4N3dUcFJPUXJOY3VuTkdYRW9HczRYNDhTTlRQd1NZ?=
 =?utf-8?B?cTJON1U0MjR5R1VqaS9mR0ZKMHBBU2NacndFWFN3ZDc5NExhYW1EdGwyVnZ6?=
 =?utf-8?B?YVREUHV2U05RMWNzM3E2NFRYLzhMb0phcDZoTnpWcy9lNmxTdDRtU1BUWGlI?=
 =?utf-8?B?VFNZQ0dLM1ZnM2NTcGY4OTlXOVZjRjRPV3J6VmFyYURVTi9MZzBnSFl6N2pJ?=
 =?utf-8?B?V3pNRXhkTlpOSS9odnlhWXZvT25wWGFpSy8zb2lWa1p1N1FmSWs1UE9mN0Qw?=
 =?utf-8?B?dlcvR0E4dWhCUnZIOER2U0xKTVRLbm5XWWZYWEZCNDVKVTJIZkhLZDBTMis5?=
 =?utf-8?B?aTRyM0ZQdGh6dzhkWnhLNjlCcFRhS3hsTjVxZGc2MEN4Q0hibC9TVmZMbkJr?=
 =?utf-8?B?MXo2RWQwRWFtZ3ZPNjZLWVNydWVBU3QxZjlyZlIxTDJlam1xem5Uam5KV2RL?=
 =?utf-8?B?MHYxY0lhYTNuc0NPaDMrMVE2a3hyUTBKSm5pOW9tbkdKNlJkY0pwUWRXSllS?=
 =?utf-8?B?cmpvckl6eTlqblY4QWZuRjlpWUN6UkFZR2ZBeTFDWk5KV2E4ZENKb0pLMnVS?=
 =?utf-8?B?dzNZMnN4cllkeUE0WnRKYTFZeklPVVQ0WG1oaWVTb2NwZzZ4cnMxNzA5Tm53?=
 =?utf-8?B?QWx1aWc3U0hRZGJLcUNQc2xoNEhmSEtjTnRPcXBQaHRwU0RTaldjRUFVdW5E?=
 =?utf-8?B?QjNiaVpCanZCNm5aZEtwbTJ6S0swRGFNek9Za3RaNkU4MmdpWlByb3dVcjha?=
 =?utf-8?B?eno1R1N6QUFVTVdZVjNZRHRJRHA2RjdmRG8waDB4MC9Pb0FJL2d1MVV1NHhD?=
 =?utf-8?B?Z2FZcHYwKzMwQXIwd2FwN0tHWGZVTTR4aU1YL1RGSmFlK2tKUy9aUmN0ZGlK?=
 =?utf-8?B?TTl1MjczM0l0aUhwbCtyZC96Z0YyNmRhN2RIV2g3c2RDdjNZQXNBUVo1U1JM?=
 =?utf-8?B?U3Ewb2U0NUtzOGh3cytyM1lHYjBvSXJaSXEvaEo0aVQ3NlZPdFlRbkVBVlps?=
 =?utf-8?B?QzlPb0Q3Vk1WSzNVd2dYRitacEdZVUpTWkJuQlBPNHNXWExxQllZcDBzWHNo?=
 =?utf-8?B?NFV4UGRkNWlMQ1h4Q3NUaGdjVFZnT1ZoQnNWbUVZMGs1a0hUSDZjNENPekFj?=
 =?utf-8?B?dUNFeDh4cG1COHhGcnZzSlZKNkNjWU9EeHFvYXh1ekl6aFFBWkkwOHJPcWxW?=
 =?utf-8?B?WFdvTmNCczlsKzZIUHpxcUNNVlUxZFhKNjIzRTFtc2lMYXhzK2tsV05wTTNz?=
 =?utf-8?B?bFJSNER6NFEwS3pSNW9FNkwxR0xuWWxYMGpZV2VBRTcyVWQvS3NLOUFXMi9s?=
 =?utf-8?B?ejRlSzQyYkNrVUkrMlNMRHhFUnpUcWNCcmM2c2RGZ3ZWU2gvdkYxVFFPaVNW?=
 =?utf-8?B?V0kvY3lOU1hUMjNpcFBUTG50SVRkOVl3clhoaVJGcVNvOWdpNStLVFVlbEZP?=
 =?utf-8?B?bkFVenVJald4VjdWZW9scENNYlJYVjVzR21DSW5OSlNZSWVzL0tZMUZDQjF0?=
 =?utf-8?B?NXdVNHdZakg1dXZ0SFE2YlI3dnk2VEVGTXpBekRpeUdjaTNIK0c1eUtKQ3FN?=
 =?utf-8?B?MUpBTHF3aHNBQ0FWblh0MDJma2tnZEhXeTBRSFdZSTcyT1p4Ty9LNy93NERN?=
 =?utf-8?B?WndScjBHYm03anJZVytuUFNTbnZZeGNaMkZXNEJiSHZMUnRZMVYzQ1ZBMjZk?=
 =?utf-8?B?ODhlU1ZySXo2ZE16aE9JeVU2K0tUUHZsOUsyTk9aK2s4R3o4VDlQSkg5VFVv?=
 =?utf-8?B?eVZuQ2xDMmZJVzJGM015a0JhYkt0c3BGaDdjLzhXalg5WmxwV0dXc2prVU5Q?=
 =?utf-8?B?c0ttUWlhYis5RlVRb3VqMitHYUdmKzVSR3haZ0JWeHlvUU1WbHpYK1ZkQVBD?=
 =?utf-8?B?VndQa2MwY2s0WXF2QVhBM1l3dzArN1U2UjZ1MlVsSjhIMlJpdC9ockFQbkU1?=
 =?utf-8?B?U3ptbHBlRjNRWUhZT3VsMlE2b2dNMkFYV0lsMFl2T0N4MVpOU213UjdBVmRk?=
 =?utf-8?B?cmNBcnY2dWFpUzQ1NVBmMjk1UGh2WTlJSTFOZjBvTzczdWhYQWNOTzlGZjlN?=
 =?utf-8?B?a0JQc0NuRmdvamxGNHQvaWxjTU5mTzBaK25tS29tZUVJSlJWKy9KTGhJT0xE?=
 =?utf-8?B?YzlYYVpob25Sb1hrejVxbndiWCtxWmJIYmJRWFo2aFdneUtSTkFaZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NwmAQGkeOw0FNFhmskr1zOZs2Xae4IlZmsemtxwiD8+bqAVApyQYJY/uQI5mGxt1XJMl8AYbdQZRZIygwCrQ1WWqHtNULA6fafhYAOXQ/YZULa0D7UPhXT7dtkRzn7qHoKw6VlVHiXnK4U2TKwY/9WbH6GsDiQY9+C34Dw39LB1nndPoiynmwXFNvEH1GP15DdgGGr85QKb/lv+z0c5UAEvoc/AoC0jvNm470zYQLtG2GEPbJT6VlSJbogBJSCgyl5XFMs6zdJKV80wRYcohjNVj5C29/ggTkV6eYqWXRJP4tGxs2NWzZ9YM7Xs1XMN6tXd0A05Q38fpLQbGDtNXYALp4R+SmsbJtdLsqx/QxjlAlvmSrZ+qvcg6PKTgCdSKo6ROzNo3/uKnYEXvG+e6GK/XzJaZmJxydpgR6WMzQjcKP4cYRr+qYtJD/q4+pbFL6g3CbE68hshUkm+Gzg5U00DYXPHXo+LP3NzQxAl40Il0lQzLkgcZKodOTqug/cyI+bDmYJ+1jK8mCy4CzLsyVlNNCGjhjgQ6m6zyHs0H4chsikljOCPjPm7K+xej4eJT2EdNlSmXWaVHlXZuPKgV2O4cj317KHjkquutnLC4FFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa401388-198c-407a-5626-08de5e81edbe
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:28:46.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35Sn9EbXhfN/9uyI1F8ovCGUoYNTULsiyNSjUc9yr1gRSHuKkiwE5EeGAc1T78EyuERMksD5T9QnNyQ2YlzM1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280127
X-Proofpoint-ORIG-GUID: Fqs57ve0Mm4RYDuBUPcMqbK59RBBvIpK
X-Proofpoint-GUID: Fqs57ve0Mm4RYDuBUPcMqbK59RBBvIpK
X-Authority-Analysis: v=2.4 cv=IIcPywvG c=1 sm=1 tr=0 ts=697a2b31 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=R0Fp75rKKuRQZDVuzsgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyNyBTYWx0ZWRfX98VK9oBnAPz9
 9DDTSxkJSOW5PEz4DpR/dd33BYsnsCdmGQuWesH5dtgKyphGXxRZmr5BXrQEXubdqa7xLhMDRS/
 T1yHUDohrApHpf50RmOVLGjhR9m+UVajR/zDSDjuctgrtL+pWPYF/FJjMeRt5UsqohP+WXOG7pQ
 Csp5fDJX7ax3H2TOK6ETjRZ6u3HdbgK9KGik6rZhoznk9YG6vSQA/AovFYA0DyC4YySc20f8422
 jpRTrHKUcc3/GF94IfVhjOYdf7/klVChYx8K8TvdlIO3kVva3KoqG1NwG71OZWvWiN7qCWwhY5U
 61Mw/udu0iYz63wcTdA0n0T6hdTnTG6mDGzfEFM974g7sAcZESIz+++6G0+Y+1Ltqacar3atdY6
 2P2BeXYJPmR7d8Y/n8RRIZRf3cDGKBPsCUCxrYkeZRSbtIGUEAnN37w3iJr//Io0mhkHFyUT2TU
 ljNFd2fjURywwVCq1JQ==

On 06/12/2024 13:51, Aurelien Aptel wrote:
> +++ b/tests/nvme/055
> @@ -0,0 +1,268 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Aurelien Aptel<aaptel@nvidia.com>
> +#
> +# zero-copy offload
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="enable zero copy offload and run rw traffic"
> +TIMED=1
> +
> +iface_idx=""
> +
> +# these vars get updated after each call to connect_run_disconnect()
> +nb_packets=0
> +nb_bytes=0
> +nb_offload_packets=0
> +nb_offload_bytes=0
> +offload_bytes_ratio=0
> +offload_packets_ratio=0
> +
> +requires() {
> +	_nvme_requires
> +	_require_remote_nvme_target
> +	_require_nvme_trtype tcp
> +	_have_kernel_option ULP_DDP

I notice that this kernel config option is still not included in 
mainline, over 1 year later.

It is strange to me to merge tests for features which are yet to be 
accepted.
