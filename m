Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C43B27E9
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186736; cv=fail; b=PV45fqcJvUrEvnuZ9dWQUSm1pUn1X4udmYL0OzbqCgv+5dlEiQwGwx1c/XkLcGvT7I1IbBLscUtP9MVlvp9U2GolsHTm1pMRMEMHHg1tFKZKJ1U0seJBFc1IZOlLcmExYnMTI5ZbpqVJK+mEs9crRdU/qKNSn78rEF7qkDYKrfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186736; c=relaxed/simple;
	bh=8Gz9J0e5dLJqaV2nfh6yEyhVmUZbXT+LULgSzEObcGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GNEC3Q8s0DTdWN3i/poubZ91wrc9AkFklR8pChNAx17Lxblj3koc6GJU7EWZA19ap9k0w4zkO/3uFpaD49dVQKsj6z3UvTgcuqzinRIhaqSgC3uf0A6FHMVmy8gkiUvgreDOkjTtE1qJLSo0QzFrtfWw1/RgV8P6F0AhTmiNGSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PR0l0xjD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sRVumy+F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PR0l0xjD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sRVumy+F"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKN2GR3155246;
	Thu, 16 Jul 2026 07:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OgslmzeN4mPGl04cNn607F6a7wPOwRuKvHWEYWp2mPo=; b=
	PR0l0xjD3MnFXKbt14kOe0yUj3shDet4FQeYQLvZQu8mSkibO33URV2L6CoVp026
	yhUbLNedXiuw+enLYAbVmVQvh9WlD7F6VXhfcsoSOLUutxac6X2TxUBfK6HAfic8
	rSfvFF+W6ZpvwD6YtfzeNo3Lh2N2kN7ctg6fxo6G5ZCkgqXRFjecVdTfaJ7XGB58
	k8LEFIuNP2rAe/ybA0JoxbdyVbLnaVAzOWjVhm5vKNDafjFhDYn87Zu5NN9pNxFL
	XyKzqE5bOa4t0O4oGiblK/Y3UNWkzMx5yPnW0nt2Sm2qKzd0/hU+GNYXYA+hY6e0
	IoGWbgOijeFYtbGWMIbCgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbepn880j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 07:25:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66G7N99f024360;
	Thu, 16 Jul 2026 07:25:19 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4feqyc5959-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 07:25:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGZot0HEbya7o4D7xbbS9B/04s6zcrT8xfAp3vCBR9GBrxpRIud2j31AE53W4WBppq9iw0zbYLP+1JbTar8iyJYOAQzNBjGS5WW2pUdVFTEGhPmrW0DtLrYJXXKfJX/06EgrmXEFlH85vHdYzUG7G9Rtl3CXCDGlEmBXxXlph6T+h4VPHL7ZKb9On0vlzaoqnM/IFhslnGtJZS9mHBNFNdAR33HeeRot/k0QLpgoGjdKbfa4IyClKMg5cX9H6+o338v3+OdpxZSuJJwAfPk73HSP1xVYxEaC9aM5x0z8q6Kp+SUWnq2D6fdwjl6UM304tZVcJDMji/wRr7nUynf98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgslmzeN4mPGl04cNn607F6a7wPOwRuKvHWEYWp2mPo=;
 b=R4WPteLo/YfOlvYWiel03jT4oOhg2r1eRHfqRR/Zsh2Ly65Z1FQl4Ptu1LMxZZoyh34xLrRE4+9wyd4qI5g6qpiXh9NR+Et2t5y6b0AJec5aescW9IxJSGVBax11BvC9DRf+KlDaEh4DnIHbD+Y6FZYYnv642CwVe7P3SgffQY1ux2o3cfQ5ffrV65zkACtJ4ztPio+uzWGsPR2xAEBkrNjRLlfgeGLXtabpDKBwOrqgXNKjOoGHG3PsqzzSUKxZzDOzelj7TFJ0l/j20ENYNTxesCaLKtcEa5tJh4gae2UI/o7jQC4XUVaK8Xi/Swkcc7ZVq5LmoRHiHpBnhlkKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgslmzeN4mPGl04cNn607F6a7wPOwRuKvHWEYWp2mPo=;
 b=sRVumy+FRJ/vgSqmFzLJv2uugav0jsLUTAQs30yVRmbrDYoIkiMlmUI1XGQ+mmWDfZSC1KDTpr5wWToAdOIGqH/SEa41WrpXXTzAiNRHroTjHrtZurq6hm/pCY+92LxwfeciGw42F5EhxfBfNGPIdDIpUdMply/SE2iegl9N4N0=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH0PR10MB7061.namprd10.prod.outlook.com (2603:10b6:510:284::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 07:25:13 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Thu, 16 Jul 2026
 07:25:12 +0000
Message-ID: <e913b9b6-02b1-4e8d-a802-2573d1488346@oracle.com>
Date: Thu, 16 Jul 2026 08:25:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme/069: add a test for multipath cdev lifetime
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
        dwagner@suse.de, John Garry <john.garry@linux.dev>
References: <20260715155531.3811457-1-john.g.garry@oracle.com>
 <alh8G0J1kXHGaOPo@shinmob>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <alh8G0J1kXHGaOPo@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0035.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::8) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH0PR10MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ed12d5-4786-4acf-f4c7-08dee30b5fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AIgsp8L1mDJMsxhoz7XXqdRkltxmqVKdKoo4+A7x1WZK7QLq/eoEGcPv9GtGxFwxU8+8edIVvaHVMZNkXf/x/H0xUGZm7nGmuG8wIh8OZ3THjr+4FY2rxSlD0ZhBmcXJ63MF4lOaLDfSuc3rXzZHwEgCBgKFRXZdS4O72wUMdOx7b4k/K/xY1Icup9Lfu88a2qiO6p2/J51ckDRf6VAWdUdFXD0/CowoeAWWtdcrHvaeK558ThtWZUWPd/F1Ybltan2B9kedIj8tV1EBctfpfIW46TzU/MiYUAGG+J6uvBl4eZST/v8fc+d6SUadr79ffFKfCDlW1AeuE+G8vcyQeDqc7rIm/MklnkNLu8zmht+GtDt4mQ9fMJfiIMvX6ldllrUhUQZps5jOIUisxjD+aYxyDrQGDFK0GqhHzydIWCwd6i306UPNxzMzcD8miElGU3hOJnszx3vVV+Y57jikB5IJKIJYI63P5gd5n91qOA9JD53iok9VwyEH7jBQ/SyMFhuAJHdxUh+Xp2PS7Rrn8pDgqeUFuTakz/dFvNCOto0h6P2rA8fwH+bsIAG6BXQoXnwfzYrUNnSq7GnobENfNh6QexhjyfEtqWJM3LXXvAtXMAMBeN3AdW2xH8gaDOwJGYbl6b//KxPW2j8jkrGeONRqzEgcRhIJI2iDYR6gdlI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUdta1dMeEJmNi9ITlNhaVBRZGVrSVM3ZlpLbHdOQWxDNVJHWFVKOG1VT0p4?=
 =?utf-8?B?akZGWUdROEFjOG1wM3k2YnRqbjBRNlhXaUkreDVaeEJhWGJ3VDdIbktMYzVE?=
 =?utf-8?B?Q1o5NUFQSlI3azIyS2V3QWY0bU5Kb1A0c29tU1BzZXNXbFhNTnRJb3JhdUI4?=
 =?utf-8?B?UENPTUdySkd4eVBObWRqT2o5KzgyWk9sbWpvRWZLdHZzNURkWWw5ZjJWR0hC?=
 =?utf-8?B?bnFsTEJIWkVUVm43L21ocFBXNWhHTDdheHBQQmhhTzQwZ2dUbWpEanFoa3Av?=
 =?utf-8?B?dHFMVmtpRE0wNGJDckcvMlFENk9XeHdvNjNoVGpsS2wxWnh4SUthTVo1QUNp?=
 =?utf-8?B?amhrR3p5RTRnYXpTMDl6Y0dkRlBxVkh0MVRKWjRMZDNQYXJzQUFORFJ5cEtU?=
 =?utf-8?B?WHRtaXM3MEU3blg3WnozbEY0bi9QOFBtajZybXFPcWZ4NHJqZnEzQWJkcnU1?=
 =?utf-8?B?UDBpM1FzamJ1WGF4dnM5ajBjSlFRQUFiZjc4b1pwQWRaN0wvc011K09yd0pR?=
 =?utf-8?B?NGVwSGdUV1ZyQzZldnlUZUxrcjRxN0xyc1R1ZjdiR0hXSWFTMnF1NDZaRDMz?=
 =?utf-8?B?WXhCNE4vK2l2UnlaUW5HZVQxYmxUMzc5OFptVmNZWDVMWW9aZ0ZNMHlmMU53?=
 =?utf-8?B?c2k0eU42OFl3dnZLVHl2djlSK21ST2xWbWhoa3BTYlB3TG9zNUZIM2F0TXNS?=
 =?utf-8?B?b3Q5K1JmeFI5QlRqdzN5U2R6OUh0Ukk3T3g3TjN0QlNvaDhpc2VNZ1RrdzFa?=
 =?utf-8?B?SDVieDBsTWcvTG81WUUwK3MwajFtUjlxSFlhRzhEakY4dUs5NCtRa0llQXlv?=
 =?utf-8?B?TUoxV09najBZcXZNbjRUMlA3R2VRTTRmeUxvc0pES3lNRkNzYzMrTUptWm5H?=
 =?utf-8?B?OHd0eCt3ekVBRmZldVdxZGIwMG1GRE4vbmRNN3lSVHRZS283ZXFPdGFFbk8w?=
 =?utf-8?B?Nk1FT2IzaGpsOVVUQmJnY3plcnF4RkQxNVJ5aE5rTlJQR1lWS2dVQmpBSHgr?=
 =?utf-8?B?SkEvaFFLYzhQOXRpeHlXUFhMMmNsUi9LWU9Jcmp2SXVxcW1HOFRkUEx0MVRt?=
 =?utf-8?B?dXNRVW04eTJYcXBuS0k5amE2Y0ZFMHF0V29tckxVamJFdWJPenRMQzhQZFpq?=
 =?utf-8?B?OTlycXZLdDZQS2dqK2dTTTVWK2RpMm9wejVvdlZpd2lyNy82ejc2UHVkNnJu?=
 =?utf-8?B?VHRFd2liS1lRNHlUd2V4UDZwcVdEMHVYc0xhc1B3TFloVWIrM3FGUHFTNmxa?=
 =?utf-8?B?d3RlL3lZZU9xQ3AyUWtxVk90bGVTS3BVWEF1blVqc01WblNuZlRkYmlhK0Iw?=
 =?utf-8?B?c1FZQktmcnlQcEIzbHprNzhXRldNbVpUbmdtaTVxM2ZyUFU1S3B0NEFzdEJW?=
 =?utf-8?B?dHErZkJxYnNaWVhCblhYWjY4NEVkMzVIcUxIYkd4SWZhVFB6dVV2K1VxNW1B?=
 =?utf-8?B?T01DZXJoTktvSUJRY3h6S0gxeU8yaEtzTEVXV1ppUFlqMWFmUDQ1MlA0NWJ1?=
 =?utf-8?B?aGx2V2V1Y2svWFhqTE9YbnhqZ0NNYWNaYSs1b2NQcTZBaFlMNkV4VHVnN2Vw?=
 =?utf-8?B?SkYrcUxPWVRWNWlRVUEybU9UN1krTys3MGk3YkZZRk9VOU4zMzJtNjJXcDF4?=
 =?utf-8?B?YlpLRk5yeG9xVlV0TkkzSm5wTjN4K0ZqMFFjeDhnejV1amZQVmJLYmYwUk9G?=
 =?utf-8?B?STZER3V3WlNIZGx1a3h2MS9MN0tHY3dlZUVDdy9TbE5LWFhvYys1TEd3Vyts?=
 =?utf-8?B?QlJrM0s3Tk9KMHlkSWVsUDBoTXVGZUpYNjNZOHUvZmxQbEdNd2xIVzkxT3Nm?=
 =?utf-8?B?czhiUzdjY2lUSERkNHlyaXI1d0N2QjlCbDhRUStJUEpQNE5KU1p0bW0yOGRU?=
 =?utf-8?B?MWN4di8zcnNZZXU1S1RBcll3UmoycCtUNkh5WnV0TGE0NHJMWEFOSVZxOU5G?=
 =?utf-8?B?c0VTNW1hejI0bzNDT3dxWTRSZDVzdHFMcE9vb0NkNGt0dCs3c3MrTEtHckxZ?=
 =?utf-8?B?MUlmRmNVdzd3Q05nUzM3VEVtQ1FSVGNwTnlyb3piWWJDTVAzZVdPcUxjZzlM?=
 =?utf-8?B?TTR2ZEsvSzhLbWR0elZwRk5CZklkOHpDOGh5Y1ZJb2dQNVZQc0FQQUZZc0V3?=
 =?utf-8?B?L0ZPYWU3anJ2akVMRS8va2Y0TC9SMEF2Vml5RW4xa09uOE9ZQ2VSWmZLUG8v?=
 =?utf-8?B?Ums5SktBc1ZnMkdyZFRSeUNzRWFjVUZiT2FML3EwU1pMWGpCb2ZQSXFHaDNG?=
 =?utf-8?B?bCtQUk42L21hZlBURWtOQnQzOHN6QW5jS25KVU5ISVk1WTN4YWozTjN1amx4?=
 =?utf-8?B?dzJhSEdjQ3ZSVk1wQ0NRNDlLbWZqUjM5c2FjbkVoaFZDY0F0SzRnQT09?=
X-Exchange-RoutingPolicyChecked:
	Gq4l+cQZhI2f/H+6BRFyN9FWd3CrZzr5CC8AJgQ8HYcrNK/qZ8LCmIhkyd6tP1Rfx3TsY97sVSieBvf2WdowyZDD7yCNUJR4HbHmEYKAL9aNw+8bWH3UoQJ4jAyh2GdNENmceqRfuN0i5z+YLwFGwWv0G5H3CTMeHidX8OEAYxXVc012q3n2yzu9HvoFVej710Kv0AiB/XBxHjXNDluQ1ak+2O+m1XOe/hP/UOFkyw3WY/547IjZ0vsvQXlMRqoJM0PGzdlrC1YxVxiIijTxWoQe3X0MrB3G5wkwBmowrpvi5cxpnNOF3MAK1xmHygpVqtcyopxzTHvxFKVqj7SiSQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xgV6T93jEhwwZfktTSaBZn1101o6+BhshNQn0lYRrKpA8xxFIWtTlSUDaQuFPysLNIQ3nEbgbEToDnvm8lTC9fuSu+FXbZiJXWXOYvQRa4VXWKhSyksE6yliXLl4UxIWv7VXRhotv3gZxWxryJ8Ji3cS6Sd83fjPf2nXltJ0GAqxBBxdeVLOPc7F0p2cD4xmBOGz6cWSshxJjf6/HcmckPHWzD9pLAEISsEBeuo/LhWFv7FHs9EBcska0NLjFyNO+HdEXrCNlNEvZiTtdDuqgu9MCGzvkZas7ovTX/WMNC98im5iA0y3CjrGiE/BSzoLzDcMehcS4vuWNIPEptGX8dBuVaumFYtwlVpGpUxF+w01ZFC7BJ/TSlD9lXJbAwKz2555gB7ib7pgOttYcq/xvOwA4ofevzEqrZVIZ0BcHBPCN5p5ffXXoEmt6Zw4kY2N4PlQ+lo1f6mOu1+n2WOCMOpYYHLa31vOZllzO2/UJRV8U4ctjQimvK+gzQ6UmVaxMUEN3eZhxk5zc3evEgAp/68GA6X4gJjQlCCWilLi6TsonpVSoyj2vniRdS6kk+amZHUZ3yp0sLQ1kLR8JKYCpfpWmy9IWe9913RmGM0qIKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ed12d5-4786-4acf-f4c7-08dee30b5fdd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:25:12.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lt/j133s1/t1HTDfiTwKEpCfmtJN4rkvz2Aoq0iILrgGH3Vo4QGFXERWSLPGh4tPkwSXSFHeKYdFP1jGqh6YEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=985 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607160074
X-Proofpoint-GUID: N5IhMqc1E2CQq3LKmbDGRMkOAurCk16u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA3MyBTYWx0ZWRfX7U5qEtACsLlF
 HbXJ2cZp4R1jze/7urKorAzyaoShopFnOE6FPTI/VMtJsobzScGRX6Owur3HJ+VxdrqAsqREFOQ
 X/Z3xayk1BZ0UzZNo0YPsBmgNUKM5D22QeiU9N/z8tSx0LjZZ1zq61pcvVHVcmQWmbwqmobHBgl
 nTiCzMSJ057EjKVXUhuGLHlpua/b4mfVPkSRDXsV4LqUiOWuNnxJJOxFf9OsplU7Pwz3m1FdJKZ
 DXeYn48Trs6KwA6uRB15XyRhURql4v1DUBWu/iYdUsvPSRyP9ubycbSD5/D3xhKEanjkqk4smB8
 YGkw7u+PZ0G69OXOi0LCcKGzQVcFFbavj+sAbgA4itJERe0XnKF1Bnq8A77au2t0PnJBn9fuh+6
 FMbEehoOTHU0CzgwmGRMmUzJs5nc+szjKYtgfejy188Icjasbc+lWzgnnorqDupRPq/DCgGjNu3
 P28lO6yT0H8alEiFZbw==
X-Authority-Analysis: v=2.4 cv=bJom5v+Z c=1 sm=1 tr=0 ts=6a58875f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=QuOPCFGGGHDf6ipLKXwA:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA3MyBTYWx0ZWRfX+u3KVn5a/G0/
 CiguD4NI7klJWsiVKqh/MfgHGi1GXTzyJgpG3aSMwQZ48Q8lwdkyxOd2IAhBm2pCmkdwuuu/T/n
 sCEbOlhIocehizeqOdYv+NENhBzvCPDezzcXFaCo0V1Ll1wZljcY
X-Proofpoint-ORIG-GUID: N5IhMqc1E2CQq3LKmbDGRMkOAurCk16u

On 16/07/2026 07:48, Shin'ichiro Kawasaki wrote:
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> Hi John, thank you for the patch. I ran the test case and confirmed that it
> triggers the KASAN. I also confirmed the kernel patch [0] avoids the KASAN.
> Looks good from test run point of view.
> 
> Please find some review comments in-line.

Thanks for verifying. I'll address your comments.
