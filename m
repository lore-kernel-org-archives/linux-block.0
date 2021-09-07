Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33D4C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B6F60F6D
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 18:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbhIGSkm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:40:42 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:45152
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240131AbhIGSki (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Sep 2021 14:40:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWEhvcseXFtWkr1Z++XM05cUw/Vdzp44qLdTUEZBKBG+mppO6PDLX0X/NtAZ7s5kGsISBuT9hJN1IBUeF+gtOSczjZUgwHuJaNUj7GvlIvOkZImxsRwVOAPY4zCxrpKmg6oXd92CE2cWSNA6EW8/lRUKsXuItugnkoOl/+AJje+3ixp5rSM/oa4tUbspCbEy5wGx4rrbmOEzh1l+DyU3QS2bOQPQjuVsXCV1FIpjDyuO+UdSXQSjJKm+xjYcPPnHDl5aLMwaqghg4JbfPGokX62wOTVVJN7TkmVePcC2utT4Lmh8vE56B9ahcH+Ro1UY7JNYNv8+owNHejByOe67HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r8iSUPP16YA5vaeuGWQv2pVSfH/31YE0Pd3UQ3hFbVE=;
 b=TtdPFXvk/hHVhr1iEJ4tB/G2gbWfv9mVcdU0Cscum+wXpCM34RIl86TzFwKaVc5KS1cRn/BsxBy6uu6N/DCzKB7HUqCHBT/GynK9E1IYoNfQK+Bxf3K5/fIAIBS6ooe6DCssjjuujMum352BcB2oz6cs9rlefrdW2/nBEXuByk6nb/Ftx6tQzDdvYpUFTkhnM+o5fRttCBAnM+eLwR+UN6yyhIe/eNGsXnlmGBQ0Q5/T4hxwktlYi9rqBwvlWC3CAs5tNIK7iHu3sxDmTSyU5qeWJNQn6xNgD9iBP2/cCnHTkhLAqfBdnTN+0/vOs97SfTXu9qLmOkFDr/Z4R0LaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8iSUPP16YA5vaeuGWQv2pVSfH/31YE0Pd3UQ3hFbVE=;
 b=rFiue55uFJbtYvT+6y8e49Ek51G+sQIfsp5Uq4IKsRarsN3hkfr8ii4rmz6nOmO0Ca6XcSsfuq+IM4lkQGK1pcwyx4lXEtFCx+kdOYWWfa/R0sCktQr0JlFNpTBo56L52eyl5riF812uxkhcR4k+HIouXOxBhSs9C6sK2YXIL5gYm6qqgRh5s6fc7jsJlcYNYfJEBt6vZVnrb3nHELOCzmoAy73aZAYFkebrxLixM94L+g5Va+XdvYZa7BsPEJxIyuiioMp88vUKr4Zf7CjUY1tLHaUDQ5gO0blfAjPwhww5xEqWnhy3UDX1tiduex/vDXXLTRh+3JZnMuRy0aOmXQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1328.namprd12.prod.outlook.com (2603:10b6:300:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 7 Sep
 2021 18:39:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 18:39:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: split out operations on block special files
Thread-Topic: [PATCH 1/2] block: split out operations on block special files
Thread-Index: AQHXo/LBENf7VFa1V0yZp3QqoCN8/auY53yA
Date:   Tue, 7 Sep 2021 18:39:30 +0000
Message-ID: <a27d6b21-60dc-5608-fc09-133c72d09e23@nvidia.com>
References: <20210907141303.1371844-1-hch@lst.de>
 <20210907141303.1371844-2-hch@lst.de>
In-Reply-To: <20210907141303.1371844-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bc2813b-2a67-4fc7-1ce0-08d9722ed430
x-ms-traffictypediagnostic: MWHPR12MB1328:
x-microsoft-antispam-prvs: <MWHPR12MB13289B337EA3ED40E94240FFA3D39@MWHPR12MB1328.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/v0lTGgnRfgaB8SWLuvforv3BCth+Uou3+mticZngQdmKXjmc2zVnilLnHaePrqu4I9m98BdJQ62TiopgJw/pcAde7wnBI+tZDMfd/VN9i7Hu7JTUG2kK50HhTEe3VFAD4DU46IN5x9uBWJs/W5O32q7edMrSAoXixMauopGF0bLD7I+uMkQmwGaTKJGA3OuOti1fal/R1bq2ERQ01WSmQXG1ZLXlKxlr2i57EBpQBOq3c7InbzELN/JgZ9ziRgw8wrqBMEXKL5+9NtybGtI53UJQJMHuC+Nunlz+V+11hXcFkxPnk+7o2hrsfXKhmZU5Tx1Krn9dLctyGrJLMDW5R4YGRxIor7fFnR2RlH4oYJnmWCWu4/0SSiB0B/18jnh+znvm9EGKgzAwh5NvRLBeeyVeOJqHBmNTu77CAQ5JSh0MMTCAPbpg4Pr6G1ViljZag2VD10JyO7FobflztwpDaiUv3ZjdvkFF91Lt80N7HlTc/LwnDNbrO09uYGEM491Njl177rI+EsILGFX9LywP2D5TG87s5w2H8W5f9D8lVAG8AMcnXiO8EPh7UX2klCtAAakj4DMjEJcXGdjg7CvYzL131zPxJf0j0v7OyvMKZma0Ozwg5rLs0cAXA3zcqYL45sha7duHod14st/SCMK/6X8fUnLFjJGwx9FaUyG2QkvVp98dncFEnRVBdorgzXypLl/GzvFs327FpOwILp7AVE5fuyJboLjsOXdsQBLYcyGNT+DS2OcefQra+JlltBjULoiTRwX4yDmHirrfITUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(31686004)(36756003)(38100700002)(122000001)(76116006)(91956017)(31696002)(38070700005)(8676002)(6506007)(53546011)(6486002)(2616005)(71200400001)(110136005)(186003)(66556008)(66446008)(6512007)(316002)(558084003)(2906002)(86362001)(83380400001)(4326008)(478600001)(8936002)(5660300002)(66946007)(66476007)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bktDT3hFU0Z4aWdTeVFJMjlHWGIxdE41MmZUVDJXVGpoeUZ1UWdRTTR5Z2FO?=
 =?utf-8?B?MDl2YjcyUXRobHFPVVo1SHdPSU9VVmpBeEV0dWFSNTFJVGN3VDh1clVmMDlp?=
 =?utf-8?B?VXg5K2JQMGxFR2kyZ3Q2RGxrWjhZNFhZSlQxS1RHTzg3bWk1Y3hnell6aTMv?=
 =?utf-8?B?YzRVZkZYYkdzYWovaGF3dDcvdTUrdzUvT1VuQVFqaDlsQzR2cjI5SjdlV0Zn?=
 =?utf-8?B?NHlJNUpqL2JKRzNHRU9LS1lwYWlQNDdXTWpFVEFZUnM4TVBieCtaRmU4Um5s?=
 =?utf-8?B?M2hlUW1FUDJxU0pNdHdEVGZOZmhMeW9uS0pPRG42d3JwL2NWMG1qM1Q4NDB3?=
 =?utf-8?B?aWJrNDczM25hb2JFT1ZocDFIZkxaL3N1cG51cjNaRWN2bWtTTHA4TUttcVhz?=
 =?utf-8?B?OHA1a0U3bnRHWTBWRVJmdDdERWJQTDV1bTR5Wm50S2VzS2JyYlozUXdOckZT?=
 =?utf-8?B?b1QxTXZ2bVgzajVRbFB3UldsN29vcHJVY25COUpwUW4xcEd2RmxlOFF5VWF2?=
 =?utf-8?B?eWtaQjRUZVZEcUtCRHgrdVZOakp2SUtmdlJWK3VnUlE0Rnd5aU1CdFUxWUVZ?=
 =?utf-8?B?SlhnMmdKL01TeGdMMVMvdytJd09mbSt1RGlJeFJyNGhiMlpwZlBrR2tmRkI2?=
 =?utf-8?B?emMvYlNCNUZEZkhEMExpWGtWY29qNUZvWG1zc05OUzR0WW9XYWRQekdWVFB4?=
 =?utf-8?B?TjFpbk82SU51ZkNtQ0lDVVBOSXEvNSs2aW00SmdoMloxZ2VrZ3VjZ2dpVEQ2?=
 =?utf-8?B?V0lzQ1lhZGdxMmJzdFA3cmJmTTl6WUsyTEN4OWJWcFdBZGc2cGVsWUVmWDU4?=
 =?utf-8?B?MUFGd1BsczRqdjhqRm01ZE91QmxoSXJNQVFxYTJ1WjJ4MjFpV0Y0cEJTYWxX?=
 =?utf-8?B?OGxHMHpmVitZRGgvZ2FQWWlpakViZEhEeGFGVVUvV1BIclNMTFM3Z1V4YXVp?=
 =?utf-8?B?dWJxZFdWU1JKZVpZY2xxamc0aldza2Fvc3B1S2pkUXU2MVZKc3JYOG0rMVQx?=
 =?utf-8?B?UUVZTE1DajRrRkFDZEJSNHNaQVp3WFJ0aWtoWWpuRExNUHpWWXczb0ZsRTM2?=
 =?utf-8?B?UUxMa094TkMyRmdwRkxkTzlsajhvK1J1R3MxS0pIcWZkMkpxQWpWZnEwVnFJ?=
 =?utf-8?B?QXNCTzB6aktvVXhsSzFmYS92KzVLVVVPbW1Oci8zS3ZjSUxCVjN2UEhlWUlT?=
 =?utf-8?B?MWw4enpiL1YyWDZML2NmdE1ZemlIaGVMMmRBZFdpK2lpaWpMKzRVVmRzb3JE?=
 =?utf-8?B?ZmphRlduL1F6NnZaY3d0NXpZOWx4bEF0QXllZ0ZKTWplWWhqRWVUSVJNa1hD?=
 =?utf-8?B?L3VGYXZnUGVZd3ZYRVJKRTFpRjNSNkpFcHlzU29sRTEzQTF6NVRNMC9Yc0px?=
 =?utf-8?B?SzBweXlRUzZGMWFmbmkvdy81MkNqdzV5WFBHWGZjSXNFTEFuTUhHOFFqVWgy?=
 =?utf-8?B?RGUyV2FWSERsQ093S25KZVZ6aEwzQnZmYndOeHZyYjJKTm5BMHJuYk9nVFZI?=
 =?utf-8?B?RnNaRzlyNmw1OVljZ1NudGROcVBNQjFkNXhXbFNoS1RMWEQ3ZE5HSGtGelE0?=
 =?utf-8?B?NzJqOWZ0enlZZkJPU0c1NW4zQ1ZCTDZ3Y2tCcEJvQzEzYndhZk9NaldoMHR2?=
 =?utf-8?B?YU1ucFBhSDYrT21uV0FxZEJ6S2pUVUZQcmI5MS9PTGoybXRaVGNVMHNKdElD?=
 =?utf-8?B?bWRod2RtQmYyU00wdUF0RmFvYnJqMUlXelNtdXRndjlNUHU2SE5GYnlOeExl?=
 =?utf-8?B?bTdaUFhsUC8wTjdiZHJyMVNzQlh4dW0ycDRNdkdkbmtyOUpFUXdVdWpsUXNy?=
 =?utf-8?B?R0RDZzJXVzZ6VThzU3VxRTE2RmhSRk50dlhjdG5VS2czQjVoZitGRG9oSmIv?=
 =?utf-8?Q?+wpm2mxlqnM/e?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFF1A13CD51D254380F13A6218000945@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc2813b-2a67-4fc7-1ce0-08d9722ed430
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 18:39:30.2641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gL5iDqruTdcdJ2WvgfSDjcj40CDYM7B4oKrm0B8oVxqem8tAfOWEK3qz7Hbkl7UDmLo9UFPqcE/twn4NH45TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1328
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOS83LzIxIDc6MTMgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBBZGQgYSBuZXcg
YmxvY2svZm9wcy5jIGZvciBhbGwgdGhlIGZpbGUgYW5kIGFkZHJlc3Nfc3BhY2Ugb3BlcmF0aW9u
cw0KPiB0aGF0IHByb3ZpZGUgdGhlIGJsb2NrIHNwZWNpYWwgZmlsZSBzdXBwb3J0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCg==
