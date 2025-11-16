Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE827462
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763263232; cv=fail; b=AykTdyWFrWaMZhMVYolpQT4R1KPm/SE5APEItpxHHAgETYBUKuzZcZCQyHJDUT/1w/NptbXDseO6ZHVOPOAxaq3vsEfEs+wpvMHbt0S1eMvCAwrNhAuwwbIFzh9dVSRya1B5mgjsex0kiZpYYPIfeDISkrmi5ZoV12Outv+9D4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763263232; c=relaxed/simple;
	bh=B52+ESpP7snMKFdcalV6WHvzTJipHQZw6I0O59L2oLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N3t/CuWcISMMEoms4rOay5uyeZBFDp0b6ZkeBQgdAEEJAqXKqiaxwmr0iHlslM25VCLjpnha7yxpp7zvVqI+lUZGsK+hWGvbxupsHSY7PIIBdj5yZij17Wd0sDmbtq9h8dAd8nRgGehfbqdkU29fg1Nwu44HzxREeGO2b/NGcu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JbczES/a; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JbczES/a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0nAlFxvLkPcvSSjwz4/EwfixnoIJO8792Zr+GpckAQdTOKD/pi1Qv4o+cE0KJQ7CNLoXEkwGy17fZQlSYpfgSqaOaOFKY2+/cPx9n2xYIw/kudfRqQ7nSZNCA/jcOSVT43alhCkpEYP0DLM6IE04JqpJ5h1QRnHTHU+ZGzTyJ2o3OCIN5bUFKpCuk0f5/jJW8NJdvfxgWAc1/eDZwUW6v0jpt2PBqQsqIOGnfaebxJY5Z+4Z1tWYRgB6bLaAJIG2MfQO6SBCyV15iUjbQjIHBPGQuK8nyqlN4cVK4tp/u8sDCwbWrgO1M6wh3+kxLCceEJzDUunE2nYvnR8BfZIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B52+ESpP7snMKFdcalV6WHvzTJipHQZw6I0O59L2oLw=;
 b=ylyHef3Qaa2ckFYqbX12hWXUaDHOjkWr91yBliwbNG15IDB/depiEERntZfMNau+wsB5cEy42ik2XNn0LyV1jAajotMPqRuEzQOgi6FdyWcFAfx++4U8UO7OvuIK5tGLYpHOZH02GHSUFCYoZ4rgJk1u5NID/pmp0ovv1n+qGqTg2+3RAsZzDUpwXANpMUXIBEO3juiDDQopg0kbEh6IDZK3A5EWNGbWW88M2hPXlB790MGgq/Fl8qIiRYXtuEgrL/aNHaa92zR1TBvscbOSCvptW5qlMCIrcakKqjtxCANMWBxl7ryznYjbAzlFIpNUMwPP+/zN/+wCQavG25+7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B52+ESpP7snMKFdcalV6WHvzTJipHQZw6I0O59L2oLw=;
 b=JbczES/aOjA+wsTU36EhZOUMS1Z591BFXNQbZhiEZagXFkOIVONZMe+t9nldcjq82NmVYavMPIhhslhNNYkII58XOhIOx6r8s7xnKv912G5t8VK64iIInu98VegvnbCdMA572iQ18Pdt7gU2ky/HHQ6l29NHeoRb9/RRxFI3W3FkwC4OkF2YNo0rXM0g5w0YNbO1XA3/YlpHRUcUuWfMTNFE9Z5y/r0sYASo6D4TPaWK4kkeVYEwancCQB4hAUkV+8rbfflGbpLJ0MiB4oG1ZMKPz/lKniTLdMwMj633KHfyLcx43XeJHo87OXDCfQbdNwF0A6Plof5wy2OUrMzyQA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sun, 16 Nov
 2025 03:20:27 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 03:20:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: consider discard merge last
Thread-Topic: [PATCH] block: consider discard merge last
Thread-Index: AQHcVZXKucHqLv/PpUmsHXuTZI9sJbT0pLsA
Date: Sun, 16 Nov 2025 03:20:26 +0000
Message-ID: <7d786d47-6f97-4c2f-ba77-5a31500e34dd@nvidia.com>
References: <20251114183145.519913-1-kbusch@meta.com>
In-Reply-To: <20251114183145.519913-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB7792:EE_
x-ms-office365-filtering-correlation-id: c28b260c-3a7c-4aed-9f2e-08de24bf169c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWNrNStDcGczckhodlNwd0k4Q2UyWHJsNHo2dnNoZnlzeWlJUkRDcFpSSUNF?=
 =?utf-8?B?dWlMKzI5eE1oOTBYN3JWdmh6cHVVc05sRFVwYWxtYjk4b2pjeDZabTFIVmdw?=
 =?utf-8?B?bURWRTBZQUZPaTQwUENIQmFDSXNKbURyaFZJTmczMUJzMU9kWXNzU2FtbzV1?=
 =?utf-8?B?ZnEySDVobEJJZ0I0aVBuSjV1RVNxTFc3Tm1ZRG5HZTN0OHhXTlQ3ZlQ5R2V2?=
 =?utf-8?B?ZFcxZHFEaXlOcnUxTytLc2F2M0MxTjZIME01TmNoaVZHUXd5VnRtVXBZUmFo?=
 =?utf-8?B?SVJsZFJ2Z05DWm9mV2NNU0pBTE9nWWZBcjdONzFrNFVJU1JmeVY0K0d5emp2?=
 =?utf-8?B?VnJiaGZsZkUvZ0VHZW5rTDdSVTRUV1JjVjJyanhrdmNwNXFNZHozalkrV3cx?=
 =?utf-8?B?SFFxTHozNXVRcUpuemJReG5Ia0FmMWozM3JvaVpZVnVVRmNhalU4TFZDVDNL?=
 =?utf-8?B?bmIxdjdKdS9icGJQUzIxdjI2cDRBU1lSQzRyNGdPL3NMYjlUd3ZhRlhYTTVX?=
 =?utf-8?B?L29EeTlUZVBKRFFubXJFdG1vSU82K29nWGhGRHoxeWdrdjFScERKQjBQZVdj?=
 =?utf-8?B?c1VSdjF6d0IyMllUOFpxdnRGZTdVTHZubDNYV0llM0trYWxIUVREMnQrMW5a?=
 =?utf-8?B?dVFzV3BnR3haemxLMHBRVk5LTkZ4OWQ5MzNEYmdvL0UyQTZEZ3Z1TVNiOVRi?=
 =?utf-8?B?L0JzY2hKOXZIUDhjSkpmbXFyV0VWbGcxU0U4RVhqNGlQeG5DY0Y5R3JrZnk0?=
 =?utf-8?B?Vlh5bmx5dFpmT05FSEpvbHQwc0RLU1MvL3ZDTmFXZC9WTzErQ2srRjZwcFNG?=
 =?utf-8?B?cEZML1I5ei9GcDZuelRrMXRVWkZuUTBFbUZScW1OZ0w3Ylc5RGd3TnYwL2hI?=
 =?utf-8?B?OHZLODNQeUYyQUtZU1hndm4rNTJEb0RVazc2R01SOGZxWHNnSEZ6Z1NWZ2dP?=
 =?utf-8?B?Z0ZrZjFaeXZScE1mZ0duNWdXN2tFYVQ1dXkzOTBDb3pwZUVpWFNrZklLaUV3?=
 =?utf-8?B?WmtaOHcvanZ6NnpxcUNwWURIMkZQV1p4MWd0NkU1OWd1UmxNMGtqZHZqZDBJ?=
 =?utf-8?B?aU0wazBRTW8ycG9lMEtYNUtUelBkZEpMQ0tCZzJ1SFZ6VE51NEkyQ3hXdXJn?=
 =?utf-8?B?WWJ5UDNxL3dJRllOZElrY1RXZXkyOG9vR0tPRlRMNElrNlhPdjJTYi9ka1ZX?=
 =?utf-8?B?TE1oM1ZLOWFqTmNPSS9aWjR4akRqeG9kSzMwZHJxZkt0MFRKVnc5ZmliRlVv?=
 =?utf-8?B?NkhrMlJTRWdBdXdZeVpWQXdYb01qVStOMHVwNU5jdVdjSkhXcXBac0lCeTEw?=
 =?utf-8?B?S1kxU0h1VG1SVmwxWjhaRHUxTjhoVDIybVdXN2E1Y0ZyZjh4MEN2N1BMb1Yw?=
 =?utf-8?B?WjhXUUpyZnlUaVR0YU1vdk04WHpYUjdlQUpSMiswaS9lSXJHa283aG5GRXFq?=
 =?utf-8?B?UWFUNjBJSmZSVmRlcCtGMjRHU0hxeU9FODlRK24waWdNak1FQ25INVRTYTAv?=
 =?utf-8?B?QnpuZWlmKzlIeU1MMS9xWW96QWpHUDdMajJqYkt5dGNtMFcrRnpEWWdiODNu?=
 =?utf-8?B?MENJSnRGSlZnMFhHYmxyYzE4bTdFR2VseUpuR1hGMjNDTm8wNWl1NGQ1YlZM?=
 =?utf-8?B?RHd6NDBIUzZYY0c1L3c5YUlETzdxaWZWQWR5S3J2K1VDV2xFSjhDa3J3T1h0?=
 =?utf-8?B?YVBZM2h0U0cvRzdqUG1YKzZjZHI3WkkxYjRDeHhGQmhMMGNMU2FvVVU4Zjlw?=
 =?utf-8?B?TlZNaVZjdTY2OGZjSDRsYVVZck9wTkc2Wm5IR3Q3L1dEY3pmc0Q5Z29Za294?=
 =?utf-8?B?NTJ0THlzVDh6QzY5b2FuazhYTFNxK29nQUdkWExKUU9iRGtYT2oyYU9CV3p0?=
 =?utf-8?B?cEZOYVF6Mk9WWit6eThLU1VzcjRXMDBBZTVpbVNtclJldHlqUy8zY2FtQUMx?=
 =?utf-8?B?TitmbyszVWF5MFFVelpUZDluMkE2WmkzZGNNMlEyTEgvUmtxQlVuYkFDOTRC?=
 =?utf-8?B?TEE3M0M5WTcxSGF4dXp1cU1nM3NacXVleVg0YVRJRWUzNERuSjJDTCtENysv?=
 =?utf-8?Q?3wvQiN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWc0WWxxM2d5bzFPNTgxak5iSVBDM2ZSamhtaVpoc3YrZzdCU3hpUnFaYkNV?=
 =?utf-8?B?NDdQdy8yd0NyOWJTc1hlNEtFdFkwV2VkVEg5ZHdkMFRsOEp2K29FTkNSSnVC?=
 =?utf-8?B?WTdSSGZ4SXlkNVBsbTkrUlJVTW5UeGRBdUQzMklmeExDeGlBVUtCeUhMNjZ6?=
 =?utf-8?B?UFVoVzg0SjlCOTNRQnczbno4ekprVHI5OHJGQUFyQmlkcXNCVHYvb0pXWTI0?=
 =?utf-8?B?NGs2aWVmQ1crdEVhUjBuZGc2VjAwWUk1bmZmTWdlR0kwVy9uSXNaVUNmckxW?=
 =?utf-8?B?MTA2M2QvSmxwa2J3SE9HeXBaWk1RdFNCbm0rOEJnV2szS1NscU15bWRMcks3?=
 =?utf-8?B?WUlPZXdXb202bnd0NjFqWlgyOVlyZk1WU2NJVmFBUk1pOUI4a09JODhGOVgz?=
 =?utf-8?B?ZWhOaXQ1WG1oY013b29xdDlQQzBXcXQxQ2JFelNZUHIxRlV6M2VoNzhrSHRr?=
 =?utf-8?B?SjhYMzRlcnNrOGlUMXFlQStpemZkVmRjaDA4MldNTGlmT1FrVm81aGRVV0JV?=
 =?utf-8?B?RzhnODZYT3hNWjVvTzZpOFBsRGFjMGFLS2xXWGVZUkJURFRzZklVWERrMC9m?=
 =?utf-8?B?M1pMMlJKOVRaWjlSN2FXeTdjNGlQeFdQeGtoU2FyRWFGaHlNdTQrQzJJeGtX?=
 =?utf-8?B?dmVUck1JQUVSSnB2QWNVQ3dEKzRlVVpvYWV2bVFpbmxtR3BVbnRzdmFXRXh4?=
 =?utf-8?B?WEptbmwyeHF1dlBsTFB2MlN4YS9EVDJrUnBDMDRYVXlNM05kWGtPYzMrM2Nk?=
 =?utf-8?B?cXcyVk5CbE9nWHNaSHBrOWEramU2R3lkYTVvN2ExR0x6OFZLV3lITnE2d0Nn?=
 =?utf-8?B?NzY0RHpZNC9EQzRYSC9WaWZiOHByNlZoS2NlMWJ3dkl0YlY4Sk1kK0FibVph?=
 =?utf-8?B?OVhzTWorVFJnQTk0cUJyRndIdDJBRjF3Q05lMWFveGlLNVJpMUtmS292NlRB?=
 =?utf-8?B?WTNvdEVScGkyU2pEdWt1SDNnUEJIOHZLZkV1MlVSVG9JVHV2S3c5N0hFazI3?=
 =?utf-8?B?VkNJRi9wNW5SNkwzdXB5cXpCR2F5NVBYaUpNRjRJRlh2aWdVNDUzM1lrOHVz?=
 =?utf-8?B?MjdjaFkyTDd1VlF3WXNhTWxnTE1lc2NYQ0ZNTU9SWHRma0pyd3RXMTZSQTND?=
 =?utf-8?B?ZEFSVlYrbEhKRmordG1HdllYZW5pY0xvZHhIMmd0RFhRV3RZTTVmc1RwcXBG?=
 =?utf-8?B?aEJocmxoUlZHbmNwc3g2UVVibWsydnBBTURSM2ZjbGlLU0Q3a0RXdHpkTXlw?=
 =?utf-8?B?OXhySC9yelVvVFpPTFk5QTJoNGtWb2JLSDhwSTkwNGpsbGN4ZlZ1WG1DUUZq?=
 =?utf-8?B?Rno2TDZ4WWdEaFA5Tkp5cCszb2ZRMDFBL0tLTUtaNnhpcTZ0bjR3bDV4UnBu?=
 =?utf-8?B?bTlMREt4cHIzZGpVY05rNjVxc0F1bjZ1dG5FSEE2Q1JybTFFQ2RtS3JOSWx5?=
 =?utf-8?B?cG5VL3FtUStZZG13TzVZM2Rhb3JSb2k0eWJmWUZTTHduTHcxcnJ5TFQxL2NZ?=
 =?utf-8?B?c3Zodjd0UGZsMVVSb2h0eS81VS9XMjVLQ0ltMURGNEliTHR3VnZVV012Qk02?=
 =?utf-8?B?NllmMW90NFRzWUlpMWtSMWQ5cndYTlBkZkk5c1FzVktKcHFnQ2poSmFuOU9C?=
 =?utf-8?B?Z1VwTW1NYTMyYU4rYW51TVhlcHUrQytzd0VvR2pPeDBldkdBUUd5aDNHQVJs?=
 =?utf-8?B?UDkxVy9BN3lzT28rK2htNlE2azZEVTRaczEybHNWZDdrL2NGU2NnNjdlZUVk?=
 =?utf-8?B?ODV0NmhuMlJlNmEvUlA0WTlPRlUvVHQ5R3oxY2JRaFpwNzhYV0lyWDFNc1RK?=
 =?utf-8?B?R20rblFDRVJDdFl6aEhMV3l4WVU0cy9zSFA0aldZQjlPa1hteXRIdVYvUEM3?=
 =?utf-8?B?RDdieGFvZjdJcURxb3BpaWtCWnVHdEtvd2pLeXVlU3YwS2hlTnhxbXoxYk0z?=
 =?utf-8?B?WjNiT0RVU2VsVHMzclhhNnlHN1FxUE9BcEZTeW12TjFwSHVSeEw1bU9KMDZV?=
 =?utf-8?B?N3VpTWdiY1pjNkcxR1hkT0pjRkhnU1lFeFhUZmduK1NGZjNnQk9HOHpWMVMy?=
 =?utf-8?B?bUdxTGlscWRoLzhpMGhCUlVhZFA0eWc0L1l6alo1L1V0bXBSeDY1eGRIdDZq?=
 =?utf-8?B?MXcwVENuMitkM1VNZkJaa3VKaXVKMVdUN1E0bnczR3QwRE0rZFh6R3RveUFD?=
 =?utf-8?Q?OjH5DsBy5AzA7W1LllOwDjJRPLQkRwXcX8CME81B1Ut7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14368B9D94A28045925A4A36AD8FE4AE@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c28b260c-3a7c-4aed-9f2e-08de24bf169c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 03:20:26.9600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l18GH/FcKsAp8Zi40h4rek5bMXDteI5ix9d50j6DK7aANVZZIrOLVcHVpOu0Z5SH0b2NOq9jTGn/YNYiczxyyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

T24gMTEvMTQvMjUgMTA6MzEsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gSWYgdGhlIG5leHQgZGlzY2FyZCByYW5nZSBpcyBj
b250aWd1b3VzIHdpdGggdGhlIGN1cnJlbnQgcmFuZ2UgYmVpbmcNCj4gY29uc2lkZXJlZCwgaXQn
cyBjaGVhcGVyIHRvIGV4cGFuZCB0aGUgY3VycmVudCByYW5nZSB0aGFuIHRvIGFwcGVuZCBhbg0K
PiBhZGRpdGlvbmFsIGJpby4NCj4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2g8a2J1c2No
QGtlcm5lbC5vcmc+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
