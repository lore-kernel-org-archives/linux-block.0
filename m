Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82663B785
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744292; cv=fail; b=NfISkP5XOC/thxeDSMShgOpRLCZIt1PhxVYH2BoDb60kgo2HLZ8mntwpQXuVl2brVcllEmeBgYvjG5QoTPPt+c/ydTxqq3guQVRgAwSRC2aDj/Ni8R+fviVplUVPh/i0VcCSpKBI2HXWe4nGpb0+Kt76ktKXoyG8/QCVCK9sLpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744292; c=relaxed/simple;
	bh=QZQI9DYBCaN74O51O0+TMagFLEs3r3Hm7xeHoNR7tJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JKEUxvq7qZ7ONknIZaoh4827lTGIwLnR/Sti2UbTZ+xDzxnKpYSJXk1m0REgRrmHFCPYadnRTjsJboQ8NeIBZD+9E/8oHRRmhHol9LXpN/283uMYoPrXaum+kY3sX4vxTdUrC3uq/5H7rIOsgUEWSQw4sTdzhX7WDLUSwTrmkLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hZdfmPcy; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hZdfmPcy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKwGb0XLzblrhw3FePhRzmNWhwuE3GSYRDLBxEczPs1oOp4TVoUC5h5SDBGN4fcmvSPbQ4P584XG4hqZyhFK8x6Ty2rVSRqQ00ulPmi9zvb43j8mdoRdCsgaWlR6UAHbgVsBFG4PostV3caMixr2csuQ9HfRQRFHGQdDlB+yFnVAzQBH8Iff/bOyZOO9U0Bfo8wuTHcey8X8mK8/Sbv8B5rApmPjE2YqU2+6p0DgkJOtW9DesUQMaF5zHZzRclmNOlayaB2zhE/0sj2xQr+UDorfSUHFuIPeB8hobu4JhBKIQDoMChzUlYKDdoCXo9fS08cREcp7LmePL71mlYPkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZQI9DYBCaN74O51O0+TMagFLEs3r3Hm7xeHoNR7tJM=;
 b=Qb/mc4AWVfpXHa6MKZNxGfkyJU/0ZskCEB0g8m/BQG8b3xsp9iSZ3E1RqKrY9s91ADq76oMqWxlLUiH4fRG/e14pcM6adxg/eZUJNRdLW747BYovc9abacCD1mF0BiDva1qVy1TISXyYJYqbvdhRMdPHiv7EqSJH6PRJG5Y98DKJjoWp2gAWu4Nmn2lyp5a/RNDHE/6fB3084PR23/fUsOGbm0oxw/nUPRP7J5AwAG2Ezq5eHZp01Pocxy7nWrpVzUKN4lZMOIRXF56v2W8r4kTzQ2EGsVwGr3hRylFt4huIgAJf+L/C84MNY4QLKq3a1IFpmPayhiDEUqblJc7Rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZQI9DYBCaN74O51O0+TMagFLEs3r3Hm7xeHoNR7tJM=;
 b=hZdfmPcyJXvYAzluQYkQ6g5IHmCIGYBYf2Xu7eQ4mhbTfsPaeB7AuVgfwFhMNYmlU3wTis3y4wQN1+SjNHpi0stkDxCsH1pQM2W8CRqpoVST3ulURt5cJQIw2y7tEUMgJrNczHq2zuFuCTbEuoCRTdZGZIGGeAgQDQi6X1qSDDyCz/D6DWrunwiBPXbAZ2ykbTCDmcunSGjMiOYIO/91to5SZaX/P5LnC24tRxNlzKLnXhILEuSGnTQNAY48eERr3HeapXaeQQCslidQ1W8FCplJeVmNdJepgHRydQm2yV5fSvp3jQOxfqCh26AMFcwx/8O1dijZQ8LjXFQTQIbVkg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 23:38:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:38:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH 13/14] loop: pass queue_limits to blk_mq_alloc_disk
Thread-Topic: [PATCH 13/14] loop: pass queue_limits to blk_mq_alloc_disk
Thread-Index: AQHaVEYpbEaBuBRJqk2b6NZY/Ut47rD0lImA
Date: Wed, 31 Jan 2024 23:38:08 +0000
Message-ID: <85caf1eb-b950-49f7-8bca-515a8dcfeaf6@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-14-hch@lst.de>
In-Reply-To: <20240131130400.625836-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV8PR12MB9206:EE_
x-ms-office365-filtering-correlation-id: ea582f51-e093-4f3e-941b-08dc22b5adf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 whTo+s7nw5rl8P0kGeYV0eIucwMrMkLhD7ONDrq0O14lB9eXyOo+vIz1uWnpHqpUtqrrV35FoHR9r50V8QKszQki0N8jHsj9tB76qzCsmJKx0PefLUzU7pcBJADnDrVTdWyX9MA9FyhCRy9BqNbUR/paeRpLTHcYBHBwc9fiGIaSuldIE6EDh1AuNXnFrX9a/xMq6BCS2XtunUSl6u4uVKj/xpv/GoKo4MK1iY4bmiqDN4niNahduz3SP+32T/RwHQAhEh9TbJ7QR1dfiEVoJJS5wO1M03lglRXayEYRs232XqV+B+eIfYmpO5ZoUZ4WS2Sn3ahS+/Sb/lgSrplPLFqG51KGm67DvXl3QN+XBKfcMQO2mt6Ah57rpLreaCQQ0B/jL2K7+LHYFXGKg86BuiDKk5BoirID6onyqWU2wmvqpAt4yavNmYzCHsKvRzRvUYpmX/xQo81pDCkNUiuAo/3KLWmfmV61HueXhIymgHX6Wq6AIqeze9AHgcIuEgiEmQxs7JoSFRHOyc9DzpV6wu5BxNgTX2JxSW85421Xs/sIBmbbP34pm9zouGeBKNsb3YvbuxNTV7s8AqFs9blF3cdI/RoIj2WIeEnng52NsPJHLnPPkTih5ttz/HM92hMrSTEE3ZDxta01ZjkRkzfI9NSuhvH+y2+5OqvdtRv2PNTEtE3pZ3Ji44g2nlVVk7SC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(2616005)(41300700001)(66476007)(316002)(54906003)(66446008)(38070700009)(36756003)(478600001)(6506007)(6512007)(6486002)(53546011)(71200400001)(83380400001)(38100700002)(66556008)(122000001)(64756008)(110136005)(2906002)(8936002)(31696002)(5660300002)(86362001)(4744005)(66946007)(76116006)(7416002)(4326008)(8676002)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHlqdVcvVWwxRWl1QW4xaWtYblNaZU5sRFlFTjdRNXA4S0JhY0xreFViS25W?=
 =?utf-8?B?K3lLWWhLLys1cHVEUmJuRXZ5RjRpOXRzVWt2cGlFWVgxQjJVcXliSXJiaDV1?=
 =?utf-8?B?NDhObUZoNHllM3Z1RTdxaW1iL0gwRURnMjlyV3l2a2RPbUFVaHJLaC9IZTJK?=
 =?utf-8?B?dmYxTERUcEdrU0N1eFpCS2hETzJUODB1WnR1YWZGMDMrZi8wcjM0ZDRxb0J6?=
 =?utf-8?B?QkV2ZHU2ZXRCbnZNQm45U3dCVUR5c2RCUjNPellmd25EdHBPWmdsalJaRGVH?=
 =?utf-8?B?RlJwdGZUS3ZGMDZOMzhnSm1CcHhiVTlxUWI1NEdvb2JzWjRuTUZwSFlYR3Y0?=
 =?utf-8?B?c25wVXZqS08zUHdvcFY1OFZWQ290YVkwVFlZcGdWZUVrMDI1Vm9CMU9IaDA2?=
 =?utf-8?B?enhtWDdUWm12MFE4SzZMU1FrWWw3THlCeWlHenV6SXorQ01IS0pRTitMd0RN?=
 =?utf-8?B?UExMWHVYNnhKQkYwakhyWVl4ZC9ZcDNWSVl6bmI1eGZUNmhuRlllMDVoKzk0?=
 =?utf-8?B?bkdCTFloZ2wxc292TUFnWkZaUG5WME1nMzAvbUIzZHoycGpNbllwdmVnVDlr?=
 =?utf-8?B?bmhoRjFSdmh0Z0tlSU4zZVlselEvOThYY2IwZ01zYjRFMFc3dW96M0pWam1W?=
 =?utf-8?B?a2VTY2hIVTV5UEpuZTNnQm8yV2ErVkwvZ09WMkVsUWRSZFRuenV6VXdrRlFJ?=
 =?utf-8?B?cHBCUUplS092R0hVSmFqYld4Z3FUeS9HV0FtYUYzYUFhT0JpcG4rSkwzeU14?=
 =?utf-8?B?UEJJNGo4d2UxRmpxSyswa3VGVXNrN04vc3pLenQrUGNCYVF0MUhDTG42Y3V4?=
 =?utf-8?B?Uk9JekpndVdWQU1hV09XUFZOWE1UMXkwZEUxUGxsckFqTXBsM2lXdWJwNXRL?=
 =?utf-8?B?a0c4Zi8xS1RKSDB6YWNMSHh4Q0RWQ2NNVzNvUFZmU2U2WC9NQXVHN2ozRTBr?=
 =?utf-8?B?T205M0NxTmxiY2pRampQNmUvSlR2Syt1V2JLWFZGc2krVW9SenU4SHNKeGxF?=
 =?utf-8?B?cExYNnUrU1N4VzMyWkxQb3N6SytqWmZCRFVkYlBTTmJrMjBVS3NKblFta3ZL?=
 =?utf-8?B?enlhQWFzbFg2K0x0ZmU0VUoyRzlDTGRQQ0hkVTVUN3EwdEk4WjF3WFhaaWxZ?=
 =?utf-8?B?MEZVSm5KUWFEWHRwZUJjL0pCZDNGaWc0bVZBRXh6eHN3RWwxL215MUkxeEF2?=
 =?utf-8?B?VE1jejB2cVJsZzhiMFNBSGNPL0M2VnBmYWdqWkJTSkpyNGIyK2h1Q2JEMWVq?=
 =?utf-8?B?OGtxbTVBT0p6akRqd2FQRm8yTTc4SlY3aTlBNDRldjNVRlJVbFB4ZHU4bm9S?=
 =?utf-8?B?NGZIUTY4VXp5N1hNa1g5aTNMaHlSSzU3Y3YzN2hSRVFjZ01iR1BOa3ExOEF5?=
 =?utf-8?B?L1pJK2haaWJ1M0FWZ3Exc2U2ZXRnVFk3SWdOemZnandpOU1vbTgvdGIxSVNQ?=
 =?utf-8?B?WXVKVXNHRlVBNStiT3hYcHNKenZOVWgrL3dSek1KWkRXbDA2aGZXR29sVDZF?=
 =?utf-8?B?WnNEMkxBdTgwWHhzMDBQemdJd1hxVm4xNVBScUpNbUJOUHRCLzR1azR2OVlY?=
 =?utf-8?B?Y1ZGeksvb09CVFp1c0I2eXkxemxQYk5BNWZ4c25GL1dQbjVtVWo1TU9TUnoy?=
 =?utf-8?B?Qi9aMThxRTFDZ29sVm9xKytzdFEzNEhSRVZ1SVNFQ0xReUhaQkUxaEt4a2xJ?=
 =?utf-8?B?ZW5rZ0FLdW9PVG13Sk9wV3V5Uk90OGQveFpRTmpLMGlkNTFCNnFBbGdKRHFS?=
 =?utf-8?B?R0h1RkZzRFp0T3hQTUJONWx0cWFiT1FaaWdVeUY0aEhSMkpOVmUzTjd4bmIw?=
 =?utf-8?B?cCtUeTR2ZENwMWZpUWJHTkgxSkt6YlQwcVc0KzM0UUxyVFFpb0QrWTMrR2sy?=
 =?utf-8?B?VDM1dVFaT1phY01XVjcraWVWVWs1ZWtuNUNPbjZMZUJ1aFQzS3dURExQTU10?=
 =?utf-8?B?YzJRdjNhUlhLelpMUTllUG92R0tWL3I3eU9tbDZmcWZzQS81N1BJMWcwNGRJ?=
 =?utf-8?B?cHVXUUtkRnJGYUJaQStjU0taTExTbEM3U0swaVpHU3YxT0NWNWJpNW82SU4z?=
 =?utf-8?B?em4xQXRNbndQbUhuc0ZKZlBuVDk4ZU9lVmdpVnY5cFJCUEp6Z0tSenJ5Vnlv?=
 =?utf-8?B?WUdiWmJ0aklUT1gzQmRUZUc1ZFZ1Mk8yemp3VUJCVFBqM1ZqWWJTNGNndzVr?=
 =?utf-8?Q?E0Sqq+UadRt9CitKZaPbWpPFRPK/+7IexC6TKbPCAgCb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A57676C07FBE174FA952E7E18C6AEBBF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea582f51-e093-4f3e-941b-08dc22b5adf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:38:08.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHHjNz9DNvQloiLBNWI/hIGP08QKYIXS2QBRroNXt54pODG13FwcBbCjDoN+c6Xx34kWelQwfG9X2zrymJW6ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgdGhlIG1h
eF9od19zZWN0b3IgbGltaXQgbG9vcCBzZXRzIGF0IGluaXRpYWxpemF0aW9uIHRpbWUgZGlyZWN0
bHkgdG8NCj4gYmxrX21xX2FsbG9jX2Rpc2sgaW5zdGVhZCBvZiB1cGRhdGluZyBpdCByaWdodCBh
ZnRlciB0aGUgYWxsb2NhdGlvbi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBr
ZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvYmxvY2svbG9vcC5jIHwgMTEgKysrKysrKy0tLS0NCj4NCg0K
TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==
