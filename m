Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176B17FAB6;
	Wed,  3 Jul 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027744; cv=fail; b=XrLilHHCN6eQ62ADgzH9SPOc22h7qBUdnL7Ata92+ORoIMAM1g+m+Rm5by9JBRjj32b/NFN02M2hk74yOaZHlCndGgxbGOoGjOK/bqwvIsvI1/ViYqpIv69ZNanR9HsLERwyNHzGCxXPZLEGPs7RkHrHy9aW8AgwYnUXJkJQKbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027744; c=relaxed/simple;
	bh=6EwYRYZmD9s80oCT2+MB4llfiUneQAm7K96Tvsw2vZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NUUMNRfcxwXzOoHNGQFmMqckMvwaLkkF/35RUZLQteayPzn2FdmN2K5P0AVZXeRATpWOsIN2+55O2wd1x8pYH4/XArTv/mDq/zjOiazCq5aHEAdtfZSGkDuNc2bVdLQyoXsl3scePv/ZaXn6PdvQCDMV1BYK5gEym25cspyklrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fQ0V0y3a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nq4YaV5O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQ0V0y3a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nq4YaV5O"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463FMUgP028678;
	Wed, 3 Jul 2024 17:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=p4tCXzfY+ATbpWluRG5CqWgITLgDX7tQK9ZL6wdeReg=; b=
	fQ0V0y3airOvVaUIf27m6/mvBK6eIboSu8SHkSSZn0+BnH+rCIaOpur3QV4sbOrR
	bNDGeQLnU+E9S3Kk77ZhSukWEm/8L0yyjVVcYwuyPc3eeUuEp8zEnWuaweyEsrGY
	Pc8zK0Zh3N7WJJdQvz2OyUzp6SZiCZIBodLYkjthfefUtk9LrYb2lGpuCI6eHf1e
	ttIuJ3Q7pjvND8k7jMjKF2YEcWLwh0bUESgGugPYl5ca6TGxTzuzGF2b9uDcA9gX
	C3MWKGHoUzUlGdigtMyCxowtn764Y6GN/c7RCU1yZesGWsfwhwiubBh8jlP7OZSc
	QYv5kP/01gX0XpiHk/zzjg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a598gp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 17:28:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463Gn7gc035737;
	Wed, 3 Jul 2024 17:28:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q980mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 17:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrgVmBmruRgm/lz28+qM//H5kYbegLkg9RESuujtDXA8VYHAldoy5YOHskZt/GNX03PAeNPdRcZjdGvCHG7ZPmL097tIHamh8EcG1Im9COYafIvRPycjnwHd/m+Rh4sax2YT0t3LdoSg0vHy/3p8B3WL0O6QLqa1BMkLbHpI7mgum1ltw9CouZsov17P3Rq+Mpx4QtqAlEHcfkztwykQFQ31NKqTxQ96DGwRNW1ntOBZUpQgpGgeNn1axy2c6rI20xF3jiXIF8EXaVSPDbSlMvd31RaqwRYlAFP99ALB5fpfzJIAMOKPxcGP7iCwMLJWaMcQXS6vK+sNIIsQZzvOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4tCXzfY+ATbpWluRG5CqWgITLgDX7tQK9ZL6wdeReg=;
 b=cFhYc0CzeXpm+PhDIHSsxZgrXWePXJOeGgCgZ3TQaEDVrQ8Kpnilr3Tt8Dnw0LwrF55IFK/c4YzMQy21VwWB/WLgap/xRQChFn0hpEDpoGu+VZBO1ZbZBJrLWZCpVcUZpxvzwvviAWdpq/z4DpGnnpL4zlt+4ZzS8j4+Fv3gsa7WJqI2wxOagXtSgfJFxyOiZSM7tdiwIKBnRHwVvpuwS5D3VbAtY41Z9rCRBiU88ElLGzXNDySn+SIxPKZpzI3iUm2GRgLTDDNz1cML4+d5gybUoInCUJ7qC+uX/yBhRXpZb9xakGGewleCizKJjtdCBaHenYUw0zJ9BVbPvP25cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4tCXzfY+ATbpWluRG5CqWgITLgDX7tQK9ZL6wdeReg=;
 b=Nq4YaV5OybzQwoWpsMS2cgoxTB6Dm3vjDyXO7g+qUh2/QqkrIAYJQ/L8ax8gzrLmGcZW8pyip5qSu4tqVcCIDV+KJ4Qp9aUmonr0VfK0PPPzytv+btjxBxBiTYlnanyIzr6hRk5Kv0VotztZbgv/3MHlx+HdtnCdUOotA5Ho9I8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5205.namprd10.prod.outlook.com (2603:10b6:408:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 3 Jul
 2024 17:28:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 17:28:53 +0000
Message-ID: <b7054e7b-9db1-46d4-ad19-8ced0eecf2e5@oracle.com>
Date: Wed, 3 Jul 2024 18:28:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: blk_validate_limits validation of block size (was Re: [PATCH v2]
 null_blk: fix validation of block size)
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240603192645.977968-1-nmi@metaspace.dk>
 <Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com>
 <Zl6cHI48ye7Tp1-C@infradead.org>
 <8f8f8f78-fcd4-4e71-8dd5-bae03a627a34@oracle.com>
 <Zn-Wpq2AzBo6rcgd@infradead.org>
 <43aab70c-8521-4dfa-847a-1175d31a55d1@oracle.com>
 <ZoVP5NZhCmMH6qBp@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZoVP5NZhCmMH6qBp@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:205::26)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b2e72a-85b8-4f08-7d59-08dc9b859c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WkRjZzE5UjgzT2dlYVVFTWgrUnBkcWprQmxGMDEvSzNQU1A2UTlMZGJDc0x5?=
 =?utf-8?B?aTVhOTZlYUJ4VzlhaW51WGN4eGZnZGJVWlc0K2hEY2JjMDhHUHcyRCt0RlY1?=
 =?utf-8?B?a2VRaCtrczZNazlERDRWR0x4cFRHRzhvOHB5c1I1eW9rNkNpeUw3eTgwa3kv?=
 =?utf-8?B?bllHVHI1MmVjS0p2akpOUWFTdDdSRStJRXRiZnRMN1JBdFpocXBNV3FRUVhG?=
 =?utf-8?B?ak9EbzQ0WEVtQjJIaDF2cm1uZEx0WmtjNDROSGNRYmVSZXlZYWFLZXZ0TnFJ?=
 =?utf-8?B?UDJHamlkR1ZoLy93SmtPZ2phY2hvcGQwM3piaG1aUmVvMFA1UTJkS0xlQkxm?=
 =?utf-8?B?ZDQwTmRhZWNpOStUMEdNWUpEejhWZmZhQXJLRkNHWFFXLzdYcVhwaS9lL0RG?=
 =?utf-8?B?amhEbWh0bXd3bXQwUmpHdGNDSk4yOXJoRUNtR2FMY0FCMTcyV1Awdzh6MWpE?=
 =?utf-8?B?MjYwNENsZGN4RExGK0hGYmpnalE4NE1aR28yUll4RkZyQUZjZ3ZZSFBJUHUv?=
 =?utf-8?B?ZEZnN29PYzNlbzVvSTRhTmNvQ1FVQlhTWkRXUmV0YVpLQ2RtV1lOQno4bFds?=
 =?utf-8?B?MTM5ZExMMUNjN2RHM3FIeHUvU2ZxRmVhSVlDanBlOG1DcmNMWmh6NW5kZkxU?=
 =?utf-8?B?cnNjZGJaRkRYTGQ1VDFNTGVpeW8rSkR4MjdMMGk5UC84dG5hai9qTDRrTVZr?=
 =?utf-8?B?cTQrd1FicGVxbnVHNEFaaVY5cTM3U2huUDF1aWRwdXdGdFdxVUFUTVo0TnVM?=
 =?utf-8?B?UVE0ckhhVXI4UjF3ZDBZREV3UElBcWdJZzdoTEROWGM4S1FSQ2lPZzZaUlpL?=
 =?utf-8?B?SFg2MEtlcVcwQXNWODRJYldReDRpQzdTN2plRWtXNDVHczN0R28xaWhrUHBS?=
 =?utf-8?B?czJHQjhPc1MxZkk0Q1hwVDVKdHJBRnUrNW9UaXloMzBFd0JpdnRuVnd0WGtw?=
 =?utf-8?B?bjNnUm5xZWNhSCtaQlVWTWM5Nko4QVp0WnBiTWppM0pxV2o3R1V5eWgyV29Q?=
 =?utf-8?B?OUhqNXpwdUwxaU45UHFCMFhxREJEN2xtL1U4ZDVWcmEwRFF0ODZuVVhKek15?=
 =?utf-8?B?M1ROcGJlQTZYWGJjQjNISXJQaGtPZXhVV29LMmg4dEY3Q0o4SklHWTVuOEp0?=
 =?utf-8?B?Q2lIbXN1bW15OXFwNmx4ZWNKZm9MZDNGRjd2elU1Zm1MQWx1Mm1hWG01Ly9R?=
 =?utf-8?B?WThTRU04YlNtL0RMV3FYMWdTUnNKemNHNXI3b2VYZkNlbXpISHFvejh5Q1dK?=
 =?utf-8?B?Z0JZb0lneHgvN2RLQytvcEk1VENQUUxrdkw4QndqUG01NWtkRFRYcE9BRWdT?=
 =?utf-8?B?czVEMW4xa0RUeFh5U0IyUHRiRExIeVF3L0VHVXprWXB5OXkyaDZxTzFyVW9s?=
 =?utf-8?B?cGJlM0JpNzB6Z2NVVW1NWGJxUno1QUFkT01rK1Z2YS8xdm9tcmlXbHlHZEpu?=
 =?utf-8?B?RExBQVZQNjRYUnpPd2xwNWFIZDc4TnExdWs5SXQ4NlQ3QlJWUmZCK1krOFd0?=
 =?utf-8?B?aS9HTVZuckd6aE43SEg0dkpFVWFFRktLNkZKWHEwenprQ0lvTlhSU2JyU1Nm?=
 =?utf-8?B?UFAwYW1rU1c1K1JKSERqNWEwQ3k0dGNiUE11RlhtQXcvTWoyejBvTHl0aEJT?=
 =?utf-8?B?K3lDdzBDSW5ZZ3FaNlk0ZXc2dXFCdXJwZWZJZ3RZNlJTcTZqWjIzbzhDTnZB?=
 =?utf-8?B?YllvaTBvNXlZSmk4M2EzeWtxNkRWWVNUcC9BTHJZc0ord2dZbUlQbzFuaGxk?=
 =?utf-8?B?bnNPZDQxUWZxLzlncVhoaSs1UkJIaU9PakdmVVloNHpjOW0rY0UyNG84SU9Q?=
 =?utf-8?B?NitBYU45ZTZIdTdiTkxFQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b0pGemdjN0xwOUpzbHlpV1RmRHdaSmJQMFk5VU9Dc2lWRHhuQkJsWWVWYzla?=
 =?utf-8?B?T243SHpoK1dBSHRnS0tTdU1USE5TOHErUnRPQTMxTHVmS0JTRnh2WEZsekVK?=
 =?utf-8?B?SXJ5aFNpMzA1ZzVZYndoSXJ5NXZkK2IzeFFFWk9KbDlCWVRxK2wrc0dwelpL?=
 =?utf-8?B?OFdXSXpZbFVJcEFicklaaWpXS2NZM3ZNNWU3WjhsaVNsM3R1bExsYUtoTDZs?=
 =?utf-8?B?dGtsWHpiQjFsejhXVUlhT1dPT0pKYmVZTmpMbUZWbHZEc3Nhb0txcnBaS2Fa?=
 =?utf-8?B?ZG5Rblh6a3g5ZlNRZkc2RDUyY0VBYm5SYmFCcmdYZ2dSdFQ0b1lVYnNLMEM4?=
 =?utf-8?B?REc2WWFNTUNPZVptbE51c05BbUdWdWJBR1ROM2xtVTVaWEpuR0NEK0Z4czJl?=
 =?utf-8?B?WVhpelJja29BdnF6NCtMSUFVSjY3RVArVUNMSjNXVW0zZ0ZPQ0dJOHpWK2Ji?=
 =?utf-8?B?OFJDblJyMFVKOUdrR1hxM1k3NDZXdkRKU0Y5ZDJrWjBmTkluU2Mvc2ZOWnBm?=
 =?utf-8?B?UUozV2E0S1NzTEJtYlI1Smd4Zk9KZ2lPZEpadktRcGNnb1RYTjlFTUM0QUZU?=
 =?utf-8?B?aHZKS0Z3TzFiZ0NCbjFkeGQydmFJN3NoNFZlYTJuSkhibTBodnhyamVRQ2hI?=
 =?utf-8?B?SDNWZWlKWEM0MGJDQ2kvK3FvS3lBbnZpMWFucXQ4eTA5VHcwVk5NbnhRUXJ0?=
 =?utf-8?B?Y1QzcStnSEpXWnZVQkN4eXJ3MzY1VFZxNDFBSGFLVlJ1R0tvL3NSTGlZMWhV?=
 =?utf-8?B?YmxkaUNrSTlhbGxLbW5XNDFpSHdsRFZyMjNFd2NROHBhdThXdk5xdlRob05L?=
 =?utf-8?B?UldqckhYVm1YcnZ5WnJFcjlFQ3BmKzQ5UjhVWkdnS1dJSlVDVmE4c2JXT09S?=
 =?utf-8?B?eWxxTnBwbHRYSExYeERDRTV3QmtNNVA1VFNLdFpNNXVOZDlQaytycnR3YzFB?=
 =?utf-8?B?MkJTNHJsN1dzK3lycWswWDlqZldoakpUcGJHWnRNdVdORjQ1TGZMLzZ2bXZ1?=
 =?utf-8?B?cEdqYktmMmVRTjg5bDZsaXFyeWxIeFRnelNvbU1MVDRwWWlUY2JWSkZJMFdo?=
 =?utf-8?B?VTFyTzBrT1lWRzQyNDEvaVJZNlBNbVBTYkx5R09wTXZoUUhvRnREaUozWnF2?=
 =?utf-8?B?c0hLVjhXUEpSTjBzU2Q1c1gzS2o1N0JHUGIwL1FZOUgwU2tVUVZWTHBob3R2?=
 =?utf-8?B?cTJ5YWZHNHF5R3J2cjJtVzFiS1dZbVJXZGdSaDdEVElyNGhtUDM5WU1Ka0lv?=
 =?utf-8?B?RXk1bm1NNDJWVElxRzVJcjNzMFJxUFVMY1A3Zy9VUlNROWo5U0tmbWVIM0xT?=
 =?utf-8?B?Wno1elJ4M0VqTU1UVCtIaVk1YnVPSVM3OHRldVpVZXNmUWRGdmJreWk2SVVi?=
 =?utf-8?B?Mm9tdXJKeHRVUVczbWRVK3lzVE01RlZlZmo1dVVEUTJvWmdUNUZ1aEtGb0Vy?=
 =?utf-8?B?V1I1WmlSSHdDVzN4Qlhwei96TmY2SXZZcFV1K29tSVEyZlZHRE5uSnMvTE9L?=
 =?utf-8?B?VUFDNzgwOUxJaG56cWlURUFXdlpFSzdFc1NBbXR4TXBMcFpsRWVLajRQVUZZ?=
 =?utf-8?B?eEx3c0tYUXJKSjAyOFpZeUNlUGc3NklTcVZ4cXdtblpaT3pnWFVsSlhrNE1m?=
 =?utf-8?B?T2syb0c4bGVhdGRGQndxV3BZZjE4M2phcTRJNDRDS0lsR1JITW5WL1hsK2Rv?=
 =?utf-8?B?TE5kb050VDlQeUZCMFVSUm1XYy9EbjVGMnZITTVnWFBHTWl2T1dRdFlaSG1j?=
 =?utf-8?B?cVQ5Znh4WXMvaElHTjdudEJRS0tSODhiS0p5Q0doU2tPcjN0dTBIdVllZ3h2?=
 =?utf-8?B?WnUzcnBuY2NwaWhHazdvQ1B6UzVRdHppRUdyY08yN3ozNmRxVnUzTitRUXBP?=
 =?utf-8?B?UFZaVjlKZHhqSGdRM2VEcnQ4OUdwdUUxUjJmbk9pRlNSUk53MTRqUWNCTlds?=
 =?utf-8?B?dit2SS8wWEpUQ09kQ2ZhMEdIWEdMcDR1RkdWWFc3RVNIdmd3dmx5bHgwaGpl?=
 =?utf-8?B?bjBkc01UVml5cytoLzBVMFkrZmNPSGU3dUxOK043MkJBSW9oaEhITkpiWUw1?=
 =?utf-8?B?UXlJTGxETXd3YlBNOXhOeXJ1cVJ6M24wemxSQ2c3TXRCN2kzd3lZWUd4VTc5?=
 =?utf-8?Q?Aty+acr1xu7xCelL4Mn2RVz/2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	v/CGRP/KQ+LwQIhZVXJeFdAkXL8s4GntsjhdsBQBVZlJRSIJ8PEdW0GwEPY9lkUaAHdLygTlJ0OQh4ydcq52Oh6/N6RBkogMCz0luhX0tWpdW3b6BJhgy5r07M/ghsXy79bJF5Jxf57hztcpXXpvx/yEqYsgpqWjb0ZmEzNq9o5OVYbqEViozLcr7FLChEOOTJXRsQOL0KJ9wUuAEnlxJe9UfWsAxjXIEbSAlQu8AimA/6MnghLPJm+IbDGdz8I8L5eXaguiljU1EQ1N3b8tqpt3V9KqDJKvaZinCh3/4WuzoDlm05FrXVaeCNxRgSVh72WkQ++MF95Hr3LfQKFCN1Ex1WAUvW+Ku+DUUPreKX2LnzEIId5YyVf0pKaQonH8XAjRNEeuJqsP+U3br8Do2dRe7fPcfGcI8HHw68pkL5Ulfu/h7WAGJd28vicIvDiLjXmSIt7Bpmwr6EPDgc5iFmsPjJxoAnQX6XUKXFGg6LEGkz+YU0d3/ojwG4F/6xbo868ojwN3ZWsa+0TDoqGdKv6dnG7ZAvsuL4ymzjq9Pk/DYlGVbmxJV3XOtKtgzj2AaVqdErzCzu2qQUI693hXsmsPgPyS+gzCyCjbJqaUZ8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b2e72a-85b8-4f08-7d59-08dc9b859c09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 17:28:53.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuSL1uMexPeMBoO/S+yykYAoWRjYQeWfhkrfGlbU/ANk/OxRX+RGfPkWeCoGlwFLAf/XCX9VaSBdr3SXSpi54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_12,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=794 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407030130
X-Proofpoint-GUID: CHoS5DpDLQCw--hLLuPg7QbebYRUFSeM
X-Proofpoint-ORIG-GUID: CHoS5DpDLQCw--hLLuPg7QbebYRUFSeM

On 03/07/2024 14:19, Christoph Hellwig wrote:
> On Wed, Jul 03, 2024 at 01:20:26PM +0100, John Garry wrote:
>> So if we stop validating the limits in a., there is a user-visible change in
>> behaviour (as we stop rejecting invalid limits from the NBD_SET_BLKSIZE
>> ioctl).
>>
>> We could add a "dryrun" option to queue_limits_commit_update() (and call
>> that instead of blk_validate_block_size(), which is effectively the same as
>> calling blk_validate_block_size()). Or we can keep
>> nbd as the only blk_validate_limits() user (outside the block layer).
> I'd just keep the extra external blk_validate_block_size call in nbd.c.
> 
> Maybe add a comment to the blk_validate_block_size declaration that
> drivers should not bother with it as it's already done by
> blk_validate_limits.

ok, fine. It's a bit unfortunate that blk_validate_block_size() won't be 
internal to the block layer.
