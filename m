Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7051CDFA6
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032374; cv=fail; b=PwUEenM8JbQSvpWKcJVnx6NssQztRWm7xSrR8Ns+bkn+vQ8eX8tAjfKGuf9Bc8ROnlLAi8DjIaxAr6M7rLwO7mvjHppHL8TWSK2zGE4z9zCuy2aZ+jnOjmvl2R8zKdSa0TKPEzQ8uZO4DK4AZQROqzkd6JZt19nendhumEh08uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032374; c=relaxed/simple;
	bh=DbnGat1YxmRed9DfVSzBCbqpU3lWIrJW7XdDElD7BWU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oq8Nge3baJHVh9570wLXNFi3FzJxfFXxENRAZv2SuVErOlliqztyb65bXrcS/k3kOZckKYXgfrANw7PwAFjgvNvOUoiWty3OvqPguTGoY4+LVTkhmgea6M8vyb8zHVi3zrQsI5ypg8J/UbLO/N7NWBLKPjfOMBOqdUIw5JrhwfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gRJuQry3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SJ8gSW83; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gRJuQry3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SJ8gSW83"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJFtZ42010146;
	Tue, 19 Nov 2024 16:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=un4qimGENBnqjrBK0nl8kSV9oHrZanHjfvw9nZDRu3k=; b=
	gRJuQry3agpv0y+RGnhB2gMvxAD8th7pkgEGXBsWBdUKhrMMg0d7jV1Nfa2ZSghd
	kOWpNJV8INVeUIC7tVdaMGEWTa6/we60f1CIezXHbxoI0GBSUI/uc1pK1dbM3E1K
	9yZ13eaUnGDrGcjDMlD2z6gH0QbZMEMVPWRz8RZ+qKWZe7PJ/kQjlxqGa6K6GRFA
	IZObjkciuwxNE21nB6NYJ2PrdN0t90tr45RhDgv7pbk6RGJ8NN2CSxa96ktdTXA/
	sTQAT2CD8htxgJGiVhLamFx1qmz6VuI9uDNdday6Cqf+xC+CaiOEApc09ucAke1z
	Bzea8KGH29WlxdUUtR84nA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyydahs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:06:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJEjDCK023091;
	Tue, 19 Nov 2024 16:06:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu9510m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w47u5yOlRANJfvGaRYw1vfqLH7kxfN0ZZ80tEu/Lsh8A0flusreaZ/6Xm4imqxZ/a2cN7HU00OajDHJ/0FKGS1xYt+iJ6WGEKQ/j6fIYLiYcxpBvfoYobDe1jfXYETi7yQXlqqRgxbt3pNZDKsFs8N7us+4hp5HZOt68QivZTgFwhqgQGlPtGwdnNg3vodSNsvz494H2nVik9zGE/yWYB/U2p2pwm1JP2wIwFmKXtsI9MVJuzdoBEmKgNWaobILkptAuTCLUN04uiDbuOVMww4QP8DrtPtwIX4KsmOSUL0ypxOea9U5JGjgtUV7xZKcVRZBLsfi/EkDx7m32UvfgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un4qimGENBnqjrBK0nl8kSV9oHrZanHjfvw9nZDRu3k=;
 b=olUAq284+D/HotmmMwBihV/xkx2SDHpmVg7Kmf/wu3OD5uma3AslTckzgqib+v3+uq5IpdU5YTscp7Vmy5J/16aAgBSiEN25P0VyKYyiB6CkIavumm9nMuN0u/pwXtiESj5nHNw3YdHmAoxZv3lmrzdq67qea9OiSbsasxFKYZxWyzPPQhNmR/C51Uc7Kq11DLRzjM3Rz1cxPEkxUS7tXScgB9nosVzvvLcvLnhiaGvIStdg8d75ot2z/mDfflL/Yh74jTci+bHk9JldNEVJeErLRWFa3k2nL77q45vfnkrT1pXjItSwSfu6YG9PaFIHy3gZoGcQWnXWj4awWM6tvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un4qimGENBnqjrBK0nl8kSV9oHrZanHjfvw9nZDRu3k=;
 b=SJ8gSW83EdzVwOHrTiVzpKIIQ9KxVdj5zD7wrzcwPQ/kjzQ1n017pqA6c4Vhy02kauBEFQEV1OuskHwfgR7ObItHp7vrt5pamuqeSx6TACzyLfA8NXrt3ySzYNYCNdHoItdhluN6lhGvelInlxjczfsO41ZVKfm6AS1AmP/joJM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4408.namprd10.prod.outlook.com (2603:10b6:510:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 16:06:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 16:06:01 +0000
Message-ID: <349740ff-fe25-4ef8-a09b-e72556ab83ee@oracle.com>
Date: Tue, 19 Nov 2024 16:05:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Drop granularity check in
 queue_limit_discard_alignment()
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20241112092144.4059847-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241112092144.4059847-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0006.eurprd07.prod.outlook.com
 (2603:10a6:205:1::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 948d54ca-e488-4e17-2f55-08dd08b40fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0x2OUxKbWVMWENhYmFPU2JrRkxOTGtCTW0wTVorcW5vVEN4VTVGVkgzTGJY?=
 =?utf-8?B?dTlRVmVIMnRsQysrSWxvSDg4TzZJSkV2Wlc4NXE5ajR4QWVpUDZuU1c0V0ZU?=
 =?utf-8?B?dWhOTktKdStGZTJHb0YwOWFRWDlvdjZTc3NOWFBEWW1lZE4xV3IrQXlCdjNl?=
 =?utf-8?B?Q1BuaTNXQzkyMUJwMkRWR21CVHNEb1ZaS29acE9MUGhWVXJ5d1RxRncrcHB3?=
 =?utf-8?B?Q2pZWFo5NytBd1JLb3lKeHJVdXBFVkFqVk9ubW5FQXNqb1BuZHBLaXlpSVVx?=
 =?utf-8?B?clRKd1JGeWhDU250OVNXSVcwVS9GVmlZTzdGT1VlZmNyMjcvdHoyazRUdXEx?=
 =?utf-8?B?S0J5dzlDNEs4YmZLam11MDdjK1NGVExUSm50NVNTN09VbDZIYTdEQ3F2UzFl?=
 =?utf-8?B?WjZYU3FEQ25vRGxtUExUdWd2QzVuV3ZTOGRjM2t3a1V5OHQrWWtGK0tWSjhl?=
 =?utf-8?B?Mnc2MmN1K2NMd3NMSWNxRy9ETFNUR0N5QytNbXgyTDBjbmlFMUlqakJTNVhp?=
 =?utf-8?B?R2g0VlhtVTkwbGpScWVaSi8ydGhXYnhoZmI2L1VXWHB0SjFrOEdpekUzS3ky?=
 =?utf-8?B?L2tMNXdzeHREN2tYeFpTUHZ2TklkQ3RxU1hwN083K2FRNm1CWGZHS1l5cG9E?=
 =?utf-8?B?SXQxNTh2OWRUazd3ZmZrM0ZIMm40eWxYbGZweitzeVpQaG13RW0ya2RkQWVN?=
 =?utf-8?B?MmI4RE52cFJNNEYxWDUzeHZqZmFaWmxtZ2QwbXFUUERVdGxXTmlzY24ySWdK?=
 =?utf-8?B?Tm5TNE8rc2RrNUlhQStsTzZycFB4KzN4YTV4dk9qT0txVytrMVJmU1M1ejdw?=
 =?utf-8?B?cllud1ZNL3lwejBWNHZ3YWJiSE9Hd043bmhVTEk4WWpHcEx4Y3g2dzd6ejFF?=
 =?utf-8?B?SkhXYTdyOW5GU0hZZTh0YUJjWWR5ZWRrY0M2U1NGc0hic0dwR1ZSN0pQcjZ6?=
 =?utf-8?B?ajdrMVo0SFBhNmRZdVBJRUFUYmozaE9LMUpRN09QKzRYa1V5cVpoODVXa0w2?=
 =?utf-8?B?MjZZYXFUMWRVdEE1dG9VVy92M0VvR0lSSUFScDJGbkEzaGVqYlQwUU1yWnRi?=
 =?utf-8?B?UjNYblRMRUNmNTFCMTUyZmVpWnlNVFdMem5icGhWSkhreldCYmdQdjY2Zmo3?=
 =?utf-8?B?c1lLNTBjdVFsdDdTemJDUjZGZTMrdEJmTDQ0NmdlTnlmY0N3eUx1WFJVL2Zi?=
 =?utf-8?B?eUwyNW80SDlJTmNCT0RvVGd5c2FGK2tPS1JVNzlpQVcyUGFab3hxZUpyTjlu?=
 =?utf-8?B?UXpuRGtXWDNOK0Z0RGtuL0dibm5wMU8vWGIvbDZLVnZsdWlSQXlwVlI1aE5R?=
 =?utf-8?B?NE9obnJQR2Z3RkxxZkppNDZaUlllN1RRZVllTWNzdm93NDZtekJjc2VXTUN2?=
 =?utf-8?B?T1FqRE5vVzNubEwzcmdPamM5N3BMNnA3VWNvdUIzakthTUVyNDlpdnBGM2py?=
 =?utf-8?B?UGhxSWVTTmdvdUwycCtCYUhoM3JCRGdHNkpYaUhCUk00RDhNaVN1MVZUOHFW?=
 =?utf-8?B?eWh2bXI4OVNVUWoyOXo2b2JUT3JCWkwyN3pvYkMyMGZFbW9WSWhjL2lvWXFa?=
 =?utf-8?B?Qkg5SnNOSEZLTTZXVkhiSHVYdG44a3JQQkQ4bGFQSEZzTmV3cmc1eFRUODdM?=
 =?utf-8?B?NUtxUkVSMVIrYW9teTJhNjE3SXBlREswcDdRbW95V1JTTUR4Uk0rSS9meG1w?=
 =?utf-8?B?L3NiSDJ5Q0EveFdvQnZaM0Q4VXRKMVk1SVNpaU5lNE5YV2RISGlQRzVqY3lG?=
 =?utf-8?Q?a2/yHpKxoWq4lOwsASuDlX9QO5BrdFt+K9tKxhX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0VpU0E5OEpLMmtnQlg0ckVsQWZuVnVnZnh0Q1QxOXZPbE82eUp3Z3lNMXYy?=
 =?utf-8?B?eDBTZmpVQXRKR2N5Qnkrd0FaM1A4R0lDMFRyNUZxUHI5TFQybGxyeDMxY0Np?=
 =?utf-8?B?WEQydUVWNk5pcCtJa2xZS2lPL2tNTXcwN2dSUTFzTTBXOUtTSFpyVjRnbDlP?=
 =?utf-8?B?akRIU1hmT1Myd3RpYytQZXpVcC9SaUVpQzM3QXlxOG9BUE5UV3prK0N0Z3N1?=
 =?utf-8?B?dWFUS21jSkRlRWhEMHZRdHBoYmEyMFNjTHhlT0xsSGpOWjhYUVFySVV6a0ZU?=
 =?utf-8?B?UVdrdFJ6MndSU2kzWkFER2RpT3FCRCtXL0NveTVITzZlNWVxVkZEalhUNGVC?=
 =?utf-8?B?NFFDbFZSbENpbEhBUnhscllaaGRXTFVVaUlwTlNWMmt2M1NkQjFSTkVPL3FF?=
 =?utf-8?B?ZjRFV3R1cGxXcklXa2pBbGthMnM5eG1wejhKYitaWEVqMTR4bjEvSWFNVTl5?=
 =?utf-8?B?WkpRL0NDZHMrYlUyRkVjS0JTUFp3SHpXZmJBQThOVFdDakFXckFMVWdlZFd1?=
 =?utf-8?B?YU1Nc2dsTlozRnczeHNqbnZNL0xleTJLVnZxeTE5bExYdlJpMHpRdFVneVYw?=
 =?utf-8?B?NlRLYm1INDl1STYveTllcnc1aEJlRmtrVjdCVUNWSzQ1S1B5QjJQSlNKNkZP?=
 =?utf-8?B?QkRRZ29jcHlSL2EwTjl2b0llNUd1MnJ3T1FkZy9vUUtKQ3plZkFwZ1QzU245?=
 =?utf-8?B?Z1RyT3FFcE01NEZmTC8rbEZEamRITmZFcGpUY0VPTjR1VytiakxnR09KbkJa?=
 =?utf-8?B?cDJ0QUR5R0IyaExIY1NlMkI5UU8vWTc1a1E3Mm5tVFA4STdhMXpvMUJsOURk?=
 =?utf-8?B?SGJpUlcrQ1lPQzh6WHBQdEk4cHlMbVB6U0tJRGdyWFRJazI1ZWFFY3RKY3Uz?=
 =?utf-8?B?a0pYbFMvSUY3VVI4TVhGRlIrcU80eGNZeC81Nmp1cC8wMDl0TEEwNjlEcFlo?=
 =?utf-8?B?QzBLOEt5L294TWxlR1owbGhndUZGUjQ0dmxMZmxqa2pIUHlkckFGQjBrdzJU?=
 =?utf-8?B?ZEQ3K05CQytSTndsM3NlZzlpb0ZueHcvT0tRQ1UzRDJDckpsSThRRWhnNXZy?=
 =?utf-8?B?bXVCOWJNVjVUSHMwcUR2Zkl0VXRSYXJXUFZqVzBVYnkvQS9WMUtKcCt3TG0z?=
 =?utf-8?B?SjlNTHZqZGRiNEhzSmlsbzBlMVp0SktYOUY0Q2JxWnRoL2dFY1RLWGJ2Qm5Q?=
 =?utf-8?B?am01eHU0OStSQkErVjRGRGRsSDFoOEkyNGRKRE9QbE5hc1NpVktiTlVBVTlx?=
 =?utf-8?B?TEJtcStZNmw3TEF5UFZ3aENsRk5Xdi9lWUNpTEpYWUQzNDJVU3BJdXBleDlY?=
 =?utf-8?B?MEFWUGoyVXBaU2Q3eDEydFJldFZEL0tvWmZNYUphYTY4aWtqMmVuVWRBNm91?=
 =?utf-8?B?MDVIM2MxRC9yUnVUYS9aYklZRHlTL3c0TWsxbmRzeVlmWDJqUXh3S01Od1dB?=
 =?utf-8?B?VzByVGhEcDFOdGVDUk5Mejh6UVdVZ3dvdkR1dUVuQWFtOU9mcDdZNTlxcWE3?=
 =?utf-8?B?dHhTMkNRY2ZGa0R4aHJHMzJYb3lFT0pTeTZ6dzdGZkl4WDFkL3NPajRtSEJQ?=
 =?utf-8?B?YVUvNWxNaHNWSDNQczdLZEgyZzJranBBekErWGRMNHBDajJ4WHVSa2M3Sjd1?=
 =?utf-8?B?dWh1WjQvRGlPNHpLL0JTUjNlWTFaYTZhTTZ2S3B6UWVMSXBmekdja0lBSmxC?=
 =?utf-8?B?NEJ5NXk1QlVLZFJlWGlPZytCamRsVnFOM1VmMy9DYktsWkJHMFNpL3hBWUFK?=
 =?utf-8?B?RHJhaERjdWdSc3lST2QyTkZBUXM1VjRuSnQyMGJPdk9RY1dpMW5lbWZodzdr?=
 =?utf-8?B?YnlOQzAzR3hWN25QT2FWRHl2M2p3TUN3U3hEU1F6Y0U0a3dtaWNPeThQVWRt?=
 =?utf-8?B?OEtBOXFXcEZDYTI5SkU3Wjl4L2p0YityYUxVaTdRTXU3cDR2Mkg4eUFXWnh4?=
 =?utf-8?B?OHdoNmdxWmZZaFo2MWdET0hsQ1BrRjFMeVBMTzl3SldVbnVlTVJBR1JxS1Nk?=
 =?utf-8?B?cDJhZmhiODhYcSt5YUlTOEQ2RzlqNERCcEJzbTVMeUlsZFRFZG9nL0UrQ1lV?=
 =?utf-8?B?SE1FK3JCK2x3Q0FoY1dFeWRTbE1vVGxrODQyRHdvby9RaWdHVFl2YitkVytL?=
 =?utf-8?Q?wo7omTzOOQ3QwOpzIP4IAfm9h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U85iKVG2ecjTEBW0MlELuLMO867qoFJkMzg1so+WzbvygxKfpeYmgx/Y1PKpqTsu18ge5AZjHThm6mDpmdVHCIoQHJp+R1FDpUln08TpPfDoWhwVdFMk927nx9+8os1B7+KGqtoIFm/QZgy0QSM7XkGqfUwX9BDDXT4KQJtsmLHaheVwhjZB3ST3YA8nXMKMuu15pAzIAeFVwtXILTDupnH+1ltR7tUNnN1lIi28Pjnvvsxv4qirMZ80NgJFfbLwtwBdqTyX0vh3CZWWuPuvPNS/m8dlkT3nNpStbOwuEyU4hnDRh557tGXaHedD3JKpCKN6XJQEgrFBuAWmIReETBXp9iIUpPM32XYANHMORdN4/p8/8azx+pOKVz6LdMgJxlrID6EMVEFldODB1OQbVd0rbRSpDN7TOUa6OK3BE89uZ2drF7ZGFUh6jtiw8e+wpJJjs19Q2/X3E2NxFPc4VAtetKxf/gIoz1mvc5ySM9UKf9iXD0veNaV2cT8RKkj6HQoD8ygB155wipT8ULrwxkXDjY9zvjEkhwxRVcOT552KfvXPGgNtL+pDWW+kMdAjRFmO5KC5b/CbhIMNOiU/MbeJeGXPaz9ZCAAyZ9Af25g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948d54ca-e488-4e17-2f55-08dd08b40fe5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:06:01.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9do4HepcUHgYshsYO9UNPzCgSyOIoVGhPZLdV3HFskA/5mPnBB7ZdxwPCVwr/LimxuA8VfV3QGJXeikVpcOCfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_07,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190118
X-Proofpoint-ORIG-GUID: AidyNE08oVJJUzTBrVmiV9AsI02g8ePI
X-Proofpoint-GUID: AidyNE08oVJJUzTBrVmiV9AsI02g8ePI

On 12/11/2024 09:21, John Garry wrote:
> lim->discard_granularity is always at least SECTOR_SIZE, so drop the
> pointless check for granularity less than SECTOR_SIZE.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Just a reminder in case this can still make v6.13

I wouldn't say that it is a fix.

Thanks,
John

> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 7d6b296997c2..4091794c5a1c 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -457,8 +457,6 @@ static unsigned int queue_limit_discard_alignment(
>   	/* Why are these in bytes, not sectors? */
>   	alignment = lim->discard_alignment >> SECTOR_SHIFT;
>   	granularity = lim->discard_granularity >> SECTOR_SHIFT;
> -	if (!granularity)
> -		return 0;
>   
>   	/* Offset of the partition start in 'granularity' sectors */
>   	offset = sector_div(sector, granularity);

