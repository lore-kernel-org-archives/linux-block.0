Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E518EAB
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762401130; cv=fail; b=WQgaKz2ciGAPHBc3bbufgir1o5K7nO9ntlQJHYe5gISeS1V2UmDA/gBeJdVZ7ff5Ow2nB1OtcaX6i7Iyvt3DtwnAOBR1fvqHIDy0+bPtCmrggCBikpSezx+Wr5J4aT1WGp5IZzZVb1YItfGeAnS/bJpwNm0D3ADieWD8ju2tuF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762401130; c=relaxed/simple;
	bh=eTUG08xsr/SCMvtbDz3Gs1nrxoQabqPkI2KgZzh2gWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVOOTcqf/K8Jq3XIsYbmUgOrYszjyIcalN7vHKxS1UPkFFdVPJ/UUlV3/Bd5RtXP0A2oUm2HmkMALjIzpgsKO5SqJEjTk4aAKTa2ZDeIxcMi3prhuhhgcBce8UtVxaLRL+FH9t2H665W+ggT+N0AOGRT6J7Qm8YfzynpZmnRYNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E8WgE/9s; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E8WgE/9s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhJnWrDLCkXSZmYixB4H41EHwrMf+FchisCSo5KcmsWVsFZLOQWYJoXv/XiV2BAcOPSve9NerNaEizcypDf/7SKBaTHZvxoyRRb+oCcNoXIAKsXrtOAVOyyzwDnhWain1Ty2hYsXe4J25oFtf4NnlbFlTRozX34ywQH35ukZpKU+HNAZ8mH3TMv5/53lxl5QPausHBX+osdA355leg9v2DGW74jwbgeqqxUOs2ew6SLUK3xga1EI4wu5rdpvzyrwNuJZaL8l0HvyviI4FH5C8vgWXVHTNKWvhRxF1ooXHs40Upt2Lw+Y/79Nue9A3k+4L5fPe/O3CTvck7DCSqNjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTUG08xsr/SCMvtbDz3Gs1nrxoQabqPkI2KgZzh2gWY=;
 b=CrvgpYA8XL0P8BPyZSR/FvaJshMQjd2qHO6MRPL6BtF6H7AluQsT3KRxolIpmvKOloMN3D/srZyvN6iOupkafp8k5GG5tStZeRxNF0vZ6M+Kdd0vNGKU24Y22uvDhg6QEkb333ywgqJoICo0w087F52JpQwp0FIbPhwtsLu/DpiSWx1znYoVcscMi1IQblGxjmvO7GRudEYMirmLCeeX2R2NA64b4iDgTiLUJF6jyhQ35KYDnXneLY8TzTgw1SgPpQsslYeBpzdzbqTqIluQKmo1ODiO3Wx6c9+2pGEtzLErTBAEMEc9c/HTKXdt/YTAFufwgXkgVLzttu05odzHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTUG08xsr/SCMvtbDz3Gs1nrxoQabqPkI2KgZzh2gWY=;
 b=E8WgE/9s3fkIRKHGmQl2Lu7U1KWsYVWKo/yO4Si15PNJYVAkFahcP69gzHgnVTUzMsH/ayROYGFubh9nPeKbVkXByqet7fyn+p2T3QIHw/NOoVEnzhRrNS/e8ASh2m27hEA5jEs4ZbKK0bkZY303lffHxL1TDmdrqqdvJNVa+kqI/8XSpdaviyIdC9HsBooHg+Jn8lmoGftSb61hLoa+dMD0i1WmhF7zWuO7S4fNnXWIHQWG8Wt0dQa67YQrDnDDXm5LcXPWu5O0HJ9tkHeqx+De+H9XDavK814HdtLJNwXwDF2H+RaivlzVCAXRKP0CL2gRBEBM+U6tgE72zaAwyw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 03:52:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 03:52:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"hans.holmberg@wdc.com" <hans.holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/4] null_blk: consistently use blk_status_t
Thread-Topic: [PATCHv2 2/4] null_blk: consistently use blk_status_t
Thread-Index: AQHcTsBrdO/iJoWky0ehlH75DIHMbLTlA+2A
Date: Thu, 6 Nov 2025 03:52:05 +0000
Message-ID: <dde328b4-296d-4d24-939e-0d6e18b8aae6@nvidia.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-3-kbusch@meta.com>
In-Reply-To: <20251106015447.1372926-3-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB5602:EE_
x-ms-office365-filtering-correlation-id: 6aea709a-bc89-431f-9b1b-08de1ce7da58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWJsZ3Q1SzhQL3k1dHNqVHJ0M09TbHhoQ3NvNlloVVFnM2RhenVYSWxXTnpS?=
 =?utf-8?B?RStQN3VwMmkxbXQ4QW1wQ3l0WFpyRXk5QWJJcGkrbTdJekhpV3lEaG5KSUhY?=
 =?utf-8?B?VnRXL2k1dFFoaWJuV0NES3J4M3dmTXNGQXB2Qk5ITzNma2NLencxRGVXekRQ?=
 =?utf-8?B?N2dVVkpkVGtndHFYWG1HVUJRMjRIRjVqU0tNMGRNNThjbHpFMCtVblZmT0x3?=
 =?utf-8?B?bjF4eWlqdkFxdVlhNHhDaGxYMDdJY2h0SkhGZDFKVkpmVnd1QWpqZkd4U2lh?=
 =?utf-8?B?YVF4VGVmZXVyczEvU3lxd3QyanZlOXBLWHZoWlRndW1lSUhNcDk0UEltTjZr?=
 =?utf-8?B?Ujh5Wm1jL2tXZ2xHNGhPUWMydHdtRWFhN0hoZEVoVkEvWmpadm1wNncrRUtl?=
 =?utf-8?B?TWJoMUdlamI2blk2bGxjV3lOQXM5cHo2N1dPUFUyMUdZd3RMU0lCc2dzaGxB?=
 =?utf-8?B?b0p3dWN3cy81TTdvM241MklNazRzQmpzeUcwbVlHMTNNNEFsQTNDZlVXS2Vw?=
 =?utf-8?B?OVF4MEFCQktTQ0JnRHNOSmRacFJpU1pIclpzSWdIS0NJSjF5N1VvWXROZWtr?=
 =?utf-8?B?UmUyVEtodE81Z3NVOEJBNTYwZ3lnWnB5UnlUK2lsVUFZM05hM3IreTMxNVEx?=
 =?utf-8?B?cDI4TjFKRVBRT2pwdEwwWTN6aHVZalROYTduWjhJQzVJc0xKM2UvaWJVSjNx?=
 =?utf-8?B?UWFSK3g3MTltNjVLc1ErU0xTcVErQjFEaWpZNW4xNTZJd0JIU3p1V0ZqQjlQ?=
 =?utf-8?B?WWRtWlUvQ2V2UTQyeU1lTWp6Vm5qN1lIbGFrMDBnOENTRWVHU084MkRyb1lZ?=
 =?utf-8?B?WE9sS0hUT21rcFhEaWkxc2N0L3JXd0FNTXo1STkvaGZPR2hOQlBJM2VvRVU2?=
 =?utf-8?B?Qm5wTGJseE1rdnhoU3I0VGRYQVlKYUo3anAzVDhXRnc0ZnFvL2Rpcmx5M1Jz?=
 =?utf-8?B?Z0pYditBTUVVRStGQ29QRzBZWURnUDYrdjZxblhSRFhHWWZZYi9IUVJRazUw?=
 =?utf-8?B?ODY2T2k5WTZZdlZyOXFrUW1JZjNFNklSenBCTllMTTFpbkRHS0g4UHhjMDBU?=
 =?utf-8?B?ei85RERFTEE1RU1lQVdDQ21EOVh6cTNXTnlveDJqT0ZjeVZsMGtlUXFkWUVz?=
 =?utf-8?B?TnZvL25MMHI4eHY2RlkrQ0F3YksvelE4Z2R1VHRhOU44ZTNtN0NmS0YvUXJr?=
 =?utf-8?B?Y0wwWHloUnU4anZOTitPRTJJdW13bURwaXZDSWJtN2NCMlRENDkvUDl1eGYw?=
 =?utf-8?B?UUNEK211a1Z3VGZKU284aG9VS0szd1VIVDl3bFpqRlJvZjN0UHVtYUlGUVdL?=
 =?utf-8?B?dW82MjBJek5SbzZEaXFjNDJ2T1MzSWlRWnpZTE52bVI1SEhTd0lnZWtrSjJS?=
 =?utf-8?B?U21UKy9qQ0M2VVRIeDI1YS8zeVJJQ0V1blVtajZQRUFadzdiV2tIT3FJWWJN?=
 =?utf-8?B?am9LZ2NQZEoxZVRMdWNqc1pNakpqaHUrZExKM2NFTitwelhLQzVQZHBJaFlv?=
 =?utf-8?B?d3BQcEwxbFBZVVVvWm4rR3AxVGJGZFBwcFdVcjZwUjc2cnNET3BBNllKWVhO?=
 =?utf-8?B?bWJieWd4UUtYeVk1Y3dFYWpqR2lUUE9NYjNuVTdFMHRISlp5UDU3b1p5VHNo?=
 =?utf-8?B?bXNNelJSQStCNDY4b2dkMTlIaHh3bndEZ0pSdnEwdlBQYXFheUhVdlc1ZEZl?=
 =?utf-8?B?U3hoWFJsNmZpeFk4Y0hLREZWSFFLSk1aL1diK1hoQmFkVnlkeHFXUXArVXZG?=
 =?utf-8?B?MkN4ek12Q3dhREo1Vk5zVklEeGoxUWRZNXYyOEpMSlFESDJucGludEs1UUxm?=
 =?utf-8?B?YnVjYVN2QmhIVTFpYStESlpqL0ttbStLV1M2R0ZZWWhPaDZWc082Vm5iOWFV?=
 =?utf-8?B?NXE2RHFxMksvbEl0dVFIUUJJZ0ZHY2hMbmgwU1BxNFRQcTBvTThmOC9ob2hL?=
 =?utf-8?B?TjJJZWFIUXpwVklkdWY1RHZIYkNVd0dTeHU4Z0RFY3RXVFhtS3FnUzFEamRZ?=
 =?utf-8?B?elFYQlVRVG9aQ0tRSXZJeXF2QW9RSTljTlM0UlR5WTdUQWNaTUVQbk9xUWU3?=
 =?utf-8?Q?X79sxy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzFmL3ArOXZqczVuR1ZxWXRTQSt3ZTNJT1RyeldZMm9wWEZxK1pTWEQ3VDVU?=
 =?utf-8?B?V0dFc0MvWHpLeUtYNzRzT3RBNHVvcFJxVS9GUE5PSHczYVY5VzhhcVdVTVRv?=
 =?utf-8?B?R1NJZEhJN2VUaklRcGozZ2kwMWdCUmlpM0lwS3hJNnNrM1UxekJnUUZ4eWtR?=
 =?utf-8?B?cmFMN0FTWTlRU0sycTNmbk9zK3VCcjQ1Sk9uMVFWRGZQaXpVVDE0N0xtbGlG?=
 =?utf-8?B?c2hscnU5THY1NEVnRVcvaEt1b1VVSUlxU1hiMTFJNmpnalc3VlBaYU52OFJP?=
 =?utf-8?B?dHQ3aUFEaTFUd2dPcmlKOXZDbkNVenVmRUlTNk5wblNaQklTSWZ6VGFSUHlE?=
 =?utf-8?B?aXJaMUpQelF6TkRlQWVUWXY4N1hGMHh5cUx4Vmd6QUIxQ1Y0cVJScS9kanhX?=
 =?utf-8?B?cDg0MUVPWnFmWkJoUFRUbmNuRDVITW9OL3ROVm5mOXRhQWZ6RDNaRCtOdFJE?=
 =?utf-8?B?L2dQUzNWNHR2a0VvekcyNkNuak1zMWJxMjZpSWVHTWJyQkl3a2JiSjFjeW0z?=
 =?utf-8?B?bnBrL0ovbGgvOFhYMXNBSGc3bmpXVm80WXlURUIxR29LcGdQai9jbUZwUDMw?=
 =?utf-8?B?K3JXVGNhZHVQNzVsYkRvN0JsanRmVWx5UGZEQXBvTkU4M29QZ1h5c0Z6VGUy?=
 =?utf-8?B?bmg1ZlBHamlQTW1zS0YrU2hxa2xxWWFSNkZpZUVuNXUwY1B2anVDUW01V2JT?=
 =?utf-8?B?bzhiV2loeitLay9ZN3orSWpZR28xNGtRSjBhKzNvdzVkVElQVTRIaytZU0lp?=
 =?utf-8?B?dE1GdWdzOXNGRnNtK0hMd1ZLdmlCU2F2cCt1d3hZMkFlV2s3ZmxTaE9RbnBN?=
 =?utf-8?B?ZzY4Sk12aDluUlViVTNIdUgxOWZRSDhrdk13Y0lLc3Z3ZkJYWVBrdTVJWUhM?=
 =?utf-8?B?dHFKMTFrb3dxRWFuSVVzU2tJQWNnVDh4bWNrK1ZjT3hPemwwQlcxdFRkbHUw?=
 =?utf-8?B?VFZqT3VXbTZaVFRNNkI3NmpCZzhRSHA2QlRlcEVVU1F3bW52a0M4aWhZLzRu?=
 =?utf-8?B?ZFBWcldSdEJrc1p3Y3hJV1VkV1FZck5hQVFhVTdPTVNieGRpdE9jQmxxM2pV?=
 =?utf-8?B?YWdoZkhMT3ZJWDMxU0FzaDBqZTdHbURrV3cxMTcxWVMxN3ZFdmFESU9SWUpU?=
 =?utf-8?B?Y2JtendyKyttYXFKMmxYMjB2ZlJ4end3V3pQUmxZZzJOcGc1TE5oaVJ4a3Y1?=
 =?utf-8?B?WEg1aEVMdDZFRnFoZWo5d1QyUWIzaGkrYVFzQXkwNVJyajNkYkRrRVNKeFox?=
 =?utf-8?B?Q0lIOXp5WFVwR2ZoWDlheXV2VHNTRlRSb1ZSRWpleitHQzVGUDBIN21BUXZl?=
 =?utf-8?B?eVEvR2pMallMZmNzUjRDRmNkZzhnZzMxM0gzbGhaU3NwN3BaVlU1dVNlRXBL?=
 =?utf-8?B?RDZwTVc2dXlJcWZXTXptUjRmVXdMdGQ4L3pXWS84UlpIRmFDQ1ozYnk3ODBm?=
 =?utf-8?B?NTVpLytKV25JWkJGQjdDR1NlRFdiZGZxaXJGc1lraTFSZU5FMTJDbGtwZVR1?=
 =?utf-8?B?VWJlZkNqRGI0ZjhhdkVOTkhONnhzbjhyUGNUV3MxZ3NmQWtoUFk1aU1SYzVk?=
 =?utf-8?B?SGVXZm9tSXBrUURhRHNpS2NLTVFVWjFUUU1MSithMFcwMXUwYUhMZ1hpT0c2?=
 =?utf-8?B?UWZhZ201YVZheTM2MzFGUmVkMzhxSzA1dG0rcnpoRlp3ekRFOHlIWWpwNjBU?=
 =?utf-8?B?SmhwUzR4K3hHZUFuWER0SmJxa01nNE9YeVBuNGJKajV0ZExVV3VIcityUEFw?=
 =?utf-8?B?TVRqQlRPcTM3MmpiVVhRZ1o1OEgxc2VPT0hweHhSVm9yWVN3Zmw2ZG11cGJm?=
 =?utf-8?B?NndaekZTclYwczIwY3Fyc3BzMFZoVmlsVjRmZVQzTHpwRTUxZDBtMzNZcitM?=
 =?utf-8?B?azRKaFp2bEdBanl0NklSNU5pZzlMOEpCbklJY09samlZTGl4MzVCT3dnQzVH?=
 =?utf-8?B?cUtnREorRkdvbXY2eEF3Sit2WmlCOVlVTCtEaG1PZVczcnFkYmZpQTlyN3Bp?=
 =?utf-8?B?aVBFeDlMdUtlcVhBWnRkbWlEc0lrUHFzZXp4NWp1bTRzVGg0WGx4WjR5TTho?=
 =?utf-8?B?a3dTQ1RZYSs1cVdxbUwrZUllSUtkbWoraXBFNU16R1c1REVEYkNEYUVobUpr?=
 =?utf-8?B?U3E3R1h2M01lSnZjVmR6WGRRQ01hemRMTzRzVzFQclYxNENqRkUxVW9naSto?=
 =?utf-8?Q?09zQ+nx4NqjlgkHjmbNSRmDivw9qIRBl7Cl4D9v8mStA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <753CD6D8E7DD0240844498B4B896BEAE@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aea709a-bc89-431f-9b1b-08de1ce7da58
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 03:52:05.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvjbyfue/nntCKBGdYJZytWcCWUcwJOPEB1MkZUsMNyJQJVaOumluK7YiRT6Fy9xyM8XS3emT+ZL4N+h+Wd9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

T24gMTEvNS8yNSAxNzo1NCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBObyBuZWVkIHRvIG1peCBlcnJubyBhbmQgYmxrX3N0
YXR1c190IGVycm9yIHR5cGVzLiBKdXN0IHVzZSB0aGUgc3RhbmRhcmQNCj4gYmxvY2sgbGF5ZXIg
dHlwZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2g8a2J1c2NoQGtlcm5lbC5vcmc+
DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
