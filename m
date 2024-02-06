Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101B1C2A6
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260078; cv=fail; b=oRp1jbcq9UvsS8HPJ4Rw+MfWoighwxq5Rlvdt9JdC+1VRShX+ZQh1MM6lc3d7dQiLBFzYWSxuKkLv23vhusZHQld46aEFsFBu8HTvZPy4YX82OTQzmnm5sac7C/ssEWITxzF5cQ9j2xDFynln6v4p9EM/7b1dZQZ8zMxH23StrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260078; c=relaxed/simple;
	bh=mGeAkX8LVBIUcRDOhbzEETMM4FxwBTjYev/ePpeoBuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZS6ltj692PMcNH8b6b7DwhqSujqD5dGLiU3NShpjthUfhAvQDO2HjmpJABsgeXhOceXlbqQ3+cEUwqq+/AAdQ5JFTWntCYMyyEx25OX6TB4EjvgPPPCmMoVTG9PJlhwOSRAtthGXzKQ5E7f9pOlOIzllSRfj5A6OKHCOuqaWDTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOrCcjOf; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOrCcjOf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzLEa7mLoD6D3KWIm0KOD+bEfmITc6TrQxdYmFOQnSQjORL07MDW1ZWujIe3XBx9gwW6Xu3ZfUOIedmm4ExfTjJOoDzv7cbLaA777Zq1FIKYyBhO439ULY3p7qb42zIS2YwjkZi3BZyaoo2oeMo8me6t/SLKpBTcAo9yeUXSM5Hsft1XMeJU0gNZZUufdz86eL0GrU/zu7k/K8lUJdcWm2A61Iqcyc7kWEjdj75m1fAui2T1u8idSmwAjAew76jixYKDQN3ZxsHxX6jnjp8IuAbg+rwLoMYtqIJkG9/IY4OcPLw8tYkeDNKv54SSRp07upWTRZ1mA4m+9BC1ClSSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGeAkX8LVBIUcRDOhbzEETMM4FxwBTjYev/ePpeoBuc=;
 b=hCyVBjztGqOz5plMvmcbOTAckd2L8v9qKsrx2fi1xQHvvhkPCoTYImXu92owUEDXF7HV3/hPykoPCWOJyerYANlOj/FoIvacewmDIAAdci0ITki1JSz+UKL/Ta6sBMnEF/lyJnByp8iQTp4pnHfkpbXVnVxIXc+El8UsLh7/Kzn8uECwJOshi7f3nKCkqfdxFGrU5ONHIroQwIUnP6c3kyzUiYQntEqWHmUpipz2jvKBM6YVLoe8K4x7DcAZTW3G0dvxYW7vQ4kE36qHJmxRN2o3lNbPpvasbwq67xB1KtLkTKINdkv1K2Njdc10eC41CDj4LsdTkpPVYFRXpduK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGeAkX8LVBIUcRDOhbzEETMM4FxwBTjYev/ePpeoBuc=;
 b=rOrCcjOfLFKSaH5zocAXRvx84D0mxO5se6uvYpzvL5XzKo5idxoXtw1AYudOZf10nM39Si6q+1nPpPNkSgJYSUrfun9mf7JPKhmvfV02pFPsUB2ulHHB4WBWGkj791AubrCzr7gWhktFmLZMx5yUQAEp3jT+b+YBwlWf2MYRSvIgQr0nwWJ/bHTtwOghZZof61P/3QOttLZQSJ0r14DKhXK9gx3eq6O01F/Ug0dXSKN2Sj3IqHf+imM9D/5NAnpgcY3s2xMZCJz0iuXRKRwiJiNEqqNvw20hpZKKcneaGtIBv9ADhn6T345VI9XnCuACAcQRXXO41fktn5Bq4LIWZg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 22:54:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 22:54:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 1/5] nvme/029: fix local variable declarations
Thread-Topic: [PATCH blktests v1 1/5] nvme/029: fix local variable
 declarations
Thread-Index: AQHaWP7VWyL7Sd+5KUWovevlZeTeZLD97OcA
Date: Tue, 6 Feb 2024 22:54:32 +0000
Message-ID: <61e70897-7118-4e81-b63d-c37c7493a6c5@nvidia.com>
References: <20240206131655.32050-1-dwagner@suse.de>
 <20240206131655.32050-2-dwagner@suse.de>
In-Reply-To: <20240206131655.32050-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB5642:EE_
x-ms-office365-filtering-correlation-id: 6469ce06-7e4a-410d-442b-08dc2766956e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pKTIIhTg541JlxTZzR6XLVZ1ohy2BuwtdzpAuUl6KCEA8g/wiMWWzBHbvUGCO3VXpgxmYf8CKbOvk3ZSbXtLre1pE+beDQFGBBlSkfEy11QeAkhTvvu7RXrjcEGGNU5iWv8eI20EKpmFsI37/jszTyHVGC6JcuL4yOscudb2segRQVmFnh/pPhr3Ll4JyFYZCswOXQwv1JRMYA5mcqx2vC0YYScLy5Qw0ufeMKGRbwMdaoHnjcCaKfiUA+enohl4dnv8BaQiHhHJp3ILaiP87F939uJifz0wmOZPt49MILgHg8LlDctomWD2ITiMaehmpAnHkLK0dXYAPNmK8RbDGzQXhAsO0jnQoSVu3qd3acsjy1NIED8T7QdquO6bi1hzRvX+JCo3E9dfLnfr0fTwcz5Y9DjXLIk5FKht2EKYORi0IVU6tOYQTEYTmWZrdWRKbqgcRM5AegwkSXGoymSjqVsJIVmm/esDXkGvJfp3yEZkHYd5VISqFqsYY+OtLk2nBtU5aerIHs7cAu/n8EVkHlJ74kKHnZr7+QC4xhnC9ebk7umHRbB86YOd7rGcIbngSPNjVmyqCqrq1QxwNTmwmcEA5onR/yBgdxbStmW6gPOig9CXk0c1FrteUQOZ66Z9vIpE9SO5HfI3SjCtn/2gAHaEhWZsbDGBw+MeS/B1Z7XLq+psMacUXCJ/R5dYDj+n
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(316002)(66946007)(122000001)(5660300002)(91956017)(110136005)(4326008)(38100700002)(2616005)(478600001)(8676002)(66476007)(6486002)(64756008)(8936002)(76116006)(54906003)(66556008)(66446008)(4744005)(71200400001)(6506007)(6512007)(2906002)(41300700001)(38070700009)(36756003)(53546011)(31686004)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjhsaUtYMnVoeDN5TjdmUHNJaUhaeE5pS3VpbXpQbVhET1FsLzZRZy9KRzdi?=
 =?utf-8?B?UXNVQmkyWXV3MmhMbXNSTjlCNm8xeWMyTUpjQ1JyWElTM1I0RnNYdW1xMS83?=
 =?utf-8?B?ZHVCWktRL29vUGg1RmQ4anozWWJBNm0wUnJGbGViRmVFN2phcnQwbGVmOERT?=
 =?utf-8?B?WjBQcVZjZjk3ZXF1V0k5ZWZ4MEo0clJsMGdkV3VaamZYaWpFWnp3M1ZpMmxV?=
 =?utf-8?B?OHNtMkxWZHB5cXpkZUI5dFFrUW9HYzZBb1dadW1BSWhpVEt1a0E3TlVZZk85?=
 =?utf-8?B?Wk93S2Y1NVlNRFNnUUZKdk5sVHgrTXV3S09XZVROWmk2RUR1cjdqUlNobFVm?=
 =?utf-8?B?NkNWdGEyQ051L1g1bjVuMmhrRWo5dVNKOXozKysvblNOT05ET0tsTWlITmwx?=
 =?utf-8?B?VU02MWJKNVR4MlBsWFQvSS9weUt6eERlU05mNVgvNWJCSFNTcFdodUNsUjJy?=
 =?utf-8?B?TDVQdEFOVmxuMGE0MDNrbU1vWWRMN3ljZ0tlWkpzQTZyN2dCVmpZM3E1Vlh1?=
 =?utf-8?B?MXN6a0l3WXpvRzh0dHBvaGM4SHRxRnhuaDMwR0xBeDQ1VHlodmNWSzRQRUUz?=
 =?utf-8?B?eVdEdHp4TmtPdG1Pd1NhazNmZHIwWkozVHQvV3Yyd3B0MVp1OGRQK2M4bFRh?=
 =?utf-8?B?R1U4ZXhqUW5naDQ1WHUxM3RYU1MweHRIY1pkdERvUGlraGxNMHZnQS8wOHp0?=
 =?utf-8?B?VHVCR1hhUE9uWWRRWGZRS1Q2YjZaOVJ6UHJCWHpMYUFLUS9CNVVLRHI0M3Zr?=
 =?utf-8?B?bVp3YU1xZUlmaVVSZC96ZmRsYndCSjFidlV5dkVuTUVLaXdQb2dPWVc0YjQ0?=
 =?utf-8?B?aGZXTWJjTEJIUHh6aHdRd3RQMFkxWUxLWlY5YTlHMkVXYmFENENnVnlCai9w?=
 =?utf-8?B?aG50SzNIWWQyMkxIUDJFNzFyN2M0c0t6ZkpNT0ExSHFtTFZXWmhneU1Ob293?=
 =?utf-8?B?OHl0Q2lnL3hrVUQ5WktndU9PRnIyNk9hUFVkdTU2S1J4dXFPVW8yRkY1WlBh?=
 =?utf-8?B?K2xXY1ZnMDc3eUJiSzE5b3YyMWRUOEZGWUJSTFhyT01QcVZ6WjlweURLR3Jx?=
 =?utf-8?B?Z1U5aERFWUh3NEdZY3VtQmhNU1VqUGt1dGdjYTNtTFhqRk5MZUZrc2lWWnJI?=
 =?utf-8?B?U1dMWVJQZmw1SkJlNlVyUlh4VDRFTVNRVmRjaEM3djBBY2FObWVZOTRxakdW?=
 =?utf-8?B?MUVGazhMdko5a21zdXVkVldoV0F1MUNZcEd0azF2TE9vYVNkdDJVSjRFT0lJ?=
 =?utf-8?B?R0xIbnhuWE1pczZsU2dod244TEdCM2IvRDFkQkVtYXpDdlllTjErNmZWNk43?=
 =?utf-8?B?Y0h3QzcwTEhQRFZsOG1ac1J6RU1aY05JcVpIdm55SXBqalN3MjdFMElRTzhP?=
 =?utf-8?B?M0ZwRitSSnU2RnRkaVVrd0xBdWdEOTk1QkJPeEZCWFNlV1Mwd2poajFpL0VF?=
 =?utf-8?B?N0NyOGRLSzlWZ28zd05UYW4rWGRPVVltNCtCMlhNdzlXQWhZeiszVUs4TVFU?=
 =?utf-8?B?aytUVmdoOThKVHRXeWZVOVdUeGhRYWNDUEJmbExNZVV0V2xrS2xPeXdyWWkw?=
 =?utf-8?B?Q3I1cVQ1dG5jdWJNdm90T3JUT3NNUWxudnVIMEFNckJSWEJSNkVERlVmZE9G?=
 =?utf-8?B?Y1RyUS9rWERBT0NBNWIxMy9PaXppSDdQV1R1akE2REFJalJSWFJ1cnJMdlhp?=
 =?utf-8?B?SUtqK0dxeHBFUGs3ZW52ckY5TWxENUhucHNEd0YyNkVkQjJ3OUIxRmlDUDJS?=
 =?utf-8?B?dmljOEZLWnJISHJhMkk1NkpERitnemdKZ0tHN1VrNzIxMmZ6STlTNHFvbE5y?=
 =?utf-8?B?NWRxTzBXN2ExVmZJdDRJWXRDMitLaVl1RUt3V0Qyd1U0eGtsb1BLUzhSUm92?=
 =?utf-8?B?VzdBUXBycG1LTCtJeVA1L1VPYXpiUmlXN3BPVUFOZGxITXU3UnkxUHY5Wjcy?=
 =?utf-8?B?THlwc0hFS3ZPYkVETkZGckFsdS9tcWVzeGMveHhQenZKcTBva0FabWdrVDNl?=
 =?utf-8?B?MzhzaHlqWVgzbllKeWdiZUlKdlRLckpXdVRPSUV3SFpXeDBiV1ZDNDlOUHN4?=
 =?utf-8?B?OHliRWgxVUV3dEtDb1l6aVdzMWQ2Q1V3SnNZYjNVd2RITVJSTjJjaG9QS0ZE?=
 =?utf-8?B?Mnpmb2U4dUhZMDhaUGdjVmhKaTZaRFhtS1ZVbjNlRE1Zb2ROUGZRdVZOV3F1?=
 =?utf-8?Q?toXBYepbPV3fbyKpyb/VtqwkADW4rNjRc+GwmLFKYMru?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84F5466870796B42B6E00163BD9D3D24@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6469ce06-7e4a-410d-442b-08dc2766956e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 22:54:32.6316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DR2b1jZlbptZTriJboj1vIZU9bfizYXYvsYGw1CAc28yFzKiOdbPkXnHfZA2Wkl2GfBo/fHdyRBtjnsjJfZzPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

T24gMi82LzIwMjQgNToxNiBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gVGhlIHN5bnRheCBm
b3IgbG9jYWwgdmFyaWFibGVzIGRlY2xhcmF0aW9ucyB1c2VzIHdoaXRlc3BhY2UgYXMgc2VwYXJh
dG9yDQo+IGFuZCBub3QgY29tbWFzOg0KPiANCj4gdGVzdHMvbnZtZS8wMjk6IGxpbmUgMjQ6IGxv
Y2FsOiBgYnMsJzogbm90IGEgdmFsaWQgaWRlbnRpZmllcg0KPiB0ZXN0cy9udm1lLzAyOTogbGlu
ZSAyNDogbG9jYWw6IGBzaXplLCc6IG5vdCBhIHZhbGlkIGlkZW50aWZpZXINCj4gdGVzdHMvbnZt
ZS8wMjk6IGxpbmUgMjQ6IGxvY2FsOiBgaW1nLCc6IG5vdCBhIHZhbGlkIGlkZW50aWZpZXINCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==
