Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5C2D94A4;
	Tue, 25 Nov 2025 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055731; cv=fail; b=i1w03ApSTP2rRv0pCMjy3N/7p9UePDJ7EaxlGxVnNeP4FgSmRk1tSvaaZ4fpSMQgM7tG9ZtyTEk+eElr5PSpkca2rinHaE9TxfDwmHP7huYUZlHTC/3pavvQjrz8erHkWMHAP/IadwDTiugYQ8mpCqKHOu5MiAjwalhDvUc1eGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055731; c=relaxed/simple;
	bh=HGeawjIii6XinwaKKvBNVvf2GGI3+eX+sP6TiyOpgw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CbPzgfeYeHKwML4t+nYMosC4n3bKy/nMFiGMNpjz0VKT2BtWX+q+dgE0XtEM3LqMPL0ED6lgipaxC5vk8EQ4EPuNOsX7PhXMDEfKS0QI+WFX/olxB8g6X1rytSWGOibEZYs5p4vmGdFEXEvqb1+mFX6MhK8b4lz2gBtLfJCxsv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uiu447+E; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uiu447+E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nH6sk72udrL80ECyx46+iZANXJvsrPoUnU74xEFuLhXu2NEOjc34lsy0tDeS8bPJUdALpsTakR1J9ON6Cf1lq2RmyD2S0mdLbbHeGbc3ozN+42EZK56Ee4ogHdDiupDXloD23H9ExcblJcBWR5LCwjimokBJGBDQ7RMySKNxcB55gWsPm4gsjtC5PFMkDoZbf/GlfF5cJiDzWaLa5Lj27EfUnkpj3taM163lt2I3lWfFZXBPpQv8zX5w0DEqIwNfxzLeO79hgEOPjpYIzW3OC3JHfURbcRmFeH62b2Xa9+gaFaT90tkBPyiQcjq7F0V3MQRsurdjnDkWvCZGF+y0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGeawjIii6XinwaKKvBNVvf2GGI3+eX+sP6TiyOpgw8=;
 b=R5hMO2Il8A+qy0EBVeESrqhg9RhMUReQQs6wEvW0JATh5THnhXljWzrvo/M6kWCaQ6KBaFJoVeKZHEhdgB/XugInb914WdhQSiucrmenEqeOkakAUwIQ2BbP7O7MYJqHk4oKTMQzLBpyuQ/ZU09nodozgHiyxNpe3KhkJqbr9LWZE93BQj2q77VEVaTGAERiyynjH0H25XQaOfPIzNiySyMOAdoAdjv/ytaq5WaTpGZA9Yusn3lt+jPn/94cdurq1b3lSC3H6giaQ6Qn58lZ5xFoOytsV6uRQwpnK0DikAulDlugh6DP6SoMKLlqpo3w1aIhzCMnGB29Dw4yWTnNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGeawjIii6XinwaKKvBNVvf2GGI3+eX+sP6TiyOpgw8=;
 b=Uiu447+ErOZPMRWCIUyY/kOUEz2IvpMZaslYnvAsxP3tr2VDc+bwilyYCGMzFtf06oJv+H7RTjSKz/ygk/HoXJPw5TpD81h4qYOlG3qhR49BGbkduNrtiAEs6QvgX31ixDlgdlSsSnN3GeqF16ZGxT1vM0OwMJxuMJ44jlJ++/P987qNWSOlrd1lhZqqt3hKCTVDIEPSx7q8Oa5CJkF9whyob2S4xsN+/WAzwT/uDAjZGCXwGPJBfKSq1FlGn3sCUZkco8cMfAzyPuRs6snn0wQXv6PGe8QKmAjeEAv0zsck8CWPhz/Z0tNFj4Fvxl/Z1nAv2/Q7kEx9+hrygLRemA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:28:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 07:28:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"hare@suse.de" <hare@suse.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "wagi@kernel.org" <wagi@kernel.org>,
	"mpatocka@redhat.com" <mpatocka@redhat.com>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "xni@redhat.com" <xni@redhat.com>,
	"linan122@huawei.com" <linan122@huawei.com>, "bmarzins@redhat.com"
	<bmarzins@redhat.com>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"edumazet@google.com" <edumazet@google.com>, "ncardwell@google.com"
	<ncardwell@google.com>, "kuniyu@google.com" <kuniyu@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
Thread-Topic: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
Thread-Index: AQHcXdJwmfeHKI6FyUaXMwBCO9A9fbUC7Y6AgAAREIA=
Date: Tue, 25 Nov 2025 07:28:45 +0000
Message-ID: <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
 <aSVMXYCiEGpETx-X@infradead.org>
In-Reply-To: <aSVMXYCiEGpETx-X@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7198:EE_
x-ms-office365-filtering-correlation-id: bcae302a-2b0f-418b-f8f6-08de2bf444ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFRPazdyMEFBT1JVSW54Qlp6eiswZWZITTM1RnJyOFpZMWpXOWM3VFRlL3dj?=
 =?utf-8?B?MGNScVpyNFg5R2tJaTVKNkxiNG1oYTNGalVlZkIvVTN3ekJaKzNFbzIvODBC?=
 =?utf-8?B?dGp5M1dQYlU0TlowdkF6UlhMN3RPN0laQTNZZnB3ODNtaXRiUkpqWXB2M3VE?=
 =?utf-8?B?L0hnRWZiVUNpVnNVaU5Qa3VZdHBONmViUTJXbmRHem1rdmVrN1hFUmNGeEtu?=
 =?utf-8?B?K1NaM3N3M2lITW5kc0hpRlhjYWRvSnpPSDZaTnlPTHR5cjA1WTRMOXhDalBT?=
 =?utf-8?B?ekJGdFVuVDFyamZFZzhUZ3cycVVnUE1obVpGVitUaDNhOGU0WklKK1RGNzIy?=
 =?utf-8?B?VjN1cG83eEZ5WkxxdGlXSUZSczRsdW5CU0d1dkkzM2x4SzQvc3RoQ0RlY20z?=
 =?utf-8?B?a0lLc3hxSGROamdUQlN4cXM1TWE0WStmUFFxcVYyOWFCMkNCdWJ1d3ZPWG5D?=
 =?utf-8?B?RjdwQlNCTElJSXZKNHdtLzlxaGc3T1pTUmpwVWJLYUFESWJadS9DenJHRVRi?=
 =?utf-8?B?aGZ4VVpaOURuR2QxWUljcmt3TnVnOWFkbmZ2WDZKVmhZSlUwWit2UTlZRTho?=
 =?utf-8?B?Zk9wWm9aMVltODZXRjY0TFJPSTRiblc1K3Y5ZWhIci9sQ2xzTXNtY3BNKzdO?=
 =?utf-8?B?TysycnU5am5wUUVXMk5INE1VSEwvR2luMldkNGZ0ZEc1R1ZacHpZT01TdGQ4?=
 =?utf-8?B?KzNDMXp0QXozNW9XdTQzbjhBVC9BcitOazdqSlp1UlU1dloyTUcvVWhMTjQx?=
 =?utf-8?B?dHdIYk9FU2Jzdm5oYlhqa253R1pRODJ4ZWMzSUNpNDdnRkI4ZEVDWTRSZEhw?=
 =?utf-8?B?a21HaTl6WnlLUVpXMVBPUDZIUjNQRVVZSzZYVnhDdXhHQ2g5YmpRVkNSd21U?=
 =?utf-8?B?c215UzN4L0UrckxIN2t4WFVHRmd6R0dDOGhRL282MVRQK1R3NVlUZExXbXVj?=
 =?utf-8?B?RGlLUW01L05vM0Erc1hLK0E1eXRJcnFZclVxem12R21DTC9zNzlqLy9JbGY2?=
 =?utf-8?B?L3FacWwyL1NmTFExLytQRmhuMGxnU3A0d2dKNVQ1aDFKRFlIVlJJRFBQNkl3?=
 =?utf-8?B?T1U4ZHVpS3U1dCsxdXZtUnZkeXcvWVRsNnpESEdkLzRMOXNRalNPc0hYbE0v?=
 =?utf-8?B?N2hGOXBIMkM5SnFFRjBRTzJnS0Z5clNBTHJ6WkRkcG85Y2t0TSsyUldpUDFJ?=
 =?utf-8?B?Y0YxYlAvZFJWUkl1T1pxMmQ4TWd6SzFhK01ib3MzTWIxWmdZRDZHL2lpeHpX?=
 =?utf-8?B?bjhGcWRkUi9BVG80ajFreHluaU5tdjBiY1FvVGd0Um91TDdZRXVuWFJFYnFG?=
 =?utf-8?B?WjFZN1dncVF6OEZYenZuUURtYUpmSGM2MVJNQkhielFBVTluWnNWblVGZTIv?=
 =?utf-8?B?bE9kNmdZaGd3Z1lTeWNHYVdvbVJUL3g0SjZacFlmSW5iUFBtN1k4WlN6eE8v?=
 =?utf-8?B?dkhzTk9Gdnpod2w5Z210VVlZYitBTGF6QTdTVEdKYjhkQ2F2MjFRWXlXaXZo?=
 =?utf-8?B?SXhLSnNtbzBSbHZ0cmVjOFF6c0djQUt0Qld2aGgydEpaYnUxKzRLNFVxd2ho?=
 =?utf-8?B?aGRzenpEemdzcHFhUUdqWFJIQVdaZWRMRWlHWmJhbUttc0pmcGNMdGF0Q3Bu?=
 =?utf-8?B?QnUvWGtyZE5GUm1pSW1zT2p4WjhOSGtEQTlCUHlJeWY1T3pHcG5Ga2k1djZY?=
 =?utf-8?B?OG02cGNhVmpsR3BGQ21IbjNRR3VWQWxqSzZTQTBoUjdxY21hem1wYlRsazR4?=
 =?utf-8?B?enJ5L3QrWjhtY1dURTdtU2gwdGFFYm1oMWNGVldQS2FPOVN3R3BFY3Y4eG5N?=
 =?utf-8?B?WU1lVkc5WmdlUEt3UnBUUE9QZG9YaEg0bVJlRkRCNlhPZlp0L29rMDdmanB5?=
 =?utf-8?B?ckkyc2JZbHkvWHVoY1BaWkpFd0ZOYlM5d0N1WGJicVcxNUpLMFpBZExLZzJl?=
 =?utf-8?B?L1FTTkJ3WEtGUWQxNjdkb2lzcC82Q3hCOGkyZlRzVUs4UlZ0R0ZDa2VJVXhP?=
 =?utf-8?B?dnVvT05XSXpST29CVUpnOEtvd3pCZkhjU2IwRUUwWGhLdnNDZUNTeXlYUkdv?=
 =?utf-8?Q?snkFtn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHhIOWpjKzJxVERTUWhRbjZ0a2dNZUEwOU1qdXNGTWdRMjRML3hNa29IaHp3?=
 =?utf-8?B?ZldPampCZEVicHhyNDVsUDRBUldZVjlMQWZycmVpVmhIMDFCR0dVWGFvSEtY?=
 =?utf-8?B?ZjczUnlESmpMbDZJY0RWRy9UZkFybWV2RWxJV3gwbjljTVB2aG5TeXg5S0ND?=
 =?utf-8?B?UFpnY1ptWmF2WnYxdWV1V1RqdFl6ZGIwbDArQlJ2R2cwNGRSUkV1MWVaMExm?=
 =?utf-8?B?Y1RSQ1FpOXpZN0dMWFk4aXlFcTNMT2w2eEdPSE5xQ3JRVEhrbXZIVjhEV2FR?=
 =?utf-8?B?VklnckRXejltdzBMNVVTQkhxaHZqanEzTTNQUmdCUmcyaWl0U1Y3TlhLSjJV?=
 =?utf-8?B?Q1NLdGpsUkt1Z0VXR1ROY0ZZVkxQbFpkT3drTkNKWXlaNTY5eHViTHJNV0RY?=
 =?utf-8?B?YWM4WHZja0dQUGlMeklud2QvdktJVTJmUFhuUUF4eVVqS3hub2ZMK3l5M3Bh?=
 =?utf-8?B?azFkTW9neUsvWWFXTitSbENhUmdtQXBibm8yTXN4ZkNuSTUrejdPQkZIcEhp?=
 =?utf-8?B?UnNCMUd3L1RyNDRjL0Z3TDlwVENyQWo4anZaamV4MzlvWUxabThIb1JyeGNr?=
 =?utf-8?B?bTl5eW44NnRML2MrLys3MXVieXhMOHVueXFDZERqTnpVTjdVS1pXTmt5cmcr?=
 =?utf-8?B?RGM4MlhxZXRnY3hWa0VJOFpRbUpvRXhFYUNzMlB5WGpDb3ptVDU1VXdwWFlh?=
 =?utf-8?B?RVJ1Y2dxLzZreHRqVFd6b2Vwc2VQdHhHQ3B0N1NCVXR0YTZGWENZblFwK2xL?=
 =?utf-8?B?ckl0TlNwU0U5SWRhV1NvdmhjZVN0RThKQ1oxR1p5OVpIYy9UQ3BpTEI4RVcr?=
 =?utf-8?B?Zml4ZE13eFF5cVBxaUx0ak5Dbkc3VytxdjVGdll0VVR2OVlzYXhHbytWZUpv?=
 =?utf-8?B?bTFiNUFvd3plSkhpY3BWWUNvRlNNb1lLSHNVelZ3SG1TMlE0RWxyTmZNRnQz?=
 =?utf-8?B?Vlk0cWxpYnZLRG04dWpueFdid2NzdmtsWkk5ckg1TzducDdOekRsREduL0tP?=
 =?utf-8?B?ajNMZ29MMXkyZ080MktxV2ZwVCtHcThqeFVxOGE0QTBrNm5KbjJROUVRemNY?=
 =?utf-8?B?ZjlGSFkzbGpqcEgrbHBud3oyaVR1WDY2VjU2Y0JSYmwyS08vSSs5S3I5bHVB?=
 =?utf-8?B?YlE5Y1F5ZmtLNEhaMnJEMjNaRFMzc3V1NUdEMmlZQlN6MVdPdGJWY1dRVE9L?=
 =?utf-8?B?WktMWnBSMnloZmNuR1llc2l5ZlVUcGs5QXo0QzVEaHlmU09zTTBCTnEzbWw1?=
 =?utf-8?B?b1NIb2FHS2Y4UEpqNkNOVkJvek9xSjcyRnM3WDdjSGIySXBmTUgyR2Nyb3dv?=
 =?utf-8?B?SFN4dUhHRHRLd1lqWGR1Q0psa0pCY2N4WnJiZzEvaVZmSVNGNjFiWmlOVk9a?=
 =?utf-8?B?SDN4UlczOTJVODk2bSt6UENPd1VpTHVMUlBxdC8wZnh3VExxeFhJL3Jybkh5?=
 =?utf-8?B?Q1Y0eFFVRGtPYUZpMFBST2lreGdZeCsyelpoVFROQkxmLy9MbW1SNTlxZC9k?=
 =?utf-8?B?MmlwWW5MTkZ6TVRtckR5dzE5ZzFJNjNrMURWbU1vZ0lEb0dSNFAvRi9md1gr?=
 =?utf-8?B?czRjZ0UzVmJ0T1A3QjJVdFRTc2E1RXVFZ1JOOG1Cbk85d2VVUGhkZ3ZEbXY1?=
 =?utf-8?B?UEV3SG1UZkRmT1RYTkVHQUZYVnFWVWJmVThMdmd3bXNqTko5bUtidk1qQTQz?=
 =?utf-8?B?SlUrUWdmbkRvOUxqajZnSUJWM1lNK1dzS045Tm4vaVNSK080OWpSTWFrbEVp?=
 =?utf-8?B?VWtZTU1ZbXYxNVlKZkhzZUFHRFFDUStQN0I1dGNFSDI5U2srVWlYNGJMWjdJ?=
 =?utf-8?B?bVdLczhKbG5sZy9CWlRHd0xOOTRHcGt1UlVROVN3dlNEQUErbnFodGlPVy9l?=
 =?utf-8?B?eXVRUUFac3Nrclc3aGlZWlNLVWtoek55M0ZyY2VQVVcrYkJ3M3dnb05BSEl2?=
 =?utf-8?B?MWtVWXZtL2V2SWx6UXRTYWU2ZXBOWUdNMUp2SlROUmpvZld6d3BCVGIwYkJJ?=
 =?utf-8?B?RkhCcnlweWoyTEFQRTJ6V09yUEE4ZUF4d0hDYmFtRUJsOW95MXQxOHpOeFhi?=
 =?utf-8?B?Z28vZ2svVytlbms1ZGU2OXF3ZHkvYWxpNTIxUEVGVnhFdmhCaUowNVlVTXZv?=
 =?utf-8?B?cjJsS1NpQ1czTUl0RGFHai9oTTY4RmxYK1Jib2haNGlqajJqVVlaNFFFN3lN?=
 =?utf-8?Q?zBsSVAtzpkcgMi0nkyxKBeKrDmyoF2thko3+ENYPKykt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA7D046C4A233D4AA8474457FA6353D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcae302a-2b0f-418b-f8f6-08de2bf444ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 07:28:45.9537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWrf6T5mbpkFU0pMxlZ2d1TGPWXIXmryi2r0pKj7iwsrlkHYrfTuui08IcIK6BUIvF9CBiqmSEPzZ7tjTCX6mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

T24gMTEvMjQvMjUgMjI6MjcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBJIGRvbid0IHRo
aW5rIEdGUF9BVE9NSUMgaXMgcmlnaHQgaGVyZSwgeW91IHdhbnQgR0ZQX05PSU8uDQo+DQo+IEFu
ZCBqdXN0IHVzZSB0aGUgc2NvcGUgQVBJIHNvIHRoYXQgeW91IGRvbid0IGhhdmUgdG8gcGFzcyBh
IGdmcF90DQo+IHNldmVyYWwgbGF5ZXJzIGRvd24uDQo+DQo+DQphcmUgeW91IHNheWluZyBzb21l
dGhpbmcgbGlrZSB0aGlzID8NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5j
IGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCmluZGV4IDI5YWQ0NzM1ZmFjNi4uNTZkMGEzNzc3
YTRkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCisrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3RjcC5jDQpAQCAtMTQzOCwxNyArMTQzOCwyOCBAQCBzdGF0aWMgdm9pZCBudm1l
X3RjcF9mcmVlX3F1ZXVlKHN0cnVjdCBudm1lX2N0cmwgKm5jdHJsLCBpbnQgcWlkKQ0KICAJc3Ry
dWN0IG52bWVfdGNwX2N0cmwgKmN0cmwgPSB0b190Y3BfY3RybChuY3RybCk7DQogIAlzdHJ1Y3Qg
bnZtZV90Y3BfcXVldWUgKnF1ZXVlID0gJmN0cmwtPnF1ZXVlc1txaWRdOw0KICAJdW5zaWduZWQg
aW50IG5vcmVjbGFpbV9mbGFnOw0KKwl1bnNpZ25lZCBpbnQgbm9pb19mbGFnOw0KICANCiAgCWlm
ICghdGVzdF9hbmRfY2xlYXJfYml0KE5WTUVfVENQX1FfQUxMT0NBVEVELCAmcXVldWUtPmZsYWdz
KSkNCiAgCQlyZXR1cm47DQogIA0KICAJcGFnZV9mcmFnX2NhY2hlX2RyYWluKCZxdWV1ZS0+cGZf
Y2FjaGUpOw0KICANCisJLyoqDQorCSAqIFByZXZlbnQgbWVtb3J5IHJlY2xhaW0gZnJvbSB0cmln
Z2VyaW5nIGJsb2NrIEkvTyBkdXJpbmcgc29ja2V0DQorCSAqIHRlYXJkb3duLiBUaGUgc29ja2V0
IHJlbGVhc2UgcGF0aCBmcHV0IC0+IHRjcF9jbG9zZSAtPg0KKwkgKiB0Y3BfZGlzY29ubmVjdCAt
PiB0Y3Bfc2VuZF9hY3RpdmVfcmVzZXQgbWF5IGFsbG9jYXRlIG1lbW9yeSwgYW5kDQorCSAqIGFs
bG93aW5nIHJlY2xhaW0gdG8gaXNzdWUgSS9PIGNvdWxkIGRlYWRsb2NrIGlmIHdlJ3JlIGJlaW5n
IGNhbGxlZA0KKwkgKiBmcm9tIGJsb2NrIGRldmljZSB0ZWFyZG93biAoZS5nLiwgZGVsX2dlbmRp
c2sgLT4gZWxldmF0b3IgY2xlYW51cCkNCisJICogd2hpY2ggaG9sZHMgbG9ja3MgdGhhdCB0aGUg
SS9PIGNvbXBsZXRpb24gcGF0aCBuZWVkcy4NCisJICovDQorCW5vaW9fZmxhZyA9IG1lbWFsbG9j
X25vaW9fc2F2ZSgpOw0KICAJbm9yZWNsYWltX2ZsYWcgPSBtZW1hbGxvY19ub3JlY2xhaW1fc2F2
ZSgpOw0KICAJLyogLT5zb2NrIHdpbGwgYmUgcmVsZWFzZWQgYnkgZnB1dCgpICovDQogIAlmcHV0
KHF1ZXVlLT5zb2NrLT5maWxlKTsNCiAgCXF1ZXVlLT5zb2NrID0gTlVMTDsNCiAgCW1lbWFsbG9j
X25vcmVjbGFpbV9yZXN0b3JlKG5vcmVjbGFpbV9mbGFnKTsNCisJbWVtYWxsb2Nfbm9pb19yZXN0
b3JlKG5vaW9fZmxhZyk7DQogIA0KICAJa2ZyZWUocXVldWUtPnBkdSk7DQogIAltdXRleF9kZXN0
cm95KCZxdWV1ZS0+c2VuZF9tdXRleCk7DQotLSANCjIuNDAuMA0KDQotY2sNCg0KDQo=
