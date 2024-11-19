Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049051D0E34
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034918; cv=fail; b=WSGS09w4jbgaGFOs7IrIQ4SvQipd34t+MDi5t4D8L0X61SDNY4wBTSiueDq+2tjfbZK8KQ38CGUMpav/kR0EoOmVYGY+zzJmMml5ko5TnP+tvcQ3IsMwf9ETtHgdGwb7ricAkdASV2mHVqhENCFRfj0LtM7YPtg5+3pvzQ4kJhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034918; c=relaxed/simple;
	bh=eQ21x89BWQV4Y9aivmOWHylmhnQkA8u1BsZg+N3++pI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KwdtECcjTN1BFNlzgI28fw5O1+pphwPWXoKcdHihb3ZBq6Mm9jbHsd4+0771sR1vFkYT6bJyWk8lC0dBmnAgWYnOplugK1tk3mKw1d30lHLIADHisQPU47vbFI/W8iqSWZ2FL9PtybzGNTorNS89q7hDO2HTauZ5TFlKuFHLrhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EYnf7MVO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=agbPsRfM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EYnf7MVO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="agbPsRfM"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGfXF8031204;
	Tue, 19 Nov 2024 16:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JsnXJK9bsdeyVjku6whnCs7/xa0wOh/QwwKduCFGhkw=; b=
	EYnf7MVO2BMmmUNEO51jfmLqec3G1srFeV9d1rLRst0rJamNYiWDrX5FfrONohwz
	b+cqj1nl+C6lLmhc6sRLsgZcyuHKXj4XwAKXH1KHdcxslov80nghHB13WlbfCi+2
	npm6r3Lc5yaOI+K2Ez7xyRL64o0yGE7Yd9qnVKw4K1qvubMXmeRu3juPAIED9FQk
	4toDd6DtAwnZZP2vH9tFJp2ipZQXBS3llhk0njx/ogDpKWdCidngwcV9lC7wMx24
	6o9RgjbbUErv0s5ea6IBQp9DrCYRTKiniLa1xuPNzp2wKz18Mr3kiyajkBogxea6
	ZoVKVFPBJCHoR5InsEBScg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sndqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:48:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJGGcd3023091;
	Tue, 19 Nov 2024 16:48:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu96tx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 16:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4YazYepqapReIw8oMJ5MRP0d5/fw1bQWsGjtiAxL1YO0cN2m6WjlShO+rBp7ZR5R6MeGh1GtD6ioKKj/H/w8epEY+kN1nrg+h/Km4mxfEcO/nDP0iuF7P97T8yMLS9cJq/ewt1rYiINvKSBZPu4KAFEFD0Q3rKfACjTRTD+XQHPpIQRw/CiXQlEYsPPeH7EBJyuAzHczJpTZ+OJ2kanLHdTphw2YWyIwFp8nm1bXjKO1dcke4InlZBmQnKbT/Q5OLADVDE10xUTrTb30P2KUj64IepuVP3T/SGyEucnJsBXcVEin0f4jHA6G2Ano7vDxaMRcFLxq+NkMO9cESia3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsnXJK9bsdeyVjku6whnCs7/xa0wOh/QwwKduCFGhkw=;
 b=tT1DEPa5LsGUlb82lGQgDgl2LdtzQMI/B5D/UPM+mDiHaVNgqkKlzJGHssRbi9Oclex3tThobH1Y0zhdFQ/a/1BUcDwb05C5zO9mHPGdZqRSw1PeUk5SBu+I2tdQ2gbozOp5qmPHjzYasiLbXzn3BLnL3K9m9E+ukNMKpA4w8WQirMzLnaX0HoH5pB5SaIN2MqyG1o1RqGn1OYJ+sd2LuXn6YtJjM2hfVW58m2SX6TK3yi9FUDXWojXuaPel6+TSO2dxxAR25d2sWS+yv++0vHN4p3AVYzhpfO1p+TZXHPSJYoC7NF4UZxhUiVz9N2S4G83l4IVsBA/uA0khCHTltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsnXJK9bsdeyVjku6whnCs7/xa0wOh/QwwKduCFGhkw=;
 b=agbPsRfMgzV+B9eRExrBqCnuHWoBgV/B3q/g2dQq14Fo6pmGTRNUmtLQBfQykCItQ8DkpGIIGqQXuTraNcodKoL+m35xgIVQ0rYkpPcEBqXRFmp8UgcGB7PbF0Sg06Asuq0qNK1jFzv+bmn6V/BCZ6fla85ZBpbH5nplIa3FYPU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7722.namprd10.prod.outlook.com (2603:10b6:408:1bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 16:48:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 16:48:18 +0000
Message-ID: <427189c2-dff8-4af8-a805-31d78019cc7b@oracle.com>
Date: Tue, 19 Nov 2024 16:48:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: don't bother checking the data direction for
 merges
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241119161157.1328171-1-hch@lst.de>
 <20241119161157.1328171-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241119161157.1328171-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 10298d28-1d09-4366-7dca-08dd08b9f81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmxrTmloRllzN1VZOUJwZmZjMldDdklsOFpFcnhDcjNVOWtKMW10bm5sbTNY?=
 =?utf-8?B?Um5yR0h1VUdHRXovdHU4TWpQSXc3T3E4ZWpBV01pMWZZK0hEVHBxT2hLRHdQ?=
 =?utf-8?B?QnNtSU96SnY2RzYyVmYveG5LZXF0TjlXRFcydTBKV0Z4a2kvWDF4UFQ2dHBZ?=
 =?utf-8?B?WEwwOC9UdWNOYzA0emoveUtkVHJwN1JJR1NMUzE1WHJ6Q0Y5V3JUcWNLQnl6?=
 =?utf-8?B?dEtnR0hUNVdabGdNZ0NPc2srZmt2M1VrMFVNZFlCNkNoa1pHZHYySGxKOERM?=
 =?utf-8?B?ekloVGoxQ1A2V1orVTlzb1hqRzFyOVUvelZKNTRHYmVMcW5WYjNoeWh2MEYx?=
 =?utf-8?B?bEpVQ0pRMDV6OTRkbkd4UHRiNHFxaTB2RGYxUFFxVUREOFdQSUUwRnFmdWhT?=
 =?utf-8?B?RGg4RnNpU2ZqQzdaTTBOUVVTVDJ1cnJUZU5JdnNTNURXdVlWaFI2dkFpM2ZC?=
 =?utf-8?B?M0FlS1IzVnVIOXBCSVFsVmxuS1ZJMmNvVHR6QnJ5TmxmRmR3eHRUWVBCL0cz?=
 =?utf-8?B?c2Zwc0luNmpEbFFieHp0dFFFVkpXaXJjYVRXTmdabERhVlR4QXBpaWR6ekdv?=
 =?utf-8?B?RUdCbkMramNZUHRQa3JyYXVmL1VoSlNLdkc1blZ5NFBOYmpYVVBvUmVXUFJ4?=
 =?utf-8?B?T1d0d3R4bEFPWXh5WTlLUmJqc0xmcmljMGpMWXk0K3NFTEMxRzNUK0M0T3hh?=
 =?utf-8?B?S0RRY25CWU1NTnZiWElDMHpuVjRKMHlybUdrWWJUMlFSaXA5UDJ3MU1xbmN4?=
 =?utf-8?B?MG40TWp5M0czOGc1cG9ZdURFUTBhN0FzV1F0YXVkS0pXYjZ4RUN5RHBjUU9h?=
 =?utf-8?B?b2xkUklXcWwvcGRaY25CZWlXU2VleWhlSjN1U3ZGNGU4Vmg4RHFKNFNmZWs4?=
 =?utf-8?B?dVpicWcyc1pibDh5Yk1xamMrTlBZRngyYXoxS1F3dXZpalVueW9wWisrRmcw?=
 =?utf-8?B?amRYcFN4MUMwY0xWNmdGMUVaQkJoWkh5elpUcGJrM1VmUUVrRFlseTUzbHVt?=
 =?utf-8?B?bEp1d09GMHZIeWhSVFd3cnBDcXFBdjVIMi9SZ09CRldUd3BwRzRkR1dYdjhR?=
 =?utf-8?B?UXpFQzJrQXVFZ1QrMlB5MlVwS2doWk5IUlpWU1prb3pDbmI4NlhHa2s3OGY4?=
 =?utf-8?B?STRUZzZsdnFXZEFEYUIwOUpXd2VVZW1nTVRQd2g3WFdDQXVseFJyMlo1Q2lM?=
 =?utf-8?B?Qjdoa2ptYk5SWldpVVhxekNvZ3poMmMzRkF0WkllMDlDckxyeTRvWitBL0lB?=
 =?utf-8?B?Sk40b0FpWHE5RHJ2eXRaT0pITHpHMVp1L0hzMlZ6M2lRRld6bnNMQlhJK3VY?=
 =?utf-8?B?ODhyWVc0RllEVXNjckVFam1yVXBnY1dpY1JJSlEvWUxlWU9GOTdyczVQdWtz?=
 =?utf-8?B?dk1lTTJ6aEJBTUdsQjE3UFArclJIWXFIb2ttVDIzU3BaamJLZEtlS0cvVHda?=
 =?utf-8?B?WnpRNjUyK052NHBsNmVKZzY5MWhOem05QUFoRGs0NHJKNmFUb0FOMVFHdFdw?=
 =?utf-8?B?RGp2MUJZTklXelIzQ2xOV2ZCWWtmWnlqUWVZZVJaaWJIU0sxQzhHYUlrM2hh?=
 =?utf-8?B?c0FLakc1TEJod2dOc1JuTlloenFHYmRFUkd2dTZEUURnUDJ2SThrVFJyYnh3?=
 =?utf-8?B?TXQ3Q0plSWdGcmY2VlZSY3BUMGpOQ1dxRlo5Z2VCM2pvM2l0KzhyMWVyZVVw?=
 =?utf-8?B?bVJ4NGhvbUZGV2xTZUJBSXlWalp5R01ZbmVHcXk0MkdrcGRCV3JLK09Ka1Q0?=
 =?utf-8?Q?jXmco6Ggj5H87wGE0GcF3WniQZpmtHWJ86sfMvq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDZZRUZuQWRqZVpIelBXVkphWmFOMmhOamU3WGlqdThEeHNqcGVvbm9tWEtL?=
 =?utf-8?B?NjN2aWFyZnR3UVBYT1R4djhpMS9iYXprOUJWanRITEtQQ292QmRWVEZvUk0w?=
 =?utf-8?B?ODhUc042bFZ5SWlKSWlMUmhxRDhCcnRiVHdjRkVuaWVXTzdaSXZZUHVPUUs2?=
 =?utf-8?B?dXdvMzlsWUdtNko2UEJBTWRpLys0SjdXczdlUzZnN21Sd2F5RkQrazNQaGxQ?=
 =?utf-8?B?SHVMaDM3RUtQeG5ORFFXQk1jNGZGWFlYTTJSc3FDbzVSUVNGYndnWDB3d0xS?=
 =?utf-8?B?WmRuZEtWOW95WXZOSGtyT1UrY1lwQTZwMU5UdkFEMXVzQ2N4YmRqVTJNa2lE?=
 =?utf-8?B?bGw4cm5LcmFSQ2FwYldud2hEWGthUjlsU1lxaGRhWUw5Z0N2Y1ZORzhQUncx?=
 =?utf-8?B?c2pucGw5SWhiSjZ4RlRYRXNsNFo5cHNGRXBaSHFjS1hKZW9YZHorNjZ0UmZ1?=
 =?utf-8?B?VlhIbDFscUxZbVZPVForZkxhc0xzZGc4V0hGemsxdkF3U1FuVWx6T2JXclV4?=
 =?utf-8?B?Mys4aHNwZ2NBOEh2SEFYOUhXdkF1NmZ5QTJiTk9QdWNncjhMMXp4SDBKWDR1?=
 =?utf-8?B?bjJwamgxdGVlNU5pWnVFZDBLRm4xY3lubTFlaXNxcGY3M2k0MURCUXA0eGZi?=
 =?utf-8?B?WjkwRVpOem5qcmdQNUdUd1lwcVZvb1FFb2p1N1JVcHNybUJoSi9SMmJrbkxn?=
 =?utf-8?B?eVd5bloyYUk0c0ZsSFg3TTdFYnU3dDE2enVWQTl1cFluanFwamFKYmZ5UDNY?=
 =?utf-8?B?NnptR2Jyd1l3UUg5Mm42dzFxdjBCbDYvaUhZVDRBWFUzVjNRaCswUWpGeHRX?=
 =?utf-8?B?QnBzd010a28rdHJwdFBLYS9iVDA3S3k2NzVlOGUxdEJDcThKWm1Mak1Wc2R6?=
 =?utf-8?B?dGd6VDdsZWRWck1WMTdyOXFsQy9JRGlIRVNyeGZFQjZMVUlYekVIZzhSQ1pX?=
 =?utf-8?B?RHBzbytPL3VHSGdRVG5WVDc4YjN1NjlidjN2SUR0S3dSLzE1UTJFanc0bzhx?=
 =?utf-8?B?K3Q4RnNpL3UrZk5EeHNJWTZxUjZRSVc4aEtQWW5NREdjSkZuRmpNbEFYRGZx?=
 =?utf-8?B?RkVyajlZcENwRGJIZ0lQUzZST0xOTHc4T01xbEVDeVJOQlpoaVR1RnhHakZP?=
 =?utf-8?B?cE9lUjV0dExkQStjM3c0Z05mb0tWajhNWitERUJUNitBWXF4OUNNdjRKQlNa?=
 =?utf-8?B?aXJPODB2aytNTFJ0dUxlUms0VVRKdk9mMldEc3Mra1lBeEpvbkk3SGRCSWFO?=
 =?utf-8?B?TDl1L3kwSXREMWFHZjh4SUE0bkJ3RDI0U2RVeUhSMUNaZXNWSk9UYXZXWlBp?=
 =?utf-8?B?KzdQYUVva1dzOHVsbGJuUGZUUllCM09FWjJ4QlVpcnRTVmI2anU5Q0ZuVTFu?=
 =?utf-8?B?QWcwQ2FCK2N6MXMwWktBZ2lRb1A0VC9YMXoraDVoSERMalVpQjRkRlRzR1lB?=
 =?utf-8?B?dW5vZnlHSmRRVFlGWDlZY0QzQ055UHlHVDNnT0NsaU1aWjBOSVVDbERuTDNT?=
 =?utf-8?B?VS9ibVRUQThlVjJ3VVdLSkRVQ3c3TnB1REtrK2RldlIxWllXL2xGbnhSTEwy?=
 =?utf-8?B?MW1OMU1YRUFFR1lteGZXRlJyZ1pJNmVKaHpzZ2E0Y2k1WlZKK040ME1lRGNT?=
 =?utf-8?B?UGh2KytBS3cweG52RVJhNGpaUHNiODFnN1dOKy9MRE1QZ1Boek9icFJtYXhp?=
 =?utf-8?B?U3JoWklYNVJ5SzdNQUNIN1doWDljWG9HMitNN2N0L3Iya0JrVWdDcmlnY25L?=
 =?utf-8?B?ZmpnakloanV1Mm1JRFVOak5qT2RWTlhqMlFkRGczNlNMR1doSW9ZZllGTTl4?=
 =?utf-8?B?WDZRa3U0RldPdjZFS3pJeU12MFU1VDA3UjZQTVVLN2w3d3JFZjNrdHdOaUJr?=
 =?utf-8?B?cjVJNHRITjlBQmlpa0h5NE5kZVN4RFlXenZJUTRMZGN3a3FDbEdhRFduYlp0?=
 =?utf-8?B?YndNWGFlcEdBdGFOMDM3OGJ3ZmFDNWtsY3dvVjk2TmhWVzVPTDdyb2Q4a0I1?=
 =?utf-8?B?cWlKVnlpVll0WWc2VHFvRFRsWEZrQ1JZNXNpaFBSamhaWUtISWcwVGt4aWJF?=
 =?utf-8?B?OTJiZDRWQjB0VjVZM3kybGttQWJFek5yU3BxWkFjcW1Wb1MwWm5jSzJJak9n?=
 =?utf-8?Q?cs2vFVihvnd+g2wNy1z2TKf3f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1o9JuKvjc488Qtx1zTrUAQ+FD7wnhZAIJbV9L27MuLi7d5ZNAgiJg9RfSElZz3+Tdt3t3Ufsf1BfSAb9WJ8ae4O2mExJty5BzswoPuW+OC6YjhjXc2KgFXS6CBVubScJzrKgmUMz1BxqGfa9le8kP8ZqUuVWn9DJakKSaCpmhTiJAwdWRFKoxvJzQBN4EqbOIKDaU9tHc+cIOCcAnBqHfVmfFdy7N7q5EBE2UcqUQbFQzu70BqejMHtx+/wy3E2DC3a6Z3LKXKMy59PQTGM7BZ1eSv73ZrxHb1M96RTq6eTdGjRpeu8ewiFkMNnOaYWrQYe7dvY5/T0BoV+NggOJvGUBb0iU6j/jtTTEicoIqcmIik9tr0iT3KB91iFpfQ8h/mg7E4bFr+dsu1eW0GTt5Q2Jcs+Otjn0wydgT5FTcXer54dMvc4XortSKWdoqBdVXGJRrKvucv+IBbUpzkZMan+ULiA21owKxI442oJjotAPlqclu8aCD7OLqBRGeEoHG9/Z421g/0iW2kn9WQsvnTO0+o3iGWzTJbG+kglKnbjEfFIM1pQneeWCdqbEn1T19+WoFYgIcS6db58fnyZIMzWcNgsfg2MDXnJrodeJO2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10298d28-1d09-4366-7dca-08dd08b9f81e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:48:18.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDDdGuAiQtsB+U7x8usHlfG84E8KtssLTFPWsbSJ1DB7+XbE9kPbdTLP5OHGVMzRotFptGS5wQOo6UXDjpO3bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_08,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190125
X-Proofpoint-ORIG-GUID: _qXMdxICEo1EWA6EBDXL4XJrgEW3FVIi
X-Proofpoint-GUID: _qXMdxICEo1EWA6EBDXL4XJrgEW3FVIi

On 19/11/2024 16:11, Christoph Hellwig wrote:
> Because it already is encoded in the opcode.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-merge.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index e0b28e9298c9..64860cbd5e27 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -864,9 +864,6 @@ static struct request *attempt_merge(struct request_queue *q,
>   	if (req_op(req) != req_op(next))
>   		return NULL;
>   
> -	if (rq_data_dir(req) != rq_data_dir(next))
> -		return NULL;
> -
>   	if (req->bio && next->bio) {
>   		/* Don't merge requests with different write hints. */
>   		if (req->bio->bi_write_hint != next->bio->bi_write_hint)
> @@ -986,10 +983,6 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>   	if (req_op(rq) != bio_op(bio))
>   		return false;
>   
> -	/* different data direction or already started, don't merge */

I tried to check what is meant by "already started", but that comment 
pre-dates git. And even the code from then does not make it obvious, but 
I don't want to check further, so:

Reviewed-by: John Garry <john.g.garry@oracle.com>


> -	if (bio_data_dir(bio) != rq_data_dir(rq))
> -		return false;
> -
>   	/* don't merge across cgroup boundaries */
>   	if (!blk_cgroup_mergeable(rq, bio))
>   		return false;

