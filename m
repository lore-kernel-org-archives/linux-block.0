Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260D15696E
	for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214777; cv=fail; b=Tw1W2AHPka22pnUrdEyC9XlTKvQqQoD8f9EVB61g3RxFa2QJTGGCp1OGYU03sDbnrf5zdbZL30Z8qX4EP/9zVNdyo3H2kTyEYwm9lkJPddL2ERAhxwevGyQV/uOHObONZ0buYPYIXBswTqqPjNLQP9qVlHuZG5SLHIrj6lJ++5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214777; c=relaxed/simple;
	bh=tyWEaO2x+FYKu9CmpG8IXT7BmQEMfL91K4wUY5sOKA4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KJU8UM4Mbkd1T7cDb7OMCWewyhEUVKdlg362cwOVLS3+JCIGq8zWRAr0ZEOM/d3Lq9KkXps/MN+AVskDIm8oksDzlhKWhBXxD0MpQhmE1BOJEzyJp9m5QhVpCjxagg17uAk2KvWjO6e1I5RhaJnOe9q12Jvecd8XyCXKFmq8a8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k/TLl1Na; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k/TLl1Na"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V19VxQ5yaVC+XnIorGf1iv2BqVy+kzcspiJ6JVE1Iw/0T/VSNOJAfelFgwvXvJ43yXyNelP1cUu7O4FRI9DPneNTVWoHuDOvzPO6BRrn7vfBd9AnwGQyg60vxQACCFvMJM2s9R66pQzk7MoXuxcSjOfFgU2Wv4S9wISuYKUeKVEWMf1jKRGdN+cv8LcexW/UMnzJjGF+ER+F2x3txxMz1+V0Thszpqdu0S2o1HxDQvcBAQFiNq2rnfQa+IZQeXxakstMR16v8dcOZru7gGDNoTLQ451K4baq2xKBiqcH5nYGfd7hNktOMN/yDZaDlcSKPX5Q3xYr6MxlfZGToeM/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyWEaO2x+FYKu9CmpG8IXT7BmQEMfL91K4wUY5sOKA4=;
 b=Q9K3cJhHpVLYW4394TP1g0kBqDGCYic6ThLCIBfiFOubOxHNPwGjZvjnr8w6xCnoZ/XAlA45UJ9mwyyO0t7g7xS4gJtbZPLKa26ZLWqIhiiuPtbxXCuvohmPVNzq+JRCFtz6rsZdqg4LRW5N/dP7zA9euqzcMTVtrclLQDO90/9Vs/Uweu69g4rY0juenJ9dna0ZU/JLdIobyECuMmhFRcg0uX892KkUsu3tgYYJUhoBBB9+Th0UJnIhJdASZBwnECm7MamqTOWfHUCjkFtpixO95krJNGmgyODssZGMiO+Rw0madfdFQsojH4IP8LW9NB+kNA92KZ3u/qk6H30/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyWEaO2x+FYKu9CmpG8IXT7BmQEMfL91K4wUY5sOKA4=;
 b=k/TLl1NaZu5qVbdLRkLPf9L5JUq5K/UrhsWKbJ3xwm4LI/GW+OfyuciLx8bQmEHOzGKnVVWaJ5ztHVuvrO+HJaB+83y1jAydB8qU01iwz4NlHrdq4gH/r4sWWK0mgNrjmWqxwfvyg3uSoZ3DKxDi2pxKTTUVg3jEHEJp3E55Cs2qk7hyTZJgNkDjsFtVmGuEPkTJYjeG1zvI/iufjEpoPkLA5CnOfdyUp54DPcH6S3AEqhE9X5b/TT25LBPV/BnC5f7epNVwxA/EhMkFbsAYBx62m1wH+Y1TmtvdXpZgbEmzvfD6El/fyzeP5Zv+CBH/Pw0c9PRLAg5Qkoinrlge+g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 20:59:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:59:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/3] null_blk: Have all null_handle_xxx() return a
 blk_status_t
Thread-Topic: [PATCH 1/3] null_blk: Have all null_handle_xxx() return a
 blk_status_t
Thread-Index: AQHai+3385Flp3ICuEeEiM3g+ud5CLFp18QA
Date: Mon, 15 Apr 2024 20:59:32 +0000
Message-ID: <42862541-6a62-409b-86bf-cbd3f6562ffa@nvidia.com>
References: <20240411085502.728558-1-dlemoal@kernel.org>
 <20240411085502.728558-2-dlemoal@kernel.org>
In-Reply-To: <20240411085502.728558-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4220:EE_
x-ms-office365-filtering-correlation-id: 8d619e6a-e603-4fef-92ef-08dc5d8ef302
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1ko1uBo5V5p45U82+HV52MbHQO9/ZuiUGaymd+/Bv6AsGe8Djenj7PMd/DPWtAIbGkpe6nsyBXFkGdYVymKfglodn1b6RP2rzlbNjNCrtq2VAoGegSBG5MgYRu4Nq7aAuAVvFEIQEao/isI3E1iD3oRevOtmveemvGxZ9xxzQbNrFW4Figb8qSwk0kd5Fw0yPI1DbINb+5iHM3j0QhPzERZ/Ic5D81P9OX5pP9X7pW5t7jnt8r/ZCZ3kShIog031PWSGCdUhPIjXurWj7BYG4dQrCZRb0Yis2GCkNui47LzZEzqhblXfs9vRJcu6JsRGjyPAsKzJ7Ff8QUsr6dlCTK96n5qWYbT3exr/F3dTWE9CWK18tc56Gw8JuHYxsV/GMzkgXlg2P0IQQpdD2nwW7xCVRZAEXv/u2Y8gSRZyjtwD86XDgqALKtMvJBXmPnjltEf1utVt2qNzVcM2n8NEdCVgxdavjhJzTwoLIjgooth6uiJnzQ+nX3L7wZLdwL8eEOTGIRQ1T8obDDB3qDUdNkbeeU6Yl7EHp8RvNyvzjnPVprtmZAh9BJkIM6v/LJgRIdaWomA3pe30ZVl984kzfc8N/H38FZHBjhdMa1O9c09XIKITHT6O72ovycLmL2L+fm5SsYzBV7f70Qd58A366b+J3+S00GHV+0OBh2dr5BueTwOdhPzUkMOYCm3LC6lqUiDGH/1gqsW4y6Eyy5l4KpklJuNxPvRhg3XUcQ8+f1Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KytJOFJncnN1S0RrZE5DUStVams2SERyWlJsRjJGMS93Yy9oL0J6enJtNW9F?=
 =?utf-8?B?ZnRXZTNISWcvTThGTHRIVUd3Z1lzT016cnFRRVNXQUtHaWhYNlkzSGxoTXFm?=
 =?utf-8?B?c1VjVkdXSUlxMkdzeFh2cC9pSDA3R0h3NmlxVDE5LzcxMVdJZERhKzc4NnlO?=
 =?utf-8?B?d2h3V2wzSlNrUURQcVF0ZTY1Z0lCRExYN2pVaC8rVkpNb0xvQUlWU01KMkxz?=
 =?utf-8?B?QXUvVUU5YnZOQXQ1ZVlHd2pmTTJoQ1JiZmw1MlluNzk2SC8yNU5pc1pZbUda?=
 =?utf-8?B?VFBENGRwak1aTjg1NlYxUW00b2ZYVjVUcm9oeXZXL3dxVTRPdk9rWGdiUjQ4?=
 =?utf-8?B?VGNVN2NRMXVZQVU3M2NmTU9iUUpMYzZ6a2N4UHlFbzJyZTRVTHNPN1R4VkFB?=
 =?utf-8?B?Z3JVWFNIMFBONmtGSzBqb2toWDJ1Y3ZnOFlWN1RCeU1rK0pCNFhReWZZZzJS?=
 =?utf-8?B?NklYaFdJaHBNdWlxbXFDVlN4blIxTDMzejB1Q2xPNkI3d1RLVC9URFlQQnpZ?=
 =?utf-8?B?ZC84K0hMdURGTitoUFB4Rm5CQTF6SEczZUsvaEJYRnBwSW00S09SbWhKSDd5?=
 =?utf-8?B?anM1Z1FtdjBEemdGa0wzbTN4UTc5dmFHSUoraUkraWdPUHNsUjJtY1JqY0pG?=
 =?utf-8?B?WktzRGl5OTcrZld2eVFldVZITk4zSHA5ZkJDOFc1VFJrZlBSQTVNVGU3clAz?=
 =?utf-8?B?SlgvbTFETWROYzhZUGNIODlVLy9xOVk3ZWtGMFB1Q2w3Z0szTXlpMmROcGxp?=
 =?utf-8?B?clJZSWlLTWpKczdEUUNNM29Fci90V3o5dHE2VzNlYmRhM1RIVldaSjFBUWtp?=
 =?utf-8?B?YTZMTWIySndram5nWE1ub0loVFN5SmZWdVVHNlpUTnRzbzZXN1hDVkFJTEV0?=
 =?utf-8?B?Y0FJbGhJb3VrZWhvc2E3RHFaWGZKNnVtNlZNdVlVbHZRYnJyMmxBdCtEK2dS?=
 =?utf-8?B?OGpjSWNwd0Z0aldFcEhhYVRMSFF6YVExdEtvQ2s2RXk2TTJwWXFYSDNIbFZm?=
 =?utf-8?B?U3g1ZFI0ak5pOUh1ZmpoS2NoQ0E0Q0FCM0N6NjJ6eHFqYUN5Z3Mvd0xXUmtx?=
 =?utf-8?B?Q25uUG1VaDZYckxJOW9ha0x5b25EcEMzV2txd0Nhb2FlVTdpVEFNRDBxaWI5?=
 =?utf-8?B?TGo5VnB2ZFM3cmVxa2J3M1R0RGxxSXNwNGNUSWNwNWxNQzhzbWVmbkRUdVVv?=
 =?utf-8?B?ekxuZ2NjQlUyWHpUOU5SdDFsa3NsRlN1K0ZhWGtpM0FIOUw3S0IxN2w3eVIr?=
 =?utf-8?B?WUUwTUx0SDNiOFJUTmJnYVk3R2NIb01DSDJmbVpOZ0NtZUpTNU5wL1VreHFv?=
 =?utf-8?B?UmJCaHVmSG95RDBYVWNuN2JBY2dYeGN2NXJneDlMakoyZjcxSkdvV255UWdF?=
 =?utf-8?B?dDZjRkRaUlgvZ09DenlBOFNvUlpWaEt5bjFIUkhWU2RkRHhHblNKS0dCUWMx?=
 =?utf-8?B?Njl1ay9SR1BjbDZRa0dEbFQ5SmdxZ3lOVHRrc0hNWGpHWEJ3S01vdmhTU0dC?=
 =?utf-8?B?Ylc4UnNobkNVdy9nWlZYR1VBUkJBWjRHVythVzcxRjc3ek5vUzRpbHFXWkpu?=
 =?utf-8?B?MXdDcWdoSVlESTBDOVdmR0tTeWNwM2dCdWp4TWlLWVRnUDAzVFNVVGdVbndS?=
 =?utf-8?B?UFZSaTJWRXhtcVVtVzFsZnYxR3UyRnY0ME4vMFNzbmtWdUFVaWQ5MXVuM0lp?=
 =?utf-8?B?c2ZZWVpnYVVlOHloUjU3S2dEbDdWVCtpQkVwamI0NGM1aExGdUJQNmsvcWFz?=
 =?utf-8?B?OFRrd0hWdUhJdjVtRVJYSTM3cjUzeTlDd2wrVUdQNFlzVlVFdU44M0Z6VWdH?=
 =?utf-8?B?YnYyVWQxZmt0dHhpcXY0aXdNekxVSUthUC9sbEVzbkVKSzhMcElFVWw5cFZ4?=
 =?utf-8?B?V21VVGdKTnpINmd2am0wVDR2M2FwS1VSdVZmRnBIV1ZwbENxbExOR0xJTGJL?=
 =?utf-8?B?aVEyVHpUU3pkcCsxVzVkQUI2Q1UzT3hXY1R0RTcrTzFXd0ZuT25vU0V2V2JB?=
 =?utf-8?B?Q09jYjBFbG0rWU4ycUNjS2E4MzJ4KzRER2VnZ1Nmbm9nTktEb2lXa25rTjda?=
 =?utf-8?B?TDVLYi82b0o0MHU5UjdDZ1BSMnZQNFRHRGk0SndZbmpId2M4cXd1N0FNUzcr?=
 =?utf-8?B?aS9rcldyMGk0TnU2OGtpTnprKytqbXcrbklYTXZ4bStaQitqRDhwOVMydFlR?=
 =?utf-8?Q?e/oKakTxm4B6VAoeRLaRn1DI92GBDxM9FZQcxqkqw+ue?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <996F621F352A2B4EBC7C5F4DAF278C40@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d619e6a-e603-4fef-92ef-08dc5d8ef302
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 20:59:32.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/mBiYh9/+fq8K9tL3oK650OctHOPksDM//PbFeWOidwZpD7+wtmEYi2yh0kZLd8KrCMoBoUwxUhC5jjVi4Blw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

T24gNC8xMS8yMDI0IDE6NTUgQU0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBNb2RpZnkgdGhl
IG51bGxfaGFuZGxlX2ZsdXNoKCkgYW5kIG51bGxfaGFuZGxlX3JxKCkgZnVuY3Rpb25zIHRvIHJl
dHVybg0KPiBhIGJsa19zdGF0dXNfdCBpbnN0ZWFkIG9mIGFuIGVycm5vIHRvIHNpbXBsaWZ5IHRo
ZSBjYWxsIHNpdGVzIG9mIHRoZXNlDQo+IGZ1bmN0aW9ucyBhbmQgdG8gYmUgY29uc2lzdGFudCB3
aXRoIG90aGVyIG51bGxfaGFuZGxlX3h4eCgpIGZ1bmN0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
