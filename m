Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8518E00
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090713; cv=fail; b=suzIVHnljyKrPf+BD29osZAF34yZhE3Zc9RwfSDkXbSyW+v01NKsQihsYWx4gojS2TSrNDGvc+4FY/+VF4cfMdfYYODvwvClqa8BjnEwqqejXQul3Vm9+xWCpQqTbfZURWahtY54ovCJSgxxJTGWiUUoXVLA7cvA9v9zfBkfvEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090713; c=relaxed/simple;
	bh=kN0dqsyNmtHI5kyxX4l0+zGEbOxWGn+8xWTW3CylmYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ms66+JwIJmfoR4tpFSfbRuKTm5xbIM+rBx1Vt0vHB/Tys1/xHe91wQLXiMNFlrhPJ7nsjTj9s09KUXCBmmfh9pLZfuTCp60+c5PO7izKZ1Yl58yrSMDHneI7Dd0PsauuCB0Zr3wgy10FjtMKQnqgunNUiIH/wXzyRdJtnqPiuLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YEHchtgE; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YEHchtgE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSGyu5xw34ORXScqKRj+vggMoZPsWYAEbcDejdIfACtyEM8wbYPC60gv441V2dQaRQJ8JFXbwWp3oHe2BsJfUtTia2hLBGBjPkTJRcXwOCem5pEJ1J9n6oyME7rT5g4hOV7u67ldgAZ1u+H0q+0CFrJ2wkHfU+OYTPaD8j9O/7xei88TRJsArl6t3qkrpBJpmMLangPgM+T/XurJNwY0F1Zpt0OpLn6WptBoA17gMAG7liorOBkWJ6Mx6nf3wJEPu2ktYWSJ3a6/tCkZy1DGUOHWjqHegE8uax3iZl/QXfcVJe++P1azO3R9/l55Xqk8szmzENOz+wF72V5HiHC31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN0dqsyNmtHI5kyxX4l0+zGEbOxWGn+8xWTW3CylmYs=;
 b=iR5PDc/2aeah426b9GXt+C3DrzBA2+QHgBgDyb/6gz+nal0acDKq0qOq+QSYrVLRRLBJzDV2kA8Ty8UFNDCYF3adAMsBRVSB10zysZABlYAsEoXUkGTGdis2DWP47LNee5NJ0l3+v1GTiMJaMXhTsfNRA1aD827e3dHnd7QrISwTBZlStlZJh+1IO5naSwnS4ZYZOlZj/qtzw9egJD4Y9AuvFcx4f/LnAXihgU7/AysbimeGKrhu/RKry0P2Hv8N7MvbsILanMWSXttFJXzdc3Sex6/8GplGKrV7gUT5Bk80tY+UJr1HVzpQFCmfIyrPaFFjopUTOTe4OBnbXvH1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN0dqsyNmtHI5kyxX4l0+zGEbOxWGn+8xWTW3CylmYs=;
 b=YEHchtgEM6EW1Nd7uMDUaichhYukSWxhHk5+Y9rRRWOzS+8lq7zZFlbbNsK4g3ZZRCNUAe+RX6R3bgk/6oZJdL+Cd1JnXvoanxfYThZnTy4tfzUpCTb4ew1rsBrBk29uv+IZ8Z+dcU8s5oXf9aZB0IzjEOHqlfcE0zJ9VaJ7x8OWogONX6ADnqxk5Y4A57ZJbFs0YMfCPx8BWuCXiad4/ZUG282olTvZuXMFSAz5xJtX8yd2RT35w09Oh9y8S+SDMbufyWGtI/aISWsoLKAeNlbxoPsxXQxZ3ygbCisUA3VHoQFOW1sbhmtrkFle9oyNBa7NjlRfT51k1P64ROHkOg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 10:05:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 10:05:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: nvme-pci timeout issue
Thread-Topic: nvme-pci timeout issue
Thread-Index: AQHaREHaRBoa88hWsUeOod3A/KGxjbDoC/EAgADBtICAAAN0gA==
Date: Wed, 24 Jan 2024 10:05:08 +0000
Message-ID: <a35cd32c-7e9e-4ed7-b7f9-47d4b2960bb5@nvidia.com>
References: <287b9ed9-6eb3-46d0-a6f0-a9d283245b90@nvidia.com>
 <094bf7ce-b5da-4325-93ab-fef6b76671a6@nvidia.com>
 <20240124095245.GA31389@lst.de>
In-Reply-To: <20240124095245.GA31389@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4314:EE_
x-ms-office365-filtering-correlation-id: 22724c4c-7ab5-4962-2ba8-08dc1cc3f1eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8IGpiuVMDRx5acDo241kpeXgZAjN945j+ICDE9cwDjg6RObtC4CBeiSiND2gj2/nYPm8cybMGPdYQxPtpA3Ae97T6sux+WIsTJzpggcDfxGfnq/xWtrnjnOkacpbgLSp1nQyGi4LNuCIPFrEua0I4TDygjWoReYfxQwZgO1WZ77R4Ek1BkDO9OfqaQCuVcGM5HTjNsg89TX34u3ogThQcRMb28EweksPttz6pU4tWmzupRTGJS9BAdB1oAgt9Wo9I8bUib9qFVOwJkL9AyGKHF5xRad/Zz5P0nnPmwhhmehpbLoN0H4f55uStphrjl/D9cVEnEqXk7CztO79GkshP5nm4AJCBKjQPwT7Q+qNd31w+tBebdcKAz2mH3J/6FFUepGs/qFPtk5hKNRqkYEUH99ELOy1HRN0JTMCmjvw+ZuEDo0azT0J0KyZmlb/O8Du0qogNXkkitXnD3MLawMhy0NNUqCBcAA2FKtZK8IaMwAEQopBJ5P4cR4tmgroCo4OEGhig1INji82tDDRN3FMhs4BhtLKSYIvvmneNY9rkZpS3KR1QFSobYDsHNB84ANVtZdNKMiPhzvvgTBv1VWJ+SOmwSJAgtE1TQc3QWzSmmPB0JbLo7MCq+T/VNfFUB5CDPqh6kCro3A8f0tLwkf00IowEDPaJkqCI8QvzaqD/giGKO/b2wXM6NCyNQuqsjM85I89uXUyfmCJDgVfn5zUgQClSmHrjc2V0RcYc0z+UnI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(6512007)(6506007)(26005)(2616005)(53546011)(71200400001)(38100700002)(36756003)(31696002)(86362001)(38070700009)(8936002)(8676002)(41300700001)(4326008)(966005)(6486002)(2906002)(3480700007)(122000001)(83380400001)(5660300002)(316002)(478600001)(66556008)(66446008)(91956017)(76116006)(6916009)(66476007)(64756008)(54906003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2dSVUVmNm1lSjJjRTQzZjVlSXdEem5qc3BjSVhMVnY2V2FQK0FweVNIdVhQ?=
 =?utf-8?B?ZGZMVUcwdndKUDJDbjF1TU1wRkJQd01YQ2NmcTZZMFQwOWNabnJlb0RvTEhh?=
 =?utf-8?B?SXYxenJ0K0VWRDFNejhYYW9uckZHdmlTdkZIajVLRW85Z1A4UDkwS2RtZ0JL?=
 =?utf-8?B?YUVkd3JPNUhWZytJZTJ1NWQ2RVFvZDdYTUQ1Q0JGajM5MG81WFF4NFk4SUNU?=
 =?utf-8?B?ejhuS2l6K2xHR3BnMUhBQ0NUZCtreGprQlVpSmEwRTVFanNub2xnU0RFRW50?=
 =?utf-8?B?YnhiU0hWRHZvdlBKWnJPeDh5bkYxbXlHSkZZVHg3YTAwKzJqbDZHdCtvUFNM?=
 =?utf-8?B?MVNaS3BlQUVHRHB2emdOeExSWVA4b3ZZRUdOY3I2RCtUb0lXQzc3WnVFenZn?=
 =?utf-8?B?UDBwdmt6UFlZdFVZZWloQ1dJc1Y0T0htYTJWMDVLdVNzY256RE1Fcks0eHZt?=
 =?utf-8?B?RnZnSEQ4QUM1RlFCT1c5clh1QXBpZEo4R0ZQdHVIY21HL1ZCMGxPeHZWc2Jk?=
 =?utf-8?B?djhkZzlaSlYwNmVmMnViV2o4ampCSzNPZjQ5ck41SE1VcUJjbi95L0Z3d2ZU?=
 =?utf-8?B?UFRXeHFHTEF2NENSRVlsQ0VJak5JT1ROcDVHK0xaQ3U0em9COElVc2M2eUww?=
 =?utf-8?B?N3kwY0ZSZUZaenhLRjFHSEpmQ1hoTzBET1RSdUNBVnN1K3BmTGdyeXhCR2FX?=
 =?utf-8?B?Yy9sWVRJT2c0SzlXSVdVWW5hM0pNTFA5ZEN1NTFvVk1HaVdmYVljUEVRUEZ3?=
 =?utf-8?B?cDB1M0haY2xNNXpjS3BQT0Z5Qzh6ZmIxa2gyQk5yeFJDdk9YeUR2VFZ4Yk5K?=
 =?utf-8?B?WXBoU0dhdnExQVh0REo5NDlPVkp6cHBpOWVDeDFYVFJtdmlRTmljbnNDMGRS?=
 =?utf-8?B?SnFCVnhJcmtjQmFzZS9yQkR5K2Q4bGJodkg3VWxzcDh0WmoxN1o4S3VzUXFG?=
 =?utf-8?B?TTdmRnRacjdsVmhYWmRLSEtEdFZOUjBmd1Btb0Z5MHIrQ1BMeUlHaCtCWTJP?=
 =?utf-8?B?RlkyR2NSUmZDdmp3UjRwWjZoZ2dxS1BaYU9FUHZDMm5oRXVvTzhheVZGdTQ3?=
 =?utf-8?B?NGtvckE2M2FRbDRyVkk4R0hyWFQxdG9ESThjaWZpMVZ5blNQa0kxWk1WakhE?=
 =?utf-8?B?RlY0bEhnWWxkMUFPMU0wY3JWWEs0VW50UEZPNUpLYnNvMGs5TnhLbHhnTWhw?=
 =?utf-8?B?WWNqZEM1dUZwYU05Z2I5ZUl6cXovaERERnhTdzJqY3F2a0ZIQWZ2Nk5uekdm?=
 =?utf-8?B?M1VvNjZDRm42b1Vza2oyeG5udlZVMjlaVTA0TGtxd3MyTzNtNDg2dUhaN3pO?=
 =?utf-8?B?Vnk5bm1WRHpOdE5iNHRHMFpCaXRlSnNqZjZLWk9Fc05iVXJvZUxGWEpBTkFw?=
 =?utf-8?B?aHBMajFWN1Q3M0JHNW9yR2tJR0wxWDZxSzcydzZrd1pLUXd0Y1BnSk9RYjNL?=
 =?utf-8?B?RFZvNS9EM2FPVEtDQnV1NzZmOUFKTWZwY0l6NUF3eWVoNnhLakd0dnFCbWtT?=
 =?utf-8?B?dzJCYkh2aVpvZmloN1paSTJhZ2tKR3UyTWtlTHdkRzYxK2RWam5WNmhIQXVu?=
 =?utf-8?B?Nlo2TUt0RjlUK1VxNjBRWmlhL0d5dXB0MEp6T2JEQ00vdlcwRVh3dkdkYU92?=
 =?utf-8?B?V0FlNjVoTnBQbi9uVG9DTXBaWTNvdW9uWGFWS3k4UWRGQnN4eUo0V1ZPSWVW?=
 =?utf-8?B?ZDBFYWNYRzA0NVN1cng2Z0hudVUxaDFpd3loVHg1dmhNNUVnSkhSYnFVcldq?=
 =?utf-8?B?cHdXdjhwakVQaVVNUDJNWUhaSHF3a3QrQjZ5ellLRzVZWlNXVTlObjA5RlU0?=
 =?utf-8?B?T0ljUk5hQXpUZlFFRmRuaUwyWU9ZdWJ1OUtqb2FRTWtacm9lVkhpalI0QSs5?=
 =?utf-8?B?L1IrK0huU24zc1EyQ1JpZGlTNW4vWHBlSDBSSTFCcEd3MnYwTW82ZFpCRStG?=
 =?utf-8?B?UjYwRXNhVVJwb3JpREhWUmtwK0ZobUhFTzhRMUIxb0ZwWk50NHRuS3RnOHQz?=
 =?utf-8?B?RDBRU0dDVmZRdDU5aTl4NHM4ZUZ4Uk9hb1hqQWUyWHA3RFUyd3JtRjFRMnEy?=
 =?utf-8?B?TEN0M3FBVHRFSDJoTzRYRFNKUCtnK1JXcWVyMGxSYS81bnJIditOSEVNdncw?=
 =?utf-8?Q?RQ+iNuzHchU3xQY7Z6TtfyKmB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A4E061560B3E643A26FE935FD8514B1@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22724c4c-7ab5-4962-2ba8-08dc1cc3f1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 10:05:08.2082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ktw39vLSSWz1Z0Gx5V1XCE/FIB8a22QmSuuEF7cqxWQWgGhkZ6yW0dVGi8NhkVBuExjN4ZvxYvo3Hitgqd7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314

T24gMS8yNC8yMDI0IDE6NTIgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUs
IEphbiAyMywgMjAyNCBhdCAxMDoxOToyOFBNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+PiBDYW4gc29tZW9uZSBwbGVhc2UgcHJvdmlkZSBhbiBpbnNpZ2h0IG9uIHRoaXMgYmVo
YXZpb3Igc28gd2UgY2FuIG1lcmdlDQo+PiB0ZXN0Y2FzZSBpbnRvIGJsa3Rlc3RzPyBQbGVhc2Ug
bm90ZSB0aGF0IFNoaW5pY2hpcm8gYWxzbyBvYnNlcnZlZCB0aGUNCj4+IHNhbWUgYmVoYXZpb3Iu
DQo+IA0KPiBDYW4geW91IHByb3ZpZGUgdGhlIHRlc3QgY2FzZT8NCj4gDQoNCg0KSGVyZSBpcyBs
YXRlc3QgdmVyc2lvbiBvZiBibGt0ZXN0cyBwYXRjaCBmb3IgdGhlIHRlc3RjYXNlIDotDQoNCiBG
cm9tIGQzYWI1YmIzZDIyZmNjMzU5M2U0ZGE3NTk5NTIzZTAxMzIzOTcyMGUgTW9uIFNlcCAxNyAw
MDowMDowMCAyMDAxDQpGcm9tOiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
RGF0ZTogVHVlLCAyMyBKYW4gMjAyNCAxNDozMDoyOCAtMDgwMA0KU3ViamVjdDogW1BBVENIIGJs
a3Rlc3RzIFYzXSBudm1lOiBhZGQgbnZtZSBwY2kgdGltZW91dCB0ZXN0Y2FzZQ0KDQpUcmlnZ2Vy
IGFuZCB0ZXN0IG52bWUtcGNpIHRpbWVvdXQgd2l0aCBjb25jdXJyZW50IGZpbyBqb2JzLg0KDQpT
aWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KLS0tDQpW
MzotDQoNCjEuIEFkZCBDQU5fQkVfWk9ORUQuDQoyLiBBZGQgRkFVTFRfSU5KRUNUSU9OX0RFQlVH
X0ZTIGNoZWNrIGluIHJlcXVpcmVzLg0KMy4gUmVtb3ZlIF9yZXF1aXJlX252bWVfdHJ0eXBlIHBj
aSBpbiByZXF1aXJlcygpLg0KNC4gUmVtb3ZlIGRldmljZV9yZXF1aXJlcygpLg0KNS4gU3RvcmUg
ZmlvIG91dHB1dCBpbiBGVUxMLg0KNi4gUmV2bW9lIHNoZWxsY2hlY2sgYW5kIHVzZSBncmVwIEkv
TyBlcnJvciB2YWx1ZSB0byBwYXNzL2ZhaWwgdGVzdGNhc2UuDQoNCi0tLQ0KICB0ZXN0cy9udm1l
LzA1MCAgICAgfCA2OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQogIHRlc3RzL252bWUvMDUwLm91dCB8ICAyICsrDQogIDIgZmlsZXMgY2hhbmdlZCwgNzEg
aW5zZXJ0aW9ucygrKQ0KICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvbnZtZS8wNTANCiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL252bWUvMDUwLm91dA0KDQpkaWZmIC0tZ2l0IGEvdGVzdHMv
bnZtZS8wNTAgYi90ZXN0cy9udm1lLzA1MA0KbmV3IGZpbGUgbW9kZSAxMDA3NTUNCmluZGV4IDAw
MDAwMDAuLmNhY2FiYTYNCi0tLSAvZGV2L251bGwNCisrKyBiL3Rlc3RzL252bWUvMDUwDQpAQCAt
MCwwICsxLDY5IEBADQorIyEvYmluL2Jhc2gNCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMy4wKw0KKyMgQ29weXJpZ2h0IChDKSAyMDI0IENoYWl0YW55YSBLdWxrYXJuaQ0KKyMNCisj
IFRlc3QgTlZNZS1QQ0kgdGltZW91dCB3aXRoIEZJTyBqb2JzIGJ5IHRyaWdnZXJpbmcgdGhlIG52
bWVfdGltZW91dCANCmZ1bmN0aW9uLg0KKyMNCisNCisuIHRlc3RzL252bWUvcmMNCisNCitERVND
UklQVElPTj0idGVzdCBudm1lLXBjaSB0aW1lb3V0IHdpdGggZmlvIGpvYnMiDQorQ0FOX0JFX1pP
TkVEPTENCisNCitzeXNmc19wYXRoPSIvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2lvX3RpbWVvdXQv
Ig0KKyNyZXN0cmljdCB0ZXN0IHRvIG52bWUtcGNpIG9ubHkNCitudm1lX3RydHlwZT1wY2kNCisN
CisjIGZhdWx0IGluamVjdGlvbiBjb25maWcgYXJyYXkNCitkZWNsYXJlIC1BIGZpX2FycmF5DQor
DQorcmVxdWlyZXMoKSB7DQorCV9oYXZlX2Zpbw0KKwlfbnZtZV9yZXF1aXJlcw0KKwlfaGF2ZV9r
ZXJuZWxfb3B0aW9uIEZBSUxfSU9fVElNRU9VVA0KKwlfaGF2ZV9rZXJuZWxfb3B0aW9uIEZBVUxU
X0lOSkVDVElPTl9ERUJVR19GUw0KK30NCisNCitzYXZlX2ZpX3NldHRpbmdzKCkgew0KKwlmb3Ig
ZmlfYXR0ciBpbiBwcm9iYWJpbGl0eSBpbnRlcnZhbCB0aW1lcyBzcGFjZSB2ZXJib3NlDQorCWRv
DQorCQlmaV9hcnJheVsiJHtmaV9hdHRyfSJdPSQoY2F0ICIke3N5c2ZzX3BhdGh9LyR7ZmlfYXR0
cn0iKQ0KKwlkb25lDQorfQ0KKw0KK3Jlc3RvcmVfZmlfc2V0dGluZ3MoKSB7DQorCWZvciBmaV9h
dHRyIGluIHByb2JhYmlsaXR5IGludGVydmFsIHRpbWVzIHNwYWNlIHZlcmJvc2UNCisJZG8NCisJ
CWVjaG8gIiR7ZmlfYXJyYXlbIiR7ZmlfYXR0cn0iXX0iID4gIiR7c3lzZnNfcGF0aH0vJHtmaV9h
dHRyfSINCisJZG9uZQ0KK30NCisNCit0ZXN0X2RldmljZSgpIHsNCisJbG9jYWwgbnZtZV9ucw0K
Kwlsb2NhbCBpb19maW1lb3V0X2ZhaWwNCisNCisJZWNobyAiUnVubmluZyAke1RFU1RfTkFNRX0i
DQorDQorCW52bWVfbnM9IiQoYmFzZW5hbWUgIiR7VEVTVF9ERVZ9IikiDQorCWlvX2ZpbWVvdXRf
ZmFpbD0iJChjYXQgL3N5cy9ibG9jay8iJHtudm1lX25zfSIvaW8tdGltZW91dC1mYWlsKSINCisJ
c2F2ZV9maV9zZXR0aW5ncw0KKwllY2hvIDEgPiAvc3lzL2Jsb2NrLyIke252bWVfbnN9Ii9pby10
aW1lb3V0LWZhaWwNCisNCisJZWNobyAxMDAgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2lvX3Rp
bWVvdXQvcHJvYmFiaWxpdHkNCisJZWNobyAgIDEgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2lv
X3RpbWVvdXQvaW50ZXJ2YWwNCisJZWNobyAgLTEgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2lv
X3RpbWVvdXQvdGltZXMNCisJZWNobyAgIDAgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2lvX3Rp
bWVvdXQvc3BhY2UNCisJZWNobyAgIDEgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2lvX3RpbWVv
dXQvdmVyYm9zZQ0KKw0KKwlmaW8gLS1icz00ayAtLXJ3PXJhbmRyZWFkIC0tbm9yYW5kb21tYXAg
LS1udW1qb2JzPSIkKG5wcm9jKSIgXA0KKwkgICAgLS1uYW1lPXJlYWRzIC0tZGlyZWN0PTEgLS1m
aWxlbmFtZT0iJHtURVNUX0RFVn0iIC0tZ3JvdXBfcmVwb3J0aW5nIFwNCisJICAgIC0tdGltZV9i
YXNlZCAtLXJ1bnRpbWU9MW0gPiYgIiRGVUxMIg0KKw0KKwlpZiBncmVwIC1xICJJbnB1dC9vdXRw
dXQgZXJyb3IiICIkRlVMTCI7IHRoZW4NCisJCWVjaG8gIlRlc3QgY29tcGxldGUiDQorCWVsc2UN
CisJCWVjaG8gIlRlc3QgZmFpbGVkIg0KKwlmaQ0KKwlyZXN0b3JlX2ZpX3NldHRpbmdzDQorCWVj
aG8gIiR7aW9fZmltZW91dF9mYWlsfSIgPiAvc3lzL2Jsb2NrLyIke252bWVfbnN9Ii9pby10aW1l
b3V0LWZhaWwNCit9DQpkaWZmIC0tZ2l0IGEvdGVzdHMvbnZtZS8wNTAub3V0IGIvdGVzdHMvbnZt
ZS8wNTAub3V0DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uYjc4YjA1Zg0K
LS0tIC9kZXYvbnVsbA0KKysrIGIvdGVzdHMvbnZtZS8wNTAub3V0DQpAQCAtMCwwICsxLDIgQEAN
CitSdW5uaW5nIG52bWUvMDUwDQorVGVzdCBjb21wbGV0ZQ0KLS0gDQoyLjQwLjANCg0KDQoNCkl0
IGlzIGFsc28gcG9zdGVkIGhlcmUgb24gbGludXgtbnZtZSBqdXN0IGluIGNhc2UgOi0NCg0KaHR0
cHM6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1udm1lLzIwMjQtSmFudWFy
eS8wNDQ1NjIuaHRtbA0KDQotY2sNCg0K
