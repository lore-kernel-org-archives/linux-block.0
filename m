Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4133EA9C
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744178; cv=fail; b=VQHRI8S6TJ1xVgdB7GYz6ytcXnTaZy0aH9HOBw3lIR6OO18to0wKt/ioP9umKKZ6BJJVVd5ijNY2c8R9UzYG0LckKqZ8wSMawfyXz93GQ7frQ7ouj73V09m38hg/15m78QGDAF1nC4xkHQirPQvem7i9P2gsuoBtTMar55IVsZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744178; c=relaxed/simple;
	bh=NvTI35uXd2KEDzSoC95Bz2pi98u6UQbTViEcPf3l4Fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MvaSD/PKdi8X+iscrxvMyr/Tjquw6Y4sCwv2YRQAu/uirXJkOvS9NYwhM5W4+AN3CAUGZmj558QhynOjSi97yZ4eFgpj0gDMCP79AVe5WfTPC0q7oQPBZTyWMyhk9ADpAHuuPrDlq6dZNBUfKZciPk4bekGEwVA9bf3APegbee4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cEsMKxgC; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cEsMKxgC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErbeFyifhEdlVXQU+9OfL+MOpakmHgsrwr8k2wS0MfF9mgNedzf//18y7UvydVanXZvFQTNmPHEtdcs+18NgThBTOtexCdehygljAqNzrGJVJl5UGUdWBmcNDRbOSUBb7BGfJy6DjauqB9ksiz4YGKlUL+YNe6H6sSQIyuXQUi+Xo1sI7SGl4NbSIiG+LcAc7VcJFFFVg5h8BdUCe2211zvLaIGnHVjoa4PJGrMFD5drf/GLnwzbTxUKbXVigAT7P3bHM79X8/LcCNk+wiMO3SO5gM6L3Xcvog5fa60fSIk5G+Y2XGKLGnmDQJajYDGeO/GZf6HEKGL6U8DTKeFiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvTI35uXd2KEDzSoC95Bz2pi98u6UQbTViEcPf3l4Fg=;
 b=Qf0+0EaIYWsD9mfg6h64u0QOX45wv2pcGo+eXbcUh7dYa0KYEZGOnIO9ioA7BgVBuErRVLAB7hpQgAIPx7LGmoTzdMVVLPzUuo0pvaliYSDzmUU+4+D2SoFchVv0MUOFSz/tmwmY4yLAIfM/3C2cdb/ZKp2xpV963vHCUnoucVOulk18npnQwzllCiLtXB8J1HTqK2pVXcURjCzXiWfav05tdZh53x6OLoQE4D9nwCaLJJ4MuDBuFFE8AZUTR7nR+6/jI9QfR9++ZiPGJmnFILznJ1Hxumv4CYmTb81sFER/NAWY6Inft7tsTtkTY824Yo+JNl5dOf581pocv/jXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvTI35uXd2KEDzSoC95Bz2pi98u6UQbTViEcPf3l4Fg=;
 b=cEsMKxgCmj/vqs/jCeZMIB1ZbgeGSaHn7Hs77P8T5crMkHAYBfsTN169UIPOp/qIUPh3U/T8bFsW/BsfynhAmkPKb3gFIbpKcvf1829TGm5mgLgcXAD+l1+Q0PhWpjG2nD+eKmALq4iJMUYm6Qsw8FR04bVwa8Q4DwSVdYa4shobyB8ubfXqhEA4Kd32rPlMPbDQmuIWJqqtg9ZzgQI4ackazqblyH/kX5PqOhtuoJT7lFj1mDC2C3mA1lJeSKEA+tPqsZRmEvmYeTdVUnVN712A74Inh1yNP6j5Ile3UCTwzHp2L+2TL/YIG8tQg+VaAVZQFmMDSYo1Nihe0YPFIQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 23:36:13 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:36:13 +0000
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
Subject: Re: [PATCH 09/14] block: pass a queue_limits argument to
 blk_mq_alloc_disk
Thread-Topic: [PATCH 09/14] block: pass a queue_limits argument to
 blk_mq_alloc_disk
Thread-Index: AQHaVEYZryCyugeOp0GYvTspbh9ZgrD0lAAA
Date: Wed, 31 Jan 2024 23:36:13 +0000
Message-ID: <a4d461a7-602c-4ceb-a5c9-2b4da1286426@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-10-hch@lst.de>
In-Reply-To: <20240131130400.625836-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV8PR12MB9206:EE_
x-ms-office365-filtering-correlation-id: 0844eb54-c83e-4257-5f13-08dc22b5697e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c9jUBzCyoBDSBFfAShdJzPqj8yg93nz2uKh8ZaQb2HGNti3XYteIiBlLL+zG0EdGl7MWZc3a2doVr6dPxNqYRsFgORqUzL4cM+cj2y4fE6+ACCcBbgy1AxHULJ2egrrlOV0A6Sy5sVULzKQS6z/9ACTlwlpuv/Jw60oIKfe55RJpvOBpS6oEcAaeHXfpa5pi/lSa3jnC912lmAE64Re0CgvPCAfABSO0swUNzroVB1CBWnV6XtiBI8ON7BpZP1z5eGWy7McU2z1doMc5Hf+V3s4TkmFwFxL1kwLhR1ZU29j001YUkKicvsw3RHn3EcfYuFssLE23dsFLbuOwdFWNJS3Pfn+4Nli7xnDX9bOy9oN2twkTk1uI+NGzd6jM2cGPMvvUum8C4+PLPh34I/tlQubIR72ZiyFRXb8FcyX06ic7OhGIzzEWaufLxuH4ljFvUMJ1ueuzL9zIwb21hwYAYoAuWOYY2p9tD13LiS58YaokYCN02Jm5J77vV8Yx6THo4uKq8SGJYy27BHeQw9LovuTsCYjEQrMfhFH2noCn/2XvO6/B9SCPcxexSlEMvkPug+S4TaYmEcNIrcaZkhvjOPUWlL7ZtGBCgrcavqROppDLh5isoTcqKRpGRK8K49WA/itshUv2W71ZSN2f1cWcptBbAxknXQ/Wl6fQ5PkFnRrSmNqTtr32ElKq22O+NQZv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(4326008)(8676002)(91956017)(7416002)(8936002)(31696002)(4744005)(86362001)(5660300002)(2906002)(110136005)(66946007)(76116006)(64756008)(66446008)(36756003)(38070700009)(54906003)(316002)(66476007)(66556008)(38100700002)(122000001)(53546011)(478600001)(6506007)(6486002)(6512007)(83380400001)(71200400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2dScGlhREhsYTdtSyt5V1pXWTJvd0FWbUtMV0MrYzg3N3F5KzZNeWRaRkpq?=
 =?utf-8?B?enU1MkdyVUx2ejVoYUF1eHlFV0dIRE5nZmR4R3Z6M2paSVY2d1U4bWJ5RGxI?=
 =?utf-8?B?Mm5Ec0c0azNnWkY0Q1pVMUYzRmpxZHhwWnhaem5raXlwRy9USFZwZ2JQczM1?=
 =?utf-8?B?NVpXd0FjYjd1UWljNjlMR1ZOT3MzSlVSdVpiZ3ZzdGxtOUs0bTlFUit5R0w5?=
 =?utf-8?B?d2NqRzVQMGRESTkwYTlrWGx2WlgvQ2JxM1JuUkN0TEl6NEJFVkxKUE1UeEp2?=
 =?utf-8?B?NXg5RDBrK1RwbEZNMmtUKzlOOFRSd25kZW14K0hiZDFEYVZvcEFrRmRhSzJq?=
 =?utf-8?B?M3AzSFdzRmM0eVEraVJJTjBFSzd4ODJQVDl6V25WdkhzZ2E1RFNqWk9MKzQw?=
 =?utf-8?B?N3NIekhrOWQxWS91NXp3czlzLzNEUFJIOG5nVnNFTFlkZ3JxR0xCTnZYUElK?=
 =?utf-8?B?Nkh5N0dFdDVXNEYwUWFzWkQvODRGcTNyTEVBMisxQzhVRmNQb3huOGFYVklQ?=
 =?utf-8?B?bmZ0M2UyWXYrRXhMeEtndFkwSFBBbVJxQ0dzN0Q2aWJIUFYyMS9OTHUzK0xK?=
 =?utf-8?B?WTNqa01BRGNOdWsxbTQwMjdTWThzL3l0QmtzakNUNkdCWStQazlKZDRkYmpX?=
 =?utf-8?B?MWxlTDZ3OW8wNmVWNXM1MDAyTjR4VGYrcVBYcGRlSFFFZW1XY3JiVE11M1N2?=
 =?utf-8?B?WGtISk12em4xbUg2dEh1YnE0VzkrVmxiSUxzTlIzbDgvUXJCcHNURTNURmhV?=
 =?utf-8?B?bWozVWNhblhDTndkYUdkQVQ0ZkFEOS9sSWVUclhzSWJlR0xJK3d0R1ArdUR2?=
 =?utf-8?B?N2ZDcnU3NGU1RTQ0Nm5oUzRsSlJoYld3TFZVc3pkVXZudE1NN2pwTWJEMzdB?=
 =?utf-8?B?RDR3UFkxOHdOTFRXMkhlTFdXVit1WEpmbUJyL0lYY2FuY2pEMHJVMU4zemZR?=
 =?utf-8?B?YTR4L0ZIQStZYzBVV0huVUtFaGJKZTJZc1Y5TG45R1NCU1NOZ2FFNjU4VlZO?=
 =?utf-8?B?WjlxZlBJQWhJOFlsK2FUNXZVSmVybUhRRDhjd2hWSVBUMG4vRCsrQWQ0dTFt?=
 =?utf-8?B?NHUweXJRNnc1cGxRWUpwL2xHWlB3dGt6VHlNSDNZTzBlSzBKNURvYi9aZU91?=
 =?utf-8?B?STlFQ1BZYnNSQjFHSFNlWCtMZ1FOV3JjY1duKzg4ZDU0U205aHFyZU5CeG1k?=
 =?utf-8?B?bWNLVFl1cVBBT3luY25PUHdrbGwzN0hxVFpYZ0M5NnRoRElDQThSWlRCZ2sz?=
 =?utf-8?B?Qks1SnVDYlF2a2s3WTN3Ykk1a2FqeGJZYzZZbS9ZdnhWcWxIZ3hsb1loM2FM?=
 =?utf-8?B?d1JCOVp6SzJjNXhZOTc5UjlmRit4RGhiZFVDbWUwYWNPMU1ReWE3ZW9EVG5J?=
 =?utf-8?B?Z1VSc0crd0p5N1RmcE5zMlF1RDYvT2lCUHA2QTBCaDQ5Z3NsN2NDWHgrV3hP?=
 =?utf-8?B?VVBsbGprWTZ6aDlaZ1lMRUxtd2NWVmpVMjRUcDdQN2ZVb3hWV3ZDSDBOTy9E?=
 =?utf-8?B?dnRUNnFHUGpRSE8va0EyY3BNT1ZqYlZYVHdBK1p0SHBjSWJ1Vk5HMUZTU2pI?=
 =?utf-8?B?WlViNjZpRmpwdzdQL1F0ZVJ3YkJUeUNyamZKcTVodVMvZ2crQjZBeDRqeEQx?=
 =?utf-8?B?TS9ZakZUSkNza3NVK01pRmpQQjJDckJ3dDFqdVdVUGZTVHRNTmZQb1lYVWp5?=
 =?utf-8?B?aWJOQ3dXVlRuWHRPVjdycWZva1dEWGkrN1I5OTVUcjB5QWhYWTEzY1ZpQlAy?=
 =?utf-8?B?K2ZLOGJwNDB2a1grdVNXV0NEZWFuYlVIREpIT21CS3BjMFh2YUpJcklsS1pq?=
 =?utf-8?B?Tyt2OFJVdmJUN3NOV1JQRkxBN25oaEdzamE3T1pYL1hZRjltNUo1WVIybnJ1?=
 =?utf-8?B?WTg2VmhRSWxBSlE0dGlYdERpc3dudjI3MXRxdlBZU25jeTlrTXUwS1U2OWcr?=
 =?utf-8?B?MXViQnFLeDIrRlhuQTR6cTc5ejZsTkNMK0R6Tk5TZ3k2ejc3cU9KZzZaT013?=
 =?utf-8?B?cC9yZ05sNE5aaG9udU1aeFM2c0xUK212citETnNwaUxpQlVIUGRtVjVmQmdx?=
 =?utf-8?B?ekJGZi8zQWRLaWRvaW9LVzZWZzhvc2hHNU8wa05PS0FweDVwQi9hbkxhczJZ?=
 =?utf-8?B?amdzM3l2cWlpd21KdVhacGVoU285TVV6bUJYTDZyZUtTNnM4bjEyd3RZOW9M?=
 =?utf-8?Q?nmt99Xa6irLjv400ly7TT4dJuosdkddJ7DWwD1oX/iCw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5275234AAA051E459AD5CFBB10C0BE8A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0844eb54-c83e-4257-5f13-08dc22b5697e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:36:13.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OMF0fFDReMo8+JssgQn8HHNGsr/Lv1ybb2uPkPWhaE8cUOiN9nwKGsAP8QP2m7/K+g1Tb8m9TIO08XTyUS/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgYSBxdWV1
ZV9saW1pdHMgdG8gYmxrX21xX2FsbG9jX2Rpc2sgYW5kIGFwcGx5IGl0IGlmIG5vbi1OVUxMLiAg
VGhpcw0KPiB3aWxsIGFsbG93IGFsbG9jYXRpbmcgcXVldWVzIHdpdGggdmFsaWQgcXVldWUgbGlt
aXRzIGluc3RlYWQgb2Ygc2V0dGluZw0KPiB0aGUgdmFsdWVzIG9uZSBhdCBhIHRpbWUgbGF0ZXIu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBS
ZXZpZXdlZC1ieTogSm9obiBHYXJyeSA8am9obi5nLmdhcnJ5QG9yYWNsZS5jb20+DQo+IFJldmll
d2VkLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1i
eTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KDQpGb3IgbG9vcCwgbmJk
LCBudWxsX2JsaywgcmJkLCBybmJkLCB2aXJ0aW8tYmxrLCB4ZW4tYmxrZnJvbnQsDQphbmQgbnZt
ZSBwYXJ0Oi0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
