Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724841CF7B7
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033699; cv=fail; b=DKuTxQy1xSdITKl6oBCKpzRGT0iuZP2F4Hyn643noVeYxImHZvcI/6V6jWcY626vI236Hm/XjCYEnHGY5/k9n6FLjMc663h1EVMkCHenb9ocjLYXt7IKT4BP9le4Yo5q/acOSyhn0jcxRaQoRa2UDN7ID3NXW2p7gx71cdI4Y9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033699; c=relaxed/simple;
	bh=VRlutLj4HnBERQw/qpYpZImAmxuj6XMNJEAzEX6+z8I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lc0M+DWm/YJ/lKlt5ij/cuv63dhvlO4E4GqMeuxlOjXdhY7U/JIWeNv+ZBPuHS5ofZ43jetSnyK79h1UkVCxpK61UAUzNu0HDlhX2Qcp/deoEk3yNeeRcml97t5ltz6jf4mx3rtYDFgMeM/U+AA6ePvk826N8T7WeZ/NAp/NoVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hSnqPygh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TUJhHbqB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hSnqPygh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TUJhHbqB"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGMnjf008548;
	Tue, 19 Nov 2024 16:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XneNlC1tvKK3UvHWRhavX8vyg4UD80YVpgZuY/ACyrw=; b=
	hSnqPyghuPRDAKEf00P4Bylt6WSwuw/XyGzTMiRV1sxjbdP7y46x/7YTunK14Sfh
	MEtIKbCmaQFBXXlwqeljcrKmAig4IcXzyAo4j3JUDEmfu+i4R/tjqSynjwVMLqOV
	o6loqw3FIkmn9X1++EvY1iiAaF0NJ8gjlK7iZwaUA5mDC7cffl4bm28dRUauHXnf
	9cbbZFnY2E+UbX+uY9n1zrEgxOD9bMsdiIn26Jc/t9K5LuZY/mQDM0dtGkUnV8ua
	HXMybIcgFic81ST2yvD6uRR60wvXxJUDOAeSVhQLJSIv8ru4BwRzDF+eFgblcV2t
	VbG/WOB8cyD6GX3nkH8V/A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa5d2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:28:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFlE0s009019;
	Tue, 19 Nov 2024 16:28:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8ygbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:28:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvKJNIMwkdTBD6i/qxAHGOcwXl2Nmf+q3tKRtIbGePv7JLmF2upS6uKLfQiPYr/o1Gq5TNw0b7e/5cS2zoKcGww9Sr2kn0I2EKyrJXNPVbFJ9K+N4yZHOUUS1LZmq6SlqzFtTLvJwCYf4VwRhcLvVZc1Q6ByUOzfgLq3u8K8G1Mi76MqLrOvdcG0a2ZCt4Sl4XvlSVzhfQ9vAGSHNHj182ySwIzxt6UdyC+GrcnLTXtAw/1Uy5fiUXvoTmHKgz8owMAw9kEELvabMb3U0Hi0xLANBSMf/XMzekuXVrk1a8iP+uArBdLhPjaxf/xA8UZ5wWtNCjFgRqNuhIEw1fWKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XneNlC1tvKK3UvHWRhavX8vyg4UD80YVpgZuY/ACyrw=;
 b=nfje6napv9tKo1SO6iPCIT/3kHKzKQJLtYVPDloU3KNNSlj9XVHjIh+AtQCv0zZgSfuzQPoGoupwNaBwfBHiDL9H1Jcai53yA8OKuf/+Z7aUVaTj6hUqvFwme68/EC5uzvyssjuapouod6/NyYN9joAJgejdBNY2q6mNMKhVomZ9lAqL1vzMdCenYwtoSUPPh+pSgmmTVhPoXQx31lVqMyl7N68lguSEoMZQfyVkTJlaJ2LocLtFwx72XgiqOWQItOXrur/6wxw3dDpnpgZUCvj/IFXaAh1CckafTOIchIqqWq/DFq8MdCOqG3NoGoddJFDW4E0G/aR8uE+2TtSjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XneNlC1tvKK3UvHWRhavX8vyg4UD80YVpgZuY/ACyrw=;
 b=TUJhHbqB6ivnA0Ts0en8z8z+9VGpWKIyvkpSOg30sY86MpH1I1ZwLJpTr+oAoyCm3zKKJ9Sdmwd/DcszkBfRD5uXH072pwMOfpJJgTseG4JtTRq58zAAgDVTm2qQrE+R4h8LPRwAUIqLfSKb1R7f03YKS+CWR2FOHju6hrSRdRU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH4PR10MB8052.namprd10.prod.outlook.com (2603:10b6:610:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 16:28:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 16:28:09 +0000
Message-ID: <e88c9684-5bb6-4908-8d17-07c273f0d18d@oracle.com>
Date: Tue, 19 Nov 2024 16:28:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] block: return unsigned int from queue_dma_alignment
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241119160932.1327864-1-hch@lst.de>
 <20241119160932.1327864-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241119160932.1327864-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH4PR10MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f506312-ceff-4e2f-595a-08dd08b727bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW1GSDYrUXN2UEt3SFlXN2RReWVxL1l1ZjRESFRpUklic2JNa2FsUExxUGl2?=
 =?utf-8?B?cG43VjVvd3JwNGpLRGNHNmlWTy91ZTdCT1lrMGFDR09Cc0VheFNIa1o2dHdU?=
 =?utf-8?B?eUcxa3NGbFRIeFMwbno1ZDhRbGtMaXQzeWVDRkU2Mi84bFI4amtnSDhXNGJZ?=
 =?utf-8?B?NXBQU29uQWhBNEpUZ0VTYjVxcXY4OXgyaXQwS3d2RTBCVXdCSVNTeDNpMTd2?=
 =?utf-8?B?MVQ2VVhVNjJPa0plandTbStqYlAyWWR2aG1OL2pjWWsrQUU0UGYwWWxZZE9z?=
 =?utf-8?B?dk5LbGp0Y2tLcDRxeDRuZHVpdjhQK1dsWnU0MFE1cy9MZUhvditHVk5Pd282?=
 =?utf-8?B?VFc3TFdtQ3JzUlVXWTNteVlBb0J6MHA0WS9XTlFwZkdXOWptS1NRbnpjbk1m?=
 =?utf-8?B?Q3Q3Q1VWTjlxeXYyTlVTdzZET1RkNHdDQS9yM1BVR0t1Z2hxZGZ6c2paTGFk?=
 =?utf-8?B?bmwvKytGdkorS0FiUEJJVzBFZUR2OU1pTXlxUmpIM0tTeVBYL1g1cUozRGt3?=
 =?utf-8?B?MDVWTzlvSzZNa254Z3JtUjY2ejlOS3RlNyt6L3JjdXRXNllwVXdsRjY4TUxF?=
 =?utf-8?B?TEczMjU3dldhS0xIWXhqeDMzcjFHOXNTeG05ekpCZTFmVGNaVzhPSldWejMw?=
 =?utf-8?B?Myt0L29ERGxURzBQUE8zY1R6NWw2Z2wzeUUzWUFTdlVyK1E4RzMvVjU5UVU3?=
 =?utf-8?B?cGw2MkFhL3poQVFxTzcyYjc4WXZ0VXZMV3p3MUtUeHB3M1RibVdFbWd6ckNL?=
 =?utf-8?B?NHdOakxIYVVEaHdhOTh2ZERBSmp0Z2tMMlZDUFg3c2ZvcUkxZlNXQjg0dXow?=
 =?utf-8?B?N3lnTXcrazhFbXVBU3ZCSzhDRUFHd3dFNHNnWm04cHQ3WXQvRGowd0tYWSs3?=
 =?utf-8?B?ZGlVeXNlWkZ1N05Ob2hFSDBBbXpnbXBXVFNhbkxVZHRjSzQwWU5veWtLdlhv?=
 =?utf-8?B?YnllMytDc3BGcUNaVGFETDE4TWtEK2xiMW1EcmRteVNOVUx1V1AzeHhvUVJZ?=
 =?utf-8?B?c1ovTkFEYm5GNjlxUktBTUZIWWkrTi9IK2VwQlhObmpWOVh2aDJNVXlyTDM5?=
 =?utf-8?B?d3NDaWE4TUZVNU1NRENiS0pNL3NoWlZEYVlNK1B6YW5JVG1TZ0M3TVB3cGFm?=
 =?utf-8?B?U255SzZCdWJXeUhVSE9ySUtsc1o5cmJBaEZDWDVDcER6OVZGK2pRZVBSeTky?=
 =?utf-8?B?NkkxQUVUR2ZKRUh4dGZIN2xsOWVCZW5SQTNRL09WWUY3dDM2WVZZdFAvZzh5?=
 =?utf-8?B?dEY4aHN6UW11TWlqYW9abnVBWnJMeHFKd2NxRnBnbE9RYmhwZGdNanhtdTdo?=
 =?utf-8?B?R0VUL2xab0FpQ2RyU1piK2dZZVVjWjlyaFhHZ3VqWG56ZmJ3UGMwUnhHVWx1?=
 =?utf-8?B?TTAxWDJ4Rm5tdVhQYmJZSjlrTWk5NUdQRHdwckRITVUvVFZXWmZmT3VaaWhQ?=
 =?utf-8?B?QzRPRG9yVzlnMUZNU3QvZWYwNjhCRUFiQ01KMjEzMWRpeFVGaHFpVTNCaExF?=
 =?utf-8?B?Y3J0ZW1TVDJBUHFjc2p3a0ZteldMQncxK1J1amZvWCtOckVaUnlSSFhic25l?=
 =?utf-8?B?TG1HZVd5VHR0U3B2MmN5NmNFNSt0bXo2TUVENGNwZUtRZDZqVU1USzJ2OFVw?=
 =?utf-8?B?NkRRRHZ4S2ZFYnlQQUY0dVhIdHhnMUpiN0ZlM2tuVTB3eXVvYzF4dm9jay9z?=
 =?utf-8?B?eWFxaXV6UG5jajdDaUJBQ21UN3R0aHQza3Y1M2l2WEtSRWpSamMwSjlIcHpi?=
 =?utf-8?Q?d38HXA98XY6+04pxbwvXYChkvXFxc4zWN47kS5h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V05rdERiTlpNL2lEL3dvNnpMRHRZdXJSNFQxVkJETEhtbEtWNW1wUVltUFR5?=
 =?utf-8?B?UHpMSnBIb1pPcndyeXEvcU0zSUJieWJEUDArdnk5dTBpb1F6SjlUb1JiMmZz?=
 =?utf-8?B?Zml3YUlPa1RMSHpib3hwQ1NLV3hvcDhneHRYUmNTUlM5SFo3SHJQZDdKZ243?=
 =?utf-8?B?YW5WSFVuSVM1R0xIbnMxUUo5TFczMUF2a0xRd2JmeTUzdVk4UVBaSURYTE1U?=
 =?utf-8?B?WmJrTUpjcXkyQyt2bXZFZ0dRYTZzZTRSRkpoNEtiS1YzYnRDdzIwdVpQcXNE?=
 =?utf-8?B?SzZSRnhoSUgxSHB3aDlVdlFvVjQ1emJaZ2MxMGxiRTFXQ3hRS3JWTFc1TlZt?=
 =?utf-8?B?NHZkNG85TUpOYkZIc25rbHBNcUpiVVNGTTc4UFRsNHJFak1zL29zU3JJbDlT?=
 =?utf-8?B?VDZzRFc1M1NjTUxjNEtWSm5nRElBQy9mK2tOTExocVk2a3I5OGg2UEhNcjNv?=
 =?utf-8?B?Vk9YOU83NjUxMm5FVlpOTmdocmFFd2JVMjJOaEpwcERJekNFRkk4SUliRFl3?=
 =?utf-8?B?NzF5WWh6UEdTTzFnZGZvd0hvUVNJUkx0N1cralpOQVlQSlRNaEsydXYrZG5s?=
 =?utf-8?B?Ulc1YzZabE5WY3FPcUpDNE5RWFRINkRUV0FWSUlkeGlZM1JDTllrM1VIclZV?=
 =?utf-8?B?MmtTaEh0aVY2cStRa1NQM1JNOWNXNzRrMjIrUitSSWZzVm9MMVZsYjRjNGNL?=
 =?utf-8?B?Q2tzcnBJQ3Nmc2FNWTZUdlBXR3VIekM0ZUQ5dU9yZ2QvcXhaVFhFY3RIYktO?=
 =?utf-8?B?Sm81UGJ5eG93WUQ1T1hLZDVSS200cnY4QUlqSThmMjc0M2RnSmh1MmNQMzA3?=
 =?utf-8?B?cnFnN1ZjMkJQbzk5SWtjRHNsT0Z2Y0I3K0c0ZXNQaU05Nm5RNENHMk4xa1FC?=
 =?utf-8?B?VTlYekdPWVN6TjVCRXYrU25hNXB5NGVTMnZQUjFSVG9HL1pKMzdMUnNTUEdj?=
 =?utf-8?B?OXp1YVBLU1YzMWM0cm83b2UzSlovWWJQeXUxSkFhZjJMekZTMkdkZVFoekZN?=
 =?utf-8?B?YU9hWlJlcU5HenVObHFiUTI1SjlMOHJrZlJ5ZEp3TkJIUWZIN2tiTTdHMUp4?=
 =?utf-8?B?VGtJS2V4RWFWU0tSbXk3VmRmalhhbG95aS9qQjE2VVY4eFNHbnNSbXFOVUtT?=
 =?utf-8?B?Z3JpSnFJb2NFZDBNdVhTNlQvcENOS1hqSGhhS3dMdFJYSHVrQWszb01mK3RB?=
 =?utf-8?B?RlVZbE5ua09UeFY2dEgyYjVWSmR4RlpIaFhMeEh4VEh5bTZCVUhjV2c1bit5?=
 =?utf-8?B?Q2N4UVQzVUNsRERxQ0lkdmYvR0ZlMjR3azVsbTM2TVhzWURZR1pEMHVXUWRY?=
 =?utf-8?B?QVVUM3E0TStrVmUvVVVSNytoZ2ZiMGgwL2ZEUGdzdHN1YlhnVlJqUjhpdERD?=
 =?utf-8?B?YWt4ekd5WVVuNDFCMzFmQVlpTzVldEVzRTZWRGJ3aVdaQU45dXNiUG5CKzlF?=
 =?utf-8?B?RFROVEt6ZHpheWRzMmlhRk1YYm8zb1pxMzdjbk5LQmdocEptS3V0VTh6OWZE?=
 =?utf-8?B?UnJVSGd1TFlLTGE0cmZWTmJ3UGYwWlZ4MDgxcGVmQjJTRjZqU0ZCbEM2UFJP?=
 =?utf-8?B?RzY3blRUYWdKek1UWU51MUsvQ0VJRDdBY3U4WUlyVGxNMmU4THNRTkI1Y0l1?=
 =?utf-8?B?cUl3OGtSc3JMajJSWm5vMS9zNERmNVFMRWdjdEY3TTlEZXZZMi92cERXdk1M?=
 =?utf-8?B?eTVralB6MXpBVkw1Zk9YYUlrakJoZzYwZnk1N0xtR3l0dDYwVnR3OUZVOXBW?=
 =?utf-8?B?SU1YT1MrMlhnUEtvd3lCVWNCRFpzM3E4d0FDdU8xdFBFSEtCWnFSMW1uc2t2?=
 =?utf-8?B?ZFhQSUNVcHFablBzRTNJRHNDQ1ZtUjRTVU0vQ1FqNzc4QzhiamllVUx3T3Vl?=
 =?utf-8?B?VUlSL0lyNjBjd2lUSzQvQWQzY0tTWTdtZ2RBeldRcHVsRHZuNFJNVTB2bktS?=
 =?utf-8?B?TG5BZFZUb3hwSW5SanpwTXVzYnAxVXd4QVgwWlU1Ylh1elhYVXR0bkVjemRu?=
 =?utf-8?B?Mzh0SGttc0ZDb0xLRnI2d0Q5aW5EZ21HMTdFQ1F0VkJ2cTVJRkJPd1ozYzlV?=
 =?utf-8?B?c1M0STZVNzY1MEJ6cWNMR2R4MFVzMUdSL3NyQ1h3Uy9oVlFvQWE3WnlzTGF5?=
 =?utf-8?Q?7po5KNyFrVkKq72W0Zz8xIHT6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xTXP+HEt0IF4feR5Xr1GJScoINRupP07hsB2OsJkfHJUH2ki1nwUffhKXohPXL599o79htNl2CR/cpP+KlTlELtgYug69mej9iRkjaF6ZZ/NokjIBBVz5WNVA3B/tbWQvYkhoXh4y3NhR+r7wG8oAP283KVry3vnWGeYiMAboKXKcNodFkf53BMU9c+c3df7EGRRs1rU3hNj+yPgZ5L8w7G/J/LTSoP1bK61EXvpTLmd9/ybLZlSBaklJKLxvSyFzFz/H+RBaKHlyXHJy143MELlFcC7STuwQ4qNu3s2M9hSpGH1StGUAMWFnBR704QI0nDiWOcWrnporcuIpZ1UaQlfshpOFbXaN65VOTBz9XMLOMQqrkRKdnNHFTq6O2IzEKg862U2phY20BQOj1XAQBKEUkkx9X5IHYHwHaYihFN+V/mmNULd1oPdAcMCruijBF5DjzlyX9d/2sPZhFNi7n3MAq+sZeu0BkCUN+8rVfwHqkpuqdqi6VXF79Hyphx/FDIjiwM92DkawgpdWObGra/FHIhkIIAkh73PDfBDhDAWjMlRmnnWbBryYdwWF39ULWxzARYLVtj5sRA/BCeHJTtA9HTMUKzuCJuz013D3K4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f506312-ceff-4e2f-595a-08dd08b727bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:28:09.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxQG3Vxp9uZimFV5yl24xQNuuTAycGkbwDXOtaMy4zp6hp2a+eN/JjuI+zPfvHrIhSov5Fv+dHFY7QzJgaQqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190122
X-Proofpoint-ORIG-GUID: k_bFR1JYTScpBT0Mo40OAxToNTLEbusR
X-Proofpoint-GUID: k_bFR1JYTScpBT0Mo40OAxToNTLEbusR

On 19/11/2024 16:09, Christoph Hellwig wrote:
> The underlying limit is defined as an unsigned int, so return that from
> queue_dma_alignment as well.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>
