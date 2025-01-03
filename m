Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A94C62
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893518; cv=fail; b=QS3uNfkHXv9FuhYr0k/3RJUXD0F36pjbA2qq0261PvfRNmRQuK2Vkwc9TFoHvg4ql0rEdY7MA4Ct2CIVb9Xs+xLMeTbyIg8wVG2bkZzV/o/cnH5WcDFg5kM55d0X+9q6IL5puUYef20fY4Zp1g2sWOs7zUXckB/T5taHeq/icjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893518; c=relaxed/simple;
	bh=V8liZC8H8MdkaNHE3Iuo1LXayCcV5gfIq0Qdn5yuSGM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L1Idq5ekHbKe0DoAe+kDEfiZmESyVhcj2d1Xyjx/+J+4X0sZVDb+/FYUAwc65WEj8NsJtZR6BW9KWHONm42NVWXY9rnnjF2lD91+V4DIEQohFyOmiBi1H1amgaM62s99FTtYtjwoAsVRZqLqWme5JrXmIlLiT3Tv+xfE4rNLfyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YgNgVbbL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EuejMKZk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YgNgVbbL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EuejMKZk"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5032NIwC019218;
	Fri, 3 Jan 2025 08:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OmoMwWAUjyHbX3HQTFzjcALADdloHwulHXCNcvLeHfo=; b=
	YgNgVbbL3ZhUgKZDrvMiqBTP6VviY4f0ZU5YnQ1wxmm5FevdLm35OErlY65aeDMw
	3hIG1k/FTOWZqPUqB7Tam06G8faurNNBOH764c6YvKNUZ6QwHNQ7gcExP9ed9vzk
	vMAxn5UxbsOdKrh6IJkZ5uwUmjR8dFdtsA40ElzaILvM/0BcvSWVxluTo2jkQmZs
	kC8Ah7hN9sBYlCUpFEPZhnGtMweo7l/wMX6sOubCjek9f8N7eVfWOH+1llQiFJrX
	fotDCHcIba8LFLpfpbsYfNwo+MSpsWoM+mzHFNez9h66MCeDbdzzXJ49BNu9LwqJ
	p/z9LBOjCh8qOt1zl0TbCg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t978qpp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 08:38:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50386g20027811;
	Fri, 3 Jan 2025 08:38:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43vry2hreq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 08:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixtePiTQbyiUU7qKT/rWM+VBvoxEIfDZ/vohNfxdrw6gA/iubuyCpmxTqUv84gGNHt1VK4RqN7zshjZgdf02+GgzkoVTDGY0GpqTg0P3TariKvkk7d2NBpSO5Xboub/J3v6fjYKPVpPqOn+Mf6W0C399gjxw0MrOzahpUxc24VXbq+B+lEAF9ereaqXZ61hLP7b/0ypFkXZBMrF85Wzejg5m25GknGjn2Fo1xT1zSfk/Jn63CSY+N0xPJjvGUJamhzb/rGLnb2rWngd0Ac63/GS/LAKZ1Vbs+N1igTEMMlIVfcuasLsDl4oPLIevyYZQ9HUX4DE6GJeJ9zmB361Lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmoMwWAUjyHbX3HQTFzjcALADdloHwulHXCNcvLeHfo=;
 b=KOxA+RxDxPszyjmInQah6LyL9EtfoEqt+AEo+Pcot5CZEl/kWX4UzjGGLWboVFWH2evt5Km1bfquRs2gfG8IZO2qeVWf/YVOK0JKfUcTcUwQI4WFpPTdHQ97HXJFYyjQ/Vwx4ZRjXboRUc1MiDl2+zCxkbsQfNaX/zi/xRIpmNbpWBNespYrDvAfRvMz7/ODJjAbOFGb1VNALkEnw1MWOg8Tt+NgFl7U4fQMM5D4XhVfNyGPslnZrDLThQHYieVXkxANOE6HoC05dmmNNyAoXY3o77Gg5eEWJyQb6QVRZMGQjUIabVEVs7EKFm7B7brhZpH/gyBZ9p6vhFV0A3Hi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmoMwWAUjyHbX3HQTFzjcALADdloHwulHXCNcvLeHfo=;
 b=EuejMKZkiwcbPSgq3nTIy5jlUQvZNYIli4KCI01uiTsV3iKlDVBc2u9RC6U6WCahGp2IvHdCAC81R1PB+7MzbNIuAZ80EqH55urU+9xWImspt+9EX/df7lMGxL6WvGYLrf4nJzcLZu+xj0IoNwJZweLquELnvGQJSEUk7GoIgsA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW6PR10MB7552.namprd10.prod.outlook.com (2603:10b6:303:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 08:38:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 08:38:13 +0000
Message-ID: <cd96ea21-056f-44fd-a4b1-ade01182a8f6@oracle.com>
Date: Fri, 3 Jan 2025 08:38:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Use enum for blk-mq tagset flags
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20250102144426.24241-1-john.g.garry@oracle.com>
 <20250103064427.GA27984@lst.de>
 <f3852e75-dff7-4cc9-b64c-01ebf1020808@oracle.com>
 <20250103082723.GA30419@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250103082723.GA30419@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW6PR10MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: c236cb25-d8cf-47cd-9044-08dd2bd1f604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akJmelh1UlV6ZGorek1tSUxGU2UxbWE2Slp6SUJIU1ZUYStXdFNQWEx1ckx0?=
 =?utf-8?B?Yy9zUmY2bmQ0Zkp1YWhGTnZGd0pIL3pCOWZxRWd4S0pkQjBNQlg5K1k0MzNv?=
 =?utf-8?B?d29pTU1RWmt2clp5M0w1Q3IzTjErWkM3WDV4cVcvck03WnAzNnhkZlp2cGtO?=
 =?utf-8?B?QUx6a0lnTis5RGlSaUc5ek9XbWNmTVc5Qk55TitBdm1qaHZDZmlQVDdON21u?=
 =?utf-8?B?RStSdzB3YSswNnd1SFFzcjFIckhhd29LT0Y4cHhLSnpsemt1U2FIcmw3ZTA4?=
 =?utf-8?B?SUZ3MWQwOTVqZHBDWnBHU0FTR1lrbGMvaVd5NVZXV2tPL3ZvZnpJL3FpMy9Z?=
 =?utf-8?B?eGN2dG1TcHZnWDdHeW1zR0dZTlIvUEtYVWN1ZjZKK1RpeC9tYWozZTJ0YnNL?=
 =?utf-8?B?OXQ5T05zTjY3Tkttb3U1TjlTb1JOZHZVbWJabWlIR1NSR0FhVFJIOTkxWElV?=
 =?utf-8?B?T0xURkVPSzhNcDhkbTVoUmFvd3ZHaHdwcHJrZDY2SllkMWFJMTRENkRBNTJR?=
 =?utf-8?B?a3B6RzBHV3BzQUF6N1JjL1RjQkIvd2h5dnlZdHhFMjRlTWN5TTc1bmpDdXdF?=
 =?utf-8?B?aUJEWFdCOXN2aWlNL1M2d1VpUXh6WHErcnpZbGdNeTAvdXJRT0JLa2ZRZS9S?=
 =?utf-8?B?cWMxWHZtU0ZxcUlaeGptWXl2Mm9wVXZOeE5ld0RKcnJSY3VuKzZwU0lRN3hR?=
 =?utf-8?B?SmllYVd0YWUzdWtPamNJOTNZaGIzcjYvSjJDVUNIZ1FRdVlWa0FSc1FTTFRN?=
 =?utf-8?B?NmZuVS81QmdWd3FoY2tZOUpnWnVMZjNZZkpUSmxFejQ3aXJZM2xtUzA2VEdB?=
 =?utf-8?B?WnVFZUlpMkhGSUpIQzhMaGdlZ2VaMHZZT3lCaGlhbEJ3ZlNhb1hKN3o3QnNV?=
 =?utf-8?B?angrQnY3MnQ0QURoYWs1Z0liN1hNN2RmZjRLRkFuQ1doRFRlTlhkNFNrMURH?=
 =?utf-8?B?Ti8rbTBMSDBkM21wV1l3eWRxUldHaWY3ZWN1Z1l0QWNvbjI0Nkhoejg5WUNS?=
 =?utf-8?B?LytHOVJwTk1XSyt5SmJveUpqdjNVVi91T2cyWDRWTnF0alpUaWdSdU9CZG9M?=
 =?utf-8?B?dE9mVjNxaExyUFJrb1lVeFBzbWFWcmtITUtNVTl4NDJvTXZJZjBBWFdra2ZQ?=
 =?utf-8?B?RU5WTFdKbGlYeVoxMDZnQUxQbmx3QWRjeE1ZdzBBV05MZWRvUFZOdE9ybDRD?=
 =?utf-8?B?Q0I0L0x4WFo0M2w5OWRWdjJXT1lEY2tXL3Q3UEUxMytpaWN0OERpTWdpamoz?=
 =?utf-8?B?Nm5WSElmYUp0WHFRdFVxVFBLU1R4SU0zZnNZVjI4SURta29uaWxhZnVud3F0?=
 =?utf-8?B?eGJmdk5BbWNjSUNMemFkS2tHa0QzaTdTdFM4UmlkdytrNU9lckpVL3kvZGtQ?=
 =?utf-8?B?RjQxKzArVW5oUmRkR2QwKytiWFd6SDlYSkhtQXJJdzVnN2xZUE5rd2VXdmhw?=
 =?utf-8?B?bk5vdlNpK2wydDlTZ3gxb2taQUg2dW9OeVFmV21Xb01FREp2U1EzSlhlNUdQ?=
 =?utf-8?B?cHFHREFmN2tnaXNPRzFlM0dmS3E2Q05wM2ZuWWh5Tld1bUF3ZkJxTjVLNzcz?=
 =?utf-8?B?TkFRMDNUTCsvc2lQN1dYOFlaODhxSzd3TlYxNmxuMTBPS0Ivam9wM1RMeGlO?=
 =?utf-8?B?UWdLYWFpNUtBVDU2a2lOdVpQUTRUZThEbHZwcHpNVHVvYWZEdTFWd2o3VlFG?=
 =?utf-8?B?SGMxOXIrVWRPRDZhNGZtOU0xQmFPYzZuZkpVdGthYUliYmRVSGhMejdIYTVG?=
 =?utf-8?B?MHNtVEtZUGx2ZXIrckJOL2FhSUEzdG5XZ2hYenpvdWFldGYrRzgvVmlrMUNk?=
 =?utf-8?B?WS9pbXoxaS85WEJ6QnlmZVdMazllM3RpcFdkNE1rQnlyZ01hY2dFQnNKYXRR?=
 =?utf-8?Q?qQFTx7s2cXsXo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjVNU1lpMFZTNnZZdnZIYzIrUVZOcDRYU2d3ODg5TXlLUDJMelN5Z3RRc2t5?=
 =?utf-8?B?RzB0RWlQV1p2VmF3K0hoZERuNm9Bbmt6MXdBOXhPWDBpTGRHM25BVGdIZkxM?=
 =?utf-8?B?UDlQdFoyTnVuRHM1b3lsaFFQaU8rbEhEWlAzVi9MK051NHlrNlVQMnJFd2h4?=
 =?utf-8?B?YXRoSVZ4V25RN2E0aW94b1E5UXZGcHR5bHV3cjhxSDVEbktWZXlHKzBsM3c3?=
 =?utf-8?B?WkNwanBZTjdWRHRjaDk2VWlOSlp4NGxQcFhzbjhEczQ3OUJRMkRyc0NkK3FP?=
 =?utf-8?B?U1RUMWRJRGszN1h1UWlYR3YxeWVLZVBsN0srakNzcTdDeGM1d1p5TUw4MHYr?=
 =?utf-8?B?SjRjTEE3UU8zdE13cmtPU1NKZXR4YTNRUmQwVFMvRlNLUGZXaXpvZ0lLSS91?=
 =?utf-8?B?eHRDbGdXYjhJbEpjL3E3QTNIUWxtSU8ra3VWYmdLZDZtUU9vUVU5cHFGTXp3?=
 =?utf-8?B?ODl1NFQ2N1hhRE1mWW9JNXJyRFRZNFpPZkxxRDliakQ4Z0ozeTNHbGJjQm9p?=
 =?utf-8?B?bkRVcnl1S1lNWVBWNWxKMm42REtKQkwrbXBUL2VlbjUyT2xtL2tGWnBsa2Vi?=
 =?utf-8?B?eFNhb3hEUm5iU2lueU9veUR2WCtuM1labEltRTFZWGkzK3A0Z3RPMTR1SG1R?=
 =?utf-8?B?RmVjbTk0dWdpWDNDVnFYc3ZTWlBDVGl2RFZhMUhqS1NmYVloZTkzVXNaTzVt?=
 =?utf-8?B?MURtdDNlbUJGaHVha283cjNQdnl1bXhyK2dvNWdHNnpFS3FvU2FmWUxGNFRH?=
 =?utf-8?B?VW9hYjNjSkZyODBwWjlhRFo4Z0xmNWxZcWg4VmZmczlHa216eFZuTlhOeEk1?=
 =?utf-8?B?ZUVFVzhEeFpKZzhLY3ExYjhIZTQvbEpjV2VTNEEwSmducGo0SUFiWlUyM0VD?=
 =?utf-8?B?Y3A2OHFUa1FaVE94ZWpNL21zQWlmWVR0VzZhenBudDB2dXhCTkhJRVE4TUJI?=
 =?utf-8?B?Y2RYQ3ZwY0VqNDJYbDVVRVB5S0lyeDFKOVh2UmdMRkx3YlpWTWVWc09ia1RR?=
 =?utf-8?B?NXVsK3dpcTFQVVdBRkxIaXJVUGU3RTgxaVBFM3BlTVhFSzVPdHczWnZqUGFq?=
 =?utf-8?B?M1gvemVaaGpPOHF3aTRMaVVTS0dwdzM0ZkUvUUlZS2t1ZGxnaTl6OVRIaTZM?=
 =?utf-8?B?WHVWZWYxWFh2Y09lZWkzRnRIdzBZUzJnUG9rVlVOci9DNGNKYlYzeWJXSWFi?=
 =?utf-8?B?clZOaVlwR0k1bjlCNkY1WjQxL0FEeGQvVERrZ29yOHpYZVhIN2ZDS3pDSWU0?=
 =?utf-8?B?WEdKZEkxWmozQS9hakFDYjd6Tis3aW0vWHBWMDdxY3RIMjFIMnRGSmVGekJG?=
 =?utf-8?B?clllN1J2NlVVdVZ3UUZUeEk4S0p3amRhL2xlTlJVTW9nNE5oblI3YlRvVWZx?=
 =?utf-8?B?UHJ4RHZPM2hWaWpjNUJCM3lpcTVxRXM1bUtoMytKZnk0OWhaYjNZODd5NmVm?=
 =?utf-8?B?S1ZJa2RzLzBrRWhjamNPRWhGc09MN3piOFZqdEVGazRRdXoxNWpLM0dSVHA0?=
 =?utf-8?B?MTgwdjIvTkNGL0JzRTQ5UzZQdDA0OC9oeTFFSGI4VHgwdmFIR0RDNnVlZkp6?=
 =?utf-8?B?TnBTSHFGN3NYdlJZZnVTa2JiVUhGUzJLU2F1YTJ0eDNpOVZETy9CK0JSQmkw?=
 =?utf-8?B?dXNHQ1p2eGFFOXBiSkM3S0FFQkxZNDFLb1FiaTRpTTNIdmNEYUI3dmRNM2tY?=
 =?utf-8?B?dnBqaUpUa0VwU05GYXBTL3ZiZUdKYXNmckxTeitucHFoR2MxZjhLN215MVJL?=
 =?utf-8?B?QXFhTW1VaGE4aHhkUWFvZGFoTHRBWnBtQlA0bDBKQmlPend5TzdvSVU5OTBD?=
 =?utf-8?B?Q3V4UUxwUkpPWWs3eHc0L1k4dC9GdE9FRjhRalRVbWV5YzZReitTeTFPUlpr?=
 =?utf-8?B?Y2thRURyRENiYzA3Y3B6OElnK2dVOGJSMEtmNWhQOWlkallPZWExM0NyYjF2?=
 =?utf-8?B?SE0wUEZ2Vk5nTEttZS9zckhhZ3pvY2k4eFZyaWo1OHMzdmhRb29razlrQlNl?=
 =?utf-8?B?M0k5VmNUb3J5YXhTK1NLdUlZUFNjSnJOVmRQOHhjWUFMTmk1TDc3MldtZHVa?=
 =?utf-8?B?R21FTGlJdkIwcEM1T2ZWMU5oSWQ1akM2NXVTcHFUblZScUtHUGc4djJydU9E?=
 =?utf-8?B?UTZVbElTcy9UQXh5bXN3WlhvUlpDRzJiS3puRmxIOXpPc1ZLREh0ajQ5NHJj?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U6YYXeM/CI6qs1mJHVbKL+fS9tkQSbHDRku/89NM4Bqm9so61mUENyXKstb+0RkrfB04hfv5Bd716b0mlOTrbBe/tvTIACrZn2oOIw8CYfydXPmaxvnp6rP7bXxMlj2MdEaKs9+hsN1IpOSU02EC+XE0Ou+jHz8GtO1Omak8jTbqQfSoJ8R8IcgfYEMvOfhuwD7z2irofxI6orrJEEuY8L6m36oE4WLEjsRqQlZDujf0711NTQioCNMRMqee/BE3wSazAosWRyNgeR6myp4Kv067pn5DSYLy/W8xv1yQ7mlJoNXpTIrsdu2albLzCXNBTfrWdGezhU8eI7EfLFMAiY2SxOQ1191EkQkcIhe6yr2IOJlPK9UsfA+/eqvDKUTTCKCshqEgsm8KASyuFFCne3T0gO9hIT8cTfJxcUUyQcvsOPXcEScqqSRVUw5KLcg1KsyLLlg8EM+IRbjEN18hBWbIocN5BG/AKmhXQ7Oa7ybK0RbCgXUBC4vRCl+HjTDh0EP4xbBDfQNJed+6uw3BgLNHHWZi1UbS1L6pBDpIFpNMuks9ZKir9uFuRxH/e4kWwi6hhFhJgoOj6udjIm1+2skb3dNNqh191+VWsttZO+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c236cb25-d8cf-47cd-9044-08dd2bd1f604
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:38:13.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2E6NDGrLYQo5XW1PXdI6WBITPaRK/1lEgt+k0Mcqqn8BP4cFN4aXl6HGv6xLN20LkOZRSeLaYinCojtfRORRTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=686 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030075
X-Proofpoint-ORIG-GUID: zVHvNf3kMBH8DlD4lokKu7KhXfLPjfKA
X-Proofpoint-GUID: zVHvNf3kMBH8DlD4lokKu7KhXfLPjfKA

On 03/01/2025 08:27, Christoph Hellwig wrote:
> On Fri, Jan 03, 2025 at 08:23:02AM +0000, John Garry wrote:
>> - better to not have unused gaps
> Who cares?

it's not that important, as long as it the flags are properly ordered 
and it's obvious where the gaps are

 > >> - catch missing blk-mq debugfs array names
>> 	- this has been a problem in the past
> Again who really cares?

People who use blk-mq debugfs

And maybe the maintainer when we have the tedious routine of a new flag 
being added but the debugfs entry being missed and then the follow on 
patch (to add the entry).

> 
>> Cons:
>> - boilerplate

Anyway, I feel too strongly about all of this.


