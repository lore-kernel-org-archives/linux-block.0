Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7F28D841
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312309; cv=fail; b=sbE71xIevU5208ydi4wsFIbDPfKgTzaWVM4tPka7myAvSdb5kTPrNxPyXtQRwdUJ3TfPCWwkKQCHfROUS/AixEmh5s/73vegEKAgZh6FRvR8HNYNMUljbVRRvtKCBue7rOuQvonfhHGyWoU5nnsUtaga/xbI4DrM+ic5xopgQXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312309; c=relaxed/simple;
	bh=bg/UmxIL7tgn3GlESTV/KTavw4X0alUQC5RaigUvaJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nV3x7dN3YwOMQnZQ2oVSv3bQ36z7PUXjAOky22GfrDa/baXekJnC+M58MrS9fI0lsK8kfL4bbS4rwh14PcD9DVj5th2E67NnWesTkNBYvChOae6y57NWmV2F844ogLArR1TaqQ0BHxqri3Nwu1En6j0jQuaF+errRAgWUIIoxd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r4raGfdB; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r4raGfdB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=masqTT7W/9ADvqpyLAt49IEv3cssZg1vU0MsZ45V4+pP8RICNFTaidnpXEL+i7mDuPmOwD7/nvxSv8W0A8lCRXSVyceVQiNAxrVuzzWIMWOYWhVGCNJq1E6M5L97wxtLieN9B7r8wcKB5nKMT8lSI3rtwAo0NAxjKP/pL8u7FzrcZg3zjmDCdxZDRH+TlYRGkT6S9ZMb/zp/iWdIRrcqeske2ivDLlG6jH5DlK1IF58qtX71wys3cJiFiQDbovd31N5difFCCmfBWy8E4q7OcLQKPDcZjWmBbSBZEP4Q8sE1uzVS6Hyi/KkjSEMpcX+Pxb0cUBJLWSwGT/QYgtj/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUXg4Zh76skw8ajVmljbNtOq0mHTmAv5Aj4fEb/QeHU=;
 b=R5gCB/es75D6hFBZ+tm8B5BqZzt2ALEQOJ7b7Q4bxSBbweErHGvrSApvVj1h9N8AEqFvzihbGhJJfHJdvXOkEr2w/dBpKmiOwGnpwMmw4MvBIeUpvnmLX6YlN9QmR1Oumy6EnUhz0bDmuYoBoofbqA0oqGHE4v2wUyvjKJErzhq4Dc0tZxJ3bPJ3scsGNKXdCl0X+CBklbPm+tkLUBZUOie4S1GSZjidW3G05gxWmFp8fPrFr5FtqJWUR5WYJOmDYVHBbUSV/p22ltAoQHd9oaoZH7xVppFzVXnKxg92wc57NLiyhdkqKzQeTyB1gcmf6pSJAEn4gu1+5g+bYjHVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUXg4Zh76skw8ajVmljbNtOq0mHTmAv5Aj4fEb/QeHU=;
 b=r4raGfdBqE1CuASqmyOMpI8TJ1stLhiJvKt2T7nQQ/XEldU18iWIFAlo5QHSf6pGCfwsKyF2ini+kRtE/Mu8Ys7529HcFq5yhOAbI3q+xFj86awRJziFvLqhY3mrzt5Yj6eLzWAlRtngbJNiQWpL+nCWXE+Op17UCncxk1cbNFE5Lm0LKQPHUgR5GjhNtYoyfQxVoX1QBqB4ovzt5QL2q6BI9rPB2jBj9hhfakJ9YGwV7BA4UROiMARVyyIWssACm1VvQqWds5rzhCqit3Ze28QoFUEBfwtnUFsZyFIT6ocPha7CFSav8zUcbZF5JtXV/3J9Ne3HMfrzn8yqjssMHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 19:11:44 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8632.024; Thu, 10 Apr 2025
 19:11:44 +0000
Message-ID: <21dfcbfc-5295-4493-8ae1-eaa82f018472@nvidia.com>
Date: Thu, 10 Apr 2025 12:11:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Does GUP page unpinning have to be done in the pinning context?
To: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, David Howells
 <dhowells@redhat.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, willy@infradead.org, linux-mm@kvack.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <939183.1743762009@warthog.procyon.org.uk>
 <67d4486b-658e-4f3f-9a67-8785616e6905@redhat.com>
 <dcb80dc4-a9f7-44d8-b88c-7221ea29deab@nvidia.com>
 <Z_NzBWIy-QvFBQZk@infradead.org>
 <f04289cd-128a-492e-a692-6f760e2271e2@nvidia.com>
 <Z_dzKUp1ukaArcSx@infradead.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Z_dzKUp1ukaArcSx@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:74::34) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: b87fe601-0425-4084-c60f-08dd78638836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zy9vL1ordk52emF2bVZiSGIwSDVQM1gxaXR5OVoyRDJId09FQ1pJN2gyNzNT?=
 =?utf-8?B?ZHZsUTZNVnhNTGFLKzNDWUJDQXBESHZMWXpiQ216MVpJRjZ6c1M4RkhicUI1?=
 =?utf-8?B?aXVjNG4zeDZ5c2xadC9LaGxkQkhxRlJnQVhFR1E4WlNXWXpnNmRsWlNSUjF6?=
 =?utf-8?B?SGFIY2pnV2dlNzRpblZZcXY5YlZSMFVabUFENHJMM3JENkd2c05sOXRIcHBY?=
 =?utf-8?B?VkxkaGRVUDdFaGFKcVNGRlJIOGJ4cmRwd0F6bEJOOVo1OHdYaXhOcG1aL0p3?=
 =?utf-8?B?YkpMWE5hRWpMRnFKM2lteDVpQ2lSK01ialNVRDBtNmJ3dEpMTzdaRC9YSnBN?=
 =?utf-8?B?enpRTXVoWUxJaTh2cllMZkxRdzZvUjhFdnlYYm1yT1RxZGtYNjd6QVdkK045?=
 =?utf-8?B?bzFvZE5QbitCWi84R3NuQVNEdXZlSDBpOEVFV1ozbU8ydVJKcE1vTXBqbTJO?=
 =?utf-8?B?ZWw1ODA2YXZHYVJwemRtaCtOWHhHV0VsRU12dEdYcHdadENSQUtsS0RjQjB4?=
 =?utf-8?B?VG4vczFiQkVlMTFvMGM2WUxReVdnVDcrOWpXZWVsSDlBWGRDQ1Z6VU4zSVZs?=
 =?utf-8?B?MDRpMER3TDIxLzZWTkZJZjVTM28rVDViUFBwK2lSaFlMSHBGZW9nRmo5bVd0?=
 =?utf-8?B?bnVJRCtuVjg1TFA4aE1lSXBlL0lmME5sQnJPU2ljL3lsSU5rM0ZRaWMxNDZy?=
 =?utf-8?B?QmNBcysyR0dCcyszd1U0MUdXVUt6KzNvMkdWQ2RkSDBhNlp5SnlUeTllN1ph?=
 =?utf-8?B?MkVPUUV5TEttTEtxdGc3OGxYOFU0UHRnQXRYREVCZndCUUxWSVNCdTRmYVh6?=
 =?utf-8?B?MDBQQ0ZrMEQ1ZDNlN3l6cURnL0U0Q3pyanVtOWl2L09QTVF1OEEzYm04cHB3?=
 =?utf-8?B?aWM2dThXVy9RckR4MHByVXcyV0pyVVN1Y3N3R3RSWU9qNWRvVVY5WGJzZ2tN?=
 =?utf-8?B?VDBYUGhnWGZrZ0pBZnBIVnV4ek9WK0tBYmVtWmVJRk5zVm41QVRYN29BRjUw?=
 =?utf-8?B?YXdocW5NRzU5S044UVpHNGlIN0FqWFlhd3ZIMEkxV3REbVFpaHFtRm5EU09O?=
 =?utf-8?B?emlOS1dpOGZGYlZPdzJrdEVIZjhxK1hPd0NNZmN5U1ZBbG5IcGNOWVN3L2JT?=
 =?utf-8?B?RG5vbC9OQktCRnFteER6c1BpZ0JKWTNzS2Y3eDB1b21PZWdvOG9zUHh4SjRP?=
 =?utf-8?B?aEVZNEV5cmVaRDhDS2o4ZmRmV2poOXpYNTExdkNGelB4eHF6eUUrazU5eGhv?=
 =?utf-8?B?SDl5QjlrSVlPRHlOTnJGNjhITXByR3kwc1RNN05Hb0UrVXlWdXlpRk4yOVdK?=
 =?utf-8?B?MDRrTEhueUprb1Q4ejZiSEx2cEdmdFN5TTRaNzhmVHdybExUcCswTWhvRmEy?=
 =?utf-8?B?S0lyZnFrOFZTWlBXOVZrcU1wQ2RxcDBOK3VBczZadTlyM1ZmY0hHdWttbE9M?=
 =?utf-8?B?dzVOTWFkRWhQTUVNcm9LQzhJbU1GZDlFRGZTYnhmeG9KRFo1dzJuZk1uVFVZ?=
 =?utf-8?B?SjJ2NndvbUFnd0YyRUFwYkhaMGVNQ2U0SVdWcUpsTzRZTnY5d1pCRWlNSU1V?=
 =?utf-8?B?Ly9mSUVEaFV6UG4wV2dvaFFENG1Jd1E4bEZJUXJJSFlNckZWK2UrMHVPUGxn?=
 =?utf-8?B?NmkvcE81Tkg3QjJPSnV2Rzg5UnVWUzVkRStvQzc4VTErV1VXT2I4WkVGbTdR?=
 =?utf-8?B?ZTByTVpQN091aDdVbnZKL1N5aG5TTVRWbkQ2UHB3SWhjSFVSc1VaaWNuUjJJ?=
 =?utf-8?B?L3VZQlRtUlJJRWxUeERpVTJxdTN5dVczb2lJbnVjcnlKTEtOeUVaQk4zQWVp?=
 =?utf-8?B?eE16MWJZUHpLSHlHTWdDZFFOMUhqeTJzRUZVWklFOUZRNVFrd2sxNndMcXNi?=
 =?utf-8?Q?T86taPM173q2x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnRPTHFnWENySEUwY21OeUdkbnpXd2swUTRBbnV3NjRDUEtZTnZXL3MyRFQ3?=
 =?utf-8?B?QjUvYlhsNEtGM1gzczlwS0VhTlJWTWIrYjhZaUwvM1JGb01DVVRUSFhiY1NM?=
 =?utf-8?B?aS9RTytlaENqblNSemtXeGxiRjVKMFBNN3RsWmE4dmVMdVgycjZYbE81RHBQ?=
 =?utf-8?B?aWo2bEl0TmlKT0JZTG1YOGZUcnBjTTJVQjcxME9QVTJMTkxLY0N1Q3NaVEFR?=
 =?utf-8?B?ZzduZ0NBVjRRd2hZUVVGS0l1N29CYWZxbTc3MVFxejR0TzYvelBFWUpreEMy?=
 =?utf-8?B?YXJpa1pEZkhPQTNFbTMyL0RCL2VGRHA2Z29xMmJNUVJiak93TEFiUHowZlJo?=
 =?utf-8?B?alZKTkdkbGpTYXdrWFpScVpWMGZJLzBpcnpGWGFwaklvTWhkZDFTMW9zQWtL?=
 =?utf-8?B?Z0VrYUwzNGJPZDFObSt4NzhWQS9QUFJrVElLYXl3WmlKR0NSZUY4cE5FRC90?=
 =?utf-8?B?SDFjaDNXZ3o1RXZOK1dIVWhrTHdmS1p6emMyMUlOLy9ZVVBxZUllejNZUlpR?=
 =?utf-8?B?S2tUeGJuZkJmc3ROcDBCZ0Fvak9hTTV5NzJUU3FKY2VkQnZjSElVZGJTRnhm?=
 =?utf-8?B?WTRmVnlZbWROb1JDVkxvNGdCU0l1QXk5OElxWWxiS0ZORUNTOWhyejJlVDdE?=
 =?utf-8?B?azFUeTIyLy9iUlpHRitTMDVyeEVnOGYrMnYrazRHcFUzQXJwMlVpL2lENUtu?=
 =?utf-8?B?c0todC9oVlB0L2ZmcHdUV1lVSEtJekE5b2k1RVh3S1l1dEN4TlZOWUR0S2RD?=
 =?utf-8?B?TU9SVkNCbGRsMFEzcnNLVGRGenYxa2d3UUhRSTFQWnJ4cU9oSnhiVGZKLzVP?=
 =?utf-8?B?RWhSQjFTK2kxTHpMRFRXYi82bXBjTmJmYitDOHVUMWU2Q3FRNzh0Y0JDVzZD?=
 =?utf-8?B?YlFLM3p4ZDhJRFhNcGVVMktVdE80andjSkRHVzZQa3pzcFhML2E2bkhBRytm?=
 =?utf-8?B?OUhXMDQvby8yZkRKN2d1cjJpMEZOazVZYU5xajBiTzh3SFlTTFlQRnF1dGJt?=
 =?utf-8?B?NXpFdkdiU2xLMXBCTm5aenk5cWtDVklKb3RNSkY5VTZGc1ppRDRqc1UxNEMw?=
 =?utf-8?B?UzQreFc2NExlS2V3b2paQ2RSMjI0Vy9qNnkzbWx3L0NiSGJIMnVENThNRWkr?=
 =?utf-8?B?RlhIYmEwSU12MkdXamw1dTdNMFBYRGRGdUJLMHVWbzlyUUU0MVBsZmNsNGxR?=
 =?utf-8?B?eVc1czlqbGdtdFZFQXhvNFpqNDJZWlpwajNadndkazdrOHBQS0RNMHdadWRw?=
 =?utf-8?B?K09hcTZKQ0J6d21XQzU5MHE1elkyTTUwTWVHQVRNMDBZc0xzWFNhb1JhZXZM?=
 =?utf-8?B?eDZhNVhvL3hGZ2JqUlFYQkZUNjRsUDlVbGc4cjU2VXNsS3d1dnhnN1BKYUU4?=
 =?utf-8?B?M0RuR0M2RCs4WHVYUUdROHBMNFU2QldRa1BGRzRLTHBiZEVFbktTUGQwYWJN?=
 =?utf-8?B?dXpxWnp6ZEJVUWhXbDA4a3pzckY0aDFPTTMxRDN5RUVyT2htMUlSTktUeXZy?=
 =?utf-8?B?bk4vVzNlZjYyRU95YWo1N1huRnAzdkdvWlJ0eVZWckwwWVNtZVRlbW5URDEy?=
 =?utf-8?B?blhLTExQRHFtOWtKNjJ2WldDWUFwK3pGanJNako5L0ljVUNPbU0vNHhhMjhV?=
 =?utf-8?B?eWJIMDVJYnpVSitpQkZsZ0FyMFdMSVpJMHpISVhaTURneGZXYTFLSDNTYXpj?=
 =?utf-8?B?MExueU0ralBEbXU4NWdVQkhIQTVpZjZIVEhSU253anVVeDBiWGMwbm1mV0hG?=
 =?utf-8?B?WWZLNjhVWjNna1FXVktzeG4rSjZ0dk14Q1haRnVIbHo0S1dvcjlrMnNLQ25Z?=
 =?utf-8?B?R3dPR3doNkpqcVlWem1ocis1MGo4dEtkV0VLU0F0dFVsOTZCendFQUVQZ2xF?=
 =?utf-8?B?S0RIUG81U1hBY3gzQndDOFBPdzM5M213dldyUFU2MnRSUWFyd2dDZURRRVpm?=
 =?utf-8?B?N0g2YkYzQUNnSmlpVmZCVnFicmUyRnN6WVdKUzVVUnRTQzBaQ2ozeFBSQWdQ?=
 =?utf-8?B?L3dad2pNMDBTRkJBWTNQdEZLREJLaWZVcUdrZWFYcFh2UDJMWWFMbDV4eDFT?=
 =?utf-8?B?SUFJUUNaQldHUm52cmVqa3dVZDJreWpIdXhxWjlvWGQwalUydWJaS1BsSXdG?=
 =?utf-8?Q?NtewUpuyrYpq6rdtMG6PO7ENh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87fe601-0425-4084-c60f-08dd78638836
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:11:44.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXIDfu5SH6/zBxcMHQSqyzXQwHcYLh74VWyb8xqHjTlZoi1+1Y8nGAZ3MXpeA/EzjTE94iaE39f09Dyo2px8wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039

On 4/10/25 12:28 AM, Christoph Hellwig wrote:
> On Wed, Apr 09, 2025 at 07:56:07PM -0700, John Hubbard wrote:
>> This topic always worries me, because the original problem with
>> dirty pages is still unfixed: setting pages dirty upon unpinning
>> is both widely done (last time I checked), and yet broken, because
>> it doesn't do a mkdirty() call to set up writeback buffers.
>>
>> The solution always seemed to point toward "get a file lease on that
>> range, before pinning", but it's a contentious design area to say
>> the least.
> 
> For the bio based direct I/O implementations we do set the pages
> dirty before starting I/O using bio_set_pages_dirty, which uses
> folio_mark_dirty and thus calls into the file systems using
> ->dirty_folio.  But we also do a second pass on I/O completion
> before the buffers are unpinned.  Which I think now that we pin
> the folios is superfluous.
> 

Oh actually I think I was wrong in my earlier reply about clearing
the dirty bit. Because in Jan Kara's original bug report, what
happened was that periodic writeback came in while the pages
were pinned, and cleared the dirty bit--and also deleted the
page buffers (file system specific behavior) that are required
for writeback.

So then later when the pages are unpinned and marked dirty,
that causes the next writeback to fail in an unexpected way
(it used to cause ext4 BUG checks, in fact).

So the problem here is that these pinned pages can get cleaned
while they are pinned, and then dirtied again by DMA (invisible
to the filesystem).

thanks,
-- 
John Hubbard

