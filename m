Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F8BC433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 18:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJESpx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJESph (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 14:45:37 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E423F6B8E5
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 11:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItTTNJ+weKdRkYQaMuxZ6YmcLfk6R+bYAIZZbOa5G82yi3c+h9OYi6nzPIYn45ZR2YSWZy/a8dO9LF3xPQDadoOZdHPYswwCRGTcueED+HI1r6Rzm2As23s4x0bmR99HJcdfSkFWSojJQaebNfhbeCldcB4jcZO7E6VXyM2s5NQQsAAKludIljzl3IcKoopk3uHwk84tFi3HrfhHm8foY8DWHcWQpa2mFKp2YuNNRRX0x21tXdHOyC2UtOtzHoywECIdfwf7kOgkd+OfosKvUiTUFO9rMxsYYcTn1XCLSIPQv27EMjN7qi87DyBmZLdpqH8CdLc6vIfl8/xr+mZnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VIxc17j3UYtHrU49d/N6ZrqKKq33ZeXCX3Q7hPPjpU=;
 b=SAzVD4kth1af60CkpMur01H5/aqlhLomySxZoX2VXBP8zJCiji7HqbQCcKM7XX5+gijJvtos8GW5vHl/mJKYHLCrJa+e+ge/Hx4nviajAdCiFnJ9eLyC/UEae4aiDqNVuEMcl36KitBg1wJws75D070aVjXgGnNUSjG1XfINdlSXaGJhc57Fv8raTitxk0Y184+7rImuStFzYxHEl1++b/8H+y77Ibp12QHYmXeZxp/55RBx2x+RZ772RlK9hv8+6PGuOUAcZ5Z7uSxgruS/iTz8flyczhOtE4zxvoLoBChsWSyDfHAXWFmcL7uM9ZJ0zzK0DMvk07ZhGWgbiNS4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VIxc17j3UYtHrU49d/N6ZrqKKq33ZeXCX3Q7hPPjpU=;
 b=jVJD1m11sH1zJtmbbVBk48iPfouSU2nz0CYgtstIFynyP2Di6Cy6k0yUqkrTfUdxXqi7IIVbYEcmgJkFvLASFBxsN1/TcFEDtd581VtKTiaQDTgP3q6T6Uv7DpF7DBUXDymyUw1mff5UfDQG7Kfh9jAcwyDTnoIvmYdQMtV7iYK5GaUYd/yBIZCgrzS6dym6R2bTQ8pHA6MJZDEuc6hZl+bGMkF/Ij/1UVyzxvtUAWMuWqHs6mf9orRixy2CZ1p8M6L08axoYzn8m7r0J+3UfmACEDXPcu8ZdT7KeYdp9SoBU1n8n7TrLCcnVFnPz1RsW491y8fLsFJnjQFNRx3izQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB5454.namprd12.prod.outlook.com (2603:10b6:a03:304::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 18:45:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 18:45:35 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Brian Foster <bfoster@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/6] null_blk: allow write zeores on membacked
Thread-Topic: [PATCH 2/6] null_blk: allow write zeores on membacked
Thread-Index: AQHY2GkFovuCv41QBkqHDwUISksJwK4ADCoAgAAYUQA=
Date:   Wed, 5 Oct 2022 18:45:35 +0000
Message-ID: <09793b3d-b1f9-9755-f3cc-1f0cfcaeded0@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-3-kch@nvidia.com> <Yz28aEOOUqrCUhe2@bfoster>
In-Reply-To: <Yz28aEOOUqrCUhe2@bfoster>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB5454:EE_
x-ms-office365-filtering-correlation-id: 74e9e60f-1b0f-459d-c029-08daa701ca02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+tuO3DZM65vKQpPPNl7vtNVIcmKL2hUVoFbihanuvKW8APsZIQ44JLB0p8m3mEO0Y3auG5arQ/x1/uJiV1ic3jZy4QcQdbJi86cWi5KYpWU9SqVp8RCeDNQmWUwdT0trSjRQ7vxBu7ycNfBKNxoqf4pnl+OTKI6N2xWffbaktUberCG0tWzdeh9BXqknj0XyqZOHqYG6JXRwC3bu3v1cT2ekjiMN/dFr//uMSduKsTuHzVAPONyPALC9mC7ntOHx4QbakLG80OD102xVq3D6C3OfpJZ0SJwym39hDTveqNE7S/r9I0mHgG5crOH97nstCtY7FGmbz7KPP9ZkGFbmIaP4RRZCUAKeT9T6ftntlrWUwQtBnrtfr/WdtKZ/4ZxbLLdnAL+yS40FbrfHaZy5RoBWZy9jfrktkp566Y4zDPhh+kl1iqyriOIyxDkd0xfvjFmb5haAY9w9/92YqXvEjkICMlDut7O4YHdKRTukqK4WNOSrOp7SKbgHPaGYuz7GkZ3VjY2+2l47Rx+wajq5axDEPBfcqMty+MtQyodpWJQqiFRdxq9Esixn2+XfKhkxoZy/9UaX04zZrOM9PJXA3+df704xT+SCh81DjLtV2CwnbXg/JxP/96NaqRZC32Gx1nfQm7FbwSn23YIHRHtvOj7bjb9UieSqlB/ECklEAmasuVp1fco219WBr0SWun88SpO0Hno/oKWYSv2hweSXL3hLRcRgtqe2JzYdadYtgTv5RxI0iSz7WDr85Pg2fxBlSMom1msfRJM6ZJ6+ZkXMbkTXDr3RGjOL7/oi4E+cQCn695WUoI9oidP1iwltxZylvTS4/uKQqtOpfY+PLQ21Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(316002)(6486002)(478600001)(110136005)(54906003)(8676002)(66556008)(71200400001)(64756008)(66946007)(66446008)(66476007)(4326008)(76116006)(31686004)(91956017)(8936002)(6512007)(5660300002)(41300700001)(4744005)(2616005)(186003)(7416002)(2906002)(6506007)(36756003)(122000001)(38070700005)(31696002)(38100700002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBIeTlkSlA3N1JSbU5wWW0wMG5haHRJSzQ1WklIUVh2ZnQxU1prQUxFcDVi?=
 =?utf-8?B?QklqcG8xL2N5QkcyVFJza0tsbkpUYlNzdktKczN4dDNTbjFoRysrUGhCSVQv?=
 =?utf-8?B?YVdpWGxGbFczN3lId1NCU0d5NVJtbCtUN1RMdEVyUWw5R2M0bjIrSjh2RmFt?=
 =?utf-8?B?Z255MmxGVGFpMUw5M0ZQWkhMS2tMaHMwVXpZZldaalRJbi9kM1ZxY0RRZk91?=
 =?utf-8?B?M3BmQ1BJbW14cWluM05iSzFMYW9tUzZ2L1oxeG12SjZIdFgyZUUwZUJRYjlv?=
 =?utf-8?B?WlJscHJUdHZNMHRxVFJmOXlWcjBldG1JMlN3bEgyRW1UQTNTbnhhems1UUp4?=
 =?utf-8?B?QjViUlQvZVZoMHY4ZnRPZ0xQVVdoN3VDSGRIOXFKbDg3WEk1Sjh6WHVmQld4?=
 =?utf-8?B?WWFHQjdRM3QwNGJKekRscmhpYlh2NHdiSFNMRWxKL0pkdVlTbXdNdkl3RFpW?=
 =?utf-8?B?MVBqT1BWY0FrTG4xdHh2SkdvOHlrUjUyUm9qYnlndHYySmRvLzgzemNaa3Ix?=
 =?utf-8?B?ZHFmRUpZVGpiWlBNZmNmS25oRkcrMHNsb2JSSEt1ZVltUzBTUHo0V0pSemtP?=
 =?utf-8?B?NktTQ2Y4aW5oM3NiMmlDYlltTHhzNy9mUzlOaUNOVVNuMGZNT2ZJT1J3cWto?=
 =?utf-8?B?dy9jTStZQzkzaEVOR1ZTdHZPb1BWaDUycFVuOFdKaDR4eWRLSUwwRTI5bHhq?=
 =?utf-8?B?eXFaNm13SXBpVVdrVFUzSmsyVkZCKzVKTnZ6NDJTZ0Y4OStMdDB2TTlRVy9I?=
 =?utf-8?B?ZFZOb2dBZm5GRFNXUnAyT2hra05TMDJWWkIyUmJXNldoT2RSb0ZKaUJlbm9i?=
 =?utf-8?B?MUVRTndabVp3cExNRlZ5Vk0rQ2FUS0dZWkFhOFMwcXppR1BjcVRVdzNMSkl1?=
 =?utf-8?B?SVM2ZVA4M3lnYTRjMEozeDliOG5FcHJYUUVCWTJ1YVhrODNsMGh5ZlY5OEw4?=
 =?utf-8?B?V0pjamd1VFR5OGFxR2pqRUR1Z256c05leEFBTzZWTmdEOGhpU2hjYVNJSWJQ?=
 =?utf-8?B?NkQ0cnBRdVhOa3FzT00waEJJMWZGYU4vODBJa0NwdnkxSkpNMW5xbjRzVFZh?=
 =?utf-8?B?SVVQRDMwa1Q0a0ZTNTkzdk9NaDZQcHFheU54RHNmVmxTMkVROWZjb1dva0pU?=
 =?utf-8?B?dmc1Q3luU3FkVFBQaWJ3a3dlVEVNNmlybU95TVVOb3RQZkhJL3JJWUk3SlZj?=
 =?utf-8?B?U2RweW4xUjVkVjV3MncxbzJCZm9nVVdpQzgzS2RSZis4a1owVzhvNDloMmlj?=
 =?utf-8?B?WWxmV3Q3MVJWaldJVXNsYnhNa1RvMkJzR0dvZktrcisrVUd5QktnUEUyWjVp?=
 =?utf-8?B?c1hMdEdaNUdYY2RqMUkySUl3VDV5QVNVeHV2QTZEUCs2SFh1TE05SmNZbU1k?=
 =?utf-8?B?L0c2REVNNVV0VDNGRUpMUllTN0srTStxV0J4WGhWVzBrd1dYNzZZK3hJemRa?=
 =?utf-8?B?QXM0bnZub1VTS25aaVNvS1cxOTVqU3BUbHIrMEY0U0VnYWQxbWtJN010VGEw?=
 =?utf-8?B?OWpnUmtnbzl1UC9VZ1lZTzdJQTg1RTNzbHNFdS9WT2Z2U3RaSnZ4Z1MvWFdq?=
 =?utf-8?B?WlVNZEUyekVIQWNVOWc3TUowTldCbjlYOGdORmtMUHMwMlhIdml0cGxNNDhB?=
 =?utf-8?B?THZaMEVPSzdPVEtCSFAxQllCVzJ1TnhwTitSYWtXUXNTdWRuTUk2UUVrcFlo?=
 =?utf-8?B?VWdJb0lwTzFOd2xXemIvU2FVRy9nd05vdXBlV2I0dEJqejQxZUljS1BRaGxQ?=
 =?utf-8?B?MURBWVZwT1NkcHVqWHNJbmtPRTZXa3o0RUZEN1ZIb0JkdlJmOXBxVzRkNHhk?=
 =?utf-8?B?UmUrdkdqaWY4Q2c4Tzg3VEQxVjQyOFU3Vkd2dVV0R0NJOHBkRi9OdGFGUE9S?=
 =?utf-8?B?a0FZODBMRFVVR2ZzS1BDalI1Vndibm42MXNNT01keHlaQnZkRWxxRDRHdlRV?=
 =?utf-8?B?bWZ1YTM2ZEpIcnlYQVFOcnNYalk0RlRzYnNBcHNneFVQM3lkcEVzV2dwZXNK?=
 =?utf-8?B?TFIrZ2E3d3ZkbnNnNm04RGYydWRPbTNjWEpKa0pGRUdCL0s0SWtpZG4vd0xt?=
 =?utf-8?B?R3BTU1o1Uzd4SWRRQ1ZxdDExcTdGMUxvYlZwMjFhZmN1N0lGZ0xMSVBOMnVC?=
 =?utf-8?B?UUJIYVFhdnVLZVZJU2UzMlRoYlFvRHVCS0phSEltRnZaeGUrSjdjNzgyWkFJ?=
 =?utf-8?Q?owOd4EffZ0DYsJj20yyFNy5spe7Fl0EWUxR2lrrH3mU8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BD15424EA496146BDD5E1BC92DBC992@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e9e60f-1b0f-459d-c029-08daa701ca02
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 18:45:35.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VDUjJ4y3iedaX1m2p5G1RmpbTW89WvLQ0sVIt+KuXDEOuWW5W76H++/G59p8ReYfCenjXwVXAOkdrKESZzn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+PiBAQCAtODc1LDYgKzg3NywyNCBAQCBzdGF0aWMgdm9pZCBudWxsX2ZyZWVfc2VjdG9yKHN0
cnVjdCBudWxsYiAqbnVsbGIsIHNlY3Rvcl90IHNlY3RvciwNCj4+ICAgCX0NCj4+ICAgfQ0KPj4g
ICANCj4+ICtzdGF0aWMgdm9pZCBudWxsX3plcm9fc2VjdG9yKHN0cnVjdCBudWxsYl9kZXZpY2Ug
KmQsIHNlY3Rvcl90IHNlY3QsDQo+PiArCQkJICAgICBzZWN0b3JfdCBucl9zZWN0cywgYm9vbCBj
YWNoZSkNCj4+ICt7DQo+IA0KPiBBbnkgcmVhc29uIHRvIG5vdCBqdXN0IHBhc3MgdGhlIHRyZWUg
cm9vdCBkaXJlY3RseSBoZXJlIGluc3RlYWQgb2YgdGhlDQo+IGNhY2hlIGJvb2xlYW4/IEl0IG1p
Z2h0IG1ha2UgdGhlIGNhbGxlcnMgbW9yZSByZWFkYWJsZSBhbmQgYWxzbw0KPiBlbGltaW5hdGVz
IHRoZSBuZWVkIHRvIHBhc3MgdGhlIG51bGxiX2RldmljZS4NCj4gDQo+IEJyaWFuDQo+IA0KDQpJ
IGtlcHQgdGhlIHN0eWxlIHNpbWlsYXIgdG8gbnVsbF9mcmVlX3NlY3RvcigpIHdoZXJlIHJvb3Qg
aXMgY2FsY3VsYXRlZCANCmluc2lkZSB0aGUgaGVscGVyIGFjdGluZyBvbiB0aGUgc2VjdG9yLCBp
ZiB3ZSBjaGFuZ2UgdGhhdCBmb3IgDQpudWxsX3plcm9fc2VjdG9yKCkgdGhlbiBJIHRoaW5rIHdl
IG5lZWQgdG8gY2hhbmdlIGZvciBudWxsX2ZyZWVfc2VjdG9yKCkgDQpmb3IgY29uc2lzdGVuY3ks
IHVubGVzcyB5b3Ugc3Ryb25nbHkgb2JqZWN0IGl0IGZvciBzb21lIHJlYXNvbi4NCg0KLWNrDQoN
Cg==
