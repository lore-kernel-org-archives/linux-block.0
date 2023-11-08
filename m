Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4270DDB7
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XhsTsujX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QWWUmDZv"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAE61711
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 00:29:46 -0800 (PST)
X-UUID: f43b7b627e1011ee8051498923ad61e6-20231108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7FnBXbh/krtO4wslUNP+8b7FLLFwwOxpV7V36Df4kv8=;
	b=XhsTsujX/62M7MJrg5ZRt/VxhHW6LPysAVUcuA4pYXYXRbI0j0K5jU8yU4DIr/b6mDGMK8Chpr1FzWUa99qXUpYG3RLXcUp+wETTeEJEv67FqVBEX13Hwj2LM13g0ED9Pt94vH3s+wfHSdi+hcf3GZO8102Xd19bV9HCSA83I9U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:dd651677-d2ec-45a4-8c7b-62660e8b2ccb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:e2112795-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f43b7b627e1011ee8051498923ad61e6-20231108
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 103072923; Wed, 08 Nov 2023 16:29:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 Nov 2023 16:29:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 Nov 2023 16:29:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2tgCfHZcV5oaDgFajLqnFnIRYUE28M8lcojlZ/UzRYHEHyc2+411RnPeTs9Gd6G4pL2v3P72zryqwIS+8lIDEFwBTPODdN73MUhYo6tNdB5KAVh7mPM5169TYdw0X/MCQFeIOe3/gi8+QMT/Dn0zrG6S8d9COzElio+chY/kogwgOuCam+J27agwHcdw87j0r+zs+YILtIlcFQ2T7T1XntHCYonQbWGP1WnDQycHxS1XTQoXUjgTCjv7+FCUWxxw7o857tWsNvySN6b/jNx/REcpEwXs47yblbjtkODJqNTIYr+jKAVGHIDjFMY4JcthKrSrn5gzqTVART+1yvFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FnBXbh/krtO4wslUNP+8b7FLLFwwOxpV7V36Df4kv8=;
 b=VxEj2y06tUcCQG/czOs6qQohifLv79qWiEB/bVeL5tSuJ8nlAMxlPsw9dVL1Aopn5xfYxNJ5XeEe2sUFtdVUn6CNARJ3Q8XoXXrqUVO9MENn+hT1N8u7sKIaDfb400SqoM2siBqzdIsQEth1Xm3iyJuhs8+oFScyEfcGFAoB9qzDRFGqhNbibp78bGxg1XGQwNSe52ueTfWtRnNccNssQ0mqoJxmFbpEA+77WoprsGayZqNrQD3MHDCHxbzYe18iH9bql3lI/tmPPL66SDD6Cpp0qCi61mVWO5EarJd1zrePtgyvHWoBGNw/+RUqJhturtupTHivwdxzyqFE/uEuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FnBXbh/krtO4wslUNP+8b7FLLFwwOxpV7V36Df4kv8=;
 b=QWWUmDZvN61wWYzn7ULwWHF20D3t95wgXCZt0ZBiaWgOXHTJzp23nLUtb2ChsgKWjjQfdFIma4bL6B/zuvE0xWEbYYimbJpTxm8SJLQjGY/4JUWGwBWMg0OFo75YIIppyWlThc7SGdbe2A3GV6vtCHR+nVcI7ibwZOpzPbYMmIA=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 TYZPR03MB6576.apcprd03.prod.outlook.com (2603:1096:400:1fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Wed, 8 Nov 2023 08:29:34 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 08:29:33 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "hch@infradead.org" <hch@infradead.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	=?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH] block: try to make aligned bio in case of big chunk IO
Thread-Topic: [PATCH] block: try to make aligned bio in case of big chunk IO
Thread-Index: AQHaEWF4GkJb+XAE0k6y5xfLSeBrLLBwB5QAgAAIdQCAAAiZAA==
Date: Wed, 8 Nov 2023 08:29:33 +0000
Message-ID: <bc49a687b001fdbd3eb11f3f8566b29ab5c796f0.camel@mediatek.com>
References: <20231107100140.2084870-1-ming.lei@redhat.com>
	 <ZUs4njXE7xpg04Yi@infradead.org> <ZUs/tsrNEZiHcCco@fedora>
In-Reply-To: <ZUs/tsrNEZiHcCco@fedora>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|TYZPR03MB6576:EE_
x-ms-office365-filtering-correlation-id: d5fa75dd-4ae7-4720-e3fe-08dbe034d62c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxXrGwKL3JjzfiYZSzk5l9S+/8HZXNqmX3NG7nbx318xqVnZNa6CUMQnkF8vUR2AuQ/3UfVMw5zAfasQca077LqHUKtqlL3AYTzpg9fOOJWI1uAn5nnl1Omk5PO7NQhv3O5TTtaBmvBrqYA9Uj+n0O1xtjh7ozHrfQrmpxbVMP9CPqTxHY7xKHsw8Sj+m2JWBkyIxralc2Wk4yK9dzIpbRzsFdTKyg7DFPNekn3QIgTLKHDo2ietnB0R65zuGCR+zxvKEPCPcdUE/T0lEMt2/QzaIvc3uKmwJXJtG1Iktrv8flGjptBj5Bk4Hrr5PHrMn3OtpozlTAcPXgJiyey6jVJ8QMvtX6hb8XEPF0yCxTR31WCZnCYZz+AOYCZBH2/X47JmIqhwO62c9QLlLbQQRTyW8J8Rsbpid6uw+b4CtZ4BBnVwy+kdwxmM9W5A44EJKvl4uTgc9PkHpxY7IORWrY0/2Iq+JERG4XKs2yiipr0AjQ4C60F4X8SMts2BblH66d3XVpfZECFe0Zeh/2Lxe3BlVGLNShbUpn6q9YLLh4cF9culTTpoSbFj65y7i1Tjkf+dSvS09q0dlg8yEny2ryZozmko+AC2bauSjhKZZWhQiTpvyzjdOP08KxkEVuf0RsOpyU9lwDoAD9GooMq/ooTaXQ2LMZ9hsTpa4bZLwzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(26005)(83380400001)(86362001)(38100700002)(36756003)(85182001)(122000001)(5660300002)(6506007)(41300700001)(6512007)(71200400001)(66446008)(66556008)(478600001)(6486002)(76116006)(66946007)(64756008)(66476007)(54906003)(91956017)(316002)(8936002)(8676002)(107886003)(2616005)(110136005)(4326008)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXFKVVRjb1Q1TW9rSFFVZUEzcXNDV1hmVEl3QzhXOElHd1FTR1poQmtQR3Zw?=
 =?utf-8?B?SEJndk9kME5zTmdtQk1Ca3B1Y3FOMXVVSHc0UE12bC9DRHFPOXJ1R21SVXFI?=
 =?utf-8?B?SjBlNGEvc1BJbnVva0F4Q2JqaU5tWkJWeUNTNmZaaFJXVGwxR1ZPbWcxalhy?=
 =?utf-8?B?NGl5KzUrN0UyL2dHSytXMFdlTTR6cy9jZ3F3c1RrekM4TE5pdWxuS3VSZml5?=
 =?utf-8?B?YVMyMHU0ZldKTlZQRWhyU2xJZWh4elJhYXY4cUlLbWFNN3liQjloRWx3cEtr?=
 =?utf-8?B?N1B1RWkvTlFBQS9Yai9YVUlmbzMzZ1BzWHpyNWNtVGNaQUx3MzYzdjRqSTJi?=
 =?utf-8?B?Q2I2Um5BVktCQisreldtajJkN2hJcU9LcGowVEIzR0ZkOGQ3U3JGNGFNUjdZ?=
 =?utf-8?B?NkVTU09ac3pXeWlaeXJpVjN5RDB5cWJqUTJFSWh4MTRNOEQwVVdBWFhkMHNR?=
 =?utf-8?B?bGhscndld2FlWUd2djZJL3dCOStNVUtyZW1BdVRnSnRaL2MvYTFBdFVYNE5C?=
 =?utf-8?B?YzFsYnh6WWRKQ2NXZG1kNzJtaTlUZHIwUVk4NEZINXBlaGhscHEwR0tmVnVU?=
 =?utf-8?B?OUVyMHRsbDdFVWNCNnJjc2RVU1UxdC96MjBjV3V2SzE0dkh6djFLSmYxc25o?=
 =?utf-8?B?YVMySlJCbkZKSUpRYXFXOUNKclZPVlluMnE4R0F5TWs2VzhzQ3pNTmUyeldt?=
 =?utf-8?B?b1YvN3g5T1RkL0lBVEsrMjU4T2NPTkNhTDZlUC8vQUY5TXppOGdDbjF2Qmgv?=
 =?utf-8?B?dWMxRmtrejV3em5IaFA2emw3YzNKUkFiUVdyQkYwQkUzbjV3aEJPZE9icG56?=
 =?utf-8?B?cjIxNUx2Y1F3V0pQYVFFMVhoVXpTblh6RzNpOWJUbnlkUkhHdm92RzNac2FQ?=
 =?utf-8?B?ZXo5U1lGV2srZVBxQTVQTHRUOWN2c1ZUcWR6UGFQWHRtNWh2aml3RHYwQTRN?=
 =?utf-8?B?MDRNUnRTMG96dlpoMWV3SjFFbitLMkk4byt0OEd2dkNVT3YyemZ2VnVBbWdK?=
 =?utf-8?B?RU5kYXI0cGR4SnROL3lVU3dmME15VW1NckROUmJiTjFudXFCZmxvWHVqZ25X?=
 =?utf-8?B?SE5teXdNR3ROTkhtS2MzMll3WmlDNXZ3M2h3cnQ4bmJ0NlZzVlRZZVdBZWs4?=
 =?utf-8?B?S2RMeElHWnNQMHJLUDQ2Um04cWhmQ09nUEkrWnY0SGphTUtWMWJ2V0QvWktv?=
 =?utf-8?B?SncwcDUvcDJPVUVTWnJFa2NPUERNUGt4YjdFRnZ5QkUycXVHY0lQS1U3YUtL?=
 =?utf-8?B?MDJRSjliYUJCUDBIamJXMU55OXYzZmE3S2lwSU5qQS9KTXNXUndjbkplMXAx?=
 =?utf-8?B?ZEFxZHl2Skg0R0l1V2NMM2F0c28zQlQwQmdKeFhZY2MwdVZPYmxxVVJHNE5F?=
 =?utf-8?B?cllhWERRUGxvUmo4RGRMb0JYbFREc2FtcHE5YUJlMkpKRzFESTM0Ny8vRnI1?=
 =?utf-8?B?SFdpcDBKVUJLR0hTOG4wYStVbHFCckZ2TFBPMm5paTBCcFNkQ2ZRSFNkcWQ4?=
 =?utf-8?B?UG9GcHNvOXlkRTQvNUlXcjk1clBKSE9uU1NsUWp2L21TR0hydG9Wa1ErUC91?=
 =?utf-8?B?cWZzUis3bnJHU1JTYllPOXZGNG55L3JYWE1SdzRrdkFvY1pFQitBOWFUQTRO?=
 =?utf-8?B?THdFUllEY0RLZnhmVFBlRnFVR2RxdzR1ZXhaOXRJQlBYdDI0MGZsR0Z1K2JU?=
 =?utf-8?B?YWd5bTVzWW02d2VNMkpVZTFGSk5kbVhzNmZsZTcwdWdtVXpxakhLWWRLalRX?=
 =?utf-8?B?NjQ2MEN5S0c1clhLR3VzMUZ6OXlaQjdEa2QzRVk2RzVWK2dDeTg4WEVJaXNu?=
 =?utf-8?B?RUVVRWFUZ0dXT3p4YURJWE52d3VMNy9tNXo4RmRJc1hSY2tDa201U2daZ1VE?=
 =?utf-8?B?WTIxbHdOUjB5eThtaWprdWpmTnoyLy9UanpqOVVJY1NKWlp4UW92WWtvV3Z4?=
 =?utf-8?B?SEMycnpURkxiNWsxT1lIa3ltM3FWblJqczBUZE02djJjdWNkbTMrUHFVTjNO?=
 =?utf-8?B?Tkh6Nm1qRFdXYjJvNTlwdVR6eGFXWFI0SkVwQU1henpZaU9YOHMyNUNvZzhw?=
 =?utf-8?B?Y21Sb0hwa09DS1hQcnVuQXpvYVdoSzhPRFhnbWFXeDdqdHZ0RXZ1T1NiY1ht?=
 =?utf-8?B?aGIzaGZZREVEck84V0NKaEg5Rmtqd1M4OERaMk1IU1p3N2trcXhRczdvOGxY?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <052EA11D35E07840B99D091A5A53A8D1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fa75dd-4ae7-4720-e3fe-08dbe034d62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 08:29:33.8692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtKMHSsagI9j2N6dpZOPAG9EEaviAGyjvv7vPzjJJvywPMjOjeUALWE12eAendX/G8NniyEyddK12Vhnb0s2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6576
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.495000-8.000000
X-TMASE-MatchedRID: oMBNC5/fKrXUL3YCMmnG4utL5wHKYQ1eUjH7I+o7mhsNcckEPxfz2Iu3
	renu5Y0wT4rvLmlL9qG1rv5o+aFbRNyWzJUF3XtlDB+ErBr0bANu95mt47DzNsi9AjK6C8p1klX
	Fl0/k6PnNQNpTNguIkHHpE9spLEtgSwBMchx9VNEU8KoqOcn2xy4tncCojEfcIFBEE5CFomLf2V
	Jhj/WJG+2nx5BJmn2TacATrwh4n8BlJTodqNqEztWxbZgaqhS0/Hd4CUWIS/EBWxwPU6jS0GDZm
	tamWR78LCS14oEMYCnV55op6HGBQn4FjWYN+jMvZlRzaO1xpJ0S12tj9Zvd80ENV4Lwnu7BfK8A
	MFnqwZi+ZhlwDZXRtSPzE4aYKBcuXm2hQ0tDETjXUumVyM1PnptnD30TfaKymyiLZetSf8n5kvm
	j69FXvKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7MKHstavr8xgErBP8dWdVv0Hq4e+YcIBXwbFJh
	abby1D7oReBXbRxsM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.495000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BE8D29949FEA2256AEFB6D80CB271DEC84E9F50DB45CC2E14711C901D20240692000:8

T24gV2VkLCAyMDIzLTExLTA4IGF0IDE1OjU4ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gIE9u
IFR1ZSwgTm92IDA3LCAyMDIzIGF0IDExOjI4OjMwUE0gLTA4MDAsIENocmlzdG9waCBIZWxsd2ln
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgTm92IDA3LCAyMDIzIGF0IDA2OjAxOjQwUE0gKzA4MDAsIE1p
bmcgTGVpIHdyb3RlOg0KPiA+ID4gSW4gY2FzZSBvZiBiaWcgY2h1bmsgc2VxdWVudGlhbCBJTywg
YmlvJ3Mgc2l6ZSBpcyBvZnRlbiBub3QNCj4gYWxpZ25lZCB3aXRoDQo+ID4gPiB0aGlzIHF1ZXVl
J3MgbWF4IHJlcXVlc3Qgc2l6ZSBiZWNhdXNlIG9mIG11bHRpcGFnZSBidmVjLCB0aGVuDQo+IHNt
YWxsIHNpemVkDQo+ID4gPiBiaW8gY2FuIGJlIG1hZGUgYnkgYmlvIHNwbGl0LCBzbyB0cnkgdG8g
YWxpZ24gYmlvIHdpdGggbWF4IGlvDQo+IHNpemUgaWYNCj4gPiA+IGl0IGlzbid0IHRoZSBsYXN0
IG9uZS4NCj4gPiANCj4gPiBJIGhhdmUgYSBoYXJkIHRpbWUgcGFyc2luZyB0aGlzIGxvbmcgc2Vu
dGVuY2UuDQo+IA0KPiBJdCBjb3ZlcnMgdGhlIHJlYXNvbnMobXVsdGlwYWdlIGJ2ZWMsIGJpbyBz
cGxpdCwgYmlnIHNlcXVlbnRpYWwgSU8pDQo+IGFuZCBzb2x1dGlvbigNCj4gYWxpZ24gYmlvKSwg
b3IgYW55IHN1Z2dlc3Rpb24gdG8gc2ltcGxpZnkgaXQgZnVydGhlcj8NCj4gDQo+ID4gDQo+ID4g
PiArLyoNCj4gPiA+ICsgKiBJZiB3ZSBzdGlsbCBoYXZlIGRhdGEgYW5kIGJpbyBpcyBmdWxsLCB0
aGlzIGJpbyBzaXplIG1heSBub3QNCj4gYmUNCj4gPiA+ICsgKiBhbGlnbmVkIHdpdGggbWF4IGlv
IHNpemUsIHNtYWxsIGJpbyBjYW4gYmUgY2F1c2VkIGJ5IHNwbGl0LA0KPiB0cnkNCj4gPiA+ICsg
KiB0byBhdm9pZCB0aGlzIHNpdHVhdGlvbiBieSBhbGlnbmluZyBiaW8gd2l0aCBtYXggaW8gc2l6
ZS4NCj4gPiA+ICsgKg0KPiA+ID4gKyAqIEJpZyBjaHVuayBvZiBzZXF1ZW50aWFsIElPIHdvcmts
b2FkIGNhbiBiZW5lZml0IGZyb20gdGhpcw0KPiB3YXkuDQo+ID4gPiArICovDQo+ID4gPiAraWYg
KCFyZXQgJiYgaW92X2l0ZXJfY291bnQoaXRlcikgJiYgYmlvLT5iaV9iZGV2ICYmDQo+ID4gPiAr
YmlvX29wKGJpbykgIT0gUkVRX09QX1pPTkVfQVBQRU5EKSB7DQo+ID4gPiArdW5zaWduZWQgdHJp
bSA9IGJpb19hbGlnbl93aXRoX2lvX3NpemUoYmlvKTsNCj4gPiANCj4gPiBCZXNpZGVzIHRoZSBm
YWN0IHRoYXQgYmlfYmRldiBzaG91bGQgYWx3YXlzIGJlIHNldCwgdGhpcyByZWFsbHkNCj4gZG9l
cw0KPiA+IHRoaW5nIGJhY2t3YXJkcy4NCj4gDQo+IExvb2tzIGl0IGlzIHRydWUgYWZ0ZXIgeW91
ciBwYXRjaCBwYXNzZXMgYmRldiB0byBiaW9fYWxsb2MqKCksIGJ1dA0KPiBiaW9fYWRkX3BhZ2Uo
KSBpcyBqdXN0IGZpbmUgd2l0aG91dCBiaW8tPmJpX2JkZXYuDQo+IA0KPiBBbHNvIHRoaXMgd2F5
IGZvbGxvd3MgdGhlIGNoZWNrIGZvciBhbGlnbmluZyB3aXRoIGJsb2NrIHNpemUuDQo+IA0KPiBC
dXQgc2VlbXMgc2FmZSB0byByZW1vdmUgdGhlIGNoZWNrLg0KPiANCj4gPiBJbnN0ZWFkIG9mIHJl
d2RpbmcgdGhpbmdzIHdoaWNoIGlzIHJlYWxseQ0KPiA+IGV4cGVuc2l2ZSBkb24ndCBhZGQgaXQg
aW4gdGhlIGZpcnN0IHBsYWNlLg0KPiANCj4gVGhlIHJld2luZCBtYXkgbm90IGJlIGF2b2lkZWQg
YmVjYXVzZSBpb3ZfaXRlcl9leHRyYWN0X3BhZ2VzKCkgY2FuDQo+IG9mdGVuDQo+IHJldHVybiBs
ZXNzIHBhZ2VzIHRoYW4gcmVxdWVzdGVkLiBBbHNvIHJld2luZCBpcyBvbmx5IGRvbmUgYWZ0ZXIg
dGhlDQo+IGJpbw0KPiBiZWNvbWVzIGZ1bGwoYXQgbGVhc3QgMU1CIGJ5dGVzIGFyZSBhZGRlZCkg
YW5kIHRoZXJlIGlzIHN0aWxsIGRhdGENCj4gbGVmdCwNCj4gc28gaXQgc2hvdWxkbid0IGJlIHRv
byBleHBlbnNpdmUuDQo+IA0KPiBJIHdpbGwgcHJvdmlkZSAnc2l6ZScgaGludCB0byBpb3ZfaXRl
cl9leHRyYWN0X3BhZ2VzKCkgdG8gdHJ5IHRvIG1ha2UNCj4gaXQgYWxpZ25lZCBmcm9tIHRoZSBi
ZWdpbm5pbmcgaW4gbmV4dCB2ZXJzaW9uLCBidXQgcmV3aW5kIG1heSBub3QgYmUNCj4gYXZvaWRl
ZC4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IE1pbmcNCg0KV2UgY2Fubm90IHByZWRpY3QgdGhlIG51
bWJlciBvZiBwYWdlcyB0aGF0IGNhbiBiZSBmaWxsZWQgaW4gYSBiaW8gYXMgaXQNCmRlcGVuZHMg
b24gdGhlIHBoeXNpY2FsIGxheW91dCBvZiBtZW1vcnkgYnVmZmVyLiBUaGUgb25seSBvcHRpb24g
aXMgdG8NCmxpbWl0IHRoZSBiaW8gdG8gdGhlIHF1ZXVlIGxpbWl0Lg0KDQpFdmVuIGlmIEkgZmls
bCB0aGUgYmlvIHdpdGggYSBsYXJnZSBhbW91bnQgb2YgcGFnZXMsIGl0IHdpbGwgc3RpbGwgYmUN
CnNwbGl0IGJhc2VkIG9uIHRoZSBxdWV1ZSBsaW1pdCBhdCBibG9jayBsYXllci4gVGhlcmVmb3Jl
LCBJIGJlbGlldmUgaXQNCmlzIGFwcHJvcHJpYXRlIHRvIGxpbWl0IHRoZSBiaW8gc2l6ZSBpbiB0
aGlzIGNhc2UuDQoNCldlIGNhbiBlbmZvcmNlIHRoaXMgbGltaXRhdGlvbiBiZWZvcmUgZXh0cmFj
dGluZyB0aGUgcGFnZSwgd2hpY2ggd291bGQNCmVsaW1pYXRlIHRoZSBuZWVkIGZvciBpb3ZfaXRl
cl9yZXZlcnQuDQoNCkhpIENocmlzdG9waCwgd2hhdCBzdGFnZSBkbyB5b3UgdGhpbmsgd291bGQg
YmUgYmV0dGVyIHRvIGltcG9zZSB0aGUNCmxpbWl0YWlvbj8NCg0KLS0NCkJlc3QgUmVnYXJkcywN
CkVkIFRzYWkNCg0KPiANCg==
