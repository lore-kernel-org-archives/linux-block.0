Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16DFC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD01610E6
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJSWhF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:37:05 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:40416
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229548AbhJSWhE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 18:37:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROzhQyKRfbG5B8x+v1GpIqvBAsxUFnPx0iyiz8+aVwMnWIFDdouN31xt8tGW22IRrsyHd3vYr9estzofRZeonO0HhQaIAx9vUVzOmIxnptmn6YSG75mzcqikVtmIcGcdBQIuTh7+wdijZzk1ZoPAkmiFa6ZjyrSWy8PqkJvzZAsVeMepVUMAHpqrSO0hZRtn0T6tTBwpmddNirCDRX2inWxsWdK/WuZ72LgYCRbTLzJRx8w8E6H1b/XRW9U9TQ+riq3TJ3cKTR/1T3XS5Ctrng3leGNRRR8pYJeEYe1oui1MFx5ezDcj8G3tjOR4Piwgsks5Dd1xLi9R4C+3+tX4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7p9YzV0jwQexnQuE7pJsPQq15Ga6fpSMuYCpl98pKs=;
 b=oVMSATbq1YxCWftv4GS5l8M74+/dffBH/WE5rfrD0sbxQ2rDbm4pgnne3PUjPwZkEIO/kvDU2EuyVBkQAqo3Fn+kmzgmy47ffsw1Upw6l1jyAjvJmlifTYTI8qQc3DU7b9oOU9G3qosUqxpWzb1qvxG56p9gWxvkNGcI9Q7kwdyjxSEJQPQUjlgeJ0cvbdIIPb9OIElqRKrn5apJqQt6qj+zQZ2IlMwaPWozuRlU2CsUsQBiuc0yAhC1z4Nr7PahfL40cfDtQ9JC1vjo/nRPlfD8gB38lRmtGMKreFdmpW9K0oL97VuYEmuYzld9ha5DOVDL6PGVDq1jGz/i6I3owA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7p9YzV0jwQexnQuE7pJsPQq15Ga6fpSMuYCpl98pKs=;
 b=R+tbfElrHUFWpsEazRV+yFAAbQby9LkJhwy5LMTeXHTUvX8Vs3u0dD72D226YyN+33vTurFppn98dnXuYhIAbf6EJdE4YGvacf785sGNYJKgF1p8ZuirwgqKbpib/KS4guGHDOxRT0UILHowojp+XoTkTXqcSEY+JkTYQUu2clbY+yIsrQ7pTWgTLsZGeF7bkZ1GqmxkU5LSiQHaNULmvxd94dJLDDE3YTZ9ARSG1SDc/gRi8bCAtKaPGfcJAwy9gEjLPQS60Vk4e3ExlDaalCqVxu5j9M/wIexfXfwwiORFdvWck53MpFAjKMYlWfGyNIgSelsCH/mT+hTY4MolNQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 22:34:49 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 22:34:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 07/16] blocK: move plug flush functions to blk-mq.c
Thread-Topic: [PATCH 07/16] blocK: move plug flush functions to blk-mq.c
Thread-Index: AQHXxS+8G/PlTVTX1U+rFusSoaCa86va6K2A
Date:   Tue, 19 Oct 2021 22:34:49 +0000
Message-ID: <d339f9c3-ac11-6e0a-0404-0c9e1be9cbbd@nvidia.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <bb6fe6de2fe6bd69ccf9bc8af049ffedcf52bda0.1634676157.git.asml.silence@gmail.com>
In-Reply-To: <bb6fe6de2fe6bd69ccf9bc8af049ffedcf52bda0.1634676157.git.asml.silence@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91449c4b-23e9-4c01-22ab-08d99350a964
x-ms-traffictypediagnostic: MW3PR12MB4395:
x-microsoft-antispam-prvs: <MW3PR12MB439585E9391A626D1CEC4C03A3BD9@MW3PR12MB4395.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fxeGK8Nro2Rs5wA0+m4d8+M9K7RpIoUFzbEzKSCtcAdzJWFRmyEXNFk0jo6IFNe7AZ5e+8tTSfvbG/VhpwPx/8T21icAGeIN0OQ5oJYVJrh0SRaPdiGR/lai/svA8vhytsKDtCwnk7UPeLfUmlD4MVTysDiQDt/5UMcF91QPhANzEfVG0V7f4i/U42jlqsn2V32BL2p05DNl2DV8rWXnWU8a8vr+yIdSVaqM6XdlAS9vg3ZXnaRN2B4eWN4mpgfvapS8iNH39hxQUZARFsxUC3ixY7xk4CkcE52+u2jT9fMskA1RKVviugEXFu7kjPmZA4Xxek+E/H0XbP+JjcxEiGDWrOIpvZSN6JTFQa9kdRcO53jBbNqW8UdNn0BcaBjgavAE0q01Au/FOiof19xTHhP0nTE39bP+DJzXG8tDinN2FaRvkNHrjPLAYBaIGyjgUBuBhpTSQMJY+OYOiu5ldMpMpNki1B32nwi8jc8Okhcma94aH0ReTi+L7vPPy4AZKNNkxCAOcH6QDd999FH2hmcilVN2NgPN6XVcUhrWfqsCp7MJ3phSDpWeyYyVh996z2rRnKuRSkEAJHTqK6AVeqpBGhyvGBzvCqGLS9bH8u4PmENrWkHKqT69CZ1CgD2uh4ju4venBxa29vr5FNVT9xfClpJASs5GhTwPO46D/pYPhYUmJLrVE8bUb5xzujjI/0NSzDqOxH5/4CiwCRWHtTyvGfCLNFB7qoYDRiC67D4ndOc7U23mj8QwSw+HcB7qhNmMoxN4Jk7Ha4loWAzHaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(8936002)(508600001)(8676002)(36756003)(4744005)(31686004)(122000001)(186003)(31696002)(6486002)(71200400001)(6506007)(66946007)(38070700005)(53546011)(110136005)(66556008)(66476007)(64756008)(6512007)(4326008)(316002)(66446008)(91956017)(5660300002)(2906002)(38100700002)(76116006)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlZ5cEdJS3JWUlFxWTN0RzIrU0E5TlhDcVVaMmcrWVJ3QjRpYVg3eHhTTnVo?=
 =?utf-8?B?bHNzYmVUbTAweTNua3ZGK3dGZFc1akViZ1VvaFFWbCs0eWd1eU9XYTYvcG9i?=
 =?utf-8?B?bzNLV21HVDVSRU51WExnSDFWcmF6a0w3ZG8rYW82MElPeG1hRzdYWi8wd2Fn?=
 =?utf-8?B?S3NUd1VOOEJpdWlRVkszWHZpZFpIOW1yQlpqOHFIOHEvYlZVeWhhVG5mbTZV?=
 =?utf-8?B?U01vYllKVlNsTUlhNlhFVW9ZV1hzaFlrWncrQlUyUWQrZE40aTFNV3EvTkJJ?=
 =?utf-8?B?Sk5VSHM1RFpYSEw0Nk50Mi8xUXpSUWdwa1R1U3ZmQm8vMXpzUUdjbkdNUkxG?=
 =?utf-8?B?VlFrMUJUd0dVaEI5TDB5UjZuSkFEOVZvWXRXL0RkY2lsSDV5cWFyUWpOdS9X?=
 =?utf-8?B?ekl5bEFPbGUwbXlBa3dsSVVPWEVTd2kxcU5mendUU1NWT3lRQ3ArVnpWaEcy?=
 =?utf-8?B?ei85K2JIblJCK2xRUzMvaC9qYzB6L0NuKy9EL01IZFNqTDdBMExyYVhuMVZ2?=
 =?utf-8?B?LzJUbmVUSjQ3RXpNZFJMbmQvbVJoU3RhWnRBVEdrZVAyTlZ2VzBMZHo1elpU?=
 =?utf-8?B?TmJHSzJ3MGR4VWYvQ0JXSWF6Nit2SVBJQXdCRzBoT21pU1FKY2tqRy9aZld2?=
 =?utf-8?B?Y0dzQXVSeEk0ZE05a096SHlSMmt2TnlraHdNK3MvSFAvSWs5OW0wY2dybkpP?=
 =?utf-8?B?MEk3Z3FBV0toWTlJY0lLUnFGd1c5akV3MDhUVDlKZjA1Mm5xWW8zQyttZU1s?=
 =?utf-8?B?R1hmUWlxM2t0bktJeGVaemJNTFNScVpsenkzWEN5VHdmUmVTRC9hQi94d0N5?=
 =?utf-8?B?LzB1QUZPMjRBUGhJZkVMRmVrcVFUcGRCYlZ4TWlhZ1laMlZSY0xLclZEU2RX?=
 =?utf-8?B?UXBpM28yK3I5TWhiOU9EeTlsMU5xNUI3Nll0YzRiUTc0bW8rL2tSVTdqYWFm?=
 =?utf-8?B?cnhPc2JRdklDY1NBcDJsMmxqeCtMQmhZOEJBbWVQMkt0RlpSelRXTGhVdXI1?=
 =?utf-8?B?VmdkcWYwSWxzZ014ZGpoOThhWHI2TnNYL29KU1hkTTJYaURmcnYzZ2NNQk1h?=
 =?utf-8?B?TnpieWE2MWNlZjl4QWNuL3BOcmljTE1peGcrQXlCVWtKNjgyNGpQNmRmbG1I?=
 =?utf-8?B?MzZjcHJwOXdMalNyMGhmMGJIS3V6RCt2V3JRZ21NY2x2RjhoWWFqOXB5U2xs?=
 =?utf-8?B?ZmtvMHBSMEtTckI1NS9WdmxxMDJtbEk2VW1md1dDMXNFS1UweGluWml2a2JE?=
 =?utf-8?B?YldhOXBPK2ozR2dwUlRuNWV3OVdWaU00ZDF2VzhKdGZEL0JDRVFxclFEbFBB?=
 =?utf-8?B?RjZUNHlsVjI1OEZURjJjQVhFVHNwaEJheDA1MEUrRER1bCtyMDBiT1lXbSt0?=
 =?utf-8?B?cFVKdTM4WFQwdFFwY2JUMEJOaDdLVlpSbCszQ0dQVXRVVU82QUVWL0hpd1dD?=
 =?utf-8?B?U21QcUUrUmVUVWxnTHBnbDdiZk9XTnFNZ0JjYi90SFdYYzJoSkx6aXVxeTFP?=
 =?utf-8?B?TDRob2w1SEJPOTVaSzdBM3ZPbHFTZVByNlRwT25meEVnSGhjdlFBTmUyeWdy?=
 =?utf-8?B?VFR5OFdpR0xzNjhPTFBNWHRUUC8yMlZQLy9IQjdGMUMxNlN3bWhqZzlFbVp5?=
 =?utf-8?B?RWVWcTZleFloK2F5Tko2b1REYXY1c0wybzFSa3BwSkM4SzVFTHFTdUFLaWFW?=
 =?utf-8?B?cEgrQlRPWVAwVlhTdHVHcHBWbGpHMmROYlBwdXRpUld5SWd3RUlqNVcvdXRy?=
 =?utf-8?B?ZHhjaXNNenIyaVVVMzQwTDh5WWM5TDgxTW83QlBZYmVkM3dZdm1lRjVkWXJm?=
 =?utf-8?B?d3kvM2l4Vzloemk4ZGZoZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C886D017B08CB40A9D463B3F417C018@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91449c4b-23e9-4c01-22ab-08d99350a964
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 22:34:49.7604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chaitanyak@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTkvMjEgMjoyNCBQTSwgUGF2ZWwgQmVndW5rb3Ygd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
Rmx1c2hpbmcgaXMgdGlnaHRseSBjb3VwbGVkIHdpdGggYmxrLW1xIGFuZCBhbG1vc3QgYWxsDQo+
IGJsa19mbHVzaF9wbHVnX2xpc3QoKSBjYWxsZWVzIGFyZSBpbiBibGstbXEuYy4gU28gbW92ZSB0
aGUgd2hvbGUgdGhpbmcNCj4gdGhlcmUsIHNvIHRoZSBjb21waWxlciBpcyBhYmxlIHRvIGFwcGx5
IG1vcmUgb3B0aW1pc2F0aW9ucyBhbmQgaW5saW5lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGF2
ZWwgQmVndW5rb3YgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
DQoNCg==
