Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC74CC7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 06:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDKGkc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 02:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjDKGkb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 02:40:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284FB1
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 23:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khe2bnHr8wN3gIdxsHZC2ZY1XZaI+UamDHmtt30rcAtpaVDgKWq8A558iAehmXna6mIYCVZjVxw0x6sviKL6+9gyEKpFhFUlDlIEw6llImqrJc3TSK8OPsB6tYYrod7fYUbCY4nEljAooH5MQiivhcesw6Qqt/aGpphoaKD7ZNdHjFntYpj8V2zArUHc0GztHBePvS833R9rMjAsGoA7bxZqOLcAjasTMyu2JxV/+WhCFD7JC0UwjEcnnT2LyKm1ncGZsM+8wi8R7qJg/4vRnuUI0F3iInhYqKJ38cUVDpsCsUv9CgoKxVhAeJ2I7VHQ/e1kC2hZczn2x2u2lGkN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrp4SZnDf36qGoRZFA/+vNLh0hK3zGxdFPzbFAS1Brg=;
 b=OzxGPrrYlZMGofTvD8xiW2e65yemPCNlNaADCmY2wja+39oqATGRxoVUrDY16VpUlPIbkR6UI1cvah8UZCxYXdHqwbK/xkdkMAosH2wa8pEqOkjNWoNifs+YGJvBOKl4Djtg7QTYpXhBdNfbhFY7cb+HcG4r8HCwzTJAw2OU0bICJ0/Qo6wdrYoPc0Hy1l0sD3PW61M43su1WhZbuVAJyAx/EqVw2zw8lIcrO23iieGgYqpbK/o1Qd811g0C5ymB8rpSchC6fv2JsJnxeQs41E3fQCpQGEh8ul/IWIKyj0FE8ZZOhKnhCw2lCDe577RVr4T3mMefXJj72X9ARlQNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrp4SZnDf36qGoRZFA/+vNLh0hK3zGxdFPzbFAS1Brg=;
 b=paNpRpojjn21L9dMLv2Kte1/K6e6VJZhxYVY300suBrAsAu4ePnRpZr7RR1bWRewtRL+wGw6uGT6rIH5/zA1IUj57WQj3jYgkDykVBwlcpcZwDPEfNKrfYBEHcaOKdPJyo/28NP+lDO/s2IyP9UIGcXBzncNYiC8uH/qnQOPGFvNJ3aH5QhyZvxXIkH63SGgkhgBGEpecRcqxHYVudKnrrCXy6EwMD/1w9KnOHSgmbjCwC1tr8ZY8DHeZpZumvP2euydXH/50qFjKAwvZYeUINlx77jkMX7GFDmE/MbaXUMks8zycyQujMEn9ZE3dvZOu+uInBvYavBTu62NxbzVVw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 06:40:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 06:40:27 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V2 1/1] null_blk: add moddule parameter check
Thread-Topic: [PATCH V2 1/1] null_blk: add moddule parameter check
Thread-Index: AQHZa2tRqulVQG1jpkWQusBTdWweGq8k0hoAgADENICAABPaAA==
Date:   Tue, 11 Apr 2023 06:40:26 +0000
Message-ID: <03029381-bd62-d26b-3520-862185c4570a@nvidia.com>
References: <20230410051352.36856-1-kch@nvidia.com>
 <20230410051352.36856-2-kch@nvidia.com>
 <CGME20230410174800epcas5p3177f199ec973ba5e8e44a0a688a072e8@epcas5p3.samsung.com>
 <20230410174708.pv6xm4pwaszyabte@green5>
 <92bce410-8a0f-5580-94d9-8952ebbab2d7@kernel.org>
In-Reply-To: <92bce410-8a0f-5580-94d9-8952ebbab2d7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4298:EE_
x-ms-office365-filtering-correlation-id: 4bb538cf-dea5-4a61-ba17-08db3a57a2c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yhU6Dh+2jz5lfqaO0GHYKIBt0ywvEAD1wugoEWV1byt/haSMRSdcJMkgwzhZGu3jPDvWIfMPUD+NHf9jNJCGdSB5QKcvBb/16owWHB9r2bFQ5DtIbvfdUvA4qfY747FJyE2r2CdN646I4pjCPRxvhaiLnSyzKj0+aOsSejGsgIelDIlV5N/wzbwq7R1C2FJGZeq8o19i0UrVY7MNVKkEljFdLUdKKpLvmDhDKtXEHENZECeIxSGLLCwXE9cZqB8ZfJZxz9A3WRSSlGAF4afvDAVnvFKJJJ0J678CP1yPqQiJpXFPUllgXO96wkmHBuaBvT/p9VQ//U2UX9vrmypsV+/Nor34OGKzJzH0TmgHSn2ZQFiMIzdYL4JSxeI63TISF6RceByvv1iNfvqyzywEJ/bW8lNNk3VhvXEPU/Zqxdq5NAeIz2KvSzCJHNQdjJWDU2hSFjBl0FwFlD2BdJhIGeoc2F5l1JKQFdGDJd0hMgdKcmCkBpbYOCzwUHUmae/if1d17cTylXvJmwO2tIByjOC5Om3KiOXvmg5fUl/IIs5pJ8mM8Ev3tBDlVtFj+RlL1SRj/MdDQN3BATUcvdT6ynZAHUGeowNWVzOVOx4M1IRwnkuFy9GZ7Bcpcl3Xj6Q4WAmFASNpLAPXyRFHnQ4ywnROCYgG0A+Q7Y+HaAyFarf1Xj/HMlIHAGgqSg55HkFo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(71200400001)(478600001)(6512007)(316002)(110136005)(53546011)(6506007)(186003)(54906003)(6486002)(91956017)(2906002)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(66476007)(64756008)(8936002)(66556008)(38100700002)(38070700005)(122000001)(31696002)(86362001)(83380400001)(36756003)(2616005)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFJTTVSR2ljak5HZzBUSnhwZDBlMGFoTm9QU3NjUUg4Sk5iQkVSSkgxT0NB?=
 =?utf-8?B?Y3RTOWRYSkdsV2NNQVJPdEFKUFRiV2RWdGNiRks2bUp3ZnY5TUVrZklxN2tr?=
 =?utf-8?B?bjhyVDFFZHZmZ3g5dlJZUkp1R2dqUHFRdkxiS3IwM2dMV1IxcjB3and1WDky?=
 =?utf-8?B?cHoxNm5jQllmQkhjd3dGa2MwdmdPMXlQNDdMd3h5dUdBQ3dJSFBkTUx3RmY0?=
 =?utf-8?B?bHlxbm5MaXVIRFJlNXBKTCtHSGxxWno5UmFZTmNYdVAvY21sRzZVN2Z3OU8y?=
 =?utf-8?B?VS9KVHRpTXo0R3lBM0dleFRuSjRpYVZJSTJPSHJFY0lIaHlaK0tzaFlWNTE1?=
 =?utf-8?B?YkpySklXTXJubHE1VUVXNS90M3VkUjZDcXVWQ3dCeWZkdW5KS1dBUkUwTnZy?=
 =?utf-8?B?cnZtTXE2QkNzZEZGV3FJTm5qdHRFSzlwcTYvaU44dHVZM2Z2SzV6Z1hsNmNN?=
 =?utf-8?B?RjAwdUYrc0l1dFQxVzh1MVBENmJ1S0VqazZlOTFheHVGeWRaTDlzRHdpUHll?=
 =?utf-8?B?Y2MwNlFkZ1BDWTlsTEhjWSt1bUo4UGtNemVzWUN4ajBFNHl5ekt3Uk9QRkhL?=
 =?utf-8?B?VkJqR3lHalp6ZVRmSm1vbXNhYW1SOVlJSmpja1hpdUtkSVFkN2ZQck8ybmVx?=
 =?utf-8?B?dTBJdmhSdndHekpoc2dURStHNzhVd3kzdzVkK0tDNE5pVzF3b0c2UnFkVWtD?=
 =?utf-8?B?ZXpkcVRhMjVlNWIvSTJLcVY5WGxFc0lVS3FjNk5HR2hOM0NqQ1kzME9FbXVj?=
 =?utf-8?B?bzFIMHZsVVhJaG5CeUNHMDNVVk1iaTl5RkQrWTRPek9DTDFnTjJOWnJVU05D?=
 =?utf-8?B?d1hQWHErcHUxa2hHMm5YM0tyY2M3eitWLzdkTFlPVlFGSXhwbWxDRUxqU292?=
 =?utf-8?B?R2ROdWdOTWNwL0tlOEszN0xoZ1UxRlBNUWVrUlBvSmFSU3FQaHlYSlUvODUw?=
 =?utf-8?B?WkJRSnpkU2NoY3hwTkd6RlMrSS90T3lsOFBCbW1MUVU4V2dXaGQxVi9PY0dE?=
 =?utf-8?B?c1NyNWxoakZLalhJL2QrNVhQRzJzczVHTDkraGJpSWE3ZkJzTVJuVGZvaGZx?=
 =?utf-8?B?eW5IV2dEQk52QWZiL1lQYzNvN0FqQnd1M2VKUXpRSjJwY3p3ckNlbEQwQ3lT?=
 =?utf-8?B?a2xaZExEU2NWcGtickg5dnUzOVBMQWVRaUwydUNZMXI1WC8yL0JWSzFFMElo?=
 =?utf-8?B?dVNHOTdmMGdpU3BaWm92clNRV2crazJWZ041WTZseXZOWXJNVENQRHVBb1Bq?=
 =?utf-8?B?N2VZSnNTV2hjVlljbzE4dUtEeTEzNFNHWloyNWJSL0Rid0lPMGZTQTJkS3R3?=
 =?utf-8?B?RVlzZXVvTXBSdjFiRW11QXVEbE1yVWd5djZ4bUY3Z3JLRXl5UnZkSE11WnJ2?=
 =?utf-8?B?VlhhcEVVUEhtcGRFb0hKWk5JUi93bDhJTklZT09XU3ErcUphWVNEU1dLM1RQ?=
 =?utf-8?B?ZDI3eGdwSjBVNFdzNWhJZTJDR3FJd1EzVjVGV1crb282WFBwVWprS2wwc2lj?=
 =?utf-8?B?VlFMcUVVWGY3THU0a3dISUswdjlzV0xWV0NMUjNOVnpYQ3IwTWVralZML3g3?=
 =?utf-8?B?SU9LdEorNjlXMnBpNlY2UnViVHFwdEJSTmxKUzlONlUrL2VTaWozMlpjRlBV?=
 =?utf-8?B?M0ZSb2hmdFBoSWUydzYreDFvSk5hRXFhR2Fnd0NqUW53YUxGaUxmME14N0pX?=
 =?utf-8?B?c1BDWC9kblZqK2RHc3kza0tDMVM0R2ZielVQWUlSZW1YeVFLekVZQnZCNFNr?=
 =?utf-8?B?SmJCWTQzTURsNEhodFRQV1EzdFlCYlNyZExneEhWM3k0SmtpcHlYUDJ2SE9W?=
 =?utf-8?B?K3F4bWRKN1dQbmtrTTJqUlc2cFBTUm1CMzhwM2w4dEF6OGd4a0JrUjdOYkJi?=
 =?utf-8?B?WE9oM3hja3UyRkViQmRTZ0FLdmxYZXE1WUxISVVwTC9qOWh0eFVpczkzWFBU?=
 =?utf-8?B?SDY1dUZBbVJIVGdBSGMvUjQyTWpLQjVEaFNVOExWUUo5WEVDVWpnV3ZSVFVW?=
 =?utf-8?B?VmhBTy9pQzZKVVJUTmZBdWVhMmh4SEJTdmhEMWxialh0ZDhGSnFCNU4xWXo2?=
 =?utf-8?B?cnRmdnhRMGhoMHo3Y0swK2ZIUFRNdDAxc3lMd0cvbUxMVHZqRW10bTQ4b2Rq?=
 =?utf-8?B?NGRQcUVFSmhFaXhDVlNlK2FjV25GeU9qUTltV3YzUWNGRzNKOFZOZitEeDNn?=
 =?utf-8?Q?gyEjez0qsG1A9S3YhpyzTycwnlnWW6WZdUFi/+o1woo/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32D10883AA8D44EBCE0864397BAE561@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb538cf-dea5-4a61-ba17-08db3a57a2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 06:40:27.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlzU9Uo845g5H3agwXAlyWg4Bc/Ewi/X2jLRy5EtZn9CM6SmhnGqKoTk493wf1wf1nI6USqf/bFKWVc+4YbLjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xMC8yMyAyMjoyOSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDQvMTEvMjMgMDI6
NDcsIE5pdGVzaCBTaGV0dHkgd3JvdGU6DQo+Pj4gc3RhdGljIGludCBnX2diID0gMjUwOw0KPj4+
IC1tb2R1bGVfcGFyYW1fbmFtZWQoZ2IsIGdfZ2IsIGludCwgMDQ0NCk7DQo+Pj4gK05VTExfUEFS
QU0oZ2IsIDEsIElOVF9NQVgpOw0KPj4gVGhpcyB2YWx1ZSBnZXRzIGNvbnZlcnRlZCB0byBtYiwg
Zm9yIGRldi0+c2l6ZSBjYWxjdWxhdGlvbiBpbg0KPj4gbnVsbF9hbGxvY19kZXYuIEkgdGhpbmsg
ZWl0aGVyIHRoZXJlIHNob3VsZCBiZSBhIHR5cGUgY29udmVyc2lvbiBvcg0KPj4gdGhpcyBtb2R1
bGUgcGFyYW1ldGVyIG1heCB2YWx1ZSBjYW4gYmUgcmVkdWNlZCB0byBzbWFsbGVyIHZhbHVlLg0K
PiBZZWFoLCBnb29kIGNhdGNoLiBpdCBpcyBtdWx0aXBsaWVkIGJ5IDEwMjQsIGFuZCBhc3NpZ25l
ZCB0byBkZXYtPnNpemUgd2hpY2ggaXMNCj4gYW4gdW5zaWduZWQgbG9uZy4gU28gdGhhdCBjb3Vs
ZCBvdmVyZmxvdyBvbiAzMi1iaXRzIGFyY2guIFNvIHRoaXMgbmVlZHMgc29tZSBmaXhpbmcuDQo+
DQo+IEkgd291bGQgc3RpbGwgYWxsb3cgYSB2ZXJ5IGxhcmdlIHZhbHVlIGFzIHBvc3NpYmxlIHRo
b3VnaCwgdG8gYWxsb3cgdGVzdGluZyBmb3INCj4gb3ZlcmZsb3dzLg0KDQp3aWxsIGNoYW5nZSB0
aGUgdHlwZSBpbiBuZXh0IHZlcnNpb24sIGJ1dCBzdGlsbCBrZWVwIHRoZSBsYXJnZSB2YWx1ZQ0K
cG9zc2libGUgZm9yIHRoYXQgdHlwZS4NCg0KPj4+ICtkZXZpY2VfcGFyYW1fY2IoZ2IsICZudWxs
X2diX3BhcmFtX29wcywgJmdfZ2IsIDA0NDQpOw0KPj4+IE1PRFVMRV9QQVJNX0RFU0MoZ2IsICJT
aXplIGluIEdCIik7DQo+IENoYWl0YW55YSwNCj4NCj4gQW5vdGhlciB0aGluZzogZGlkIHlvdSBj
aGVjayBpZiBzZXR0aW5nIGFsbCB0aGVzZSBhcmd1bWVudHMgdGhyb3VnaCBjb25maWdmcw0KPiBh
bHNvIGdldHMgdGhlIHNhbWUgbWluL21heCB2YWx1ZSB0cmVhdG1lbnQgPyBJZGVhbGx5LCB3ZSB3
YW50IGJvdGggY29uZmlndXJhdGlvbg0KPiBpbnRlcmZhY2VzIChtb2R1bGUgYXJncyBhbmQgY29u
ZmlnZnMpIHRvIGJlIGVxdWl2YWxlbnQuDQoNCkknbSB0cnlpbmcgdG8gYXZvaWQgdGhhdCBpbiB0
aGUgc2FtZSBwYXRjaCwNCmFyZSB5b3Ugb2theSB0byBhZGQgdGhhdCBpbiB0aGUgc2FtZSBwYXRj
aCBvciBhIHNlcGFyYXRlIG9uZSA/DQoNCj4gKE5vdGU6IHBsZWFzZSB1c2UgZGxlbW9hbEBrZXJu
ZWwub3JnLiB3ZGMuY29tIGFkZHJlc3NlcyBkbyBub3Qgd29yayByaWdodCBub3cpDQoNCm5vdGlj
ZWQgdGhhdCBmcm9tIGJvdW5jZWQgbWFpbHMgZnJvbSBoZ3N0IHNlcnZlciwgd2lsbCBmaXggaXQg
bmV4dCANCmdpdC1zZW5kLi4uDQoNCi1jaw0KDQoNCg==
