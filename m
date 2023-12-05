Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eRhD9ewB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XBBup5XS"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EA1A4
	for <linux-block@vger.kernel.org>; Tue,  5 Dec 2023 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701794119; x=1733330119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p/AsgmHwbh5FDodzICs2jm8802SrgvyFJbuROPfQQ5s=;
  b=eRhD9ewB2WIO4xVwgLIq1+EkQM3StX98cTG+iGjz4mv2lw59135nAyFK
   Bgi71tUgiq2alogQ0VykBLOfdUra9lIe+Pb+sQRwYlD/e/W1HNUzzpPUS
   HJlQooDmMl/HjwCAmFKi3n3NOniADYX1eHFI7BdBQUWDfwe9PeB8tqXSf
   dcTYkL4Bvjwg79Uytqcc1bzZdaOjGVSl58UWKOa5h41N/yaVtzPxRYGUu
   egXp9WIbS/cn5zViAM5kRLpPsKCnYoQAg/PDZ05rwbF7n400Fhejp4FXW
   9TDDOvLD78R1GyEbIHBxueMZEvzfhr7ln9409g516LWecCGuWATahoHKx
   Q==;
X-CSE-ConnectionGUID: T8xCqbPyTgyz0EYgguGw5A==
X-CSE-MsgGUID: IeLJpnbyQtS83BrbTmwoTQ==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4067605"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2023 00:35:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWex3GPvyRBeQIYIfeMkYAPjyxTJ1+qFN0aW+DpZ8/P2DCfIADakFa6rGT6C7mc6xhowYuPo+rj6XoaALa3w9eoGomJ4FsA43U+I6KIx8djRpXy/CxOiar4WjGhRmkxYAknlZmlKv8fzRHSyPJ8cdQaD3yOff9n9F1STEYX0YHI0n5u1wH7howLhY/AGtR42Niu6qoIujnctokVAUBGSzi0DXmJ46pr0J+L1jlLgbgeH69fj3ZXQZwPiOPleEYKI/dSVjesocPzNnhrtDYgjzpffCYa3OUQHrL9bOBuKDoHl7FqbyrUYESufuQMFLI10xx15KYxIUj7wwBKLyAL+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/AsgmHwbh5FDodzICs2jm8802SrgvyFJbuROPfQQ5s=;
 b=n/lQruh9kfdD9LCwwHxjQfia4TIjgf6X1iK94PPOgUOfA1Zg//DgnPiHXJoqvhB8r7J2guod2fE+tyEXPLpWOR6/lWXpIkZs+Tg5+2ONSjrsc/ChRMMfNo9GsvTzu07Lbf6NaLP9VCKb5sGq/DJRu4QU8hVAF73psKlWNEjJgK4+1maaoSc2ev8kH11rUattuJ5zI3j985nBl6IUVyxM+VDpo7l2K+tXYLKu6jjrIZsvIXkG0s2mFpdARnzzmCzkyky60h5SLv7IVEONKSEEH9RhNfIwilqni6puJAUdy1HNRk1tgO9rx0BB9FYxRmR/2vGmw6iMnO9SweK3oPzI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/AsgmHwbh5FDodzICs2jm8802SrgvyFJbuROPfQQ5s=;
 b=XBBup5XS6EvuAE33s/eD7gYtOb4Pw1ESJgCcddo7Lr9lTnTX7bmt19/uQ1+1jqoHd/HGgjYFIbP9g1wfvM3JKOFsPkCSCxMRfhmmmi0WV0aWDAcJeCnzmnahphiMTscvcj7O8usSbokjZzJPbmR5aTAYbBPV3+N/onZW4/ePyEM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8154.namprd04.prod.outlook.com (2603:10b6:208:349::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 16:35:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 16:35:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: fix bio_add_hw_page for larger folios / compound pages
Thread-Topic: fix bio_add_hw_page for larger folios / compound pages
Thread-Index: AQHaJtg8WAoLQp0pNkyhHog1vJGCzrCa5FoA
Date: Tue, 5 Dec 2023 16:35:15 +0000
Message-ID: <938d4b5c-286d-467b-a6ac-e43e9fe6faed@wdc.com>
References: <20231204173419.782378-1-hch@lst.de>
In-Reply-To: <20231204173419.782378-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8154:EE_
x-ms-office365-filtering-correlation-id: 80e7cd26-a6a5-458d-1211-08dbf5b028e4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z4ayhJC6C6M72Ujz4C6x/ZYT97num5mvh1lOB13DRPwjk1tPRF37VmSksPxeX3X3pU3Vv2qw6aFW7fAktiB48xY8Vr2s2ZeGOOLS++Cmd74iks76+uh9rvwD7RGc6SnG0SiyihCfWzEQcRu8kC8W/Ao7GR5smNiXZNe7JCaVVcJLsFt3PXo+3X4nZJOFNZAIdvxyoQG9TdM+B8sYrrr5NoI49MyaySmuZn95+FW9PHMPhWEwdY0M3xXTroEXlDoAPVIAsF2itUTx/eKLL9ee/NnB7/XGkSLQWDs6xACwA7+pp9+DmIzwRN2mQT8wwT6UCIhqW93bX2qZierEKSRQBmfqv6pk089SHYaThnzxxJpF0jhC23IC//UWD3pUbCy7YL4w3YmxYx9lg/pWaHDi8hOhdq5aHTChDOvsfwhTB5AjHyVwZd+cL4jSJ4Q+GgkWByIRNO2lkizWdkyrymO2cfvp3K03fZa5fyWhecHroorkqj+6+WcnceadjrZUKEhlwh4dOu5Id35iXsV6brIL2Pkpt0iQ7qQNp1UHLOUhCnWdBVUtLyAL+BYp1+W3t+JoB+SiL+bbSm7AXVQJxhzPkf1L83ZI4iaA268hDcoFoAaDYVZMzw16lXMPsQtVnKt4IYW4shsjeTvNqSTPOnuuLo7dqVEhfiNHTIKlYtOKG2MiU03GSTnc6zziGP14SjR1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31696002)(82960400001)(2906002)(5660300002)(4744005)(36756003)(38070700009)(86362001)(41300700001)(6506007)(71200400001)(478600001)(6486002)(6512007)(53546011)(38100700002)(122000001)(83380400001)(26005)(2616005)(31686004)(8676002)(4326008)(8936002)(76116006)(66476007)(66946007)(66556008)(66446008)(110136005)(91956017)(64756008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFpLWDk1UXpMUC9NS0l3cnBXWk5PWm1JVytJbjlaUGtGUXhPUzhQUzNLSkFL?=
 =?utf-8?B?bTZCeFpXYmcvSmlKcXVLR2NPNysxeWl5d3FaR01XY1R0YVJlL283SVhNcjdP?=
 =?utf-8?B?cU5kVlhrYWUrdmlvbzE1UGdMNzF5U1ZJNHZqeEp2UXhMVGVwenYrTWZjZWh4?=
 =?utf-8?B?ekxCYWxvQXFxanNhSzVwSldURThHZ1Y0bDJjQTJGMHRlSEVBcmtHU1Axd0w3?=
 =?utf-8?B?WmFtbGd1aDlLVW83R1RsTEhTTkdraGtUMGVpbis3OG1ZeG9aT2hJdWQrQjBo?=
 =?utf-8?B?aThqMlFOWG5maUFucFhTTVpWOVo0cUZLcW9TOU1EME1nUjJyQXJKNjh3RC9B?=
 =?utf-8?B?ZHR6Y1lUOERXaHA0czNWcTRWZ2Z3UWh4ZGE2dTNLZmtlYnU3S2RvUklDNVpZ?=
 =?utf-8?B?NjRDejFyY2FkRlJ2eUV0VVRCZUs0MXcySUhYNS9EN3BUMTh1R0ZHTmg0WFRo?=
 =?utf-8?B?T3JoL3NNVVRZUnNWQzZuZVR5NmZnMzlnQ0w5clp1clJYeWp6Q2pycUxkVGw2?=
 =?utf-8?B?VWpJWENGaml4dUJIQ3VXNXpTR01Sc2tvQjVhYTFOZkxuTUpheTJNWGRQZFZ0?=
 =?utf-8?B?R2Z3VDY5UEJQcXMzUGh5OFIxaEFOTDBLNTBQMnpGWW9mTFRYYWU5bTA3R0V3?=
 =?utf-8?B?QjM1QjdoQTlGYlJmOE8vNTVkcHBMS2NMZFdmWGp2dzVNRms1d3J4djhudUk3?=
 =?utf-8?B?TWpJd01SMWx5SlB0RVRhS1NxQ0JRVVVvZnI0azlmVm1ibXZINWpaU2tJU05m?=
 =?utf-8?B?RVRkS0dwTzloRUdNaFRKbHpCUVZITjJ3ckFXejFBU09zUHRwOVZ1d1hIVlF6?=
 =?utf-8?B?aUNwelVxVFQybFJ1d0dwYjVHVHNCZmNTdXpmMlRabGFBRUpvTWN5LzBZR0E3?=
 =?utf-8?B?WTR6Uk9lRFZjMXlEZ0pCL0ZpUFVqS1B4ZjR2Z0NCRkJGemEwT0tKcitRZWt0?=
 =?utf-8?B?YkZqNUlkb3d0QkgyK0tSQk50b2dMY05MSDlKUUdPUEdRNVhHazdMNlc5UDBn?=
 =?utf-8?B?UWJFa3JIWU5tVDZkdGM5R2ROTllkSUpqUDNZRkFPMlY0TEdGbUNiTXk1WEw1?=
 =?utf-8?B?Ylk5NklyRHhUM3BvbjArUS9CaXNjclBIMFUyeWtObWR6SjFGY2pVbzhKamNw?=
 =?utf-8?B?elR4WUJsTWRvSmpGaHNNTWVWQ0gxTStsUUlxNkFHcWlMSFJMaGYzZ0M0aCtJ?=
 =?utf-8?B?Y1NRdTY4QnpVcTRxR3F6OWExazVMdi9PSVFYd1VzeUQzZmpjYjd4MnY5aHIz?=
 =?utf-8?B?TjB5UlRYSUJxQzhuWGMza1BSVkZjNzliUUY1Mk5RbWE1ZFBBdUZ2NUZuZVgy?=
 =?utf-8?B?WUx4Z2JNYWVHc0VOWG5KektQVDdadUZJK1BRUUIvSkhLczNPVGVoWlN2V0pP?=
 =?utf-8?B?WUxnUW1Rc3VWT0tyc21ma2NhSGUzWFZqQTR4MmxVN2Z4TXR5c3A5MjBkaXdR?=
 =?utf-8?B?OVNoUEdrMVFUWjd4QVA3YWF6eElDUHhrRTg0Z3BCV2J6QkphWWhGZmgxV0Rq?=
 =?utf-8?B?aXpCZ1duVXduS05aOUwyczl2Q04zei9wdmExbXdQU2JhN0xyTDgvbDNLRVp6?=
 =?utf-8?B?L3FEbWJuWVhIOCtST3pCZVl3R0tpRzd0WDZhOEJFc24rV1d0RHFtb1ZNZWps?=
 =?utf-8?B?NmdMd1lseFl4UzZCS3Zhd28zUnV6eXF0b0I2bW1rbWJMckV1ZTNoY3Jpazky?=
 =?utf-8?B?dTF2R2p6SDV0eUZmd1ova0NMMTJYcUQ2eEpuNlY1ZHBJWXAvU1QwSnBuV1ls?=
 =?utf-8?B?dXlPb0s5a1p1UkZuclp5QmVVeko1M1ZmaHNjWXJCZGFSM3ZCNWRoWUtwNVQv?=
 =?utf-8?B?bUJBR3hBYnBHOWR5OWE5VGZSVlFwbWtkOFdkUWF5UFJMdmJGbW0yeHZWOElh?=
 =?utf-8?B?U0RYWm9ZY0RIL3VTb0cvQ3pmMkFvQ0d3cG5pMm5McXFYVFdJSC9YUGlrWjRm?=
 =?utf-8?B?VWd3VUVPM0pqaENYQ3BteFRiZ1Q4bGhSSngydHU1OC8zbzQwRUpZUXBLR3BS?=
 =?utf-8?B?OXhobFlXSitGR0JRUCtGQzBxNFp3ejN3d1Zwc1V1eW5UUVZRdENRN01Jalhh?=
 =?utf-8?B?NVNYUWF0OE1LcVR1WUpncXlnbVRtb0JvMUswc1VWYzB0UFhPQXVMZUQ3cFhK?=
 =?utf-8?B?c3BWcStuTnEvWkM5OW42alBpTGhybGNodjU4ak8weVQ5MUlTWktEYU5MSWc0?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B4133A8A441D5489A64F0DA2D452391@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23ZGJK/BrBte5WrjzqcnVyzv2UmbQUPNxpZnq+W1hSnPqziehR5dzZncAfj9n5XoXQfJCVWymbF+F99RzUEgqW7XdxWbT0MqsA6zg3GYqDcMRF8B/TY9ZgI4RoU7PBjrZRL85DM1u+1QMIkwWqIPJdG1DZT19j9pI05DytrYRwzvraVM8y4bKZkBLRHR4YdkTl9/6+EbMdonWw4RXvgaivJXRdphMnFYWgHbw2dlED56kRYAGbwCipP0w58kIUODe5/PdauD7fTLGQrIjzSwFg6yezajwNPME77Yq0izuifoRQuWWm04Hs9LJw5U+vhLt5XhKe467eBcfAHX9Wwfau0UKyf7cv4pBYbhfzhXVvXWRDJFJntr4qwhBUEOKJ2vS6BpZCxFrEqmuqMNH0rQsucw8nutv6xXMQDuRxgG0zy4DbyDNlbllOwLu6Zd5IsI8Ff5GIB8IARFN0oR8qIoojNuzOcpu9czhvzAQNODYKStRxPsVIuCBJqmX7eAiUZM7AOUeJ5cdH7i3OgC9h1oYAltDlHCy69uhQrLUtJgMjIaHiLalXOuWBfWAt5vZw/DHyisHbjTzxjjbfgG19cjQw8GgxkxxVaHRJ/nvlK3Gzw4vlzTvo3K6gh9d+/BxYNWYtrcOYW4P0pXGhjtu+jWajLtCfzHDXloDy6BI+qXak/lyjf0qO6AjO6VBlCB9Ov4MlMLvuvGUZKxHjhBHghr+onvYbgAm4tODC2NDxuM3HxL4SyFzmOLIgA5UlTTV0n4sh6urO8P3F1JO3Fl+sGMnVU+PEQc8l3VXp7RtwmrckebyrnmGR57QwLWZLliGE3ywYFpnZfaP5rpfFI/nPv3pw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e7cd26-a6a5-458d-1211-08dbf5b028e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 16:35:15.1615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2u3ReVS+ecCgpx+9N5bvvyxBzv29gpl8X1XrqTSPdNb2qfrIYiz1KDrImSQ15ql3rloIEQwQMkigpBweDM8cUtmw/sySNZBoc1cFCo0LW2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8154

T24gMDQuMTIuMjMgMTg6MzUsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBKZW5zLA0K
PiANCj4gYmlvX2FkZF9od19wYWdlIGN1cnJlbnRseSBmYWlscyBtaXNlcmFibHkgd2hlbiB0cnlp
bmcgdG8gYWRkIGxhcmdlcg0KPiBjb250aWd1b3VzIHJhbmdlcyB0aGFuIHN1cHBvcnQgYnkgdGhl
IHVuZGVybHlpbmcgaGFyZHdhcmUsIGEgaXQNCj4gYWx3YXlzIGFkZHMgZXZlcnl0aGluZyBvciBu
b3RoaW5nLiAgVGhhdCBpc24ndCByZWFsbHkgYSBwcm9ibGVtIHlldA0KPiBhcyB0aGVyZSBhcmUg
bm8gY2FsbGVycyB0aGF0IGFjdHVhbGx5IHBhc3MgYW55dGhpbmcgd2hlcmUgb2ZmICsgbGVuDQo+
IGRvZXNuJ3QgZml0IGluIGEgc2luZ2xlIHBhZ2UsIGJ1dCBJJ3ZlIGJlZW4gd29ya2luZyBvbiBj
b2RlIHRoYXQNCj4gd2lsbCwgd2hpY2ggaW1tZWRpYXRlbHkgdHJpcHBlZCBpdC4NCj4gDQo+IERp
ZmZzdGF0Og0KPiAgIGJpby5jIHwgICAgNyArKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IA0KDQpGb3IgdGhlIHNlcmllcywN
ClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMu
Y29tPg0K
