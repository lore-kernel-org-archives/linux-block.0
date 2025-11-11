Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31029CA6F
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876852; cv=fail; b=SYpYdHbPw4vuSv0hrD8koYXM/lBdBakCd8F685F7XfzLGCdVCua0Xlsm5BhT9MwrSdgpn283c++xNrhl3zXARup0HwJRTat8EfHgNdNBkjo8shSVmuzQmNATDVgKQCB4lu3Z/5pxy7Kbf42FyfEuc3TnJLuLy9GkE+/O2F8GGkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876852; c=relaxed/simple;
	bh=96zW/mBiUgs1x9kcvJfg/W7e4FmTHQEN149zSUgI9HM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SKDoaEpYatj9iLRYcptEnvPbGdtZs+SVOiAkFgTIxuzptk0a4VqxDVCxVeZ7ICVkekCM5rNUzsAL3NA4ixqiVmw8Ni0idQZkomGdgjDGvCxNDBflcr6JBmBALEqPr1uE4gspeA8Fx5Yz6NL1KO4eopwQskkinbU7G69JWh8q7CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WPz3nM0H; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WPz3nM0H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL9JJ1udPjcmkPPnqpqbNwxMkhyr77mdxTArzf/FDKztOq/ZKO/5rt+5o4rHKmKb3hGzAWQgrHHCoHs+ryfr07vModSVOQAEUPbt3QruMVHHpt/cbBEEGR2xsPVasZqidrstBqMZX+fVEoD1V15qVZyJiYc/KtgyUS1MZGtE25rsghK2xjRfiKSL5kcw2QSJm9D9BFXKCJGQObaeu224yI2bOR6xjHGT2MUKlO0OmrLYPBKsKh2cGLSFtA5LuUyz1KHfi/vbhTKYkgHlUfAz/PXDOtXSMp/5J2hN6ADlYhEps6meu+1W1Sh8xr6X3/o+n1hmUW1KM27tmodiEjVJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96zW/mBiUgs1x9kcvJfg/W7e4FmTHQEN149zSUgI9HM=;
 b=wB6DqRg94b8bt85ZpgLnX9xFM9FKO6EzDXq2JNUsmXy+AYXswPeGyNk9HyX3MIHKVqhx0ixIgRBa5KhqpsNMDurailp8BJ+J6RG65q0ZoNY2m1lkzRdAITgRAGtPDcY54u+25h1FeZtlADc3YIa+DHKkWGOwlmu94/JonTfXX1Xw1cQY+w93WZE2r7Kxihod8eRLHsxIzxp+un8xHlUOOPqo+2T/KhnwsvHrzmkpuef8/aya25fuF/lnFQK0UUFxjVj48vY70ZFxnf0Tb9ZCw26NYOu6TLU8rMC+SoASsh7Q9B97lF88kKF9YeccvNB8QwBFz/0AN662mii4Nr+Byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96zW/mBiUgs1x9kcvJfg/W7e4FmTHQEN149zSUgI9HM=;
 b=WPz3nM0H+5AxBvoJRhcF0LgKQZVykgLQWK5fFaFyLwZZUXMVNtIQPZiyiS+ZxIeXxdX8sIR2p2qsAAj0tyRYL1ZxBI1HcMah90jBn17OwSpjYda73GB7Oshjv72Rx7tIO6EkvMVUoFEmGlXOZPW5wUS638uIvxzNwoSCcuZHzyV41mq1wRITjvuzx/ynTolfumgIgFaxZ505VexvVgvp0rmA7uipXydwZuVxWkmDnW24jBT5uNXwHG46PvDtPPAgY8jM2odkFvdtSQ7OdsZ3tPgpprnABPwa3XOlOV0Y5R51qjtDFH1JLdHIVoESCQH1NGaJMbHzpxlWxvoutGly5w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 16:00:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 16:00:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@lst.de" <hch@lst.de>
CC: "yukuai@fnnas.com" <yukuai@fnnas.com>, Keith Busch <kbusch@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] block: fix merging data-less bios
Thread-Topic: [PATCH] block: fix merging data-less bios
Thread-Index: AQHcUxTNIvE+bfG0+UqA4lzEJhaLDbTtooQA
Date: Tue, 11 Nov 2025 16:00:47 +0000
Message-ID: <a4cca7d2-dbb2-482c-b8a9-7965520e06ab@nvidia.com>
References: <20251111140620.2606536-1-kbusch@meta.com>
In-Reply-To: <20251111140620.2606536-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB7458:EE_
x-ms-office365-filtering-correlation-id: 29bdb125-9f59-4d3c-961b-08de213b7a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0xKbHRYZml4SStrdityS3lwcWtLdTZPTW9OQ3hDQk0wZGt4SldESTByMHMr?=
 =?utf-8?B?Q1RPZEJqSHJEWm1jYzNzbXBSMDVaVmRKNzlxblYvdmZoMzlzRnVnbnU5NHJp?=
 =?utf-8?B?eTRpSy9WSHZ2ZUVkUk8xaUR6RG9lWFFzRjhrS1NOZWMvQko0TVBOYVR6RERH?=
 =?utf-8?B?dFYrRUY3bktrc05aR1VEV00vUTZhMWJlWUt5UjY1eUE1eXdJVmViWlZwS1M0?=
 =?utf-8?B?cFpLSzZ6V0dpKytreEpqMmpWL1lDWFBVYWc3Sy9OVXZrUDdTZmpoeFJ1TDdy?=
 =?utf-8?B?b0ZUTUNxNjYydkdFVUhTdmpKWlZ6UDFiUGo3cHk1c3VuVDNyWUE4TkxBYkJL?=
 =?utf-8?B?YlZseGg3TVNqcUVGU1B5Ty81R0lIZ3NoTm9WK3hiU3JHRVZqbXBQVlFobE5N?=
 =?utf-8?B?bzNqWVNaR2llMVRUYzh1MndrVENuN1BQUUpzYkptQkpOYWViVTZKTWhSdWFY?=
 =?utf-8?B?QzUvNFlpQzJOQmV1QzkyOEViSXhmVjhXOGU0THlxUGg4NWNPV1pZSlZoN3h0?=
 =?utf-8?B?T2RSdjRrZDZtZ2FzazBiWkVNcWFTREgxRytLVHhZTU9WZkVMQjlwNWgzTWE2?=
 =?utf-8?B?YTEwcDhhWENDcThOcnYvSkZ1SExKMUJCMWR2NHhxdU9yby9lYlJ4YmRHUVBY?=
 =?utf-8?B?dWQ1WnhvSDRDTS92TkpzdnNqSTNqOWlyY3JTNzZWcHJZaFRqck8yeGcyajVY?=
 =?utf-8?B?SXpybGJtYkxyU2J0dlJ3YzVkdVhoL3RCb1pNeE0xSGcreXpVQVNhUnFQTDVk?=
 =?utf-8?B?M3daRW0rYUEvTzFCTEVva2g3MzhkdkszUXVaT0hFN0xQdWR3eEoySkNQdi9x?=
 =?utf-8?B?SWVIWjBodmxqMmRRWFdZTzBEQ0pmTlMxb1dSS2xsTjloYmVJSmJTTTB6VjVu?=
 =?utf-8?B?Vm56bFdDUFdDNDVjWE9aNDhsY1lUTk1ld1A3R2Z4Y3VBeHFrUUcvMGtaOVM5?=
 =?utf-8?B?UmtpNm9DOU0vRmhROVgvUVRMTXVHbTJWdW8xZCtCUms0TkhCcVBlNU1zSUth?=
 =?utf-8?B?QTZvc09OQU9LcS9jZU5hRjBOdmZheE5iR2VqYVlMdGlaQ0hSM01MNklYVnNt?=
 =?utf-8?B?ZitDK0VVbE9nR1ZTRlVmQTZZMVNzVGhrQ1dvV2YyWm5JTTZ2ellCaUk3L1dx?=
 =?utf-8?B?SWJiQzNNSFZOWWE1bjFRU0ZIc1JaaG9yYzB4RkJMUWNiVFc5TVFQR0FidkNX?=
 =?utf-8?B?YkRwVFRoNnBLSHJ5akxsUEs1TEExUWdnVkdlejB2a2VENnF1VE9tYnNvREN1?=
 =?utf-8?B?SkpjVHVKaTJEZW5ySE9kdTVETEI4SXVNZHlSOUFWNGt6Qko0YTRvT1pmVy9P?=
 =?utf-8?B?WkcxdW1tbXBIaUhFRlpDUWp6aFMzMUVnKzFqS2ZvRFhGMmdlNWRFZXhjSDUy?=
 =?utf-8?B?aXZjdDN4cHNWbFI1Y0Z5N1M2UmZ1MVdZNC9tcDFGajFnMDE2VmZZb25Gd2ti?=
 =?utf-8?B?K0V4R0RNUFdWbU5JQ0FVMDZFUzd2dlJaUkpMYWJyM1p3WklmcVQ3ZkFoMTJZ?=
 =?utf-8?B?dFFvT3pTZ0dtNWtNaDR4UklrS3VpWDVjaEVlcU5TOEVMT3lxYW1KMEpIYjA4?=
 =?utf-8?B?MTFTM3AvMzAyUkFpY0F1SG0xNTcvWEMyUlhLNGNzbEJ5OCtUck4vR0FaNXAx?=
 =?utf-8?B?UGY5Tmd4eTF4a05ya2RKZmUyTjcvMUlKY29hSlBqKzBtSk8vcWpTa2pkYUNM?=
 =?utf-8?B?OTZqMW1ORnNQNVk4NC8yekxwVEw3ZWs0cEM0cElDLzU1Q1I5aEEwN2FtTkJr?=
 =?utf-8?B?V2sxVWR4MVpnTm5jN2RNTlR5R081QmtHSWcyUHJnSVM4djg0MUNoN3lmRHlI?=
 =?utf-8?B?RjRxL2xVaWtVS1N4V3RJSUw0VDhsc0FPcVJxT0UydVlGZVRrMWtoRWJnRVM2?=
 =?utf-8?B?QzU1cmZ0RkxjVEo3Q0tkdjhvaExaS1NVN21FS09NNlF0OFl5UEVrU0RDdEZZ?=
 =?utf-8?B?dnhsVTNkbWN2aFhicXQrVmc4VlVGYUtMZW1NQ2c4ZnNVRHdpNjJUS1ZHSHpC?=
 =?utf-8?B?VmZxN0VjS0JQWDhWa2pQYUR1blJka09WWnZEQ09Melgwb2RYN3gwREE0TnRw?=
 =?utf-8?Q?t+fXdE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1kzN1dla205akdnL3p4djNXWGNuZ3hZZW94ME1xUnZkT1k1WFhZWGNFUE1q?=
 =?utf-8?B?WW1ZS2RGTnNYbmY2Z3JaTWQ1U1gxa1kvT08yWDdsOXQzYjVYZDZ4V0duSGJl?=
 =?utf-8?B?aFdXcVJHa2N6L09BNjcySFpqN3VZb3l1M2dwSmxmajdiaFFjK1lyT0tRZ2I5?=
 =?utf-8?B?UU5XdkZ2amZld3pwbWNsSVI1VEt5L2NVUm5kSHE4UU45K2EySjE2c2F0a1Y0?=
 =?utf-8?B?aEw2MHZLaHY0K29ZM0JtQVUvNEo2SWUyY3VMSllyYkhEQXNEMFNUbFpOdUFN?=
 =?utf-8?B?Ylc5bDZWZmVWVlZWbFRLaVE4TzhLTVlFV0JETzVLRTA1ODh6cmZpUTFERHI1?=
 =?utf-8?B?djRaaE84R0ZsbUcwSDhEODV1M0E2QmJlSDU5Z2NUTUw5UG5scFA1WXl4UnNS?=
 =?utf-8?B?akdSVjdzWW4rSVdOS1VwOUVmMUlyL1RTajhRRmYyWXNrOHVpVGxnTFV1TGVH?=
 =?utf-8?B?S2VSS0lEblBkMFNYN1lQWEpmQXdYbVlZdGxoL0FVRU02ZEVmVUpISkd3R1Jv?=
 =?utf-8?B?S1BIazEwV3A2alVHOXZxZXc2RUlLbE9tNGt0K3h1bWFYQWMzaXVKTFcvaEUw?=
 =?utf-8?B?OUNjeXVDVENoRlhOYitRRWt4Y0IwOXlYMmxpTS9GdXU5ckhrVE5lVmRWNERy?=
 =?utf-8?B?RmhidlVOTnVhNkI2N1k2cnQ5MXozQWNsc21tMitpSnlBayt3V0s2YS9UWmdT?=
 =?utf-8?B?M3pPMEFSb0hFTzhHUWMxRTJJWTNrZlZoZndHTkRVL05tak5ZbzIrVURBa1VP?=
 =?utf-8?B?SnJTWERoc3RteU1IK29oRWtZOVU5bHl5b3pGTmZleHVVR1RwUDZsbndTQ2RQ?=
 =?utf-8?B?SUtUdUY5YlVLMjlWWER4cTFpN3I0R1hIOFhhUkpCRDFvK2dWalFkWWdFTlZi?=
 =?utf-8?B?THROeFJwb1lWTGFCVWhHcjBQOUkyQkgxd2IyOTYwOHU3YWdhaWw0OThGWmQ0?=
 =?utf-8?B?bjQwNWQxMXd1S0hFOG1lTndUYjVaRGYwWFlMZVNGbmtRR2VFaXhDNnlKd0dm?=
 =?utf-8?B?enJYUWkvblZZU1Z4SXNCN2dmSU9YV0M4a2pWZXJoRSs0L2NSNFBRRGJCY1di?=
 =?utf-8?B?OUtBcG1GSU01REFSV29uUFAvblV4TFRBQWJ6UnZQRjRwenhjeG5Rc01UcEww?=
 =?utf-8?B?RGZwSnEyTWd4VFFxR2VqUC94bmFuaDhYM3hPOHZxb0ZxUVhxQmd6UkU3NkQz?=
 =?utf-8?B?K1FHQkpGem81dEd1eSt0d3FSTEh5Nm1VNTZacTR5ekJJeFdLMkJLN2NPUk5P?=
 =?utf-8?B?aitjdWZxSHZGVkZmckhsVGNmNTdtUU0yZm9EMTZQNVFJM0lkQlAvek9FcGZk?=
 =?utf-8?B?NGRJSUFBSXdZRVZOOFFQUTdrSjZRZFhJdk5kVTdUelJMT3cySnpwRGRGRXoz?=
 =?utf-8?B?U0ZMcVVMdEtHVDZLcHY1dWE2WU0yWHh2NCtPakNKdXp0aVc4RmNHbXdOZEhX?=
 =?utf-8?B?TUR2T1pLWndJa0lTOGt1dHFxUUlUZXFqay9MNUhxbzBhTTRxRXBYRDlpUVFR?=
 =?utf-8?B?K0hUMEozUDBqOXJlZmg1ZUIyWUpPZnZENkFwWElTamtnVVJOcUN6TVd0bGVQ?=
 =?utf-8?B?LzRrdUdZTzNzRUY3aHFCemhsdTBUWUZsdnRTY1NrSzhTRkQxOWtDU0trYm5K?=
 =?utf-8?B?elZSbnhkKy9zTkdzNWxhbmZCdXdlQjdKN0psK3ZPZHMrR0RuZThIRGlKK3U2?=
 =?utf-8?B?eE5QWFRXUW9FNWgreEtSL1pJTzV2QU9vdi9Wa3pCYVdyV3JGVjZIRlY4S1Z4?=
 =?utf-8?B?alhvamRJdXUwVDJGenRmYUVod3ZqWDc2TFdEMDN0OG1qcmlTN0RKRnhXT0hw?=
 =?utf-8?B?Z1ZVbkpiVTlJWXNMdVppcmJjdjgzc2xGWkJoK2dFazBqLzRGMDlQWFpLa0hp?=
 =?utf-8?B?ZnpEMzhXOEZ3c3dKSXl1UGo4M3BrRHR0czhpWDllYUVHS08yV1NlNFhUMjJ2?=
 =?utf-8?B?cHdOV2JPdkNSSm1VRHhCbU5PWWQ2WUZEYlo1VTNPSVBBTmRoQmRVWE9hMEFF?=
 =?utf-8?B?OXhJNThhUWRIZ2grdFdlZ3VpL3BIMjNnNjJqd1hYMWNwUnFCREFLV0MydEQy?=
 =?utf-8?B?Q1NVdXU4aHBUS1ovanpoblJ5ZUlhTXQ0UWk3YlA3YVNmK05YN05BME01UVBR?=
 =?utf-8?B?aHYxc0hhOUFvTFhDVjQ2SUhCUURidVNtUDBLTkQxN0RLaFZnVEhDcGJYMjBx?=
 =?utf-8?Q?Qa3GSNRTIA+VZaq8gf2Z+yp72q1pmA8KxtIpaDNTnhap?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FF2AA74D2F3F3468FC4517CB0643D77@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bdb125-9f59-4d3c-961b-08de213b7a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 16:00:47.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYuW++cLAa5mmDu/PNBr84NX1lgteMZXPkPFReF/YUxOBLc8AfMoMlVwoSCbG42cEU67S4fd/99+81QRu6Dj6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

T24gMTEvMTEvMjUgMDY6MDYsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gVGhlIGRhdGEgc2VnbWVudCBnYXBzIHRoZSBibG9j
ayBsYXllciB0cmFja3MgZG9lc24ndCBhcHBseSB0byBiaW8ncyB0aGF0DQo+IGRvbid0IGhhdmUg
ZGF0YS4gU2tpcCBjYWxjdWxhdGluZyB0aGlzIHRvIGZpeCBhIE5VTEwgcG9pbnRlciBhY2Nlc3Mu
DQo+DQo+IEZpeGVzOiAyZjZiMjU2NWQ0M2NkYjUgKCJibG9jazogYWNjdW11bGF0ZSBtZW1vcnkg
c2VnbWVudCBnYXBzIHBlciBiaW8iKQ0KPiBSZXBvcnRlZC1ieTogTWF0dGhldyBXaWxjb3g8d2ls
bHlAaW5mcmFkZWFkLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2g8a2J1c2NoQGtl
cm5lbC5vcmc+DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
