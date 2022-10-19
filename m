Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DBC4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 06:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJSGGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 02:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJSGGT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 02:06:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA20C659DF
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 23:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSNXT3WYfLL3WkbJNzxpJuGzLTKRyCDT8S8MPrEy8oSfduX9mLQrevRHkIYPCqsWh/jb8WCtUTCTe3iUM4fNRlqpJza2+Xb4va0cP6U/RYkTK9t5XyEPsr76FowChtE8vO3nvgLhMvJq3bL8krdpEx5LbvY5692dL4g3WC47Y/Hd5Nwhrjv2l22iHRyf0y9J2rZvcARpQqboaupjB/gYdPAskqyDyKpukfKCssSOoVEDuA0t1Bcu+jkz2wYFogQJmS4TsDM6wjj8lKIoMzW74z+YYvl+oo+7J+qmqJe3RaPTgZOZQMiiiOO4ev4xPkWrZr6pOHeDWqIfkeAc1USUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPiJG+3lvRBPb7nOxGUeCrS9sLZSQ3GI/GVgA1SZz3I=;
 b=Zvt7KLx3STzlIOo0bFz/VRShFweDb8sHjuUUfnou5kdjsXfWFp9HnfNqd+TB4jJqEBEl0GHMFbPak+ROqe6pIwl7v11PxSy1ZajTBkgG8vB7ymTIhetzCTHRP5eIBAYROGyuYzOxxRGfHJCKs86RG2ZhXX/bti9kdFjmxRkWSGTKecOzYb7wbZNsqyX20oGbxRvffgDGgCZ0cv7xhqxxX7ePMh++TBHkC76djJIvALe0g6DtP7XuPKxguGiD1ZpTwp8gQmD5G2ql5SMQvpM0mxg+sjtKcDbBS90DpW+9t/JO2fEzc0Q2ArHXldo3ZM0thgNxtYzjejiOGwVIvjR1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPiJG+3lvRBPb7nOxGUeCrS9sLZSQ3GI/GVgA1SZz3I=;
 b=OO3cNd5aAXmsv3urMm5Y1VwSS01VSRDlqzMqERnk32vTDXbaW4J5DsINwhhn5faDhMrL6TSvPFhq6ciQP0IelIZQdJ4HB3Nq+GkYFIDWDAX8Y/JJnrSTpiLmRP/leBx6t+RylVOdDKtmAM0qaQz2IXTtGSmj3SiaJwUAG6grf+4SNGyRbWS2FtleTm/7BJMUqrNNAM2US1VBmBfG9D4DbvCU41QkEhTK4JItd8lqIwPQNxvy3h82+hyO1MyFze+KJ58lLmXWuoOEc6octjNYPsth3fqAorOCY1tY0lPHAW1bxcgTw7HZGYHYYwAQBIxhJMVwDZnaGCC3iK2zVJ8Tvw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 06:06:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 06:06:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sandeen@sandeen.net" <sandeen@sandeen.net>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l60hl7Fc9KsUGQcUgAzbInn64VOtQA
Date:   Wed, 19 Oct 2022 06:06:12 +0000
Message-ID: <08400395-85db-94a3-372c-d3121cfbba69@nvidia.com>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
In-Reply-To: <20221019051244.810755-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5146:EE_
x-ms-office365-filtering-correlation-id: d1cb091b-96cd-46de-5ba8-08dab198064e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h7v+tfDX2x4PiKuTO1iqxNn1P8Ydflk4TvZZRCjzhWs3IsqHV/mHWAYCHtp33OkshwZv4wl/MzSyLfwGnGJmZkoEl81sGPqJZ/Bmvko9o1EEplL6ZUwo3ri7Reiwn612y9fLwb9v/kVT+9pQYz9+1Qr4IcUjQSCLQCcE8Ukjm4MY12KuyT/Hfx+POHFN9FrHmaVecqFt0lxc1NJ6jlG+nok6C5Mof8LAzpe/pub8AbsUvwxnyakTa08mb6T2Jhw77k/xaWSMVapo7+k3g3JEjRgi5ZHlSKLH3LiPeBdXkpLGuuHMFtvwAj4stMPtGeW+ryf7vjhjtyD8z40/5k+0gOtvou6Rm3URDo4V6zhQWmC+HiFgGRxz3+xpUUHDCZ6BbDxsMkSMiCvk0flFqWGuLBFrU+sxfuvWsFhcLg36IgdlmLSOtshDYvRarx5IhXekOzIYC3N5uCqBa9Zs7xph40sqS+PNurTORTFb/tTHIFHYy704oAzvivNCVlKm9uvGJ67R4w2Kl0idNk6Lfp5lgxghswt99TtstKtPn0v8SoohE+MFlNQyvBwUB8dRT/XjxSWQqz7hNqKUrIwJll0qHQJgDx6G8MdjK+Ve+BmtChQO47f7jCHGwCrMEMWuxuMO2svedF1cgSi0t4XgDSx/Aw/k2hwQIj14wnuX/qC8mO72xXLET8iK18srCSJPG0UtGQSust0gXvA+BIETUjnfFKso344tjAeunOD9Ph7GcqMidTUMzXDwrn4TApv+WAwlgygaxIpzwCyzTZO7EsmiBo5Xlk7+RBLcUbha+30ZvmG1nfG9me+ObkPCYhtEzY2VaQ8kf/xVQ6sFsub/JwoFUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(31696002)(36756003)(86362001)(558084003)(31686004)(38070700005)(122000001)(38100700002)(2906002)(5660300002)(6506007)(6512007)(2616005)(53546011)(186003)(71200400001)(316002)(6486002)(110136005)(478600001)(41300700001)(76116006)(54906003)(4326008)(66446008)(64756008)(8676002)(66946007)(66476007)(91956017)(8936002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enBOdWNpRFZCekFvL2U4SktUUnJOcXVqcktuOU5pazJpb21jREdDc1J2T1JX?=
 =?utf-8?B?WGV0U1BYVlo5Ync4ZXhvLy9DYzRmREVOMnFBbmNqTGV1TUpwT2duUTVXQzRa?=
 =?utf-8?B?dXZiVEhPcUVCNDVMOFBxTE5qY090ZXRyeS9sZ0lCcDkvWUFhTmgrMWlFeHM1?=
 =?utf-8?B?dFNBMUgxNnRyU1lCRmo1WC9kYXZETHJoMmlzSno4Ny8rWm9EU016TlVVUitD?=
 =?utf-8?B?WXhQVWRHckR4VjJvV0E2RDVRQ3JJdTg1MnN4MG43Q2dlQ295VnNmcTJKcmY5?=
 =?utf-8?B?Vk9tYms1ZS9HV3pMeDdhL1FwTG9QWXY1MndsUC8xeEgyWUtISlZKZ0lDOENs?=
 =?utf-8?B?YVRDLzlDVjBNVFRJbDhlTTc5dmF5bm5WZS8wbXM4aHBQYlJxc2RvYVNBWk9X?=
 =?utf-8?B?NzFrQXFjVytMUUVHaExHcWpKRGZ2MlYvVTRCNkMxMU1Hd0N4bnF2d2xmcUxF?=
 =?utf-8?B?aWFucmJSaWlkWThKWkxVaC9PeWp3UW5IalkwckljTFdIa051OXNod3dvNmQx?=
 =?utf-8?B?SWNReDkzVUljRnFzWTgzazg2TVhrdHZ4Qk1oMmxEdDgvSEJFaG5HVEkrc2k1?=
 =?utf-8?B?RDlBbHd1eTB6NG1ONklPbTFkTkZhYlBkQ2RLY2lTRi9kZXI3VGxkejNXTjdQ?=
 =?utf-8?B?NU1qdnZtTC9uSzJEUVM1Nm12QVlUYk1IS0N6NGUzT2tYc1JZY0loeDlaWWdz?=
 =?utf-8?B?V01ZbE5zYW1TR3B2MVd5K3JGdHNqYW1BRmJhZ1JPMktFd2hDRDcvRFBlOERE?=
 =?utf-8?B?dTZXQVhZQlZPTW92MnVuYUdtL2xzYkVPN25vSGlaN082azJWMWdqbGtRcGJx?=
 =?utf-8?B?Wm1XeXNOaUhHYUhSbjczT1Z1bUhoTU5iRTk2UUJVMUZwTFVtWVNvUmFxUkQr?=
 =?utf-8?B?cm03RGFmMkw3bHR1K3RxZWFURGJoZGIzQVB3dVpHTUc4R1k3WHhsZVU0dmta?=
 =?utf-8?B?Y0J4cEpxcTFJdmVFR0VEaExvL3NDWG8rVU5iWU51bW9QSmRraXpmS3RObGtQ?=
 =?utf-8?B?UHkzem9TaTRjMytRbU1aMEptSDZuZloxMHI2M1k1SVloMzBCMncveGdKK1NL?=
 =?utf-8?B?aUJodXRHb0g1VU9ITlRLckNhckxvRDJHTm5tU2E5amc2VksrY1lYZWdIa3Z2?=
 =?utf-8?B?RENpUzM0SVM1ajhQNnlXN29uNXdDUWw5cU5jWllvRlVleHd0eHVSRTVUYlFo?=
 =?utf-8?B?aEZHN3NVbGRIdDlxQ0tvMU1ZNEw0dEFpK29CNnlWSVJNWHVDQVNCU2JVd2N3?=
 =?utf-8?B?dCtSVU1XYWl5ektpWkRLdFVXTEh0dFVXR0RINVgvUzdqYkl1aGIzZzFnWEIv?=
 =?utf-8?B?UHB5UFN1dVNFZ2F2Nm9VdmJuZ0E1aGY1Y05TK0NSbTJpNnNLdnZ6YVMyaHVa?=
 =?utf-8?B?bXg2TTFaU3JqQ2NxeklJeHdFcXZMdjdCRXE0b05pRmhEKytiMGtjSmtVT2tD?=
 =?utf-8?B?WURUNzVHOHpYZnRRTjFMYVd4NzhNLzJLVnpPTlpHYVVBOCs5eVROV1RzcGhR?=
 =?utf-8?B?OE10MU9SbzdhOTBPQUUzQ0dZdHdlQk1wNHkxa0hGTHNhQi9wbWxNSzcwSE9F?=
 =?utf-8?B?Vm1TQTFIeGVVbkpudHJIdkl2RHYxQnFzN1BxNzhTbmJwdnFkRy9NcTBDNEZr?=
 =?utf-8?B?dDNCYnZXYkR1bmZjbHBobk9NTm5Ldm96NXduc2VYQTVudXlUSTFKYnY2OXNo?=
 =?utf-8?B?TVNheFdXbU93bVF6ME1kSUVDTGtIbUF3K2ZYdlQvQ3poZko5QU5uM1BRNlZ4?=
 =?utf-8?B?NUZCd2kwcWxjSnRZZEd0TzFKWFArWHJVL2ovaW0rM0ZCRE9BeTNBUU8ya1B0?=
 =?utf-8?B?OWlXQzZ2RGk2VzFhS0tFK3Q2STNEZEh4UjI4OXdEVDVwbVdoRXBVanB0aWsx?=
 =?utf-8?B?dTY0Y2tGb09IYnNuTDg2NnMvUlFWNjZQV2QvanpoUHRSTjZQT0svcnNKMG0w?=
 =?utf-8?B?T01pQm5COTh0L05VbUZIMXRhSTJkZXB3SnZ0c2Zzd1hFRXg4NEY3N2dTTmgr?=
 =?utf-8?B?dEdFK2lVckd4UVliaklwZEtyeHc0aStVaGwrK1FJNDBqcFBRNXlnaWU0RHVL?=
 =?utf-8?B?c01CWTlERUMrVm5DZ2NaU0NNc2lyY3V6SnhmdU1oZjVhUXI4S0swWUtqNlJV?=
 =?utf-8?B?VGNxZzJMNDJGT01tMGdmeitKK2taUURXekZEenRSWmU1UUJnRDdRZnBWa3hr?=
 =?utf-8?Q?JszAgLuqzqVnUAWNRsj3VOqZ8Y4xAkw2zECG370S9zwE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5D4EA4FCB83584EAB6BD09681059FCE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cb091b-96cd-46de-5ba8-08dab198064e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 06:06:12.4665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ID6RHUax8BfZtedicWIfR4lW80cdfTqtQMftRehsJK782tl6iTj5A5WWFzVsO8yPKL8eilUSg+b4wEFcTaWoSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTgvMjIgMjI6MTIsIFlpIFpoYW5nIHdyb3RlOg0KPiBUaGUgbmV3IG1pbmltdW0gc2l6
ZSBmb3IgdGhlIHhmcyBsb2cgaXMgNjRNQiB3aGljaCBpbnRyb3VkY2VkIGZyb20NCj4geGZzcHJv
Z3MgdjUuMTkuMCwgbGV0J3MgaWdub3JlIGl0LCBvciBudm1lLzAxMyB3aWxsIGJlIGZhaWxlZCBh
dDoNCj4gaW5zdGVhZCBvZiByZW1vdmluZyBzZXQgaXQgdG8gNjRNQj8NCg==
