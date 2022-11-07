Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A494DC433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 05:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiKGFsC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 00:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKGFsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:48:02 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC4DF5AF;
        Sun,  6 Nov 2022 21:48:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzZURph+tX20L8e6L4mUxC9OTBK0LrLDwafc2Ge5hks0Iyz9Y8ddRc+CZcBJjGZHmAAA6PjZWZe5dZ8NJ12XlpMtjAvLlRRhinOZRcREWrD5PiaE52eVtL3FME5lIwh4PXkkzAE754n1wwxpTbslh3Nq3pTe53p1IsZ916uSKd+i9jVPRr94IWEQVRHraLxae/D6G1RGStSFnzpbO/VSJHck7z9inolODcYE9xvrpglyJ8C0ZRmD6/qqmhf89ll/Sgbumqh3kJsVndy4x99+Y8DO4K9sRbUT+Zs8BubPyHSbJrlvILlC2aElEXLtKDsS6x7DZ9Y75qrnDLRpiPKAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3QUGEleW8WYeByaFw6QQbpKrqn9IHnM+pfiwJU2DFI=;
 b=CZNl3QdP1+puXUfwRERAnz3TmMWR1AYnCl+rAHoCTXoGog7gZrFTIgZZzGbGOs1uqpNnDOkE+VYpOxg/bQvpVI6t32BCXl6q+ExJi2N/9acW96dgVoTcmoKDnfaZpPPihG9xV4k6aQfL/nJt2C9Oy492cOwR35JIJ8KGhX9qbzPcCw0yEgjGrhh4HIMAXG9RGApgCO+9MSlkoU+tF9Lq+IZDgyMmo/84MmI+gjIAI33ZUXCVmlDC/WvvX0XNGCk4qEcVxm6aIY1T7pH2npZhJQmLWt5tjLEQKJ+rgf5QZewHdFoOz88XnMO+HoVR2ELqEhp75/NPg1/QABxcXdKtBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3QUGEleW8WYeByaFw6QQbpKrqn9IHnM+pfiwJU2DFI=;
 b=MDV42+Lb7o1/8ky9CHOxj8e+2+aTXjl6PcBozXKxlqcvKBLhns3NqIvCLJYEMqnl8MKxZQOvdYx8BD+FNJ3Pqz+vixIWRZOm8vHo1WJuiNaPLCUoxotO3em0jUqQn3zbbGMUAp5HEGHEwvSJTjH6l2gaTYF7dFm47+3n3DUu36xC9tD+88G9a+ZJeoGQpR2XbFfFvyCek63X21wv/5qwwSs9Y3f4PkaKnGXU5N3OHAi0/4sT/sHHV7n7bIXmiLzLpo5ini9Cb+c4oyywgvlNdXZlHcXX80VMSozygbBU4nZ2jfKIpH9nm+pwf1yX25LDewYHkZlWyU2NxOXjIVV2wA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 05:47:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 05:47:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 7/7] ata: libata: Enable fua support by default
Thread-Topic: [PATCH v5 7/7] ata: libata: Enable fua support by default
Thread-Index: AQHY8kL7K/JqslpgS0+YFVYzBEOcCq4y9HWA
Date:   Mon, 7 Nov 2022 05:47:59 +0000
Message-ID: <2d79987e-9285-109a-3cae-73bd4ded45e6@nvidia.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-8-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221107005021.1327692-8-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6470:EE_
x-ms-office365-filtering-correlation-id: 36d3b64b-4454-4b14-be3d-08dac083a0cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KHluQ+ZNYNcTpF2j+Ke2sCja6meVPfNr6sVrgPtftZkgFDyChr14FJCpipIlKqM+GQmjvnbgtpG5yNhKMKWbPmymcJ535RGvpaL9AxX8WsHF/lz3pJNs0YndFiNRkSY0Pz9mRgClBHU4ybTyVGp4ydXd5GwdHrprpuN50i6JhafZEC1QYcM+T/HNNk+CZ4afqJTvHXGnKhtBGlx44mE0V+km5z3ZJ9a6LDTDYb++x0ByvA5LDwdmaeA5iyqjDpXmLC+qe6JuUEaag4fnIMg1J34nP5MLXhkGAewEhLePeSMIH6aenbLuiGt1iXPMiFs3VaTpgJN+xqQ8KBPwSGMplRVtds470Tn/kvN9XZG0LyG2H25rHNqvIGL1rHNRPTMdonxWIDKCylnbTbbNnJZGPM2JhD0osv+Jds7heoGGhlInVNWlzppaBqpy0W0He5Zj8v50ZqDbhbsMzT43CzrEIDPqQJIDFB/MK8P2uIDgFBOSzy+Cq1C/okhcazsPUpeYx400RZ+UQMvFLAsr7nw7gG4IGvpnw2c0AlGRTK1IyVlWtnlcZHAL75sKS6e0svMjKYEEsm4xHYep3AtmTaCrkUyD/XKekxDyJKO4qG5tvcFNRlBZdqjUwczS/UHDLepAk1HA1SMjOyDzFU3p24Pm/o0r+muef5ncVACFR/TQ52vr6G3FlLHR9QCKyB4sQkxopwtbCSMmKPYub2cDDZu0eDscA1daNtL903Mhz8V75FYBe/tEzA1HXmH9hnfJTGHGa51WdDEhAnfbIgI+LjyWosMIMCoVeglslaVd2nIdDuWha+QUnvXi6QVYbENs7JZkyNCflWrczlXOSunr5NJkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(83380400001)(38070700005)(186003)(6512007)(86362001)(122000001)(91956017)(6486002)(38100700002)(2906002)(66476007)(66446008)(8936002)(66556008)(41300700001)(5660300002)(66946007)(71200400001)(2616005)(76116006)(4326008)(110136005)(316002)(6506007)(8676002)(64756008)(53546011)(54906003)(478600001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm9PU0QvR0N4RURWS0MvU013MlZmeHpFdStzcGl5V0pZRE5vMVdCczJ2MWR2?=
 =?utf-8?B?ZVBZMGYzQmRZemxxSE9iYlVXS1RKU2ZBSWFxUC9kdS95OElNL256azlHQ2NS?=
 =?utf-8?B?eDRGVDJDMXpSV1JIaGt0Q1o1aVZ0VkJNMmJ1cWJzMkNHclJrVkFQUzlFSHly?=
 =?utf-8?B?TllmcGpaQlJ2a3hJYm51UlNlRWxxZS8yUUhnU3Y3ZWI0TzdCQk1UVmFXdnl3?=
 =?utf-8?B?a0VBMmlnMGN5MEEwbHdiM3o3ZlMydVdoWFBOazdwYThLNmxOallHdVFiakdT?=
 =?utf-8?B?M1Bjak9yNkVZc09yazZUcGVwMUdHdTNKZmhEc2paczU0QU1VelFDbUZFdndo?=
 =?utf-8?B?RXZkY3pSS2NzL0xTai80Z1B6L3B2YWRQcUFrV2VOSjdOMTRhWVRUNEovTVdC?=
 =?utf-8?B?eEJNTGdXWkw4dSt5QzhRWUxCd2FwdC9rMzJxcExoZ0oyQkNwb3M3ckRkZi9Z?=
 =?utf-8?B?YmpLOVozWG1VelptS3BXS0wybWZSNUoxem95MlVvL3oxRzRHQWFWWUlwOFdC?=
 =?utf-8?B?dHVEMFdaaGQ4SkZJS3o4YU54NDRkaCsyYWhLNE80ZiszLzV0Yitad0tPRlFW?=
 =?utf-8?B?dDZKeE95aUpMVkg5c1EvQm15OHpXdzh3dDNENkpoZ1R5ekEvNHMxdW1Denpp?=
 =?utf-8?B?VTBDUDd6WW9KWGRWSHpLVVA1blc1amxaZlBVSkp3RDZoOElPM1RzZUpEY1M5?=
 =?utf-8?B?KzZ6QURDcXc3WEpYbEk4NU92ZC9DeFpvTWx3M3ZReTNQdnJrLyt1NFpCUHMr?=
 =?utf-8?B?M2luTlI4UWFmRnAxNjhxVWdiekkzK2VIdmRBY0hjUUMxWXV1K1pWV0tWeE1Y?=
 =?utf-8?B?SHI2TDVPaDREVGdOTU5XTStGdnpWMTlyQ0piRnAwRDRCQ0lvNGZZVXJTeVdC?=
 =?utf-8?B?b1c4aE45aUlIWEZrQ3FWS2IrK1pXdHQ1ZjB2YVVkZFo4d0VNeFJKUGswSTRZ?=
 =?utf-8?B?YXF0S1gvemhlVDRBK0hYaTNKd3J2TDVXSk15ZXFsYUU3VnpRKzRBSG5SUmJm?=
 =?utf-8?B?WUlJNTFIMW43cEZUQzYvYlhmUjduRFI0eHVOSnBJYk9NT2NqQ2FpY0lWdHdw?=
 =?utf-8?B?dEorQkhZTzVWN3V5ZkN0UFQ3aTVmVVpUMHg3a2RJblFXVUVaY205Nlk4Y2ZO?=
 =?utf-8?B?dGNGYVJ1ZGMvZWZnMzEzdHdHYTY4K1pzSDd0My9xbWxoUGtidHlMYzhPM0tQ?=
 =?utf-8?B?VGJ5VVNMWFM4MUwwZWc5bzVYMHpzWDNUK0tYaXJRRVk1OEkwbVdXUUpZRUlW?=
 =?utf-8?B?NTJBWGxJOFIxdFBGN20vMUtIZERPZ0ZBVUlIL1RXRkpoVmRoMmQrQXMza3RR?=
 =?utf-8?B?bExqSG5sa0k4SUNLV2xzblc1dm8zNnN1TGhPU0l3QkFlTlpTYlBvQ3V1eVRH?=
 =?utf-8?B?Zlg1TGVhd3lMU1JTQjVIcGcrOWhUWWNtRHVRZHpEazFRaWFDRFQ1WEV5a1VM?=
 =?utf-8?B?bjdFanE4Q1l5a25LTmRZTXI5UGN2K01EdTd5MzgwZGQ4U0o2aFpVWE4zM3VD?=
 =?utf-8?B?T2NTS3RETmdRSDF1NGd5a0RQMmRPZnAwZFhTUDRFci9MZTZmbFFHS0Y4WUxD?=
 =?utf-8?B?V3NnWWlQL3Vua3lHRWhPRDlOL0NQWjhYemRDcUhiTVlxcTM4MGN6Z0paR0Rl?=
 =?utf-8?B?VjRGb3ZNYUt5b05hVXRNeG05Qk0yeUZta3lmUXhjdGQyT1doajFvS1ZWYVk1?=
 =?utf-8?B?a2pGamlFdy9MRkJZOEtUb2RjZzlmR0hGdXFvZHkyWXFScnAyZTNMczRBUmEx?=
 =?utf-8?B?dUVJTW9OaC9pQmF3SUtvWmlpeXVCY0doOFJrQzdoM3dlUUxmTWZtSXFWakhN?=
 =?utf-8?B?STJlWXJnWG55UVdUN29IR3I1UkZSZHNkcWs4aU5wK3ZUNHlPazJCWEFiZDYw?=
 =?utf-8?B?UllqWklrWlozNGRUeC9LYmF4WkN1c2d4bGthU1ZZcHVqK3ZsRy9uV3hoYjZl?=
 =?utf-8?B?VjNCMVEzZjVqMzhtb2xsM3JseThWVC9tMDh0RHBMdnY1ZHZmbWxjMCtpTDlt?=
 =?utf-8?B?SFZ6bzBORG9ERzlnS1BLWTNJZVFYSUFnNXJhd09mazFBdnN4OW9ycE1yVGZC?=
 =?utf-8?B?dXVrUmdMM09KUlZpc3JINW04VnIvZFJid3ZjS1dSWXdXTGs4cHFRSFVxNDhn?=
 =?utf-8?B?Rnh1N1FuUjFOQ1RzSi9LMG1QOTZxU2U3UVNxL0tGMyttdFpxbUcwbGl4WDJi?=
 =?utf-8?Q?HgHewtlZjPzD5vjdz0rotuT9Hk4T14QlKBh3YBlwv214?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B85014D530F8E342803917393D8B545C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d3b64b-4454-4b14-be3d-08dac083a0cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 05:47:59.7120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccYvpvba4TjxF22XCh9jBqhq5aRwX9XRJGsxzaPJHEwavHo3SeSfrv0HDl11z9mBJQl1oretkdLg1PJBAbf5PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNi8yMDIyIDQ6NTAgUE0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBDaGFuZ2UgdGhl
IGRlZmF1bHQgdmFsdWUgb2YgdGhlIGZ1YSBtb2R1bGUgcGFyYW1ldGVyIHRvIDEgdG8gZW5hYmxl
IGZ1YQ0KPiBzdXBwb3J0IGJ5IGRlZmF1bHQgZm9yIGFsbCBkZXZpY2VzIHN1cHBvcnRpbmcgaXQu
DQo+IA0KPiBGVUEgc3VwcG9ydCBjYW4gYmUgZGlzYWJsZWQgZm9yIGluZGl2aWR1YWwgZHJpdmVz
IHVzaW5nIHRoZQ0KPiBmb3JjZT1bSURdbm9mdWEgbGliYXRhIG1vZHVsZSBhcmd1bWVudC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9wZW5zb3Vy
Y2Uud2RjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRl
Pg0KPiBSZXZpZXdlZC1ieTogTWFjaWVqIFMuIFN6bWlnaWVybyA8bWFjaWVqLnN6bWlnaWVyb0Bv
cmFjbGUuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2F0YS9saWJhdGEtY29yZS5jIHwgNCArKy0t
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9saWJhdGEtY29yZS5jIGIvZHJpdmVycy9hdGEv
bGliYXRhLWNvcmUuYw0KPiBpbmRleCAyOTA0MjY2NWM1NTAuLjllOWNlMTkwNTk5MiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYw0KPiArKysgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtY29yZS5jDQo+IEBAIC0xMjcsOSArMTI3LDkgQEAgaW50IGF0YXBpX3Bhc3N0aHJ1MTYg
PSAxOw0KPiAgIG1vZHVsZV9wYXJhbShhdGFwaV9wYXNzdGhydTE2LCBpbnQsIDA0NDQpOw0KPiAg
IE1PRFVMRV9QQVJNX0RFU0MoYXRhcGlfcGFzc3RocnUxNiwgIkVuYWJsZSBBVEFfMTYgcGFzc3Ro
cnUgZm9yIEFUQVBJIGRldmljZXMgKDA9b2ZmLCAxPW9uIFtkZWZhdWx0XSkiKTsNCj4gICANCj4g
LWludCBsaWJhdGFfZnVhID0gMDsNCj4gK2ludCBsaWJhdGFfZnVhID0gMTsNCj4gICBtb2R1bGVf
cGFyYW1fbmFtZWQoZnVhLCBsaWJhdGFfZnVhLCBpbnQsIDA0NDQpOw0KPiAtTU9EVUxFX1BBUk1f
REVTQyhmdWEsICJGVUEgc3VwcG9ydCAoMD1vZmYgW2RlZmF1bHRdLCAxPW9uKSIpOw0KPiArTU9E
VUxFX1BBUk1fREVTQyhmdWEsICJGVUEgc3VwcG9ydCAoMD1vZmYsIDE9b24gW2RlZmF1bHRdKSIp
Ow0KPiAgIA0KDQpwZXJoYXBzIGl0cyB0aW1lIHRvIG1ha2UgaXQgYm9vbCA/IG1heWJlIHRoZXJl
IGlzIGEgcmVhc29uIEkgZG9uJ3QNCmtub3cgd2h5IGl0IGlzIGludCAuLi4NCg0Kbm8gYmlnZ2ll
LCBlaXRoZXIgd2F5IC4uLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQo=
