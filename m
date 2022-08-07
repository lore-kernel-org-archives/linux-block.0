Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A38C19F2A
	for <linux-block@archiver.kernel.org>; Sun,  7 Aug 2022 09:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiHGJ2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Aug 2022 05:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiHGJ2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Aug 2022 05:28:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A9FB1F3
        for <linux-block@vger.kernel.org>; Sun,  7 Aug 2022 02:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ+cmPoCi4C0w97uIDUUqz1FBCe4BjqJMIBghblgATXaTcqJzG0UDgXHHO2x5RlPZaqKmtCJbHau/FXuF0iS5j8V8iOszZZO1vcuDE5otdlGFIZ/bktZWDrvxUIYoBjg+cQgifJ6u5Dmh5/MrPPXrbric3g9yKcQvGu41bVq5binQgM2MEGj+voGayBhWjAT6uzDg3uDtcCZcK0tbJrK073JLPtMcJg4NDplfAnqKMuCx8nTF43MJDDLzjJ7KsetjDarFkdHFzi78t+VsrguYhh+6U/liNon7XAXttDD+lS0bk4oQMM9VEjPloE0EpSta22K7YqtFWdKrmANIwWdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wywX7hXDs4DoXOOdEavS6e3t6MSttQddk91rNNzI0gA=;
 b=jI2NT4W3eYfO4HXqflYxDkfglezE8qiWNqgP8QeLHt2u4p+0EBDSdvdM+CrxEBytPByxJ72JxvLwO4cyKHqhjd3Zhdcz0H5wZENuFdgZbvRNVebzzxn1uyxKsDxdGvF+1NglCB10PhKS9QO/D2oXDh8aw090cgocULPjfsxsG2OFDOG+heynztial6A6wvlrUjyLa/LsTHE/N/UsNZKSSM5hNoOlij8btxRxqstTcrtqfBrvX+47aqt1cT2w5FnA88kOb7fyKNY5KZurIFEwxwqsqma2yn+Ryw4ry9/2Ooi6wnROwE+LXLf7YEpYfh54W2ggQ3shBVS/FppPMe3/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wywX7hXDs4DoXOOdEavS6e3t6MSttQddk91rNNzI0gA=;
 b=YOxxL7eGjvjaq0VkY4qfOR2i+UKRaqG07ThjnZr9VqUko+Mrjd1svP73TpcEeLWByQm6Xj2ULAoBlmgtPH14FlktRTehFExZTAlagyKw68TceZAZR0s6Ls/OOBZAbm11XwsqM9PPuFkixgIqbuNsdS5GokEiWX4QQo3H5JUdAFvyTRpoFL+pcAj16VyGyqL2Z50wH/yT903Rv8dCJizSXVveF+VAWox8s2uptd+uJ1Ats5auXSLMxiiQOVeImQSTzLRbSFMbCmvrQNuFxiZfutk72xQJ4UUCfDC1Nm5Tf/566PrwGFivulvu4YQfhzNF/GmDtBqOvaTyqpBUysoEHQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sun, 7 Aug
 2022 09:27:58 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5482.016; Sun, 7 Aug 2022
 09:27:57 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] block: enable bio caching use for passthru IO
Thread-Topic: [PATCH 2/3] block: enable bio caching use for passthru IO
Thread-Index: AQHYqagI0eYPGubDgkCtxqKl8QD+Pq2jLKSA
Date:   Sun, 7 Aug 2022 09:27:57 +0000
Message-ID: <d8467ed6-14e1-3018-e2e6-6cd1137742d0@nvidia.com>
References: <20220806152004.382170-1-axboe@kernel.dk>
 <20220806152004.382170-3-axboe@kernel.dk>
In-Reply-To: <20220806152004.382170-3-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33ea09ef-96a8-4844-23ac-08da78571d89
x-ms-traffictypediagnostic: DM6PR12MB3468:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lThcZ4y6TkLS3RSgo7hKbLJi4YsP7xz+hjhWoUkoBsPEPBQ2TnQARYhteLOgepeCKHsoN5RIjLRMx3ES+hAYzTNMlTFGPBlTAPPUzGo/LUhWb4UHaYo6JzCr1M07SViruf+9KlOyg9CT3wloA2Q0o+is0+D5M17vEAgR/ncpS3uw6Gs8w5kC3hcPbNQZ0VoKn7JDqmtqZqu5CxcP4SW6++z/RRii3CxvHEvlGTcdkV4a490GmDiGjgmeckDNs2+u1eVro2Upip52lxDw50yArqje5OL1W0q11j2/zxHOK6DzYzlwcWwbO/YSB5nF4A2zfZgzQmN61RBqYtmmCbekOB7iwWcRnQhTmakMNdPzRQ3wbufr0HhfW1hqOS1Lh0sItN3YrRzT+IuQbKuqvea7sab/kQp41Vd4c7PthHuoYTrfltHYdW/8g2Owvczbuhs9Kwig8/bqbgFGt4vhVtHOlWVHyfijlVkL2vn/GMAEcOUumiQHJBwxW0odFwi2VHvlUA8CZyUFME31T2xu6yditPpDHZV5RbchO2jIs5j5rPf+CKqFBcyXNBy8hkPixTiYTKatg5s2aHMoOMAGtJ3/e2cKhxhXpMC20/O6ajoVHieZoC1YnPU/qyI1GqMRLmzFFIApKeJ5i+Oqmd/mmSbYFgmEogdLtnU2wa4MIlb8dKDk2NR7OKDXpvwy5jvq4IBoHEVkZDB4h/h0xvVICYSsLkBohfw3YFPVq3tTw9CEO5uYg7KdIop+JNeCo87VmHG+UWJ3hRwwE30Ojao3VGzHHOgDV6b77/XvpGmB+Jj6k9BZRhGdhKuGXRHl6+zpJbtiDSwIlNIFA/kfwShv4tceGv7rDTHrDABMBjCrMbSuQ1QVsGfwCECClZDrdHISwcP2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(6512007)(41300700001)(31696002)(6506007)(38070700005)(86362001)(26005)(186003)(122000001)(53546011)(38100700002)(2616005)(83380400001)(66946007)(66476007)(66446008)(76116006)(66556008)(64756008)(91956017)(8676002)(4326008)(31686004)(5660300002)(4744005)(8936002)(2906002)(36756003)(71200400001)(478600001)(6486002)(110136005)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S082SGc1U3hMMHdhUlM4MlVjVE40a3pQQzRHMFQ2YitReG1IbkxtMU9pdENi?=
 =?utf-8?B?bkQrOVpyY2pGakUwdnZkbHYyZ01YZkxUS1VPbVFlTVBaUDBsaUdxYVBNZ2Fh?=
 =?utf-8?B?d25qbkpRbk94U2NVUFJtOW5lMGZVcUFreXNHVDFFNVJQV2FSeHA4aFl6NUxK?=
 =?utf-8?B?TU5mZ05iZHNuVzB2N3NKQTJUeVFCallZL3QxVWdLRm5DbGZjOFlvRHNhbFFO?=
 =?utf-8?B?M2M5ZWo2SHg0ekRJOFJlSVg0Tk1kS3FveHd0SW00Q2orZERMWFlVUFNkRWlr?=
 =?utf-8?B?QjQ4bGhlNW0ySEd6UzRFUXcwMmMzdlRnQk9NSlNsZE9PdGhvZXo2TkZZZjZJ?=
 =?utf-8?B?R2VOdFN3OElFbGtNRXBsTWY4eEE1cVFzbFI4K2lPaW9GV0JQbndxZGpMVmU5?=
 =?utf-8?B?S0M2QVlURDQvK3N3Wm9UNUd6V2VDMW02bjdFVWlxYnZTRVNNNDFoNnJ6OGxi?=
 =?utf-8?B?b0VyZ0NyM1l5N1VRNStEdXNDQ2oyMVcyQ0Z5WnJweFhsQW1hTlJtTUcweFFB?=
 =?utf-8?B?Q0U0Sjl3V0RIdkNRMXRSd1dWd3Q4TS83ZkxLRW9mME0yNWVEQWJvUDFyNHZD?=
 =?utf-8?B?N0hrbVlBRG5ERDJ4RzVpaklhSVJ4QmVmSUE0VTZMeVl3cXZjTzIyNGcrTFBv?=
 =?utf-8?B?V1B4dVl5ZlkwaGpNNlBZMC9MSmhkRUZOY2pEbkZnUHlUZWREbUQyaGo5ZmhV?=
 =?utf-8?B?SWhSVzB0Szl2YkxRbGtIZjlERjkrbzMxVTRVczV3TG16QW1GN1V5QTgwM3lt?=
 =?utf-8?B?Tml0WXZtOURDU0k1d1RvUTNMN1B1Z2xRRHpzRlltODAwZUFvRlhtNDVPSlpX?=
 =?utf-8?B?dm92SEhRMG42bkVYQ2FXdldObUN4OE9DZldEZWFiZzYxUDhYODF5K3NueEdK?=
 =?utf-8?B?eE1FejN2cSswZ2d2eG5tajJ2eTB5Sjl3blBPWmJUcnJwaDE3bXBIdE9QMTQ3?=
 =?utf-8?B?cVducHJUYUp5dE5YczgxMWY4V3FwSUtyTDhmT2s3TmttQlBxc0twaGZ5UE9n?=
 =?utf-8?B?VHc1NW16WHVQeVpwZkVmd2xPeGQ5NFlUL2ZKbnFydFI1VGNPTU1rdnptMW1F?=
 =?utf-8?B?a1NkbVBnZ2hadlZZdUUzVERwc1pPbjNWZGprVmpzQVYwRHZYRnU2UUl5NHFG?=
 =?utf-8?B?T3lOTnNwK1NvZENvU1hmRnlDZHhLZmhqUG9ieFR2SXlQZGJIVU41Q0NmWmxm?=
 =?utf-8?B?Wkx2dWx5MXBhczBFVWpwdXZEaml0dEdJY2JKeHVLVjVvcGkrZ1FiSXZoNFFl?=
 =?utf-8?B?UEZFdUd5Mlp3SWZlVWZobWFPL3BXM1lwNW8ybThuUi8wZkpoRS94VWxveXRr?=
 =?utf-8?B?MWFVdzJlbzduV0hmMjY3K21GU1JlK3kzK0l1UHdwdWZDU2FkS3VRMHRKWEVZ?=
 =?utf-8?B?RkR2TjNCT1o5SGQ1U0hyOFZPc1VQSVkwbVU1SVlZcmpFdVQ5a2w1OG9MZUMz?=
 =?utf-8?B?UHZDWEM0elZvWXBQMlRWNEZmaWw2VGpLOFVwblFXV3ZTZWV4SW9WeW1hUGtD?=
 =?utf-8?B?UzA1MTlYTGVybEh6cUozMUtxaU1Galc4cUdEZGUxTm04Vm1hT3pNQ1dZL0V2?=
 =?utf-8?B?M0Nub29zTkRiM1pkMkFMMHh0Qkt3WmovQzhCTjFqbXVVbzMrdWdmeDhiblQz?=
 =?utf-8?B?bllYdW9vVjl0MHdPYWVDQktlR0ZSSzgyZW5rbnVMa0J5ZmN5clFDaHFIUTh1?=
 =?utf-8?B?bmxxL0kwUk9UeFkvR2lqREJpRGFkLzJZOWpzdEZCUUY3Y3MzanRzMXBsanJz?=
 =?utf-8?B?TFJDa3dpL0MwejFKQ1ljYURKU2xsbGM3ajZ2OXRZTjNQZnFkdnhGRG55Nzkx?=
 =?utf-8?B?cVhyalh3V1hpc2RmbmQ4cFhCUUxpSnBjL2dQclZnZ0dzdGdCMGx4djR3VXd1?=
 =?utf-8?B?MFlSMXM5Q21FNVhSR2ZaWnFDTWRobVR2OVlqMVVndk4yVUxxM3Zaa2EzOGZJ?=
 =?utf-8?B?cTZjUW9DVnFHVE9Hc3h2MDBxTUU2RThuV3l5WFRORmJibGtiUUpNbG0ycktn?=
 =?utf-8?B?OGRybVZTZVFmMkk2cG1BNW5wbHZETXd4STIrMmRZVUt3bERYZTZPY2ZQdkRw?=
 =?utf-8?B?MnVwbm1EQlRpRk9qMkc5ZFFSTndGVkpjTDVpZ3BtaXYwNGNMUHdGSkN1WW51?=
 =?utf-8?Q?3E0A+pPku1DJjEYTUYnLE33Y9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1956D89F72093047877D3D0539226E66@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ea09ef-96a8-4844-23ac-08da78571d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2022 09:27:57.9204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbr6RlpRrULi9NARd3xNE76yJsesirI6XwIacyBRmKNmfSN7tHYw5sSxFf88g+/Bu62FJWeUv4BeIqqoekKoBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC82LzIyIDA4OjIwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBiZGV2IGJhc2VkIHBvbGxlZCBP
X0RJUkVDVCBpcyBjdXJyZW50bHkgcXVpdGUgYSBiaXQgZmFzdGVyIHRoYW4NCj4gcGFzc3RocnUg
b24gdGhlIHNhbWUgZGV2aWNlLCBhbmQgb25lIG9mIHRoZSByZWFvbnMgaXMgdGhhdCB3ZSdyZSBu
b3QNCj4gYWJsZSB0byB1c2UgdGhlIGJpbyBjYWNoaW5nIGZvciBwYXNzdGhydSBJTy4NCj4gDQo+
IElmIFJFUV9QT0xMRUQgaXMgc2V0IG9uIHRoZSByZXF1ZXN0LCB1c2UgdGhlIGZzIGJpbyBzZXQg
Zm9yIGdyYWJiaW5nIGENCj4gYmlvIGZyb20gdGhlIGNhY2hlcywgaWYgYXZhaWxhYmxlLiBUaGlz
IHNhdmVzIDUtNiUgb2YgQ1BVIG92ZXIgaGVhZA0KPiBmb3IgcG9sbGVkIHBhc3N0aHJ1IElPLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K
