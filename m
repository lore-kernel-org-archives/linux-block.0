Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2471DC001DE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 00:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjG0Ayr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 20:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG0Ayq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 20:54:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34417128
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 17:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQYgpE2uhbDuI/MA01KEFEWyHTehwZgSuNtiIqwCiFqGFWMs5P5fHwp7r3Z3zSFBHyA2uIbPGAZvfmEDwjaksrrJ4cGTtD7XTZK3LCRE8l5qz1XjpPq6i/0Zzrfj3c2jytemCaZ46+lOPSYT51UHyuaobDCGr9hV8n/T5YxDmQ/vLOPIAfHyJUDSgyNZfyo6aSIxvOAEOvm+N7xXPQObAC72OYS4Mf0ViyVc4ufZg4C2Klt8lHbmbwdq6mdOcn8NZBauLsjHq+dusVHCnzj3rm+kn5jkhdRcUJ9HS8GVHIk4gm7ykmnu7cIYuMxIhOnCMWzNCyy6PY+u9VOL7GgpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rABXfFfbIE06pH7OyBh8/tAF2bfZu0y7dUEoP6ZaVoE=;
 b=ifjLZgPDirhRumqv/DnzCFTffoq333twPxtTH3Qwpb6r++/TWSPWA67VrY5u1POdVCKwOmOpHZzwaItiAzEFp0b8SV1MDeWNXjB4rzDehIgpzkqZ7LeEG8UHiH3ZTSAXnh9+iHAA4q2hMOnuvLZMxVZIAaIzoHDOFSrrcyUKRNyHUn4NIPfhQLV/xQnAD4HNKFSeVS57DtA3C647Am8Ce1fJvx14BryxbLkWqCk0jPR4sqe0OO+Sc2wqzIWndfIySxgHmoWhgHWE2WjRZKDpB5cR0uQJax1AX20oW4GOJHgOf+DwjAoVyO0vGqFVbh/rAGW0UynXdMeCJ6Z2/rOGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rABXfFfbIE06pH7OyBh8/tAF2bfZu0y7dUEoP6ZaVoE=;
 b=hMGJE8pgKdIU6pH1n0oKyWBYaexj6aN3UF8joomFSP+sAStJLFycheWmjGwbpFI/vMk22b0mmVRojfk9qRkdbTFF1I2tLm9PJaA1ZbhGDwoh/LCckz4UqFpB8y8Aa5qX0IP10WbyPbE+tgdqSn/Xo/qTIU28FIcl4fH8FTfIE8qpPWKsL2pmrPknlODCDO1gmGdkkDy3ShFzaOhJGQPk6ZS/yz5NMd3JGBfYAofYsAK5nYfo2AzI+kwZaowGJ8IscTRR13zMkmx/4wBEReAFIKzG/DcqkQH3m+PkZhPd0M/pnxOCZkwpy+IOL5g7Shh9YJmKmB1Y8YgaDOc6oq8JMw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 00:54:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 00:54:43 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 1/7] block: Introduce the flag
 QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Thread-Topic: [PATCH v4 1/7] block: Introduce the flag
 QUEUE_FLAG_NO_ZONE_WRITE_LOCK
Thread-Index: AQHZv/hKWygJSaeDekuQfFIP2Yehg6/MyewA
Date:   Thu, 27 Jul 2023 00:54:43 +0000
Message-ID: <65bb97ce-f0e4-8174-0d27-64a8543d4bbb@nvidia.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-2-bvanassche@acm.org>
In-Reply-To: <20230726193440.1655149-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5347:EE_
x-ms-office365-filtering-correlation-id: aa4c0668-d47a-48bf-1941-08db8e3c10c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3xvPjfcCEWqclsxu5ax1ZGNDWgeMBhttGjViexaYaJPowm7cH3PZdw+rkW5lEHzKc/hz2yDVinAWSrBIEy0rG91v47vrDJq0k/Pu2HKeLp4S52pAj2C/Q1aRGJjfVIIo4PBTNfPWfBWkJ7iXG8dfVyk5zvEKCLRUZ6Yt5OfJ89Z2U/een8qO8z74Y/sEavivX4LxVs/+g22KOyHszEWoz0hBCCtOu4f6nZ2oBxI1A9ZGCHflUsKAzhKagYKzVrTvX8zRXdg3H/ZaPTzciGvOfPtut6DAMhMjggt0UO7MGhL8w0E6XP33d7Vbvcsl+RMFwfQ5/8veXeE7DXSwah8HkGN/yL5KWenLN9+hRUK5pOMtJGvUc4bCs8kzi8yQG7ulYp6DYE7vB85cK4x13plse/S4h5y6QCz9VxHOnvIA8tQDrnIzAcWaTBpK/ze472OMBHHp3h/6sQ1QcD7zYJy4zkT8veJhzX0H901Pl57iRKAFXfzFuZaI14EW6fs0TXSr1FEafK+01FbMR37cZtskafkI5ABra6+cICCHrJll5tSdBlrBby45Vmo/CIwmeLWWDukfZe1HqOCOmmFL0MgxBLOj2uWcwOHWxRpPYcr4NMZ61JzpUOh1joSBe/mGhWLLRqShiLOQoVJ3tI/1gyhHYKP83qqWjaMXdFz2spFtmsZwchSU/xncQFpF+mOlE3V/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(31686004)(2906002)(83380400001)(38070700005)(2616005)(26005)(6506007)(53546011)(76116006)(91956017)(186003)(71200400001)(6512007)(6486002)(478600001)(66946007)(54906003)(38100700002)(122000001)(86362001)(31696002)(64756008)(6916009)(4326008)(41300700001)(66556008)(66476007)(316002)(36756003)(66446008)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXhJVHFnaE95WUNsOFQzclVEVHorMjRtSEo3dndhVi9kSWlRakFCa0w2RWFV?=
 =?utf-8?B?OFdwNW5zUFFmY0xEcDVEZlA4N0FKVVJtbGpoVWw2TDJhNHV4Z0R1T05iZ2po?=
 =?utf-8?B?WUdoRTd4dlRZKzZ6VVJWK0tuNEswYU1tSTh1eFR2MVZxeThZSUNyWmtGMW1H?=
 =?utf-8?B?bzM4SVhVQUhiVWt1K1lWTnM3YjBCZ3JML1hIcnFJUklHei92QitDamxReCtR?=
 =?utf-8?B?MmRDQWxqTEJkKzRVQmZweS9zOGYzME4vYzMvUDF3b3VrMEZ4V3FIMDYwRlUr?=
 =?utf-8?B?RnIrcHBKd1Q3WVBpbUxwb0xnZW55NmpkM0ZCZ1Z4M2JTK3RFY3dGblNjQWpX?=
 =?utf-8?B?SkNwUnhaVWxYVytrVXNxRytuRWFtQlVWdDRuRkFLb2F4MFEwTzBEQjI4OGx5?=
 =?utf-8?B?V1NXSFBRUTNHOUNJeVpvOFlRVHlZd0tMbG4zR3JiaDlTb1kxYUJNZzd2M0tK?=
 =?utf-8?B?T0htLzNIMnBrS1l3cDVsc08zSXNnRG8zTHNGWlB3ME9Pc05DUlFPekd1Z3hE?=
 =?utf-8?B?YWVQalJHMDNXbE5TeDZYUmdmZlRsMzJiY1RKSEh3U0M3bFYxOHh5OVZUZFpo?=
 =?utf-8?B?YUY1TnpIRmV2c2YvRkdBNUh5ZFBITmgvUVlBNHRDUHF2NkhTN0gzL1dWaWVB?=
 =?utf-8?B?Z1lDa1BRU01GRGJIMlpEMGwxL0Z3SWtUQ2JaQnM1WWYvb0xUTEI5Ym03L3lZ?=
 =?utf-8?B?YnQ1cHBFOHUyMEQvbklzTDlYdTNCUi9LWTZEaU95RGVJNVRkazdxb29xczIv?=
 =?utf-8?B?WTREeStiVVBZcjJrTGNyaDFYMWgrMTYxZEVVMXRoRzUrQXpiTXp5eGxvREYw?=
 =?utf-8?B?Y3AwOFI3aDVUbjJ3elY0STNYQ3QwbDZKRFp1TTFZRXhkcGQ0dThkMXl4NVhU?=
 =?utf-8?B?emQxS2Z0Ui96SnJsejFOaitKQTUvVVZES3lSczdicUl2Mk5hc3BXQ2pxeFdW?=
 =?utf-8?B?dUxyUjltTVBDc1pZcGZ3cHNCZEhpbWtNOWFNeUt2WEVHMFZYRUw0dEMvcjRw?=
 =?utf-8?B?VzFWamU4eGx3NzgzNHlZT2k4MEFZNTM5c3hVdVdKYnJTOGl2VDg1dXdmUHgy?=
 =?utf-8?B?N3ZYaDNBMWk1R1pCdGtKSWVDVExVNWJjSnlydmJIV0FVSTY5dW5wZ3hGVnVr?=
 =?utf-8?B?cm5xUExvQXBVQjJseTFYVEduV1ZqeUFXalZIU1F2cG1sblZUa0hNTWhNYjlB?=
 =?utf-8?B?K1MzVWg3cXZvRVJzVmhFWXd1RFoyODI3Q3R5bTRaYm9pV29MT3h4a1VtRC9k?=
 =?utf-8?B?akt2c0gvdTRBNE1TV0dSb09DdU1iZmFqaWEwelQ4VGFYTkxFRGtGRDh1eGFa?=
 =?utf-8?B?MWlNTkJGdm5xRkNYa0tlTkhSS1RPSHRpSlVNYnRXSzJUeVdhOGdOOWIzWGVC?=
 =?utf-8?B?ZHRKb2NMTGJEVzNBb2dXano0ZjVud1F1R3dOZGpuYnRNZlB1bXFpNUUvd09k?=
 =?utf-8?B?Q05lQnBSYisrRnBDWmU0bDhVcU5kTGZWVFNxWjJJbmRWWEs5NU9lQkUwZGZm?=
 =?utf-8?B?Wk11cS9HOXFSWDRLQ2ZSOU8xcm51aUdML3ZsVS9XMlRITUdLWlhZYUNYSStv?=
 =?utf-8?B?MUxzWno0K2F5QVhUVG41aWRsYmZRZXJkSkFBYjlkWS8yYjMxcjhOQVdkVTBM?=
 =?utf-8?B?eUlnbytMd3NRSzQ1WS9BaFlxa2dJM055MGRHMjkrc0NqVXdaY0JLaFVLUHJv?=
 =?utf-8?B?eEhtTlkzWS9IVkd1VmNmOGRjZDNGR0dSNGlHRTBiY1YwaXZkVXg5dW51MG5R?=
 =?utf-8?B?SmY4eCs0S1NtUVUreE1ONW1ndUtlMEhHZU5zZW5LRDdlS0RYN2xKd09hTWVi?=
 =?utf-8?B?QnpXT2dTdDcxQVhwSE1FWjE4K1Z1amVSaTMyMmRyMk1qOEg5N0pJY2lCekZC?=
 =?utf-8?B?YmNFZzltdWI0Qk9LYnNzMC9YOXJhRTNLQ3lkNFUwWk5UTWpZZkRWeXNhSkVQ?=
 =?utf-8?B?eDNNRFJjdDRWdmc1eTRPeXdhUDFWN0hrTHM4bHZsd3piVjRSUy9hVk1vOUE3?=
 =?utf-8?B?Z1Y3WXY1Y29NWWFqdDJHSkpvR0ozRGkrK0tYWUI1NDNzZ0pwbm8xczlxSjNZ?=
 =?utf-8?B?M0RHOWlCclhOYThGeXZwQTBnZ2pvRkFpTTRtMmZEU05WRFM0NldwK3BCZE1p?=
 =?utf-8?Q?efNZ2ELHQoqLtKmYm1vho1Wn/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B78196FDA2B649A5D3BE2770DF3884@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4c0668-d47a-48bf-1941-08db8e3c10c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 00:54:43.3446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHdKFrb4gLcSZjajk6pkKQlGnyGb1FYXUGuP9fuIVTV809+clwVmiPXcqNb+maiCq2sdh4bVyOP3qijAcCpncA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8yNi8yMDIzIDEyOjM0IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IFdyaXRlcyBp
biBzZXF1ZW50aWFsIHdyaXRlIHJlcXVpcmVkIHpvbmVzIG11c3QgaGFwcGVuIGF0IHRoZSB3cml0
ZQ0KPiBwb2ludGVyLiBFdmVuIGlmIHRoZSBzdWJtaXR0ZXIgb2YgdGhlIHdyaXRlIGNvbW1hbmRz
IChlLmcuIGEgZmlsZXN5c3RlbSkNCj4gc3VibWl0cyB3cml0ZXMgZm9yIHNlcXVlbnRpYWwgd3Jp
dGUgcmVxdWlyZWQgem9uZXMgaW4gb3JkZXIsIHRoZSBibG9jaw0KPiBsYXllciBvciB0aGUgc3Rv
cmFnZSBjb250cm9sbGVyIG1heSByZW9yZGVyIHRoZXNlIHdyaXRlIGNvbW1hbmRzLg0KPiANCj4g
VGhlIHpvbmUgbG9ja2luZyBtZWNoYW5pc20gaW4gdGhlIG1xLWRlYWRsaW5lIEkvTyBzY2hlZHVs
ZXIgc2VyaWFsaXplcw0KPiB3cml0ZSBjb21tYW5kcyBmb3Igc2VxdWVudGlhbCB6b25lcy4gU29t
ZSBidXQgbm90IGFsbCBzdG9yYWdlIGNvbnRyb2xsZXJzDQo+IHJlcXVpcmUgdGhpcyBzZXJpYWxp
emF0aW9uLiBJbnRyb2R1Y2UgYSBuZXcgZmxhZyBzdWNoIHRoYXQgYmxvY2sgZHJpdmVycw0KPiBj
YW4gcmVxdWVzdCB0aGF0IHpvbmUgd3JpdGUgbG9ja2luZyBpcyBkaXNhYmxlZC4NCj4gDQo+IENj
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gQ2M6IERhbWllbiBMZSBNb2FsIDxk
bGVtb2FsQGtlcm5lbC5vcmc+DQo+IENjOiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQo+
IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvYmxrZGV2LmggfCAxMCArKysrKysrKysrDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2Jsa2Rldi5oIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaA0KPiBpbmRleCAyZjUzNzFi
ODQ4MmMuLjA2NmFjMzk1ZjYyZiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9ibGtkZXYu
aA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oDQo+IEBAIC01MzQsNiArNTM0LDExIEBA
IHN0cnVjdCByZXF1ZXN0X3F1ZXVlIHsNCj4gICAjZGVmaW5lIFFVRVVFX0ZMQUdfTk9OUk9UCTYJ
Lyogbm9uLXJvdGF0aW9uYWwgZGV2aWNlIChTU0QpICovDQo+ICAgI2RlZmluZSBRVUVVRV9GTEFH
X1ZJUlQJCVFVRVVFX0ZMQUdfTk9OUk9UIC8qIHBhcmF2aXJ0IGRldmljZSAqLw0KPiAgICNkZWZp
bmUgUVVFVUVfRkxBR19JT19TVEFUCTcJLyogZG8gZGlzay9wYXJ0aXRpb25zIElPIGFjY291bnRp
bmcgKi8NCj4gKy8qDQo+ICsgKiBEbyBub3QgdXNlIHRoZSB6b25lIHdyaXRlIGxvY2sgZm9yIHNl
cXVlbnRpYWwgd3JpdGVzIGZvciBzZXF1ZW50aWFsIHdyaXRlDQo+ICsgKiByZXF1aXJlZCB6b25l
cy4NCj4gKyAqLw0KDQpJbiBmaXJzdCBnbyBJIGdvdCBsaXR0bGUgY29uZnVzZWQgd2l0aCBhYm92
ZSBjb21tZW50LCBob3cgYWJvdXQgOi0NCg0KLyoNCiAgKiBXaGVuIGlzc3Vpbmcgc2VxdWVudGlh
bCB3cml0ZXMgb24gem9uZSB0eXBlDQogICogQkxLX1pPTkVfVFlQRV9TRVFXUklURV9SRVEsIGRv
bid0IHVzZSB6b25lIHdyaXRlIGxvY2tpbmcuDQogICovDQoNCkl0IG1ha2VzIGl0IGVhc2llciB0
byBzZWFyY2ggaW4gY29kZSB3aXRoIEJMS19aT05FX1RZUEVfU0VRV1JJVEVfUkVRDQpidXQgaWYg
ZXZlcnlvbmUgZWxzZSBpcyBva2F5IHdpdGggb3JpZ2luYWwgY29tbWVudCBvciBpZiBpdCBpcyBu
b3QNCmNvcnJlY3Qgc3VnZ2VzdGlvbiBmZWVsIGZyZWUgdG8gaWdub3JlIG15IHN1Z2dlc3Rpb24g
Li4uDQoNCj4gKyNkZWZpbmUgUVVFVUVfRkxBR19OT19aT05FX1dSSVRFX0xPQ0sgOA0KPiAgICNk
ZWZpbmUgUVVFVUVfRkxBR19OT1hNRVJHRVMJOQkvKiBObyBleHRlbmRlZCBtZXJnZXMgKi8NCj4g
ICAjZGVmaW5lIFFVRVVFX0ZMQUdfQUREX1JBTkRPTQkxMAkvKiBDb250cmlidXRlcyB0byByYW5k
b20gcG9vbCAqLw0KPiAgICNkZWZpbmUgUVVFVUVfRkxBR19TWU5DSFJPTk9VUwkxMQkvKiBhbHdh
eXMgY29tcGxldGVzIGluIHN1Ym1pdCBjb250ZXh0ICovDQo+IEBAIC01OTcsNiArNjAyLDExIEBA
IGJvb2wgYmxrX3F1ZXVlX2ZsYWdfdGVzdF9hbmRfc2V0KHVuc2lnbmVkIGludCBmbGFnLCBzdHJ1
Y3QgcmVxdWVzdF9xdWV1ZSAqcSk7DQo+ICAgI2RlZmluZSBibGtfcXVldWVfc2tpcF90YWdzZXRf
cXVpZXNjZShxKSBcDQo+ICAgCXRlc3RfYml0KFFVRVVFX0ZMQUdfU0tJUF9UQUdTRVRfUVVJRVND
RSwgJihxKS0+cXVldWVfZmxhZ3MpDQo+ICAgDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgYmxrX3F1
ZXVlX25vX3pvbmVfd3JpdGVfbG9jayhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkNCj4gK3sNCj4g
KwlyZXR1cm4gdGVzdF9iaXQoUVVFVUVfRkxBR19OT19aT05FX1dSSVRFX0xPQ0ssICZxLT5xdWV1
ZV9mbGFncyk7DQo+ICt9DQo+ICsNCg0KSXMgaXQgdHJ1ZSBhYm92ZSBoZWxwZXIgaXMgb25seSBj
YWxsZWQgZnJvbSBibGtfbm9fem9uZV93cml0ZV9sb2NrKCkgPw0KDQppZiB0aGF0IGlzIHRydWUg
b3BlbiBjb2RpbmcgYWJvdmUgY2FsbCBpbnRvIGJsa19ub196b25lX3dyaXRlX2xvY2soKQ0KbWFr
ZXMgaXQgbW9yZSByZWFkYWJsZSB0byBtZSB3aGlsZSByZXZpZXdpbmcgdGhlIHNlcmllcywgYnV0
IG90aGVyIGFyZQ0Kb2theSB0aGVuIGlnbm9yZSBteSBjb21tZW50Li4NCg0KPiAgIGV4dGVybiB2
b2lkIGJsa19zZXRfcG1fb25seShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSk7DQo+ICAgZXh0ZXJu
IHZvaWQgYmxrX2NsZWFyX3BtX29ubHkoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpOw0KPiAgIA0K
DQotY2sNCg0KDQo=
