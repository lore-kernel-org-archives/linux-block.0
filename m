Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768A1E4B0
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UEl3FvfP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCqHkAGC9CPkguBlEJc0u34MCJOA8cMjYgonMdM1FmuzaifLIt1+73VUHa1NaULSVyjbdsF+ceqAUZnptRt5ZfBDny3hJ95LNQ/L7Ich8xI4fOFUy7OrtA7BL19J3QnBSsBN/Vd+K9f3zqLb4s84D8uqrM5CtFfFq4PGWEnU69Fl1nFiQ7Jfm1q7RLZmzYI6Qx8S6U/9aj5VLgJfsFA1viAPFKi9JOFebDkvBCoUbe5BUuJ/YfTRVSJJOIOodmOiSFwizlKm6MjolobkENshYQoCWDuT/hP/hOb99zX7nmTVOhDSgEIMz/hawvSHkEEVLbuUkt8ZQrnIevEOCe5Trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac1GkoUAaRamRjvVD0IPSkJbPfzKBLF+wC4Qmj1b7uk=;
 b=PlZbGjfnfdBOSjwi4w9U+f7svMymYvc0tDGErtb2HexqZPFvoj9+Pso3waXiJhwhyvLsSctNUJH03aRm6CxKsnBNQY96aW/mN5i9vnipXEGo1GczLYm4EQKjvQBDUt6eOCO+LRv4HdzKOpxP0JmJ1VN4KGe9TBNqNtAOvOtwNvT6npJFB4SOqU5+kTnjYIyj+qT4gtwb2QAHi64r/xneQ6pFU4+GOPk/vMWJ5vaH0+utCfFAvEePw1Beep4g97pDMRGYaSy7ySd7Rxz5PBHu2gAM6xHEws17N5Zpmvz08bzRChvFaCdtmAqcKH9+QBNFmj1+fRjsSznJQDr31FzYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac1GkoUAaRamRjvVD0IPSkJbPfzKBLF+wC4Qmj1b7uk=;
 b=UEl3FvfPmuLwvrqxxMloEwaJQEq2Mi7NsPOOQ4XRzh1pp4JdorvBu9oTK5+J+qX0+mwG0Cs2EiVtK9JvEtdxwmJOy2omv0oFB/G0Zv0YGykud7ro2Yb1W+tJP4vXhw26W6LWghTWoX6IWCyBNEy95ip4DxHv24JTMU0HnbLxNeflezjSQXb+zJ1NJlnBv9CJXieGCjhZ6PuZHxSQOi8lrxP7Tjau1uPvX3ERftTW4GHyWs8vyYfswNb93IczGRUA+yTE5QOPGc+XamxHAWEQwpLciy296mbLftQSx25Por8sm3NmiPkNRrY3ApsBZVSeSh9y1kM0KNZ7pGmSOrxu+w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 07:40:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 07:40:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH] nvme: add nvme pci timeout testcase
Thread-Index: AQHaQ3lDV0aWrUFAIUCtA7cIZYYqELDSkmGAgAAXHoA=
Date: Wed, 10 Jan 2024 07:40:04 +0000
Message-ID: <b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>
References: <20240110035756.9537-1-kch@nvidia.com>
 <CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>
 <20240110061719.kpumbmhoipwfolcd@green245>
In-Reply-To: <20240110061719.kpumbmhoipwfolcd@green245>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB6817:EE_
x-ms-office365-filtering-correlation-id: ffbfdffd-63d5-48d7-a2bc-08dc11af5c10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1zUqjv7Yvefd8uph0jJwsJjxy0If7XlL8q8unuetRiwMcRpJ7uE4pYcM2dOT2ni5xmOBPxi3SmbPRqBCihrsYCwnOC2AEdRsSdLfuhhuRY8D2iNjS/nJm2R4t0mu3xnWAstQl9R+5NgpIAAriGjfNj2XVxXHkV5gelFbEIDIYdSfrfLS5gRAUMxGdydkA8DGC9y/Ui8WSgJkT1S5Op1SkvVEjcbVHZgNy2wxf7KCzDYLQMIcMt+XsoQ5z19A4/kgu/TRaeg6jrAZpMIpwUCxJTXKvANCePQJ6naJsYBiJtImq6MHW6GIScgBq4ogAfzZusi6j+gBnmR7oskWSew7OcB95jpIf+igy08ZEE4D1+Z2xZE3KG1/4yy0kubdX0dotHJxKQfCSQsQGO6+DTvkaRQJM/0Tp1aqo3PESNjgLcMnPbA7deYgPZ9OFtoZqsDz1/fy338yzWFPueAIG3v4+mSXtane5IEYwiye3TnUYhPlpTKTD+Ar6q0Z1kR6GeH0HU3xbVpcurcbSFgaVZwYveLTXi2HzLrQWN6KAjE99aRRrg1w1ID7DHUzJ+sRp5rtFHBjInL7qNproqSHCxxtFZ6S0V45+M3vZys4cV2w2Y3OgIjfEy3UhckQV+bWQziwhEQKd2M75qoMZN952VrDv+UgpFjlRhsegxsXq9UCqWNuQjOQP+fI8dQh/te/wRlQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(478600001)(5660300002)(36756003)(4326008)(38070700009)(41300700001)(76116006)(66946007)(91956017)(8936002)(66556008)(66446008)(316002)(66476007)(64756008)(6916009)(54906003)(71200400001)(53546011)(6506007)(6486002)(8676002)(6512007)(31696002)(86362001)(2616005)(83380400001)(38100700002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVN5L1dQUTVUL0xHMmxSVHZIOVNvTUxUM0RMMkg3bXE3cEtnUHRrNjBwZHo2?=
 =?utf-8?B?WGNOOXNOVVJuSFNIVDFnWVZxTklaNXYzWXE1ellXOC85aXBiZVlXOWQ0VEdj?=
 =?utf-8?B?bWJpOG0xVGF6VGY5L2pSVmlTWjlhQ1I3dCt6NUl3UkZpZTJHVGRBbzU5Yysv?=
 =?utf-8?B?WGhMbk1PQVVsYkNrQzc4ZWw4dUNRSUp1L1JPaFh1ZUExWkZ0SmtxRGZ5NTNz?=
 =?utf-8?B?ei80NHArSEs2MVhIOE9odWhYVVdMejNrS3A5SGw1WXlWMnVvOTRUVTh4ZGts?=
 =?utf-8?B?MjlZSU5LZ3FzUlM3S09zd214U0tkWGdCUG8vdGJGbXR0K3kzbHJGOGpKeWFn?=
 =?utf-8?B?ZXB1S2UxRkViNXFTZ1hGYTZtTHVNREZLUDZCcXA4NUt5RElJVjZNTHlGdmRp?=
 =?utf-8?B?SlJvbEgzUkZhcU9VdVJYUStvRENtT1BGeDRZQUwzSHlIcXk1NGJPa01UekZQ?=
 =?utf-8?B?SnEvemlCSEFmWEEyUUc0NTcxa2xYRlBhMjh3TElVWVdCVFpzUGQzNlNITmJY?=
 =?utf-8?B?YVdWeDNTUUxiNmxFdFViQ2lCV2ZKTXJtQ2k1RHh6NFVGNFc4VkJkVnozdUhz?=
 =?utf-8?B?NTNLNnZ5UElJdW01bHA1OWg1WlpWc1RiMmlqaHVCTXM4Y2k1NUdaTEl6ZlVC?=
 =?utf-8?B?alUwQWYrNFN2ZzlXbk1zOThJZGNiMW9sRGY5M1AyTVB3NUdYT25aanF0b1ZS?=
 =?utf-8?B?cVdkMlJjQzM5WWdpRnorb25zU2cyOUlmMDMyQ0dRaUhmeEZZdmhKREhDbUFG?=
 =?utf-8?B?cENwSTZyai91K2hlYmtUWGtyczZQeHJtMVVyV1V2MHc5MkZNdWdTSFBFdGU5?=
 =?utf-8?B?MktCdXZobmJucXdYellKM2pFMmoycWtMUGZnUEQ0eUFnYjFZR0tPWE11MXFs?=
 =?utf-8?B?TEdvNUpDdWdzTGtzRXNNZndHV254WUhxNnhFT2NZZ2pnVGNGSnZzNWs3SGFR?=
 =?utf-8?B?SmFUUnlndlREdDllZ3dqbzJtc3JFR3dCcnNZKzk0aGFLNVdaRnlsVFlPUVVz?=
 =?utf-8?B?Nm1CNXdoVW83R0w3VTZiQ2xYNlNiWlRVK3BWYm85RS91VmJDME5FaTN2eVBj?=
 =?utf-8?B?TWE5aGphcSt3U3RkMlREbjJMKzZmT0p1SWJ3OER6RnBQRzJ1T1N4dzFZRVgw?=
 =?utf-8?B?QmJjS0lOZlB0U2NVUENqZjU0R2ZBemk4ZC94ejJrVlowUkZienZoMXhBYzhL?=
 =?utf-8?B?WmdpZkNpdGdxRm1kSzZkdU5iTGkvZlZkakY5MVRCZ2xFSEQ3bUJyNGxybnNS?=
 =?utf-8?B?QUs5NDlPR0xxQSs0OXo4eEJnZkQ4VHBKS3pLM3ZOd2MrbXlNK1ozSDNJNlFl?=
 =?utf-8?B?b2ZSV2xWTUI0TzFrWXJady9WQlFJMWFaK0VXRkN6dHUwMFE1a2tLWDhsbWRp?=
 =?utf-8?B?Zm9xTE5PRWhGZS9UYlVsdXZjcVJiOTMrSmQrR3pwRWxLbVV1Ylp6dUdQVC9h?=
 =?utf-8?B?R3FGZW1LSlhWNENTUThhVDZ0amVib0pBRVVFK1ZOcVJqbHRmdUo4ZG5Na3lu?=
 =?utf-8?B?eWpJTnZkZDZFOGJOQjkvVWJia2NIZGVac1pWUWxnQlNQQVZuaysrZmI2ekZn?=
 =?utf-8?B?ZnRlaDVQQ1pxVW05eVkyZlVHbGt6c2YxMTlRejVjcm5vVkpyYjVJYWFiaytI?=
 =?utf-8?B?UUZ2Z01SOHhtdjdWOFlyaUYweUwwRG9KemdRM1c4cnFNVDR4a1JxZFFhdTE4?=
 =?utf-8?B?REpscWVLZmd0dWhXWWcrR0N5d3dKSlNreG9hTlBDcllqL05Eejc1bWx3elgr?=
 =?utf-8?B?V0t2dmk5SktaZ1E3Nzd1S3FxVTI4THhjQkwvbHpjalNFTko1VSttNVRrbWlw?=
 =?utf-8?B?b2IwQkVUbFdRdFc1elg5UkdWMk9FWXZuOTl3aGljVGRZSzFZYkdFQVRXT1pD?=
 =?utf-8?B?OHVqOWpqUnFZSjdmMlowZE5iZE1LMlpOa0Vzay9PR0lKbkI3S1lKUXkzNUx2?=
 =?utf-8?B?RlpiakRiZVJxdHBaMXIyVEpGQnFCTkw1N1NJa0dndWEwV0lQTTVpb3RXSmNO?=
 =?utf-8?B?QS9KbEJjOEFEWGJaeHZzVkNEMzl1UlVJOXJsOXVOT0c4NGhlQ3pCT3M5cXdW?=
 =?utf-8?B?K1dmNXliRGxndFFubnl4Qlkvc1ZYSWNOUkhTUkJQbXIxWVhyWWs1TkFXOUpR?=
 =?utf-8?B?cUpVd0V0YWZuaGU5bnRXdGNRVzZGZ3h3Yy82dkhCV25HcFREV1F2NWlQbytS?=
 =?utf-8?Q?Y1TD0lLx9zHEoTTBMDCFZFa0k7pPJDPvny5ToSqOzg08?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9608A3708E0DC248BD38A5E116193D28@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbfdffd-63d5-48d7-a2bc-08dc11af5c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 07:40:04.0863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y786hhLXfNqhC90A0WO/xKROzFkwBotHV0tX5+xP/f7fmsRWA6JsMNgqMkJyw6rX/7wfBs2NxHp36hYbVx9qwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817

T24gMS85LzI0IDIyOjE3LCBOaXRlc2ggU2hldHR5IHdyb3RlOg0KPiBPbiAwOS8wMS8yNCAwNzo1
N1BNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBUcmlnZ2VyIGFuZCB0ZXN0IG52bWUt
cGNpIHRpbWVvdXQgd2l0aCBjb25jdXJyZW50IGZpbyBqb2JzLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+PiAtLS0NCj4+IHRlc3Rz
L252bWUvMDUwwqDCoMKgwqAgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+PiB0ZXN0cy9udm1lLzA1MC5vdXQgfMKgIDIgKysNCj4+IDIgZmlsZXMgY2hh
bmdlZCwgNDUgaW5zZXJ0aW9ucygrKQ0KPj4gY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL252bWUv
MDUwDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvbnZtZS8wNTAub3V0DQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL252bWUvMDUwIGIvdGVzdHMvbnZtZS8wNTANCj4+IG5ldyBmaWxlIG1v
ZGUgMTAwNzU1DQo+PiBpbmRleCAwMDAwMDAwLi5iYTU0YmNkDQo+PiAtLS0gL2Rldi9udWxsDQo+
PiArKysgYi90ZXN0cy9udm1lLzA1MA0KPj4gQEAgLTAsMCArMSw0MyBAQA0KPj4gKyMhL2Jpbi9i
YXNoDQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTMuMCsNCj4+ICsjIENvcHly
aWdodCAoQykgMjAyNCBDaGFpdGFueWEgS3Vsa2FybmkuDQo+PiArIw0KPj4gKyMgVGVzdCBOVk1l
LVBDSSB0aW1lb3V0IHdpdGggRklPIGpvYnMgYnkgdHJpZ2dlcmluZyB0aGUgbnZtZV90aW1lb3V0
IA0KPj4gZnVuY3Rpb24uDQo+PiArIw0KPj4gKw0KPj4gKy4gdGVzdHMvbnZtZS9yYw0KPj4gKw0K
Pj4gK0RFU0NSSVBUSU9OPSJ0ZXN0IG52bWUtcGNpIHRpbWVvdXQgd2l0aCBmaW8gam9icy4iDQo+
PiArDQo+PiArcmVxdWlyZXMoKSB7DQo+PiArwqDCoMKgIF9yZXF1aXJlX252bWVfdHJ0eXBlIHBj
aQ0KPj4gK8KgwqDCoCBfaGF2ZV9maW8NCj4+ICvCoMKgwqAgX252bWVfcmVxdWlyZXMNCj4+ICt9
DQo+PiArDQo+PiArdGVzdCgpIHsNCj4+ICvCoMKgwqAgbG9jYWwgZGV2PSIvZGV2L252bWUwbjEi
DQo+DQo+IFNob3VsZCB0aGlzIGJlIFRFU1RfREVWIGluc3RlYWQgPw0KDQp3aHkgPw0KDQo+DQo+
DQo+PiArDQo+PiArwqDCoMKgIGVjaG8gIlJ1bm5pbmcgJHtURVNUX05BTUV9Ig0KPj4gKw0KPj4g
K8KgwqDCoCBlY2hvIDEgPiAvc3lzL2Jsb2NrL252bWUwbjEvaW8tdGltZW91dC1mYWlsDQo+DQo+
IG52bWUwbjEsIEkgdGhpbmsgdGhpcyBoYXJkIGNvZGluZyBjYW4gYmUgY2hhbmdlZA0KPg0KDQp3
aHkgPw0KDQotY2sNCg0KDQo=
