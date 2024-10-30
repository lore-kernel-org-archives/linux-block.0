Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90B1BD9F4
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313102; cv=fail; b=gt4nh+c0W1Si+0TsHrIdzz9TCrUYRO0vnn/ZozDSOm5/0MG10QHieIiHT/EepHNbMgAKGx94vPLNrH1rrQVxKSo+P3DebAxWXyGlOeal84mHETLknJw1und9XMDc/vnm4XUpJGwuEl9gOEgom77rNerEOhAvyQCfqUBQMcWDGJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313102; c=relaxed/simple;
	bh=YcxSfu9Hf/dAyr3v7PNqavn3M9PpZ1deXCj0A8elMKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDf03vRPBepdEzcqFTI8P2ZgZDxvGsQ8wCRX5AAc0QStspjpjzfQSu9L+q3BdQTCKWi9an3UVwLTScTbbVYvcawdq0Gb2uYUuqCr2W/vNA5WakzxlwzHw9VUt5d4W4AEnnbMT2KaETL+G0gSDrpmjUPTkZpbK3HKv4HHyTOIjHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eBfk9Fx2; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eBfk9Fx2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHe6JAOThkfKNlFofaZc+uu+XzmS9ikUIx4jQ/jUMRW5M8crLg2rSvqRAW3/Lac650U7ZaA+hLGBwUFsgLjyogL8Go+wcmGlCe3cOZl7u4qzUvoXlVjP3oSnSaKbzLNHuz3hcegV50gMd7x23Zq22wQpSeqbZLFMDczOHAPR5UnzoC1+5JL0Zfrgvp+6TCkztJS4/bnhcGOVprndcYxh+VupSlo/K04goyT0IjOS4y6ZMlkC77h0WLRW1G0h+KaOwt9mc09WaffGIK9hVoNsGTpPB56VgA2+jYjfuBLmpPtB7vz8uFzOtW7YZFVRnPt5hR6B5XLU7N/SnIQ72UM0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcxSfu9Hf/dAyr3v7PNqavn3M9PpZ1deXCj0A8elMKs=;
 b=sLaZZV+aByGQC/p+5X2GCEmJ6inXaC9NV0/CvxZWSycp3arnyNvcnFkllvfWr2bVXfdwPA8eRCB8f89y53hne1QrEW2+lcAun+ne1hT4XeTTup2b0iPPvKGpQJv4ydXN6ZKAF7FKDwsKxzhoxMGWiztDQRXBFCUAzrePyy9b7ss/Ognc38u77Q8+LI55LLFe/e6gkgeXXfgpuTnkq40cnTD5BNCERD+RiwfluyUoIJ7Apm/HlI6UDsBAKX35onUhHrUFUv2ncYY75yRBoDqBZrCzo9MwuKM5C/BLV2HlX5Oa1W4kARtAvrQpV7LGval9UOdvxykf9uNYjP4NCHEskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcxSfu9Hf/dAyr3v7PNqavn3M9PpZ1deXCj0A8elMKs=;
 b=eBfk9Fx2Va0LpdFioEyLF8iqE9BJs2Ih9b9YlwkXcY6UJ2CURGYW9+cGVNVjUckWGYg6QDBgFsMz/Xs5+hQlU3YlOeTckq0B09IJFlSAMxeMzTuLQCGkEN1R0MBMEyRAhrMZpmzypMjWIX8s8YJaEuXZYIQtrZ36Mc/xdQCzQ21GJQ1bpDR+1625BbqETsgvomStIn2Wyq0+rsIWvUw+Lg4NNvMl7OWeskzIdLehYbyEhriizKJFVaFoFmn767S3BSJhRhNKJfTwGGplmtJOcDhqari9aENaGF7Bb5ys3K8JbYGBjGcSoD80gEYsHJv2rkjiaoVdkAytrqA7kK/qwA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 18:31:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 18:31:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Kundan Kumar <kundan.kumar@samsung.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] block: remove bio_add_zone_append_page
Thread-Topic: [PATCH 2/2] block: remove bio_add_zone_append_page
Thread-Index: AQHbKotBmkMADGK/BEmVHE4a+yCf+bKe5jAAgABpHACAAE+CAA==
Date: Wed, 30 Oct 2024 18:31:34 +0000
Message-ID: <b50e3a70-3d34-4ed2-850e-f43cb988a7df@nvidia.com>
References: <20241030051859.280923-1-hch@lst.de>
 <20241030051859.280923-3-hch@lst.de>
 <790362cd-dfbb-4ca7-879a-68463156b69a@nvidia.com>
 <20241030134700.GA27762@lst.de>
In-Reply-To: <20241030134700.GA27762@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7127:EE_
x-ms-office365-filtering-correlation-id: d32a8db8-9f56-4314-2a53-08dcf9111583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3RBQi9iSjF4Zld1YzRyWkVxVklaRkwraldld0dvZlZ6cWhjNnBZUDlFUUVH?=
 =?utf-8?B?SW9pY0N4ZnVIa0V3Q3dGVXBpaWFmUzRuZjVGbUZyd0FNTDdNa3pYVjFGeUMy?=
 =?utf-8?B?YkxJQXZ5Sk91MG90aGE5QjlqbVkrUlU1WHpWenVFQ2pXajRVQVkySWhNSm9p?=
 =?utf-8?B?UTlWQXdTR0txQkYrK0tETzdvZUx0MDh3aHhvVGpKYUdHa1pIdHNzdHUyZ2hj?=
 =?utf-8?B?OFJUd1dLL1ltUFVCemxXZXl3czdNS1FMRXNnVk91S21CbU41dG54cUZRZi9z?=
 =?utf-8?B?aFI5MVFCZG1MSHd6dW8wS1A3NEhCc05tazk0Ui9jZUhDWkFIekpRcmFqT0sy?=
 =?utf-8?B?L0dhN0psS1AxdXNaQldWL3RDaVlZWUZzdWhRQkZZU2dzTUtuSmVUWGtlR05y?=
 =?utf-8?B?di9uU0RGUkR5NnZRQkovejhFREZicHpobFg0K1FjVDJvNGUzcUJWSGgzR0FC?=
 =?utf-8?B?TW5iVUxubll2RDViVnptTjZESmlYM2lNbFdCbldMUVRaODJDYmc4Z3ZWeEFx?=
 =?utf-8?B?Zk1WRnZNenhaMnJ2anNUdSt0ZUdscmhhczYxYzFUMU56UWhucDMyTUdSb3J4?=
 =?utf-8?B?UDc4d0VNZkhQdGhaOHFlMHcrbCsyMEMrZ0s1UDdjUWRSdVRoV1BtMTRBTUdF?=
 =?utf-8?B?RS9OSC9laWJOcUgwY2dxdWYwR0VBaTIwYmpWRlZxM01BU2JHbXJQSi96d25p?=
 =?utf-8?B?NFFwWVdTalZQa2QrSjBrdW9YdXF1bGtFU3ZvajI1SEJxamFFYldKVitFWVpn?=
 =?utf-8?B?ZzhLYW9OMW9jcXpZWExtN21nNjNUUHZsc3RoaEs2eDZZbVZndnJxTkpCeFk4?=
 =?utf-8?B?YlpFVE9PVkhBNUVLbW1nMUd5TEI5Z0ovMUlFbXBDS25iRTZJQkphRFJDekpz?=
 =?utf-8?B?WUlHdUVIeW0rRlIwMktVNDJyZ0ZOOTdIbWkvQXM4Q2lYOG9rZHNyWVBsSGIw?=
 =?utf-8?B?ZkwzQzNPZlY4WjdXNWZNNERmYnI4ZWdCTDY5TXZzMjU2SzdHeTdmSzBHbWM2?=
 =?utf-8?B?aDlEK050RnRZRVVSSlVxbVRWbUdQZVB4VVR0SE01R3FDdFJmdXhia01lajE3?=
 =?utf-8?B?Mm9jcmFsdmpML2trNkltdi9oaURuYW9EYldEU1oxZFJVMUVtbVYvdGI5NVhm?=
 =?utf-8?B?cGJaNmJ3Rk5EakpoamFaOThBNUd6dE5rSHZjZURob2poZEFVZ0hzZnQ1UDZ4?=
 =?utf-8?B?MmFVd0ZUbUsxN0VrRlk0bUsxZ0VQRzNFVUZnRU13Y2tiT2FVY1IwTERGU3M2?=
 =?utf-8?B?RFZuL3FQQWdYZFFONWp5YUhVOUVkYVovT0pPVEM5V2F4V1UwSWpRa01LVVZF?=
 =?utf-8?B?SU5qbXFvRFk3SERDdU5VZ2o0aG1LQ2ZKenJxNFU2WEN3WEg2VUo0RTQyK2tn?=
 =?utf-8?B?LzJrb0E1a3NuMmQ0YVBmVG85c0JIbEhTL2RTY3RmZ0xoaUF2L0h1NlR4VXBi?=
 =?utf-8?B?NG5aR1ppL1FnUVdOTXNYTWM0MVh3dHl5UWhDaHpMd2tBbmdQeDVSSVhjWXV1?=
 =?utf-8?B?cG4xbUNZWXpSUmtYNVMxQUNldjdzandsR2FPdVpJUGs3RUZwWHR4K0xsRXAv?=
 =?utf-8?B?TTJpeUsvaEJhVElZakF5ZFM0Wmt1VXM3ako1QmF1OTFYaENMOTdOdElKZUsx?=
 =?utf-8?B?cktJaHpjK0FxMXRacFYxaHNGcU5VZU5YUTNjUzg5aHVnTFo3empsZm1wYlk1?=
 =?utf-8?B?OXpuanY4ekJVdzhRNXMrcm9QcnZpN2R3R282QzZ6WW9SSUdpU2kzM3VxZnhw?=
 =?utf-8?B?SDlPUlJXbk15ZU5XWEFPUjkweExmNXRPYmFiRDBRM2dDaTdWS3JRQ1dUSGR2?=
 =?utf-8?Q?Y37KkkUSTYhVrpoqvX6+a0HiSoUZrUDTrfehw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkFOYlZJdXJ3MXhWdklqcjVSWEJ3YWt3VjZJaVdxZGlwT2NmZW1sWDNiaXZC?=
 =?utf-8?B?WFJIUDkrNFBVaFRkWHg1a1NGT3RSMUdNcEJOU2w3aXJvYkdPZHRYOUpvQjlX?=
 =?utf-8?B?cXFPSExTUHlaN3U1NEZ1SDQwMEhNTW1VUHNmejdWcWhIMmJPRDBxaGV6M1NG?=
 =?utf-8?B?alhYNkxRcUt5a1lxZWcxNURmYmRqcGpJZHRac2JZdjJJcXpaRWt1M2NERDBC?=
 =?utf-8?B?N2NVWUEyNS92WDI2ZzM1WDRmRi9YcnZSdXpKQTNaNWFjbDhiVUVDelV3cHpk?=
 =?utf-8?B?Q2NCSURjOHlGRDhNWm0vVnZYczhPdVFDOEVNR0FUMExJZzZtZ0tTQ0x5TjFX?=
 =?utf-8?B?ekxrYTlSSis3U0JtaWdFekNSNjVwMmdid3oxK3VZSW5aWFVuMUttWC9oZ2ps?=
 =?utf-8?B?dkt2R0VVeEVoazNyV0dWa2NLS1MxbkhHeEo3dXc0elZoSmNqeWFBaDlHMnpI?=
 =?utf-8?B?VjBHdnFwMkJvVjI4cDNmaGhBN1psMEhxQ1dXQkdQZFNMSnhpVjBrYXdRRGc0?=
 =?utf-8?B?N29ocmtwTHdVYUFJZWUxS1RheG56STcxZFpBM0FzejFNUSt0QWtNUi92SEtQ?=
 =?utf-8?B?UFVzek1Jc2NuUUZCYUlpV2xSWEpmNXNpL2ZEMDVmZit4bGcrSGIxSGhqQkZy?=
 =?utf-8?B?OUtORnArWVRSZ0xyc0hMWnhZckFjbE94MEo5eUxsZmFTdjZnL252dk9rRVY5?=
 =?utf-8?B?YXk2OWV2bDk5bWxaaU5IQUdvc2I0bU9yeFpsK2RSb0VwbVoySTJUUEFySWto?=
 =?utf-8?B?c2FUYWxGMHJaenpFVGFPVm9lNXhWVFI1TlVJZjYxTFp2cnVuNk9sZjhkT2Nn?=
 =?utf-8?B?emhkVlR6b2E0OFFNbHZiS29NRzRabnlHS2R2SkdSVmdXMUVROUV5WWlwL3pu?=
 =?utf-8?B?OFltUG13clRxTS9jMUhHZm8xWkttRVRJNHNicDRkUVhCME40dmVxVlp4cGJB?=
 =?utf-8?B?MWFTQTdLbjdkdnU4b1FwdUlOeHFDSlNZcXo0dDBleXRudnF0MEFaQVhpYlBT?=
 =?utf-8?B?cXp3OVFnaFZRZWJ1Y1B2MlRSUVZOdE14c0lhcG02RlRnUVRhZVlVZzNBTVJL?=
 =?utf-8?B?NUxQWkw0OTdyMXgxVWxFUHpNTUhPZUZnUFVScE1HTkEzS3dhTWhpeEFKTE1C?=
 =?utf-8?B?bGJJMExpelZ2SExMdERIRTkwRDBxN2pJcnRHZ0hhZzhibmViMDlXQ1Jpa2Nk?=
 =?utf-8?B?MU1FMGc4QUJnbTdmK3UxaEtsNWNNTXNGdGI4RDB2VlBQSWJseEVOQjdDam1k?=
 =?utf-8?B?akZCYVRpZFpybTJsUXZHbnY3WU5NUWRic3NxdEpMbWl2dEl4cVpmM1g4MUg5?=
 =?utf-8?B?eUlIK0V3UWdYaFowSGVCK2kyNHF6RExKZDRDek91Z01BVlFUdVFyeE5vaDZJ?=
 =?utf-8?B?V0thRzZsWDhMYm55MGxQWDdwQkhtVWdrM0l4ZmZOUkVSYk55ZVhVZStMeUZW?=
 =?utf-8?B?V0ZmQm9YRnArbjk5YVdtZFprZlF2QVhxOWN5dmUyZ1pqRWlScXVKTittZHdT?=
 =?utf-8?B?Nk80QTV0dldvRFM5Q3VTM2NueS9EZUdUNmpCaGk5ZGhpR2xzRCtBczBCMWls?=
 =?utf-8?B?UmpqRVUzMVNBVG5YdkYxUnI4TzlYVndvT2x3MEs0L2c2RDFsZDUrNGlaRmZO?=
 =?utf-8?B?emRtRkgwdHI2bEtGN09leXk5dDhZalE5OTQrdG1yMGZnTHZRdTIwUk9zR09H?=
 =?utf-8?B?alBqNVVCWXVjbS9URjArdmFjcElEY28vY3pZUGgwMExEYTZRYzVJVUhSbDU3?=
 =?utf-8?B?My9PV2JWZnAzbDBYeXU3c2syZThxNUJPTSsramtXUTg0dDc2SWttdCt3VFRl?=
 =?utf-8?B?L3JRY1R3RkdLOEZ6SnA0WnRyNHpaYVdjeE1TOXZvRkZndS9mRzYxVUdiZHo2?=
 =?utf-8?B?c3R2SlhpYVpqcXgwWC9Ybit3NVF6alRUVkVCM0tSZ3pCTUltNWZ6Yk9GL1dV?=
 =?utf-8?B?VHN6NnNDb1RGZlRnRmFIWWlPbklQTmhYWDg1VjBmRG9DeldxNXU0SElYUXB0?=
 =?utf-8?B?M0NvbEg2ZSsrU3p0L3JiQjNqcEdnM0gxT1lwb2dEMVp2cVpaWjRNTTR4bmx4?=
 =?utf-8?B?K29IU1dSMzZZWGZIZVh3QnlMTnNBSUt3L1JoRUNyQVFUQ1ZtZ3loaHovd1Yy?=
 =?utf-8?Q?tAwQaahJwK/gF2DXxOWqsCvkg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FA6140F7D9EAE4B972E116218F2437D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d32a8db8-9f56-4314-2a53-08dcf9111583
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 18:31:35.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxVH0127gJFqtGLmMbRgneE1iUoH5fE79fia8pFrNVHfcxkjUsrpkiwYdMAHAkclmHxgHkQUTkXI8JzEmPcKrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

T24gMTAvMzAvMjQgMDY6NDcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQsIE9j
dCAzMCwgMjAyNCBhdCAwNzozMDo0OUFNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6
DQo+PiBpZiB0aGF0IGlzIHRydWUgc2hvdWxkIHdlIGp1c3QgdXNlIHRoZSBiaW9fYWRkX2h3X3Bh
Z2UoKSA/IHNpbmNlDQo+PiBiaW9fYWRkX3BjX3BhZ2UoKSBpcyBhIHNpbXBsZSB3cmFwcGVyIG92
ZXIgYmlvX2FkZF9od19wYWdlKCkgd2l0aG91dA0KPj4gdGhlIGFkZGl0aW9uYWwgY2hlY2tzIHBy
ZXNlbnQgaW4gYmlvX2FkZF96b25lX2FwcGVuZF9wYWdlKCkgPw0KPiBiaW9fYWRkX2h3X3BhZ2Ug
aXMgY3VycmVudGx5IHN0YXRpYy4gIEJ1dCBqdXN0IHJlbmFtaW5nIGJpb19hZGRfcGNfcGFnZQ0K
PiB0byBiaW9fYWRkX2h3X3BhZ2UgYW5kIGZpbmRpbmcgYSBkaWZmZXJlbnQgbmFtZSBmb3IgdGhl
IHZlcnNpb24gd2l0aA0KPiB0aGUgc2FtZV9wYWdlIGFyZ3VtZW50IHNvdW5kcyBsaWtlIGEgZ29v
ZCBpZGVhLCBidXQgdGhhdCdzIGZvciBhIGZvbGxvdw0KPiBvbiBwYXRjaC4gIEkgY2FuIGxvb2sg
aW50byB0aGF0Lg0KPg0KDQpzb3VuZHMgbGlrZSBhIHBsYW4sIGxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
