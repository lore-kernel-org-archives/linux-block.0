Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3F134C9
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gRnAy20x";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VCHEunvT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705400712; x=1736936712;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=83ikC/unHMQN+08GVT3nK69zw+3sDtGb34dLaMFPkFQ=;
  b=gRnAy20xay8imy/Qq5+XkaqQhGUQn5lxOTvbQ+YrqZlQ8UVZs66gXPUy
   r6+OEcM9stmlfDtgby4UXcZvPFoBOitsBL98ZALzO/pRNTabK8rhTBEim
   zDoV56MCrn4SYxl0xtQ3yGBN/hfKCL55Yy1VOZ/lgZXtoLrEHn4esK0af
   YP8L8FkSXknBRPxFNH1YH4HPtz/OvWeTPP9t8WBzqqPvGuy5bGciku6sq
   yw1/ZVzU7cPBnT28VKaPCgsNsKv9DIrRNeuX3K4fTIw2UAVXjKXzwlJXc
   Ha0d6+ORQ15HfYzDCyXRBKbQjIvG5yZTDvCkMs8jyiBWMuHTX6jWwQp9W
   w==;
X-CSE-ConnectionGUID: PgIipHTdRiqhx6+eUOhErQ==
X-CSE-MsgGUID: APT61Mp6TTO8z7lYHgMDuA==
X-IronPort-AV: E=Sophos;i="6.04,198,1695657600"; 
   d="scan'208";a="6728142"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2024 18:25:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irjUNge1I9nYw8gbImtDOqkChTkClkxF9GrQ6PqWW7PlL7eeMUGJBd6phDnkaNWlth+tlAEX5nfzYwWspeVsawFCIMJ7x1k7OW2MEGhlBIyJNCMpMOTBDW3ZC8DeFw493tGS4YsrWz2S1k6JXPVHeb20NFRHE6Vl2FBSH5Sj08XWrzBFQFBPizcKOsg6IlmtImIFLjU12Mhm3hs3jQF2UtvOKCN4JzFsMHoVl4MhtgpIEWjdUypIdIC0LyfUure23gqhykL8rMcbww7aJfLf4q22kvBYbD1F6ZWO5+RWO5rWDSMwtBHZkEtdhdYApB1RZZGl7MwMADa212BnH4aT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83ikC/unHMQN+08GVT3nK69zw+3sDtGb34dLaMFPkFQ=;
 b=KwdtgpwzC0SGujzJAEAc4lNGXzmBhWpbp85w6Q/L3xA9jDDAVT5/fO4iYJAF5TGqHVNnQEKE6zCSJJJQga0hFz0e7LBvipUCo8n2AVbAYMJiRlUdTnZIR9eRhJ2kkzjGZFRhcgb9U8QE9jpwrRcjmyMyNFkqBhJMRVKXsvVGTg7WXnXJxoxdmIDUoMb/tX8VtXb7/Fs5EHJKfmFaUNM8xq/gm6F+YEU/1EjL0O/PiobuZJS9qlsJBUCScGKVSthM3Uo/RgSbVN2ojRYsw5cBTCegGFAgO46uk1d3trFlaIzTAYyDp7WxOWNeWm2efTQCRArpykiPotRk7jtCxbNefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83ikC/unHMQN+08GVT3nK69zw+3sDtGb34dLaMFPkFQ=;
 b=VCHEunvTQpOHDl9k8sDN/cL7gjK0gzJVXTqF8VqSEuwSiubX82iAnMUb0KbwSn8Rpq67Q80qE+SDlkvh1UwK6wCsjWwjQhHUkYmUxw6IhmSvq/THa7Jlap0h6oPojS9jYUYEvcIaqcBRToJXGoC5w1Lx7koKvzEpZMZKGtLoQrA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6677.namprd04.prod.outlook.com (2603:10b6:610:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 10:25:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 10:25:01 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: cache current nsec time in struct blk_plug
Thread-Topic: [PATCH 2/2] block: cache current nsec time in struct blk_plug
Thread-Index: AQHaR/4MTgTRsZRCkUSaI7Dx/FkEkbDcM0kAgAAJPwA=
Date: Tue, 16 Jan 2024 10:25:01 +0000
Message-ID: <6f98b078-5378-4d6b-8089-76bc53de2894@wdc.com>
References: <20240115215840.54432-1-axboe@kernel.dk>
 <CGME20240115215903epcas5p1518ca37cf0c83499dadba07bd3e51c77@epcas5p1.samsung.com>
 <20240115215840.54432-3-axboe@kernel.dk>
 <ff4a6649-9f09-23fc-ad33-06deb4845590@samsung.com>
In-Reply-To: <ff4a6649-9f09-23fc-ad33-06deb4845590@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6677:EE_
x-ms-office365-filtering-correlation-id: ca76b34b-87e8-4944-62f4-08dc167d6593
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5EeRstqzwkN47FWzHxoOilKs062j6qfZnI/UxeF65Uuhf7NxM/xtvW9MYDC1ajm4rcB7Uf/IaziFToxLd86lxRg9wJopN8QBk4kYBnH+0HYZ6tNsx7csofzcfPEg5tznjh5Y2gZP5UwEZrqzKY10+SKre/oLjBDR32TQbOCsLDZNN1RKeI6Biom5wvPwvi3D5VWDZR2jqYA38ziFSnpXrJGdtRCniA60KOYHARYF7J8urwxp1Z3et0IZ3P4SDZZRXA/4FeF4X2wIQPXaXSjfwcDi2ME4ZI3QFL+6gJXRBKHFJAvNmg8hni5apywlZNzyNbpRlUzw0qJTewNxfbPS5ibU1966e0N5yibG+bGpzkBP+GXNql67fTylCJYGuotDkmf7HCZW900k7QYj554t3K5TsVHMEEUFZhNSpIgTerkTXP4RCa6qqQ+q/yd20wq205kKbHwKEOjSMSES4YX0n+0wvVIDIuJm0vgOZVfrOGWZD197/dOMpF3c7Yk56yaRamdvtWKMdxcxlAQJ5p3wvMcTv1an7eXkUz92QYoNDwGhLC1f4a+dUQkguxWxLepfqX6pYh/tnOWF+q6KEiMxwrEbvQs9rLmD+RfN56j/BFIMpcsBTi256BQ2f3lN/JmIMJBpZ7KEr8u/VPiqu9OexNcyPBHDEpJk05bft1OjS4Cp/qntSBUSs0I+nc3vIXRo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(122000001)(38100700002)(38070700009)(36756003)(31696002)(86362001)(82960400001)(110136005)(316002)(91956017)(66946007)(76116006)(66476007)(64756008)(66446008)(66556008)(4744005)(2906002)(5660300002)(8936002)(8676002)(2616005)(71200400001)(6486002)(478600001)(53546011)(6512007)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWRDZnRGWjVHRDFoM0RYOU4yQnJ6SGxkS3h6dlFaNDVGSXllN0FLQ2ZEbnh0?=
 =?utf-8?B?WjREZEt2QjNJMG9NY2dsbDZ6eEdLQTRMU09lM0RGZzF4Z0VYTFFGZkg1UGJQ?=
 =?utf-8?B?azZialNUTlc0Qk5GdTIyQTJWdGxWYXloQ0xiRGxMWU1YbUtya2c1dWhIdTN3?=
 =?utf-8?B?N00zQ2RUZUZYT1FINUN0ZkIyTFcwVENjUExVbWgyNTl0blRvcFI0RFRPbWRY?=
 =?utf-8?B?Vi9seGRTRTVhRlltOUwwUVNhMEZ6N0pjNjU3R2cvY01sUmIvUlJzeHlkZnJP?=
 =?utf-8?B?SXBDeG9mK3RJZElsY2JEV2EvaVFWOHlQOVM4OEF2VUtKZmVaMDhHVzd0Q1Va?=
 =?utf-8?B?eHdHSUl2YUhjbTBFYkd3TjVva1kvbGFhcHBRYngwRFNMVUY5V1E1Yzc2c2tj?=
 =?utf-8?B?a2xyTnp3bGFmNzJmM3VzYXk0STd6SnIvQkN4bVdKdVNQenNuTDBndGpmVEtm?=
 =?utf-8?B?eWFDSk1GY2ZRSXdqQ1JDbTZXckV1akhscFFTQjRQNkFRQk9Ea3YwKzFQOVN1?=
 =?utf-8?B?WmljL241cWE0SkwreENWMWxNa1VOc3ZaUUlCeFlibHMxeWczSXBsb1RidHIz?=
 =?utf-8?B?ZHMyTnIrQUpDL0VBZ0Q2SUJuNFd6VlN2djZuNlhBa05pYmd4UzM4dmJXazBw?=
 =?utf-8?B?Z1BRelJmRzNsOHN5c3hDRXdzSnZFZFpSc2pNSUllem5qSVhqcU0ycUFUUTdP?=
 =?utf-8?B?anVaKzVrbE52d0hsa3Q5cTVaeVJjaFJ5bHRSMi9kRmJTTFZ0aS95K0JsTy9F?=
 =?utf-8?B?NXdLQncvNjF3Z0NKN1M0NnZLYmtpdFNXbFZtZzJzMmZPcDJnSHB0L0MwZmUx?=
 =?utf-8?B?YWtLeTlqOFJ0UU9xOFN6dGhsZTc0Q2daZzZWZnpRWk9OV3dvYmUwd3hZeW00?=
 =?utf-8?B?aFVYZDF4SnlKZEh2Q1BWVTQ5NFpHTitGNGtmMFQwdUthVTBoV1V3MDBmNXQ5?=
 =?utf-8?B?c25BNjdRckdZTzhOUFZIdXVhOEphUDZLSEVOdGluN0t4YXlpK042dlp2MUVV?=
 =?utf-8?B?WXNsNDlYbWJlVWhzNmN5RVIwM1pRQStWTXVWaFJCVmJqLzNnSTlhTHdJOVlF?=
 =?utf-8?B?L2RxKy9VOHhIWitrOG04Nm9jQlpSRzAvcFlzbzNVWEdQK3hKUUpndW1IRElY?=
 =?utf-8?B?d1RndWdZYm1BWU05Vk05M091UE1xOVV5T25mUGRuOWZLMTlnUk9RWllQUnpq?=
 =?utf-8?B?VytmMVk1T3NCaWZlaEM0T1gyMzNzQ3BhSWNCWFowbjdKU3BpTkJhTXFjL0lk?=
 =?utf-8?B?c1NBbmNDTStkaGNqWm9CVHFRc1lERW1uelUzVFk3aHNJMEZ6RklVQ01QMnBJ?=
 =?utf-8?B?a2V5TmVqenFhdjVmRTZrcDZBZkROdzYzNkpFNmg4ZWlQZW90cUZJTGpGdG81?=
 =?utf-8?B?ZWhESU8wblphRWZVa05oeDB1ak4rbm9XSm8zYmNTQnlYd1c4aEYvZHRqL1VQ?=
 =?utf-8?B?L2o3VnAwSDE1ak5sa1dHUXhEdXFYSEpTdDFxT0l2bTdoejJpZWVUWDFvOGxE?=
 =?utf-8?B?dHZuTzFxTWswc3FYa09nb1BvaEJ1UDNVTHdQNC9MdjduckFKYlpyNDhvcjdI?=
 =?utf-8?B?YStTQlp3Z3ZSNXgyc3V4ajR6WVk1azI3RmgvUXJwaGxiUHdIbzJSZUlwNnhH?=
 =?utf-8?B?Rkhmems4OEtVTHBidi9yRUZvVDdQbjVPQjZmVURtQWIxVVAxWUgyTEgxcUJN?=
 =?utf-8?B?dko1bCtLVE0xVUUvUy9nVGRuZkZYSDFFQktaanVFM3lDb1RGMWJLQ1lUYXpL?=
 =?utf-8?B?RTFPdWt1YjVkZzd5dURvWmUrYWVJNHhaUklEYmtrNWlWZGVJcDQrRVY1SndS?=
 =?utf-8?B?MFEvUTZNM3Vpb2IwaGRyeEdsOUdNRXN4ajZJazVKWnZ3RHdCU1BLUGdYcUlT?=
 =?utf-8?B?RHVrcTRSREVBcCtvMWVJWnpRL2s2TDczN296SVg3dXlEVE53clAvZEVZbUpT?=
 =?utf-8?B?cm1JbmZMaUFwczZtbWdUUktMN1B5OXhCdGhjK29KeDROcWc1L1NvU2owckpu?=
 =?utf-8?B?WklyVWc0Znh4YWZTbG9XTFU5V0lBQmFUZzF4TWw3NnlxdXBQdk9YR0xNMUdP?=
 =?utf-8?B?OVNtTlpPNXV4cVN6UTJDL3BFVllXZk5GcVorVTZWSXdBTG0yN2V2UmIxR1Rh?=
 =?utf-8?B?c0Y5WWRWNk95ZjRMdkFnMUVFdFpSU2ZpSGhkck1zTGx4WWtabUJoNTJWam5s?=
 =?utf-8?B?SThzK3NtTTl6ZFU5SkpBVDIyOTFCTXdiTUdFcEVLYWQxUHdCUWVtdlJ5VTVC?=
 =?utf-8?B?eE0zQzdmRWJIbzRlNkhWNkYzR2NBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <275F9215FDFDF64C8CEBE4EF9344DD40@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PLi7gvTHO6WCx0PRUZorIfBMZOUSIdGHqiFoV4rYZwHxERY5MokYH29FGX+khHcIAhwEM/KIXnbNUJUKdsB9e/rkqoNXC/B7oCX8ewvInDY3ruLr8u0RcO0wVg/smceCgaTijGynExaJKTBzkNvU1a/IXzQFOXQIHuGzJs1+HAkNW+pDGz83dF+OT9cD6XYvNJfoZx0KSejHpYo4J2RKSvZFjZ6CSf5v42scxOBeFnXz5Kc2UL6kApHo2f/17Z45Y9Hz/iEyXzonKnSvAV5zpNnObFwaw77S968IkjUqfa9ibgEHU246W8m7JLwhWUH8DTrh17ZCFbbzdXRcUcCOLYalNvrUeSLY1WvgLgOlPt3Rwps4mvmyJXqRFZ1CIrum4byD5ldECBwBzPohgrwU7y6MCsZmVg2M6AMJGGG6wVxYnI1O3RRvBsZAkoda05lRHH9B8s64UF686aOOhv3aDqd25F1wEVc58kRrmgpKrc0zP6qbXgj2v2bso4Q8uM4W+Rt3eT/jS8YrycsVsC02Q6AVwLJEqBf/j+5xQt78ldF2vBzz3aPGJHa+azsj7d6qRSv8JvpTVeQu8vkFXTPgOKEATcEgCo2IznP320Bu7LH3rO2DsLRcGcVWpNNtoeQd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca76b34b-87e8-4944-62f4-08dc167d6593
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 10:25:01.0612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TNnA3JoTZeKhqG0XCT74QTBhuApPqro2zyMQtxcjaVxOZ/9EcL+XxWalVO/dSFdCzUKpTXUOE4MenV5bZc/DI1e1v3VtBl7c/UDz3E4kC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6677

T24gMTYuMDEuMjQgMTA6NTIsIEthbmNoYW4gSm9zaGkgd3JvdGU6DQo+PiArCWlmICghcGx1ZykN
Cj4+ICsJCXJldHVybiBrdGltZV9nZXRfbnMoKTsNCj4+ICsJaWYgKCEocGx1Zy0+Y3VyX2t0aW1l
ICYgMVVMTCkpIHsNCj4+ICsJCXBsdWctPmN1cl9rdGltZSA9IGt0aW1lX2dldF9ucygpOw0KPj4g
KwkJcGx1Zy0+Y3VyX2t0aW1lIHw9IDFVTEw7DQo+PiArCX0NCj4+ICsJcmV0dXJuIHBsdWctPmN1
cl9rdGltZTsNCj4gDQo+IEkgZGlkIG5vdCB1bmRlcnN0YW5kIHRoZSByZWxldmFuY2Ugb2YgMVVM
TCBoZXJlLg0KPiBJZiBrdGltZV9nZXRfbnMoKSByZXR1cm5zIGV2ZW4gdmFsdWUsIGl0IHdpbGwg
dHVybiB0aGF0IGludG8gYW4gb2RkDQo+IHZhbHVlIGJlZm9yZSBjYWNoaW5nLiBBbmQgdGhhdCB2
YWx1ZSB3aWxsIGJlIHJldHVybmVkIGZvciB0aGUgc3Vic2VxdWVudA0KPiBjYWxscy4NCj4gQnV0
IGhvdyBpcyB0aGF0IGJldHRlciBjb21wYXJlZCB0byBqdXN0IGNhY2hpbmcgd2hhdGV2ZXIga3Rp
bWVfZ2V0X25zKCkNCj4gcmV0dXJuZWQuDQo+IA0KPiANCg0KSUlVQyBpdCdzIGFuIGluZGljYXRv
ciBpZiBwbHVnLT5jdXJfa3RpbWUgaGFzIGJlZW4gc2V0IG9yIG5vdC4NCkJ1dCBJIGRvbid0IHVu
ZGVyc3RhbmQgd2h5IHdlIGNhbid0IGNvbXBhcmUgd2l0aCAwPw0K
