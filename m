Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD580184D
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 05:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxatxHcU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfMkcZue/dGSP8y7ooRazFY8z01feObXN+HqWH1aXaxolyA/qEs3tL2/14LsrcTACsXhlMkcWBwwfBecajyjuFcS03LQ9KZ8UlnJgOWHPJ0rd4ivkJnssMV16fe9IPhrSuoMY2umPoJCriKlwYPC1shETonjdLQiBHN/lC/HW7oiJY53CaiFgCk0QlVX/mDvZCIUE54So4aFpDICa/mRmMkZEsrI2k2LnUxFkbgKn+ixHhMqU7dK3tBfl7ibGRrNVP5IUIf/UtNxNBPhLBAgtPg/f+1uEvTwDmGrA7e+trZ0m8ymMyucjhahxi4zbwhzNT2RuLXrb6WBDFdtF8R5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFg8a69yOgC2Lvcv2MZWwrvzItEBYPve4HDKU7rZniY=;
 b=FdJEIdDnE/cqzNkvpdwcDZSr9kUphiexVlFoZiH0h0iQBd3lC5aYI+v7LY0WwED/n1aiDAwGhnVEBgJS8pe6gV7GdV3eyoCJ9xa5S/j9EF2Kq/PgiEvJNu9/vm+KI6JAilp2dtdQ8vVI8ZwviHJyijmvjywVaxaDUPNvmkjEKxhNPsA7fmqU+eeTFgT8hqcxED5SrzNtIW/96nMH5Trf3pB1lFEgcHKr/SdFOLDs9W/+AA6tXYCHthfvfcG+csi9BAPnRLU55uc46uYvD08NpviIB87TwLFLr+sqQ9tSjLuCWWCEclj2y753DHZd2liRUX++M2cfElpRdMkrfBzt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFg8a69yOgC2Lvcv2MZWwrvzItEBYPve4HDKU7rZniY=;
 b=bxatxHcUr49mYCKWjekRLOTVQEXGlLgFiuCJlWoD3/ul4//tYeta8ffqkIB9L2/INF1IWsL93Yf2SUgSKBJCRJ3pcFy94KvbtAAKHhT+NmFUXMxi+aKEqXdmhbBx6RxUeDb9gRcl3uKU2wjyw8tvJE5SIZvIesU3NRds47zha2OgVH2FKCVVMEfD5+O61pbwNcxQ6dHw0HWx8K2N720k2XEhSb4/vdauOIAIaHPoxZ6z+0uysn6Vf3D9xbwYBfo/3XDqylEshAv7953jNpGKHpWVHQiLlp5ghsKCwYx+RJ2y1dW5RrPhf20KSPFWVX/2CjB+8vhyBiDLlCxz9nzhoQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 05:01:38 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 05:01:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH] nvme: add nvme pci timeout testcase
Thread-Index: AQHaQ3lDV0aWrUFAIUCtA7cIZYYqELDS+LeAgADCsACAAE6qgIAABX+A
Date: Thu, 11 Jan 2024 05:01:37 +0000
Message-ID: <c187efc5-7777-417c-a4c1-ccac48755359@nvidia.com>
References: <20240110035756.9537-1-kch@nvidia.com>
 <wa3xm2v53vsgcs3iv4f3fy477zza6uwxj64dwib6ib27kmkgxj@ovgndmtcpzch>
 <f730071b-1183-4266-8a12-0f044b8f9bc3@nvidia.com>
 <vl5nvm2ozht52g4whdscteizyayeuyhgfi5yzpzvuboo474zmi@3eaabtwu375h>
In-Reply-To: <vl5nvm2ozht52g4whdscteizyayeuyhgfi5yzpzvuboo474zmi@3eaabtwu375h>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB6662:EE_
x-ms-office365-filtering-correlation-id: de8e2e42-5e9e-41e8-016a-08dc12626447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +DoQ0WH59snCOuOR4LIph7GSp5Kc6r4Qy/duHVCRtuJdf6IoOVlUYTUGHiSRZmNsdHWgQUs180nVNsYxhQZrasEp0an4Rv/PxbyLSKTRmnBbLZiJpaajO1qOEJKFwq2BBhYMo6ZSp78SFqWLpqRhFL0t//GC1jb+XVX53PFU5lO/6H4mwwsxmFX15ArasgVU/3uuotLzrzD4B4jGvzx9z/bsuvSILU7vZKurm00tFDj5Gpjx+OKXm8BbHZ6a0pNet3HiGvcmD776xB5vhBbmOgB3F7GSF1T+ISnnFwySaxQO6lZVlEvNxaeuwOOQHP9s1Xm2ppqghozeXApoe7QMoX5BnfTntKDHv8qMuxTsnVCGQjIrlC/+atVBu6GF881+21ocP/Wr1aIsHv3fxDq2rD0yNATILxO0GhwBDlNUAJ81QdDUriC8Opi4VG0LMwX1OcSEktVeqqVy428Zt7Y9B/h+qTNhgq8VFbTgKTj7ONJxrFyen5RVrPw3O8qdSwRR8fqBi0QuTgN1UnQth+30KyyDqGL8G24nYOr3x1HUFkZe9biAoCRJYVziYfPyOpJ1CTI+lU0Op97wmBrAabsR9xrqT4vqeMEAgO9eTCfBmNoIyEq2SinhQThifgC0a7dhCsRCOAo1X1RAyAqkuh1c67eyEPUuMA8gfdrHJwCG5gCP5w/hGFhOtUZJ7KhRDO3N3vWISJy4sw11v97ILQILkeNFzmb2c5bD9Z4aa3a9AAHhaJq/oeEsJ80LHwlHQF9y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(6486002)(122000001)(66446008)(54906003)(38100700002)(91956017)(76116006)(64756008)(66946007)(66556008)(316002)(66476007)(6916009)(71200400001)(2616005)(6512007)(6506007)(478600001)(83380400001)(2906002)(31696002)(41300700001)(4744005)(86362001)(5660300002)(66899024)(36756003)(966005)(8676002)(38070700009)(4326008)(8936002)(533714008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWFjRmNvMFpTdWdPaTdQcDNSdGRHSDkraFp4WlB2Vm9BaU92ay90VWVaYVp1?=
 =?utf-8?B?KzA4d2MvZWtFQkxVU250MTZYdjgrNDdaRnN2cEhmaDBKR3lCQkFET0x6RVBr?=
 =?utf-8?B?cTZKWjdZa3JDYTJrVUViMGtFSFAxVnJaaUR6SjNwbTQwak9hblQ4M1hiOGZ4?=
 =?utf-8?B?NjBRcUUxczJnQXBUQ3lPV1hJTkxpQW9XSjZvc2FzVGM1azg2dTdycFp3bS9N?=
 =?utf-8?B?L1A5MS9JR1gvYkk2c2FTRzl6Y3pSZW50TnBNMEdseWJycXJmckdPTGV3QVlX?=
 =?utf-8?B?dWlwcEUrZlVhd2JYZXk1MmRMcytieVFhR2VFeDNBK3N6U2lXNW1BU2dCUmVB?=
 =?utf-8?B?cXBqYjExSytwcVJ1aGdCV2Y5bm5NL0dEdnFvdVFaNDRmdzBnOEp5VXFPTGI2?=
 =?utf-8?B?bHpVQ2RsL1crMENvYmlEbklDVGg4dmFZbmUrSDZTWko1S0xvSnNYRko0cHlp?=
 =?utf-8?B?RjNuaHc2NFQ0bUJTcEVsYllJa3lKQmZLUFdXOXlhK2V3czBDaUtITjMxeEdD?=
 =?utf-8?B?R2dOZjBTVml6OXNKSFpWQ2gzdzFLUWdEcEF2MkVkbTdORjZ2RUJ0Mi9ZV3lp?=
 =?utf-8?B?YWswd1NSbjFtSkJKREVFMEY0VFVyTWdFUnFyKzNJL3IrMHA1dGZ4clR3ZHho?=
 =?utf-8?B?OVh5ZjFVa3RCdW8wZ0RQZkdOdFZoUEw4N29mUFpZQUg2WkgrNGVhMGU2RVI4?=
 =?utf-8?B?dUNPbVhZSDRBMmhQS3JsQXQxRnlmVlJuRzhDVFJsQkpqZ21vSjdOS2RidVlz?=
 =?utf-8?B?TEhXeFEyVTF0Ukovd1FzVWZJV2YrZnBKMzdQQzJFMG95dHpFYmdtVlJIa0N0?=
 =?utf-8?B?ZE1SbDVuU0FPcTlyemY1ZURnZVZ1QVByS0piNlZWN08xaW9yVGlNTVhNQ2Ez?=
 =?utf-8?B?VUdzdTVWZlZQYkhiUkR2eGZ6MW5wY1F4QkZhdXZlMk5qSmlKTFBvU3dhcnJJ?=
 =?utf-8?B?YzJwQ0tlY3JkMjg1eGNvdXFEaWN3TzhFejNnbGE3Q3FRbmFUaWJYZ1lpYjVZ?=
 =?utf-8?B?NzlGM1hZajRsS3hxZ3pTTSsydElUc1RxT2dpY0lJTk90NUw5Uko0QklQMWc2?=
 =?utf-8?B?Mk55THh6aGIvTGg0d3hVVXV5Yk9ZZXlUcWdCa0RVbXRmUWxsSG1PVEZkL2Zk?=
 =?utf-8?B?S2dnMVp1VUJOMklKVy9TL09NSGtrcE0wWjA2QlRBMGNvaytGQ3I2NnNUbHFV?=
 =?utf-8?B?WUVQL29VNndqKzRKUWM0MlBhV1I0N2M1cWpZNVlDUDdUUk1Ldm1PNGx3MnRB?=
 =?utf-8?B?dU5URTRZYVAwR08wQzhtajg4Rzd5SUZpMFdpS29UeFZLVkFTTThrS0t5bzBl?=
 =?utf-8?B?bkpPYVFwc2h2cFhseEFzVEJzVVI2SkJzdStQWUhEQVloRnBqOWtSeTNyYUtH?=
 =?utf-8?B?RnZsR1ZEc2RvcUhIZStLMGdGaSthQTJXT0dsZGdjUVN0RXlKZmdCcmhDN1Jy?=
 =?utf-8?B?VlU4ZURHYWlpZ3hWYW1xRUhWUXhkVmJ0MGMvQktOY2hCeWg1TmdkRzdCa3Vw?=
 =?utf-8?B?YUtZQ2hwT3A2dzRwMjBNMm5aYWp1M21VRXhBZCtTaWZEcHNJK1FVNWhNNTF1?=
 =?utf-8?B?VXhkU3dQQnNDTWdKd2RwOHkrOUcvNHoyc1c3YnNoeEV4VzN0eVExclB6ZDRw?=
 =?utf-8?B?ZER3T1dIUW1oaUUxTFN1TkttN2NFa3VkVFZ5S0l6cElRUURJNVdLQVZpa2xM?=
 =?utf-8?B?RlFxa01uSHAwMFltVFJVNC9UaVJDd25GdEliZ0ZFak5EbzREZ2QzRHZzMUo1?=
 =?utf-8?B?dnBzbnRJYXVtMXVJT0ZDN0RsR2tkYkFYMmE1dno3RzB6Vy93czdDdEx3MkdX?=
 =?utf-8?B?U0lSOE0xWGNuTk1vN1YvOFF6Y2RXNlpNZWNoVGQwbjFxUytzbTQ3VnZnNlAw?=
 =?utf-8?B?aUJLOXg4ZVIyL2tGL0d2a3ZiTjRLMW5aMTZvWnE4QTZzWmxMb1RTT3dtL2RU?=
 =?utf-8?B?Rzd3VkozMWZyYVBmV1pwcFdDMU1mVmRoU3NTYVZ5Tm5zaHoxd0JyM2VJTXZQ?=
 =?utf-8?B?TUd5OUxPczY5bDlqRUdFMmdTWHpNbGtlajVyTHdTMDZMQ1ZKM0M5cWRKQ2Vn?=
 =?utf-8?B?Z2JhakJtU3lReURDL01aOU9YOHI2WkszUmVlSzdIRkJ2OUpJTGUvOGMxTHJR?=
 =?utf-8?B?TFJCM0NZM202bXdEeWltZkxZSTdEc040eUc1MUJDV2JzeU5zRmFvbXM3S1lh?=
 =?utf-8?Q?YRXjqyX8cPgcAATuuuY3gKzJwYh/eIrUr19TAqc/BNWH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <852466D91FAAD24DBE0D3206750580E2@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de8e2e42-5e9e-41e8-016a-08dc12626447
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 05:01:37.8055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kO3CjNeYeDrpAj902hT6cEWgu7mUaUrndeoBhIOBJ8nIIo5PlxdN2aW6lUXZerCC626kKSmq0ZY1jMvBUO0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662

PiBCVFcsIHdoZW4gSSByYW4gdGhlIHRlc3QgY2FzZSwgSSBvYnNlcnZlZCB0aGUgdGVzdCBjYXNl
IGZhaWxlZC4gSSB0b29rIGEgcXVpY2sNCj4gbG9vaywgYW5kIHNhdyB0aGUgbnZtZSBkcml2ZXIg
cmVwb3J0ZWQgSS9PIHRpbWVvdXQgaW4ga2VybmVsIG1lc3NhZ2VzLiBCdXQgZmlvDQo+IGRpZCBu
b3QgcmVwb3J0IHRoZSBleHBlY3RlZCBJL08gZXJyb3IuIE5vdCBzdXJlIHdoeS4gSSB3aWxsIGxv
b2sgY2xvc2VyIHdoZW4gSQ0KPiBjaGVjayB2MiBwYXRjaC4NCg0KT2hoIHJlYWxseSA/IEkndmUg
Y29uc2lzdGVudGx5IHNlZW4gSS9PIHRpbWVvdXQgZXJyb3IgaW4gdGhlIGtlcm5lbCBtZXNzYWdl
DQphbmQgd2l0aCBmaW8gb3V0cHV0IGdpdmluZyBJL08gZXJyb3IuDQoNClRoYW5rcyBhIGxvdCBm
b3IgbG9va2luZyBpbnRvIHRoaXMsIGFsbCB0aGUgc3VnZ2VzdGlvbnMgbG9vayBnb29kIHRvIG1l
LA0KbWVhbndoaWxlIEkndmUgcmFpc2VkIGEgcXVlc3Rpb24gdGhhdCBpZGVhbCBzY2VuYXJpbyBz
aG91bGQgYmUgaW4gb3JkZXIgdG8NCnBhc3MgdGhlIHRlc3RjYXNlIHNlZSBbMV0uDQoNCkFzIEkn
bSBnZXR0aW5nIGRldmljZSB3aXRoIDAgY2FwYWNpdHkgYXQgdGhlIGVuZCBvZiB0ZXN0Y2FzZSBh
bmQgdGhlcmUgYXJlDQpzdGlsbCBvcGVuIHF1ZXN0aW9ucy4gQXMgc29vbiBhcyBJIGdldCByZXBs
eSB3aWxsIG1vZGlmeSB0aGUgdGVzdGNhc2UgDQpwYXNzaW5nDQpzY2VuYXJpbyBhbmQgc2VuZCBW
Mi4NCg0KLWNrDQoNClsxXQ0KaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xp
bnV4LW52bWUvMjAyNC1KYW51YXJ5LzA0NDI2My5odG1sDQoNCg0K
