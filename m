Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE13212FAD;
	Mon,  2 Mar 2026 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440925; cv=fail; b=T+NmoWsYyMzYByPNZaxTA89nlTsw6n2PBxij0mk8+uwwK+Y9+cg7lwpqXNYlyTH9Yhl2J7kWY7268Lf8WrBlSYy+f/7Ih19NDQRUYjjubyZ3kFcVikVq6Qj9jRZpsF1aV/CCY1W4jMcPS/zI2TRGQXswEoG9RgCcOYue2GD9Crk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440925; c=relaxed/simple;
	bh=tTOYI9Vard7aA/LWIYgqL1ETu+a5nlV6xexTzZSSDXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XJxouq/z9OCHNKSC7eVN28mc+pEsljQCZqMss9012gnr/cqGe9sWC41SuHyUbXwh7ye4mnDDz4KKHh7/yMRPavzJrOo+gJnd3Ab9koK9ZoxouqrZIUrH0NKY2Ql5Etz/+lZPXAgNDHc0xmx2NR2eywgQgDoii13ZM07LzxytsDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBqcXm3A; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBqcXm3A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/yh+FDwSJOLbB/BuyGaX0kstUAv783ZsiQZ9hc8crzz2gk+wMGv8nmTVwMIuSa832NSPVoYSBt2blegEXITxOCF7nuGY5ciV4bcWn2uxJFWdPDD0KjwYHlC1DMYB2cDFo1soCoQeQ7jwaTrPk0PpuQiVK7VVmtYUyCcZHQ6GF/Uad+kOF9zVuNiDGdIg/i63LN8gexHCJPWo/oI7DIbLheuXr091hJaXN0jDlBsXGA8+44DQRL9Py66VdjISMK+LYhB9pb+m6kekhrINANY1XbF9l0b8oxzib+iuNLXoq5X/2CxwJssLpVkXOLySAuKoIL3gXs7NPT3CU7jhANZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTOYI9Vard7aA/LWIYgqL1ETu+a5nlV6xexTzZSSDXI=;
 b=L6yMMzx4lLClJNMTa/n/zwYoiHpUYUF2sGiL4tU9MatJWGZqT14gPqjnGJPdw0o/NvqO0SgtXp/QEs/uDfdpkjrTjNmMcpk4Hheu1cmwMW7OOt3mCpk0j7Jp5HqpEBe4SToBknscYJ+awLOt8GwXbGrPQKrBLjugp0Vlx17KlJxEiVJNQ3D9JFbu/hmeDe6AbIFIt8ioWZ8Wrb3xqUiOlE/h9fdCUpU3laZFfiyioSxekHnwEonldBsU4nS8Upw09W1JIg4qvlh98QZ6Pa9muj7ceJH+sHddHjeAJyPjMowYLhRIm6Y1vXnhrgm8XeoSWBttj8KiFHmX5pyQ6/XmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTOYI9Vard7aA/LWIYgqL1ETu+a5nlV6xexTzZSSDXI=;
 b=nBqcXm3Ap9aUlDHbhZsooA6KcnXhhTfV7DCQNjyB30LsA/ZOhh6bcgzzDZ+c2V1itrcOGONyp4CXcJjqXOx9vxfErPwt8f8TciGTlvo4mAI0aPCRTwyWgUlCJNWsOelVDmMVe7ZvmNyvnzpQTQEQQgZVToPEaRl4C00eD3EMFRkgztwniqBtJCfB4aWbLwrylBDemDZnIJQv9PUPjIblm+uFw0Wz546C/aw29l+Vtm8WJ4Hyyf6FMKVk46KwsiLC+7xQZJft705sa1XeAqqqClLs0vbm63bncPa5k78pCUYL7WrXaIDJHCKrpLlAo3M9EZDHcLpYFJWB1sA5d8y8xQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 2 Mar
 2026 08:41:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 08:41:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, "rostedt@goodmis.org" <rostedt@goodmis.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH V2] blktrace: fix __this_cpu_read/write in preemptible
 context
Thread-Topic: [PATCH V2] blktrace: fix __this_cpu_read/write in preemptible
 context
Thread-Index: AQHcqdqrzEa0aI0kSkuxxWUm9NQAWbWawI8AgAAsmAA=
Date: Mon, 2 Mar 2026 08:41:58 +0000
Message-ID: <84f1e52c-7e70-4b98-8302-ca1f1e3db9fc@nvidia.com>
References: <20260302002207.12165-1-kch@nvidia.com>
 <CAKb3OG_1yUUhLK8uHUxrYtnpph8jNr_j1kjivEWQ9VtkP-fRpQ@mail.gmail.com>
In-Reply-To:
 <CAKb3OG_1yUUhLK8uHUxrYtnpph8jNr_j1kjivEWQ9VtkP-fRpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS5PPF5C5D42165:EE_
x-ms-office365-filtering-correlation-id: 61b8cac6-247e-454a-d6da-08de78379148
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 /IrVdN/EWdB0ci2GBiKNBY+Xc+mPkXU4+OHEozEzBRHje3o12vGi1bb3GWpdy0eju0k6sXHz69/cSOGvlcxPj34gNpfznwclTwWPmtV6KDKCVtjLtHauMBF++EHCqoh/ETOhKLIWJuLlknyzYasjA0/SJVFDUY4Ayk8aXp5y2OKOblxPLQB2/5DAzAkPYj1rVTaeCZ6RfRntHSTJGhomfGBbzl0LU3i967sSziDJDHEKsZCeQxZEVnuz1jQwfAAkTDidnUW78cbGVj5/nqUCMV5XeEFxDGyy+lcz1Sz4V8SY90Ndr45UrLRgRqo9KZNz8RiPvQ/qTxTCgTYI+bQ9JC0h3TT2CMMblbg4tfZMxfYYGi/947r59eTvThGHZmDC0E06ipi+iwNJmyoffh5XI7b/nODbcRc0pzI8EYTcsElMMa6Tf474fxBR+es6F2A9bsdsuFFw4yTKh9pVmOG6vz6u+5TqCVd19MyRiDQEzpQ8PXtxezPIoHd5dVnJPSoHDLBtPwh0VnjtPVfAwDUpvSZnSvAd6P1iFjt86/mFjE0m8GjrAy95TSTKWSBsq6M0h9Yi/Bf15g7c592kdG9jXwLXwZdz6jk/eV39I2gppZ33au68WtpqoRclkHoqCPWQLtz87JJMbA0PrDeyx3WMylBVYNRadaKDWZ4suTRPbD6NRzqyPQSrnWYWnahQ9RABNUT6Ew1+oz2n7ckrcloB8TjwcOYlkJ499hL3AI8frbHHI+yTKEKuPRVqRv3ZA5fId460R/+o7Lfyd3sTm7pBzFuaFJpk1Wkb6/BIraETM2E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXRIeG1rU3hxM1RtS3RqN0NGQTFLZVVpMzRTUjFMSXVWVkZaektRK2hLejh2?=
 =?utf-8?B?YU1tbjRjR29GaEl4d3kwNTl5emFaYkQ5bkthaTk3L1l5NFp4Y1hnZm9mMVRF?=
 =?utf-8?B?UlpFU25EanRjWTlMR2RDb0NtSHFMZHRHL3dIMENVNFNiNVl1RWhRaks0eDBR?=
 =?utf-8?B?RStKNGhDRlZZM0w5amxJOFNrbDdQWENXeEw4Tk5MeDlpSmlHcmlHejZqUTBh?=
 =?utf-8?B?Y25xdEhJa1M5MnEwM1dFUjBpZkR0R0E4UnZIQzI1MndpZlVPU2EweXBjVTRk?=
 =?utf-8?B?UkZ6ZmtTTlZ5YjFvUmxsNzExc2thWExnaTNFd3FKUlAxZk85UE9IdVN5UnN5?=
 =?utf-8?B?djI0TFI4ZFB2MDQ3Qi8zckdpZURpTVlJZExvS0YzR1VkeFBKbWgvRFVKNXFX?=
 =?utf-8?B?Y2g0VVRlbmVHV0JGVzNva3BnMUpnSEZQd0tWQ29DUGwrd3d1emZMTXJUWUI0?=
 =?utf-8?B?RWg3a0UrME8wUklBNWJDWjgyR1ZXM2hZOCtuZ3pEYW8vOEF4YUNwM0ptenEx?=
 =?utf-8?B?UXpSTFJzZjkxYVduT1FRaFlCOUJmMWJQbk1CSHp4MGxqUXBQalV4UC9SVXdw?=
 =?utf-8?B?ZmFLaG01anFocEd3bUVRMU8ydUtKNWFrTWxSc1RYeFRWNHJNLzBtNlhPTUg4?=
 =?utf-8?B?a2I3RzVBNnNxSmFlRXhuRjJqZXJGdmRLeXRvMlRWZk1VaTR3cEduTlZVNlMy?=
 =?utf-8?B?bmF4M2ZDeFZ3VG5yMzVubTlTTWpVNnF4dUd0NEc4UFlReWlwSThwYUtFMERz?=
 =?utf-8?B?Y28ySFZqMjJkWWg5R2xyZ0VsSkpENytFbFRoaUdWV3ZjQ3FMRXZrbHM2amxO?=
 =?utf-8?B?MHErM1YrYWRUdW5hTDR6dExBVW5XQmRBYWRUaGNXQ3lFMmtCRmNONUJFYTBv?=
 =?utf-8?B?QjN2Z3E4c09Yc1Y1UzJnd0R5VFZNL3hJQnFrRzlXUVNiMEZibDd5R1Z0K1RW?=
 =?utf-8?B?Vk9mSUgrcW1WK0toRGxINjhkbnF0NFZ4Y1ZCcnhxVUU4ME14dDE5K0FTU0Nt?=
 =?utf-8?B?OWkyTGFiMVp3MzU4OC9DdFFwbUJsNmZFNEtNKzRrTDFHdUNObXNvTnVYMlZt?=
 =?utf-8?B?TGZjS1N2aHQ3NDB5Q0ZwUTI2K3U5SkdxeS9zek1tblJSbXlKc0I3ZmRvNVVO?=
 =?utf-8?B?eXN4bUo0d3Bvdnd0TDZFWEV6M2FHY2hUcXUwdTJMV1psRjJ1UDlpRmxucXJG?=
 =?utf-8?B?dHRYZlR5YUxvSWtXa041Z2hKZDVZMGFQLytWcE5VM1MwSVZHeWFzYXBjNzU2?=
 =?utf-8?B?dWxDekxWeW1GVVViSStEd1ZxTnh5cXE5cUtnRlRkVVkyTXk1NDlXdUgySTd0?=
 =?utf-8?B?Mi9PdFRtM1RWeDFzQitJY09zNlo1bXBFT1VPWTdKZlNEdUtVU2JrWDVRMjNK?=
 =?utf-8?B?TnUvQ1JWSnVsbzJvS3g0eTd1bWRuRXRmb0k5SktnYXV3dzBtaGxzNVBQdHQ1?=
 =?utf-8?B?M0VDTmovaS9laEZKclJQZVdOenVmVmtpM2pXTjR2dFluWVBpZTNGWUdvdDRi?=
 =?utf-8?B?bkY0V3hJQjgvSHgzdFBkamNDZWQ1dTBWL1FvRlhFai82M0tKWjlieThHMndk?=
 =?utf-8?B?L3BubHB2YVc5RUtHTTBSbGlJVERHaTJxQTVCaXhMR1JHUVhpSi9VSGJ0YUxu?=
 =?utf-8?B?Tys1bDZ5UzZSU2tFTjBENUVKRWpOM1BkQlFlZTBCWXhVVUtRa2Y2VGJTMnBN?=
 =?utf-8?B?OW1udmJjSzd0b25CL2ZyZ0JIU3lsQXl2eGxDV0VHbW5WN0VhQVZZZGJwYmpk?=
 =?utf-8?B?V0JKRGF4Ym5KZjBKc0hzL0F3RmxteEs0eFBndkpmZEQ3djhCNnJSYzRSam5w?=
 =?utf-8?B?cE9EbXUxZXlhVXo5dTNKREtvWkptc2JUbmdoN2JyM3ltU0NhUDFjbzdyZDcy?=
 =?utf-8?B?NldncnQ3M0RtT3hIWHBLczljVzNZbllTbTZvZnJJZXhLU1BHV1NDeGdaSWEy?=
 =?utf-8?B?WWNDcU5NL3htQk1IRVZ6Y0VaZmo4Wk5YQzJaTVp3L3hGOXRzbURpSUZVV05y?=
 =?utf-8?B?eTExVUJsQ09uSzlYZXZOcWhQbXFUK0ZyYnFRYXRuQ3VicmZaMlhKaDYwSGds?=
 =?utf-8?B?RHg3blhJZ2FEamhNZVJyQWRTZXl4WTZDU0tEbzVIMDlHL2RoazlUTkhJR1Zt?=
 =?utf-8?B?UW5UVytlRHFMVXhhY01PMmtTYlFRS2VXb1ZwT283TUNXM2tsa0VrUWxVcUdQ?=
 =?utf-8?B?QkZRMlF1NHQ4KzhDakl3aDdBQjFKYW5CWnlPQXFjYlZRS3JzYXJXSzFLQVZU?=
 =?utf-8?B?QUgyeURLR0tIRjM1cFdXbERPaGhhUmFacHl3YWtYTVBVd1FzMXEwd3lwMkwr?=
 =?utf-8?B?RTFPdi9oeHBxWXdsWlV2alczakRpTHVhRmp2cmV4a3Q3Nmoxd1FFN1NYdit0?=
 =?utf-8?Q?aopUmDTgA3e+44JEwy4dnkl4Sh0ClIxFGxrbFiszcYsvh?=
x-ms-exchange-antispam-messagedata-1: FyZ2EGsWun1G7A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7D0B1F3ADE08D42862C3B6E007A78BA@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b8cac6-247e-454a-d6da-08de78379148
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 08:41:58.8572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtQQtUUk5pSPEq28CCTKTHBYwUU6U+jM0TiJPTDg9Op22AstX7R7DyLIkjB8AM04dwegaVXg2+NrdmTGPF9Lzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

T24gMy8xLzI2IDIyOjAyLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBPbiAzLzEvMjYgNToyMiBQTSwg
Q2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gRml4ZXM6IDdmZmJkNDhkNWNhYiAoInRyYWNp
bmc6IENhY2hlIGNvbW1zIG9ubHkgYWZ0ZXIgYW4gZXZlbnQgb2NjdXJyZWQiKQ0KPiBJIGRvbid0
IHVuZGVyc3RhbmQsIHRoaXMgZGF0ZXMgYmFjayB0byAyMDEyPw0KPg0KPiAtLQ0KPiBKZW5zIEF4
Ym9lDQoNClRoZSBjb21taXQgYzcxYTg5NjE1NDExOSAoImJsa3RyYWNlOiBhZGQgZnRyYWNlIHBs
dWdpbiIpIGFkZGVkDQp0cmFjaW5nX3JlY29yZF9jbWRsaW5lKCkgZGVmaW5pdGlvbiBmaXJzdC4N
Cg0KVGhlbiBjb21taXQgN2ZmYmQ0OGQ1Y2FiICgidHJhY2luZzogQ2FjaGUgY29tbXMgb25seSBh
ZnRlciBhbiBldmVudCBvY2N1cnJlZCIpDQp1cGRhdGVkIHRyYWNpbmdfcmVjb3JkX2NtZGxpbmUo
KSBmdW5jdGlvbiB3aXRoICBfX3RyYWNlX2NwdV9yZWFkKCkgYW5kDQpfX3RyYWNlX2NwdV93cml0
ZSgpLg0KDQpBYm92ZSBhZGRlZCBfX3RyYWNlX2NwdV9yZWFkKCkgd2hlbiB1c2VkIGluIHByb2Nl
c3MgY29udGV4dCBpbiB0aGUgY2FsbA0KY2hhaW4gZnJvbSBzdGFydGluZyBibGtfYWRkX3RyYWNl
KCkgaXMgcmVzdWx0aW5nIGluIHRoZSBzcGxhdCA6LQ0KDQpydW4gYmxrdGVzdHMgYmxrdHJhY2Uv
MDAyIGF0IDIwMjYtMDItMjUgMjI6MjQ6MzMNCm51bGxfYmxrOiBkaXNrIG51bGxiMSBjcmVhdGVk
DQoNCl9CVUc6IHVzaW5nIF9fdGhpc19jcHVfcmVhZCgpIGluIHByZWVtcHRpYmxlIFswMDAwMDAw
MF0gY29kZTogZGQvMjUxNl8NCg0KY2FsbGVyIGlzIHRyYWNpbmdfcmVjb3JkX2NtZGxpbmUrMHgx
MC8weDQwDQpDUFU6IDE2IFVJRDogMCBQSUQ6IDI1MTYgQ29tbTogZGQgVGFpbnRlZDogRyAgICAg
ICAgICAgICAgICAgTiAgNy4wLjAtcmMxbGJsaysgIzg0IFBSRUVNUFQoZnVsbCkNClRhaW50ZWQ6
IFtOXT1URVNUDQpIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlY
LCAxOTk2KSwgQklPUyByZWwtMS4xNy4wLTAtZ2I1MmNhODZlMDk0ZC1wcmVidWlsdC5xZW11Lm9y
ZyAwNC8wMS8yMDE0DQpDYWxsIFRyYWNlOg0KPFRBU0s+DQpkdW1wX3N0YWNrX2x2bCsweDhkLzB4
YjANCmNoZWNrX3ByZWVtcHRpb25fZGlzYWJsZWQrMHhjZS8weGUwDQp0cmFjaW5nX3JlY29yZF9j
bWRsaW5lKzB4MTAvMHg0MA0KICBfX2Jsa19hZGRfdHJhY2UrMHgzMDcvMHg1ZDANCj8gbG9ja19h
Y3F1aXJlKzB4ZTAvMHgzMDANCj8gaW92X2l0ZXJfZXh0cmFjdF9wYWdlcysweDEwMS8weGEzMA0K
YmxrX2FkZF90cmFjZV9iaW8rMHgxMDYvMHgNCg0KWy4uLl0NCg0KSGVuY2Ugd2hlbiBfX3RyYWNl
X2NwdV9yZWFkKCkgaXMgYWRkZWQgaW4gdGhlIHBhdGggZnJvbSBibGtfYWRkX3RyYWNlKCkNCnRo
aXMgYnVnIHdhcyBpbnRyb2R1Y2VkIDdmZmJkNDhkNWNhYiA/DQoNCkkgdG90YWxseSBmYWlsZWQg
dG8gdW5kZXJzdGFuZCB3aHkgdGhpcyBidWcgaXMgYXBwZWFyaW5nIHJpZ2h0IG5vdw0KdGhhbiBi
ZWZvcmUuDQoNCi1jaw0KDQpPdGhlciByZWZlcmVuY2UgY29tbWl0cyA6LQ0KDQpUaGUgY29tbWl0
IDJjYzYyMWZkMmU5YjgNCigidHJhY2luZzogTW92ZSBzYXZlZF9jbWRsaW5lIGNvZGUgaW50byB0
cmFjZV9zY2hlZF9zd2l0Y2guYyIpDQptb3ZlZCB0aGUgbG9ja2RlcCB0byBuZXcgZmlsZS4NCg0K
VGhlIGNvbW1pdCBjMGE1ODFkNzEyNmMwDQooInRyYWNpbmc6IERpc2FibGUgaW50ZXJydXB0IG9y
IHByZWVtcHRpb24gYmVmb3JlIGFjcXVpcmluZyBhcmNoX3NwaW5sb2NrX3QiKQ0KQWRkZWQgbG9j
a2RlcF9hc3NlcnRfcHJlZW1wdGlvbl9kaXNhYmxlZCgpIGluIHRyYWNlX3NhdmVfY21kbGluZSgp
Lg0KDQoNCg==
