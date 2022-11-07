Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D50C43217
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 05:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKGFqR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 00:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiKGFqQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:46:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC3DE19;
        Sun,  6 Nov 2022 21:46:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nair6wW22S5nWes9QXBt+KzVJ/nu6yy9dUtE0u67FAAF07l+Glzw6sa9XfKls2YDqiSe2s1/5Bc/cCR/YvC4cr42QYHTifWq7Bx647tTW4AFwJ+I0DwDCKcIid3TrQbAFgmPHoxaKFLSuRstHoqcLf9hzuR9+6hs8S3IjafmXp9y/nn7dZJRXSJYDebofI9wxAWQynhjEvoBbu7AeRSgKiYg4Ou2EUTBC8QonT008V4nuMs8X2CVN2/ZOsYVQa/h+yxPbs8AC0bzQ1eMz0/lgCTXmUSFh5UoYZ/Wtkpkn+N6nY+CVDcaL8437EZGIZByMvkYIsv2MnywGUJVorzbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aJi7iaFFNaRMcPsiYqOmaV4YXiAmce3yoDOj8oFzhM=;
 b=MaBD7jquWXcl8oEJvm8JDtMuHf0V7gNWvRLyQsTwZwUbxII5f7tCR3CNi/vQK0sIPr0Eq+6Bqg2kwPDmwLbyNkYO6Zcy1UZRadNdaU4YLN5aADDT47/lSt8rKMiaSde1X70LIII1f/fwwD+5+Bq+uNKqqkv+7uvGbfJ7KoiJkSnVKJOZk5AZ3maPXcYrsti1NWoy35FkmdS5q0OQYG+Dx2cyyrxZT/d3Ehdgxr1NxGjHKn0mc6aKHK9R8X34/IzvIm4xrEq6O9OVvaFe9mwkQyHO9OTYdtKgMnYr/HSwpldusd+BoZGhRCL0vVrCusIc4ooHw9ymx66e/IwgiqSliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aJi7iaFFNaRMcPsiYqOmaV4YXiAmce3yoDOj8oFzhM=;
 b=AigA4qaGhYF29pK+YgJ2LVanAtxlPuiS26bcZ6N6XqLRyeHKf/r1tWHhhiOe3xGM5PNnKW/KeFaf4URyD/V+Jxb5DMFasce2qmC2xncIRsiPh5WIzOiqR1uybF2aoWwBACupOhX6lILxba+hmP1ass+NeuSumXwrBUa8b+Xn86BY1CDALGDEp9M9XCIeGVo49NNCo1I+mrx0Q7Nb1sN0v3+NGhJC7T4PB4jzt317I2r0D5FZVA1ygT2hf+as2nbzxzauuyoDMMgSTgZrfS0CbxafS9V4YcDJLHJkZrTei7769tz331+aKFDDGOELmnrnxOIWLevdrSgxFMuCS9o/gA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 05:46:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 05:46:14 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 6/7] ata: libata: blacklist FUA support for known buggy
 drives
Thread-Topic: [PATCH v5 6/7] ata: libata: blacklist FUA support for known
 buggy drives
Thread-Index: AQHY8kL5zHOY6yIbPUW0XJpHtzQolK4y8/gA
Date:   Mon, 7 Nov 2022 05:46:14 +0000
Message-ID: <7f1deafe-c075-3234-b7b9-d2862a0e25ed@nvidia.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-7-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221107005021.1327692-7-damien.lemoal@opensource.wdc.com>
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
x-ms-office365-filtering-correlation-id: 38997e4f-e63f-48fc-6e11-08dac08361de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1uFx7eQ/wU8RZkVg5cj+Xg8hX/T8lZsw2Fbjjv/8BW0IGamVBM+2cjcYqg7oCbf+j3Vj0DtUtcpFindfanoCSYVWJ8HeJWvETlndgcy1F3GVuxgWXlHrzlfg4/LX1Ns3XEZ0shkbuaH+3XS9kry6ZpaHgvVFhG3ONJuqiGKyWs71Z/w/+zD/F20VyAaAbhrNj7uvhqEEb/7LbjDLOXJ7Oyb12o6AapCOzcbPxtYh333d6vSmIVjstyjv/1PFNDnUR+izbIhoLgB7ermQwbz62HXzIlwTHo0xXfu2mgZ5V86ifI9xmD0XTWOr3PaYdztcnDuMQC2rDAi4yGSPVkGdgtTJN/+et8memZ16jElsJgzd3K1lh0whmyVm9vR3lcNJllL6KydUsc4R/P7QB1LFmny8626a4FWYL4X5iGzyKpwkzkC/0HAfdC0NFjunXuKaFafK2kJpx2xKAnb6ErckmaxLEFgQV12tcb6Ghx04qiGvSRrZMhNNPSNuSZdWwKlpFqP8mxvzWbEJyFdjp7TBe+izX053NStSK3r1akQuKgp8LGcE3PqlMF0YH5CoGnNi33r0Na1O5xfrx3odZ2VGj6Pum1ooJOhuj1wff8OboojbJluefzSg/fezcxjDL/zxIYao5Gorgwch5zjAVFjsbJiqMHFC6wZmBmYsSE2zRXbHoi0i6aBPiRdYdWtYUFINTVoNUe+z1sVJujAdOOHG8veHnnUi7xR4O9maA8Oh/UrD0qeDc7mSYUs7uwPeED3JrbG+OGO+uAZDIHvae/T/k9fj33NkXt1WnVaZb6CNBJYgtdIZk/UPiuC1SxEp0O7PpgCENZpJX2Bp637sIHjOPYFkwd9QP4f/stV+XabdTmZugu2bBOp2yuJHg77w80CbiaERxrdblnfAFIe/gXYH05T9dJJ3QVzWnNoIdz4AT2k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(38070700005)(186003)(6512007)(86362001)(122000001)(91956017)(6486002)(38100700002)(4744005)(2906002)(66476007)(966005)(66446008)(8936002)(66556008)(41300700001)(5660300002)(66946007)(71200400001)(2616005)(76116006)(4326008)(110136005)(316002)(6506007)(8676002)(64756008)(53546011)(54906003)(478600001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG05QWhva1FzZm8zVC9XTnRwaWRoY2dIS1BaejFLVGNUNEZqcXRwRm1TRHZO?=
 =?utf-8?B?cHpqa2Y0ZU1ybzRSd0dHTE5IbGM3Z3hBeUprdkh0M1gwMWk4V21xWk80emR4?=
 =?utf-8?B?NzNYOW96MWJrd0RTRXV4VWNrL3Bxcnc3aDUxTEhFVWthcnpYWHZReGszRXdq?=
 =?utf-8?B?TW5iZ2s2TUd4c0pnQ2VoSVN5Rk5NSW9PdjVWMExYbTFXWjdCNXRHWWlGaWlX?=
 =?utf-8?B?MGpwUXo3YzFoVGpsM1BGQWZ0aTJhSk9wR2c5SGRYeGxmVHhlVE1sdnE4V2Va?=
 =?utf-8?B?NEdGT2pyRXhUeHhIQktvallNMGpWWFpYYnVsRWljVCtmOWIrZm9yOVp2aXVV?=
 =?utf-8?B?NDlWUUNsTlJVem5sUlhRTzRabGhwaDFtS2FyV0p4azR2eDdtRDk2SENaTW1Z?=
 =?utf-8?B?MEd0YTlWdk8wWTRFeTNXYzJmN2FSU3dYYXpWalRQN3FzTUJwSUdVaUNIZ054?=
 =?utf-8?B?UDRrcThFajRtVlZhTlJCbEJmOERORXZJM3ZxMnVyckhBem9qWW1GaWx5RGtD?=
 =?utf-8?B?Uzl2UkNJMXIvVHJUVHI1RDkwTHVDTEdLV1FWb2lockxyT25vY2RBOGNLbnVO?=
 =?utf-8?B?cmZzb2EzaXNQTklaOWFiekNRb25GV0N1V2p4YjU4OXhudmtxM1JxRGFsTUtO?=
 =?utf-8?B?aWcxRkhzYnM0djVuTkQ4SFd2SXhEQ2thRWZnMno5bHZ0QnBQMFY3VExOQzRD?=
 =?utf-8?B?OHlvSWxsYXRuWHBSY29yaFlJS1lWb1lOcjdMWElocEtzc2QyZ0tLY2d0bnJ6?=
 =?utf-8?B?TStKb3AvMVZCQkFXV3p4a3VlanF6SzBTMXNoNWpucU5QdFYvQnEwLzlaWkJG?=
 =?utf-8?B?YzFPdHVuZXJmS0ZWdWVXK1didTY4dFR5czVTTVBRdmdRNTVsQ2YwU3JFSlNY?=
 =?utf-8?B?NkhPVnE0bGlZZXBBRndYOTNuQ2YvUi96MU0rYkhKSVFpMGd1V0hoMnNibWZr?=
 =?utf-8?B?WGMxM3hWU0lKWTE3VjF2MWZQNy9mSFl5clRDVHZ4dDNRRjVqbGV0R0FxeUov?=
 =?utf-8?B?U0NiL2xRM0ZZN3pDbjdNdGd1TU5CLy85NVkzZnhuWmYrbFByT2E0RjY4eFpn?=
 =?utf-8?B?Q1pLVE5jbVdUaXpNeGFHWDVac0o4MFExVG9kUk5FME9Tay9ndkE2L0JtYXF4?=
 =?utf-8?B?c1B6YU9ja3VROFE4am1hemlYdVVHODgxWG9YUi9pRmRNdnZ4dFJXaVhrMXhG?=
 =?utf-8?B?VFQ5WkUrR0toRDF5MGNocGE0UTlLVDV2MUhSWlRpeSttbDBxdWJjTUltM1gw?=
 =?utf-8?B?K1Y4ckNycDhzcllrMW4xVzFoVDAvSStnOHArNFMvMWJ2bUVOU0FWZFk5cHdw?=
 =?utf-8?B?MWQ3b2VMMkcvdzAzZE9LSWpGWnBLcUxOZXdVdzdSTTF3RWdSLzNtMGdrUWZh?=
 =?utf-8?B?UXp0d1lnYnF4N1NONGdKWlg1TFAxL3RvYmN2RFJSK3pCQnAwd0JiazRQU2JR?=
 =?utf-8?B?MGNHWUpZM2lsUkFhYS9ndkRtR0Z5dUhqeEV5Z3o3eWtLa0NkSHE3YVlnTmhF?=
 =?utf-8?B?SXhRbnhUSGlnVWUwTFFrN29wT1AyMDBLemZSenJaWFF5bm1Ca21CVWVjVjZO?=
 =?utf-8?B?cGZjQXhnSUFDaUR2UVNVanpndCtJSGlmR2Yvcmt4dEw1UDgvemp6QTAyQ2Rx?=
 =?utf-8?B?TVY5Ums2VHdNSWh6d25GMnZneTBEMUIzSjJHcGI4L3JBV3BZVXh6SWgxQ1Fk?=
 =?utf-8?B?REJMOUphczZYT3Q1SnJSZ1hnTEQ4RXkrekNxYWhTNmR6RENmOHNraUljSDJ5?=
 =?utf-8?B?ZkU5cXZwelBaNVhVelJBazduSG5jRUtmWnF0UytFeWxmcXNsajRnQlMyVXlB?=
 =?utf-8?B?Rm9XNWtrRWhvOUJnem4xdStIZTN3SWc3ZkxUSWNObER2c29rcTVWdXZxQUhm?=
 =?utf-8?B?Wk9EOTg3WnNhQU5NYXhvc1UxOGd6UmF5VWczRWxOZUlaSEdWZjVEK3U1bWZ4?=
 =?utf-8?B?a2VYMUozbko3bzE3MWJsUGRkV2lrVFU0ZS9EY2RZSllKYzdhMFlNM0ZWODl5?=
 =?utf-8?B?czJMZkVrOFY4WGRWZTkzRFppUitnbDVOMkdxU3B6WGFoa3pkdlhzVWdHaUdr?=
 =?utf-8?B?SEI4OVVQNm5YMStqZk8rUUNtOEh0MVAxekVmNEt6Vmx0MzNuM2wzRm4xelRG?=
 =?utf-8?B?ODJxUGUyL3ZiaHhaM1lZMEZUN1oyZGhHVWtjaDF3V1pRcHFtN0Vnd1hxRnhm?=
 =?utf-8?Q?rY4+Vew+SmsGKuXPxJfpnaBKcMCT1HCuidWFeiN24ATC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A282705F4D17844A9959D2DC7273C6D2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38997e4f-e63f-48fc-6e11-08dac08361de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 05:46:14.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pH1UmCX4gV8Kg99al8P/NR9FKeCJrycS8ojYHJ+SI8WO+XhEPbL1ZI2sHPttdGdjI5Bl5gMKdmkyCw+eEWKA3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvNi8yMDIyIDQ6NTAgUE0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBUaHJlYWQgWzFd
IHJlcG9ydGVkIGJhY2sgaW4gMjAxMiBwcm9ibGVtcyB3aXRoIGVuYWJsaW5nIEZVQSBmb3IgMw0K
PiBkaWZmZXJlbnQgZHJpdmVzLiBBZGQgdGhlc2UgZHJpdmVzIHRvIGF0YV9kZXZpY2VfYmxhY2ts
aXN0W10gdG8gbWFyaw0KPiB0aGVtIHdpdGggdGhlIEFUQV9IT1JLQUdFX05PX0ZVQSBmbGFnLiBU
byBiZSBjb25zZXJ2YXRpdmUgYW5kIGF2b2lkDQo+IHByb2JsZW1zIG9uIG9sZCBzeXN0ZW1zLCB0
aGUgbW9kZWwgbnVtYmVyIGZvciB0aGUgdGhyZWUgbmV3IGVudHJpZXMNCj4gYXJlIGRlZmluZWQg
YXMgdG8gd2lkZWx5IG1hdGNoIGFsbCBkcml2ZXMgaW4gdGhlIHNhbWUgcHJvZHVjdCBsaW5lLg0K
PiANCj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBKzZhdjQ9dXh1X3E1VV80
Nkh0cFV0PUZTZ2JoM3BadUFFWTU0SjVfeEs9TUtXcS1ZUUBtYWlsLmdtYWlsLmNvbS8NCj4gDQo+
IFN1Z2dlc3RlZC1ieTogTWFjaWVqIFMuIFN6bWlnaWVybyA8bWFpbEBtYWNpZWouc3ptaWdpZXJv
Lm5hbWU+DQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9w
ZW5zb3VyY2Uud2RjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBz
dXNlLmRlPg0KPiBSZXZpZXdlZC1ieTogTWFjaWVqIFMuIFN6bWlnaWVybyA8bWFjaWVqLnN6bWln
aWVyb0BvcmFjbGUuY29tPg0KPiAtLS0NCg0KDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
