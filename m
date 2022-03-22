Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EBCC433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 03:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiCVDO5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 23:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiCVDO4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 23:14:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C548554AF
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 20:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD4onltnP09SpUWPs6kU725+9etEOaR7yWjEhIdRETCBakZsob3wQH5bFgcPVFEnDw2zve9VQ0Fy5P8UY3xFiH9ZYOAMNngzlV3P1spWWMPtWsr9vyjJB1y8C6igcEBjTZ9Qkqe98F8nNjDVo9FqTmb5vxZs9yOZ7t//86itZXOWUNzG3FZ2z1cnwv0kw1Y0XIK2QgdYbYrGlQyd6vGqCunHf8eVFc3YLU8MWFlFmGZGYOeXij9qoePv34tEirxA3YcpJexdk2wMD7cVFAkU0x9ME2TE3IiYg4LqBHikrahddsfcWCag9XrAzjK5dd1qljZ9hz+OMKN4vmMttB3/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOZzZYJfG6GKB+hJELs2tQTPglM3n5IMFuypRm1vfbE=;
 b=XYtNClLACTjsr8jqRnMboAW3jqSf5uU/H/hfJtCX8Ku6EnRq8pUDuKRtsNwfAQpLOqJujnN5e0akEf2+znVh2q/F9gvqu9cmhWHjY7cgZXM+076aLP3NRdv5PAPu598Wv6FvIM8xj9hIitWgDCmFDF+cUVP/cNSTR0zcCMAt1gv0lycoKYCcIWiWtY9nNR1DX8p7B00pZKp3qaxmJuJI1bICOo0j8h9f3qCJFPhhCswcWyYA8K6ghgdW2r7/Kywm+V4xfq9qEDq8HZtam7oJC8zIoWgESL4ssdVeeiycm3q6YjBiCXWB2l+AL4dI3CmVYPkIXTQHbjmcwdcrz40VGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOZzZYJfG6GKB+hJELs2tQTPglM3n5IMFuypRm1vfbE=;
 b=BTDMCea8Ul0KKur5r0WYsgnMXUkFbUJiJbrzrqyVyIm1rA8FUftdTq2E+TkRN2mgfB2O6IxMTne167QDHjjJFdppgyYMtIm3zN5oYotTme2ra4WzX9gT/trF9HYVIx304WJjecinWvDFjM5v1JyChTSUPFIahq0VKPoDUu0ZWTfWj3i9x7+lg+NJwdzCrrk7GjrMe213vJj6HkZya2gcw9lpKbXc7wBRoE5RmlJFOCSb2ll1z+keRNdxGeTFliUzGSAaCHoE4ttnP30oNEilBZDQUIgTiYqMZUFbOFSg7E5iDDcAJTasMQizR5JjVlXVikcHIQJAKhVoo2zo0pp8KA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Tue, 22 Mar
 2022 03:13:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 03:13:26 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block driver updates for 5.18-rc1
Thread-Topic: [GIT PULL] Block driver updates for 5.18-rc1
Thread-Index: AQHYOxN3Lp3Y0e7tt0yqfV+mnxP/oKzKjT0AgAAyMwA=
Date:   Tue, 22 Mar 2022 03:13:26 +0000
Message-ID: <9cea629b-aa31-f2ee-0858-4253de7fb3f7@nvidia.com>
References: <83ce22b4-bae1-9c97-1ad5-10835d6c5424@kernel.dk>
 <CAHk-=wiXy_WR5=z+tWFY8NiuXtwfnOC5cOZeFN41MjBGcG4tsg@mail.gmail.com>
In-Reply-To: <CAHk-=wiXy_WR5=z+tWFY8NiuXtwfnOC5cOZeFN41MjBGcG4tsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 131c6103-dfd5-489c-a519-08da0bb1eec4
x-ms-traffictypediagnostic: BL0PR12MB5523:EE_
x-microsoft-antispam-prvs: <BL0PR12MB55237F93ACD53E0D277B6610A3179@BL0PR12MB5523.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9j2M24CECHKpeysbvqxsDYzMqH8sUtNVNJ4JbyI7vYpNo28qfPpGWXSpqk7ZLaN/z9xtAAg1ICftxTjXjpjiDa/IjiwvrIZ392OHajiEn1swJb+kKaKljoeB34zLKjF6KH/z6Tg26BphV//wZ4cLPCumChTHuZELdaLgRMH+rc1rPefG7NhTuusXrR+0dp/RPCONfl3IjXxDjp2y0HJzwzOp1c1xxN1luGwzrc+kefCZDgep2eJsOGCzizIkV1WWi7fgBX3pVwL/pz9X7XrTdw81BKGvKUad6YAq+7eP3JZQY1/Lb3ugm7hNMqtI3VunIYxsyji5LzHhcqg4HrWZX3uCC8o8IXx3btgd5Cvy2q18dVstdxRCU7fa9Qu1ZY0DRON569Cr3KW+vTJHs4dDuVvDVOkvPA2R4+5Dr9rfaRWClzzldkqOUiLoghY66VYgSBhv6tYg06x11n4RvooWlgxOf8C9AG3foifYQV4cO3p9D5YbBTOgXs/4NK8rtFZTUFO6Ueag0I+a5MHV/IMzC2N1v6JUdBSCHeAaTcyeAjaHWyRkpPson+7XzPzVdf9SPbOqwcd4Eatguq9D7gRMs2dump7QsE06ceKzcjiIgiR3jAjlHUImR9oW6VQWvNBrhvw1wUvA6nmcEd5z+l7ibZYIsM88sDPt5QuosMlHzmrchcEuUSANf12zGpkyRDDarxdFgPCsMS2ev9yuD2dTiyjUEN84KPOFRb8RY8C1Ln/RXhZwFCqIRH744qfnczxgntArNrbZrjqKWI0wfL3R1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(4744005)(31696002)(91956017)(8936002)(76116006)(6486002)(53546011)(5660300002)(66446008)(66476007)(66556008)(66946007)(86362001)(4326008)(8676002)(64756008)(38100700002)(15650500001)(2616005)(6512007)(508600001)(38070700005)(122000001)(6916009)(2906002)(6506007)(36756003)(31686004)(83380400001)(186003)(26005)(316002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2FNMndtSHFRYkIvUVlvZWhyallSM2hnSTNncURWRTVKM1lmSysralhJeGFZ?=
 =?utf-8?B?MFJnaWJSUEpqNUtiNVdMbVh3SG4ra0wvTnNjZGlpYWpvd0NVNCs2a2k2TzQv?=
 =?utf-8?B?UTNvd29LK1JmbXpiVnRxVmZRQ3BUdXNjcEpRbzR3RnBPY1c5SWNnNmNmeWY1?=
 =?utf-8?B?NEJZN1UycTZheVZncFM3MGE2czFmdFlkdzlYQmhFMHBkMmV3TExQMnVoWEdP?=
 =?utf-8?B?OEhuY2xQVFpwOTBkbzNsTyt2dGtob0FrQmVPYndwK1Y2MnhVQWc3Q1ZOUXh2?=
 =?utf-8?B?ckhGUXB4c2htQWhoazIvYk14TGIwSnp3YXBubEd1S09vanRJbEw5SngrNXVC?=
 =?utf-8?B?Z3o2c09BVEpuMUswVThmUGZ4bGZlRGd2UllNMzdUMWNITDR2T2c3RVBaamdz?=
 =?utf-8?B?bmY4TUVhL1lSbzZWK01wdU4rWlRiYTE3bDIyWDRvWDUrbTJKNUs1eE1JOEFR?=
 =?utf-8?B?OXVDZDRMS3lXZnNPLy9RRlRGYjg0NGthU0ZLTkk3YmR1NGdpTmhnV01pTEJn?=
 =?utf-8?B?YjVMWjVjaEJBVlBrNU9HTGVaVUsvQ1lhNEFMN29tZDRWeUgwVTlOQkNSQzNK?=
 =?utf-8?B?YmF3aStncFFJVm4vSVU0RGZPL0lmN091QnlVRDhFSk4wTHAzL25CbFlReWsz?=
 =?utf-8?B?NXk2eS9ML1JLY2xneEQyR2VGVXhDbWRPOGFGajg4U2tPVUxtZldHNmNyKzAz?=
 =?utf-8?B?MDRORnB6YTZVMEFwRnIwdVJEbnNWUXNqNVl2TUtjRFd1S2R3eVFOUWJ0c2FB?=
 =?utf-8?B?c2c2azVZdW1yRGc2REI1Y0gzZkF5T1Z2eTRrQWxxekxuVytBczBmaWNqQlZC?=
 =?utf-8?B?MTdHemQ5UkhDd0tTSEFhcFpTRllnMWFOTHIwUUE1YjdKc0tGWDJHcm1JV1B6?=
 =?utf-8?B?NERvaEg2ZlcwdEFEU29sWFBneTJlZTRMQ3N1c1B1by9WcWhXSDRKdkw1MUNX?=
 =?utf-8?B?QjYzRFNtVTJ1Q3lMM2tYMVBuUTRxdTQyeURxcDVkb05PWFBZMmh1ekEyUHJT?=
 =?utf-8?B?V2E1Q0VPTVo5MkxmQlY2Q3NoUVdaZ3FqUy81ZzZWYlptMVZGN0ZHN1ZlRFJs?=
 =?utf-8?B?UHRzVlo2YktrWTFMWEM5VENjNDNDRGhiVUl6cnVXWkw5Niswa09FSGpVWFVK?=
 =?utf-8?B?RWN5TzVmMy9QMUIwRHVtczhVVTZuNGhCd2ZoRTF0UkpXbkZnODNnVnorUDhS?=
 =?utf-8?B?aHdHTTNETHhGZWhGTFhpSitxMVVmZy8yWWV3bFV2cDRTb0kyM1AvMjNRaExG?=
 =?utf-8?B?K0oxUHZBcitPdmROSFlKL0NwdElKaHJqMktST0JHRHZaR3phbEZVTTRXSG5M?=
 =?utf-8?B?UW5JYllGSkUybldUc1JoNFBkQzQ3d1BabmhCWEcvR05rQU13Mm5PWHVUN0d0?=
 =?utf-8?B?SkZsazhBdWhySk9vMHRkenZHWVl5UXlUazQremt4eUFkNkNMQ3lpa3N5N1Yz?=
 =?utf-8?B?Nk5hRS9zZmUyOWVsVlFxbTMrSlliZWhJK3JhbStCdDRuU0JYT242OUdWWjVh?=
 =?utf-8?B?Y0N1SFNjVE9QODhwc3ljektSSHpoSENvc0JVRFRwWmNDcHlzSXBTd1A4MWlo?=
 =?utf-8?B?bzhOb3JXUDlYN3lrWU9BdnhwVU93SXZYYmQwOS95SXJ1S0pnb0pTaDhCc0Vk?=
 =?utf-8?B?bWdzNGZ0RCtVM3V4angxMS9TZE9yQnN3dk4yMkxUTi9NV1BydU9CMm4rU0pi?=
 =?utf-8?B?OHNPSXZWVVVORld4OXhDNVdIT1YrVkxMR2JnaWJvWEhjVVEzeXRhZnNQMzE0?=
 =?utf-8?B?eU1oMkFuaGpvK1BVTzVGL0FiR2hseFRuS1V3dUI2L3hPempoUkRrYm9lKzJM?=
 =?utf-8?B?RWV4M3BCWEV5c3M2M1NMcDhYYVJGMGc1dTk5cG1nMkV1QzhvdW5qNEdyR3Na?=
 =?utf-8?B?YWMyN0FXdm9MTDJCWFNDL29KZnozdm5zK3dwZEc5bnBkTlN2R2FGektnQUJR?=
 =?utf-8?Q?yQSWq7LWbQ8TEC3X2Svu5XvPCfYa0rP1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5077E6BD315B544C928398D11C2F52E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131c6103-dfd5-489c-a519-08da0bb1eec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 03:13:26.8390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0JCH7IBJ59y7zenKKeqIcdDRrH2NMqVbSrkFqs1BkayBB9r2pJ5wVf6MVZ1g74bndZ6Vtd/9aeKi/HLr6en9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgTGludXMsDQoNCk9uIDMvMjEvMjIgMTc6MTMsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPiBP
biBGcmksIE1hciAxOCwgMjAyMiBhdCAyOjU5IFBNIEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4gd3JvdGU6DQo+Pg0KPj4gVGhpcyB3aWxsIHRocm93IGEgbWVyZ2UgY29uZmxpY3QgaW4gZHJp
dmVycy9udm1lL3RhcmdldC9jb25maWdmcy5jLA0KPj4gcmVzb2x1dGlvbiBpcyBqdXN0IHRvIGRl
bGV0ZSB0aGUgdHdvIGRpc2NvdmVyeSBoZWxwZXJzIGFuZCB0aGUgY29uZmlnZnMNCj4+IGF0dHJp
YnV0ZSwgYmFzaWNhbGx5IGV2ZXJ5dGhpbmcgaW4gdGhlIGNvbmZsaWN0IHNlY3Rpb24uIFRoaXMg
aXMgZHVlIHRvDQo+PiBjb25mbGljdGluZyB3aXRoIGEgbGFzdCBtaW51dGUgcmV2ZXJ0IGluIDUu
MTcuDQo+IA0KPiBPbmx5IGJlY2F1c2UgSSBsb29rZWQgYXQgdGhpcyBjb25mbGljdCBkaWQgSSBu
b3RpY2UgdGhhdCBzb21lIG9mIHRoZQ0KPiBjaGFuZ2VzIGFyZSBraW5kIG9mIHBvaW50bGVzcy4u
DQo+IA0KPiBJIG1lYW4sIHRoaXMgaXMgd2VsbC1tZWFuaW5nLCBidXQgSSdtIHJlYWxseSBub3Qg
Y29udmluY2VkIGl0J3MNCj4gYWN0dWFsbHkgKnVzZWZ1bCo6DQo+IA0KPiAgICAtICAgcmV0dXJu
IHNwcmludGYocGFnZSwgIlxuIik7DQo+ICAgICsgICByZXR1cm4gc25wcmludGYocGFnZSwgUEFH
RV9TSVpFLCAiXG4iKTsNCj4gDQo+IEl0J3Mgbm90IGxpa2UgYSB0d28tYnl0ZSBjb3B5IGNhbiBl
dmVyIG92ZXJmbG93IFBBR0VfU0laRS4NCj4gDQo+IFNvbWV0aW1lcyAnc3ByaW50ZigpIC0+IHNu
cHJpbnRmKCknIGNvbnZlcnNpb25zIGRvbid0IHJlYWxseSBidXkgeW91IGFueXRoaW5nLg0KPiAN
Cj4gICAgICAgICAgICAgICAgICBMaW51cw0KPiANCg0KSSBkaWQgdGhhdCB0byBrZWVwIHRoZSBj
b2RlIHVuaWZvcm0gaW4gdGhlDQpkcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMuDQoNCklu
IGZ1dHVyZSB3aWxsIGF2b2lkIHN1Ym1pdHRpbmcgc3VjaCBwYXRjaGVzLg0KDQotY2sNCg0KDQo=
