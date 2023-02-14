Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344BDC05027
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 06:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBNGhs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 01:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjBNGhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 01:37:47 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32341C5A9
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 22:37:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/zgb6j+DlCB3tDr2cpfBz9VHWS54v8rp1SNAIB03gPz7tg48t34rVioTM0/r3uv7W/Z1feHlIbvVU4mg4+XLiWytfGdXDRbZ8ObODhTAJBtE4I0k0YE9Vdd0D8ZgNIyPUmQTk8wM/vcH2T1ms70HNqeQsQT1GmwEP8LnWAci/9+51TVHdpIMJJwpfmlCoS2U5Ke+WggT2WY1h1QMraUun/35qJ8d0imkasFFsxt0WseDGo7KwldodVFpnuRlZuIsP+3KFzlhqD0VlEC1OocRfmfOLBaWe8hNLSPs9IhYudGpAuQlhE3lflw/IdI6YxhDMNC0G3GIvxSakkmwxprTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkRJp8W/uQShmcyOHbSoDbI/ZwipJD5vfnKekqcds/w=;
 b=AODjqiOFTCC/VIaOOQlyafmCVVEozpzISl31AtKhECXOkFuy5JM4B2SuCdkCatowlkG1jXe9FXUNsoyHjJspQoOzO54OCmiDs+FexC7hHpO4ipL1b5n6U5dY5TErX/gTBwZkG/4Ig/iCF3FNy24XHDoP5VgpiHYpS/4Q+n+AO+AQ63Fp8yxfgGRYahYDS97yg2IMBjhhJccqSen5++BrXaxbAATUOl+UyPSikJy2Iz8ip+2oqPYydKrEnm80U41HwbdyIO8z3Gvr3m+29z4/xWD4rEk7q0h/ojKdNERD156wK/HivCABx6j63t2MA3NcIAAYlyOsbAjVXS81iAYj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkRJp8W/uQShmcyOHbSoDbI/ZwipJD5vfnKekqcds/w=;
 b=qAIdmjqUN02srEzds81mxopIe+mnHcRqT6U1iz8hFwM7NCs4cLPxyEbdfQvvQmnfzBpcI/wVs7GiUX7EI/GT60EWqT93eiuusKsJofN1JQtYmeTSPm8MYIUIqEDSiOhCuIPdQspWPAfH1eZhrFYIHp7UbdICcSJceS2YcaA2s5cI0bwqOZHawU/gtLK5c+jUxk4XDNIFlzGdVvhToVS+o6O41Jvg7b6G9a0W3pIr9LPmGVwAbxHH3Ztoy2FRJMTI9Gahc7hYiijdgSv55udUtn4MbpvpfgiYmolMNy4N9LbuJ2nw9yBExx1+Z8WYZzVTbMHVX1bYRg9lqo3nHna1dQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:37:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:37:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] blktests: add test to cover umount one deleted disk
Thread-Topic: [PATCH V2] blktests: add test to cover umount one deleted disk
Thread-Index: AQHZO1kpAILDPJxLUUu0jmUCImum7q7EqiuAgAAA5wCAAEN+AIAI8/AAgAAkdYA=
Date:   Tue, 14 Feb 2023 06:37:37 +0000
Message-ID: <8274f205-8acd-5f11-e6d2-8718c2105edb@nvidia.com>
References: <20230208010235.553252-1-ming.lei@redhat.com>
 <20230208073911.x4iwd4iq5i34xnrr@shindev> <Y+NSYGJBoM8Oixa5@T590>
 <20230208114357.nzoocdy4uzolcfij@shindev>
 <20230214042707.4utlpmecsyfagkhr@shindev>
In-Reply-To: <20230214042707.4utlpmecsyfagkhr@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6235:EE_
x-ms-office365-filtering-correlation-id: 0b105155-ba2b-4885-815b-08db0e55f697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tIVAXRAoPu+vxvn0Z8I4fUWKiCRQCVNB1LE2UmSgBWPIXIT+0SQFXWzubduvAmlVDUt3sAtww3UAhHbFXHw/g312YQtbHmhhNW4UfDvjKLkwvqduOE7DoELNRt7Xh0+ghEEuJv21lNq35yO5qeRlB9z8h4dnKqhqhBMY/RXyY355za47S5yUU5ivCVCNAkLzOT2Zz+E2xZJjQ3+s9v3nPGyXZZAYsReZ5uR0TdZiFeRAYMgognoA0XrPa3UY8orl2BIetyu6Flpjnis6J0OM1s7uM9Nx1Qf4WK8pGgmgFUZmyNA4IQ78NYI/eXVYWrx5x0tUQKQ99xmqubJVycfx7D5Nh9HPOcouoddF/VLxohrClKRhgRaIcBwiGmi/bVNrPDz7R9MS+HchP0L6IZ2E5LG8mbUuVRATb+huxJmB3UBpWX/MxZxyJmDKF+rAFo/EOV4ZR43VP1SPWhdHhyf7C+ItaVFH/XyuPCsUe66By0VCKlgxkt7Dw2GBvX8jqwnnPPrpbC2R06jGdfHMpjuMy2VUWG9WvXiBLO4vjP8ISBsufcKu5W9ULvtrg1Xuta8KzUHkYrNIN1jdcPMRHqzNFXa1eomzD6neGq41wRnJV3hRg4gX0cFPL+4pR3KxrFMgVSkoCIWGn2atQtSz0s/90zlvpJQWir3hvBM+1F/wQypKrdMWlJpjvcaUsd6uJVymhNcqBWp9AjIg47asYEKj89FDjsGR/+ygBmytnvmjWCLGTC5BczZLBH6lwwzen1cUfdKGKvBbK7r1AMUwmWcJ/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199018)(31686004)(4326008)(91956017)(76116006)(2616005)(66946007)(558084003)(478600001)(6486002)(36756003)(71200400001)(186003)(5660300002)(122000001)(38100700002)(31696002)(6506007)(53546011)(86362001)(26005)(6512007)(8936002)(8676002)(66446008)(64756008)(38070700005)(316002)(110136005)(66556008)(41300700001)(66476007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDVEZTI0ZUpBUFduNEZXYXR2S0oySytEN05IYS9sT2pERHpCUXRRWVpNTzRr?=
 =?utf-8?B?K29mcy9mV0NQZkNEeVdJNWJGdkE3c3AyYXZWSi90YnlJRTZJTUxuSWE3MzhD?=
 =?utf-8?B?R0NucFlUa2RiMFQ5U082dFdtdVU5Y0UrcDV3OUlHZHVmeWIzT1paeEI3dnRa?=
 =?utf-8?B?bks5Y0ZCOGJ0Ni9BUm4vQjZwbnpnWGRYbm1xZW0yU3ZpdnJVQnBMUkJCMnNy?=
 =?utf-8?B?VFNGdE9sSks2L3lTWDFHSDFhMk5Fakd5aGZYclBUcjVqd254QTkvS0R6UXZW?=
 =?utf-8?B?akdoVFlnd0o5TkZDMSt4cG1Faloxcm9jb0RhNmxVbGVVS0laYTlJa0JsY0F1?=
 =?utf-8?B?YS9HS1BHcmZXakJHOUpFd2FBVk5KdER2enVLd0Z6YU1pL1pRakdXcVpjT2Fp?=
 =?utf-8?B?QysxMU5vS05SOHNVZG9QajdFYWFSZ3ZWOURtOGk5d1VRRWpsUXBwMXlrajE4?=
 =?utf-8?B?S0NNK3BnaGNlbVBRRGdidWdKbGNPRnNtNFJxRFc0NldNbXFKUTcvR0Y5V2ov?=
 =?utf-8?B?bHZvTzFmTkRPSnlYbmc3bzFVUGg1ejlFT0pLSkxXT3V2dmlaUEFSOGRVZTdJ?=
 =?utf-8?B?YkozYy9HQXJVQ0Y2VnpBd3lMbmNZc3Z3V2JqeE5MbEgyVVIyUXU5OEFYVWxC?=
 =?utf-8?B?anF6bUZHaGUxV3FHYm13Z3ROOVdCam9QUHREOFdJQ2ViZ1VBMWRQQXhBWCtR?=
 =?utf-8?B?WkJkUFB6c2RHWFc0K0EvcTI5YVZkTnBqTXJLdnI1eENkdVo5WjVJa2hURVpi?=
 =?utf-8?B?TDNUeDJHcVRDN25DajlTb3RBbEFsdWdJeEtHcVdaODByaDBGUnRxSEJWczFh?=
 =?utf-8?B?RnJVM3o2anArbFJBV2R1dEVHRVdMRU9wVkNJSnlkUjJRR0VST3FJQklsVW1k?=
 =?utf-8?B?cVVXUHVvRFBhWnlzT052V05TdWZuTTRSN3dMd2xKYXV5ZEkrbjdKU1pGcHEw?=
 =?utf-8?B?UXBnQVEvb0hwWDNQcWZrelkrQmpZZGZreE1ad2dRRWZOYkJOK1Vjd0xwWVlQ?=
 =?utf-8?B?aVQ5ZENlV29ZdURLY0UzRXlXUWhGSHQwUVdWVmd3VXVXaE02WlE0bGRZL1No?=
 =?utf-8?B?NC9GWlNuamlnMXFrQkNKcUlaQTRDRy81UFNweGE5b1BuRmN6SlJTY1V0dE90?=
 =?utf-8?B?cjlCcmNmWlhtMDRkSk0vbm93ZVlJUi9NQmZVVjhnZXdnYkFXTVJPdkFsRHY3?=
 =?utf-8?B?aEVlYXUvRHNuSmVUUWVTREVVNWRubVdhSjdIQ1pwUkZDR2FHWEYzakNidi9I?=
 =?utf-8?B?L0hQdm4vRGN3aGRFYk1FeEVsNkp1OS9LemZiVFVmaHJlK2NWY2wxTjZBQi9Z?=
 =?utf-8?B?Ymk5eDFxZHRmaDUrbVpSRnFVR1Z5eStXRmY4SVFEcTdSRzN1TnhNQW1peVRT?=
 =?utf-8?B?bUpyUTZJOXdvaFhzYkFhaytRTHhueVl5VE5tdE9yVDk4NW1sOVRFRVI4M0ZH?=
 =?utf-8?B?ei9nNld3Z0RDVHBYTnNYWmZtYVJRMTZSVDBjYnVMeFZJejZOVk5wMFNKZVlK?=
 =?utf-8?B?RUR3ckNJMVR1WWZaYUkvcUY2bmtqLzlMY0NueFRnZzlLNnVvZUtMdkFnUURu?=
 =?utf-8?B?Sk9aZzF4ODNZVHRWL21qY3MydzZZVjgvMXlpOW9zWHA2ZXhybGFZbzJHL3l0?=
 =?utf-8?B?UitXR1hQajZwN0I5OWlEUUJLSUtIOVBacVQ5b2V3b1hFcmF2U3hyS3hma0Zz?=
 =?utf-8?B?Z2svMVJWNWVYeHYxbER0U0I4VGhkSGRCZWNKUmZTdHJ3Z2lQUG9naWJQeG1T?=
 =?utf-8?B?bmhhOW5GV3NCblNlV2xkNVJKUXZNUkluNG1CUzJrdnBsNHZoT2ZUZUlud09M?=
 =?utf-8?B?eG9oamNFVGJHN0l2Vm9IcHRpQ3g1Z09EU1hQTzBsWi9FRHlHZ2VodWpoa0NT?=
 =?utf-8?B?REZYamxDSWxvSDJUN3JoUWhmOWQ5MFU0ckRwRzJCcDc0d3dua0ZUR09sWlJO?=
 =?utf-8?B?OTU5TUdTODZUS3dOaHlYOEpJUXFNRkhyay9GZHYvN21zZkliZEJER04xRHVQ?=
 =?utf-8?B?TmhySnI0eTNWWm5RQUNHUWt4ZVVHcEVQejBsTE8xNU0zR2pEVHlBV0V3RlZB?=
 =?utf-8?B?Ni83V0M2dUo3R1NtL2w4Y2M2VzU0ei9TcXdSc2FXdG01TWppSzZCWGJyR3lK?=
 =?utf-8?Q?aJfiSNZgdNi1in0eC8IEOe0vg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C0AD3171BF921458B22E6F572091346@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b105155-ba2b-4885-815b-08db0e55f697
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 06:37:37.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbL64pBHVqg9QGzegUeyKc2B4TP6yGy3/eLMe2NtDEuS164z9HV9bGq3ngBKOhh5ERzmucD7yCfe5eJK+Zoi/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xMy8yMyAyMDoyNywgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gSSd2ZSBhcHBs
aWVkIHRoZSBwYXRjaCB3aXRoIHNvbWUgZWRpdHMuIFRoYW5rcyENCj4gDQoNCkxvb2tzIGdvb2Qg
dG8gbWUsIGlmIHlvdSBjYW4gYWRkIGl0IGVhc2lseSwNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
