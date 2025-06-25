Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B41367
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750825969; cv=fail; b=il4baoRcFyMh05sum4l7hOO+ZEGXxWd7uU9RAuxkBUI4w5hLKMNJYURD1e5ylffjjev4In4sc2FXzs0X+neqSfhQ9Dno6SkjT1LcGEcwx2LC96HyBPy8uJXX7oXgSoKZFD06Taz7djYOuDmGh58z6y9ZzN0SnxLGNN2iUMu6Yfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750825969; c=relaxed/simple;
	bh=COUyJYdG98sHhYYL/e7AD5f774AKsZNLBxanLxQgLg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d67C69z3cUyNvT0l5WCaJnbZjJEt6jfu/SRrpzs0J7mZJA8zqfRVdmHh4JSpceZd/gGu9lkoiBsUdhi+Fzukao5G4iC60GRXquCKYpxrxE5BlF5ISPR5ZupEtzyDkirjxKDCFo0G/FzI1KrRsnQCXj4aKVwyzjqRMplud6Z6gtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UPZu7h+7; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UPZu7h+7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQs6hApcCGweelIGfvmvul68zZ0OUJoRRs/qeO0j99CKQimLm7RhRUTP2E1H+ezNr0Z39yCsEOfJRG1JnVpL+FJvyyHbQhfPdmvRQ/pPl9pZ0CjLsfZJRiyUyNY4yh6LXZ8LY4QvPs4o30rtlbBVb/GZA3tVx65i/BGLsf3u2tnymH9xTGW9Qhy5z87D4AfeVkRM45BkPlusH4N33iXzkL7K92Hf1HWUWaBP5OyRDcsyxWfTnq8y6u6/ATF3gxL9xMUYDLqZ3GsO6Q6t09NxJIV8W/lJUcpHHxtWCuV6uWTp1/m+UMZ/Yp7knALd8loMRZWfAQPVA4EvbPVKfHcoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COUyJYdG98sHhYYL/e7AD5f774AKsZNLBxanLxQgLg0=;
 b=m76fZurBlsp30M7XCGX2tVpZYgJwUJGtNUxiS+hHtoDGStTKlwS36hxc1kcAfVr3Z6ouLVYxu+rpPzbimlYnUzFnKag9bHHmt1OZmcK4hCDyW0BzaXUcz0+ZfJaE9orcA9zfy4i8g4uxj3/JS+2raHU3PMm8Ai1ggS3YqUjoXzTi85/9yiVQq50kFIjD78qjHwCMR1Pfcm2A5iXBdouXk1oHgWTME/ao03EuTc435YrKPi+KgIAZHDhtJ1ypHWXm/SRiGZkAA9Ms7TLMjvOeEi9ZrlMnqZMswxYcKuHNIezYcA4fkHSUbe4p32osV1bSNee+c2sDoIXK/iUf8fV/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COUyJYdG98sHhYYL/e7AD5f774AKsZNLBxanLxQgLg0=;
 b=UPZu7h+7fb1Yk8vc+8PgBaQrNAgbfSCrJLJZQNZxLEp6Os+tpBftpcwCs2zFAVLl8oMsfe4PX5INMBObwbVSX4JuKvj6CTH7eEUVDlvARqMfbDgZfsnhz7Hp5hH2uVqnz4PulMZrEiAEKKauCv5InrjV7C8XxQ2+D0CJ3eZNrA6vdUmqOjHTlPppfzVaC0lpZLM142ro01qT/aiJdsEiMQpqLy+qR+OdXGd6XdFEBdr67gSEzyxoWEsXBAsfTM7zbouThgExrDWcCJJc5q13HigWDKrApm7DqYRA+UBVS8aqyiTUDQjvWbYMisQOi9psRVw88kH78TZBKyjbmzo2dg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 04:32:44 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 04:32:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Kanchan
 Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>, Nitesh Shetty
	<nj.shetty@samsung.com>, Logan Gunthorpe <logang@deltatee.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jens Axboe
	<axboe@kernel.dk>
Subject: Re: new DMA API conversion for nvme-pci v2
Thread-Topic: new DMA API conversion for nvme-pci v2
Thread-Index: AQHb5EjzDJufsSha2E2LyQ3tiujn77QRR60AgAIEJAA=
Date: Wed, 25 Jun 2025 04:32:44 +0000
Message-ID: <5469b9d7-d840-49eb-9778-c31b987ab29a@nvidia.com>
References: <20250623141259.76767-1-hch@lst.de>
 <25a33178-fdd0-408b-a6fa-6cb6c7e7986e@nvidia.com>
In-Reply-To: <25a33178-fdd0-408b-a6fa-6cb6c7e7986e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6143:EE_
x-ms-office365-filtering-correlation-id: bd12e71c-9582-4e20-03d3-08ddb3a15475
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnUvY1hqNWF0Wmd6UjcrNXhsNG0vdXhkOWpyeE9nbGpZYW9oNTZUSXg5c0w5?=
 =?utf-8?B?ZWJMa0w0TjJvUVl6S3VtOFVENVgxYWhvMlBocEE4ZDh3b1Fmbm1mYk9ZelVG?=
 =?utf-8?B?YXl4NWFkWEhPa1AzK2ZBSGJNbytLYmtyRWVCbzhQUFg3NkpvaGhyanNpbjJZ?=
 =?utf-8?B?dnBoa3dSNVlzc3pNRVR5OGlWVHNEb2I1N0crMHkrOStSdTBMbkF3NkRUQmNZ?=
 =?utf-8?B?WXNQQWxsTllZNUdYdG53dklaUE42SEYxU2JJVnJ2RFozaVVndmhqRTNZSVRt?=
 =?utf-8?B?c1hVNTVuVHRENU0xQXdxdFBjQkpFUkxIQzVISnVreVQ0V1RsY2cvTGN0NzVH?=
 =?utf-8?B?eWhadURjaUxzVUdxR1BwWWJ4aThsd2tJZnhkVkJ6bm0vMHBBTEt6V1kwekRF?=
 =?utf-8?B?NnRUSFlCSGhuZTBEY2szYTRJRzB5YnB5Uk03V09QTHM4Nmg0Rml4ak5YT2Iz?=
 =?utf-8?B?dkxwOXBuMTBYVFRMZ2F1c1lWbjgwVHd4M0cxWFNGTlFlZCtSUFRIaTdPbEgr?=
 =?utf-8?B?STFXNy9BVUVNejAwOE81Z042dURtWnpLUkVaemgyVEhyY2k5VnVTSkpZOHln?=
 =?utf-8?B?cGdSdDFXeG5zZ3lQeTFGWG5tVHdxT3NxaGFPU1pGbjV1OS9PNWdXeXVnb3ZB?=
 =?utf-8?B?RjVGaUt4bVMyZWl1eENpcjkwQmVLc3BMOUJ5aGxpYjVBQlJkV3Vxa3pkQ3ZX?=
 =?utf-8?B?ME9RbTlsd0xvTDUxZzkyODljYStoY24yNitYSEM0dzMyek5obFUyRGlXK0tK?=
 =?utf-8?B?dUllOEE4cDFvN2NjTU9jU0dhalhGOFNtaENyYnorK3NSejhWVUgrcTVzb2J6?=
 =?utf-8?B?QjZzYjVoWVFnby9BVW9meUV5SHFNaWtSOUQzSjdIVXNuSFEzQnJPVlUxVkNi?=
 =?utf-8?B?d2crNXRQZlJFSnR2cXRnd0kva1V5d3RJZHdZK3NSWFFQYVJ1VzlPT3FPQUV5?=
 =?utf-8?B?NU5MdTN4WlFVck11ZmFKYkx0MTBzYSt2UDdJb29HWHVjREYrWmU0bkliTkZL?=
 =?utf-8?B?eUc4Z045ei9jamYyU2pNNnA4TjkxWHNkaTlLK3d5UnVQVHF1WGdMYjdLVjlM?=
 =?utf-8?B?SEk2UzlORkI2MGdscjhkSnowL0ZweDJkMm40YTUrVnByU21UOTljQWpicGNN?=
 =?utf-8?B?Y1JydVNvVmNib1ljV0RyLzN3Z2kxWVRWMjlKbXJhOHRsckw3MGJmYlFOOXVL?=
 =?utf-8?B?ZFA2UG9obUhwbGxETy9SaTNTbXYyZDllclV3ZkRVOEJ4d3BYWGZpSyt4d1pi?=
 =?utf-8?B?ODZnSVZTWkVjZHBxVWJRQTJwVHlMRlJIVWJBdm81eFVTbHlqak9pUEEyOEp3?=
 =?utf-8?B?SXZha0ZjQVg0NmtMQlMrV1phVUkrZ05Sdk1mM3V5Zk4vdUVBdFlvb01vSVdh?=
 =?utf-8?B?RXR4NG9vbjR6UmVsL04vOXNwU1RVa2NKZkhpeTQ2Unl5RGVBdnlZVVAxanZ6?=
 =?utf-8?B?YmZraU9OREVjSXM5TUt4OXJ4eGQydFZSVlAyeGprbHpjaDJnQ09qWEczSVo0?=
 =?utf-8?B?SEIwZ2JRS3ZHSEIwaXV0WTE5Q3A2VjM1WDVEV0tIbFM2dWo3WGdhK0p3ZjAr?=
 =?utf-8?B?MHNqcUhRUUZ2YzNGQ3BaQnpqL1VvUHFQSGVrQWNTR0NuUTh2RTl2L0x6TGUz?=
 =?utf-8?B?Q2RTOG50RlNRV1Npb0FveVF0bmF2TG5weUg4WGMrUG1oL3BaTTBCcGhaQklN?=
 =?utf-8?B?bUtaSHNKVk5pMzFHTy9pSlY2YzVYTmh1NGV1cW0vT3dNcmcyRVZIOFBSQkg4?=
 =?utf-8?B?cy9uRk1FNFNURlRNV01lejdpOFA0bWEzVnlVd3dBMklReE9obFhPNlBvUXZq?=
 =?utf-8?B?S2dUdlhxa0h3aUwrZjR1TW1xdHdFMU9tZ0xQU1NuUURBTE9GcUpGZE55amNC?=
 =?utf-8?B?Y0dndm5IVWJ0a0FDeWxCbVFmeXNDYzNYWEhkZXVSbi93ZDY5R0lSTzFzOVY3?=
 =?utf-8?B?M3BCTUVGcUs4Mk5sRGJJbU93OE5JY1dUOVlxM0MyYkpSS3NDMFNaMG5NMTUr?=
 =?utf-8?Q?isa84IWX5ebroKYsmxLLj4yk1NAoBU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzFzMHJYV2lqcFVlZGpScDFWVWdXemFoK1VrRnBzOE5OTks2NXkxNzlZeFZv?=
 =?utf-8?B?VU9hc29vdndTWTBuWE5LM1IrMkNTYk81ZkdCbmh0akhLem9wcW43TnNNaEwy?=
 =?utf-8?B?ZklYK1BZRFNDaXFSQXM5MXJUbEtkZy9VMXhheE95aDIzaG5TaE82emJtSUkv?=
 =?utf-8?B?VWQzNzV5Q2xIQUJSQ3ZCbXZESHJmVUVwcTdYK0MzWmVUUThxcGl0Z292SHpy?=
 =?utf-8?B?aHJwM1ZnZk1rQlMzcmtpd3JlR0ZkUGxnK3VKdk93YjhVYUNma2pueUZvQVBk?=
 =?utf-8?B?M3dZQ3BiTGNpOHJxZ1p6Q1JFd0szaXNQVS9EV1hNSXZEbFN0T1VJS2kwTFZk?=
 =?utf-8?B?Y09xdXhzY2w0ZzRqN1hYSU5Dekljd1lZNzJoMnpKbHIxOFd6c2o2MmQzdTVF?=
 =?utf-8?B?Mll6RlhucWRzczNsQlhtNVpPeGNYTmR6YVQvdVN1R29zVllRNVZoakNoc2x2?=
 =?utf-8?B?NkZTcWtpM0VYYXcrKzRrdEVFOU9NTVYyL0tjaldaY0VWOHR1NWZZSlc5SUNt?=
 =?utf-8?B?dVFtTWJaRmkyVmRnbmJEWHpwdUxraVdYUUZoSlh0TVgzRldGcDkxc1BoTk5W?=
 =?utf-8?B?VEgwc094amtqYnJXVlhmeDhFdTdLZlN2L3BnUExLRjJHMHZkanc2YmtCazRX?=
 =?utf-8?B?b1ZqUFRZS0I3NHUvUFhuNU94UzlOMjZvRUFXcHRCVW45QzZzdDI5Um1FN2lB?=
 =?utf-8?B?SDNtdkt6TjdOT2FxWk1XVHFLZHowcm54VVoxMWRFcWVmYjR0bXNnQ3RVVFJI?=
 =?utf-8?B?QXNjazB5TzRLL3NlWmcyZ1JVWHlLVjFaUVd1ckhZTHJxVTl6VTZwc0s5am9o?=
 =?utf-8?B?S3hLRVRYT09aM2s2cVRSVmZlclBOWWVPU3hNTnJWM1d6SFpVWWFXZ25hYzZq?=
 =?utf-8?B?UVRTRnE1T3hqWmFNL0FpZFZhWWtDdUt3L1oyaDNHTjZGMy8vb1dBVGRHdUlp?=
 =?utf-8?B?Y2JCMnNFb1dBZTM3TWxZOFBiSXV4T0R2MFN3S0laQkFEcC9kRlZJSzV2aG5V?=
 =?utf-8?B?SmRrbTZsM1IwclhMWHlPOHRTTjJZK29nOGVwSGFpaTZ3Q1l5ODFmRytWaS9m?=
 =?utf-8?B?aWR5VE1raG84M0xrYUJLMXlEUFo5S1JQY081M2xDYnVxT05WYWVTMnJPa2kr?=
 =?utf-8?B?QWpycU5tMUxzWTF3Z1EzbHRyckkxakVwM3V1VEY3dlA0L3FPZlh1VXQrQWQv?=
 =?utf-8?B?cUNVMGJmZ1NKaGxXeVMxS3JSMkprWUQ1QnpRNXgyeXV2Q3pab1FTUUc2Nldj?=
 =?utf-8?B?ejNENW9OOXJUQUxDdlhobEZaZ29QN08zTHh0cmx0NW9BUlNzcUxkWkhYM1pq?=
 =?utf-8?B?WFo1R0pqb1prd2ZYYklrUmpxY2pqaDBYZ3dvS1R6VmVNMmtBb252ajYxWlhk?=
 =?utf-8?B?UW9nMmh6Uy9kZnBoYmh3aWhmbjZmQ2wzRnJhOGplZ00vRTRKYTFEcDlMc090?=
 =?utf-8?B?MzNObUFIUHlxSjRxaFltT0p0WEdRTHJaeGNJTnJIbVNBL3V1K0xQQkxCYW1k?=
 =?utf-8?B?bk5nRXl3d0ErZHJNSW5BdlpFK3hNUTkyYU5WbGZXdGFhYzBHOG11cG1BNS9u?=
 =?utf-8?B?QTlrTU5leXl3SXVzV1VKWFFkZVVoaE16TWJ0ZXdmN2hJVElmdXFwRjFXWGFs?=
 =?utf-8?B?U21vdDVhUkR1a2VYQzQyTTBDSWYxbmloSUdlMFNpaFIvUmphSUFZUVhDR1E4?=
 =?utf-8?B?YThYMVZJd1AyNTl5VnhIc3VxYTk1V2xGSmhkaGVLRFZra3ljRnFQcVk1aUJR?=
 =?utf-8?B?MVBhY0tvdmJud0ljNzFBOTZUSk83YzlWNGs4UUY1ZkRIR2dod05OSUhyOG1W?=
 =?utf-8?B?VFlWTE8zOHd2M3NIY3dnSThaamZCSnBsdnhVYlBUaDdMUVA0VUVZRGl2SzhD?=
 =?utf-8?B?aERNYU9mbkhvV2w1Nkx6cXN4Y0xNZ3N5VDIyMzEzc0FFV0xuSksrODd0dzZt?=
 =?utf-8?B?Sit5dnNFZWpnSHJqS0V2Q0lOUDhiYW16KzQ3UnJTZXAvZzN5YVJhdVorSTJK?=
 =?utf-8?B?Z2NkeEJpRXk2cmdITnZVVlZCeE16VlZqYjF5V2pmU09rNHhJTGgyLzA2L1pC?=
 =?utf-8?B?TFBvdjNXTlNGVVFsOFpRdk5paUtMQllmaDhhT1l3VlhBSHcxeFMyVk9CanNY?=
 =?utf-8?B?T0V5aWNpYUlxMkxxVUVBRS9RNWR2bXRZS082eTJOZ2JFb2xCbG9UWmhvc244?=
 =?utf-8?Q?E8O6EAFCoggTJBcOp7hGhg1uZiqkpE00TX9CQkQE3da+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE2844D742D9EA4398DF9F38C5173DF9@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd12e71c-9582-4e20-03d3-08ddb3a15475
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 04:32:44.4068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qwy0IQ7Q4lnKIhGbB8CTM4n82sbI+FXUFFMy/HUlhxlgEdxFGOAKVjKt8p5G5YIS1yYXOUvA9CkXmyu9Z1SdAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

T24gNi8yMy8yNSAxNDo0NSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiA2LzIzLzI1
IDA3OjEyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IEhpIGFsbCwNCj4+DQo+PiB0aGlz
IHNlcmllcyBjb252ZXJ0cyB0aGUgbnZtZS1wY2kgZHJpdmVyIHRvIHRoZSBuZXcgSU9WQS1iYXNl
ZCBETUEgQVBJDQo+PiBmb3IgdGhlIGRhdGEgcGF0aC4NCj4+DQo+PiBDaGFuY2VzIHNpbmNlIHYx
Og0KPj4gICAgLSBtaW5vciBjbGVhbnVwcyB0byB0aGUgYmxvY2sgZG1hIG1hcHBpbmcgaGVscGVy
cw0KPj4gICAgLSBmaXggdGhlIG1ldGFkYXRhIFNHTCBzdXBwb3J0ZWQgY2hlY2sgZm9yIGJpc2Vj
dGFiaWxpdHkNCj4+ICAgIC0gZml4IFNHTCB0aHJlc2hvbGQgY2hlY2sNCj4+ICAgIC0gZml4L3Np
bXBsaWZ5IG1ldGFkYXRhIFNHTCBmb3JjZSBjaGVja3MNCj4+DQo+PiBEaWZmc3RhdDoNCj4+ICAg
IGJsb2NrL2Jpby1pbnRlZ3JpdHkuYyAgICAgIHwgICAgMw0KPj4gICAgYmxvY2svYmlvLmMgICAg
ICAgICAgICAgICAgfCAgIDIwIC0NCj4+ICAgIGJsb2NrL2Jsay1tcS1kbWEuYyAgICAgICAgIHwg
IDE2MSArKysrKysrKysrKw0KPj4gICAgZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgICAgfCAgNjE1
ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAgaW5j
bHVkZS9saW51eC9ibGstbXEtZG1hLmggfCAgIDYzICsrKysNCj4+ICAgIGluY2x1ZGUvbGludXgv
YmxrX3R5cGVzLmggIHwgICAgMg0KPj4gICAgNiBmaWxlcyBjaGFuZ2VkLCA1OTcgaW5zZXJ0aW9u
cygrKSwgMjY3IGRlbGV0aW9ucygtKQ0KPiBJJ2xsIGhhdmUgdGhpcyB0ZXN0ZWQgYW5kIHJldmll
d2VkIGJ5IHRvbW9ycm93IGVuZCBvZiBteSBkYXkgb24gbXkgSC9XDQo+IHNldHVwLg0KPiBHZW50
bGUgcmVxdWVzdCwgcGxlYXNlIHdhaXQgdGlsbCB0b21vcnJvdyBlbmQgb2YgdGhlIGRheSBiZWZv
cmUgYXBwbHlpbmcuDQo+DQo+IC1jaw0KPg0KPg0KDQpQYXRjaC1zZXJpZXMgZG9lcyBsb29rIGdv
b2QgdG8gbWUgKGV4Y2VwdCB0aGUgU0dMIHBhcmFtZXRlciBmaXgpLg0KSSByYW4gb3V0IG9mIHRp
bWUgYmVmb3JlIEkgY291bGQgZmluaXNoIHRoZSBwZXJmb3JtYW5jZSB0ZXN0cyB0b2RheS4NCg0K
SSdsbCBkZWZpbml0ZWx5IGhhdmUgaXQgZmluaXNoZWQgYmVmb3JlIHRvbW9ycm93IGVuZCBvZiB0
aGUgZGF5IHRvDQpwcm92aWRlIHRoZSBuZWNlc3NhcnkgdGFncy4NCg0KLWNrDQoNCg0K
