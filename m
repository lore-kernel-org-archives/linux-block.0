Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CA3E492
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EVGsN9wp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNIjfZkdxPwRKkLx18eeXldUQJHT0RoKY/bY2SJTYqWpNxLcJgfob9PCUe0Wu8oCTDE6O/jm/3AsG127HgJp1ssLTgXZ7l/LAR1Ee0vqvwR1Xb1Tp/5UM9JQZ5cGueZa5OSPbEVpCPdkrliK3TrA0QNPW0aLg9/zIsuP6tT/upLU8jf9TN1zKjITmUds2XOtyS4AOmguH1QSDizev2YpbDNWoMFgI6tyToslxB7EK4Q2Xt4ke1AOE2Dua91SwycAa+oMIYimvWa/+BxTtuUeZ1HhS/I1WMiA4Pwc+zrSqgnzBiJQZR2rkBPIMnKfC50e769vg8nVCWLwbFEkvg5Y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzWpkfpuaGV/Dn7fbQ2Bs8dimmPcjNgQBNSnFVOTa80=;
 b=lVemiYgGVlNG9BjiCmQXqvt6vrnS98vsjUSKH/mJaJkYBhwLFgr36FN9ndSb947Uj/JWUOJzUXPoGah/LdmWaMMULvNg16j6PybsVDeLk0dFmlmfVWEQpAT2YDqlxpm7eYFttepGRbkhNGDXCvNb2Vb/zyIA9fINJgO8lWqYPCp9BsKA132/uZG8GHkhvsXeLceom1o1/0MPnCyC/Edg58DL/zizeYjjOc5A0R2NXmYY5TdbS4TGeM1ivarWgiZ0ysT9nIbyEuGMkcanWKtmgzNy5ZVM8Sj5TCg0lRZZ74v84NPgXSXFjReBqkJu4SlH8FjSZmUTygZMU1mVjZVyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzWpkfpuaGV/Dn7fbQ2Bs8dimmPcjNgQBNSnFVOTa80=;
 b=EVGsN9wpekdFNJhy8BKvPKUwYpinp1QJXv8JwtvgRWN4uPXnA9koNP/LGcNG3yTIUon4KkPuHi5YQR4b6Oxoq47soj1i4cZu9ea07vSaXCrLXfG6M6jV+Ub8plp2pm6+lPrdiraIWevijHyHxAigQmVoq1TcrDDpVVZ43IYzfJKd6BNpzrvyK187eZ/+86aGQepE6LczFQ1t3G/ZjvHYMvBBMcZpvoeDXqcQ1NlbTAuhg8wU2P1g0z8jqA+Y3TUPMCy44e9Gk0xGTSKNeeKX2LGx0r/jQkSgDuKQId4t7iqqNdlSRD/J4Cy5OYfG4iBkb+Cg5hLtZMPcT7IPcgMJRQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 08:12:05 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 08:12:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH] nvme: add nvme pci timeout testcase
Thread-Index: AQHaQ3lDV0aWrUFAIUCtA7cIZYYqELDSkmGAgAAXHoCAAAQIgIAABOuA
Date: Wed, 10 Jan 2024 08:12:05 +0000
Message-ID: <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
References: <20240110035756.9537-1-kch@nvidia.com>
 <CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>
 <20240110061719.kpumbmhoipwfolcd@green245>
 <b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>
 <20240110075429.4hqt2znulpnoq35h@green245>
In-Reply-To: <20240110075429.4hqt2znulpnoq35h@green245>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB5017:EE_
x-ms-office365-filtering-correlation-id: 8e01eafc-1b31-4675-b895-08dc11b3d551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G8hiIiNEPiBVxFlXWCfa9W2bJGX3cs7vh1vMOB8RCiHZwZxz/hHHFjAIfLEuEv6hrtOoVryxhaXn5wSr+1Z8g6jKmU4xSWZhV+ilSdflIXuMET8UQKtbMFYnVMaGS1MRgysmM6mPUphGinUmVrSYymWZ0J/vzDUve9t9gi//O13C/UAtCNeKa336JbtoiGbdAIB3NO34MeaBzmxY5gAux4yRSDdHzEWq2CHb/FPoNvoLNk9evXohQ7Ze6t+htXTUQ3/0+wPF09bNA4X8L545HxTyaEHTCCiGDJvIWfKLFAUvIW9lYFfyyknhh72/zcxu7d7ehq2SgihEuQGxLiAtf6eoD32qScbIOHhsbSPkuBr7FMPe1WApRAlAnq1r1/s5PAIqOq92cSgfwxrJn2HiMUPO+VBRh93LRrx+59gz0pzqK080qYVwj0N16CLGelCL03uL7FeFDJ29HhoHyW77z3Lp2snmb8VFE900IqPdPLV4hH8uSldHmRBPfqfFZpD3mPwhfxjnLcOOiDjwbn1tHZ1TpiU/7AIpoGEb1+K1CRKBnappKtapvwVebrooz3HP72tJ6XRjyg0qcTj2qyfQuPtHYBnhJ5n2icKduczyUBJi+qDf8LmDemVGKkrUT/WUcGKDH8flpNz5uBtccJTE2AuMOcsDMg1uAvlfe9hPGQpL0H1cXeO0o/lYLm2ntyDa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(478600001)(122000001)(38100700002)(6916009)(64756008)(316002)(54906003)(66476007)(66446008)(6486002)(31686004)(31696002)(86362001)(2616005)(71200400001)(6506007)(83380400001)(66556008)(66946007)(91956017)(76116006)(6512007)(8936002)(8676002)(36756003)(5660300002)(4744005)(38070700009)(4326008)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHdSamZMR08xRE1jdURnem9ONWJ2NXhJSGk2Vkw0V1E1ZG1vemVwS2xXdzVQ?=
 =?utf-8?B?UUNjU1RGVUNDWkQ1ZHFPdmlwVzJCQVJOUU4zeXN1NWFXNC9DMXVFaEt5Q0lV?=
 =?utf-8?B?blRBNEFObmphbDJ4Tzlkcm1lRElwMWcxN2FVdjNqM2t0KzhkanJwa3ZqcHRq?=
 =?utf-8?B?dkM0cVZXanJ4dUE4RVU5b08zL0d0U2JqdUMyVkhqbG82Z2JUL212bnk0eEJL?=
 =?utf-8?B?WDVYYjJkdGxyUURnZ3RBVFBWM0s2dEZ1UWFrbzkwNUdJMlhJWWlXOEp2dlB4?=
 =?utf-8?B?cTlqM0k5TjVTWk1maXhySTVRNEZ3WkNGV1ZGRURycjVrcFZGVjYzck93aGlx?=
 =?utf-8?B?bjgrL3FlSGlwVVQxZzhhOTlSeTF2MmQ3VE1lZEJLMVl4SkFjT2xKMm9YZHY4?=
 =?utf-8?B?akR1QnhUTkFjZlA4ZTZvNEFudFUvWmpyTDRPb3A1eEdFSzk5RDZRSmM1eCtH?=
 =?utf-8?B?c3hpeVB1bFhWSnN2QmluVmRKcUpIYzVvSk94RERNUnN0R0FVTG5NUTNpNUJQ?=
 =?utf-8?B?ejJZdHJRd0sxazQ2SHNQMFlwUVN5Wnh5OHJTSlovcXlqZHk4WjRqS24yYm5h?=
 =?utf-8?B?bUJpT0s3dlRadHh1SlByRmw2eHl5WGtzNWljRjdzeGhQNlZlcjNZOXBraHNB?=
 =?utf-8?B?QlI4VjR3WWZ0NWV2Qm00cVRuTTdKaGIrNWZRc256eUxVZjdWeUh0TXBDWGh2?=
 =?utf-8?B?VTd1VDgwNlFLYkJ3R2NoeXUwc2E3WFlhMlpjcXMrMFY3ZSttbUlRVEMzYXRB?=
 =?utf-8?B?Q1dtR2E2NVhPSWplendWeHdWNGt2MXZVbVE3ZlN3SVVML05URHBsSmNhL0Na?=
 =?utf-8?B?eTF3WkpwV1p4YkpQVk1zUk9mZWJRbTZtaHIzVUZTRGNkUjIxWEhaKy90RWxm?=
 =?utf-8?B?RkhuQ3lHdThKZk5CZ293V3dLSzA0ZVJONU1NYVhaVHFwNmJ3MDNLY3VaNDVn?=
 =?utf-8?B?WFpVNnFSYWp1enZpV05rbDNrZFltbzhMUW93Z1U4YUJkK01rK2JFdkorcWEz?=
 =?utf-8?B?a3EwZ2lVZTluU29IRFNpakVOdjdleHp4ajRzQmV1Y3ozS05YU3pTREJkUWRB?=
 =?utf-8?B?eFZrblZaM1A3anVWUW0wQWo4dldnREx1SzdmUVl0Qi9OdmRRdnpNTWlxRS9n?=
 =?utf-8?B?MVZhY3RpcjRwblIvYzE1OGFoSUxJcVZKOGxYcDZ3N2VHOU5za3hKanM3b3Y5?=
 =?utf-8?B?dmc2NDhPbTNscUpyQmk4UDh4ZExGaTEzbTJuV1dzVWtRTnJPcDJmbnI0dXFO?=
 =?utf-8?B?K1RvOUNTNTIrWEp0WnMvYWlkRlc5K0k1Y0JxaE10b1JzaFNoR2RJY1FNSEVX?=
 =?utf-8?B?NktFcEFmZUdsMXcwQUtoMlBUODJhblFOZlZWOUJXZUMrUzhaZWF6alJlRjJi?=
 =?utf-8?B?S3pPZWJaNU4xOU0xL1RDdW9FQWM0bkNEVnB2Y1FtczlKa0t1NVVvcFBsaXFZ?=
 =?utf-8?B?OWZneU4va0RsbU45OWhGcnhKVWJyWkxjSGVSaTI3WUpLcXEyM0MyMEQwMFZI?=
 =?utf-8?B?Z1Z0TzRhc2RtbGFuaE5mZnNxZjFaZkhTVkkxT2ZiTVV3bFB4UlpVcDVwYkc2?=
 =?utf-8?B?blBIekdlS2JTUmRBY0dIc0xWNmlyUmdTc0pFaXp6Y2lXYk5XVUovK09Qb0dO?=
 =?utf-8?B?NXl5V1l1S1o2SGRpVkhTcWFPeGpDVWRnZ1BUS2JXWC92QWhOZ25rYWd3NTZD?=
 =?utf-8?B?NEdqZzNjSU81bCtFdm8vcXY1YnI5TkZwakNVcFN1ODE0eWk5UStpU0lRM2kx?=
 =?utf-8?B?WExHZXBpbm81cXg2Y3BuWTRrUjRiazliVVBJMGZIZnNLa3p4cEZFbU52OXdC?=
 =?utf-8?B?WFVrcWtHUXZiM1BMb2s1d09OS2tBVDVUZ0I3dGtlSGtuWSt3L2M3NGFka1lW?=
 =?utf-8?B?U3h3WnBCV1MwMWROa3FUdmlYL2Myck9VbElhS1NUanlDazN0cE80WnQ3UHpW?=
 =?utf-8?B?amZSejZkeVRTRzJYNzVRaHdzZzVxTlZoN2w5ZFR5b2wzRE83bHVoK0dRemNK?=
 =?utf-8?B?WDZnM1I2NWNrVGl0RGs0Z2hCdm5vMFpaMysvUEZSMkVSN3ZBODJPQlBsQnJQ?=
 =?utf-8?B?aUFvK2xMMGdQM3NGY1RhMEFUUEtsVlE1bFJJWmlNenhuMEFwbUVhclRUK2Z1?=
 =?utf-8?B?OTd2YytWYk5ZTTlIVWxZVDBTblo4OWtMamFsOGtVNG01QmlRSGt0Y0tOS2FI?=
 =?utf-8?Q?xkSYkHOBa2LXZ+NB6LQTZzetqcaSj6TyYlv88dK5elsJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0829B184D8D48341A893B72E9AF8B034@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e01eafc-1b31-4675-b895-08dc11b3d551
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 08:12:05.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TJkYr/GlZ2vL4XU8GZUXi7vQxTsIXhGuaYBLp9/2QBsn2B6KKh8KSBJhLalLHUS+2m2Day2BaBUBfScUjY+wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017

DQo+Pj4NCj4+PiBTaG91bGQgdGhpcyBiZSBURVNUX0RFViBpbnN0ZWFkID8NCj4+DQo+PiB3aHkg
Pw0KPj4NCj4gTXkgdW5kZXJzdGFuZGluZyBvZiBibGt0ZXN0cyBpcywgYWRkIGRldmljZSB3aGlj
aCB3ZSB3YW50IHRvIHRlc3QgaW4NCj4gY29uZmlnIGZpbGVzIHVuZGVyIFRFU1RfREVWIChleGNl
cHQgbnVsbC1ibGsgYW5kIG52bWUtZmFicmljcyBsb29wYmFjaw0KPiBkZXZpY2VzLCB3aGljaCBh
cmUgdXN1YWxseSBwb3B1bGF0ZWQgaW5zaWRlIHRoZSB0ZXN0cykuDQo+IEluIHRoaXMgY2FzZSwg
aWYgc29tZW9uZSBkbyBub3Qgd2FudCB0byBkaXN0dXJiIG52bWUwbjEgZGV2aWNlLA0KPiB0aGlz
IHRlc3QgZG9lc24ndCBhbGxvdyBpdC4NCj4NCj4gUmVnYXJkcywNCj4gTml0ZXNoIFNoZXR0eQ0K
Pg0KDQppdCBpcyBjbGVhcmx5IHN0YXRlZCBpbiB0aGUgZG9jdW1lbnRhdGlvbiB0aGF0IGJsa3Rl
c3RzIGFyZSBkZXN0cnVjdGl2ZQ0KdG8gdGhlIGVudGlyZSBzeXN0ZW0gYW5kIGluY2x1ZGluZyBh
bnkgZGV2aWNlcyB5b3UgaGF2ZSwgaWYgeW91cg0Kc3lzdGVtIGhhcyBzZW5zaXRpdmUgZGF0YSB0
aGVuIF9kb24ndCBydW4gdGhlc2UgdGVzdHNfIHNpbXBsZSwgd2hlbg0KeW91IGFyZSBydW5uaW5n
IGJsa3Rlc3RzIHlvdSBhcmUgYm91bmQgdG8gZGlzdHVyYiBzeXN0ZW0geW91IGNhbid0DQpwcmV2
ZW50IHRoYXQgYnkgdXNpbmcgVEVTVF9ERVYuDQoNCi1jaw0KDQoNCg==
