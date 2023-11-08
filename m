Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B807DDB4
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eGeV3eBL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nFTUDYUR"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB23170A
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 00:22:18 -0800 (PST)
X-UUID: ead970667e0f11eea33bb35ae8d461a2-20231108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lcg4zaj9dyfV+/dhqyQNWArIlmXdQfyuLcKPVsVG4dk=;
	b=eGeV3eBLdquc7zUlS/V4lp3y0ECPbTPDfQynLceSZ1Q+W1/JPBnCAmOiZX9WC8Q+XySndOMzvzu4/qT3nGD56snYVWZ7LwqoucXV9TdfoH8y/diOXPTJYVENaCWDHcwe9Wd5rW/kXLOjCukLLvDsNVR0gQprDGr3CR4D7pA8ZSE=;
X-CID-CACHE: Type:Local,Time:202311081536+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:83fb1c1b-62c8-4e93-9d21-8923b1f7edbd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:86672695-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: ead970667e0f11eea33bb35ae8d461a2-20231108
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 835033472; Wed, 08 Nov 2023 16:22:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 Nov 2023 16:22:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 Nov 2023 16:22:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjApv8shrPkS8y2JHFVWQrUJr+GcmM6KkgVj5PNy6NMPnVB7fEuQw8FTh8girSF7jUy8V4bRXpU7T7usIRiI1IxaqExD3xroxveh2q5TjutpgVeIuuJ86NkFzY+QjvIqdiQpWTJVlX45EncPDuwewPQI7JzXHzHMpaBLO3/eUjNh2dqQg7TsOMmAeeTPKRSlShvjTjcj12zZ+vE+0Wv/f+c648kRbDL+qNdtxdNHrP3ctVCsnKM6FV1qhac8Ew5bGZ2A23UR8L+r1l2Az7aqcRpMzZA2Z3xIYmSFodCb5lXeLb6pZ9Ff3TToYRnMLTTJY3xZYQu18VPxZREDQplIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcg4zaj9dyfV+/dhqyQNWArIlmXdQfyuLcKPVsVG4dk=;
 b=QLdwpO3R7uEVQkS7vvkCHzp3aQcJUEB9OdULisl7zggWm6+yxPkuwagcDl1WFdZ3/BR/Z9xH8ot1M92LlErSK+u2m8cu0IQNJzsWka4/5bpY5C4Sf9e5eAWL2Q0ZLKzYGB94wjlD55X3dTx3kVgORfKddX7LQ0t57Ci/xhifKyq3DY6n1zKjstyL2ssfHUUzpfsv+Op4mj4Lhsu8Br8XzApVoj9adNby7Ucfk0uJ124a+FZScj3GjFGXSF9BGUdgw0zqdY1ZYj8WGVHw648+djrzN74o6k1euQ6+HVt76yCJ2zybzwN05g0UeJqplO8gAEE1P0dlD74swYJ1CRYBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcg4zaj9dyfV+/dhqyQNWArIlmXdQfyuLcKPVsVG4dk=;
 b=nFTUDYURTfjrQXQrxS7WttJGpxa+r9hJWgrI+JmKUvk7i6F7QHTjCT82nq8rgow54RkQ6fgd3BpxESrrolI5zNIUN7usSazPVxc4+3tjoR2LTX3nv/u2E5WA7Zv8/mvzsKIjEMQf7lpSnhuP4p4RoTps8QblFapPEetsx1ADEiU=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 TYZPR03MB7769.apcprd03.prod.outlook.com (2603:1096:400:425::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Wed, 8 Nov 2023 08:22:09 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 08:22:08 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "hch@infradead.org" <hch@infradead.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	=?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH] block: try to make aligned bio in case of big chunk IO
Thread-Topic: [PATCH] block: try to make aligned bio in case of big chunk IO
Thread-Index: AQHaEWF4GkJb+XAE0k6y5xfLSeBrLLBwB5QAgAAO+4A=
Date: Wed, 8 Nov 2023 08:22:08 +0000
Message-ID: <87ba0013ac8380a0331762b4f1dc117beeb4369b.camel@mediatek.com>
References: <20231107100140.2084870-1-ming.lei@redhat.com>
	 <ZUs4njXE7xpg04Yi@infradead.org>
In-Reply-To: <ZUs4njXE7xpg04Yi@infradead.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|TYZPR03MB7769:EE_
x-ms-office365-filtering-correlation-id: f5af3d15-6eb4-4c92-1e23-08dbe033cca3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQMLdgp0421InjeO4IzFnj4OcASO2SIxn+6pvUaDvr/B9aA26NzPD2D5DOI3yv3E2jI5IE8iTGs8zydOojjp5iLxoH+21/x+lnys94WBMxA0b96xyctelcDFyTa7idgA43Lk5Hqm8d10sF+y2rZLnMfwC7HfEa2yt0cAxnj56/efzAD4ip63fo1MuOyIdFm9r18kHfDQskDDYg0spIJU3ytSOaGUX0apotI3eQ2P2zZMy8e8inBL/ZRA/SQmWxnRqXTBbMEUeLY07jIVBGqR5k0Vfvn8U/qFLl8FbIUQGl3HVpJ0/ske4Z0nl6iMaw6F4EDTg50uNUGcfMuO10vyEgDBA0J8+49f83REkJowUNshnU4kOakHjSS7YGbYOSAH9KJiue2uW5v1MTbeHnmfCCfPlV6S2qxJSjCx+4qUilfexmfmvIAsEDQbHplNMmEExug3M0x5X9HNGMHH2gyuNnw9tRNY/zNsaSDw17tu2IxmXCBwjA30r7BfmJ3hCIe6oH+7IqppO4ItOSGzrRSP5k+mNhi4DsOSj6X0J929Jqz+vmdoD6wXeA18MdXDrcukru8EAkL6WLUCNTmrLX574GFCdGDgaVxHlJIIHgrbKBOQ4ZWSkBcM76dVwPIbB2ubC+ZOtsTC64T5k2W/vWSxAVP10NHEF2JRJxIAV4VOBnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4326008)(86362001)(41300700001)(66446008)(2906002)(5660300002)(85182001)(8676002)(38070700009)(36756003)(316002)(8936002)(66476007)(38100700002)(122000001)(66556008)(54906003)(66946007)(64756008)(91956017)(107886003)(26005)(478600001)(76116006)(110136005)(6512007)(83380400001)(6486002)(6506007)(71200400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWxDTUJDMnZ5b2RGSnZoV0M4dGEyR1BhbTJWa0RzYVFYaXdMNy9GUUxPSkJU?=
 =?utf-8?B?YklMWG4xVVRyNDJmK1RXM0RQcG5nZSthTHIyK3huQWFvTFdiV2pJMk9DdXNi?=
 =?utf-8?B?a2lqczlMOGJYeUhrckFmNlhhdWRPeStuMENPTHVKQytKWHh1UGtFY1RoTDg0?=
 =?utf-8?B?bHBZb0FRQWZiWUV1OWpBRnh4eWJuZHU4MGVDV1ZsMVB3clhacjJXYlowNDJi?=
 =?utf-8?B?M1A1aUlFSDFDQmJOTTJ4Umg5Mi8rMzhFNEVvMnNlRWhIZE82U01hekR6YkpF?=
 =?utf-8?B?WFR5RmduOXJ1aGYrejZkOWJKSDA2bjZlRmlqSXlEb3VpelhwbllmNTZyUUV2?=
 =?utf-8?B?QXFvMENtVm9GS0RESXpUc1VKMExVZUtCR3lFSzJXZjJGMFR1NjZtSmhHcENL?=
 =?utf-8?B?WG50K2VWcWJaWU9haEhLWktuMUpNUkh2bDcwY0xRTTI1V0FLWDFuQW1tU0F6?=
 =?utf-8?B?M2xPS29ZVU5FNm1Nb0x0cjlZWDhFcDAyVFNjOURTNWZsTWlpMEdJdCtkOE00?=
 =?utf-8?B?Q3Jwbi9SelhHeE4ycDlQaldBenRzbW51QXNLQXRBZnl2OVFGUS9sclRjdjZ1?=
 =?utf-8?B?cHJUZ1lOUlYvdVRVaEtGTEJFcVhhWktTVW8vRDN1ME15NjFKMUttbVJEaWh5?=
 =?utf-8?B?N2NNZUpoV3k0VzgvMGJNaDFPbG9hSG5wcUdCekdONERmUGxnQm56TTViWFBT?=
 =?utf-8?B?QWNSeVBZTkU4STBPN3ZyWmJhZ25Na2hBQlo5alpHVlQ2MjUrWmk1ZjVrTXlV?=
 =?utf-8?B?MURHamlWSFdMK1F4dUUrZjJ0WFg0TUZzSjYrT3k1UnE0QkJWQU5ZUzZBS09w?=
 =?utf-8?B?em54LzJ3YzlrUFJrdmRDSWZNUmt0cXNiYW1mWW5BNDI1akFZNzBKRmsyQ1JH?=
 =?utf-8?B?NndpTGQycGZLR3p1eUROcGlUTUVOT0tpKzRXbmNJSFp6aXhBK0h6WGlDUkcw?=
 =?utf-8?B?clR0bmdUMHc1NnNxVmJ6Y3ptcndpSkpOZEFScEZjZDNYNy9EdkhWUlpLbGpm?=
 =?utf-8?B?UDF2cFF2azJtcEZqUy9WbUlFdkREUlVnVFBQWjhzbmsyTE1acUViZlZBYkZR?=
 =?utf-8?B?aDBSeEFSOXdmWFNrTkhMbVNEZ3NjbzJwT2Q4RG44Sk5iL3ZxQ3ZRL2J5NmF4?=
 =?utf-8?B?THZVVVlocjVXYTlKRW5Nd3FSQnVtT3llNjhkdnFtb0IyVTlTYVNiMnZIVUkz?=
 =?utf-8?B?dGhLRUhLRi90bzBmTk1GSEhBdmxZSjRMdmIzWjR2ZkdWR1BIK1hsUjQ3LzNW?=
 =?utf-8?B?cldRVUNmaVRnRzAzZW5abEdFdXNWeTFGTjdRYXRNcXNUT3R1b2RFOHp4T0lF?=
 =?utf-8?B?SkFBNUxXbk1DMXJVVW8wM09MUHdmcmdaM09IcEhKR2IvNmtJWUFpd2I1ZmVF?=
 =?utf-8?B?UlFjWGlKbDZWc2pjeDhRN09GZFcyTlp3M2xLQW5KS1NhS3B2d1p3NzJGL0xB?=
 =?utf-8?B?ZGVwaHhvcXNtUjRqYjdVQ1NFV0NrNHpzcWhHMWtkbjVuRVBUOVVwMDIrNC9G?=
 =?utf-8?B?WGVlWVY2Tm1TdnVKaDNtd1FNR2lneGlGc2V0RTVxMmZRdWgydEl6T04rSjcw?=
 =?utf-8?B?Z1F2SVBWZGR2YkdLUXlJdHg0SjEydlkrRUJRS2JMT0RUTXhUN2t0RHMzVnZX?=
 =?utf-8?B?RDBmSEhFcE82R2V5K0xyTXFYNndHZ3hGb2NXa0ZHYTRpTmUxMGl4ZTM2Szl1?=
 =?utf-8?B?em9oOXkzcFM5ZDFuZUNveDJWTytYL2MzZWo5MVQ3WmdGUU9PaGhvWnlzaS90?=
 =?utf-8?B?U3ptS2R3clZQNG9lbklWWE1VdXY4VmxVR1p6K3o3UTY2ak1SUnB0QU9jZC9n?=
 =?utf-8?B?T1hYUjJkSTBTMmZ4U0gxejBMeU0wRUpvaTdFaFZzUG90Vzg3RkhOdFBtZXZW?=
 =?utf-8?B?VDJ5aFBuRU1WK20rR09FaGhtUWFLVzgxQXN6OFNQOWlZWUoyeGxySlh4NlVm?=
 =?utf-8?B?dm5tVkNsV2ZLVlg3SWlpRm1xVE82ZkV4a3NGUXdES0V4dWtiTVMwTkIrb24v?=
 =?utf-8?B?bktaR2NMRHcrZW02SFhvWE9RQ2E1YksxL1IzK0ZXOEVQb0I0K1c2RjBiUStE?=
 =?utf-8?B?dno1Zm5IRFZLQjdLaHFNd0dkRU5FV3JIMjlDdHRCRmp4eFcvdDVMZ2VMRFNt?=
 =?utf-8?B?dHpYMEt3c3JqY241STREREZ1MWpScUdTbGZ2dDBQcjBsL2FkcGlWWFVCWFFr?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E581C386B18CC44B82BCCD66DE93021@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5af3d15-6eb4-4c92-1e23-08dbe033cca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 08:22:08.4227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YH6kCRMB0cSRf3FzFbUbEvVUbvefgIyrV1+SGjL7O37svM+2C4KD5cV5T2NVi6RBPuXmn8wGUxjqyIZp8r8UzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7769
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.378400-8.000000
X-TMASE-MatchedRID: GBgFBUqwD4HUL3YCMmnG4utL5wHKYQ1ejLOy13Cgb4+qvcIF1TcLYD2m
	H2v5qbOTmNfYu+WBgqS1rv5o+aFbRNyWzJUF3XtlDB+ErBr0bANu95mt47DzNsi9AjK6C8p1klX
	Fl0/k6PnNQNpTNguIkHHpE9spLEtgSwBMchx9VNEU8KoqOcn2xzGZtPrBBPZrQQ1XgvCe7sG3DI
	h4Vmbze+swrbLbp1FuBhAtLgznpMynuow8yO9bea/Zw8tRb535ou/UrlGog/Kd2m4WouwOOKPFj
	JEFr+olFUew0Fl/1pE9wJeM2pSaRSAHAopEd76vxpGsFVLOgrE0AcOIQpC5Qjr47h6ruq/BvIb3
	F9fjH5935pbLgzXCRw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.378400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4AECFE8F998CC642CD23FC8289657D1178D39B0F610E2EAE705331FECB4C034B2000:8

T24gVHVlLCAyMDIzLTExLTA3IGF0IDIzOjI4IC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIE9u
IFR1ZSwgTm92IDA3LCAyMDIzIGF0IDA2OjAxOjQwUE0gKzA4MDAsIE1pbmcgTGVpIHdyb3RlOg0K
PiA+IEluIGNhc2Ugb2YgYmlnIGNodW5rIHNlcXVlbnRpYWwgSU8sIGJpbydzIHNpemUgaXMgb2Z0
ZW4gbm90IGFsaWduZWQNCj4gd2l0aA0KPiA+IHRoaXMgcXVldWUncyBtYXggcmVxdWVzdCBzaXpl
IGJlY2F1c2Ugb2YgbXVsdGlwYWdlIGJ2ZWMsIHRoZW4gc21hbGwNCj4gc2l6ZWQNCj4gPiBiaW8g
Y2FuIGJlIG1hZGUgYnkgYmlvIHNwbGl0LCBzbyB0cnkgdG8gYWxpZ24gYmlvIHdpdGggbWF4IGlv
IHNpemUNCj4gaWYNCj4gPiBpdCBpc24ndCB0aGUgbGFzdCBvbmUuDQo+IA0KPiBJIGhhdmUgYSBo
YXJkIHRpbWUgcGFyc2luZyB0aGlzIGxvbmcgc2VudGVuY2UuDQo+IA0KPiA+ICsvKg0KPiA+ICsg
KiBJZiB3ZSBzdGlsbCBoYXZlIGRhdGEgYW5kIGJpbyBpcyBmdWxsLCB0aGlzIGJpbyBzaXplIG1h
eSBub3QgYmUNCj4gPiArICogYWxpZ25lZCB3aXRoIG1heCBpbyBzaXplLCBzbWFsbCBiaW8gY2Fu
IGJlIGNhdXNlZCBieSBzcGxpdCwgdHJ5DQo+ID4gKyAqIHRvIGF2b2lkIHRoaXMgc2l0dWF0aW9u
IGJ5IGFsaWduaW5nIGJpbyB3aXRoIG1heCBpbyBzaXplLg0KPiA+ICsgKg0KPiA+ICsgKiBCaWcg
Y2h1bmsgb2Ygc2VxdWVudGlhbCBJTyB3b3JrbG9hZCBjYW4gYmVuZWZpdCBmcm9tIHRoaXMgd2F5
Lg0KPiA+ICsgKi8NCj4gPiAraWYgKCFyZXQgJiYgaW92X2l0ZXJfY291bnQoaXRlcikgJiYgYmlv
LT5iaV9iZGV2ICYmDQo+ID4gK2Jpb19vcChiaW8pICE9IFJFUV9PUF9aT05FX0FQUEVORCkgew0K
PiA+ICt1bnNpZ25lZCB0cmltID0gYmlvX2FsaWduX3dpdGhfaW9fc2l6ZShiaW8pOw0KPiANCj4g
QmVzaWRlcyB0aGUgZmFjdCB0aGF0IGJpX2JkZXYgc2hvdWxkIGFsd2F5cyBiZSBzZXQsIHRoaXMg
cmVhbGx5IGRvZXMNCj4gdGhpbmcgYmFja3dhcmRzLiAgSW5zdGVhZCBvZiByZXdkaW5nIHRoaW5n
cyB3aGljaCBpcyByZWFsbHkNCj4gZXhwZW5zaXZlIGRvbid0IGFkZCBpdCBpbiB0aGUgZmlyc3Qg
cGxhY2UuDQo+IA0KDQpXZSBjYW5ub3QgcHJlZGljdCB0aGUgbnVtYmVyIG9mIHBhZ2VzIHRoYXQg
Y2FuIGJlIGZpbGxlZCBpbiBhIGJpbyBhcyBpdA0KZGVwZW5kcyBvbiB0aGUgcGh5c2ljYWwgbGF5
b3V0IG9mIG1lbW9yeSBidWZmZXIuIFRoZSBvbmx5IG9wdGlvbiBpcyB0bw0KbGltaXQgdGhlIGJp
byB0byB0aGUgcXVldWUgbGltaXQuDQoNCkV2ZW4gaWYgSSBmaWxsIHRoZSBiaW8gd2l0aCBhIGxh
cmdlIGFtb3VudCBvZiBwYWdlcywgaXQgd2lsbCBzdGlsbCBiZQ0Kc3BsaXQgYmFzZWQgb24gdGhl
IHF1ZXVlIGxpbWl0IGF0IGJsb2NrIGxheWVyLiBUaGVyZWZvcmUsIEkgYmVsaWV2ZSBpdA0KaXMg
YXBwcm9wcmlhdGUgdG8gbGltaXQgdGhlIGJpbyBzaXplIGluIHRoaXMgY2FzZS4NCg0KV2UgY2Fu
IGVuZm9yY2UgdGhpcyBsaW1pdGF0aW9uIGJlZm9yZSBleHRyYWN0aW5nIHRoZSBwYWdlLCB3aGlj
aCB3b3VsZA0KZWxpbWlhdGUgdGhlIG5lZWQgZm9yIGlvdl9pdGVyX3JldmVydC4NCg0KLS0NCkJl
c3QgUmVnYXJkcywNCkVkIFRzYWkNCg==
