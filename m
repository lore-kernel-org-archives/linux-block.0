Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34601C30
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tw+N0gVU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIpq6owwqFIISYYMeIe5WEkqmbBTI/kfKHa/9VbvQhhsBe72LeQnY8dNZdqNYgkJDHVKIRlpQWjB7GA5P/2ZhmF25MK9czZLTEn69z7HiIsv+yZGsbP+mw7wQkul+Yn+iW45nalajv2ukui0BXBudfOSjI4zZrECsqd9VNB6JhR5T0P17EpgYqPnWN2OJvSWi/9tOh8nTA25hqDAU2gOXgBKxEAv+a/38vrBVUAlzgwNOyG82cOuyI+2D3zL9hUdJYF+bQNLF5U7DBd+f5muZ0NlHdH8nXCNwWrCnP2RqPes/PJknCmpDC+GoBfzNrjLxAEtviTWhX/hgl4Fdl0uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwD89KV//ehtuhxHCznArNhFVIhACn3rUf/lRDpj4tA=;
 b=aF0yXH2CnaKXjugnEhCKQZfwFZ9i3Mxw9cFEH/hpTD6eRIehN6CRWoQi0ZHYNS2QA+ozGOMZbNwt+3mXQRsGO4Z4cK+PWMxOspEE9fjOJXWDOC/FYei6gAqtsGecKiHkFcCzvDAmiiZWRiKpBzfrGjntbUzI6AC7fQbSGqBoFluuYzfzr9xodYMBKF74vVRl1bLvBUXgCaHwOsWnXHdSWoUm3I1v4qWVA6qBRQ5aL89NGBEnD9XlD9d/Dl6lJ56OCUD8amStM0GOX3tA0ruYrYO3Xr/eVGnWS6iUsPX+B1nn//wG+5mXCgKkq7fSuq+MpFsf5MneCj30x9TABIO+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwD89KV//ehtuhxHCznArNhFVIhACn3rUf/lRDpj4tA=;
 b=tw+N0gVUTAdniO7m4aCZdzccSjCFZu01aK3gqisV4uOiRlO0M42sarTcGXY/YKB9nSoLjbQXywPE99W1SeDHujbhEN1Qa1glZbnrPjmhz3g6FDYJEmOSNx6KS/dA75TfuC2MNGSSmFl3N7Y5olQcm/N4oPXn2pXwnpaOhjjnXEtRoZoFv0pxabUjRUKGlHo47liz9cJQEC7fknzUn5yupu+Mdp79C8t09yfg/OQcpbPmtsP0CMTXRBDiVmEMsb7LwH3AwbBNZ7SvOKVYwMHsti88yKDsr4HNNKckjOqgpEhx4CmjfbAGDVjbjk5L1rzgCSYn43n0B7x3xoMWCelTVg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 23:28:57 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 23:28:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] block/iocost: silence warning on 'last_period'
 potentially being unused
Thread-Topic: [PATCH] block/iocost: silence warning on 'last_period'
 potentially being unused
Thread-Index: AQHaQ9o7bYwhBy6M5EO1tyRbBKvwR7DTsd6A
Date: Wed, 10 Jan 2024 23:28:57 +0000
Message-ID: <3925bffc-1130-485b-ab90-f556defe0004@nvidia.com>
References: <06a7b6da-f3de-43cb-8ac5-bdd090a7d33b@kernel.dk>
In-Reply-To: <06a7b6da-f3de-43cb-8ac5-bdd090a7d33b@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB6723:EE_
x-ms-office365-filtering-correlation-id: a9d86c9e-4e6c-4d4b-552a-08dc1233eb11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xsiahT18c3sDNaPehyO2Ls7uh97nAkPFja9BWohi1TjGuDcLy0FiL4oyi97KNHwkugNtUlbWoje+bn9myNORGTZiMxFOlfX6/OsOV06EOsGUD9e+g6L5EdHsNsP5hv09fzTUYsDPbM3R4X+aQThKLuwOrgQj8qFGL4sjPxlpkqSpmjbpTgopHPLRPj1SkHeyCcUXhnIMISazne6t2HiQuiMb55jldPx5PqP5rm5lVZJvbZoO79s+HwszCjfV5KfD9FH8UTQHYEYgxmtYzV/aw4XIAVA8FWNqYBN/MfPLTRJZknaAK9zW1AhJNstY8xGbBIuaKMTMrnBXOXmenNFk27Q/dqmYHU/FRRoO/N/nvmVBjtE/pzO4jJkhdBkjZNsb/ORhwC+Av6cJ/BVEMCPRzDoLlVD28I1Zj5wclJkfgl2TZVtPYTDbPI/jCrj0nM0JOjV/O2KsPtBnk36DFYJTw5zaXBoXpBNkLai2k2Yh6dHxpJcsxXYId+3TKmxNZOsIdyrbgEvMNKtIYw4eueUY2ADLfm8SdIYzG625NrcPXd8V5EqvWJcI1FyYWohbBjjwXzIUW9jo9jRoyqsbRFZzabLlUEOCfFrBGw+Jd6an5PuCdrwnAZG5eDxQ3uweMQn9uAXDgmbL0Xox3UnUcF40oADliFIumpSdAlpetadY1eVtL47a8NX6uyBNaFZ92pxtYawPdGwsXrFSBCOeJ+eEu4nlSBeWUFaBIXWhKgY6XiEtLvT9WJFqh04obisGXO7fLS7YOG45yocqMAE6ULdc9g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(83380400001)(5660300002)(53546011)(6512007)(2616005)(38100700002)(64756008)(122000001)(8676002)(4326008)(966005)(8936002)(4744005)(66446008)(6506007)(71200400001)(66476007)(6486002)(2906002)(478600001)(316002)(110136005)(66556008)(91956017)(66946007)(76116006)(41300700001)(31696002)(38070700009)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjNTRnhHRTdCV3l4MU1QV3BKa2Y0TGJ6NEkvU0J4WnNUVmEzTjlvNVFoR3V0?=
 =?utf-8?B?ZXVOL2hERngzN29ISlh3RzJOaG5kZ2FQd2h1YmtML3VzTDFYT21IU0ViaE41?=
 =?utf-8?B?VGR2WXBXVjY0QW9BZXZ3UEU2Sy9XdXFKVUZCanpPNFAveStDQW0yemhpS0pL?=
 =?utf-8?B?N1ExYXRiWFYvOHdlUEFoOGxxM2hXNVJ1T2h1M1h2YUEzejFUL1ZCMEJOZTJj?=
 =?utf-8?B?OVRxWVUvZG1vOE5jN3pncFV5dEJnaUR2R0RpUjRZL3JVc3BlZUF0Yy96cEpX?=
 =?utf-8?B?L0p6MXQ0TktWa1A2N2xEekFvNjlTckRSYUZZZC9ndWYvNmR3bWFWeGR5eUc1?=
 =?utf-8?B?bG42SGZUaDJPbXd4dC9RK3V4ako5cW1CKzB0aWVXQ281Yms1eFJZV214cUpP?=
 =?utf-8?B?aTl4TzdKbWV2ZllqQ1Q4clgwRVM1dUFkUFE1MHlTN015STdpeEM5QStiZklX?=
 =?utf-8?B?VDdheFBIalQzNk5KZWF3bkJDWmE4ajlVS3lvZlZUV0Vqd1VkTGdLclVobjdR?=
 =?utf-8?B?WTNvQm9NTHVUQ28vcllZRUp4YXlzSDZFYlQwK0FuOFRKNDkzajBacDIrd2Ir?=
 =?utf-8?B?cW8xMXowL04yQm1HYUhsNE9LT2ZGaDE1cHc2dTIralEvcTh1R0EvTHhqbGVS?=
 =?utf-8?B?STRFeHpPQjBoNVpYWUo5eFhxT1VmczJKbnF5Q0dtZjVsdVM0N2lQYjhqZldz?=
 =?utf-8?B?UW9aOTloV1FrOG5oWkhzMThVNklBaHA0MmxCcFA2Y25QUzdNdi9nVHRvT0dS?=
 =?utf-8?B?TWhMY2pRbW9RWTh4NFpXZGtZVmxoOFZOWTFMQ3cyeWN3bkVmbmhTaVR2SDhT?=
 =?utf-8?B?a2N0YU5HRG03VlpNaFEyd2JiT1RwSU9MdVc5YXIrT0Ivd1ZDT0tXNGt2ZU5l?=
 =?utf-8?B?S0FqRFZBcitWQTR0N1pxRHdGbkNVdC9IMXk0N2x4czh6SDU4MU4rWEdoUUFK?=
 =?utf-8?B?L1hybVNnQkRXSnQwM2xHRTh5ODF3bWgxZUlIdXpIRFR6aGZWVThJTGYxYm9F?=
 =?utf-8?B?dmR4U3I4SDd2Y3FJYkRnemFvOEFjSmMzbFhza0hCL2xYa0MxbjYwZndRUFUz?=
 =?utf-8?B?dUs5Y2tzc0RHVWkvakJreG5OLytGRHZ0cGJ4R2YzU3d1OUNKWXJXMnBVcHVz?=
 =?utf-8?B?YmpEQTR2UWFYVURYcXRONjVUUVBOclBZVkt4NGo1WGxBZDJpdFdFZ3FYRGxT?=
 =?utf-8?B?cFJXOEd5K0RHVUp3Z3U1cTZOaVhVTlNDZ0dJRkZrM3kwTjRaOVhyaDVLcVZY?=
 =?utf-8?B?Vk1wL1NKNlFzZDJDb29uKysxdWR5c0tzc285Um9EL1FVcUdIaUQ2OCtqaUFp?=
 =?utf-8?B?RUROUGlKM1VBK3R0VjBUbVBUOWZBZGRRTVhZeDRUK1NITytSak9OdmtSeUZp?=
 =?utf-8?B?OW12Y0Z6d0R5MW9icmhiWU9kNmRQVWRXRFMyc3YySXMxUzI1QUxab1VzTitR?=
 =?utf-8?B?Z0Y5ZlNOWXU2VlRHY1NqeERLOTJ3MW1kNmR1QWRTVzJOS2JoN3pwbHJJZ2Ur?=
 =?utf-8?B?NEhlWGhBQWt0anpFcFgwdytqU1RhYThqbkg0MGg4VW5KRDdySXM0UXoyZWZT?=
 =?utf-8?B?T3RoU0dkeEVGTzhRWCtISG5sSTE4TzZZK3pEUmtvUnN4a0tiOFVkY0tleTEw?=
 =?utf-8?B?eGVCb0F0OW1GNTlzak82Z0I4QzhzcTlMM3BzY0ptRDBNMUZ1dTk4bm9wNWhk?=
 =?utf-8?B?NGZOL2RYL2J6bkhPcDNoWEMzZEJnWERURGk3RE16Yk90dHZUVW1LNU54a2xO?=
 =?utf-8?B?UWRZZDNMWW4zc1NpenkzZEw5VWphOUlFRDhrVGpzRmJRN2gwWTd4eHBQRmM0?=
 =?utf-8?B?dVJZSGJtRXJOY3BGYjlrRzlUalN2SEtHTXoyUVVzM2Y0aW1vblFwRGVPaXQr?=
 =?utf-8?B?QXZ1TVR6QldwMkFLRnFZUFBoeFh2bS80UGhta3EvbGg3bnpUb3RCTFVnNW9h?=
 =?utf-8?B?SURyWkhPNXBsOWlyUlVWckdVVU9YVDhJUkdYOWdzb3E4Y3VqR1h0dWhoVXc1?=
 =?utf-8?B?RmFiQ09YaEY3NW5LTFYvc3JpNm5CdE1KL1JkbFhnM3p2UTFoVHpSOURSVlE0?=
 =?utf-8?B?eUFrakozdklra0hvSm14eVdoRDZOY2xyWWFSRkI0TVJ0eVhVOWZzb2Z5YmZV?=
 =?utf-8?B?YUhtTHFscnRzdFVVWjZYMXRwRExyS0FwUUlxa1ZqdCs1UmErVXNacDQ2eXRh?=
 =?utf-8?Q?R/BZt4vwQzwFOtHSqXpBLC9B5jk+Q4ndvhbE2krrwvmY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BF3787CABBF374790B4562B65CC502B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d86c9e-4e6c-4d4b-552a-08dc1233eb11
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 23:28:57.5628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4t3UYJpRAn+75uhdI/g3hHPsHvn4KbQKIW/0NLdBhY3fp7VgbLNbyJ2n47AH93KW6oH9gV20tMvHdboDtgwKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723

T24gMS8xMC8yMDI0IDc6MzIgQU0sIEplbnMgQXhib2Ugd3JvdGU6DQo+IElmIENPTkZJR19UUkFD
RVBPSU5UUyBpc24ndCBlbmFibGVkLCB3ZSBhc3NpZ24gdGhpcyB2YXJpYWJsZSBidXQgdGhlbg0K
PiBuZXZlciB1c2UgaXQuIFRoaXMgY2FuIGNhdXNlIHRoZSBjb21waWxlciB0byBjb21wbGFpbiBh
Ym91dCB0aGF0Og0KPiANCj4gYmxvY2svYmxrLWlvY29zdC5jOjEyNjQ6Njogd2FybmluZzogdmFy
aWFibGUgJ2xhc3RfcGVyaW9kJyBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZh
cmlhYmxlXQ0KPiAgIDEyNjQgfCAgICAgICAgIHU2NCBsYXN0X3BlcmlvZCwgY3VyX3BlcmlvZDsN
Cj4gICAgICAgIHwgICAgICAgICAgICAgXg0KPiANCj4gUmF0aGVyIHRoYW4gYWRkIGlmZGVmcyB0
byBndWFyZCB0aGlzLCBqdXN0IG1hcmsgaXQgX19tYXliZV91bnVzZWQuDQo+IA0KPiBSZXBvcnRl
ZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IENsb3NlczogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI0MDExMDIzMzUuR2lXZGVJbzktbGtw
QGludGVsLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRr
Pg0KPiANCj4gLS0tDQo+DQoNCm11Y2ggY2xlYW5lciB0aGFuIGlmZGVmIGZvciBzdXJlLi4uDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0KDQo=
