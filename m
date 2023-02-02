Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C5EC61DA4
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 17:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjBBRmw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjBBRms (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 12:42:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642CA5A37B
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 09:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3nFhF5DJvgCqif1csLDF5l8+L7HtD3nZPd4+4d2fuq+3BWlpoI+uqc+AvR11Ni4LS5ikVN7zlvNDs7U2nVwmjUv68psC+BS7AZpGuRf6qXlE8jYUspfocu8LpO9Zta7Ws0pjJ6/d+Qc6JvsBdNKM/7Kr36oCpNWToj62RxLRou5p9+nJd7f0oDWpAZKpdirBjkCEakVAyRIF45yBJsQvDTMDqaZvpT9pm6mbdyxzcOMpq4EgJ5LUxvYMdWEtH+rtae7SCer4leYHMoq3pgSrVR7faeG8I1eCZ2ZZgg2zr9msBQDOliKD0ujE1EKqs3shN05Wz/b+aOBErkh2fkuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z7T6RHneeVu6ColmMDLM7jnLi9PBq6h6aARVyvxwm4=;
 b=lXmlC404hXgodeg65PIal3wg4Sa8xKPV7RGkD7ubPR0Yg8Du2X3fcsNc9KoaCfRyRqIxb7rFtJsUVWADDEDwAkFx/dK6fpJwTzjLDC5VS6CpYvE14k8RmtRU+4BCRziDT6steK0FiaE9hRkrhyY1c7mHrfpB1qNpA84mSz3nOHU8VhdBy3Zvzw4Veh+eHKzpTwryreyAZUWhukLMLbDktolAXHLtogZthKADo03l6m0HGrj3DQFxcJw1E4LBuG83y3aqlJ5ekuaaV9cZElkpskOjkd1BMhl7OaLMB4qV78qHfuxvsPX61DlYk9MBxGzz+RfLATf8+029NmjcQiS3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/z7T6RHneeVu6ColmMDLM7jnLi9PBq6h6aARVyvxwm4=;
 b=PZQn4DyHQpr9kl5gFXCxmOvsd8kAkGM5Fy7r6macJTCzzX1meY/1vLnPfrweAbZHx6zL8C+DxZoxH1FjKSECsr0uX9PNr3PpaqTodWknA8uCML2wO2RFESAHpzN3h5Vr7HKVUg/BnMfyalWlJCNJr5qJyJea7YCruz7hYSXbQleCWiegv1ERV2A2uZ9boFt+c9K0xMVIiN59A2K6Vbjv0R35ke8qkNqp2lTyO6gmh4DAuBDdIRiIA39WxOysxsJAcgkSuaq+F2JNo6ipnpfE/Wjx9Jez+jokpvrT07sAukOkU5T2jse55aXvBfRPs1ldAgeIaI7uiS+pzn9zQB1niw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Thu, 2 Feb
 2023 17:42:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 17:42:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Juhyung Park <qkrwngud825@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove more NULL checks after bdev_get_queue()
Thread-Topic: [PATCH] block: remove more NULL checks after bdev_get_queue()
Thread-Index: AQHZNuaW8ltCXID7/kuF/CXKFkFnGq677baA
Date:   Thu, 2 Feb 2023 17:42:45 +0000
Message-ID: <7f407c82-7ad7-0705-acd3-405e2fc4e2c6@nvidia.com>
References: <20230202091151.855784-1-qkrwngud825@gmail.com>
In-Reply-To: <20230202091151.855784-1-qkrwngud825@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7653:EE_
x-ms-office365-filtering-correlation-id: 41f5b1dc-a766-43cd-61a6-08db0544e4bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6D8qj4ZRlSxIjw7+7Z4v5bvcYrQ/K5h5V/FPIq+qscWs05KLc/lmkNi8TPtsozP/hN5a/21LbGeLFgO2BN49cpMERz03egL97sg1XjCY+2EGlfmq/BIh9IIFZuHB8Cc26S84iMTwr0vc75MAgG4fnH/9WYXyNA2o59q2rqcBKvIS7MosHHlQ0W7J9g2S/WszTblA5YqHXQ/RtzvW9X4vsZtSd4nvlr8iy2DECiEiPVoowkC/O1Mj5O41P63bGy7aUKkUhH0eae95LGJ2O14UonIJyzBL+rzptCi7AclEr6PGfRdUtBm1LlqR5hMhlpjCCoP3RxYLIXfwg9zEjiLSBLP8FaApGJyCORvasKsw0eFCU7fRQTRD+r6kUGgI5vSAQA0MzCj6amYto8rt/vBQ+Tnu5+6VFkDq/ASPiYZ/mNJlsty16gceUuOaIS186JhrA80ZVAqFHb1/D/WykArKOFEqwfR/JjTNRU45YzJaJ9/yUQwDgLbdE1rfSlT1WLvPUPTjoevOqwyqygvhbNnWxxpkEHDkbrsJoK76k9Bek9PRT6nwHZceoSFSPmYtWb70V8SL6iQNRK8XNBJmiL+txZQTQ13S1/C60r2xoJ8UhWYV0zyicIwd4xK72yil1peFRJEck3ONAy4xmc2kIKD+MFo9UdeifQFwu4+kC4zYn1CRNW94t48HcmQyCi7pVyEOIZ55NxPrUnt+/W1j6NG1ySjizJc5paw30AraX8HGu2sRQcvmyjnKz71qPiZuz9rb/a76bS5EVrS4f6vUDdi3Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199018)(83380400001)(31686004)(478600001)(71200400001)(6486002)(2616005)(6512007)(186003)(38070700005)(53546011)(38100700002)(6506007)(86362001)(122000001)(36756003)(31696002)(2906002)(66556008)(5660300002)(66476007)(4744005)(8676002)(76116006)(316002)(64756008)(66446008)(8936002)(110136005)(91956017)(41300700001)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUxlcHhjbnVPNDIyUmFnczhLdWJuanVVYmx4ODluUjd3RGF4RVR1R0xxV3hT?=
 =?utf-8?B?enJSbEhoNFlSWmQzT3ZzUmJ0OVliQ2V2cGt4WDZuVzh3OEdWZHlyQlVoT3JQ?=
 =?utf-8?B?T0YyQlMrZ2JNZHJoaDBUaDEzVHQ2dWRqRWM4V1BxM2Y1blB1ejRSalA5U0xp?=
 =?utf-8?B?YVllVkVMSXMxQW5TTWtGNUMyQzVOMmNvNkJQY3VEa1hkRnhsTGt0akM5WmZX?=
 =?utf-8?B?cmNsNlRMUldBMXBIbDJVNFh1bGJHNVpXM3JLUVduVTFWaVRxeHo3Ymg2ZVhh?=
 =?utf-8?B?SW9ZaU9QMWxuREhweGdrdFdtTGtzZitvL2UzelJsU2NzU2t6dXpLNEl0dExX?=
 =?utf-8?B?NjBraHhvVmtKbE9ONzkxVW5Ua3BnaDFaNDBtUnlpS1lPSGFER0ttOWRTeUl3?=
 =?utf-8?B?akExbERRV3h2WDMxSUpPYkJ3ekxlWHloYk5xaHU1SmNhVXUwRy9uaWJtaEtp?=
 =?utf-8?B?eVFnaEJqK1dYeGVQcjZaSDhYUEJKbVhVK0lOVmhaQUlZelU0cFpaQ2o4ZWJO?=
 =?utf-8?B?WVB3S01VZ0RwZEhBMVJHTXgvc2hqaS9QNDhoRVcvWjlTQzVFU1pYM1l2MXRH?=
 =?utf-8?B?RytjY3ZRMVAwcEtxVE5kRVZhaUxZNFRnaTNiQkI1SCtYQ01YOG9zTFZmaFhx?=
 =?utf-8?B?Sk13MVM0THdpdEJhemU1OC9nU1Q1bkNsYVhmRXdYQmUwWEpINExXWXVFa2Jp?=
 =?utf-8?B?ZWdHNHc4VW5kQjc3QzRQS3U3UWVwY01sU2xnaE9SWjVhdGxnQUIzZ2tNcXlx?=
 =?utf-8?B?ZmdxMVdvKzgzRDltanlFWGxSMGJNK2JRM0g5NXByL1lSS1BpSkRreHhxUU1B?=
 =?utf-8?B?Y0hPWm9Jd3Zmbi82Tk5UVzhZcDJvUmtzaVJobVlGYnYzU3RUR0VXVVpTSC9k?=
 =?utf-8?B?ZldWYW8zNkZoaGhXQ1Y2c0s3cDNpSEtCL1A0ZndEc3BhMjJWL1lHTWEwd0h4?=
 =?utf-8?B?TTFtOXY4aTZhRllUVUtFUWhqakx2bnJ2ZEN5Q0tqSi9NN212U2xLaHIwQThX?=
 =?utf-8?B?MFdvZWpKNG13aGZ3MjRTeVVnUlJqa3llOFdQdTZ2U0ZZa2N4UlkveUlzY1dP?=
 =?utf-8?B?cnFka2dvMnF6S1B3dkZnYTdYRkU2bjFxSnUrdlBsM21neDlGUWFSMWxSa2lS?=
 =?utf-8?B?MEIyR2xQUG9yN2hZL2o1MFpvL0NYTzV3TUp3N1MxYmdDWUc5WTJ5MFJJNCs5?=
 =?utf-8?B?UDFrWlduS0ZKa3Z0MjZQdTZadTRvcWZJUFg0cGRxbHdZMkxaUzlyOC84MGFH?=
 =?utf-8?B?dXpnTW9DWVBEZzVHOUhGa0dMRTlpMWticHRMeDdWK210ejdIWFhsUUc3WTlK?=
 =?utf-8?B?QUQvOFRNZmk4c3dlR1lDMGNZaE5BcFFkQjVabCtqVm9xaFFmTy95b0F5Q29H?=
 =?utf-8?B?cDdHK2hpdTNSYjlHbCt1RGdLQy9rS2dsWXIyeVFHQnJJTTFyUkh0Q082bHRa?=
 =?utf-8?B?RlVGdkZSaUQ1NUxKK2Q2STdVU3NaTjgxM3FCeSs1Y0NoalVNdnNybGY3UFJz?=
 =?utf-8?B?bWluUE1WSldwaVVuK2ZuMTUveXZOMXZYcG1oY0NSVjNrZlhSazhNVyt1LzJq?=
 =?utf-8?B?SGdqbDlDbW45Rmh5U0MxNjNyZGd3ejdzS1dNT2tyVGkrdlZnNVl5UHZlQS9V?=
 =?utf-8?B?Sk5hbU5hcU5TOFhsNlM3UStnU1dGUmJFK21jTmp2N29SM2dhQko1VFcyR2Fl?=
 =?utf-8?B?S3EyR21icmtrRk5YT1A4NXZ6ZU13aUh5ZDUxdzdMTFdOZjhhT00rdWlaZkwr?=
 =?utf-8?B?R3hVdm5OZUFneTg2VThqSGNkS3JiQUVqM0VKUVV0cVc2Vk5sWnM1M3ZKWTM4?=
 =?utf-8?B?eVY2aVYvUlIyRXlEeTdmUCtXL2podndrMzByblU5WEkyaEpBemVXc3ptOWdi?=
 =?utf-8?B?VUM1RElxTitiL0pndkpxOXRvdURDd0xPcldmTDZYYmwxNXBMSjFUdDRJODRZ?=
 =?utf-8?B?RGx1VWNCQVJ4QTNlOGtGVHJoeUVMaTRjckhZNU9JQkVZeitYZUFnMXdmUFdH?=
 =?utf-8?B?aWJ1b1lvVFg2TzBPZmlCRzc2OVlNdUhnSUpEcTkvSkFJNjltTW5zTDZWNVEr?=
 =?utf-8?B?eWp5RmdaRWdnSzhIT3g4VG9qTStZUlhwc1hBKzVyNy9VTzJOQnY3d1hmbWlq?=
 =?utf-8?B?bmRWa0Nuclpya25xT0NpNVFFUjlUZlZZQ2h3YjBQM241V3J2K0o0NXFYbER6?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C663D096DBC34641B3B85D885D2F8CC1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f5b1dc-a766-43cd-61a6-08db0544e4bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 17:42:45.5898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Zxg1+J2fQ4YTfpP1zEy0hG0kmDhuBg/doESe+nIHE9wZEQUhtMc92JkFafX65vghKHfDG6dYBvFd+TIFZCsJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8yLzIzIDAxOjExLCBKdWh5dW5nIFBhcmsgd3JvdGU6DQo+IGJkZXZfZ2V0X3F1ZXVlKCkg
bmV2ZXIgcmV0dXJucyBOVUxMLiBTZXZlcmFsIGNvbW1pdHMgWzFdWzJdIGhhdmUgYmVlbiBtYWRl
DQo+IGJlZm9yZSB0byByZW1vdmUgc3VjaCBzdXBlcmZsdW91cyBjaGVja3MsIGJ1dCBzb21lIHN0
aWxsIHJlbWFpbmVkLg0KPiANCj4gWzFdIGNvbW1pdCBlYzlmZDJhMTNkNzQgKCJibGstbGliOiBk
b24ndCBjaGVjayBiZGV2X2dldF9xdWV1ZSgpIE5VTEwgY2hlY2siKQ0KPiBbMl0gY29tbWl0IGZl
YTEyN2IzNmM5MyAoImJsb2NrOiByZW1vdmUgc3VwZXJmbHVvdXMgY2hlY2sgZm9yIHJlcXVlc3Qg
cXVldWUgaW4gYmRldl9pc196b25lZCgpIikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1aHl1bmcg
UGFyayA8cWtyd25ndWQ4MjVAZ21haWwuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
