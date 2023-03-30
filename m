Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB09C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 18:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjC3S4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3S4c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 14:56:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4E9DE
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 11:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B01ZlgiEbv/rySW4DYLIIU05Xg8GcDPv70dCDLt4DI0QGSlY5ubULUcG7EtS5m7Y2oNsiIri8nfKG6D/zvCnkYoJx5PxP8FYDRP9Ricq4WQ9h+tIkyiH9TrjsOaE8k5TMtNOMwvEA0oifBk3muN1Du/NlovcBNh7WC8csn0UP7+1eC6LXQFvk9ZosfQX4gnzH2A3oGb6xZoa8IWeIS+aMFsF+xY2lEYI3kyFhkp0qP8y63h56akpnox5kkD/TaarZyGMM7H/UgEwerI7kgqVN4368gDBTBl6xdlCA+EJxUSUeQ1j/wnINDgkv0c0MNhITZ47EFGBAcCodiiE8sJMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dET7PP8AmSP7C2qHy1XKunEhKG59iMUDc3Gls90kmCY=;
 b=noiPd8BHyQ+536O+uEZFK4sAo5dIKCP604ZECYHChgFv+OiSNQEIMDeBEznMMrz68d3CE6wLJGu6poRqpdKJwHnBCypUy6ncAuPgjeKmBoOHWxnRhbUFXT9+0CqJScysp9Y7lcQkw0mosw0uVZ97a0d0znihmYyIeGoAP0DFv1eMZx7EWNhVfQqTNmyn5bUne3MLBTAQ/s2p+Hhkccb/xsYYf7fezJprZXmaMP+vh8HeXPWg9MxYFATStOeXzdBsvBHIzZJBBt+Fwa5LRA51EhMU+jbM+MmAP4lLqkBFi/aP7ixP7WY7R3i5H0A8eK8ZG6/lPzf2lUvW02n5Um9SQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dET7PP8AmSP7C2qHy1XKunEhKG59iMUDc3Gls90kmCY=;
 b=Zr3apX0PdKXJK3US5tr6SJ+VAQhJDCuPfCkxUPXn8eSH6fPVXoIo9sMka7+mDnnsG8L9Y9nVRXJI3RKbEgvPZ10C33rzWn0E0rbKMMlXdZgAne53Mld2LNM39tcBUHPvGUZBL9gWhvFzNrp95gRBXTEZhmQ8wgeSEzpbd7eL4ZfwrkHgtM7+52tjshrVj+abAxtnkM7HCNQtZ9k/zu3LI8fUKzfocVPoSOSAAkO3Ei+k5HcfzPWqmNi+mqcfz2q31zwbTu7s8RaGbwefwjzxCt0iRLucht8W7LlrlhTowbjV2sUhudFXtDnK85meUpe9RWY5VG2lx3wamT5ZvHtrOw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 18:56:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 18:56:29 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "error27@gmail.com" <error27@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 0/4] null_blk: usr memcpy_[to|from]_page()
Thread-Topic: [PATCH 0/4] null_blk: usr memcpy_[to|from]_page()
Thread-Index: AQHZYn+hoxDH6ZqFxkS61zRTlY2vP68SXAqAgAFRoQA=
Date:   Thu, 30 Mar 2023 18:56:29 +0000
Message-ID: <02b39d4a-821b-0b86-5a64-7d4a706b79b8@nvidia.com>
References: <20230329204652.52785-1-kch@nvidia.com>
 <8f759010-cd5e-3ace-9b6e-ea4f896ee789@kernel.dk>
In-Reply-To: <8f759010-cd5e-3ace-9b6e-ea4f896ee789@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB8316:EE_
x-ms-office365-filtering-correlation-id: f7d4f866-8ef9-42da-c519-08db315078a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OnmNtNznvqtt0jh8eJMJ54ZZ+nYUQMVo4cf3Dav2vTzHHJOep3RwtwQ7LMx0mNHdBOeNTkhxDwOPSNX4GWpnn9VYz4Nf/whbLK6MxIlGwLBIOSU+OpDGRnMYMZ9h4OZECe9Y38VXEJLbpllbluAuGJDlI0mJrKzTjvi/MB4QEuwtSQWrH3TsVGhyb8uWpXdjvk5S8xLDhzTnT23/bxxi5S2xLKsy1UoYVzN8+QeqSr6GBFfpURe+owUf7XeGm+RbbxsVTGsRU0qeFSiinGtsHBqKY5SCU1YYgSse4YJcAZRiw0T8aDJDf1sO4KHCc92X0K55RjMXA8sw7CjzUwM6uDg7GLmmLLdkZ2MvWKzaaGm5ba92oNcZA7vmBfl1uqCLPOzs8zdpOOjGxzcuQyRALYtaHMlZkKhPoOT1AZIhIF/hxpdYM7hVFYs0wrT7CvY6mqaRSPiuVEzSxhDdCkqQhMyzDt7bnkLSmPWp/645isAYoNgDJT3qnoQm2/cr8tcDXKWd8f7xMoVqce9Si02VA5kyyfQMcxhT2feXHvYwibTSTNx9RdJFHFUQyMVKxVRvXWCZ876gvjaHPqFkCTjfqnWOKett7YcYRrx/JeeeThwiPYfxBLMhuQycJeYlM1T3krTwCR96oQQRrnHf8MvyFxrUiqRuVla9eiv93qt4r4fZrYg2iiCJ6hP5rvNBdQxw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(64756008)(66476007)(66446008)(4326008)(66556008)(76116006)(8676002)(91956017)(122000001)(316002)(186003)(6916009)(66946007)(41300700001)(6512007)(53546011)(2616005)(6506007)(478600001)(107886003)(71200400001)(31686004)(6486002)(31696002)(8936002)(86362001)(36756003)(2906002)(38100700002)(4744005)(5660300002)(38070700005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVNFNDN6bzcwNlZZNVBZc2ZuRTFLMlRIT0o2aEhMMlBZUHVRYk9LQnJlSkZ3?=
 =?utf-8?B?eVZ4eWFFaDU5cDlwZExHOTVSTnVyWCtkWWZWUS9kaFlHeWpsakN2Lys5QVZ0?=
 =?utf-8?B?ZDV6VUtZU0hMQmc4a2ZSYkJLT2pram5pWklHakVRSUZoZktrVi9CdGdHOWFr?=
 =?utf-8?B?YVVFMlRjU1hOempXckNZLzFHMGNnYmhCK2xIOWRZbUFKU2xtc29sVGtJZnJE?=
 =?utf-8?B?YmlzS1JCUFcwYmtvZkhUMEUzdUN3aWNEeHozWFZqUzdzZnlHS3dybVI1Rlll?=
 =?utf-8?B?V3pNN0lleFdwU2s2T2JUZmVwYWhVZjVKSmtTZnYxbVpSeFhPS2RoeCt4WHJk?=
 =?utf-8?B?QnZRMVEwVmxxMnN3MmgybnQrUHcrVnZ5MVNxQjYxVVJzMGJucnJWMENzN1pX?=
 =?utf-8?B?TXhuc1FtMmpPRkRuT2c1aFVTY3h4KzB0VytIK1FLeEdyOVI4bUJyRUI2dXVN?=
 =?utf-8?B?SlJMQnBoOEllT0dVY3M0aWxFWWgwaHNUTzdFbzh1dHFNNE1BL3RidGZoRXdu?=
 =?utf-8?B?dFVRODNVVk9JeXVJY1VQdVBjcWF5Ykx4dFRweEZ3WENVY2pOdGdUdDk5TFZn?=
 =?utf-8?B?eGtoQTdvU3cyeFZCNUFmcEpZTFVIOUNOd2xpRGxJSittcFRJUFJPMFdDc2tE?=
 =?utf-8?B?eThLY2Y5TDFKbUhpeDRWT0NPT3RCMGw3UUVGV1dsNnVEdUFlcGNucjhhN2p5?=
 =?utf-8?B?QmdZYzhyaHZ0Q252eHZFNHNmdW9CbTZTc1RUa1JucU8xSlJpWndpNW9JaVFJ?=
 =?utf-8?B?MExTaHVhTXRhVFhqUWczYTVVS1RIclNTS281ZEhFb0JzYWR6Q0Y1eVR2Q1pP?=
 =?utf-8?B?YUJTYTQ3T0ptOVhCaGI5SUUvdUVaZGhqbEdhbUZOS0g0NzdlU2plc0lvb2xC?=
 =?utf-8?B?MEJQQ1RTVkNidnlIVXFhZXJXTitMdTNsQUpGQ0djbTl5TVN4dXUyM0ZaN1lR?=
 =?utf-8?B?T2JqY2FBcWZYdk5kSGxkZ2FNYWJRY3grei9ZTkNQbnBMWWVON0UxK3F6cDI4?=
 =?utf-8?B?Tzlvd2RvOHZubXZlZU53WXlSYlAvNmFuRlRmalFFZlRjQU5TQW9LbHE3aWNC?=
 =?utf-8?B?SDFWc1k4UWN4MTQxVkZqTlpJUXVRSHQzSDJkTmhmN1prYWpDRGk2blBCcVZx?=
 =?utf-8?B?bUo2N0pFRzlSL3AwK3JUSnVQbG1nWEJnTHdZZU82ZllEbkVCK0w3anBFNVRj?=
 =?utf-8?B?bjlmY0ZDbXVJNnVIZ3NWWks3bEc1cWtlOG5sb3N3WlZGVXFNOW5mVWpmV0hJ?=
 =?utf-8?B?amNHOW9kVnkrUW1NWk9XZVNKcmNHVFB0NnNkY0o2LzZPVGhuRk51OG16WWM1?=
 =?utf-8?B?RTRCRVdDT0xCZCtBMXIvdWU3Z21jdFpLdXRxQ1FRNlhwSWNYanUyYzZnSUVK?=
 =?utf-8?B?bDNzaUlaVHFaTDdpdmxrRjNVc3c4Q2E0UXFEYS9TQXlRd0h4VFdvREpjVlhv?=
 =?utf-8?B?NE5SZTVPalJ4eVBObGt5VUNnRy9ld1hZWllDTGV1eGwyekpYVmg4MGdlaU14?=
 =?utf-8?B?OFYrV1c5UllSZE13dTQvcWxhbWprb3cvUm1ISk9DMXNTWmc1VTk1VVV2ck05?=
 =?utf-8?B?di9MNWxNU1ZjSW1jYzFaWnFwaThrR0tJOTZjdDFwUnpBOFI2eW9KUFl4eDNi?=
 =?utf-8?B?STNRU3VWeHpIazg5SVlvZ2ppNWovTUM1NXV5TFduK2hRREZmYURmaEp1dFV1?=
 =?utf-8?B?eDdHQXVhM1FFeDgySXNrK0l5WWl1dmNNdTRZa3huQ2hhQm5ZdUlLbWx1SUJS?=
 =?utf-8?B?WUlhSVJTVlBNSTQ4eWkrMjQwU3lvdVJqN0poN0V2ZStlOHArbXlHNHV5Z0ts?=
 =?utf-8?B?akNGTWNYVUlBQ2ZqVTZkUzZNOHh1Skg4cDhSTFhnWXliaE5WNzUwdWd4OFRq?=
 =?utf-8?B?Rm5HQ2tQRG1peHBKMEFjdTdtSGpWMGlTaEdvbktiVjRqQ3hvZzgyVFBpVzJ1?=
 =?utf-8?B?UWZhcmc2bEs3VzgrczNjdmxMN2k5bFplTktxb25vRTAyR1FqUmZHNXRNM3F5?=
 =?utf-8?B?Vldlc0pwSjJKcTJyNS9rSS9meWdBVkhsbmtzWGkxVklGUWtHZzdWenEyTlBI?=
 =?utf-8?B?M24xdWpWUVE3c3ZmYVMvRzR0K3gvMmdidzE1UlBhQTJCd0Rxa215TVRGb0Fq?=
 =?utf-8?B?aHQ5YTNORFVVdmZ2c1NlWHNhTHM1MTBYRmdla0RZZWdCVC9TTXFMVThYOGFZ?=
 =?utf-8?Q?Lb9iEAtKTBScdtDXxYf59gRezD2qOCzaBpOmCSiCxcjb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AEAB97366E57E4A9899B98C29C719FB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d4f866-8ef9-42da-c519-08db315078a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 18:56:29.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5a0VSG6Zp/GFEzR3RN8ND7mEt47Oc19FA8P71fqUFoXwbm8C8OaTPyvStsTTjahg855kjzY9oxzOsrbM48GEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8yOS8yMyAxNTo0OCwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gMy8yOS8yMyAyOjQ24oCv
UE0sIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEhpLA0KPj4NCj4+ICBGcm9tIDppbmNs
dWRlL2xpbnV4L2hpZ2htZW0uaDoNCj4+ICJrbWFwX2F0b21pYyAtIEF0b21pY2FsbHkgbWFwIGEg
cGFnZSBmb3IgdGVtcG9yYXJ5IHVzYWdlIC0gRGVwcmVjYXRlZCEiDQo+Pg0KPj4gVXNlIG1lbWNw
eV9mcm9tX3BhZ2UoKSBzaW5jZSBkb2VzIHRoZSBzYW1lIGpvYiBvZiBtYXBwaW5nLCBjb3B5aW5n
LCBhbmQNCj4+IHVubWFwaW5nIGV4Y2VwdCBpdCB1c2VzIG5vbiBkZXByZWNhdGVkIGttYXBfbG9j
YWxfcGFnZSgpIGFuZA0KPj4ga3VubWFwX2xvY2FsKCkuIEZvbGxvd2luZyBhcmUgdGhlIGRpZmZl
cmVuY2VzIGJldHdlZW4ga21hbF9sb2NhbF9wYWdlKCkNCj4+IGFuZCBrbWFwX2F0b21pYygpIDot
DQo+IExvb2tzIGZpbmUgdG8gbWUsIGJ1dCBJJ2QgZm9sZCBwYXRjaGVzIDEtMyByYXRoZXIgdGhh
biBzcGxpdCB0aGVtIHVwLg0KPg0KDQpTZW50IFYyIHdpdGggYWJvdmUgY29tbWVudCwgZmlyc3Qg
dGhyZWUgcGF0Y2hlcyBhcmUgZnJvbQ0KZGlmZmVyZW50IGNvZGUgcGF0aCBhbmQgdGhleSBhcmUg
ZG9pbmcgdW5yZWxhdGVkIGNoYW5nZXM6LQ0KDQoxLiBXUklURSA6LSBjb3B5X3RvX251bGxiKCkg
b25seSB1c2UgbWVtY3B5X3BhZ2UoKS4NCjIuIFJFQUQgOi0gY29weV9mcm9tX251bGxiKCkgb25s
eSB1c2UgbWVtY2FweV9wYWdlKCkgYW5kIHplcm9fdXNlcigpLg0KMy4gSSBndWVzcyB6b25lZCBy
ZWFkIGJleW9uZCB3cml0ZSBwb2ludGVyIG51bGxfZmlsbF9wYXR0ZXJuKCkNCiDCoMKgIG1lbXNl
dF9wYWdlKCkuDQoNCmlmIGFueXRoaW5nIGdvZXMgd3JvbmcgaW4gYW55IG9mIDMgY29kZSBwYXRo
cyB3ZSB3aWxsIGhhdmUgdG8NCmVudGlyZSBjaGFuZ2Ugd2hpY2ggd2Ugc2hvdWxkbid0LCB0aGF0
J3Mgd2h5IGtlcHQgaXQgc2VwYXJhdGUsDQpJJ20gZmluZSB3aXRoIHdoYXRldmVyIHlvdSBkZWNp
ZGUgLi4uDQoNCi1jaw0KDQoNCg==
