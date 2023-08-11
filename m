Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DF6EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 05:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHKF1I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 01:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKF1H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 01:27:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023512717
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 22:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWR8nEVYW9tp5PZzntcnMWGbVO+EJDfLoDd9AvZcvo0/GnLJ/4dzc2zuYA+355hSvI+eP1VMyfFJnKxOcVNTF1ranZMOCOe1P/JW6YwtcwEn65TkcSSg2kQmcIZE5ZqKTBNVGjN4HZAAbw8juLL8RYHlovliEOtz441Tx8yGfXnavNe6J0OJUi6RHv2xBz50ahPL5iHbsLhJJCcDjuNqZCVEKL+aBovz3mWS7NIuMFhK0nYA0tAU0IaSOVkVUBGIHRUT39lJxvIDjhE80q/OdIdpf9VH5KqOV1gwl4AGuzA5XeSCjAno5wif/Zn41FFjz6yo07i7tMpOD8JUH28nxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFawQE3Npr57dGbXeeGMCWdrmbVqJcLcsa945bxaJrs=;
 b=K4KowP2wm6F/Cf7qS7WxS7uqiHOROiDd+0icoRHVJP9JiGPdUMQfFnoAdHAhHbp4UPN0FxlJC83zsQvYD4ab+LM0pDGYmk8dx+2ch45knGkkFneZDFn4RG67uxzgRU+zcx0NolXaZFglc/BmRKlpZNl8P/QUokIXGNA6ZgE3QIggr6OPQRsKno81jWJfD7QN1WmQnRXH3lh0ibJR9gys6KxRAK9Q23aRCCoeYdhHoL3lcfx5SgjHJo+A37MjTz/3sZPtvct9ku4D2l9m5YTTKnw/sGMhxT1baF/oeUqc89DzlE3kHdLshP8rlCUsfNn/vK1j7xo5wEHVK/p9T8vURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFawQE3Npr57dGbXeeGMCWdrmbVqJcLcsa945bxaJrs=;
 b=m+8KrU1gEsfzB8/vSovpGHP7KTPyhusCQ0FmxDf+MXvNhhn9zNTE0CfhnSTu3W9M2MJ0+8/8ekXe7jHWMWy6Eg0fpptEPaODQpxtdlWv58menBf4Y4XE++XdJmrOTmE6WJS7fbJNLwubvznLoW9F2Spm+Kq/PbbKxIZ+ZSlqUgVBovAUMEnLCZPJzNMS1D/ZRwUDuO0EIBE+CeEyP0I+sOddErsQgaTU1fP9yIegbv42L9GeE/3nMVqQvmZOwauyQnV0P+VVCPECBew8/TkipQg6TIOKrAk+98z2v2BRX4jdvGE9f7WdsWzkqNX5VgDgcnf8kpcfeoHTfI9Rtl/QTg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:27:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 05:26:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Thread-Topic: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Thread-Index: AQHZy/J4nzWodVElWUu/Q+9M04QZm6/kkQAA
Date:   Fri, 11 Aug 2023 05:26:58 +0000
Message-ID: <b0dfb8d3-b96d-4b79-922a-c25b6c68c432@nvidia.com>
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4875:EE_
x-ms-office365-filtering-correlation-id: 5f3a6b14-48e7-408e-b646-08db9a2b95b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sQq6OFjs45rCQ71a7w3MyJtzdXHw6405UknttcL1ocIWbHVTzldm3Gz8IojNLxrL5MeP1ZyC9zg39CsXeoL1j56c0gFfDJaIgPiNA4WYHi9KD6MaMP9RswNmYggWjS1r9TRcpzNVCSpLEHKE/zIHsK2CKTOZQx5aju6kvN3abWWYyFfwJL7zxZlNdqGSt8Zcbatf3dVQvbJY8jj2vphD3+KwNgHnzayOsPoXSajfJbML1ZCLv/AbomkLaaBU24fLu2lUqaNHi1kcYutWyIm6odV0dZtynmbEW/kZh4uhI41xs5KtbPnNgbD5Lowv6/+YpsjxGeuHrkjEv09wAW+KX3ESN4WL/jkpOf0ccCy/hmJyJ/Aq0fnSSII5EQjZtqY/ihhxHTmZwmclpLjnP0+e3j0zcSwr5Rehe1o3+JCs9YVUwoWZiJcDKHTmwRCYdvsDgb88zsPNhSoKOc5rWLcaBN/56qmb1fWk3bNxgITxFZKd/yG98twNyAMFJxwuZ9+eX9lTwwku2g+3COuvgYtoM6Ctr4Tb7Gom8ay8BvRKjKbjhi7oeV4/BqA50Z5mETeuuxNcDe/Gfq42qWXRCFbtOCn5bHOAuRaGjtqTMxdAAyScOyhoe5bw5aTsrbNBQCC5cgeXY7rqcmwlsWrWr3aPhBPOo3XtMGN/avpuFhnytZV+8s8QAgfW2Vq45iW1PUwqI+Nj/GpKnydBOI9IZrP95sm13n2KB0nN4aA4XEe3UNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(1800799006)(186006)(451199021)(36756003)(86362001)(31696002)(38070700005)(122000001)(6486002)(71200400001)(110136005)(54906003)(26005)(53546011)(966005)(6512007)(6506007)(316002)(478600001)(41300700001)(2616005)(38100700002)(8676002)(8936002)(5660300002)(31686004)(91956017)(76116006)(66946007)(64756008)(4326008)(66556008)(2906002)(66446008)(66476007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2dYTDVDU3VGTFRYWnVxQlpISEtRQkJERHJDcC9mYUJjS3BFbnBycEVZRVdI?=
 =?utf-8?B?cERtV0NyOVhJTG81S0xpcCtLVzdXVGYvTkV3MEhxamFUc0RQVnBidHBqaHd2?=
 =?utf-8?B?TVdTcU56MHcyNTRrZG1yV1Q1V0tySU1JVTloRUMzbTZIaGxpVERaVFJrT25F?=
 =?utf-8?B?a0VmbkdqeWd2OExxVHpaUmhhYlczK2IzYWVHRmNLejZmT2xkZUE5SWZxc0ZC?=
 =?utf-8?B?ajF1UWplMEtnTXVjeGxpZXR4dThnNll4UjhrOWdMMXZ1TjFDWTE3bEhMMjFt?=
 =?utf-8?B?cmdIVGhjR3JyY3dFVUJZUlMxb3JXMWwzejcrdjFwZkt0TDg4d1lTcXBHenJO?=
 =?utf-8?B?UlkxdTJhUzdWRFAyYWw4dDgwNXR1NjQxUEJKSHZGNWFzRS9PWUpDVnBQVXcr?=
 =?utf-8?B?b0VDVXhvejlSNzJHRnROZm01dUpSdGpUTlBJYUdMWTc5ckppaFNwZ2hpb3J1?=
 =?utf-8?B?c283ZTVXQlJmaWFRVGpSVHNoVTN0azBzUW9iMVA3YXhtKzZSbXpkTVU0Wmlk?=
 =?utf-8?B?MEZId2JyNjVjQ3ozWWttdXlzZ0kzM0Nocnd1TjIwcXJzOHRpbjQzRWt1Y014?=
 =?utf-8?B?RG4rc3lTKytPREViczJFZWNJVDNLUmRveWcrVE1TelZMZjRlVmVxWGJHZUI5?=
 =?utf-8?B?RmZMV2lBQVo4T2lqSk1zaXBxdzVHTzdOcXFvWjhmUWw4NkgvcElJcmVzMWR2?=
 =?utf-8?B?T3FNdE5xZlZIdUk3RUlXdmVuOTJNY0U3cDhiK1RDdE5JcTFVcUVScmtVRmho?=
 =?utf-8?B?cDc1NElBMjBJQW9POWFONmZyMEZnK2xwb2ZvL0NhRjJzUlV5eHd2MUk5OGhp?=
 =?utf-8?B?R3hxTGJJaDdBajRTVWFUUmU5VVF3eWdGV09zSDlMdFdFRUZWdWhkSGswVkVW?=
 =?utf-8?B?WVFTNEtxekdJTFVidExhUmFvdG9LYWc5ei83K0FORGpib0ZMRlFzWmdjNXZV?=
 =?utf-8?B?S3VQTzZXcVU3SUVqVkx2TTdycktkcTFLVmtYNGZFQ055dFRROTlvSjlUUFQ2?=
 =?utf-8?B?YU93UFdCeFJvMng1U2NSUjNDdFN1QUJKaGJuYWNzUFNScWlIaVdEREZMeE9m?=
 =?utf-8?B?Z3ROeU9HQ3g2NHVOZ1dOSm51KzdFOUZsVHhGOWJ4NGo0STlnYlhta2VFQkhs?=
 =?utf-8?B?azQ2VnQxYlpiYTd4b0FDamF2U3ZQRWtBREhwZ3NmWDJXTXZlVDQ5cTJnWmRZ?=
 =?utf-8?B?cmhhc3RQNUxxbVdvK2hSdGNFVFRyUlVwQno1MC9TTEw2WmlNeTlOZllCSzRq?=
 =?utf-8?B?UzJ1Rm1qWHhpN2VuSGw5V01TOHJTUnVqYThQMnZwZ1B3UTg2dEVaR2FCTTgw?=
 =?utf-8?B?dktiZ2R4bEYrRmk2MCt5UExnUGg5d2Y2dEtaQ1JsckNvSFpKaFpaZEZiTklJ?=
 =?utf-8?B?Q3VVcExxeWNJZEtnMnp0V3RyTjJDMVN5b2t0YUhTK1lCV3M0Zmt3Mkh1cWpE?=
 =?utf-8?B?ajdSZHI0L1F0eWpyczFVY2s1NnloVDZlak9EOVNXQk5za3RZU1VWZFVwNDJP?=
 =?utf-8?B?VzlHNjI0V3FNR3lsSFE3WnpQR2dKOUtmSmwrekcrMlEwVHRxWUpKbFV1enVa?=
 =?utf-8?B?NkVhM2RzdGpEZU84VkJyNkhJRy9xMFNFTCtWTnpnVlZzYzVYS2Q3ZGdLUmxP?=
 =?utf-8?B?ZWhHdlJ2YUttOGhiY1JvQWl6UGpXTVZKUDdrNWlEVkRsV3czVC95bFlpTW9o?=
 =?utf-8?B?cVY1dVdmL3ZETjVvWGFpNnl5anlKQ1BrNVNkZHpQdjVpbUgxaER3RXkycDlE?=
 =?utf-8?B?WHc0bEU2bTJPenVEdFJOQ1RvNUlYVHNWNnpaZTViNEt0dE10NC9HcERjMzgx?=
 =?utf-8?B?YXlrc1pRMlREM2FpTjFYWmU2elJjUnNpb0xhV0RJQmJYclZ1NlFZMVg3ZXRs?=
 =?utf-8?B?WDZCM1UzY1FPdkVoZUpxMW1IajNEaEpETm1zUmV2U0R5MDZoTGJTcmwrZEll?=
 =?utf-8?B?Sm13dEVMWEZIVkUveXR4Q2NJK09rbFE3ODhOTkxxYmhrOEtHNG0xZkVWVHNO?=
 =?utf-8?B?TlgrWnhEYTJJcEpyS0dQTVRZWDZwSzFqd0lsQXF0Zm1NbDB1YXA0d2RLbHNh?=
 =?utf-8?B?MGg5YUMxR2dTcTVnMjNIRFpwVkNZMUsyQUwwU3l5NHZGMUlmaHptYjljQ0Zm?=
 =?utf-8?Q?6Lhm1x9rMZXF+aH/sUijDOWXP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05B246F44157254A84A6F340BB26C0BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3a6b14-48e7-408e-b646-08db9a2b95b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 05:26:58.8499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEus3WvPV89NRg2JQ8Ar7Yc8BKJxsipGmsDhlZzeKDgfI98NLJa0uiM0mp2mCuLTkDuwEE0EoIO8kZnB2X4WbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8xMC8yMDIzIDY6MjMgUE0sIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBUaGUg
aGVscGVyIGZ1bmN0aW9uIF9udm1lX2Nvbm5lY3Rfc3Vic3lzKCkgY3JlYXRlcyBhIG52bWUgZGV2
aWNlLiBJdCBtYXkNCj4gdGFrZSBzb21lIHRpbWUgYWZ0ZXIgdGhlIGZ1bmN0aW9uIGNhbGwgdW50
aWwgdGhlIGRldmljZSBnZXRzIHJlYWR5IGZvcg0KPiBJL08uIFNvIGl0IGlzIGV4cGVjdGVkIHRo
YXQgdGhlIHRlc3QgY2FzZXMgY2FsbCBfZmluZF9udm1lX2RldigpIGFmdGVyDQo+IF9udm1lX2Nv
bm5lY3Rfc3Vic3lzKCkgYmVmb3JlIEkvTy4gX2ZpbmRfbnZtZV9kZXYoKSByZXR1cm5zIHRoZSBw
YXRoIG9mDQo+IHRoZSBjcmVhdGVkIGRldmljZSwgYW5kIGl0IGFsc28gd2FpdHMgZm9yIHV1aWQg
YW5kIHd3aWQgc3lzZnMgYXR0cmlidXRlcw0KPiBvZiB0aGUgY3JlYXRlZCBkZXZpY2UgZ2V0IHJl
YWR5LiBUaGlzIHdhaXQgd29ya3MgYXMgdGhlIHdhaXQgZm9yIHRoZQ0KPiBkZXZpY2UgSS9PIHJl
YWRpbmVzcy4NCj4gDQo+IEhvd2V2ZXIsIHRoaXMgd2FpdCBieSBfZmluZF9udm1lX2RldigpIGhh
cyB0d28gcHJvYmxlbXMuIFRoZSBmaXJzdA0KPiBwcm9ibGVtIGlzIG1pc3NpbmcgY2FsbCBvZiBf
ZmluZF9udm1lX2RldigpLiBUaGUgdGVzdCBjYXNlIG52bWUvMDQ3DQo+IGNhbGxzIF9udm1lX2Nv
bm5lY3Rfc3Vic3lzKCkgdHdpY2UsIGJ1dCBfZmluZF9udm1lX2RldigpIGlzIGNhbGxlZCBvbmx5
DQo+IGZvciB0aGUgZmlyc3QgX252bWVfY29ubmVjdF9zdWJzeXMoKSBjYWxsLiBUaGlzIGNhdXNl
cyB0b28gZWFybHkgSS9PIHRvDQo+IHRoZSBkZXZpY2Ugd2l0aCB0Y3AgdHJhbnNwb3J0IFsxXS4g
Rml4IHRoaXMgYnkgbW92aW5nIHRoZSBjb2RlIGZvcg0KPiBkZXZpY2UgcmVhZGluZXNzIHdhaXQg
ZnJvbSBfZmluZF9udm1lX2RldigpIHRvIF9udm1lX2Nvbm5lY3Rfc3Vic3lzKCkuDQo+IA0KPiBU
aGUgc2Vjb25kIHByb2JsZW0gaXMgd3JvbmcgcGF0aHMgZm9yIHRoZSBzeXNmcyBhdHRyaWJ1dGVz
LiBUaGUgcGF0aHMNCj4gZG8gbm90IGluY2x1ZGUgbmFtZXNwYWNlIGluZGV4LCBzbyB0aGUgY2hl
Y2sgZm9yIHRoZSBhdHRyaWJ1dGVzIGFsd2F5cw0KPiBmYWlsLiBTdGlsbCBfZmluZF9udm1lX2Rl
digpIGRvZXMgMSBzZWNvbmQgd2FpdCBhbmQgYWxsb3dzIHRoZSBkZXZpY2UNCj4gZ2V0IHJlYWR5
IGZvciBJL08gaW4gbW9zdCBjYXNlcywgYnV0IHRoaXMgaXMgbm90IGludGVuZGVkIGJlaGF2aW9y
Lg0KPiBGaXggdGhlIHBhdGhzIGJ5IGFkZGluZyB0aGUgbmFtZXNwYWNlIGluZGV4Lg0KPiANCj4g
T24gdG9wIG9mIHRoZSBjaGVja3MgZm9yIHN5c2ZzIGF0dHJpYnV0ZXMsIGFkZCBjaGVjayBmb3Ig
dGhlIGNyZWF0ZWQNCj4gZGV2aWNlIGZpbGUuIFRoaXMgZW5zdXJlcyB0aGF0IHRoZSBjcmVhdGUg
ZGV2aWNlIGlzIHJlYWR5IGZvciBJL08uDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtYmxvY2svQ0FIajRjczlHTm9oR1Vqb2hOdzkzanJyOEpHTmNSWUMtaWVuQVp6K3Nh
N2F6MVJLNzd3QG1haWwuZ21haWwuY29tLw0KPiANCj4gRml4ZXM6IGM3NjZmY2NmM2FmZiAoIk1h
a2UgdGhlIE5WTWUgdGVzdHMgbW9yZSByZWxpYWJsZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4n
aWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+IC0tLQ0KDQoN
ClRoYW5rcyBmb3IgZml4aW5nIHRoaXMsIGxvb2tzIGdvb2QgdG8gbWUuDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
