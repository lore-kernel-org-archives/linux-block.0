Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47D26B75C
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901290; cv=fail; b=m7Lfb1t2g1EXUDyIpAeA38XUQDxghu07p4qf0XvbcGyCCdEakcnDIcM3sjtLl2oiQxYYp6h9Pl8UyMgguX2uadcJ+g1WjvFPM74Dm65i48ZBMsp8KrIybqSXH5wiLnKMPD6zdW1jrna60+o1b0cRVbXr/+ADoUrbek1hsP7ioc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901290; c=relaxed/simple;
	bh=KOqvQm2FECdz1wux28mJw5/sWs0crREKtatjF1J7Lfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SP1vUJdsLRlNRHJhINlePOo34FJKPMehKtrbTNHJTMcS02HK3AGvbWtqGlXaSXsrGsKAbouNd1uqMuWsrQgLMFr4VPFlN5TYhGQa5z1RtVhf9qsCgjwFrrzaYrFtNP8g5r2csJZssn8q7nFPT0R5ZuvWOoaq92hChfFM9TbVDts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NW94W12H; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NW94W12H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvlN46V5N/Gob+LEEX8hYttdOaP2lVMuuMqL0FNbdbXofBPYx7x8UfdmfxWNo/XzgoDPsil0+AtIOn0ffBTXIERX1ZWaU+9K508SG9FjsIHNG4BatvrzRTnS5aSMuhf8oRAQQkp9MHxCtF0kQ13RT4nCmPmEEOTIl9YzPlFlH1rfX+ijM+9Y8vEULqXg4DO4+F6L8afh712uvxEyjHhuP+OLP0S+W4jJ4R4PoZw5Q5D9MvAJtFBr2xGN5KDWDZWdDDtlErce6X0DVKJTbeurEzB7ppWrPIzHJCRvLxirNrQJYT2REhb0/sFhElMHffPwpzDgwczwBgUVakQ4Phd2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOqvQm2FECdz1wux28mJw5/sWs0crREKtatjF1J7Lfc=;
 b=Uju9qbcnpKGG/nANQKVoaKAkKfZ2nGfJJvLXtrkIRi346Y+JQjaQs5Xhk2cKRs40grIcdxQGQNvmYAN11Mc1In4hbkAF4fh/hS5+Za+OOMOrfzdnOs2gjO2rJK2PAS4Nxh8fszJz3QS8Lrs2pXpiGnohZ9nj9ziKOo0hpAe9oK3ScJW7r8ZYAPU1fOL8VVX/8tSyodFJk7r1OSfLJeYcqMu9XOk/C3tb+9rJESeHUvRuVyuF+/d67gQ0WzDJSmo7+JH7M+gyfoZabg3y0gY/qnbAAfTJVrxc2ZkYxc4eHKK0YShPIq2I4ADtHcbdtoTzDc6wAIBtHs0v5yiHjSwAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOqvQm2FECdz1wux28mJw5/sWs0crREKtatjF1J7Lfc=;
 b=NW94W12HFaqEODRqx1n842Xavjl7q6a/A90+nzI8ICCTvN9nRvHWXhRZyd6TUX34qGefNGAhDWUq/ufQEOIe2xh9GFu3AdcL9y6Fbbyp7Kb5phKKAWKA/g3ILSMFrG3wkFDBQSf35r3oSTvchJR17mwYfg2HOVAAeVxeo4wfyw35Jy1exUyNuxyh9UyLrtuPf1dvaenCCWUarna89GOwetMyFg5q/hEyimGMRrPyNRPRN0aBR5Ra6r6ay6s3JDYi35sb2bKg3NBrjQwoBXa/2GFI7BOQi/jyVEmOseR/0EgMDHUixgdd5pPLf5Tih53wcvnJrNMv/00mkpnKiuazwQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Tue, 11 Nov
 2025 22:48:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 22:48:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Zheng Qixing <zhengqixing@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH] Revert "null_blk: allow byte aligned memory offsets"
Thread-Topic: [PATCH] Revert "null_blk: allow byte aligned memory offsets"
Thread-Index: AQHcU1fLinJu53fqvUCgBZXiC1mIBrTuE8WA
Date: Tue, 11 Nov 2025 22:47:59 +0000
Message-ID: <2b9ccdc5-ef7a-44cb-8838-a684a2bae939@nvidia.com>
References: <20251111220838.926321-1-bvanassche@acm.org>
In-Reply-To: <20251111220838.926321-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB6716:EE_
x-ms-office365-filtering-correlation-id: dbc809ca-1c2c-4a26-c581-08de21745d68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0p6YjlPakZLRmJ4WnBNS2tBei9UZmhBY3p2dWdLUEtMRDFSMTFJNTVpSC83?=
 =?utf-8?B?MkdGalAyUjQrZ0k1UDFBWjg0aVFyczBDWS90MjdZaGdHLy96ckFEdXVhdnNN?=
 =?utf-8?B?V3F0U3c1UXpnTFhOcFd2UVp2WU5haHQ4aWUzeFlVdjlIaGNYK0dqcEFVbDV6?=
 =?utf-8?B?YmdGR040UjZSN2Qyb1NEcVVNeDBSNHBhNkYxYTkzVkJ6MWR1Z28xRy9vL0NO?=
 =?utf-8?B?WmVZTGRWNnRYc05YSGRXak9VQS9PNU96NEtPVEpGK1NZQ2JiNWJXc1NHcGxJ?=
 =?utf-8?B?eXJVUG54R2doRGRPQlJMd1NkU0Y1VmVPSFlUWUVHRjZQU1dCTXdaMHZJSzFq?=
 =?utf-8?B?Y0tZRGtFcWMyTERiaS9kaS9FMW4rZk5BRkxDZkVrWnI1QklXN0VsTWc0aVA1?=
 =?utf-8?B?UnhOOTRRRHZDa3c2NHVaeU9hYVpHM1VjMzhUQlM2MXV1SHZmbkg5SFZiQThz?=
 =?utf-8?B?SUxVZlRqUmFTYjVzbHE5MlE2Zkd3dXJCOE9HWFdIeVVMekxzZlE1RzJFYUFI?=
 =?utf-8?B?R0owdFVUcExOdklFWnloRXFCU0N6RUlIOE9IVnFlZThyNUNZNHlzYk10WG56?=
 =?utf-8?B?SzFyTm1FYk5yYUE1VWF0Q3hmWTFBVGJmQ2RzNkFvZE5xUlp2OGMwK3REb2Iw?=
 =?utf-8?B?MHlpRDJnUExJZUFEbnZXbHVPdFhmUlRLMUNqeVlqMWVpR1VFZ1pLRS9UWWYv?=
 =?utf-8?B?R0t6T3dtczdVVGdTcXJTS1QrUlRxaUdnd1gyaktBQmU3RGVBcis0YTMxZGNk?=
 =?utf-8?B?M2tpNGJFRjZkNDhYRnpWZjN2K3AwYXRtR3dscFJjL1RDazNTcHVnSytzNW5o?=
 =?utf-8?B?OTU3VFFHWGtvUW9kYzRkRU9NOFk2Z09yY1VBVFEvMTUzYWp3YjlWVWVudlhv?=
 =?utf-8?B?MHlIeWVoaC9nK2M3UFJsRkN3Ums2cFF3T0t5S3FxWlRpd2tScjkxd3lndWww?=
 =?utf-8?B?ZGs3SHdYczJvVzRzcGcxODF5bEdFS0ZxQ2ZUY05xUFNkV1VzNU8wUGRYK3o2?=
 =?utf-8?B?Ri9Lc2F1TFdQSmxETDdTWlZYSllMNlVEQ3R2bXVhelNwYUlWWEdOeG5PRnRr?=
 =?utf-8?B?alpXRGk2djA0NzlpYU5hdzVOMFdSYWJjTk1sZThnbHNpQ0VrZHl3OGh6UHhy?=
 =?utf-8?B?VGhiYThhL2V5VWoyUjBXNUEvZGdpSGlDNHdnRnV3aFd4bUJjTmJxNjZ0TUlp?=
 =?utf-8?B?LzRvMWV6NFR3ZUNZdjl3dU5Uc1dVOHY5T2M2UnlUU1VCajN0RFVBcldPM0JE?=
 =?utf-8?B?aFdYVEt5b0I0eGduY3dDTTBOOUhocWdWeW1kVFZUNnRlaUsvdTc5SU9mMEdZ?=
 =?utf-8?B?VStzYk5xTHE2NWxmckhLMVdpM2tqZHpZdTVYb0JFWVFQcjNla0QyanU2NUFn?=
 =?utf-8?B?MitDS2hNaHJRbS9KNDltcFQ1WjdaSUgrSFhtNHdVclFGTUlOZC9uSFNLb1Av?=
 =?utf-8?B?Wm1adkxzQk9jWGVydTdFTTRCaVNkbTNkU0FPZ0d1R3RqQzV4MHYwQ29ZZXRL?=
 =?utf-8?B?T0gzNlJNQkpaRmVMLzZjbzlSZ21wNjZHUkFVVFlFdEswZXEvallibWJ1YTlX?=
 =?utf-8?B?T2gxZFIrNEYwUHFTT2F5dFFUY05JQlo0dWRsVUVJSVJ1cWxueHg3V1FocmJQ?=
 =?utf-8?B?TktHYjAxUTU4dHZhMTdjcVdnV1lsNEw4d2ZLNVpuMTFjWTJrMWhrWjFRamRj?=
 =?utf-8?B?U2hKdkdSWlNMcm1jMHlwcDJTT1RHU2tVSXArS1pUS242RWNOdlZuVlVYTkpl?=
 =?utf-8?B?S1g1WlRsT1ExSDhQeXZITDJRQWJyRnBYV0ZKcUxWV3BRcmJUM3VJVkZDNVY4?=
 =?utf-8?B?YkJad1kxZk1reGdnbGNJKzN3alpFWXcyRUxzWWk0V202Yy9RcVJLRm9GUFNX?=
 =?utf-8?B?bmFFUnJqZitKRGJUenhWNS9wY1JrMTEvOTFEbmUvZGxzRWs4emFLblBMUUlk?=
 =?utf-8?B?RVg2YjlHSmRLUkEvck9qdjZQY2V2TjI5MFQ3WDdXOHU3Ky91L3QxNklNYzg4?=
 =?utf-8?B?NFBReVUwQ3cwOHRyTW81dmZOMmxKZ1BqVnpCdENJWE5oUjQ0UHhzS0FIb3Bl?=
 =?utf-8?Q?kGFBZj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2ZqaUZrY3B2KytxRFZHdGNXd0lFMDVEMUtXejhVc2dXdFRiY1JiOEl3Yk9k?=
 =?utf-8?B?MkQzY0lUNUR2UEFhT0x3S09EOENxUmc1bW5HdVpzeUdtSllKMTdBU2QvZTJC?=
 =?utf-8?B?Z1c2SjN5ZGJ2NEdaRkxPQkU1bkJuZGgvVkhZR21lWk5DS24ra3Y2dUo4cEpk?=
 =?utf-8?B?cnc5SGNOYVJJNXhRWjIvNHZhVnMxb2N2MlhTNjFLb3k5RVhLNDhzcGFacVhr?=
 =?utf-8?B?YmtpU2pnc1JBNjVJL21aUm50c2NyZ2RvZEVvSDBHa0hUbk1vWlpmK3Z2c010?=
 =?utf-8?B?OHNXRVBuV3pWeUF5OU9ETUUvL2ZHOTZZNlBLVGJPakJGRHVSZi9ZTFVjVkI3?=
 =?utf-8?B?L1l3UGhMc0hKUmxVaUpTcmJpa1ZnVHdGYnNvZ3c0emFONTVteDJ2VDVzWDFj?=
 =?utf-8?B?R1FrRG5aNW01bGpPZWIvSWVVdGQ4ZHN4WVN4UzNjNWVTYmduTmExTkl4ZnRJ?=
 =?utf-8?B?cXJZOVJ6NWF0NlhYeHI2Y0FMUHluQnVEN3ZJekVOa0Z6bEc4MnREWVRoWm9L?=
 =?utf-8?B?VWV1NjNVcytzRG9wSDlQMS9tNk16WDBGREhVdHg2UHlTaEFBZ2tjK0s0Q0t0?=
 =?utf-8?B?MGNZcFJ5RUdaKzVaTmJOTXFITlAvSzhVUVhhVlpjQklBdVBSWDYwdUZ3Zm9y?=
 =?utf-8?B?REVabFZ6V1ZnZkEzS2QvQzkyT3cyWFlCR055QzNweDYwenVBUmg3aWt2YWwx?=
 =?utf-8?B?a2pERTV1RGEyL2o4d3lLaUlGRVlNV3EyZGJLc3NCNVlLRGQvVHgvWXRsYmM2?=
 =?utf-8?B?YWpVL3MxdmJYMzBKYTBBbitPUHNPd0YvcTQrQ3pPMzIxdnhhNDN4WUo3bDZs?=
 =?utf-8?B?ZXlMOFBqazdkN1lxZVdpRGNJTHFLZXFwMng1YzQrU3hWOVpVK2tLNnhReUl6?=
 =?utf-8?B?U0pYSVptZXZoYVlDNEhiSXh0UDgzYUVZWWF4c3RIc0RKSDZSWE9qekNzbHo0?=
 =?utf-8?B?VEpVV05USzVQV0YxL2IwUWI1Z2I4eTNIbUthUkJZQTJ1OEM3NFgzd05WRGlS?=
 =?utf-8?B?SnFSb0k5aU9lVXlBSEFOL2I2QzhreWtZY2o4clhkOHQwOW1JODV6eHdXaUdq?=
 =?utf-8?B?RHpHVEEwRnZVWDBGeWVnbkwvUUhIZVRpQXFUREhScXdWR2h2OU5LeUUrYUU3?=
 =?utf-8?B?bWVad1FkRnRFbmNxSXFXYldVdisvaFcwRjdhSUFOSmVPdktsczBCSWQ2cVV0?=
 =?utf-8?B?aVNldWRQSTVyNXNZQ0o2VzhtRDIzSlhkTzVoZHJNemRqaUxpL0Q1c283T3NI?=
 =?utf-8?B?a2h5dWo4RG40dm1kSXNTckZuREQwNW9wWVVTYnBJL2x1dkdFd3JhMjQwRzIv?=
 =?utf-8?B?Ui81K1dIMTBVbGFUdlhDNmhURUZnMHJkVGoyOTIwd0plejJBYVUxNjRCY0M2?=
 =?utf-8?B?YU13YVYyUU1tYXVuTkh3QW12RlZiQTZZR3JtWlVseTdTMVQ4TkJHcCtCM1k2?=
 =?utf-8?B?T3BjZ1NHNkQ4UEdJaTUxZ0ZreFhEZ25MY3g5OGpiMVlmNVhLTGRaUUhqZnJy?=
 =?utf-8?B?WjhQV29kallxVEJld1VSR3lEcy9MZ1o5SUlnK1ZHbmFqZ0RqTUl1czFxbzhN?=
 =?utf-8?B?MlBicXVYTHBscWhNK0Rmbkt0cm5TZEpiWnQ5NDRzT1JITldCWVBUZ29EQ0Rx?=
 =?utf-8?B?Z25SR2xZbi8rNm9HWVYzRi9LUVJnNlh1VzZPWExZRVliRzBxZ0JBNXBmVWRM?=
 =?utf-8?B?MWpkUHdhRitBRnJVYXJuU2pZaWNVV3FUaURyK3hNVUxCYnZHL3U2YzRrV3NS?=
 =?utf-8?B?cTZlbW9OaGxhOHB2ZEUvRC8xVCtYOXlsQzV2emdNa3VGdXNTVitVTEM3emYx?=
 =?utf-8?B?M1A3S0FNM3M2OGE2NTRDYjNXSUtCeHcySXdBa21LREgxUmdObG5CTnJjQnFU?=
 =?utf-8?B?N3RXeHRhOW5ITiszWThCRU9lbWhBZVRCQmFxeklQdm9CaTZ5YStuRjRKY2N2?=
 =?utf-8?B?NWdQZ3NDUmtRTEgyV3k0QWw3L1ZPK1FPWkhGN0lTL0lqUzhMcmNOR1JKMEtl?=
 =?utf-8?B?Z0xxOFdKMnZjSnAxd0RReFpETVJuemNva1Nhay9VS1E4QXgyb2FVMjZDY1l4?=
 =?utf-8?B?SGdMVTV4cmhjekZtRzhvc3VJYnR6Y1M3Sk1vRVdneWM4SzVPS1lqQVBmMEto?=
 =?utf-8?B?NjVBL3Zwc3piMW5vcERYV1VLTWw1UmRSTWovNGduY0lDcWhBR2dBaU9wNUsw?=
 =?utf-8?Q?qU86y2kR3eI61peQR+4w+1wb7NOcyTv2rj2dpibgk1U8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38E54DD8CA6AE14EA7ADCEA34824D1EA@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc809ca-1c2c-4a26-c581-08de21745d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 22:47:59.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4tuYk9aoLSH7Nd4dehasEXf4X9FT/PGRuVRozhNuO5wTHqdGOGznSAYWqNHvhRbS7tDk+YXEygYvfHoKqcWtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716

T24gMTEvMTEvMjUgMTQ6MDgsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gVGhpcyByZXZlcnRz
IGNvbW1pdCAzNDUxY2YzNGY1MWJiNzBjMjQ0MTNhYmIyMGI0MjNlNjQ0ODYxNjFiIGFuZCBmaXhl
cw0KPiB0aGUgZm9sbG93aW5nIEtBU0FOIGNvbXBsYWludCB3aGVuIHJ1bm5pbmcgdGVzdCB6YmQv
MDEzOg0KPg0KDQpNeSBibGt0ZXN0cyBhdXRvbWF0aW9uIGRpZG4ndCBjYXVnaHQgdGhpcywgbmVl
ZCB0byBmaXggdGhhdC4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
