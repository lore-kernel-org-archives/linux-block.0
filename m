Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1048ECAAD1
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 12:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiHaMo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiHaMoZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 08:44:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7136FD3EF6
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 05:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVhNRZxmW39OnVd7CtFw/er3A51ErI3rwR4DUJ9+fBQCPsK8HYVaNd75LL4ZcxHN2PNEPvYLokzQQY3HrTY+I92rRrM72upfpC7YqVRSitBM9O8n3VBYu9rZnxBGH+vXr8YP1RkqV/2TOsSM36ssSBDuzAKTJkDsjdelVoGkn7DG8qiaWNCbnTZBYIgH+6p4671fsSZz00XGQUyQD3DrH50hYNtVzLPqjhvxeLXbL80gGZNKgaWjPa7U3PtooXufyTQdwJrEAaSNQ597V61ka+yAkcM3jYJ+ZJfxOO+njYot/BrcsUJiUvlWAd4XRQpb/iu+uHUbmD40oqmvArDTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w/7hPnsloUvhtMvLAS7I77K+BgluMpxFvP/7Jt0C6U=;
 b=eUJIiLZ2FNXgYYe59pA1w8+XMUZNrt9ypLb6D/kd3R39DJB2J8ZRtNH8xwW029mhHQDlNQTOhUdi7qxCV8rmEVsuYVtjlfQ6TXuEKtnXB0K1DgeuZUD4FrlgGTlU81t5idhtfcM3XqSf+J47JW+q3rFFY1AwiznqNjXoUzG7yxOuP906H1VreoXgkE8YudaPMOrFx8TmQdBDs9vr40D+4ommzknrpggy+iblYbLunOKUfctgAMkVizIqJWOv3lEdcHuPKCmOhTxCDwc8ZlrYuHtrSLEzX4fzpisjt+smORI/uKNdNIvaxTSneIPKnqwf8fTdmt+zpbWZxoXAOYZ9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w/7hPnsloUvhtMvLAS7I77K+BgluMpxFvP/7Jt0C6U=;
 b=ZpA95rDxp+JyH+TUoGK8qhZFcpUfb2U4hZuB4PG4n0y2/eTA209gWnuid6NvfTV1cD8Sh0G9OPXq0/zHWdomQNHUIOIoP4NvFphVHRMq6Tv2zl3M1Wblmtxm0PDzl1KgglaNf1NTTXzGwqlIu04KpTGLWGquAMl4pRmm9v1mae1nnOpWO/TDd6/OwZqH3NbI12I2UWE8lk3yVLAraG+udslfLMgPeAV622F5XuWFc8AJdLHO3xnEiRYkJSQH/fU0z4Ln4UJNbeQy4bWXgrYzqIUlKTgduVGzdKOr9kNzVW7lX1U9QQgxMoW7Y1xUhrwSlBLjH6wpcK47cue7waWHkg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 12:44:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 12:44:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v1] nvme/045: test queue count changes on
 reconnect
Thread-Topic: [PATCH blktests v1] nvme/045: test queue count changes on
 reconnect
Thread-Index: AQHYvTJ8iFc5qToyVU+KAdSmgwXhh63I9GGA
Date:   Wed, 31 Aug 2022 12:44:20 +0000
Message-ID: <a135eef8-ee5a-fdc9-c8c3-f591b3fa0d2e@nvidia.com>
References: <20220831120900.13129-1-dwagner@suse.de>
In-Reply-To: <20220831120900.13129-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41af5c40-91ca-49f5-c3a5-08da8b4e8638
x-ms-traffictypediagnostic: PH7PR12MB7378:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mCuvBMnias+2F5so/eQN29CtLodwIY1UVdJod9R2yPTu+ZIDYMqBlqRFVnXtxXdEzKbxvkPyWtn3AKkUOr5qn2lA1B1VU2x82/6qkRsizLVlbvo4cHPsraqI77+fy7J/jhM9g46h1eZYAj+96anqSuqVvRV2C2bV/OqDSt5sVDN2hwhbQ6Rs9R65TxPBtI4YUqoU5hLO1HQ5Uf3pCtA3T9gLiVfhMe4Sm5BcGVXrpB2GwFl6AWmYaDkvAmfpkfZC/vIb3+bl4KXpw/0QPxeAle12fA64b5Cu4JMEbNCgFCijPTRNZ4TAMIl7g4iUeqdTuCfRHqu7+7hvPJW+zKjw6bC3RcbdMJjzLpcWl+ONPOij2n/inukS6MWw9Uf7YCikBWTYl2SZ1XhkgVlXzVKck/QY6VqZKet7ETtE/V4S7KEKo4+9Y6fP8CuEsT3sgMYhFVZt+xknCBHKlO8njHuauK6BQpPGsVEaEEu22WJNYgx5fQ8VdFuBk45mrrZBsl0C6hC4GUjfQk+0nh1KXg1R15DYmKOwXMKYXMFRO5URRUh8GYeJ3N1d2+7BcTDuriOemiVYqR3rHJfaLAPQCdY1SoXNx8ktWeyBnAH0y7QEHWINhhCKPBd/qE2fuu9BAWVg3ESDpLmULHAfX9GIjnoXczyKY00XML65r5lZcOunYECA0c30B2VYFjpWqLDluzpa1q+/o7AWidNxFsf248Hka6VTpaIXgRT/7mAi1FNczKRlNAGwdDLqG+YccEbXCoKW1pMoKa35ZsHp/OjudJtsHGIM8C53j1pgi71cKdzWCqBCNHjjML/boAU1S7PKugTgNSue8z5u1VeaapExdNHRcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(6512007)(66556008)(6486002)(53546011)(71200400001)(478600001)(2616005)(31696002)(86362001)(66476007)(66446008)(186003)(64756008)(5660300002)(6506007)(38070700005)(8936002)(2906002)(8676002)(91956017)(36756003)(4326008)(31686004)(6916009)(122000001)(316002)(41300700001)(4744005)(54906003)(38100700002)(76116006)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHBXUHpPaWJkQTROdnVINjJwdDNkT0kya0lpZTVMa3BKdVJjdi9RaG5OeGZR?=
 =?utf-8?B?UnUwbjhZZVh0TG8vM0xXNDM2d2J3QjJ1NEVRWG5FcGRKcTVJcHE2K1Jnd24r?=
 =?utf-8?B?YWdWSjZKd3E5aXRhQ0xqc3psb2hXaldQbHBIYzN1cm9lQktCWXlKOHFsNGcr?=
 =?utf-8?B?dzZWK2hxZlNnbmtCZ2tMMG9lK2JqaHpPeEU5d3FSYWhVQmZtaWNJcU83NlNm?=
 =?utf-8?B?RlRIREsyWE84dm5wSzZrYWRNbzJuRjNROEdKeXpVT2h1N1gwWUdPcEdDRktK?=
 =?utf-8?B?T3MxMnI3eXFmT2dsMUl5VWg3Sy9FN0EvektlWXVxdit2S3pQUUI1bUVHQ2JJ?=
 =?utf-8?B?S3d1eStyNWtnQzB3UXQ1NThtYVB6UnMyQWtRVmc1UjY2TDhIbk1SWXR2NCti?=
 =?utf-8?B?QXNuK2Q2SzhmeDB1NHZTNklrTXBaa2llUnhwclhJZlRhSytZMHZEREladVlh?=
 =?utf-8?B?TEpzRVU1TFR2M1luYXpMSUg5K1JkVU42Z21kOU9SMUFmT0Y0Q1JLNFFjaVZ0?=
 =?utf-8?B?bVNvR0NySlNJbU1Gdmo4OHBKdTc0R0JsdndVaCtRS3RzUitITHN0akJBOGwz?=
 =?utf-8?B?OHlLNVN0Qm9jUGQwSnVYY00vRHZJbVVjeEUwcm9PeEw2SCs0RGI2QVpBUjFt?=
 =?utf-8?B?S2RKQ3JyM2k5LzA4YjdrbWJ1ZVVIdmZoYUg0MEV4ZEpGeUYxYVEzU3h2bVN5?=
 =?utf-8?B?RVY4R0xEd2dVbzBESUJvMzFuMEpWTVVUZ21VUlZ4aVRvWjlORHIvZjlKRVdU?=
 =?utf-8?B?YVM1UTIxdURnY3RFMmVDYWxyMU1oSGMwUE9Lc1JENUF2NjlBNWJkbnhCdE9D?=
 =?utf-8?B?YlYvZ1M3YUVqOC9PWmlyaDQxZDJJaWpFZEkxWThpT2NSNGEyZThVUEcvVCt5?=
 =?utf-8?B?cjFnR0R4aU8raFNEMFk0cHdJTU5mYldORkNlZE1NQ2g0b0xFRlY3ckdKYlA1?=
 =?utf-8?B?QjR4cHVqdkw2Q0NMbnFNdldRYm1UbU1wYmw3UHozem1HZmwwdUdzN3dpOGRE?=
 =?utf-8?B?SFlHUVFSRXowdGpYbTRPMnBEOFZSd1AvSU40KzdaaWVrTExaREs5MnpuQWh4?=
 =?utf-8?B?akR3ZDR0cENxZDFSVHlBekQ0T290SVdRMUNnNGZGd21XME10VXIrWHI3L2VR?=
 =?utf-8?B?MDM2cm03a1QxaTlTSFlqT05nRVRGbW9UQjVibnJKdkhNQjVRc3ZlUmJ0UENn?=
 =?utf-8?B?d3BteHNSZmhFbkZoSTk5VlBybUpWamd3Ujk4Q3dyVTlIQ2h4eU9GQlVEaDU4?=
 =?utf-8?B?b3VTS1JyaGNhMHBlWGNERFdCSS9JVGUzOWFOU2JxWlF1byttVXM2UmJ2KzMr?=
 =?utf-8?B?VWxtNitMOVU2bndNKy96ZjVmTE9oa3FTQnRmbndUa1NUTHM0VjNuZE53MFc3?=
 =?utf-8?B?cWJJOWVZSyt3QXJKQ2hGdUYwV21kNFUxek1ubGVhdmN0dFBiZUpiSjZzcS9h?=
 =?utf-8?B?V21HbjNYdEUrZGN4ZGg0T2haWTJzMWVFeEJJOGtGREl1OVd4YTNpL1lPWVAz?=
 =?utf-8?B?dlMyK2JJRXVwc2Q2eFJFMHZIbXRGOWIwdjZtaTdwYVhRZ3JVcy9BTXFSMldi?=
 =?utf-8?B?K1JwWUVFcHhqeWpienNTK013U1craDZpUExJL1ZaNXBhdkVqOTZXTzkrOTBt?=
 =?utf-8?B?WGkvZFNsc0ZoNEhycTYzK0J0MHk2MGxUS25kaDY5YVAra3RHc1AvOHR4YmVF?=
 =?utf-8?B?OURrM1NZbHFHK2dwU1kwZm1ReURxMTVHSExwRElBUHVWRFBkcEtUWk9uaWlX?=
 =?utf-8?B?Vmw3ejE2YTJiMUFvQ1haMnA4SStiSytFcDJEMVR4REZTWm9XOEtSY29YSW9l?=
 =?utf-8?B?NWFOWWdPYmZSTzdjNi9VU294YWJHTGlyWTdyOVhwc0VXYUZld3JPZEpIRHpF?=
 =?utf-8?B?OEVFeThTdUVZU09XNE1VWDEzbEwzVjlqTG1GaGRHR2VYTHJFNHdnMmtTbmQ1?=
 =?utf-8?B?WlRkY0swT3JVZTdVRE1hS1NvdjFjWVhiMmtMV0NWMjgrbHNuUGVCV2xPdnBU?=
 =?utf-8?B?S1Z5V1pzMjd6b2tsM3ZZbUFCb1Jyb3dac2dYT05vbi9FbHFDNDZqa1duUnhY?=
 =?utf-8?B?cndXNkg5SzN4SHh4eHE4V2UyZjREb1pTODVXd2hsWmMyeEFYMUhFelE4azdn?=
 =?utf-8?B?R1Z5cHoxbjM2WFRpcTUzQytEdnpMdWlnOG1RSzc3eDhNZHZ6cUlJUktMNXhX?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8289530DC2441B428D68E3C702EAFE83@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41af5c40-91ca-49f5-c3a5-08da8b4e8638
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 12:44:20.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+n6n3f3fuMh7kSzsnRhe2lPGh/TRziSzCr7Jqr9RVR57BbMRa/TDVNhhww6lro4eV0j4nzg1B5uYxbjol4HtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8zMS8yMiAwNTowOSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gVGhlIHRhcmdldCBpcyBh
bGxvd2VkIHRvIGNoYW5nZSB0aGUgbnVtYmVyIG9mIEkvTyBxdWV1ZXMuIFRlc3QgaWYgdGhlDQo+
IGhvc3QgaXMgYWJsZSB0byByZWNvbm5lY3QgaW4gdGhpcyBzY2VuYXJpby4NCj4gDQo+IFRoaXMg
dGVzdCBkZXBlbmRzIHRoYXQgdGhlIHRhcmdldCBzdXBwb3J0aW5nIHNldHRpbmcgdGhlIGFtb3Vu
dCBvZiBJL08NCj4gcXVldWVzIHZpYSBhdHRyX3FpZF9tYXggY29uZmlnZnMgZmlsZS4gSWYgdGhp
cyBub3QgdGhlIGNhc2UsIHRoZSB0ZXN0DQo+IHdpbGwgYWx3YXlzIHBhc3MuIFVuZm9ydHVuYXRs
eSwgd2UgY2FuJ3QgdGVzdCBpZiB0aGUgZmlsZSBleGlzdCBiZWZvcmUNCj4gY3JlYXRpbmcgYSBz
dWJzeXN0ZW0uDQoNClBlcmhhcHMgY3JlYXRlIGEgc3Vic3lzdGVtIGFuZCBza2lwIHRoZSB0ZXN0
IGluc3RlYWQgb2YgcGFzc2luZyB3aXRoDQpyaWdodCBza2lwIHJlYXNvbiBzaW5jZSBpdCBjcmVh
dGVzICA/DQoNCk9SIHRoYXQgaXMgdG9vIGNvbXBsaWNhdGVkIHRvIGltcGxlbWVudCBpbiB0aGUg
dGVzdCA/DQoNCi1jaw0KDQo=
