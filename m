Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473385227;
	Mon, 10 Jun 2024 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717991090; cv=fail; b=RyS46Jyu556xw/rI4/PWw5iJheGEzsXoSPmQ1R5ANaynyRquHvJL1qsL6TlSZa+2lYKjODUWUDjSowhnof2kMT7EtDDjeUrzpPZA0pvi03Ottpr1JAGKVpp0kPHOWbIxj3pzHp1aKKvVU5jwRPOI7xoxL4/Qz8/ICcrjZ+FW4Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717991090; c=relaxed/simple;
	bh=QT1o+iMa1Uh18UvUB6snqRKNOK50R0QGt+lmvzk0Ojk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jOy4JI4ERR8xiZ3YG6tQQxtMnNCc60BJWKElH4V3qj9ZTR/LwWKqB0obf2CY1zJMGwdbL49wGPjlpd8ZVtvK+mmulVPWGrMiJZOygoWkRCbnxO2UH360+cmpej0LtoiwxZsgEZvVYtPNAKDsSAgPhCsdATyIeizfPwNve7mkBvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UyXd7nQR; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UyXd7nQR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFerbxioxV5tDH2JcvfGYhSGkxTIibrcZnY8DRo7assj5TqIPTDRs3DJzzq3snPuNhKVsVlt9ZTFA8lOyNGSu5K6t2IrQuxywqNyWkOpJuc5Zi4RY52KG3uf+0JA9OYUaLZ6eL2YrUg/vBrE+uelcCuqc4+rfFeaE/SZkShJSQEZvT/UB4vX0flacae8ZpBlserjjCEfYEcFyKo+BnJUGSbC039NuEBCrdiaQrFFhf1WCSNzQ9elMkbsW7Djw68r2vz0HA1jYBrK3Vfmd67oE6JjIv76rSI6q6EdbeXCbiXzvGSCoUytWqKplMT7cKuTLD2wgCXVHW5wR5+vPAMCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT1o+iMa1Uh18UvUB6snqRKNOK50R0QGt+lmvzk0Ojk=;
 b=EvHGilK/+fss9FeZl9WbP54rbHVdMyMk7G/3qYcgafo49ZmfaAHk75TaZ9RvUvdWp7Sb3BTiHY04C2cbLcoTF5kaPhuh+w1legW7MO7TJfYLnfveWxaXYLteF1NNCDLgu50bQ4A3XJZjY9B7ddutaDBZMOcrgMFELkEsZexMJ5Bq0id+waihma+U3fGUWJ2JsB3f7xiEYJjzO8wq2qJBmrNQBOGa6Lm6swxoknVuO6vgzAQ62Me+7WvEXgzNoWpD8pacHpj9cu5IzqsJ6ij1ufCBQvbuoTOWvLbpke8ubx69/dCCuA+l5XWhMZ8oKgVXAq6QjrcAkhoYAnU2zjRIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT1o+iMa1Uh18UvUB6snqRKNOK50R0QGt+lmvzk0Ojk=;
 b=UyXd7nQRvLScvTl5jNMg02ca1L/AjwMX/6436YmUYWjvfWT+LvZShS0AkQacLFUNWyu0go0j9re1TX7EWZiq2i0dvOhmPlCRavJDGfIcabsvK9cTkWRRUmhQtfXeasnnSnF8fCY1uc4QnHfe6VJRHvrPN/mUqG6yQVWH1Zvs/ozadelGLftFhkJGJHdiwDnl+3OKq44N7ID5CB4bYjyhiS2ZTYHOjDYOx1T0yh+G74eV6R5vWhJGaNNAjtGep+87rpvPUC8NbILPOt6UvzHHMx/FykecU5kbg6EYPHcMA5lmmF7qSY+AXDB2dEIN2oWmSUAE5YwulU4orsEgnBctYw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 03:44:44 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 03:44:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>, "hch@lst.de"
	<hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHauQ3RH8+/LQBeJ0ughV/pktVvVrHAXvOA
Date: Mon, 10 Jun 2024 03:44:44 +0000
Message-ID: <ed3ec0aa-04a6-43bc-9a1d-5c15a5a46643@nvidia.com>
References: <20240607190607.17705-1-gulam.mohamed@oracle.com>
In-Reply-To: <20240607190607.17705-1-gulam.mohamed@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8699:EE_
x-ms-office365-filtering-correlation-id: 3abaaa39-3a4e-4ff7-1079-08dc88ffaab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ti9HVEozRERjNURHR3VkV3h5UURRUnUxZ3R4UjhFU1hCTWJzRXF2enYvQjIw?=
 =?utf-8?B?aUZiTDhNTGVHUWwwd2tOS2dISHpQcU9ZbjhWdHkzeVErS3MwWGpaV2tYN294?=
 =?utf-8?B?T2lZWFdjOUs4bk5KeklUbk1sdkQ1eFJUOW1SWS9CbEN2TUhqMnRDYVhUc3d2?=
 =?utf-8?B?R2FwcE5raXVkRm1Baml1bFhlbU5pVGVhbG54WHhWM3l2cS9ib2NmdjZ2bWRV?=
 =?utf-8?B?aUthVzRLU2IwNkhrd25mL2JYTHAwdnZpL1NRY0xkcm5maElDTkk2SmJEajY2?=
 =?utf-8?B?emp2SDN1WWVhZWtZc2lRUk5YOThQYXZjUUNEdHY1TzFpcFMremFIbUk4ZlFL?=
 =?utf-8?B?ZG1qRHZ5ektYdGluZCtBNm9zZndjeGgvWG11T0tldkErbGNwbHYyUTdaRGIx?=
 =?utf-8?B?NWhXNXkzMmVlQ0NRWU5iTDR5YytGQ3h1dlB5VjJkaXFZL1BoOFdQRnhnWjdv?=
 =?utf-8?B?K1A4MWRGWm85c2lYbzRxVFJFTDQ0dUdlM294UnBSMEFZQkM5T2dkbU44Qks3?=
 =?utf-8?B?SHRaNkdrVlFWVy9ieFNXOWxHYWFBNlp2QWp3ZXZFK1N5QjZuN1pGYmJDcDFX?=
 =?utf-8?B?ZnR4NHRabXpBMWwvakZ0Snh2TkNmT0FmK2o1OE42RGlqUWptbHhQU0JXeVd1?=
 =?utf-8?B?OFNuWE8za2xUOFRWZEY5L1dqak1ldkZMQ2RoVE1xRjZROFFMVDNISnBnMlpQ?=
 =?utf-8?B?TDhJenZsQWpUWW9Zc3hsaHQ0RmNlbkFEZ0Rja3lXS25CZGlKUEc2WGYzajIx?=
 =?utf-8?B?dzYzTWp5bTJWbC9FZ3d5LzB3dytsc1FYK29iaVZXZkZUeE9ncCs3NCtMTXpk?=
 =?utf-8?B?K042c0p1WmI0d3BUQk9yMHdrWVM0SFFUeXFhUFkrbmpBVS8yZlo5aHVDelZO?=
 =?utf-8?B?NkhMcG81cUNYN2tjZnd2ZC96bW9TaFk5alNiclhacU5qaUNSeWx5NXNDZjlH?=
 =?utf-8?B?bVdxNzdRRzU4enJjQUkwY1BTVnJYSmk5K2wzcHN1MkNIUE44YVRTcC9iRlZR?=
 =?utf-8?B?SlZOSFdlanJkNGJWWnBDYXZiS2pvZ0xkcFcwQnNCdlJpSE4yY1BLY2hrU2Rx?=
 =?utf-8?B?NXZBUy9LNlNJSEx3TTM1S3NtYVdycFNTUXBZRDhLT0FUUDZRcmxVbnFhMzJo?=
 =?utf-8?B?Q1E5bGpHYTluSE9xcUZCcHVncy82dVFLR0ZoY1lEOWJ0V0tzQTQwZmExcmVP?=
 =?utf-8?B?Q3hla00wZWJvUVdoay81VHRISVhYZ1dDamZsS3UzRm16T2g5ZytCQnJHY2xL?=
 =?utf-8?B?bWZxcWsvdDY2aURiNFdlM01NL3UwS2I4QUxGeDFtMXdOcnN3QlpMckgwRG1T?=
 =?utf-8?B?OGpwVGFJM3ZpQktqbXpmZ0piV2RINHJuVEVGUWhiQ0Qxd0JBR053VjlTY1Bj?=
 =?utf-8?B?Y29EVlRlMlhKWm5FVFBUY3Q4aEhBbjN1RmpzMTlxVzYvenMwZ0ozelkzMUdD?=
 =?utf-8?B?Y3N2YUlNcWY1YkZkSzVjaUUxMWM2dmFPMU9NMmpXM0VjeWROWm9veUZKZ2VD?=
 =?utf-8?B?NWpXa084VURkcUR5bjNpU2ZadjJWV3MwU0lKaFUyTnhpNk0zblZIa1J6Tnlo?=
 =?utf-8?B?NjNmYWgyNHdaeUJ6dUpzOXdvdmljaWhsc1VkU3F5bkF2RmxoSXd5Zm5JSXNJ?=
 =?utf-8?B?azZxSnFKL3lhWkJnaTVqdFdiS1VlTS9OVFdpTGFFaTUvYnNKWElYK2tkUEFt?=
 =?utf-8?B?OUYwY2Rqelo1VExIOTNqa0IrQVFPamlEbDdST3dhbDlnSCt1bDdMSFlwSS9u?=
 =?utf-8?B?cVpJZUtwNUdiNXJkMmgzRnY5OXFQNFZ6Ym9SM1V4YXJJb2pMUXhWTzBabXVh?=
 =?utf-8?Q?65qbSFtq6H96U1PnH8NYYm8nxk+/UUAbgrFpk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akp5TmM1emJiQW1uZ0ZDSzFUVFFta05UbXprYjhFbllMZkhoOFM1QjB0ZC9X?=
 =?utf-8?B?Zkt1TmpwZ3U1VXJJVmw1UjVSekQzVHQ0SDliL21ta3Z6cFdOL2JYWmoxUk9M?=
 =?utf-8?B?TXdBOVU0OGtXMVFOZlBqcXR3dW0zT3JSV0xJbEVMVWF2UHhiUnNVK3FDSUxa?=
 =?utf-8?B?cVg2RXJ4N1FXaVZPSVhyVG5Pd3h2OVFudVU5Tzg5ZzZGT2xWZWNkcmNzWXJB?=
 =?utf-8?B?K1B2SHJuVG5wR0JuUm1vdjlSNUx1T2hUajZkWTRpSlRZWk8rcEIzL05yY2xY?=
 =?utf-8?B?MUdwN3YzdWRDbnJndDFXdmNKREt5MjlLYzNCOTdQYXR2N3psRkVHUDFkN2NE?=
 =?utf-8?B?T1paYUhNYlRvRElxT0I2QWVFaTM0Zk52YWlyaENZOUZ1R1pOTnlRbE5Na0NL?=
 =?utf-8?B?ZkYwdXRhS0VKU2JTd2MwY1JuMTRITHMyQ0V2SmU2QmU4YVl4V3haanZSV0xl?=
 =?utf-8?B?TW5MV216cnlFa29JYXA2eE9VN3BYblh6cHV3OTVXSUhKSnc3eHpBVTVHeWM5?=
 =?utf-8?B?eXZXVFhuUzQrWHBtTDRpUENqay9pNDdyenE2RW1TamVzYjYzY29PcVYxOXlC?=
 =?utf-8?B?dEZBL3NVNmU5S1d6TFZoSis1Zy85ZEdFaE5VVjN1OXp6eTV2a0dsc0lFMExP?=
 =?utf-8?B?Q09SVFJ5NWE5Q3ZOYTZ3WDZ5SjJCQk9yeEFmdDMrdjQva0IxbEo0UjltcGlN?=
 =?utf-8?B?K245QkJoMUVFZDZNRHdSSWNCbmVuRDFLOVV3Z0dHTStKMllTeThrZlBycHFZ?=
 =?utf-8?B?K0xPRjR5UVd2bDR0ZVhSeHBVV21SLzF0dXJlQkY4cElkNnpTak5YdS9HRVhG?=
 =?utf-8?B?WHVYQ29mRFUzbEhLYnQ0YytTTXJNbS8yd2JrZTFTMFNpQnFwNVA2dUNGRDV0?=
 =?utf-8?B?TnVoKzRlN1ZNQjhQQ1V4NHBsUzJGOVFRd3I1dUdNeXBZUndYUmE1UEhJQm1r?=
 =?utf-8?B?eFY2alV6RmJra0dZaFFlWXpHVjFNMTk0TVFocEFDelh3VkVFbE1oU1prSDQz?=
 =?utf-8?B?R2pTQWNlMlVveXNxTXVzdDJuQTcvL2NPRVdmMWh1dTJWUEwzWmJmN3g1bTZq?=
 =?utf-8?B?YTBhcFJVNEp2TTduRHp6akNUZVI1ZE1WZjhEd21GSWJjdEhJSW82b3pxdUVv?=
 =?utf-8?B?eGNzMHZGSWdSZHhPOGpnQVhoZ3ROMWlmK1k2RUQ4aXQxNEdEMHdpUW90b0Zl?=
 =?utf-8?B?SDZFdFc1UlV4bEthOUlkUmVMYUppK2tHYlB6VE03M05FK3BDSzFQUkVhajZ2?=
 =?utf-8?B?dXA5Z2lwZVR1SUNJUDlGUVNkQ1pPRUpXV1FPMjdSU29hdWpaN21DT2c4ODha?=
 =?utf-8?B?ZjB5cmdiOThOeG9BSnpOeEcxVmthdmh0RGdxKzZMUFBvN3ZLd1dNcXZOaVFy?=
 =?utf-8?B?d2QxNVdrc2lpRUQ2Um5XTFBlM2NNbCtsWnJoemdyZllmK0tKQTJLNzVTckVk?=
 =?utf-8?B?MzFXdlF3M1owbEJ0VEdHM3lxU2NrNE1jZnJhcDdadFN0eVNGVCswV0NmNVZk?=
 =?utf-8?B?VEprTUYyL0hNMGxuUis2VVg4VkFNYXVEZUxxemlxYmJUc2FNMkc5M1B3dENp?=
 =?utf-8?B?Z2hTT1UwcWFSL3krK1JkSEwrSTN3cnJ1ZGVKOXlqTTZaUmxhWXZMTEMwbG1R?=
 =?utf-8?B?TWVjWndwUnVPdnBWS3pNOUE3OUVhSkhTM0xZQTMyVENrKzVqUGY1L21kZE52?=
 =?utf-8?B?WVZGV2MyUGJQSVpHS04wcEhqdGZ4KzRWdGw1V0g0ZUlGMFJzZllDeE40ZFE4?=
 =?utf-8?B?VDd1dVU4aDNUYUFTQXI3TDd0WCtRbW1LMk5BNWRRbDVqVXl0QVZqNmNweTdX?=
 =?utf-8?B?aGhMNTh5dHlEVWh0WGZSR1pyaHdFUzA5KzlFb3pKcXBvRnByOWdHV3AyWVB6?=
 =?utf-8?B?SXVMTDBpUGNjRm5OQy9jZjV6dGhHNVBXbFNIMTBVZjZpV3lWUXdxTUx4T1Ni?=
 =?utf-8?B?Rm1aVmZqcFgyL2xFWWhES1dLVnRnTTRWeEFPWU04T0JkS3ZEVnJvVFZmalVD?=
 =?utf-8?B?dHhTa3UvV1dLNHlMR2pTRktrNitDQVUydVdXdHFPd0h4VzZ2bnhjNndrak1j?=
 =?utf-8?B?UVdPVDVyWmpiQ0FxdHhGRm95YWRtZzR3T3Q5R1lTQVAyYkxYVlRNSjlpSWQx?=
 =?utf-8?B?emhuMDB3ZTFOcEJpVjUzM0RpWFpIR2NEM3YrT0g0NVE0M3pkeUw0dkE4b1Fz?=
 =?utf-8?Q?w1ushWT5trfPFp/QK+QRVx9oyViUPYIyvHM/+O/myANK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFD57F8E796D0F4D9FDA0C260F5D2786@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abaaa39-3a4e-4ff7-1079-08dc88ffaab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 03:44:44.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8/ggdysmRMDJ507AZaF1YgxgZ4hCj3F00E1OytWuGaRZFb2eJ27E30Wlw7Bna+coSh+PfcWQrrfrG256AxO3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

T24gNi83LzI0IDEyOjA2LCBHdWxhbSBNb2hhbWVkIHdyb3RlOg0KPiAxLiBVc2Vyc3BhY2Ugc2Vu
ZHMgdGhlIGNvbW1hbmQgImxvc2V0dXAgLWQiIHdoaWNoIHVzZXMgdGhlIG9wZW4oKSBjYWxsDQo+
ICAgICB0byBvcGVuIHRoZSBkZXZpY2UNCj4gMi4gS2VybmVsIHJlY2VpdmVzIHRoZSBpb2N0bCBj
b21tYW5kICJMT09QX0NMUl9GRCIgd2hpY2ggY2FsbHMgdGhlDQo+ICAgICBmdW5jdGlvbiBsb29w
X2Nscl9mZCgpDQo+IDMuIElmIExPT1BfQ0xSX0ZEIGlzIHRoZSBmaXJzdCBjb21tYW5kIHJlY2Vp
dmVkIGF0IHRoZSB0aW1lLCB0aGVuIHRoZQ0KPiAgICAgQVVUT0NMRUFSIGZsYWcgaXMgbm90IHNl
dCBhbmQgZGVsZXRpb24gb2YgdGhlDQo+ICAgICBsb29wIGRldmljZSBwcm9jZWVkcyBhaGVhZCBh
bmQgc2NhbnMgdGhlIHBhcnRpdGlvbnMgKGRyb3AvYWRkDQo+ICAgICBwYXJ0aXRpb25zKQ0KPg0K
PiAgICAgICAgICBpZiAoZGlza19vcGVuZXJzKGxvLT5sb19kaXNrKSA+IDEpIHsNCj4gICAgICAg
ICAgICAgICAgICBsby0+bG9fZmxhZ3MgfD0gTE9fRkxBR1NfQVVUT0NMRUFSOw0KPiAgICAgICAg
ICAgICAgICAgIGxvb3BfZ2xvYmFsX3VubG9jayhsbywgdHJ1ZSk7DQo+ICAgICAgICAgICAgICAg
ICAgcmV0dXJuIDA7DQo+ICAgICAgICAgIH0NCj4NCj4gICA0LiBCZWZvcmUgc2Nhbm5pbmcgcGFy
dGl0aW9ucywgaXQgd2lsbCBjaGVjayB0byBzZWUgaWYgYW55IHBhcnRpdGlvbiBvZg0KPiAgICAg
IHRoZSBsb29wIGRldmljZSBpcyBjdXJyZW50bHkgb3BlbmVkDQo+ICAgNS4gSWYgYW55IHBhcnRp
dGlvbiBpcyBvcGVuZWQsIHRoZW4gaXQgd2lsbCByZXR1cm4gRUJVU1k6DQo+DQo+ICAgICAgaWYg
KGRpc2stPm9wZW5fcGFydGl0aW9ucykNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZ
Ow0KPiAgIDYuIFNvLCBhZnRlciByZWNlaXZpbmcgdGhlICJMT09QX0NMUl9GRCIgY29tbWFuZCBh
bmQganVzdCBiZWZvcmUgdGhlIGFib3ZlDQo+ICAgICAgY2hlY2sgZm9yIG9wZW5fcGFydGl0aW9u
cywgaWYgYW55IG90aGVyIGNvbW1hbmQNCj4gICAgICAobGlrZSBibGtpZCkgb3BlbnMgYW55IHBh
cnRpdGlvbiBvZiB0aGUgbG9vcCBkZXZpY2UsIHRoZW4gdGhlIHBhcnRpdGlvbg0KPiAgICAgIHNj
YW4gd2lsbCBub3QgcHJvY2VlZCBhbmQgRUJVU1kgaXMgcmV0dXJuZWQgYXMgc2hvd24gaW4gYWJv
dmUgY29kZQ0KPiAgIDcuIEJ1dCBpbiAiX19sb29wX2Nscl9mZCgpIiwgdGhpcyBFQlVTWSBlcnJv
ciBpcyBub3QgcHJvcGFnYXRlZA0KPiAgIDguIFdlIGhhdmUgbm90aWNlZCB0aGF0IHRoaXMgaXMg
Y2F1c2luZyB0aGUgcGFydGl0aW9ucyBvZiB0aGUgbG9vcCB0bw0KPiAgICAgIHJlbWFpbiBzdGFs
ZSBldmVuIGFmdGVyIHRoZSBsb29wIGRldmljZSBpcyBkZXRhY2hlZCByZXN1bHRpbmcgaW4gdGhl
DQo+ICAgICAgSU8gZXJyb3JzIG9uIHRoZSBwYXJ0aXRpb25zDQo+IEZpeDoNCj4gRGVmZXIgdGhl
IGRldGFjaCBvZiBsb29wIGRldmljZSB0byByZWxlYXNlIGZ1bmN0aW9uLCB3aGljaCBpcyBjYWxs
ZWQNCj4gd2hlbiB0aGUgbGFzdCBjbG9zZSBoYXBwZW5zLCBieSBzZXR0aW5nIHRoZSBsb19mbGFn
cyB0byBMT19GTEFHU19BVVRPQ0xFQVINCj4gYXQgdGhlIHRpbWUgb2YgZGV0YWNoIGkuZSBpbiBs
b29wX2Nscl9mZCgpIGZ1bmN0aW9uLg0KPg0KPiBUZXN0IGNhc2UgaW52b2x2ZXMgdGhlIGZvbGxv
d2luZyB0d28gc2NyaXB0czoNCj4NCj4gc2NyaXB0MS5zaDoNCj4NCj4gd2hpbGUgWyAxIF07DQo+
IGRvDQo+ICAgICAgICAgIGxvc2V0dXAgLVAgLWYgL2hvbWUvb3B0L2xvb3B0ZXN0L3Rlc3QxMC5p
bWcNCj4gICAgICAgICAgYmxraWQgL2Rldi9sb29wMHAxDQo+IGRvbmUNCj4NCj4gc2NyaXB0Mi5z
aDoNCj4NCj4gd2hpbGUgWyAxIF07DQo+IGRvDQo+ICAgICAgICAgIGxvc2V0dXAgLWQgL2Rldi9s
b29wMA0KPiBkb25lDQo+DQo+IFdpdGhvdXQgZml4LCB0aGUgZm9sbG93aW5nIElPIGVycm9ycyBo
YXZlIGJlZW4gb2JzZXJ2ZWQ6DQo+DQo+IGtlcm5lbDogX19sb29wX2Nscl9mZDogcGFydGl0aW9u
IHNjYW4gb2YgbG9vcDAgZmFpbGVkIChyYz0tMTYpDQo+IGtlcm5lbDogSS9PIGVycm9yLCBkZXYg
bG9vcDAsIHNlY3RvciAyMDk3MTM5MiBvcCAweDA6KFJFQUQpIGZsYWdzIDB4ODA3MDANCj4gICAg
ICAgICAgcGh5c19zZWcgMSBwcmlvIGNsYXNzIDANCj4ga2VybmVsOiBJL08gZXJyb3IsIGRldiBs
b29wMCwgc2VjdG9yIDEwODg2OCBvcCAweDA6KFJFQUQpIGZsYWdzIDB4MA0KPiAgICAgICAgICBw
aHlzX3NlZyAxIHByaW8gY2xhc3MgMA0KPiBrZXJuZWw6IEJ1ZmZlciBJL08gZXJyb3Igb24gZGV2
IGxvb3AwcDEsIGxvZ2ljYWwgYmxvY2sgMjcyMDEsIGFzeW5jIHBhZ2UNCj4gICAgICAgICAgcmVh
ZA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdWxhbSBNb2hhbWVkIDxndWxhbS5tb2hhbWVkQG9yYWNs
ZS5jb20+DQo+IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCkkgZGlkIHJ1biBibGt0ZXN0cyBy
ZWFsdGVkIHRvIHRoaXMgcGF0Y2ggWzFdIHdpdGhvdXQgdGhpcyBwYXRjaCBJIGNhbg0KZm9sbG93
aW5nIG1lc3NhZ2VzIDotDQpbwqAgMzIwLjQwNDE3Nl0gX19sb29wX2Nscl9mZDogcGFydGl0aW9u
IHNjYW4gb2YgbG9vcDAgZmFpbGVkIChyYz0tMTYpDQpbwqAgMzIyLjkwODk5NF0gX19sb29wX2Ns
cl9mZDogcGFydGl0aW9uIHNjYW4gb2YgbG9vcDAgZmFpbGVkIChyYz0tMTYpDQoNCndpdGggdGhp
cyBwYXRjaCBhcHBsaWVkLCB0aGVzZSBtZXNzYWdlcyBhcmUgZ29uZSB3aGVuIHJhbiBzYW1lIHRl
c3QNCnBvc3RlZCBpbiBbMV0gLi4NCg0KWzFdDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
eW1hbndtZ3RuNzZqZzU2dm1qYmc1dnhjZWdmbmcyZXdjY2dudG10enNrd2w2cXg0MmRAZzNpeXZx
bGRnYWlzL1QvDQoNCg0K
