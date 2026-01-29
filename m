Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A537C0F7
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687566; cv=fail; b=Idw+rea9Uq1lajeu38ttoysbgL2lshRFG3DK4LO4XsaEBxEkRRpUuG+8fQ1h3zqwlNz9k17t3Trl0y7bq3iUQ1MGe+EAzwPe2zlLFYoaqf7PejLk9z3d9UD3MX8u2sht54aCZH7ZnkXgGkg1K4pPSVxW6kXa4ZplH8WG8SXOOmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687566; c=relaxed/simple;
	bh=D3W4CrZBiSuqWcSTMi9WijJMJixpYxXqiKxHaN/dEwg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YPHNOEOMgarNPEISimA/51kIk+FLyRafE3jToGWSFQT0r9At+0UvN1oflaTfGKUEEq9nvRDOaGBt6h4PauFu7Edb+WtdQqm/iTVXrAlrN/g6qlStrBPySCjnFHz0SIv8QT1/kAcLFRQdtPTnBPhC8Z7JnMPliuAK5HZ9D/68cYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=phccYb9t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UEUsNtoS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="phccYb9t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UEUsNtoS"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T6p3Ua1231016;
	Thu, 29 Jan 2026 11:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AFGO2TORq8Fyuh2QHucXOngQXhmeSpgfKB7ySR+YDnY=; b=
	phccYb9tpJvhTi+jY+89gKag+Xs6jhu7FXPCxnZcGDC+jgbzCHa2jFb+XYe+1PhK
	J5donosUDy3iYNVuf5zv402bBKG5KhmZ9DhV/r8QPq5ebKAGSevXvdleN8r0qiN9
	4RfItz6Fyaku8H8haLL/wOa1yjsVT6P5XIb++YNfh5kL48L+A6vO9cuqLSYg2UgJ
	SZOjw9Vvimgba7ikQo5nzfZskDQoyOeEJ1VHGLZT6y3rgh7yfOlnz6/MZuv3+gIN
	Ek06mFB4OsaaG61kMbQzIn7KubTxC0gG024FTqyzUhjTTXRGzVrjS6/2S5zqe8gN
	L4Gq4uJi05A+GNOB4ThXVA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5t6arub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 11:52:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60TA14Bh012730;
	Thu, 29 Jan 2026 11:52:40 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhc8jy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 11:52:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFl0vnbbx0RtKTyZ/mf2R0sKVlWGqU0ayU/kraVN9MZhK7AfveETvj6qMAdKSrldOPv45x6OpBxohlW8r8VPpr8vXzO6kRsoBo8pQ0TGoRdG0bsxEAWABlykWwpEkmCfWOjmplmUpITFpZ6BfXSl1wYTAKH6FUtOaxP8+2HCSls070EMDvZLSnfH1ZtlyzEJm6J7QOzKPDPYwbxnD5j+HdYF9pEgXrKH+B5AgXtBkxND8CPOdDXvczaMcqKTMm3vCrXyZa3SYwIBTpF9SyC2DNjKsVNnh5+dChIe6qFq3sptrakJthGDj/Iwn2+eDKseW0FGzWTYYHs7iljhr4y8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFGO2TORq8Fyuh2QHucXOngQXhmeSpgfKB7ySR+YDnY=;
 b=Rl2UKi4WFPGEedEycZYrvxMQQuNlMGaTJyhtDhxEpuAj1RfkEH8Nl1eSaIbFC3diG7w4aQ9S/QtaBq4EutBxU2+2A3sCrsz2bALFb9xrNlaVTE2po0T05CtecX2p5tSR8zXIG5PEU8cF9c9KiU7c44urAISNtJ3bIVD3p+yZaDMq7UVfIGz6j4BO3oaGaB0nyrtBocoE8o9mgUtCQr0G9V9OOwEFfafYSt65P7Gnw02Nk6nj1ATu+XeqYY4vWS49lMheye31Gh1iz+kLCzFN/Xz57O4s04ce9gk2ZjWozLJplesLopqxFCzCRx1JLrt3HZXwoB//xef7Td5WOaoAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFGO2TORq8Fyuh2QHucXOngQXhmeSpgfKB7ySR+YDnY=;
 b=UEUsNtoSsB0DHfAXXlpuc6j65+oELWQOWh4hJNPdaUokr+ozJEgnkSpdTqoMJi1Y/EA0zJUj4nF6bew1roUWYhD2MdTbmgLEQhXhvcjEFJCEjrhYwuew8i8eMp1V5rfyDd7bHNo/m1k96utx2JJVw/msDWcc56X9iWq8L60g6EU=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BLAPR10MB5060.namprd10.prod.outlook.com
 (2603:10b6:208:333::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 11:52:37 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 11:52:37 +0000
Message-ID: <85c9a0c2-a181-4e07-aee5-bd966967c451@oracle.com>
Date: Thu, 29 Jan 2026 11:52:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: cleanup queue limit features definition
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20260129072715.1107336-1-dlemoal@kernel.org>
 <20260129072715.1107336-2-dlemoal@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260129072715.1107336-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::11) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BLAPR10MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 5516b6d7-d08a-469f-2ef6-08de5f2ce610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlBWOElkSVMxS1dQN3dyM2pNVEZmcWt2RHMza0IxZllta3ZXSHBDVHVKMmw0?=
 =?utf-8?B?M1VKbmtHUzVRVXJJTnVZazdtWjRIeWFURGo3STNWZEF2LzVLd0hVUDdQL2or?=
 =?utf-8?B?YThKbWxaN0ZOT2FTR1pnTlF3azdhaG9DTEcwV3hYSHpSUkVORHBsNW5veVlx?=
 =?utf-8?B?TkM3SjNmSTNrSm5ERXYzMFFiYndyN1pwRVJXRHRxSFdQcktQN2kvSURvMkV6?=
 =?utf-8?B?SVpUZmhUTVUxZndxcFdkQnJJKzI1R2pqQm02Unl4aWEzeGNyM3dvRGpRS1Ju?=
 =?utf-8?B?MGI1dW1jM1pMc3AvN042UXFqQk1TSzVDUU9OTnczRW4zdXN6dHhnS2ZJbHpO?=
 =?utf-8?B?MFpYMWgweERjeFFrMmt0NXpjRkhvM2ViU1FGSjlGM1d3d2twUWo0NnlhZk5k?=
 =?utf-8?B?eSsxM0pFazBJeHgyS21RZm9yMFNqTTdoQndaUUhnYXVyazdrbFl0bHg3dmVx?=
 =?utf-8?B?T1o3b0dCem0zRU0yYmx1Tmxjd0dVZnZzV0dseVNkMGpIRWFSUGhyMjRSc2gv?=
 =?utf-8?B?eHNmVk9mbjYwWW5Xa1dqaVdnYlIwa1N4OUpyUXI3emxCVnByYjN6eTR1VHRt?=
 =?utf-8?B?VTFZWGVnOXdFZEFEWmdwd3NwTTVtL24vdzU1MlJ3WEdsRWl4R3ZCaXltOENo?=
 =?utf-8?B?ODliNjZPM3hCR0ZWQmFmMjhKR1ZKV3hGVVZpQTFralFmcE9QWk85V2ErZXFl?=
 =?utf-8?B?Ujc4aXJuNlVrcGdsMitDeUcwSDJBekxoa3hkaFdvVUFKYW1FN0VCNFZhNWNi?=
 =?utf-8?B?WC9aYXQ0TndNMVQ2QlBqV0pmS2w0QlNRenBIVm5VQWw0VytBMnUxUCtXbkR5?=
 =?utf-8?B?YW9XS2p5eVdZUzE2Zlo3LzBnYyszZ3dwM0lTOG93cjJOeTl0dG5qbU5IcENl?=
 =?utf-8?B?M3cxR0d3M2xEUHozdHNYejlqNnExaHlubTZDdnpUNnBNSlpvdXZrd0JOaGJC?=
 =?utf-8?B?Zm5KSDJNN2JuVjhlM1JoUTlJUnkwYnBpd3hoSmdUYlpuVUUwcCtUdWJ6alU4?=
 =?utf-8?B?blFzNGl0Q2U4SXByWVVnUHNPUEZnMlh0U2F2aWpwczV6L0lZNXJSd0c5RkJH?=
 =?utf-8?B?YUtoamFjS0d6K3lyUVZOT0tHeGIyVEdGMW52eFUvQ3RkOCtYOFpQTHVBelEz?=
 =?utf-8?B?UCthLzRtUlhWNDlsMjdla2lIU0Q3QWh0VCtUeGhIeGMxYWJkdHJuN0xPRDds?=
 =?utf-8?B?V2p4OCtMR1JtQWI5djhzb3pPZTVyNFJ3bURacytlSWtXT2VxNlFxazNaOHJM?=
 =?utf-8?B?UVhJOTdiRmpaaW5JWWhrM2o4cTZoT2pHVTAyKzFBZ0VRSnptaUU5QXBxZHVa?=
 =?utf-8?B?ZDNtcjdSOGxyZnFUQUJpNlM4YlhPcnNXYXNNRlR1dzYvUmZocWxEYSszbUV1?=
 =?utf-8?B?dzVsa3laZWtXWlJ6M29XanBLT2RZVUg1Z2Fjd3pvRTFpdjVXWWkyK1ViOWlp?=
 =?utf-8?B?U2kxNlUrZ0gvVFZQL2RZWHhIdVJLckJXZE8reEFYNCtPTTVOTisrSnRPbFd1?=
 =?utf-8?B?VXBFUnBWanBjNmhaSnMvMnptZ2dteHJhM0t4MkJGeVFKQzdpTjUzYk5yd1Js?=
 =?utf-8?B?VDBSSk9mVjhGVE9OZUpUWDkyQ3RVMi9GRWl5VUlHSlZwUkdwR3hFL20yRGVj?=
 =?utf-8?B?UHZKTE5IdVFkL1BkY2hPOFB3TWpaTkEzQkRlZ0lUaWtxY09vQndORXluQ28y?=
 =?utf-8?B?QzB2Q3JIK05uV3BhUHFYVWFZQUY5blZoRnB0dkVzS29ES0JJZ1I5Y1Y1OWN5?=
 =?utf-8?B?MDlRVHBERnRRYWcvc1p1VVRWQnduakM5Z05JUFpScDUzcFNGenowN250WXBN?=
 =?utf-8?B?MlppcktWM1VOa0FRenZxazRUOWhCVE11Z3Y4eVRzMkpaWGUwRmF5cGRGUG9F?=
 =?utf-8?B?TEdGQnMyNGdRb1lJZ1dvcFByTmRiU0Vhd2tZa0xOL0VmM1hBRDdES1FJOEdn?=
 =?utf-8?B?QnNMQUQ5djVJUHFCQUdYRGwyVkcvUlQ2Rmlma1REV01td1J1bERvZStFbXpJ?=
 =?utf-8?B?SEQvcUxqeWRvSktGWXRPZzNuc0pRNUE3dE5Vc1MzT3dQRkQxS3dQMkh2VkJK?=
 =?utf-8?B?U3A4dlUvMGxGM1BscVUvbEF4ZVdSRC92ZnZVVG5PeGpOQ2EwQ1Y0WTg4MURE?=
 =?utf-8?Q?+72c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3lsckZvNzdoQk55bHJNbVBaZ2s0cGNtUlNoUy9yTFBzR0V6STJUTUNVVWpV?=
 =?utf-8?B?SmhaaGlXMElQdTFSOFcwbEVVM3YxdG1jVHk2bmp0TnpBcHBXOU1XNVlhZ050?=
 =?utf-8?B?R2V2QlRsckNxNXhlaXg4bG1JZHArSVVFOGVYNzkxcFd2NkVHQkwzN2N6OEhp?=
 =?utf-8?B?bGg5QSs1TlJYUUFiNTZGWUpkQ3NUdXlQSU52OW5VUEpaeGJUT3I1VVZzVm1l?=
 =?utf-8?B?cURQbFdQdzc3MTRnbDdSTnFtL1NWMEt4SGM1R1lNZVF5SmU4bDhHRlNvUm5E?=
 =?utf-8?B?bGVzbU9HNkw3RWdnQng1M3hHZDhSTk1ocGJsQ1JFMCtCUlJ0eVk1dVNWdGNQ?=
 =?utf-8?B?eDAvb2JMbTFRdVNYMlIyK0wzSkdjRGlzMXorRC9PUGRnRkl1dEFGbEhPNnhI?=
 =?utf-8?B?KzR1eDhuOVo4dHhSWm81WHpwL3FodkwxRkgvWmZmR25pdm5tVlhZUkxzSU8w?=
 =?utf-8?B?bDh0Zk8zbXJsVHhXbFhaK3VpMFRpeEJraVdHd080TzNwUXZxNTRLbDhKM0pm?=
 =?utf-8?B?MWdrWWZCYnFTVzk4VFpPV21vdGRHL1Y0MTREUk84eW5EZmpMcTN4cUNiVm1u?=
 =?utf-8?B?OUJIVVNxKzZsNUkvanVibmF6cFI4WHZGOURxWTJ2N0RwWW8wSUcwaGhwQzZZ?=
 =?utf-8?B?VDZrd2RqdnplTEZ5b21SeVNpZmI3SGM0MlpLM0xlU2QzdkdGVUd5L1RGVkJK?=
 =?utf-8?B?RW9SYVVUdmFEbmhVN3FNcWlBT0Y2OHg1OEQ2RzEzOWlhQ3VkZDhobnpTcVNC?=
 =?utf-8?B?eUN2ZHg5bE9BaEhBYWI4amV5cUY1QWxTdm5QYUVDU0JuL3haSk5HbTcrdGE2?=
 =?utf-8?B?U215V0I1Vy9JQzh4eXNjTi81dmZnbnZXcU05eXlBYTFZQXp5aFBXaVFEeXYy?=
 =?utf-8?B?NTA1Z2k1Yi9sSXNacGtzV05QTWc4czBTTEhvWU50S2JmRDZsS2w3YXRwNEZF?=
 =?utf-8?B?d2VVK1RkbkVaRUc1TFJaTkx6OW82Q2syMFBmMWNrK2UyNDZHbmk2OU02dTJF?=
 =?utf-8?B?UUZSVHVnTFdzTmZhZnNhd1kwT2R0RjVIZFltOXl0UENaUGhEZ25NREgxand0?=
 =?utf-8?B?Zjc0NDBibnducFlYNm5IbVcyRGNjTFhDMXJ2aWUvYStiRVN1Z1RtcGVKSEZD?=
 =?utf-8?B?UW5iZnY2SlBnM3dxZm5yZ25iOGw0Y3Yvc2w1azZjelI4Vk1zdVZCUkV4K3Fr?=
 =?utf-8?B?V1BNS1B6TVZjcEJJTUUrKzNQTnQ5Rzg0b0xPYWhZOWQzL29PNCtvd2hPMnFO?=
 =?utf-8?B?cDBPVUpRbHVWWElZd1FGcHMxd1dCLzFCTlV4c2RwdFJwRXhtMCtSVjJvMnFW?=
 =?utf-8?B?cnBkUCtPalBpRUJmSnhvS2pBYmsvZWxFaFl1TWQ1ZTdTaGtManZRTkRCUzBa?=
 =?utf-8?B?bDhQVDYwZDhYWXA0eEFYejFEUTYxU1A5TjNjZnErclRnMmpmbi82YnlSb2Ru?=
 =?utf-8?B?T0dCN1RiQnYvLzFtbnRmWVJuNVFTeER0bzhpUklIWmdlZkdpa1B0N0dOQTc3?=
 =?utf-8?B?enJBbEZtRGo0WHlJNmtzRk1BbGkvT0lDQ2cvdHdWaGUwbzV1dHNFbXY5dUY4?=
 =?utf-8?B?djdaQ3I1bzBYdXJpQ2pHNzA0RnFzOTBrRVljbXFEeFk1b0w2OGxLV2I1Umsw?=
 =?utf-8?B?MWV2WVQxY2hHWXV2TFEycHpHSTRoaGx1Ky9OR0NGalBZUjRNcVVoNVFEU25V?=
 =?utf-8?B?eXdmTjZGSENMcENsZDRHNVJZellMZ2VIaUJOaVdCYXUvSDYyMlZiV0lRSk5h?=
 =?utf-8?B?Z0xaN1k1UHVxLzJucTZyT0dkT2NIWHd5OVh5OHBtSFJ4aXllN1VHRUJQMnVP?=
 =?utf-8?B?TE9ncEJVSGhFZWJON3YvZ0lVbk9ieFN6em8xdXo1Y2s0aFRIOUtuemU0SFNu?=
 =?utf-8?B?aEFQaUtsYTNTU2ZIUjVkWm1EUGZveVBtVjJ1cmhWcHcvamNwVkt0cDIzbWcx?=
 =?utf-8?B?bDVqMGNFNDE3UGw1UGJ2NmdHOWE0ak45a0pPdll1U0U0c3NxMWFjNXpSdlJU?=
 =?utf-8?B?OUxucU5ZNE9QV1N1VTRza04xZGpWUE1iUUcyS2I2dW5ESVpqaGFHWnUzdkN6?=
 =?utf-8?B?MXYwUUI0ZmpLYk90OHZzcmJ3WEZpM2dMYXQ1NzNMRjFKdlpNZm5LN0Z2bFhk?=
 =?utf-8?B?ZmZNN3JXNWhXbERUbHJwTlYwRFZRUUpsdHNyMjJlR2IwWVFuamVUWSs4OStR?=
 =?utf-8?B?ajhzSkJjQjhWOGtBZGg1TDhLOWVzYldrVGRrK2RZbTRyanJxMDZ4MzkreTNv?=
 =?utf-8?B?MnhiRmVhcURiKzRnQnlBR0s5V0VicWRTajViRmhZM1dOUkk5bjRnMTQvYlNn?=
 =?utf-8?B?ZkhUM1dCMlNjWXhKNFd0NmV4N0tYTWdndnhsSTQweGwvK0NmREJKdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+HYSABKBAuUlKmmeJQInBNZndeZOc1cvfpIAzs6yiJgsj/DYQIO7NrIlqtY1EWLJvrLYIxBVV1Ip+Lb6qJDTwrMecgwCG2nDHB43iUIBaRlX8jLTxgpwDx3YUe6U7z2mxyTdkYLjRXUVnIuPtn+6V0MnodqvsRPYp/bBQ3+S02Yth3ulOyyBIq8BAd1UZ98N8XIKzf1yP8BstieCV7/Bpsw5Wk7Fjqt0tRfesKsRdoM9LsK0fDzspaL5PuzcefYGosq/MnjO+yoAc3ARp2nLIBjKb6KQs4Mpq1mCDWz/avN1TQr01JKCpjSi3tBujYgK8X9nRApp4Yvtaten+9FvuamajkFr+YKHiibXZ3Brbp6JAaz6bHKwnlm8lyUlDRxi9Gtc1hDrDo2kNSkA+/DcRpPpflzlU0qbsBbnk4rdYK8QkK2yh54DSY5k063h++9c3Sdwr/+5ZyJNW8Ax+Q3iVVg1lLi/hmN27gbjx3JIUgnSzMBOclSpBc4UISsLA2NfefZ7RStCq52EGfSK2TbNmB0gfxi0jwqIGzx0jw3UiYRyK3hk2AVNtw0+KUaKMzgye0PUfqU5TIOXwA35AjTjd6XRahiTgWtEPfN9IAQH9VQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5516b6d7-d08a-469f-2ef6-08de5f2ce610
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 11:52:37.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3hD8AdZ0gdQ9S/qZFgfM2NbClnygWWx141UcWLCARwfo/y6XFQ0YpyAhJFodjih28wSqse6eKu5Pxyc7MKO5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601290079
X-Proofpoint-ORIG-GUID: TL5ydm7Xux8Id2v2FtPqtHJUR7WljLAZ
X-Proofpoint-GUID: TL5ydm7Xux8Id2v2FtPqtHJUR7WljLAZ
X-Authority-Analysis: v=2.4 cv=IIcPywvG c=1 sm=1 tr=0 ts=697b4a09 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=rIoYZ3ZZhQFFdYzTJwcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA3OSBTYWx0ZWRfX/0fFGSCek+hS
 21GUAGwj8H/N9DDycuzPLauWqP6PF36smh3ovz+pwdu6rmz+Lkfv/rjtMfwloBMKOrk2OHlgV6X
 9MffJQkLk9nM4QeSFchh/A0jKSflMepzkqFTjA+E10nq5mBmyRkqw+INsPOkWHiCtVb0vzmfDKe
 eGdMWsRjOzxZBwBpv45njOLqSJAkqcjn1H4xmPRtpnjQQxAWJKPSAef5dvGfIevFshyZIj6yBIx
 j29X9I4YF50SdImvLBYf/ODPCtoD6UHf/WVug3QwphwIcZW3GCDUE3Du/7UXPFoGl0vRIhxcnbb
 P0nroD0tTPLw1NnKANLEES6AOmWEFBvtlEgp3VGlFuYaLIgP+OBSti7yXCCD6D4iaEUk8Yjed5U
 5kknsqB4aoaQGnwDDNkCRIxfeyEpnni9LlA3Ll1fiIyj5xGd87lt6cauDb/auqYdDo9EE346AYT
 kRRVXhkXikzEUtZPjUw==

On 29/01/2026 07:27, Damien Le Moal wrote:
> Unwrap the definition of BLK_FEAT_ATOMIC_WRITES and
> renumber this feature to be sequential with BLK_FEAT_SKIP_TAGSET_QUIESCE.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   include/linux/blkdev.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 251e0f538c4c..4536211ff33c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -340,14 +340,13 @@ typedef unsigned int __bitwise blk_features_t;
>   /* skip this queue in blk_mq_(un)quiesce_tagset */
>   #define BLK_FEAT_SKIP_TAGSET_QUIESCE	((__force blk_features_t)(1u << 13))
>   
> +/* atomic writes enabled */
> +#define BLK_FEAT_ATOMIC_WRITES		((__force blk_features_t)(1u << 14))

I think that BLK_FEAT_BOUNCE_HIGH used to be numbered here

> +
>   /* undocumented magic for bcache */
>   #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
>   	((__force blk_features_t)(1u << 15))
>   
> -/* atomic writes enabled */
> -#define BLK_FEAT_ATOMIC_WRITES \
> -	((__force blk_features_t)(1u << 16))
> -
>   /*
>    * Flags automatically inherited when stacking limits.
>    */

