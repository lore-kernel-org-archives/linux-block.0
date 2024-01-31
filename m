Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243304878B
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743930; cv=fail; b=ukC9lgK9mI9Cf15apbntIwlNBBhYb+7d+28i0M0epxY0rwIMDfzir1UnEn8/UrGgG505HjCsRc8phaigqYkQnNcblLK1jjWnLqFQvAiAv+uEe5Utz0MaU5XHMn/ZDVaslREpMpjNC3CP+Fy6z3zZa350iF4PSxiPSCzPixYCVHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743930; c=relaxed/simple;
	bh=5z75qLN3yFxTH7p2/Go/ZE+vYK+ZW+oo6YutrEerjos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MzDroARx2P0I6bdNLAOvZf71BhbSUKg+br+itXpz/OESW0X7MOPnzbhHO1gQOgK/Nx7I7keO8/Io+KBNKPq4ucIHKXUvLEpOBwuWw3xKdJTHH2rjTY9zBZ+3eGxo6v5nSMHTq7ebwJiuS0724BX1xFi1narfqIaDmzzRI37n8oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SUOZkfKA; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SUOZkfKA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQVZWmuFc9nho/pDbTqn/UAH7pdTte95LqI4MB2O9ZZACvjZhARXfmLOglsNbtak9hIKcUWpoJdJraj2W5urGa4NgASVa+zyT9E+uXH2R1Z4INgPI0g3XQqU9i3esGE5Xb/NJLIS5ayYtPZU70dqL47iA7zgk2gslOs3S2X28Hy8k3oV2TLywFNzhlT3pn3enrTwYT/WIbEi9my+80ACDJkDFPVo/MItp216FcwT4nZ2YWZo6qR6U9GlFj4hnPEsa3sSxjCT9du05vhbzWA9/YO4oOkl+foXZaZTkSmPu4ciCU7+6531avX5MPBX6vI2HGX0s5D/j4sxRzCN9CK+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z75qLN3yFxTH7p2/Go/ZE+vYK+ZW+oo6YutrEerjos=;
 b=P6ZMBeSfV8N0dgh9I2NLEKNdhF3LM6aL2CxWoFHEZnDegS5p8vEOZwdKz+leRaXeYzSQBsg/zPKnErUd3B4PdtqGKnLEc0dQ99gSFQgeadECfOQX1Z1s7SqjN+2tj4BNzxrgdr6NnQx8rg4HogaKJcH2qGCVnFCMyFZS1u+NFL2YxFqmpnrEhFOVb2sTNzkVj8/r8/KbyHAJ5nDWoaTrbjNf7e+1Qh7o8w2YrmAEusM7JG73REmcG0wHzuy23EkWC91RqigGmyGr0uK4dKfoRGHhgCgUy9xsRePpLOKzZ6SBFQfTbllQhbYx/IieLPUF9Clz0olI0YFjf8G0wyktWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z75qLN3yFxTH7p2/Go/ZE+vYK+ZW+oo6YutrEerjos=;
 b=SUOZkfKAYLBcjR4bw4XalvMz7487RtcQ7UIEHNN3IJW+ov/Kb04o29M8S6MMgdznj3OyGqz/8Z7X+VwDeBYo1o8HY1WZh+dS9U0U3trgt3reNhhbfbmVO3pjzBrNXbkrncAzX2DDiXthWeONi6msjk7znzvfRl7EUfDxZIt+x/dM7YwwSx4DRyPVIpZ52s0ODGQZVeaIZne7tJHDzLFiJ9/nDiv3Netk4GB99M3ERRo9JBl66nqYbHsQDdUlOejz4gz+XT2VdGB1I/AswtXUfS2rxQh2fZ+Eq+G5O9UL94OMBr6LL0fToKX6zoSucaycIe/46qTJpLrh+i+RXAxOpA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 23:32:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:32:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, John Garry
	<john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 07/14] block: pass a queue_limits argument to
 blk_alloc_queue
Thread-Topic: [PATCH 07/14] block: pass a queue_limits argument to
 blk_alloc_queue
Thread-Index: AQHaVEYYLLpFI4HzSkuylLqEnMATXLD0ktmA
Date: Wed, 31 Jan 2024 23:32:06 +0000
Message-ID: <687dbe18-d3a0-45db-9a65-83e897582720@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-8-hch@lst.de>
In-Reply-To: <20240131130400.625836-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB6317:EE_
x-ms-office365-filtering-correlation-id: 3b8af28a-944b-4bf8-b5a4-08dc22b4d635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 N+BtxW5oRMS/VKXO5tWEQP0AefwVq6IlF1veQk90K+WEgbX0ibWcSV1jyeLokb120VltIdWgkn3Fw3q7fz+y5eFKw5aJJ8EDZwGwKNTx02VwS5/VIXxkW9y/IA1iL/l9D6QWlRse4nHA1VthbCI97Vujib0MdFlOIBV4hE4cef7jIzVesiyONfqnySw5pb5Di1r8OB25xGRzAQQ0EJ/Kbx9RXB2MC2Ka7AhfdVFJrtolVtOx45heBmShh/RIZI2FC9VcU0NpYy1iLxgBo1xWQV+KZrmAMQ5LNYcCq+lhH2UZDHntc4V80KJsk988E1UL7V/XALKOrannrZsHCcZJKyG4gUiNtbv9YWXSLKmxLanvCCbTF8/wLHgZmlegbXpSTvJM67ckTqEghHXAfTS3Ft8aSq2nYRId2YSCETEVms9y74FPE3pbuimwIt3s2U2HJ5iBNaQTneU29cLLtw3S8n8I9cIQnK8ta82yiUcj80s5FoMNr36kZZxA2PX1DIBWrd7QTvf3Ibb8LFfp2saOk4sM+9Atmo7f0khdEEjr55Wv8D3E3Z+rZEhByDoTvH1m0axt5PTZeyc9T8LxUrFRr1jrX6mr5EXrlU0cIZAEUK+VhfkhqbwzSWi2dcFNL/p2R8LJfgY5u98g3XayU1Od49UnEgK3yOX6QrDHtmXJ2i+CCRZFeLIilI2kVdTlIO54
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(2616005)(31686004)(316002)(38070700009)(71200400001)(478600001)(53546011)(6486002)(6512007)(83380400001)(38100700002)(6506007)(122000001)(64756008)(54906003)(5660300002)(36756003)(7416002)(86362001)(91956017)(110136005)(4744005)(31696002)(76116006)(66476007)(66556008)(66946007)(66446008)(4326008)(2906002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHJEWCtYd0gwRnQ4RUJ2R005a2NmSjFWNVJObWtJRXYwNkd0a0s1ZTlWbWQ4?=
 =?utf-8?B?Q2NUMmRDNFFUYmwxZW1WUlBNNWpsSlZwYzRDSkR4VVVudE8rZGNPbUF1QTVt?=
 =?utf-8?B?MDNnQXJRZUExWVBFMnBiRlJOUkEyZUxndFRVNWJIWEZHZTBRM2EwMERacWUr?=
 =?utf-8?B?MXE4TjI4RWRlRi9qQnF0M0Zqc0pSdTB6RHlWRi84ZVpyc1ByMFRORHlLYk9T?=
 =?utf-8?B?b05CYUYyOXRWdzltcm9WZ3ZNNUMxVFlwVTRyZWRuYks2WTNCYk93SzdGY2tS?=
 =?utf-8?B?b2g2ZFRKdzkvRDMra2dNU1JoNW9JN3hsT2RYNHE2Q3VjNncrU1RJTkdOMnlX?=
 =?utf-8?B?NWlHemw3NFVBekJOMGZnVFl6TDI5QzU5bFA5Wk9GNk1WS0g2a3B5cjZlN1V4?=
 =?utf-8?B?aURuckJtYTZoUFVRUXRJQXlpMjIwamM2Ni9Zc2phekExTnBwQjVIM1c0ME1v?=
 =?utf-8?B?WW1BOXhMVm5RdWxUTHNpaXhZYittbm1SSjN0VjAwZzdYN0lOZGZ5VTJ0STNn?=
 =?utf-8?B?WkFTSWFNOWcreG43Zlc0RCtFZ0VpK2tzYzN3bDl0V29FeDlvSndrZ2poSVBS?=
 =?utf-8?B?dG15dkxhd2lvbllwRUoyUEQzNkpyMW5id1pKSkdhMHBab3NVZDRJWUsxR05v?=
 =?utf-8?B?eFVPYWdEUFM0WVY1R3I3ZkF3K08rU2hKR3hCN1VDeUN5UkNzbEQ0RmFRV2F3?=
 =?utf-8?B?ZXN3Q1o1ckVNNHN2RWd1SFZvMmVVOU5GUWJRK3Mrejk2Z0JrNUpOUjY1bEwx?=
 =?utf-8?B?QXpaNWU5cnhWSVM2cnlOeENqckFzQUFyRG9RbEhUbnBwWUV0aEQzeUk2YVpQ?=
 =?utf-8?B?QnpQNHhKclh4K2MvRm9acWRjbW0rOHVCZmtrTzZwZGJZQzZ3UTM2OHZyZm5r?=
 =?utf-8?B?elVqZ2wrcjhHaHFVbWV1ejZ0Sm9iRkhvYnpLYlduMkd2SmJjUE8wREorWkJV?=
 =?utf-8?B?Q0dKQm1JVVBjOEFmaHA0dXpqZ1NNcFJRUGJlUjNoV1RrSldidUQ2cmxDSlVF?=
 =?utf-8?B?UE5vWUF4ZUJtSklPODQ1UW9lVE5Oam45RUpuZ0w3UGtveCtyT1VaWFowMlNw?=
 =?utf-8?B?ZkxKWWNkV2RwQmpoVUdwbWR2SkoyTWV0S1Y2L3JaM2JzcDA3VTVXTk84aTJh?=
 =?utf-8?B?ODZpQXliaDdkTnVRcnhpaFhHQWY1M2d4SE1venVFWVpiMW9zOFc1dHNOL2Rn?=
 =?utf-8?B?Tk0xRkFyVXNNckVJVHRtbnlMb1VZRnhpZW5wbFNnOVZ1eTZZS0V0aEpNc2c2?=
 =?utf-8?B?d1ZVUjgyMmN5TklwK2xTZWFic2NINGRCdmxvSXgyWFRnOE0yZ1V4ZVpJbGE4?=
 =?utf-8?B?dTJLMnE3bnFPMTg3WGxodGVLRFBEVWlNSzgrdVVyNzZUbCt1cnhVTkw4WEhr?=
 =?utf-8?B?clV3czV2bHdYLzQyNVBIWk4xc0VzTGl1ZFp3TkR1ZnN3cFNxSzNZTVUvbWNT?=
 =?utf-8?B?d0VWTXdFZ0hrNGcxRDQ1M3IxSU4vdnM0YzNRVUw0SjdMczd3YUdEeGxDTEho?=
 =?utf-8?B?OUwyZ3BmZmdHU3BtQjJQTm5Ra1dnZ3l1b1AweUNkUUl3ODg3Uk9yODVIQVpy?=
 =?utf-8?B?ZGppM1hKK2JBZzdhVkdWc2Y4SlgxLzU0Y0cvbklEaEREZEx5UnhoVGp3aW43?=
 =?utf-8?B?S1NzemxYajhnWjVLeXREcldyUi9Mdlc2V1RqU0ZyK3NaWS8yMVJ3NWZtWnQ4?=
 =?utf-8?B?ZnRTd1pKcXFraEN6em9FUlM0RHdkNURXd3pXeUVocTl6eWp0WTZ6MXFsMzVn?=
 =?utf-8?B?bVNwUy9DNXk0aEFTL24yQVN5VWhRbWJKc1hJQlF1YnlMUEx5WmFLQTB0S0c1?=
 =?utf-8?B?Wk9XWDJPT3BQbFpTV3ZqUk9Ob2FpK2FESXdEUVdMY3BlWkpkd1Z6TE1SOTlJ?=
 =?utf-8?B?Tkx5dXl4VGRsajNGQnc1S1h1YjREUzA0VlA0YjJWTmUyRVN2cWc4dFlVRUM0?=
 =?utf-8?B?ais0ME1VWVVCVStSTnk4TVlnSHBzcmN2VVJVbC9vdVJ0NDlJTGZnSmJrdHB5?=
 =?utf-8?B?U2x0Rmhya0xFbFdhY0R1V1lYdERJSEtaSVh0N2ltSDc0cUJQMlR2YzNqV3Jp?=
 =?utf-8?B?TlNzMzVmNmhlZDRDT2VDTTVQdDZ4Yzh6RVdiOHRHeGFNQjUwVzFyM2VZRnNS?=
 =?utf-8?B?TXp2dUZCSjFuRGpUSlBoS3hTQTRCdVc1bHBYR09kb05XcDNuM1BDNjBJbXJj?=
 =?utf-8?Q?1B34pCibITE8Nyw2SPFyDUBUdHFWG1fFalLYAvxuei9V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2725FD4AFA496F459A906E658B3468A6@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8af28a-944b-4bf8-b5a4-08dc22b4d635
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:32:06.2758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhcyR/Ch3KOYymeza6pPu32b9fpVPzlq0gPbWNUMXuYtDLU4hgCuAlSmIS8U4mvqWJk+N6roAANRDg12NI7RBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgYSBxdWV1
ZV9saW1pdHMgdG8gYmxrX2FsbG9jX3F1ZXVlIGFuZCBhcHBseSBpdCBpZiBub24tTlVMTC4gIFRo
aXMNCj4gd2lsbCBhbGxvdyBhbGxvY2F0aW5nIHF1ZXVlcyB3aXRoIHZhbGlkIHF1ZXVlIGxpbWl0
cyBpbnN0ZWFkIG9mIHNldHRpbmcNCj4gdGhlIHZhbHVlcyBvbmUgYXQgYSB0aW1lIGxhdGVyLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2
aWV3ZWQtYnk6IEpvaG4gR2FycnkgPGpvaG4uZy5nYXJyeUBvcmFjbGUuY29tPg0KPiBSZXZpZXdl
ZC1ieTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6
IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiAtLS0NCj4NCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
