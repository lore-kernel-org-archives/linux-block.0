Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011007.outbound.protection.outlook.com [40.107.74.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DAB78C9C
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904474; cv=fail; b=a7JSCTBvCZIaxBPBKRPog8JKE6vZcmjltMJ3Bkhy348Fe3IA/yMIrAtnhDPUggEomx4q31EGwC85yot5hixYbaJeZsGQW96vEbZu4ifgvtEPfqXRQvWEYidPRgkWsWfQVEjGIcYQryjsAutH3mTTywcvTBBQZq6JNyepZct9CjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904474; c=relaxed/simple;
	bh=JPXLrJ3t8KqTL749Q3jRPO4qfVMa9ZDoYgvWb41uUOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oxz5tTpcEH+hkZYLNVRY5W2VnQxHpddHy9O9NCaNUv0jpKrLrXQJ2fKyM1UesReHiH8GgjBi5CQp0WmmPxRATQj98p0XhuC8LoLvSORlekUcWOxEl8XKyuTyG8RQ4Z/nSUycijlZ9Zrw5emr//1DP4tqObDMbSAgtF1n2r4a7kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Fe+tW/uq; arc=fail smtp.client-ip=40.107.74.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Fe+tW/uq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZPccp/SENr5P7rLOiPNYNbU+BBa48kTqFvP+vdpJVEeR6LHxwT0AFXLpT2J1dUrRNj07qLOL+/naOsHaDm4XKkwRlaE0hmtwpI1QUtaqWhM82Pnm16dMIUGAcauwUtgvdxYiOwsbv+BRsBnVD7OXjAQJ8OUK/nPsYNBwnU1BaLExeVS3w518NzS9UvcDYxS7RvAmZdg9z/NZfyB1uMdZYKg76jh6LqR1faaiJLfwan3iVdJlwU+bLi6S3HcqqCkJKHpkZaAN8Xsf3hM+yiokfYFbYG2+j7TPoiJEhpBvPdXyodxUCNY0T3jwhZQIJEF7O7DRlfl9Btmk1Gt0+t9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPXLrJ3t8KqTL749Q3jRPO4qfVMa9ZDoYgvWb41uUOY=;
 b=pY6wrBkNZBkf+NmlRvYy2E3DAPJ8DG6kwnr3h56eKgzHQp4lAbZjyKZF0wfpP2mLfuuxCTmMOmWV+Xgy83wvC7M/OBAeUD78XlENjiDuEN7NVxuCfEsKUUHhMPQ8EZHVvdXL/iRti8GzkxRZ8dyb5qQ8Y/5Qqanr06yh80muGGReMCbhHE/UKW15CNENEkybRAebIMzdJXv7ROyl9llBFDjJJFEpiRtKEyYJBb1glTl5f3b0hdelqFZy1D6COBSQ2MXYbnx8XfCRnuousjPAZN9Eh5Lvl5h+3BskF6srxBHikrVuOImGl3y0Q1x5uKk8AmUWSPlABZO3/94K0m7pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPXLrJ3t8KqTL749Q3jRPO4qfVMa9ZDoYgvWb41uUOY=;
 b=Fe+tW/uqIVNkqSmQncyVDHvA2WeQQSxrqCcCx1/1z3Z5ud+qFTXHWP+b1r/mNBhJKzk4xBOK7mfbV0I+0LOuPsgWRYJgEG668JxWqIxi8LtmCdx5S58T4zh9BvhDPDVU2y4xKloEFJLOnWnrjZhVxwZ9nY3uD0fdjyl45n5XQ4XrJQZlL2GRNwOp9tEZOh/ByFLfxzg+YTn76FXOv8SIQTKFQWT/57oGSsFjBlPN4XL9hlvpFTk6AprwyEXoWd3e+7YTnJ08PVuT/vnaqdHzii9FaD818KoDEPERaOh2MdU4veOW07lr9k91vHTa90HDp8x5RTSsVaztsX9PsUhOlw==
Received: from OSOPR01MB17759.jpnprd01.prod.outlook.com
 (2603:1096:604:467::23) by TYYPR01MB6586.jpnprd01.prod.outlook.com
 (2603:1096:400:c5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Fri, 5 Dec
 2025 03:14:30 +0000
Received: from OSOPR01MB17759.jpnprd01.prod.outlook.com
 ([fe80::584b:4382:85bd:24ed]) by OSOPR01MB17759.jpnprd01.prod.outlook.com
 ([fe80::584b:4382:85bd:24ed%4]) with mapi id 15.20.9412.000; Fri, 5 Dec 2025
 03:14:30 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Bart Van Assche <bvanassche@acm.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Topic: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Index:
 AQHcWbyd/dB/TE6bnU+b/Z/pvJC8ZrT7KHkAgAAQ1ACAFdnmAIAAJW+AgAA6G4CAAE+lgIAAtKwA
Date: Fri, 5 Dec 2025 03:14:30 +0000
Message-ID: <2b39b794-a82a-45ff-a9e1-d45074b176df@fujitsu.com>
References: <20251120012731.3850987-1-lizhijian@fujitsu.com>
 <43b4daba-3bc3-4b37-8464-324792c8b4de@suse.de>
 <17b6a4ab-1709-45e8-93da-a068192b0137@fujitsu.com>
 <2pvduxbjeccwqgfn2rlofm4aacrnublbwcav4bpcsz7eg5mimd@5tm3576mikyy>
 <82978f0c-4426-4bdf-b270-a86ef9c2d1fa@fujitsu.com>
 <gjl7kqnnziae3yumvohew7nacq4553k6lahfdefc3xrymohzgt@727qyoksolau>
 <ef6199cb-f3fb-4d69-99bc-66ab1222272b@acm.org>
In-Reply-To: <ef6199cb-f3fb-4d69-99bc-66ab1222272b@acm.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSOPR01MB17759:EE_|TYYPR01MB6586:EE_
x-ms-office365-filtering-correlation-id: 5a78d6b4-1c7a-474c-f4f0-08de33ac67c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2JURWt5T1psMy93cXpLMWlST0JwSDlaRWk4VWErc3ZUcS9WVDJlTEpjTXBr?=
 =?utf-8?B?VVZOMDhzazVQR2hUU2E2SWt5eWlNT25SS0VHMUdka2RKZ2UzWVRDckZzQXhp?=
 =?utf-8?B?dVZvRDRUdnBOclZSZEd0dVB3SS81Y0F1ZEVMUy9vODhvZWU3a3d6cXovOHNk?=
 =?utf-8?B?aGtNVkFYcEowbVU2TnRKaFlRUVR5MmZPaFVTZFVPSWtpNk9BcCsrZHA4dHl0?=
 =?utf-8?B?cnNSVjBEQ0wyUWYxRzBVRkNYa2ViekZqTzcrVVhQcFJ6UHZUcGc1UVZvQWhM?=
 =?utf-8?B?MUJNaDhLQmlQalIvUFZ0RTRLSjQwak1xQk4yY0tMbjhqY1Mwb0wyMDVBZEli?=
 =?utf-8?B?a294eXVwKzZ4L0xHVFh5eEUybFBEQnc5Mmc2NU1qUDlRQlZMTG0xMkJGQnRo?=
 =?utf-8?B?Q0xFd0NjTFI1UlhlNVNGYTBtaFdKYzFJL2hHM2pvWXI3QWRPYzRrNk1mUWxL?=
 =?utf-8?B?eVdmaEV0M2txZEVrT0JxMEduaVhzbFY3Y0hCRDdVdnBvQWxvTGkxeGJnZXdh?=
 =?utf-8?B?K1o1Nk44dFNOM29OTFRmZEYxeE5oTHduZzZnYTZrMVc0aEdmbzBhQ1VLTEJt?=
 =?utf-8?B?VlYzdkFuUEhsS1V6VG9FbFNPSERLR0V4V2pMWHBxbUtoUTFlS2RqM045MWov?=
 =?utf-8?B?dVErRXQxVmFUUjFhRTlseDU4Uy9sa2prbnBaNmNCVG9oRlNkVkd1Yk9ETUJG?=
 =?utf-8?B?dk5meUV6VkVYLzdpVStzK1VqdUlkWU9aeStIanpyc3VwbklXcHNwQmYyMWVh?=
 =?utf-8?B?ZE1nNWh1QldMR3FhTENoTjg5WkM4akxqNTVnNWFZaUhvSFIyS0FhYVVsOWs3?=
 =?utf-8?B?MC9VemRPUDFRRzI5Ni9DbkNKQ2hWVGx5ajAyVmZMOWg3UE5COC94eWpCb21B?=
 =?utf-8?B?QktwbkNtWUV0UXdvTUxJa0JXdDIyUVkyUG9pSFVWYy9HaXFUdWJZcXBsL1Aw?=
 =?utf-8?B?ZnZrc3VpWTdXUFJDMXVLalhVUG5FdTNpYU4yRTdFeGRsbkF0TlVSTUgySVZC?=
 =?utf-8?B?bTNCTmtsRk04ZXhRb0swWGtITHVOQ2NaR0dJdkZmM1hjSCtQNCs2YzdKRlJ3?=
 =?utf-8?B?N1hub0NsZWhhcW5MdERGV2ZuN1ZSa3NBL1pUSGdFcVIyenhnbzRteUdqZFlo?=
 =?utf-8?B?eEtpQ29EcWVxd0xQUnRZMzlZR3NXRWdkcEpncTZvbE1JWG5CUW5sYm1NUURS?=
 =?utf-8?B?UW5HNW5yU3hYQlBDd295YndvSTQxWlY4U2NDcFd5TGxCUTc3MHdIcStLWWNa?=
 =?utf-8?B?bjBYYVEzSDlsUDdIMC8yNVVXdlIvcENoV0lDSDQvMUlqVEZHR0dpREZFcHov?=
 =?utf-8?B?SWJYNldOY1RoWWt2VGdTZ1A3TzVqQzF2L1pkMlg5aldxMWJITWNCWVZQeFB2?=
 =?utf-8?B?WE1ySmJEUGprU1lwNThVdGdjTHhZMTVoUHlCbHZDOC95YnpYUlJrbUVUci9D?=
 =?utf-8?B?amNaT2dFT3Z4d1RNcnpId3NVeDdVNTRtQTJxM29HTG9pZ3pvRGxUSUFmZnlS?=
 =?utf-8?B?bEtFZDc3OHprSHBxZTI1NjAzRmRRRU5EZTU3NFU3cXRYYVcwYVZma0R0Z0FD?=
 =?utf-8?B?b0EwMkNkeWdraCtiYmZDdFhvTlhtZEJLSHRMbzVxRStOQ1pCVDl1eXN1UDIv?=
 =?utf-8?B?M3NvVVpIc0pUN2dzVnk4NDRNVEJ4Q1JPQlZBWDJWS1ZPUFM0U2JXQVYyTmRK?=
 =?utf-8?B?Q3Nzb1kyY1pOTVN5Q3RYOWFQSXJWY0N1c1pRc1NManNwaUtNSkt5aE9JUS82?=
 =?utf-8?B?cERjUWo3ellndzU3RERjWXNaSFJJR3lHUm9UZzBtb1V1WmlyODhKclBEVmtH?=
 =?utf-8?B?TVpBWWErVnNjUGtDWUxFdTBDUFZuaE5vcmttQU5uOWVqSTNlNHRtSHVldnFt?=
 =?utf-8?B?TnV2Vm1JdGh1WGpuSWtmcmV2VXNQWXp6ZWo0MFJvS2pNZmdEMUNVSHF0VjVY?=
 =?utf-8?B?cjdpUW1COVNlUnIyZ3VqUWVOME1lQkcwVjM3bmFSY2dhaU9vdlMvOVMzRHkr?=
 =?utf-8?B?MWEwQ3ByU0lLSDU2dDFDMENJai9GaXFCb0w0Z3ZiV3h3c3dvcUs4aDYrQ0hy?=
 =?utf-8?B?c1hKclVhZVJkZER6b1pWOXJsN0tmWnFRZ2drNTY3UURabThoTGFHWnBlZTVG?=
 =?utf-8?Q?0neY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB17759.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tk9YM25mQU1xRUZJVU1pZC9NeFpyNktueFVoUVlyMllTK291ckpydG82S1FP?=
 =?utf-8?B?eHIxQXlwS3d1eExnM01HbWJzRUsxek9YcFBYcHZCaDRKRnRRTWhIejVjNnFk?=
 =?utf-8?B?YzN2ektCeTZNSlVxQ2h4RFlyWTBMSUFzVkNrOVFMSUthN0ppWkduSGxUdWxn?=
 =?utf-8?B?OXJrNFFZZldzYjE1TS9XNkUrNDR4UExWUG41VVltN1JoNFZXTXA3bWVMaE1M?=
 =?utf-8?B?YVJuakZHcmRVaFJVdVo0VDdVU1RJVHJ2VDFHSmR1d25NdktaOVBtWjdXR3Rn?=
 =?utf-8?B?TXdBV0hxa0VVZXg4KzFQRk1kTk1FcndxNzZWTFJpc0I0UWxzeGN5MGt6dCtG?=
 =?utf-8?B?VnA5TWpWb2RTTmlZVk9nb1ltbFB5TTREQmhsKzNDNjNQUnFQV01jK2N1VlI1?=
 =?utf-8?B?ZnlKNmhrTytEeWhvVWhYTythK3hjM0I0N1lPcnVZZjh6U3BPZ29UUGxhTXZo?=
 =?utf-8?B?cE1FUjVmSjNDazliYzB1NUpKK0E0ckJUdTVWUlFUMUlIRUkyYVd4Wk9qZ0JR?=
 =?utf-8?B?a21BdmdTbEJ5TWk3UldmSFIrVjdYYTQ2RHpOaGlHWVN5QWFkbkJuV3Y1UnQ2?=
 =?utf-8?B?TUplK0tuMThRZUJ5Ni9zTXlzS1lHUWdQYnVtQ2JkSlZDTFBXUERqV2ZyM2VU?=
 =?utf-8?B?V0h4c3VuSVh0QmpNTFZtVDMrcnd5UjQ2dHVNeWs4c3p3Y0JqMStTK21Pdkxt?=
 =?utf-8?B?Nys5ekdWREJZVGlqUEpybUY3ZWhsUzgvQVVkZUcvSFdMS3VzVExaVlZPZHV2?=
 =?utf-8?B?SUNqSHRFbFR5NWhQZUxvOUoyMXZTZkpWUTl1TkNob3dQRENLalBwbDdzL0VM?=
 =?utf-8?B?eEsxd0pWQlhURTFkTHpoZzRhVnVRbkZESk84VnBKZUxCUEFOemxjWG5Bb0Zu?=
 =?utf-8?B?VHBnalZuTXQ0bExxN1d3aWtad1EwdkZ6UFlBN3hWU2NwdnFqZ2J0R2RpT0Mz?=
 =?utf-8?B?UHNGc0pxODBVbmN6VkNnaytjUGtVdVhZc0tGei9yYXl6NWV6QXJ1Vks4ZHVs?=
 =?utf-8?B?Q2JEa1gwSTcyM1hRdEdTSHcrd3BnMjBHTnZDamRIN3V6NndjWlVRRU5IRDZt?=
 =?utf-8?B?NFRScmdXSFJJc3d2Z2pockxRL3VFS1hIVlgvWlFhN1JxYWFzSU5NRFZZTng2?=
 =?utf-8?B?djVBVDNEOGozaDQwRDM3ZlZtUEpSK1g2dzlKTEVENm9jbVA2UmFCNGV4T3dW?=
 =?utf-8?B?T0hkY2VKUmV1ZVpiNUZIcTdkMDY4b256QmZwTDZrMTdsVzJoRitmUjVPTWd4?=
 =?utf-8?B?UmdETm50RzZtRXMxNUpoMW55SlFMN0ZWZGdTMDlmQXE4Z0dNWmxWeDdqbmtj?=
 =?utf-8?B?RjMxL1ZxeVZWR3lrVmhxNDM4bjVtZFlOdUNmaGtXdnVSN2ZMd0pFdXk2TDJT?=
 =?utf-8?B?TUJQOTRQcTk0TEpwaGo3VUNFczl3dkRUaU1ETnZmUTBTRWpIUFE4NTl0d2Jh?=
 =?utf-8?B?REhoK01jdlIvT3VKS2txb3QzbDJFN3JYRGN2ZUEvZk9UVTZnUUxLSG8rcXh1?=
 =?utf-8?B?TnBycFdNK1ppdmJ5UDRaK2VZQU85ZlRFY3F5RzFXSGdSRUZZbnpKRURQN1J6?=
 =?utf-8?B?TFgvMkRJTGd6cVR5RzAwK2l0bm5zVzRSYW02Z3NrdlF4TVVsbnJyaXFBNTZ6?=
 =?utf-8?B?Y2FwOGR6Y3Z4Vy8vQi9nVDBYaG1XM1NpT3lkczBwMC94ZEFrOEJVaWc5bWhD?=
 =?utf-8?B?REkxNmhGVnlIbEhJVUF5M3RIYmNLKzdjSGxDYlpMdXF5Wkdvenl3cU9iMmFU?=
 =?utf-8?B?Slo5OENmSnNnanJBMzlmQ1oyUzc2VDVRWU9IcTY2TldjSTVzYjJVaElNTlRq?=
 =?utf-8?B?cVV1SHJ1V1IxajJYNUh2Tml4SjBtZFdva0pCcDd2cWZ6VTVZZGdlN3pKc0hN?=
 =?utf-8?B?b3R2disreFhWYWxqbXcyQ0FBaHB1VUNFTmVqY3BFYW5DL1pkWmVGVHdRcE9L?=
 =?utf-8?B?OXAwTEpZM1lDWGtwbCtWbGo0eEVlZXJ6bVIxU3Nsa0VWWFpaZEdabzJoano4?=
 =?utf-8?B?Wnc2UVh2MEpETWtPbXlrdy9xNmg1TVZidUIvVG56dzdIaEx2YzdWZFhNaW1i?=
 =?utf-8?B?WXhTL3RqVXFnb1dGTDYvM1NObUdmT1IvdG1OY2duRWFOcWpFZ1pZS2hvOUdJ?=
 =?utf-8?B?UDdZOFNybGFxcjFJY3JWY2M2Q2lYbWEzd3dNZXo0WHlMUEdPdG51QXBUSFkw?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <163D61EBA6F3E2449A47A33051437BA2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB17759.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a78d6b4-1c7a-474c-f4f0-08de33ac67c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 03:14:30.1160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryi0lN5jzcGJV3IgpxY68jUJpqSSoRD9hHZIbRglMVLfIVcfcW3+CqWBLDaFePYU3Nh/8LUzjoxNO0qEJbpkMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6586

QmFydCwNCg0KDQpPbiAwNS8xMi8yMDI1IDAwOjI3LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+
IE9uIDEyLzQvMjUgMTo0MiBBTSwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4+IE9uIERl
YyAwNCwgMjAyNSAvIDA4OjE0LCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+PiBTaGlu
aWNoaXJvLA0KPj4+DQo+Pj4gVGhhbmtzIGZvciB5b3VyIGVmZm9ydHMuDQo+Pj4NCj4+PiBPbiAw
NC8xMi8yMDI1IDE0OjAwLCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPj4+PiBaaGlqaWFu
LCB0aGFuayB5b3UgZm9yIGZpbmRpbmcgdGhpcyBhbmQgdGhlIHBhdGNoLiBJIHRvb2sgYSBsb29r
IGluIGl0Lg0KPj4+Pg0KPj4+PiBUaGUgdGVzdCBjYXNlIHNjc2kvMDA0IGNoZWNrcy9wcm9jL3Nj
c2kvc2NzaV9kZWJ1Zy8qIHRvIGZpbmQgb3V0DQo+Pj4+ICJpbl91c2VfYm0gQlVTWToiLiBJZiBp
dCBmaW5kcyBvdXQgdGhlIGtleXdvcmQgaW4gdGhlIHByb2MgZmlsZSwgdGhlIGRldmljZSBpcw0K
Pj4+PiBzdGlsbCBkb2luZyBzb21ldGhpbmcgd2l0aCB1c2luZyBhIHNkZWJ1Z19xdWV1ZS4NCj4+
Pj4NCj4+Pj4gSG93ZXZlciwgdGhlIHNkZWJ1Z19xdWV1ZSB3YXMgcmVtb3ZlZCB3aXRoIHRoZSBj
b21taXQgZjE0MzdjZDFlNTM1ICgic2NzaToNCj4+Pj4gc2NzaV9kZWJ1ZzogRHJvcCBzZGVidWdf
cXVldWUiKS4gVGhpcyByZW1vdmVkIHRoZSBpbl91c2VfYm0gdGhhdCB3YXMgdXNlZCB0bw0KPj4+
PiBtYW5hZ2Ugc2RlYnVnX3F1ZXVlLiBUaGVuLCBhcyB5b3Ugbm90ZWQsIHRoZSBjb21taXQgN2Y5
MmNhOTFjOGVmICgic2NzaToNCj4+Pj4gc2NzaV9kZWJ1ZzogUmVtb3ZlIGEgcmVmZXJlbmNlIHRv
IGluX3VzZV9ibSIpIGNoYW5nZWQgdGhlIG1lc3NhZ2UgZnJvbQ0KPj4+PiAiaW5fdXNlX2JtIEJV
U1k6IiB0byAiQlVTWToiLg0KPj4+Pg0KPj4+PiBJSVVDLCB0aGUgdGVzdCBjYXNlIHJlZmVycyB0
by9wcm9jL3Njc2kvc2NzaV9kZWJ1Zy8qIHRvIGNvbmZpcm0gdGhhdCBhbnkgSS9PIGlzDQo+Pj4+
IG5vdCBvbi1nb2luZy4gU28sIEkgdGhpbmsgaXQgY2FuIGJlIGRvbmUgdXNpbmcgdGhlIHN5c2Zz
ICJpbmZsaWdodCIgYXR0cmlidXRlIGFzDQo+Pj4+IGJlbG93IChub3QgeWV0IGZ1bGx5IHRlc3Rl
ZCk6DQo+Pj4NCj4+Pg0KPj4+IEkgY2hlY2tlZCBvdXQgdG8gdjQuMTcgYW5kIHRyaWVkIHlvdXIg
cGF0Y2gsIGJ1dCBpdCBkb2Vzbid0IHNlZW0gdG8gd29yayBhcyBleHBlY3RlZC4NCj4+PiBJIGFk
ZGVkIHNvbWUgZGVidWcgbWVzc2FnZXMgYmFzZWQgb24geW91ciBwYXRjaCwgYXMgc2hvd24gYmVs
b3c6DQo+Pj4NCj4+PiDCoMKgIDQxwqDCoMKgwqDCoMKgwqDCoCAjIGRkIGNsb3NpbmcgU0NTSSBk
aXNrIGNhdXNlcyBpbXBsaWNpdCBUVVIgYWxzbyBiZWluZyBkZWxheWVkIG9uY2UNCj4+PiDCoMKg
IDQywqDCoMKgwqDCoMKgwqDCoCBncmVwIC1GICJpbl91c2VfYm0gQlVTWToiICIvcHJvYy9zY3Np
L3Njc2lfZGVidWcvJHtTQ1NJX0RFQlVHX0hPU1RTWzBdfSINCj4+PiDCoMKgIDQzwqDCoMKgwqDC
oMKgwqDCoCB3aGlsZSB0cnVlOyBkbw0KPj4+IMKgwqAgNDTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZWFkIC1hIGluZmxpZ2h0cyA8IFwNCj4+PiDCoMKgIDQ1wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwoY2F0IC9zeXMvYmxvY2svIiR7U0NTSV9E
RUJVR19ERVZJQ0VTWzBdfSIvaW5mbGlnaHQpDQo+Pj4gwqDCoCA0NsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVjaG8gIiR7aW5mbGlnaHRzWzBdfSwgJHtpbmZsaWdodHNbMV19Ig0K
Pj4+IMKgwqAgNDfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoKGluZmxpZ2h0
c1swXSArIGluZmxpZ2h0c1sxXSA9PSAwKSk7IHRoZW4NCj4+PiDCoMKgIDQ4wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4+IMKgwqAgNDnC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaQ0KPj4+IMKgwqAgNTDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbGVlcCAxDQo+Pj4gwqDCoCA1McKgwqDCoMKgwqDCoMKg
wqAgZG9uZQ0KPj4+IMKgwqAgNTLCoMKgwqDCoMKgwqDCoMKgIGVjaG8gMSA+IC9zeXMvYnVzL3Bz
ZXVkby9kcml2ZXJzL3Njc2lfZGVidWcvbmRlbGF5DQo+Pj4NCj4+Pg0KPj4+ID09PT09PT09PT09
PT09PT09PT09PT0NCj4+PiAkIGNhdCAvaG9tZS9saXpoaWppYW4vYmxrdGVzdHMvcmVzdWx0cy9u
b2Rldi9zY3NpLzAwNC5vdXQuYmFkDQo+Pj4gUnVubmluZyBzY3NpLzAwNA0KPj4+IElucHV0L291
dHB1dCBlcnJvcg0KPj4+IMKgwqDCoMKgwqAgaW5fdXNlX2JtIEJVU1k6IGZpcnN0LGxhc3QgYml0
czogMCwwDQo+Pj4gMCwgMA0KPj4+IHRlc3RzL3Njc2kvMDA0OiBsaW5lIDUyOiBlY2hvOiB3cml0
ZSBlcnJvcjogRGV2aWNlIG9yIHJlc291cmNlIGJ1c3kNCj4+PiBUZXN0IGNvbXBsZXRlDQo+Pj4N
Cj4+PiA9PT09PT09PT09PT09PT09PT09PT09DQo+Pj4NCj4+PiBUaGlzIG91dHB1dCBpbmRpY2F0
ZXMgdGhhdCBldmVuIHdoZW4gImluX3VzZV9ibSBCVVNZIiBpcyBwcmVzZW50LCB0aGUgdG90YWwg
aW5mbGlnaHQgY291bnRlciBpcyBzdGlsbCByZXBvcnRlZCBhcyAwLg0KPj4+IFRoaXMgc3VnZ2Vz
dHMgdGhhdCB0aGUgJ2luZmxpZ2h0JyBjb3VudGVyIG1pZ2h0IG5vdCBiZSBjYXB0dXJpbmcgdGhl
IHN0YXRlIHdlJ3JlIHRyeWluZyB0byBkZXRlY3QuDQo+Pg0KPj4gVGhhbmsgeW91IGZvciB0cnlp
bmcgaXQgb3V0LiBJdCBwcm92ZXMgdGhhdCBteSBzdWdnZXN0aW9uIGRvZXMgbm90IHdvcmsuDQo+
Pg0KPj4gSSB3b25kZXIgb25lIHRoaW5nLiBXaGVuIEkganVzdCByZW1vdmUgdGhlIHdoaWxlLWdy
ZXAgZm9yICJpbl91c2VfYm0gQlVTWToiDQo+PiBjaGVjaywgdGhlIHRlc3QgY2FzZSBkb2VzIG5v
dCBmYWlsIGluIG15IGVudmlyb25tZW50LiBJIGd1ZXNzIHRoYXQgaXMgYmVjYXVzZQ0KPj4gSSB1
c2UgcmF0aGVyIG5ld2VyIGtlcm5lbC4gSSB0cmllZCB2Ni4xLjExOCBrZXJuZWwsIGFuZCBpdCBw
YXNzZWQgd2l0aG91dCB0aGUNCj4+IHdoaWxlLWdyZXAuIEFuZCBteSBzeXN0ZW0gZG9lcyBub3Qg
Ym9vdCB3aXRoIHRoZSBrZXJuZWwgb2xkZXIgdGhhbiB2NS4xNS4xOTYuDQo+Pg0KPj4gTWF5IEkg
YXNrIHlvdSB0byB0cnkgdGhlIHNhbWUgdHJpYWwgaW4geW91ciBlbnZpcm9ubWVudD8gV2l0aCB2
NC4xNyBrZXJuZWwsIHRoZQ0KPj4gdGVzdCBjYXNlIHNob3VsZCBmYWlsIGJ5IHJlbW92aW5nIHRo
ZSAiaW5fdXNlX2JtIEJVU1k6IiBjaGVjay4gSSdtIGludGVyZXN0ZWQgaW4NCj4+IHdoaWNoIGtl
cm5lbCB2ZXJzaW9uIHRoZSB0ZXN0IGNhc2UgY2FuIHBhc3Mgd2l0aG91dCB0aGUgY2hlY2sgKHY1
LjEwLng/IG9yDQo+PiB2NS4xNS54PykuIElmIHRoZSBuZWNlc3NpdHkgb2YgdGhlIGNoZWNrIGRl
cGVuZHMgb24ga2VybmVsIHZlcnNpb25zLCB3ZSBjYW4NCj4+IGxpbWl0IHRoZSBDT05GSUdfU0NT
SV9QUk9DX0ZTIGRlcGVuZGVuY3kgdG8gb2xkZXIga2VybmVsIHZlcnNpb25zLCBob3BlZnVsbHku
DQo+IEFueSBvbmdvaW5nIEkvTyBzaG91bGQgaGF2ZSBmaW5pc2hlZCBiZWZvcmUgYSBuZXcgc2Nz
aV9kZWJ1ZyB0ZXN0IGlzDQo+IHN0YXJ0ZWQuDQo+IA0KPiBIb3cgYWJvdXQgcmVwbGFjaW5nIHRo
ZSB3aGlsZSBsb29wIHdpdGggc29tZXRoaW5nIGxpa2UgdGhpcyAodW50ZXN0ZWQpOg0KPiANCj4g
ZWNobyAtMTAgPiAvc3lzL2J1cy9wc2V1ZG8vZHJpdmVycy9zY3NpX2RlYnVnL2FkZF9ob3N0DQoN
Cg0KVGhhbmtzIGZvciB0aGUgaWRlYS4gSSd2ZSBhZG9wdGVkIGl0IGluIHRoZSB2MiBwYXRjaC4g
UGxlYXNlIHRha2UgYSBsb29rLg0KDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPiANCj4gVGhl
IGFib3ZlIHNoZWxsIGNvbW1hbmQgcmVtb3ZlcyB1cCB0byB0ZW4gU0NTSSBob3N0cy4gUmVtb3Zp
bmcgYSBTQ1NJDQo+IGhvc3Qgb25seSBjb21wbGV0ZXMgYWZ0ZXIgYWxsIHBlbmRpbmcgSS9PIGhh
cyBmaW5pc2hlZC4gVGhpcyBzaG91bGQgd29yaw0KPiB3aGV0aGVyIG9yIG5vdCBzY3NpX2RlYnVn
IGhhcyBiZWVuIGJ1aWx0IGFzIGEgbG9hZGFibGUga2VybmVsIG1vZHVsZS4NCj4gDQo+IEkgZG8g
bm90IGtub3cgd2hlbiB0aGlzIGZ1bmN0aW9uYWxpdHkgd2FzIGludHJvZHVjZWQuIFRoZSBoaXN0
b3J5IG9mIG15DQo+IGtlcm5lbCBnaXQgcmVwb3NpdG9yeSBnb2VzIGJhY2sgdG8gMjAwMy4gSSB0
aGluayB0aGF0IHN1cHBvcnQgZm9yDQo+IHJlbW92aW5nIFNDU0kgaG9zdHMgYnkgd3JpdGluZyBp
bnRvIHRoZSBhZGRfaG9zdCBwYXJhbWV0ZXIgd2FzIGFscmVhZHkNCj4gcHJlc2VudCBpbiB0aGUg
MjAwMyB2ZXJzaW9uIG9mIHNjc2lfZGVidWcuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0K
