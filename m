Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16904248898
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898584; cv=fail; b=ZJc9cJ5aSwXFoX3qHNgiwjYFOHY5rAV9ldy2Ia4dBqCvHzGa38LYA3cpULFVR/gl9J4SXnNzftYAJMyDK1SV7J91ijS5LxaLp7IE6yeDwT2DHrSGUvlZgcAME0Qn7xRD8/W/LY2SswVMsbI5Fpz/M3nja33qqYV/fXdB++lPrbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898584; c=relaxed/simple;
	bh=Cwt8YWe8Emk1mbuv8pWrwBqRKKioNtzhKSGPk4+b+mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uhTWD0MJVgBv4ymswRQVaDN3Vf0uEhW0a5Rddz/PUB8ahQYaniGVPq98PMKawK9p00ocUXbM9c7nSvu15slEJwbtnWNKLoQJOdYJVE0Bqiuou6ywsNhBNczM5yPOCLUgg56XoqunBmXjHy/ylVdsvXY38Hrl4EJpfrFQNUEARnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qj5zOHLg; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qj5zOHLg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWf+bRUz/T+ZHx5zlXiQGMe+ti53yrEy0CQLvOAZrrZ7y+xPzy7Pid0iVnC47a0dye7B4fi2oLn0lITlf+Mqbxw4wdmj5pY9CQ82xhTJawx6i/faQ7B1siqKDCx3gw7OwQXkwVluFMmFliK2H/8b84T+u0hBNGXLcm9DMbygb9t9TKwHQwfIh+vmnBwyPYs6ReYt4z/HgApPTORjp+iGsmWWLeH/NaEOkYbDTQL+PaZkTpIs3aUBrM2JInu4/AokM5qzmRp4tohWbYlJfAm/fP5FBvnYj2KwL+G4dwMk2FOJm0VFpMCcp1kdPoR7ra8oVNsTklZp6EAyzc/UApdAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cwt8YWe8Emk1mbuv8pWrwBqRKKioNtzhKSGPk4+b+mw=;
 b=xNzruz+zAWUZDUCc070v0+Sta97kO7YPQQs5f2YEzrnM6NLGipxAwS1IYtVaKgL5eDFFBRbsg4FUxtvzp+ETo0bMrtnlJWmg8gMHWNHwIOd8k30ry88a1QdaLFU6g9o97rIXzxqVcu/fh1Xjh9OhGfVnFjWE00NKJRMnjMOQiiJZSJhJlPvP1JijsUdNJwkAULg0+a8cXNcfw1UayBgt+LBckjnn/teAc1ycTVTE9dnVOI05UvUmv66jrzfqLCIXYa9GCHRX4Sf9r++n3xx65M1NiiGR0b1ARaiXVpH/y9ZBlV2BL1CXRKvwXL16PJh9FDNLWLFrgPMIDR6iAloATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwt8YWe8Emk1mbuv8pWrwBqRKKioNtzhKSGPk4+b+mw=;
 b=Qj5zOHLg3BjZb6SLdq8j5QgNILPw/itXTy4302NxLX03FoOCsP1Fxp7HZI5PIaS6SC0AiXrLJr577lsjUo2eUXuRQ1nUHNggcdQkmrxkBbB8VyNgHtsQ2b3OzlWfLk5x4lozvCa+v/7G85O0K7wYSlHJoRHDzToN+tIMvoQ4RySGna+cjV/fvpsLc6Qz5F43ur3zGwETibyZIi9iIbOuCR4Baw3U2dM2vttVZNcfmFWZyP9nIHiSU0xw0gNMbd17IvhcM8EhRbfuRt26IfRwF9u7WZjTlXkjjDt3SWXgxqZCmUPxMJIIZ9YzcLRxP1ArLHzYTsu+F1K8IlTt4WEE1g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 08:16:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:16:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Casey Chen <cachen@purestorage.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "yzhong@purestorage.com"
	<yzhong@purestorage.com>, "sconnor@purestorage.com"
	<sconnor@purestorage.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>, Ming Lei
	<ming.lei@redhat.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Thread-Topic: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Thread-Index: AQHcSRhauqXv7enrvU2FX6HoDAYwUrTZ2SIAgAB+qICAATllAIAAWdmA
Date: Fri, 31 Oct 2025 08:16:09 +0000
Message-ID: <fa540874-6d3d-4927-a51c-1488593c8d3d@nvidia.com>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com> <aQKzxpJp98Po_pch@kbusch-mbp>
 <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
 <aQQk6nWYeB71PBK_@kbusch-mbp>
In-Reply-To: <aQQk6nWYeB71PBK_@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA5PPFE3F7EF2AE:EE_
x-ms-office365-filtering-correlation-id: 973ccb8d-5e7a-47a3-c259-08de1855bf4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFk2c1BZQkp0MDVHck5Ob1NiK0xQeCtQSjQ1RHZoVWEyNjVJVEVveHhZTUFO?=
 =?utf-8?B?a1NDOWpNWndxb3BCeFBPRmpsdGdqRnVHdGZ0Y2FncGQyWGU3QlNpYmFXb2RG?=
 =?utf-8?B?VGx0ZDFOZC81L1ZOaldLUktmVU0xN1VoQU9IK0RZWHpaMy9QUE9qT2Zlcm90?=
 =?utf-8?B?TUp4dHhDa05zQlRCUDdvMFF1NHhWRjRram9VRXFxaXczeWlUS1Bzdi83eitw?=
 =?utf-8?B?UXo3N241QzhDYlBuSnl4cjloaGFaRWtseDJlQWtRUUFGVG40UVBvRlhVSWFM?=
 =?utf-8?B?Qk9oVU0zaTAvSmNlcVVhRGhrSWs2SEV0cEJKQ1YrUFh5aThhWHNVNCttamhp?=
 =?utf-8?B?WlJXNmFpKzhaOVBqai9LdkxtaTlpZFZMY2tjb2ZKazdUMis4bDRHVXlaZjAv?=
 =?utf-8?B?VFNaYkJ0TitaWUdUb09qS0VlL1pSMkZUR0FBeXZYaHhRSHVjL1dYcExDR3lK?=
 =?utf-8?B?UENFNXMvV1g0ZXc0L043Y2R5Tk1vT2hxRlBQVmFQb0YxMjhiMjZHUWVWMEJs?=
 =?utf-8?B?VVd4MEFnUGk3cEk5alZxb0g3cm1zU0ZmdnBtUHQ2QVpyK2pKRlh2M3hucEZQ?=
 =?utf-8?B?NEZOM1dNeDZEQlkxWitaZUw3QUJhcHRPVTZweHVvTlRPd010RzZ0UFEvcHZq?=
 =?utf-8?B?dU1NSnovaGcrZjFXYjZTY3lnYUlNZ0F3THRCMEdUbGRPdGJ0RU85cHM0MG04?=
 =?utf-8?B?aEVtbE9DUWNFMzFCaWxMNjNOVXUvbzBUcitwQTRPODZ6V2U1akJlQnI4Sm5D?=
 =?utf-8?B?bHNjRmJ0dkdFRnF2TmJ1TWRpS2dJd2V4NllSam0zeXZCOGdkdWw4MWNMMmdt?=
 =?utf-8?B?WXQ1SHBIdy9nMXdEK3pPcEYvQTJtZi9NUmROaS84eUlxMVZVTXFoMnh1Z1Rv?=
 =?utf-8?B?cTJnS1pJTGxXcWIvcm1NdVl5SVJlZHI5emdVb3BDOXBjQlhOZ05VaVp0ajd1?=
 =?utf-8?B?Uk5ib1BKVXVBOXBRaDZadVRyWlZxbDhmYmhram9IcHFSeE14cnMwUlA4RkhX?=
 =?utf-8?B?MytyR0RudG9XeG5hRld2YWZiYkJSak9zeDNId0FnMnpKdzlyVUxjbi9CT3Jq?=
 =?utf-8?B?TUwxcEtSRHNHRk9BNVd6VmFTeWVmM056QVZndk1JQk5WQ0oxSWwxVThlQm5G?=
 =?utf-8?B?RXROQkhGbllMQi9ndHBiaGNzbUlaS3kzbUFMOUxZODNDWG9IbGdpZmJYTVFR?=
 =?utf-8?B?OXM0NVg5WXZPYWZ0NEVyZWhQdHE0TWMzaHpyK0RoUC9hU1Nyais3SWN5QU1s?=
 =?utf-8?B?a0ZjOXdDa0xEMW16SG8vNnJIeU03Rkp4L1BZYVVpbmdzdjgwdGxmTDFXU1Jy?=
 =?utf-8?B?N0FiZHdUNVVZRGlqcjRqeDhqcmtaQ3U5VkVCRHVHb2pHMlBsalpNRnlScVZ3?=
 =?utf-8?B?TEthbFpXNDdGS3gzbTcyWlAyK0VBZGtGR0o2dlZlWm5USGFhMXVZeCtVMm5B?=
 =?utf-8?B?NXRmSkhoZEpPcnJPeXpnRjVPZVpiRnN6S2VKZXd6c1hUMHJBZVdxVURkeVFY?=
 =?utf-8?B?azRMNnlmYWI1MDd6QVIyNUJYRHRmRTZwR1FwNzBISUFOOVdKTDBWTWgrSGVO?=
 =?utf-8?B?VFlBbnNpWGY3Ry93NjdVTzl5UC9HNlBQSmxia1VMMndaR3U1NzVHMC9ZNGI2?=
 =?utf-8?B?NnI1WWU0eHg3MjBhZDJPSjE3UTZOM2hEVmxmdzBjMWtVc1ViREJRbTJrMTFP?=
 =?utf-8?B?UjZ4WUpxT3Y1V0pmaWZpR0NpWFZTQ1pENEtqbUxkOWlneE1ROEpZQ0FQbUZj?=
 =?utf-8?B?a1JmbFFWcHZwM1RCQkpSQ2RubmxFbzB5Snc2YXlRR0lJOVJWNU5yYUNUSzl2?=
 =?utf-8?B?VWhRR0M5Nmh5UGhMNGxOS1l0VHpCRFphc25VRHRRK0F2QmZvc3FwOENGL3Mx?=
 =?utf-8?B?WDlQS2YrVVFRRWZocmRZT2NScVNQbUM4a2p3K1Z6QzVVQ00zZnJ5bkd0U2NI?=
 =?utf-8?B?eDJSRkc4Qi9ES3QwNGhHUHAwWmJZY1FWRG90eDhHZmt0VTlacjExVkVYamdw?=
 =?utf-8?B?MldwaE1MdGhMMnM2T2E1WXpRRkZKME9oWXBaMmxLSXB3U0N4cTVSbkVSelBy?=
 =?utf-8?Q?ORr9ds?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVNJQnNDcUd0SlBqZFBhYWQ3OC9DeWo2UkhKRngzNDRjRVg0U1ZwdFBmWFhz?=
 =?utf-8?B?TnpkdzdmUTI1Tk1wS21LeFpKZ2cweTg1R3ZPSjRtVjNFVzQ3emxJMEFrTUxZ?=
 =?utf-8?B?TVdPWHhFTHFuUHZSV0l5NFhpRXBJSC9zNkwyM1J1SWlkeklyWm9EbHZnQWky?=
 =?utf-8?B?NjF6WWVoYlRjUEtjanNjM0ZOZTF6QWNGVkhUWGlkUGkvM3VzNGZ1RzVTUUV3?=
 =?utf-8?B?VFU3cnRnZENVd2k5eWdXbldxakRxRjdnVkl4SDYxV2RSeWF5QWR4L3NMWGRH?=
 =?utf-8?B?eThLeTJld1NXMjVnL1lYbG1jZzNrM0FNZHhiemFkZ2Z1b1djeHhoM2dFdkQw?=
 =?utf-8?B?MFZrenNLQWxTdlNrSWY4SE8wa1FmMm13MmpRK0pSa21MUVR0cGtDa0d1UmJs?=
 =?utf-8?B?TlZEeGZ5ZjRDVkhFMmIwMVRpcGZxMXJGbGpQeVVIZWJJQytTZTdacDh5eGxt?=
 =?utf-8?B?WE1mbmV2dllhOXg1dGQ3eWVlbFRtTlppeUczQS9XTStiQUVycW12T3QxSi9D?=
 =?utf-8?B?K1BJYkN5YkUrVVpzbmxmWlBvNU4rdWx4MkdxRjhQQlc4b1c3elVHTU5xZnpm?=
 =?utf-8?B?dGx2MDkvVnB3OW5HbHY0R2czVXh2SkFaVnF4Ynd1c1Zia3pMZ21IUWpyd2hh?=
 =?utf-8?B?NUF4NERidEZGc3FkT0hNakVSMURzdFo5cy96Ry9pcXYwMWxhMnBUMXhpQmJR?=
 =?utf-8?B?MExEZngrandCbG9WeGc5RlFsanlwMUFGMmcyOWE3c3EzM0dtU3BpOENXc0Rp?=
 =?utf-8?B?bVJ4ZHhId1ZLbnlTMkYzLytxUWVWa0VpY3lYV3ZYVVI0b1dzcHZseGhmeWxh?=
 =?utf-8?B?a283N0YrL0pFR0dEWWY5by9DSWJLWUc4dVhKK1hYbENLWkZsVmVNcXFFOUNO?=
 =?utf-8?B?RFNodS9rODV3U2lxU0w3Rm1jQWNOZHRzQk03ckwvUDBwbWt6RU4vMzF2SUNk?=
 =?utf-8?B?RDd6aTRnd05nTHhRenFaZVVRSGlCOElvRHplUFhKVmROUEVpbjN2elFmRkdY?=
 =?utf-8?B?N1FmbUhKTmdSdjZoYjhNTVF4VFRXQTVFYVZvNHMrUGlmNGs1MUc3L1ZxSjNh?=
 =?utf-8?B?QzZVZnVoZWhXNXNJMlpXSVVRWFVJQ0d0T3N0VlQ4SHJRcFVqOUUvYWkxUlJ3?=
 =?utf-8?B?cTg2NGwwRjdvb3NWV3hZcjQ2UVFGUmtLK0ZnZlVkaERYaVA5RGg0OGtnWDNq?=
 =?utf-8?B?bVBvNnlQSlpCanMxMzZQdHdZNGRqUmZreFp0YUtGWjExU0xJOU9kTStHWFJ0?=
 =?utf-8?B?Zk1wQUs2KzBpRzZPOC8zT0xhenJVdFBUeUZTR0NJM2dDdVVvNHhCdFJmOVVN?=
 =?utf-8?B?Wk5ySXBCamNhaHJIZTZQWms0VWNlSXFBQ2J5Q2RBdFpLN3VnakFtSk9HWXUw?=
 =?utf-8?B?enNtVzhNMTRneXAyK1pheG1NOXEybCtuY0tBMnBQRDdoUUFVRXpsT3d5emVa?=
 =?utf-8?B?QTBNVmRLZGFPa2praE5LQnEyRHhPcGp4djMwUzNVaWJVc20xUWhFTzRoa1NX?=
 =?utf-8?B?bGw4WnR4Y3Q2R2QyVThISnZzM2xJTlVIYXhWa0NCdFNhSk1yNjdBaXFNSlRt?=
 =?utf-8?B?My8yVWY4U1dHRmV1S21qeFl1TEhuZFptVU1vM2E4ZHkyRCtsd3REUlNZQWE3?=
 =?utf-8?B?L0FLVWpEQ2tQYlRYdVd3ZUc0WWJDVW9OUGY4TkczZGkyRUlsa3IwcXJEV1dP?=
 =?utf-8?B?ZDlxS3MrbGpKSUJBOFprZ1dWTFpiOVBQMnNvWEUzZWFrd2IrcHlBWlV5UGpB?=
 =?utf-8?B?djJLaElrWWxHRGl0V2FrUm5XWHBDUzJ5OTc1R1NRU2FiSks1NHl5Y3FkZDlh?=
 =?utf-8?B?OFVqNy9UNjU5Y3ZlcTZtSm9NTlZFYjVZYllFZTRaQjhnWEtnVE1QbjFmZm5r?=
 =?utf-8?B?NlZYTk4wWkxaS3laZ3hzZ1A5L0Y0RCsyV0UxVEdydkpsb0l5YTZBQkFxQ0pi?=
 =?utf-8?B?NTc2VHdjd3ZtWWxPRVYwdVAwRkdHSVVyOVdkS2U5Q0N6Q0tnRStueThCR3Bk?=
 =?utf-8?B?MkduTEZYS1ZDbkpnbkc3TTg3ZzUwVG12OGhGVUtrZGJlZjZwRVdCKzlvQi9m?=
 =?utf-8?B?dG8yOU13YXltcHlZZTd4V3RsZ3hOVTA4TGlKYXhoRlFPT1ZaWkt4UzNkMDVy?=
 =?utf-8?B?eHNBU1dqcC9RZDYvZThLVWxJQ1F2UElzN1Z0QjYzQ2ZPR2YxWjVKOS9XeVVH?=
 =?utf-8?Q?77GUgqPAmPLFJFsg9k2P+inYIPM7gzuZJDht6YNSpT2e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F89493CA535B145B8970802162EC749@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 973ccb8d-5e7a-47a3-c259-08de1855bf4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 08:16:09.3710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrfQfLvc87vi4yU9Kpt5L+0wLuaOvakoFs2N3qIakHyozFKLCDfmMhpuXpi5w0K0UgUM1dCoYKmsilTIscmm2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE

T24gMTAvMzAvMjUgMTk6NTQsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBUaHUsIE9jdCAzMCwg
MjAyNSBhdCAwODoxMjo1M0FNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBP
biAxMC8yOS8yNSAxNzozOSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+PiBJJ3ZlIGFkZGVkIHJlcXVp
cmVkIGNvbW1lbnRzIHRoYXQgYXJlIHZlcnkgbXVjaCBuZWVkZWQgaGVyZSwNCj4+IHRvdGFsbHkg
dW50ZXN0ZWQgOi0NCj4gSG9uZXN0bHkgdGhhdCBzZWVtcyBhIGJpdCB2ZXJib3NlLiBUaGUgY29k
ZSBtb3N0bHkgc3BlYWtzIGZvciBpdHNlbGYNCj4gd2l0aCB0aGlzIG1vdmU6IHRoZSBjb250cm9s
bGVyJ3MgcmVxdWVzdF9xdWV1ZSByZWZlcmVuY2UgcmVtYWlucyBhY3RpdmUNCj4gYXMgbG9uZyBh
cyB0aGVyZSdzIGFuIGFjdGl2ZSBjb250cm9sbGVyIHJlZmVyZW5jZS4NCg0KDQp3aGF0ZXZlciB3
b3JrcyBmb3IgZXZlcnlvbmUgOikuDQoNCi1jaw0KDQoNCg==
