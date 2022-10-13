Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0609AC433FE
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 14:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJMOcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 10:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJMOcL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 10:32:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B1DDBE4C
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 07:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKxX7vn3wsfuM//vcjIv35NX9jQQMl6q0mu3Sa9RdZIpqyWTFaHWaoEzlJQANoSbyRTiHQCBifXa0MTq5Ii1CnQmyFyzB0ltCmfkmVF1fxOxO3WAI4vw+uX/dHWRANZroEnG2/+5SvnAY4UeRxK8u0AU7lfu8CObNB+V7pGk/+tX95bp/mbHca58xCqU9AD5/kJ+Mq/l31COCV9F8eLjtyktAHpEbSFT+dTXKlbJFpBygh6fToo8jSIw+1Pj3Iyit3hFPiA4Ynd8SY4QM+Th1870x+zhs85Rf6haNIwdaBzNwzwt/uUD3IrGHWVuBziKum+SWEpK4NADVFFh68n2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRZN4YEo03cJMSQkVgoe0RGaq2tgr5VLLcSPpNMh80A=;
 b=QuGGWecOklAJ3dYt9qAJGT417HYTsrC6aCssZoJeLTC22QSpRe2kJQS4bn3JAScbV9nQjK0wy5vRutGORiesJdntiWEClidxrbo6dURCkY6Qo7f2A6rXQyPRwtTtw7TINzpkrK6mtsFlpV5sRV7ArB71aWJKEsSHwVZgYaiQTVBJWXGDKfCKsX271h+bOYtu9v9oT36TBQwe2mTZC2Qa1p7W0OAFMMIK4AUsBejcYHRrXNx8CvsuzJSjF/dFuyJKtuwkmuMl/23Zw6LbLzeU4exGj17CPRXh6117yNeJAMCOOrlWnPap+14w9rkf/VxNoTqTKhNzbU5WtVjd8lYlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRZN4YEo03cJMSQkVgoe0RGaq2tgr5VLLcSPpNMh80A=;
 b=oi8jzWDKGxNOvarxCrMfSm4m4zWPODLgBBAdVcTK8Rw0kqod80gmV+MMXII3IJsXIATp/7pwm5bUKx8fyacEOf5RsHLOoP7aeSqEP457VGnWnDk0uj4HU+U3TJE3OtcHBDdDa5NZoliZPBnkHSXGtwzuvhxkITkRbO+cHwJDzp81LjM7Bec/uJgEmE+47qxXEIw3D0tx94WFLD2rJ9+kzX0rwv9oVPYXX/ouOBC55jA6FCCEvw8Nw+uJAEhrWEK9SYH1Gru6EaAhc9KWGX+Q8Ab0GT/ewif1+NRBdvzHGQBg4eKKXukt4Jt9CJc8zpAIYruRVuDk1Paa6nEpBBuQEQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20; Thu, 13 Oct
 2022 14:32:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947%4]) with mapi id 15.20.5709.015; Thu, 13 Oct 2022
 14:32:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Chao Leng <lengchao@huawei.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
Thread-Topic: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
Thread-Index: AQHY3uh4/bADRDRv9kaOrr+lm2Kvp64MY1OA
Date:   Thu, 13 Oct 2022 14:32:07 +0000
Message-ID: <d83c88c8-0486-072d-a03d-d0a3a8e4387c@nvidia.com>
References: <20221013094450.5947-1-lengchao@huawei.com>
In-Reply-To: <20221013094450.5947-1-lengchao@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5838:EE_
x-ms-office365-filtering-correlation-id: 34cef4e8-8a74-42ea-7319-08daad27b4f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OROnw4P8454oaXXEx+H6DPFERBiMaA7eN3KiHrQCKZSxch+jC/kQbkCT8xYvwHmGxSEJ/IFK0ERxwfA6WYc1SeFakM/TJtn2wqO6Yz4tCkMbHPk2JvfxD1mXfITe5YEUU1vF5YF84WQvfcjxXLEz04ZqFhexS9V7k7rjSBZ41wu+a4lAg/+MOnyOkDHIQQy7ZE+qJjMLjUNnrss7Hq088Sor0l3uZtbwdVEZhacuLN5XptHRJ051baDChLaYuRkg/4SIp99y5xoA/5ddnze4xDIXkrCCMnUfOFT5qm/TWuep2ZVvzxc9s6pSMhXvULlTX2gjAQj/rXmpWYzk9NnNbqwYoukC33a6p3bmwiVsay9RAn3qhcwSYANzZK77QpfW/gyxha/tuESoSEcITkWOHBlDf3QhOOkrVEaunAkTtzKNJteh7Pblkw0Qvr368bSRDuN1aVeecUg93qSA1jEFZKf+wllpXEF5KG9kyVAxSgm1CQSrNji0oNKXl6MeiENr3aotgV9UH0euZJY9t0dv9l/1DuDhroQHHPNFY5ck9EbT5SuLzhftY63JfYG2TweA2BXVZuZDms/e2iN75zvYcKJCORnOKRYy3/38cVCrCfbL/T48k3sJ77opXaI9/VicR1JpKSpFsWp/fuK9OKSAhqhq5pVTifdrFi/zcf4DeX6fwKKUnEyw2UDF5HGKviagV2aQce5rR7sXmxz3i4YQ2iS2Yuw/vpir8uCyANALlvod6h9xPCtR/kQn3j8/lPmvDFnGJvwICOm4LyTbFEU5Rv7SRgsLvKiwEuOLSinVJiooCEq70izB5/iW7CGY62j2CSYhaI3VwG7vE5aSCrRl6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(316002)(110136005)(54906003)(8936002)(186003)(6512007)(122000001)(4744005)(5660300002)(2616005)(2906002)(8676002)(4326008)(66476007)(38100700002)(66446008)(76116006)(91956017)(66946007)(6506007)(66556008)(64756008)(36756003)(53546011)(41300700001)(71200400001)(31696002)(38070700005)(31686004)(6486002)(86362001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1lqd0wzMVE1RkJhMEtWRUJ5RW5QZFBEVStxelVaMDMxVFNmV1FWa1VOQm53?=
 =?utf-8?B?a3Avdk1HNmpnR1lPdFdTU3NJdjhiS3RxcXRJUHA3TEhaTnA5bllvSHArbXBL?=
 =?utf-8?B?NlQyaDFGLzgvZFdSeXdOdm91cVc3YVBwcGVnMVZKYlBQeER3NXVhSWJZbWlx?=
 =?utf-8?B?T3lsaUZoc2VvV0M3eWc1dmJ1K3Z3ZkRCMFEvNnF2cnRjQ1JaY05lY3lyZ2NI?=
 =?utf-8?B?MDNvN1cvNE42bnAxRVIwS3JpWnFxZGtITGVndXhuaU5mNkRhUkQ0NUZoS3JS?=
 =?utf-8?B?dFJZS3kxdDhVQmJMZkt0b1VQVThYWWUrYW5WbXo3cnl5US91Z3BTMFlzaHBK?=
 =?utf-8?B?WUpIVzVRRlFUSDhvNzEwR3N1RjZyS3lUOHo5R20vTjJwa3pIWVduM3VIbU9M?=
 =?utf-8?B?bXVwdHdjRmFMQzROVXl5UEIvcW1YbVJDQnZMTVBoZWc3clFvS0dXdWNwWXRQ?=
 =?utf-8?B?MTlFeVhjUjNxbFk1am1TTjdlcUw2cytCS1UxRFpxYXVyREszVGFzdUI1MXpa?=
 =?utf-8?B?K1A3K2ZIQUoyU1VrMG1kKzhUSGRvbXpUc3ZJR0Jha2dzQWhuc1daaGl1N1Mx?=
 =?utf-8?B?bFlqYXhKT1ViRk9qNEd4cjM5ZDdHWk1BMDNJSnQ2N0VGM05FMnVFYlRFMmJB?=
 =?utf-8?B?ZTJaMElVUUl0d2lrUXF1dWg4N3B1NXdNVlhzak9rbUwxY1ZOanNIanY0YXo4?=
 =?utf-8?B?MU1WM3V5S0dWZnA3TkQvZXZnWFBPWE1PbVVNOXU2Q2cxU3J3bS9yWmNNck5S?=
 =?utf-8?B?Ny80aFpjbGduZ3ZjMU0wZE00cXRHdTNwaG1VVG1UbzFIMFJCUWF2eTNtbXE4?=
 =?utf-8?B?UnVhWGdHeEwrM1JHYitKS1MzTVJUazdmSnIxa1FacGo1K3hNWXlEbW5aeC9O?=
 =?utf-8?B?aDlzeGt4SUd6RUtJTGExYitQbnJKN2pjZW44OGl3dFhBcmo0U3ZlWFJVaW1h?=
 =?utf-8?B?ZkRCa1VVVTlBSFd4TkgrTkRFMWRUQ3YxdkZIZGcxSTU0OW5XZCtLbUdEcTRQ?=
 =?utf-8?B?WWJtcURlUWo4VFBESkFGZkdBS2RySnh1Z0VlWnlyTEdrVGlzSG1kU09zb0x3?=
 =?utf-8?B?Q0xBK001U1lUdURXZDFQOUROYlE4UWx1Y1Zod05sdVJ2aTJuWEJ2OTlrVVNO?=
 =?utf-8?B?SlhHMDZnbFJpamhpYlh4RVlTRlArSGxwSExWNHpZbUJ2a2g5VEwyTVlwd3RP?=
 =?utf-8?B?RlVjU1RoM0ZOWFR3RW9pYy9vdkQ0ZjBZYS81a2xxbUhrTEJlSWtVTnZZK3FZ?=
 =?utf-8?B?Z2NSWUdxeEd3ZjVZSjhwWFZmN1AwVUZqOFQxdmlwSjdLNEFWT0dBMkc1WmIr?=
 =?utf-8?B?a2UreXgyUVlEQ0tjRWM0L2hxRzVSb3VGVVdldGJVbE9JWmRaOW1PUmlQNXc5?=
 =?utf-8?B?dHNKWlhYaE4yWUEvNkh3YWpwd2dFVFJnazI3OVBwVzVoM09yKzRWM0FKYjFi?=
 =?utf-8?B?K0xsVXJ6UkpxT21QU210dTg5Sy9IVmkvTHJTbmJLWEtBeW11WndHWkRaSlE3?=
 =?utf-8?B?djNwdFl4OUlGejZqUFNDR01FNmRnYUI0OER6Vkl4NnNVeXRmME5lU1ZRaXp5?=
 =?utf-8?B?WFkrak14Tm40MlF0K2Z4a2tqa1NGSkl5ZG9vdytWUmhYWllOcXZxWjlyb1dY?=
 =?utf-8?B?bnJJWWVXczRLZ1BVODNzc2Fjc2hDMmtQeEh5dDFpakFlMzhRUWNxUnZGdlU1?=
 =?utf-8?B?cWMyVWpBT0FlREZqRExER3ZhSFZ6bEF0ME5hU0IyNTF4MUphTWVUckgxYjdX?=
 =?utf-8?B?dUdEMVFSbFVoSkxWaTl5ZFpXaDZpcS83aTZXVEJ3cXMvMWhhOXBFV3FIbGdJ?=
 =?utf-8?B?MXRNVDNDSzd3cFV2cW9VVDFHWjl3WkVaRHBscU55T0MrdkUyV0I4UjVZRWNK?=
 =?utf-8?B?MytxSytTcDFOcWFYb3dFcDNac1dpaGUyVUQ4MURONXQrakdNZmdDSlgrdkdL?=
 =?utf-8?B?cHNHeGUyYXJUMWJKRlZCOGNOK0w1czBPaDhUcURvRXVGUnB4YnZwWmFVRGVX?=
 =?utf-8?B?L2dGTTB3SlVaTzgxN2RSNElLdmgrUGtqRW5jb0w3Z0ROdkFGKzhic3ZmWkll?=
 =?utf-8?B?dElzYnV0YmVXU09seFJzZ2ZjMnhFRnE1ZDJ5cWM0MkVpanB3Ri9LQlJVTGlk?=
 =?utf-8?B?cnd3TUVSMFM5SGZUbmJ5UEpuV1VJWnF3dk52cXN3VE9XVjBYM0ZpajFjSlBK?=
 =?utf-8?Q?7rtxAUibExYAYHEnhoV1/uooVnjfsc2HWcz8sXxSw7wk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <341349D3A0AD7E4DB0DF87207E86DA3E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cef4e8-8a74-42ea-7319-08daad27b4f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 14:32:07.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXFZ8pL0zVMzLA7bGn9zhiXG8Hti2XrU428g/S0PXRxO3w/HkPbqqZkB1zOns2iyEQV+elEcrY7TpKNrcH74gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTMvMjIgMDI6NDQsIENoYW8gTGVuZyB3cm90ZToNCj4gVGhpcyBzZXQgaW1wcm92ZXMg
dGhlIHF1aWVzY2UgdGltZSB3aGVuIHVzaW5nIGEgbGFyZ2Ugc2V0IG9mDQo+IG5hbWVzcGFjZXMs
IHdoaWNoIGFsc28gaW1wcm92ZXMgSS9PIGZhaWxvdmVyIHRpbWUgaW4gYSBtdWx0aXBhdGggZW52
aXJvbm1lbnQuDQo+IA0KDQpieSBob3cgbXVjaCBhbmQgd2hhdCBhcmUgdGhlIHByb2JsZW1zIGV4
aXRzIHdpdGggY3VycmVudCB0aW1pbmcgbmVlZHMgdG8NCmJlIGRvY3VtZW50ZWQsIGkuZS4gYWRk
IHF1YW50aXRhdGl2ZSBkYXRhIGlmIHlvdSBhcmUgcG9zdGluZyBwYXRjaGVzIGZvcg0KdGltZS9w
ZXJmb3JtYW5jZSBpbXByb3ZlbWVudC4NCg0KLWNrDQoNCg==
