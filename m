Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBCE225761;
	Mon, 20 Oct 2025 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003404; cv=fail; b=CUE+wYW+kEHuTWxSbxSmHCDedTJTNGWNCMFRUPhnA2tPd4ZbXFl+xSO8oI/6soAM8Moe9uNwxZDlC5zRi4WjV2Ph3gDxUizGZ9oacg2nRTXKlXY3wvU2DYq01bbO+I+lLezSrTNxb7wcbik2sUAFBjHWETGAvZHJwyhhaTlQBH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003404; c=relaxed/simple;
	bh=DP6p1bGCoK5iO+ogjNcY049Uc43D3qVu11ZnF+pBmrM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H7JHVbg3uKphUBjVWD3/W+MRX+SevyfaRVxrHzMUNsBGoKfn2mfL6Su6pbT8VLHPaTCuJ+Y3zZWJj6Jm5XdXXLcXN6p2K8MaCmuGt1JioGbkNCi6f3rJPKf2p6b6N9l37DZw2ODNC6T2QgxNLt78H76XMG5N55oVD8IoZz3U9hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dkl9Teb/; arc=fail smtp.client-ip=52.101.56.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dkl9Teb/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLksI6upPA+JYQgUlRwD5PgZKE6uNOmMAcwK6bSWM7ni1CdNN4mPAn4cqkpD8x+5rwr0WyKBCqa/zQKbgkHKYTs9leSJ9NwH/RZuXOvjGKL8/2SheaYwOkS3UYjFlO1dhI/sMIrWuxhcPqIlgY4emAsgXkJn9CSDSkCui7CJysbkG/aihbLbUeLe8yxAptU4Yu9B6YzDWvvyyYBO2fCLB0RVRXNCC/IOU3QyoyEhTDILkK6e6o4qn59jfd1CZGd0xMl9fUbGumxCTD0AfAvRbdtWI2dUc42x9qchJVlDyWwZDFU0myGkYcwIeAVEUEQGZ4dUZz7eNM52mTWqoq0aGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP6p1bGCoK5iO+ogjNcY049Uc43D3qVu11ZnF+pBmrM=;
 b=cDz4IEv2pa35HgaEMWPu0eSzcPaqJIqEV1hso8Cp9U5skK3pABD0WnF7piOocOJNxdnXfhlQaHHmEaC9pSgssYQbQhhXh1zO10ahZl71F3InSqSQntFO/nnwOTbxM/NJBDtU992l3AcWdfs08arP08fTrQ9a2Rk7r4MMnPSEqs+BOnG7H6aaMUEVgvMuTuQuptB5mkTvNEDJaEGgyHCM4pcDP0yUl9zAmQvEZ+ZHKFTe5u9PNpkIlRF7Hj6res0HTNMM8YHzwAbnTlEgVaQ88JHkeD+te5ApW5X69JNIs9zWh9cw8P/JObzo1/iWUUVYKgu7r7ggx5yo6bl23+bcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP6p1bGCoK5iO+ogjNcY049Uc43D3qVu11ZnF+pBmrM=;
 b=dkl9Teb/Ry5QAUklWKSGFNJKSiijwxNupP8tDsP28xIiq4ph2v6jUog24lXwL7OqCiD7K0j6KeCYYADTfTRvyKlfJu6Wf/WQZlU2ri0j3Ch1LDvonS41Xkn8CrECLVaBsg3v7bNfDY4qyKPCGy61GOQ8k20V10BvwbqST+acdQtYlxyPbbuo1gVGZy1ANGLJP2ladU0+APzmhGWxFRBoTMsg5FYaRRtd6CPyn7sT0fq1McJED1l696+FMvAZzPgiF0DMtoq8ZKu2wOmmzXq0xJ/5YnM9B/BPr1MMUYp1O2gFFIMBggHz/avsrSZmo+br3sCx6B4a4SIEXV3YH8Mj8Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 23:36:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 23:36:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Thread-Topic: [PATCH v2 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Thread-Index: AQHcQeMfLlucYKtiYEi4r2E/AQ3tCLTLsPsA
Date: Mon, 20 Oct 2025 23:36:38 +0000
Message-ID: <da06329c-6a42-450b-aa04-6813bb2cd981@nvidia.com>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
 <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com>
In-Reply-To: <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6429:EE_
x-ms-office365-filtering-correlation-id: a02d30ad-091e-4307-3cac-08de10318424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXVDazJ3bnFWamZFQVZ5bXVWakFqd3BwU241Q2hEOE5uN2NqbVUweEJjeXVL?=
 =?utf-8?B?QnF1eiswa1kzUThxS0VZSjdhbzZFVlFaTGMzajRJRE11QWJFSTBGNkxsTFhC?=
 =?utf-8?B?dDAyM1RKRDA4Q1hUZWRUM01GdW5KZE1hdkVhSDVMTldxYkVxWkhxZ0hIMUhn?=
 =?utf-8?B?dlEycmtFbllwTVNBRThiOHZnOXk2a20xZ0QyWE1OUjdaM1hGQ1c0SXdPKzFw?=
 =?utf-8?B?TUFZdkRpUlpDbFZhM3Z5ZENaZld4SDFzOTZIU01ieDBlSWJKVVYyVHVSWFdW?=
 =?utf-8?B?b1FnT1lCNTlSelpwRTcvMzN0RVNDNmpWYzVmdVVWbFFaZ0tLWW9UQVhNR0VB?=
 =?utf-8?B?VFdXWGRmVTUrUml6c24rb2UvaHRZcVJCNktKVFZmbXVadE1zWDFKcEZmTHVN?=
 =?utf-8?B?YmN6MDdXNXA5dXJIN2pEZzZ2aHlTaGhhbEUycExkUUhIVjZGK1YwY0pTTFkr?=
 =?utf-8?B?RjJoZ1pERGdvVGV3WHlaZ0MrRjVvV2dZWjRWSENoK1Z3d0pKOS9ZbmNwK1Z1?=
 =?utf-8?B?S0EyU0dFTUtESjZQYjludVlyNlM5ZE0rQ0pEYm12enJSbFdJdVZWamlQSk50?=
 =?utf-8?B?MUE1Uk54dlpUckZCUENsd0h3ZGhMbnZJdjFFblphNklrZHhnLzFRWnNCbGhU?=
 =?utf-8?B?SzNiZ28yR01MNEhMV2kwTEc3eGJvRHB0ME14M2lodEEzckFnb09ScmxTd0Y0?=
 =?utf-8?B?d0NZamFOTWpKR0MwY1VweDlxMW12ZmhkM0hFOG8zOWJBYjhhNTJRb2xCaklH?=
 =?utf-8?B?ZkRiWmladTU1ejlIck5PT0puc09WVDBaVUY3ZGNncEpWYzhFRUZxUnpjdmZ3?=
 =?utf-8?B?a09nenU2aGhCYmZ5eUQwcDAxK3FONFZEZ3Y3RUlSYW5zK1h5M2VxN2hzVjIz?=
 =?utf-8?B?eXNjMnl0a2EwUGk2MWhYaGJ5NnBiR1ZWTFFCS0VtZW1SbTNCK0NtMis2bTdp?=
 =?utf-8?B?WTBGOUJaaTl0VE5Sc2JORTFZYzA1TEtaYzluTXpwUUt6S0tLWFdOMjdFUTYy?=
 =?utf-8?B?UjcyTjNMNHZiY0RqU1paZHB5Y1RoMWcrUE5wb0hZUG9iUTYxK3pLcEFsdkps?=
 =?utf-8?B?Mk85U1pKRjVvYm5sOGpCZ1lFRHJpTXJYOXhaeDRhRjl0Z2JlNTg2NjNJZkdW?=
 =?utf-8?B?M2NTa1dNRTJnaW1BTlBldDIzNm5Vc0Nod0krbXRoY2kxY2VXRDU0MHpXampo?=
 =?utf-8?B?cFJHUmdhaUhHRVoxeWdxam9pYlpsclUvUytuWWFQTE5TSmwzNHY1WVJsVzZO?=
 =?utf-8?B?L1lOTkNzQzM0R050bkZYN0tjQmZuaXZvTkk4ZDBkR3RNZFJ5T3hmRU5vSitw?=
 =?utf-8?B?aEx6SEljYnJlQ1U0MUdpdUplN1RVdjdGR3FFRHV3WHNpWUNUZWx2ajVrOUlC?=
 =?utf-8?B?bE1EMFlaNTJLUEFhWWxleGFxMUh3eFEyNXVQZkF4UDJzTlBaYUwyelpHcjRj?=
 =?utf-8?B?cUR5OWxXMUNKbE12WE9zYmlleUI0YTBkaDBtNEJMSVhVdmNJTnhIN3crMWdk?=
 =?utf-8?B?V3FSY05zTVFUS3VManQzN2NjK0NkQkdHYkk2eUNHR1hvVWdqaW5lTVp1NTdi?=
 =?utf-8?B?K0FrR1VjTkw0WExKQ1BENmdTRVVqdlVUWU0yM2cxSDFwZmZHUFI2L1h3dlo4?=
 =?utf-8?B?MnZhWmFha001ajNLS1ZEdzVJNFJDQTdkeTYxaTZ3bExWQVJBbG5neHlWZmNu?=
 =?utf-8?B?dlZzWDRkeXdYdTY2L0ZZOWI3Vld1bXNhTDExS1Ayb21QYjVSSE42OTlsTWh3?=
 =?utf-8?B?RUExUWxzby9SM3FRMXNsT3A1dVhKMS90ZnJyMmMvVGdGUVlRZ0NVU1hiZC9M?=
 =?utf-8?B?ak5FT0RSTXZJeHR5ZWFhSklaa0NkMGJsZUV2cmFIQjloWEREK1hmQW0zdEFM?=
 =?utf-8?B?RFFIa3BqQUJtWHB1QlFTNTcxM29Yd1oraDJGZXRmYmd2dlJXRTVQZ05vWWVP?=
 =?utf-8?B?V1duNFRFT3kxdzRoYjl5aEd4VE5idHJBZkJWRE1weTNvSnZaVkZaTStkbFpw?=
 =?utf-8?B?U05aUDN6U1Rvc3ZnMVNuQVdZMWZJYXpza05haGE4NXJxZWtsUEhTdHlibmk0?=
 =?utf-8?Q?W15HTB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1I5Y2RYTGVEMkF5dDdoVnJUbWdRMXRNU2l6VXRhMzNZdnR4ZFY3Zis2Qm5K?=
 =?utf-8?B?cEdYM0pxYmpCdHJycTlDdUwzNVowWVpLVkE3ZnpCYjRBTkp1b3lwVkNuK0Qv?=
 =?utf-8?B?eExBYTNnWERGdVJEcTREdGJSaUE4K0lTbVdlMFhmWHpqcGQ0RnUySWNlOWN0?=
 =?utf-8?B?R3J3WTV6aEZxTHFWVUt0ZXhZWWdsOGxpNW85N05Qb2QzeGc3SlRPeUFxR1Uw?=
 =?utf-8?B?WlFJK3k5NkN0aTlHdElXZVMxWWZBbkYzazh2c1k5Tzh3ckpCWVBQMEZDVEk1?=
 =?utf-8?B?ZXBoTEJOUnJJNnM4SGtJOWdBN09tTUk1a0tpVElkZXhVOGVNbk80ejdnOW1U?=
 =?utf-8?B?WnpnWFQ0MFNEQkFqeXhBNTk3STU4VHNFWm1Tc01nS1huYnFHQzd1Sm9wYW8x?=
 =?utf-8?B?dWJqbG12dUovTUZ2ZzZnN0tnMmxrS054eG5SUGF6RHdrSFl3UmFwSVU0b1Q4?=
 =?utf-8?B?VFV4NWhjVklMQ3orbWYxZit5RVlNRWY2Q0NQcys2SkdlakZnL1doKzhtaklP?=
 =?utf-8?B?R1J1TnRNVmZkVWYzNUFXMDFFQVFMdVlHcG9DeEw0aitwRTFzbW5NbVlIeW9O?=
 =?utf-8?B?QnR6eWtrc25rTzdHVnFQS3ZwWjV2dHZnck53Qjh6WFZxN2tkNTloVU9IVDZi?=
 =?utf-8?B?djF0dlJ3UjYwMFhsODYxYlNEQ3AyQ0F1K1ZPOXpqUm8xNmFMV3hvY2trVXJq?=
 =?utf-8?B?SWtObVM0Z0JEYlAwSUNTQnl6RVZEZWhBU2dIcVNZS0pBREc2dWN2cmM4K0dV?=
 =?utf-8?B?M2dYYnBlT1EyakNnbU44YzRiakNOTHNYR1pQSHVhM0ZzcnhqTHZuL0hkTXcx?=
 =?utf-8?B?dnV2WWtFWlJBNjlzOVB1QkVjSWNuWW9JdlI3aWxmVHE0Si9TNTNVeUNvSXVx?=
 =?utf-8?B?WjlhZ1QrMzdYZTdKdEdZRndrY1FsZjBaQVB4ZlJqYjRBQlMvWDQ5bTB0QTdu?=
 =?utf-8?B?MUpHSVpFc01lRXN5V0tGeDBnZzI3VnNLWUhTTVYxZ2VQWWhaZUgyTnFMelJk?=
 =?utf-8?B?MytFRmhmTXR1cFRWOEQzNTZwSDVGdDV4RUhLZGZXeit2OXEzRldsazI3NFcy?=
 =?utf-8?B?S0hWaG9ZSlRaeEE2WVdCa25RN1UzcWplN0FWa3JoY0JwVG5teDZudGlxVWwx?=
 =?utf-8?B?MXNzVmt6a3FEb3kvYzhSWCtMM0dSRmlBWFQyYkpDLy9vR1RDWGRDTkxlYnJ0?=
 =?utf-8?B?WGlRUXJVZXpCdDNqREt5Ynh3d0xGRWtDQlQxaDdzUys3bG9DcmZPUGJlN1dL?=
 =?utf-8?B?U1hyM1BEMFVlS0h3RVhUR2NsV3l3NEdjVzdSVW9TbElpV0ZlQytRV0NiOEkv?=
 =?utf-8?B?RFJDWEFadm5nUHBQOHFib2t6bmtZdUJLQ2xrRXFlY0pWbVhtT1V0L3NPc29M?=
 =?utf-8?B?THhhYlhoU3ZPZkh5WFEvZW84b2dCVzNhMmF6MTVxMG9vZ1NvM0ozT1pCU0kw?=
 =?utf-8?B?Z3pUV1hXWHEvTVJsa0JkUXdzOFJETHBYazJ0cEo3eTlmNGlxdUFwN0w3V29V?=
 =?utf-8?B?c2NiTTc4bnphNkxRRm9EOWc1ZW93YXZPMUJaMnJ4SkRtWnRDRnhGTTNXT20w?=
 =?utf-8?B?MWxFQ2llU1hNOUpSZHVxR3o2VUxGL3YramR6TWxDc1VDRVkybm0vT25Yak9o?=
 =?utf-8?B?N1BTRDZ5MVU0QW53dXhaVEFYRDVUYVdTUkxQMUNJeU9lS1ZESk1TYVRqcUlN?=
 =?utf-8?B?cXJiRG9BWTA0YmdORmFYQWVuLzNyd1JDbENZU3B2U1VMVDZSdkJCQXVIOEVU?=
 =?utf-8?B?SWkvcHlJZ0dCZzU3NmlFVzRMYlRNem13NEN0OTg0R21GY3FNMzdRcm9FUFZn?=
 =?utf-8?B?dlNrRzA0RENOKzV5RmpBMFFFR2NHNmhacTBCN1N4TVovaW1MejVuMmUvS3Qz?=
 =?utf-8?B?Mllpb2o3aThEVzJmaW5pdUk4YUN1WDhoZFhPeVRlU3VKRUhuSDFyWnJTWGc2?=
 =?utf-8?B?bHJIOUo1b2lDQXZabUorODlnR1IwUjBUaFlBODhEZjdtQ3kzbHR2N000RlRh?=
 =?utf-8?B?cVNmQnh4NE5RNndOS25BRkdSU0xmaE9QQUF2SzZkU1pKc2dHMDZ3K0lsbWR3?=
 =?utf-8?B?THU3KzZWTjNGejIrVWNibFY0WmJiL3ZjYk8xRXRRTVJEOUZBTGhESnNCV28z?=
 =?utf-8?B?SHFhSWVmclY5ME1rdDg3WklpdWFLMFpDbE5CQVN5M2Q5N3FOY0EreG9UWlRD?=
 =?utf-8?Q?COwPr5Obn3rfg01Ym6EZ3z8dltXEVL5wLYNvtsgHKVG/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6F0DFDD3A3EC346AE1FB71D676E6E85@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a02d30ad-091e-4307-3cac-08de10318424
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 23:36:38.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wx3wTFOMF4gla/DSrtumv8zlpt8rWlDMxGPGZw1rgG4i47xQDsiiaknOTcvRST10X6RER9aU6+iYXbwy5TUZow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429

T24gMTAvMjAvMjUgMTA6MDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gRnJvbTogTGVvbiBS
b21hbm92c2t5PGxlb25yb0BudmlkaWEuY29tPg0KPg0KPiBBZnRlciBpbnRyb2R1Y3Rpb24gb2Yg
ZG1hX21hcF9waHlzKCksIHRoZXJlIGlzIG5vIG5lZWQgdG8gY29udmVydA0KPiBmcm9tIHBoeXNp
Y2FsIGFkZHJlc3MgdG8gc3RydWN0IHBhZ2UgaW4gb3JkZXIgdG8gbWFwIHBhZ2UuIFNvIGxldCdz
DQo+IHVzZSBpdCBkaXJlY3RseS4NCj4NCj4gUmV2aWV3ZWQtYnk6IEtlaXRoIEJ1c2NoPGtidXNj
aEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5k
ZT4NCj4gU2lnbmVkLW9mZi1ieTogTGVvbiBSb21hbm92c2t5PGxlb25yb0BudmlkaWEuY29tPg0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
