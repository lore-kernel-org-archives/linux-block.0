Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673134E743
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602956; cv=fail; b=hllz6h60Hpp4MQVIdFWZwr4AJ5Rd3XDB4hHGsjpcsmtmjO+6oGupfIuGuuEWeUx3ASUsNBp1SNXCevIuCPS2oaogLikZ7Tpuguifdqm20He92YrIPyhlEu1bl3rbIujlYL/idkZz3l0+wBbhdNze3X8Vgrng6IPmVYAkm1yC238=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602956; c=relaxed/simple;
	bh=lXzhxD7PZkaWT6XZKy2zqBIzOL+w3mMZ1pX0DBMDyg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yy/ZaPsv0sHBQ9ATsujH8BOPOtFiGjrfY4A82OFLlV534tgzHVZP5HQl2qqOTG4bg3H/s+bn+WjzEgG0P/d3fXqJyMZCpJNoUOb9tzVzTYVStSJap6LiE81kTTqA5fZXheps0sItrkgfARSdRuHYFpIDhKLnSt+rUEgawAYZ3gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZCY01mbL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w0+VmxcL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZCY01mbL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w0+VmxcL"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KB2VOv1575135;
	Fri, 20 Feb 2026 15:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9xmDQV+H7Awh2QX6EEidKkTKWWNifeSt/ijiI3NVh2U=; b=
	ZCY01mbLkE2N5bO1nH9o7K+2r8LkFNFoe/rr2StZKrUZ7hw+vlMZL0AvXXYK8TkN
	pnIJiHdOvhjryW/DFo78wdtMPLxFCX+NjCIOpNSWt5/+rYh5pvfAp9v2/MICQBAM
	Wr9Wz9JIDilRDcjwneaC6Ty7I5gedUxwvd+tzHFrYmGXa6XTnHaByF6vrYj+OIi4
	x5+1xBJPo76BFtHbj3QwWWNxUY16OnnlghTRDKz9bnMPUKwn7Qdk8gvgueaOqXS8
	9btPkWLv7ExHBhrPYPz0Rc3Dpvwn1Y9GIpm0dxUQDEB3OnR5N/hNJ6ic9eAaNtH8
	Aic6TqoNm6BbRimWCf/9Kw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0rhhe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:55:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEAXkv037067;
	Fri, 20 Feb 2026 15:55:49 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2bf548-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 15:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO3FcuC3QNN1n3Z6/Tvpd+jaow+XXin4eR470clM+HoULtFNtvH79AC98s/gXi9JbOQXT5PDJu2dndjCVT8VZ/HV1mIU02SQrednGnjhzGgK4PwPycOxaFzIkJy+0AxqMruxrrcweiiBt/PO/KE3Jn5D+ZTSzFSHvdd8R5ZSW7s5j14s3Qv4hVXFPPFdchNeU0QBdXm5R3xn/W+zarS6udYhwfGkRq1YZbFC1tEc5HqRk2rlnetHNZzFoyIRvUkbu5z2yfX0zhaMJofUjE1Fmw/NS8dboRx9frl+V0mCdhYT2InmdbWA29Ih7ucef8UiVUUyYlGbfNlarjBw6rTDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xmDQV+H7Awh2QX6EEidKkTKWWNifeSt/ijiI3NVh2U=;
 b=sQXtah0hYbeYMV2fOutWT5l9h3Y/Z0bVBtK5BEN9LogXymEx5KUYVjZsPWyIripcrc/P+SgnWxpR8axWCvPeTJhIG41laOyUULX+a6Q8Wg4D4BaO8EGkXkDHnzBch9r5yIpjXfT9JFGy+q4sevG32Sf4B4J5fdtrvfPDVCUbWVZAfn0wHv9QwRRv6kpIRNHoMs7gGbgnYzkNYkMwF6iGP0VYhI3EXGFxV8o4WmOkUXSLeIbgnugHGDPZ6acPMABUQncVpdG6jT7qeGAAKO9SlfW52qkgRbu4Eqr39FUMBZczg2XZ06smDqjuf9VJtU3cFShFugdGL7ruHMShS6mq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xmDQV+H7Awh2QX6EEidKkTKWWNifeSt/ijiI3NVh2U=;
 b=w0+VmxcLn/TgpEUohXmq6U3QmU/QnyUToMzRFHBCqvbT6tUtwnYv8CImCYxgYwY1co+GgkzYYyJ2z4TkbJzAHTmzfYU0dWtUwqbhDbycqOL7qKq+jdmur7ja+11oSrzjl4xUdUC4nkawSfV+LfzcMNgojS/JcVDTTNmN8xkHMHk=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 15:55:45 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9611.012; Fri, 20 Feb 2026
 15:55:44 +0000
Message-ID: <e7e48183-c5f7-4912-bbe4-a58035156f2b@oracle.com>
Date: Fri, 20 Feb 2026 15:55:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Correct comment on bio_alloc_clone()
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20260220143233.3500551-1-john.g.garry@oracle.com>
 <20260220151019.GA14027@lst.de>
 <26f345ba-9cb6-49ad-89f4-1ce0153fd86c@oracle.com>
 <20260220154324.GA14632@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260220154324.GA14632@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CY8PR10MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 001790e7-2b25-44d8-f82f-08de70988199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZllJSXVzQXZSTXJ6RDgrL29WZTI0K3FlbjIxNHRueTFrRm8vUUM5UElzZTF4?=
 =?utf-8?B?bHkzTlVXQTlNRGROMDlOTXlMeXRwQVdIWnZvY2MwUEtCdlMwSmNVZEtITWhW?=
 =?utf-8?B?TjlJTFczR1pGRXQvOG8rR0RRdDVReHptNnhKVExpRVVRa2VuVURNWkgvcjJX?=
 =?utf-8?B?bkF2YWNWeUR2dU14U0poYUlvTVhkQzB4NExVa2lhbis1UG15WEtNSEVTNG9x?=
 =?utf-8?B?TmNjZFFvWDQzUG1udjhickpBRG9IUGVXTm9rZW8vMEhkZWR3cE9jV2cyK2o5?=
 =?utf-8?B?TXlhOVdjTmgzVmQ4Q3loVHNpV1BpSHpIVm5WdHFRb20xSlBBeE0vbTJxUENV?=
 =?utf-8?B?cHJ0VkVBc0lBUU14NzB3Smh3blhXTnNTbW12SnpDOWR0YXBxb0pJbmtVZmVs?=
 =?utf-8?B?emNoQU9FL3c0QTVjSW5jVWp1Vm5pSTBZMWk0TzBHeVJ6Q2FTRkVoRTZQS3Iz?=
 =?utf-8?B?MGxZK1pSY3p0N1ZpYVJzYlV6eUc5aXdIRzdPNkVubmVqZ0tTeEtPak1UbGZ5?=
 =?utf-8?B?NDdyRmNScndRMHVPRW42MWlJbGl0NTYvNC92Nkx1WStmd0xVSXovSW1ycWV6?=
 =?utf-8?B?TDNSTUhNWjZtMm5QaHVNYTRGTDlEV2dnU2xqOUNRTnBqUjZmN0Q2YnFiMmFi?=
 =?utf-8?B?Wjk0RC9OanpLYThkNXlHaks1cWlxa1QrMHNyMzNqc2ppWkhEbW1zSTV6cGxU?=
 =?utf-8?B?MkJQWEVRdSs3OFhmakhWWmd1MzZIeFY4bW9BMGlqbmpaN0lBNFlXVHZoMC93?=
 =?utf-8?B?ckpvZFpsQUl4K3A5b1FKNWNWQlBIZUxFMXo3MWZreUJZa0xrTXFxMUJmUUlt?=
 =?utf-8?B?Y3IxWjIwNEVhd2RzWDlrb041a3JBY0RHSkZtVGQ1cEZWMXdlYzJZSW9Fd0Qw?=
 =?utf-8?B?WXVUR0xqZDFXSDA2ZHFXUVR2V0VwTUZhck1yNWdiREtzVW5oV2VBclozMDNB?=
 =?utf-8?B?OGJlSlVxQ281cDluYVpZNEpjTjBlQ3B6TkNUaGxnaEZseWJLZ1psOXdOYm9z?=
 =?utf-8?B?cUVLcW9JL0s2V2xPckNNZTRUUWdVTUdDWm9BRVUrR0FqUGxaWmFTYm5ySVBQ?=
 =?utf-8?B?cU5NNHg5b1BFK0o3UEhmVFdENERsakZYVjNvbDZtM2VZQ2hMeDVJdDVEL0xI?=
 =?utf-8?B?UnQ1Z3U2Q2JWVno4SXA1aXB1TDVhTEtEQXlGYzFhdlp0bkJvQk1SdlJSNUV0?=
 =?utf-8?B?bEtDcEJicDBNajJVckJWWEkzQ2tzRjNqWjNNY2dwcmxnb0Fvam9sV1hMK2Zz?=
 =?utf-8?B?U3dGK1B6TTIzNWU1MkV1ZDlJbEgzWHR5S0NlSmhtQ1YzZ0xIRENWaVVBVUVI?=
 =?utf-8?B?eHFmUzV3WTZwb2Z0VHo3RndEdzRTSElJL00ramRsZGx4MzlXdURBaVVEVE1F?=
 =?utf-8?B?M0N5VEpRSTd1UmRtbXhwZ1pJa0dicUd4S0gxNFM5bHJpN05DaUNTUVZYZXFF?=
 =?utf-8?B?d1Y0ZEFETGtoQTYvYVB2ZG54KzNCZ2x1UmVhUzhacjAyQWZCOWtXNDFtdlN5?=
 =?utf-8?B?czVER21qL2duR2lNYzhCV1d6TmV4eE9zU2RzbG8rejdNS3FKcVB5RkN1enAw?=
 =?utf-8?B?cXVvM2tHQ3dsV0NGRmpQblNOTUgxam9zckJsK0xtTFJEWkJuZEVhMlplQ0JV?=
 =?utf-8?B?QnViRlc3QmJob2MrckdBVnE1ZU5Fa0lnbDVPWUw5bmNmTjNHclkrbTBBVzFj?=
 =?utf-8?B?OTZXU3YvSFdLbDFtTmNEc0RYRXUwQ2QzcTFicTZNTnpCeis5YUZkQ2E2d3JC?=
 =?utf-8?B?U21pTVVOUzk3K21qUzJzVFdtQ3l6aXNWZkdvbGdXdVpISmI0UkV0aFJweksw?=
 =?utf-8?B?aEVaTEp6Q1hBYjJJbmVJYW9XdTZ0d0RrdkthaFpjMWorZmJZNXdZUjJBVmtT?=
 =?utf-8?B?WjkyZUZWdEpISlVhRDZkMUZOMjQ4cElsL2VqM3docDZGS0VOV1JYb0hNT0RU?=
 =?utf-8?B?Ky9paDlmRzBGbnhqRWw0VElhQlJSODJ0ejBxdlgwL0o1bnVXVUlMRWZqK3c0?=
 =?utf-8?B?eXg0cFZPcGtRMzg5dWU1NisrNWhId3VXeXZ1TkdLditDM3lhR2ZpVlQ5MTA4?=
 =?utf-8?B?UVJCWXhKREhzZC9yb2pjNG9DOWR5cUtFT1NIZTdscDVDbVVOTkJTRGkzT1dh?=
 =?utf-8?Q?CT48=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFFpZEhIUTl1ekFGbnBZWXJLVnN6SDU3aUZvYzMxeU9BK0JaOUZHU3VsTXNV?=
 =?utf-8?B?V2J1TlViSDZVaSsvOXJMY0xiMDdFOVJ1WXR4TXQwNUk3Q0E0eW9SbkxTVzhl?=
 =?utf-8?B?SGgrcWphaHV5WHJhV29oc0Y3YTIwR2dPTXJFRm5ZbTZUcTF3Y3hYaWJsWDdL?=
 =?utf-8?B?TU91QW0vNlgzaTRaWHpTV1R3VlpDU004bTNpckJlMHp4RHQ4VjJUbksvbjJ4?=
 =?utf-8?B?dERFZGFhTmxUNEZhQnd0OVpXaDZhYkFwTnN6aWNJMytMODVpaERTZ3d2UnBw?=
 =?utf-8?B?dDA3N2ZvK3NaZkFzMzQ0eGFWb1ZCbFU2Vzl5RERGMHg5MGd6UDZOcC9TT2RH?=
 =?utf-8?B?bGZqRm9LSmFRbDIrWlJ0SEt1T3ZONkFwZG1hRjF2YkNKR01KZTgvZWFHbTdW?=
 =?utf-8?B?OE55a3JVSEhNWUhibmxiL0NOdU9WcithWHpNWTd1ZENqc1Y5cDNqT1hZSldP?=
 =?utf-8?B?ZnozUnR5OVFwQjM4U1Vnc3dqQytaSk1GR3Yxc1JFdzROemlBaFBDaUZFMm1N?=
 =?utf-8?B?OXNSYUd1ZDJ4d2tNQzdaMk5lR05CZXZZOFNUTmdFSEpqTnh6aHZESEpQcWVw?=
 =?utf-8?B?RUdjVGVzdERDZmRlck5uMjVVbk1oSWNVb0krU21SSmFuWlBLVlFQOUlxVFc2?=
 =?utf-8?B?NS9aVkNHZ0E4bGxwQk9USjRRZnFZLzZsd1YzRmljQ21EUkwvUFlSazNnMlIr?=
 =?utf-8?B?enkyWkI4SDl6UGZhNWYyS1pGWUI3aGxjSDJneEEwcnVLVkF4cmltVlR5R0cv?=
 =?utf-8?B?cVJBandxVmlCbGVqNkJjdmdxQ2JyMHluNWdRNWs5UWVHbW84Unhwb2pxM2ln?=
 =?utf-8?B?RG1hdlAyMDlOR0ttYm1HTUM5ckR6ekVrT2hNeXNIeUdTMzVvYVFwZDc0S0ZF?=
 =?utf-8?B?Yi8wK2lybFNWMUJRdUx3RlJaWGduQVEvRkZ3Y1FCWm1lN04vL2ZWM2gycEIx?=
 =?utf-8?B?V2k2MnpubEhmTzdtRVNUT1FWcTg2MEhiRlptWHh4RHd3c1J5REZraHdWQkhq?=
 =?utf-8?B?V2UwekpXYitMOGQ2QnZobkd1SzRsQTcwT1VSWEpPRUZ3UWtCdzh0NFFSUlFm?=
 =?utf-8?B?Y0RJM2FQTHUrTkxwSnFaWlhROEVkc0xSQUtUWVhSejNOKzJRUVRydmJoQ1JV?=
 =?utf-8?B?NGQzNjR4akRkMGQwR3BQTktZbm5DbVdhQklxRGZJTDQvYWFuMGxxSXhqZFZm?=
 =?utf-8?B?NnY0TWZ6QXFUa2ZhRzkydU5KZXkySGE3TXlnbE1iTTZmalJ1UGNzaFlhbkh1?=
 =?utf-8?B?eGx1a2pKWlQ1bHB5SjVmL24zTTNSYmhIUEtnYS9HSU84RXlnMzg1TnlkdzJ3?=
 =?utf-8?B?OVNiWmJ2aDhWK1JyUnJvUm1tMWNncnpCWVJiemRiZTFSWDFuZ3R4NDFndUFO?=
 =?utf-8?B?NkNDNitneis2TXBvTzRCL0d4b3l3UXVHNXM0NHJ6SysrWmppUDBFTHY2NEFj?=
 =?utf-8?B?V3VtRmZ0VEdoSm1DTVhpbXFYTVJ3NkxUVHFjZDBhSlZvQXNYMzVKdUxZMXBU?=
 =?utf-8?B?b2Jvd3RIbSsxTlZiYkYwL3laOXFvNDl6TW9paTd5ZTF4UTdyRlhFemM2M01V?=
 =?utf-8?B?UHk4c3liRCtsV2hpYkFnRHExZUdjWXpHRHJmMTVsKzlTTWFGL0gzb1FGSzBY?=
 =?utf-8?B?NmlxSGN5dlVDMUJTZ0QyZXNVL3NMRDQ2K25jSUsyczBBUG9tZ29wRmhMOFBx?=
 =?utf-8?B?WlhYMStlc0ZmYlYzRjhQb0RSc1J5OGtlcXJST1RVNW1ZR1RvS2V6Z29ZUlNP?=
 =?utf-8?B?R2VLL2hWTnI3K3p1S01uck9UaUIvaVNJTi8yYit2YklnbE5uYkhjcHl3ZXVk?=
 =?utf-8?B?S29LeW5QK2F0bnlzVFdySWc4SFVoQ1RybXAyWFlqOTlSK2tjVHRhRkk0RUJi?=
 =?utf-8?B?UktBZk9xeWVRV1BNWkFuajE5SEtqanZZczhjRk41WHNqT1NsYWt2WWZQeHdj?=
 =?utf-8?B?dTAzb0tZbmVHVFBCUFZ6ek9MV1JBY0c4Y1dPZ2pHcDY2eEtBRHI1WmZINnFn?=
 =?utf-8?B?R0lUWU9iMkxOMVdLYmZFVXNIY0d5WU9abzlWOGZURC96NlNwdTBGYjBFR2lq?=
 =?utf-8?B?TkRGaTVjaEJUYmpwa0VBR3dDMWpKRUZ3Rk1NREJSNGNjVzU2em9pUTAzYVA4?=
 =?utf-8?B?VzJLVmdUaXEyRW5oTm5IZHpxb21PQ3VmUm9NczE2elNWWndlMDVQSWsrdThh?=
 =?utf-8?B?VGxxQm45dmhHb3NuY0NzeGdoN000VmJVZUNlQ20yYkU2NHdiZ0hGZFVwMCtn?=
 =?utf-8?B?akVCQ2VkV3JJOXMrWi9IQjNidkF0blJPdUpjVVN4WkxxZm84VDlrUlh1aXR3?=
 =?utf-8?B?ekIwQXBzUkFRUERZb05tU2RYbUhlSkkycWhtOFZiYjJnSGJuU1ZoUzFDNU43?=
 =?utf-8?Q?ICi2cyAAMTXu20W4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W6B7TK9uId8ZsPhzHRVfqQjICQT8oro7xfysR0z+Mr8a80VRphOdShJHF5Wqva44Q9kkIvHF1p6xbp7X68UpP5UUSvpciiA+QZj5dsVMVWlAjazFndY45NcpPPAVVtgSaZJ5doqIEZH8f7Fpdsf50VjpysNyofTXFblFLJfuSC36eFJQGQ7Ot0gGS7f4rWYc8OYX566NBUw7wglj4xm5KR1u/LptJgdSPIs/la0lI4v0fz0CKVZlhk5GEPBuaXrKbElAufr6s7ef9HVYMrNSlB2NDst6RTOSMAKUh2LN0g117z3XlzOzep7MSVgHL9susU1mynqA9e3pT/QH5Zq8RIUcr2xTTV5QgBFtKrCGejomX+cc9UrUur5rer4oZxevLA7hs2itsbjxOY5eZm4sfsQAzD8h6j0VvibL14luu21NIyg1u3x2a8+IzvN4BddgAlT9H5Driq5LouQ1+kvkPDTjYQn4cJLUNVBR9YnK6GtqT224LjzqaVc1Paa+EtzvUTqimnIvjwgALDHwzustDAE0+2TUJtxIv/NnJcH78jSFZLqBcZ9UxlkUUdt/OMojh0ZoNtgn8bhbPsteYQ8Zzv/j9vPE62oYJlX4HRZVUQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001790e7-2b25-44d8-f82f-08de70988199
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 15:55:44.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGoGRWHqwJ8IcjrQvF+Y0hr5zc4zMU/JZf45YVN1XKqIZR49dzSjQJP/gLcmDuPmuffR47fkEUuS7er4W/yVWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=878 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602200138
X-Authority-Analysis: v=2.4 cv=V6RwEOni c=1 sm=1 tr=0 ts=69988406 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QFwbCKLXDwaz8OT5fmIA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12261
X-Proofpoint-ORIG-GUID: ejQpYwSeRgPry9ZorlcnkVtv0_TCz3xY
X-Proofpoint-GUID: ejQpYwSeRgPry9ZorlcnkVtv0_TCz3xY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEzOCBTYWx0ZWRfXyLvImnRWnagi
 WcVsf4yEQuFA30T7e8AFqDqeCzbk/ZsLinYsnFMcxBzMw8dYmZyjUb2MrLurdWyj8hjZcmz2f3S
 8rZ8rSIb2x431fe+rpHDBHo7uqulqQl+MAaIh9T3eKIQJphBZhG4yedg8meI94qevhWxeXsfFxG
 Ln8ce+NFW9YE7vqYYNEa2FAPWH/x6D/5GjFPwzeIDLyuFy//8PfvjzMXTekbd90IF70evdFJbAh
 i4bd0CIPSPWTUzfeyzlxJ0smyPB4wxDjXEjVKCRA3KwXU+14Ky/woPkisbp0lL7KeH8Ppqypd3w
 4BhfL58yYlZ3rntlkyALjtY9f/i5YPZfe9eC32g4mlNeQ6zOls/e9DWK4mq6KMhdlTrZCI3pOG8
 Hp1Ee8Z7PsAIKZVkcdSYD/lo7inAauTrp8u/ZU0OBLNRe1mYqCNmxyKcB3zyHZg0gXTzVRQ4qvN
 QJZ7bFVgqHoC9PHbNEaw5giY+LwsVndPwfTVxR9k=

On 20/02/2026 15:43, Christoph Hellwig wrote:
> Well, bi_io_vec isn't really the data, but the indirection pointing
> to the data.  I guess we need to come up with consistent terminology
> first before we can make good sense of this.
> 
> Allocate a new bio that is a clone of @bio_src. This reuses the bio_vecs
> pointed to by @bio_src->bi_io_vec, and clones the iterator pointing to
> the current position in it.  The caller owns the  returned bio, but not
> the bio_vecs, and must ensure the bio is freed before the memory
> pointed to by @bio_Src->bi_io_vecs.

ok, fine.

BTW, the comment for bio_init_clone() was much the same as 
bio_alloc_clone(), modulo what I tried to originally remedy. I can just 
mention that that the same bio_src->bi_io_vec lifecycle rules apply 
there (as bio_alloc_clone())
