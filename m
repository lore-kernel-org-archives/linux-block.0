Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DC2C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKBBTC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBBTA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:19:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B919DAB
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 18:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGpSWCGByOIzXSjIoLsPHVfYVQAKt+VcLLpKHSkaX2Y1/946vKnBfe2xRBaI5o3rVO6CKz3+7EW6RPIgg+y8trwtl0bvNFQNI88TfcCSbiEPxLp/hERBrnWcva/9qYabUE19pzZM8wvWXUS+RBcW5Aw56B3lII/a733wq5gJC5G9VZnFSXfo+O9JaU371Yvr0Xjc726kLCtQwZL3X8kVW2HwXOCwnFgNuAbjbgAOaE9IRmHM3MKLcsQGx3z2Qyu2Mu/ixcM+hiVM79+ers+6IAzLP44Ymgz1yobN83mrABpVcWRgVs7lx0hvpQo8FlJr9/2obdAoVA/73CIZFTUg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt58WZtXDum0d/0+9uW3OdkpHF60K9hPmrlI6QvRmOs=;
 b=Zh3mvC7JJtDCUAbNfO/jqYtLwaSgOAQCOJ9psAKGHfCt2slIi0IlgeQI1DFVlkKxE561WOtL4mAXVQgoidHcwENKNgG70W6tInM+uTrJ/SBVNTKjEvEW+HEDKYGuxhPMUNZm9iiRSPbMrslYppHFNjLWvmrrM8BPl7GW5pV9aCwg/8lyAd4Oe9p3q8VdAl6K9VkuydeLUQLMtk841cDGMZM2EJRQkKAVElkz3KJWk/rePhfHDH0ZlCcPQRWdYoIgUeR0OBy2nEbWecDi4nxXMiDYNjgGemBpCV/oW1g8dQwCHdWpgoeCMJ5aq8iVsXQRQdU+MRyh5H04YO0SV8nrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt58WZtXDum0d/0+9uW3OdkpHF60K9hPmrlI6QvRmOs=;
 b=GNMu/XfT4QsVxVMbC30vppOOvNQpozb0TdH6HDaVlqcWV3RSdaS/dwgncTK/Weiz+zpxOWvWcCZ8l+xe7lWRx0g1M3XEbkn+E04mH91f1vEu/8B2pcSWCnWEbx9EU5cljxdYhN5bpOQcECIDc9HkBP88rRnRZPcjEzreQGXIVEootWnYUbEyZI05Fw2pG8QtiRJU3aw44SZBZh0wsIQ2qA3CRF//PhSGyQ5jfHfpkUv/q7Co0oCuJp41cX9Rcf/MkZhMlJNxYvI57kf09/rEWNrNzmxrzpbUi4CV+jhdIad1mO1eSp5KgkY4bDJinShEc1hh+JooPu5PE+qzn1/9CA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:18:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:18:56 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 01/14] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Thread-Topic: [PATCH 01/14] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Thread-Index: AQHY7gLwLPshy8SnTE29CA2MmAd5gK4q1iEA
Date:   Wed, 2 Nov 2022 01:18:56 +0000
Message-ID: <94b8ae53-0e6c-2405-a88c-2c293283b8cc@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-2-hch@lst.de>
In-Reply-To: <20221101150050.3510-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5264:EE_
x-ms-office365-filtering-correlation-id: e94957e6-a03d-4c39-18b8-08dabc7036c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rpErGZR+tzn517It/7uI40cei6dzIOCcZDsK3xtgvqEn2+5GyKzbRM8x12wtNxmjyZEgbb/1j3gm/5IRzXljITqGuAVA6iW/EUzMJxTwJGzDSlWAdinlp756tfJ2WIVvJibRipq1OM/PukLc145I/hBnyd2MhHPjggU5E8x+Niw/7apMFFIttN47GXDwoT/5qhCRBIEorGBV5dss+SKrAz0PI4vML3gRjk59hFHpxhhWUdjdD6P0ZcQTOgxb6jw3ZtfCutm8hZEa9crtFomI34/ijB+ITw6UZayYGd1zsGSr3z2cOxIyuAHcsJFAzW271iBEBtyQo5p/WO4wENxQznwc0mzoBErGp1UBe+sSXu71qmtR+aMm+EP4KRMYqHy4Rchx8CcZYgNHoGYfnHDlkmYtFu6lgM6cn1gM9PRimKocHcWDX0JN3Lfs1AYWd+UeH5LRd5RHzzixaoY1h63JffsTMnjkUsdSGzZ82or8fRKk9a0wr9tuvC+kjoRrG1jZaNVQRIm9MlJU2wZODjsiPvyk3tQ8iEWdLiYK2O8dDYWVPOIX6smVn8jM+0gyOCF/64y/eaURFOw09QDX/u1l0YgiLhPCIurEjG7ipJOKEyfWHgI4ahf6P5akW5h7WwnR2fuI2VW8PRsE+mAUu2T3HBV9ETbQswf0ODIgGSPdWvPzrp0l25ZyOa/LlCsZr5GGzj2gH6ZObZ3yeDtQBa20gkSf8NZVYJC0wRzkuBz90EzKz++B7VO60HrjAQfFkPhhojqYGSrQGOc+3jj013nQdwb3ZgTQ/NkVYvyoFGbY/gOataX8VIitF5bCVE2aIfW0pOUfMP39qUBHhiHEWRu+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(76116006)(66946007)(91956017)(316002)(36756003)(54906003)(66446008)(66556008)(6916009)(2906002)(186003)(122000001)(83380400001)(6512007)(41300700001)(8936002)(53546011)(31696002)(64756008)(6506007)(4326008)(38100700002)(86362001)(8676002)(2616005)(5660300002)(66476007)(38070700005)(4744005)(6486002)(31686004)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2E2UGVucmdvbzI0Tlk4OGdUcTRYN3Q1eFhCYmI5VC9TRks5bWlmVnkwQ3l2?=
 =?utf-8?B?eE4yUElFa2RQdXVVWEtkd3Z2NlJuV2xDaVl2dlFRRk1UZERYcU91cEFyUDY1?=
 =?utf-8?B?WHVMM3FudFN1aW91YmhXaTFVYmo3bW41QUtkSG50eGo3OEE5V0xjZlEwY2pM?=
 =?utf-8?B?NGFvUTRjWTY2U0JlZ0d1OEd5cGZUSGFIWll1S1lJUUJFMTdDRlZaVHIzbWxq?=
 =?utf-8?B?TzVpaC9UT0F5VSt4N1l4RUJVRGwvYjR2NmZXMnE0VzA2R3hwT1k4RWNmaWhH?=
 =?utf-8?B?WTRGaXB4MGNranVwQWM1WEQ5UkdlQ1JhNWVOMTVJV3M0Z05UeFVRQ1FTOENq?=
 =?utf-8?B?QTlTVk1HM2U1UXZieHpOWldMbkNTbjRKQ3RIZmF1Z0VWV29wSVQrcEdyYm8v?=
 =?utf-8?B?UXFJU1dVU240Y0pJY2NBcGdIc0JaZjlQOTJwbXNMVUZFUmJKamc4TXdITHBU?=
 =?utf-8?B?eUxnaDFMRS9lR3RSaFBneDJlYnlLTk0xNWJsOGNpUExySkpVVCtDdXFIMzhL?=
 =?utf-8?B?cjhGd0FrUTZkWnE2b0d6ek1nS3pwYjhxM1BRRDhTb0dSRHVJR1dBT2s1QTQ1?=
 =?utf-8?B?M1plMmF4YmFaekRjSVFHakU5anJ0TWJIRzRwWGV0eE5wWUdaUmFTVlZrcHdn?=
 =?utf-8?B?NUNwTGJYTThranhyUUFhRlhFZUJHSjgybm5iK1RXVVRhVUFSNko4eEd2VFdE?=
 =?utf-8?B?ek9QWDF4U0xxUFk5dk5OWjhGTFFOaWlpakZ6MTc4WWdwbGxYZitpdERydnov?=
 =?utf-8?B?bnAwN1hjK2VTTmtIam1FY0tLYlJaa3ZHUE93NFNkREFOZnd2L1hoT2FFK1lL?=
 =?utf-8?B?aVQ2VkR5VHVRNXljQk1pbWYyengwck5qcUYxZWF6NXhzQW9jdzVIMHdzRjVM?=
 =?utf-8?B?RHlVRXRlNzY3VWl0VE5lVW55c01PYVZMc1l5MmFxQ3Fqb0tubDM0WTB2TG83?=
 =?utf-8?B?cXFSaWZ4VEpYM1VRWDBCNWUyN3NWMjZsTG9ReEZtSnNYRUZ6K2RraUpYQ2ds?=
 =?utf-8?B?WENLNXdJVEJwckpZTXk5ZkVDN01jaytWOEtwdFVVWEc3M1VuNEZ4UWhHS2Ft?=
 =?utf-8?B?ZTFNUVVMT2ZDWjRiVXhEa01WQTZhOFYwVDJJVVZUQ3hEcVdydFZMUGdpOXBF?=
 =?utf-8?B?ZlhLZGFadk5MV1pUcnFnVnZCK3JhRjE0aGV2dWdvcm5FWTVqS0h6VlZvSGVJ?=
 =?utf-8?B?QlN1aDdjbVo2eUg1aG5naDdtRXM4WEtXSDM2RjRWWHIzUkk4cDlSZit4ZTky?=
 =?utf-8?B?T2cwY1BEMHNCdi9tMStKLzBiYmk4R1diSlYrNUNPY3ZramlvRUllcHNpT1RO?=
 =?utf-8?B?cktUZ0V1ZTZoUXJuWkJ3dnBxQWpBcGpGZ1J5YkY2Wk8xTzVVMExQbmxMSXJk?=
 =?utf-8?B?UVlZNmIwZFhad3p5T3RmZ0ZCbVFEUExFSk5KQmRzWnNmTFJnc2V2cUN4c0ZH?=
 =?utf-8?B?VHJxalhLSmpyZVQ4OGlpTkoyeWd1bUxwOWhRUk8xWGt0VGtnNnNkRkJFTHp4?=
 =?utf-8?B?QndFUmlsZ0xNT3c4cTdzc29aUytqUm9DKzdDYWd6czhxLzdCcEhSMUl2cUJh?=
 =?utf-8?B?MXYycDBDVHdyMmVRS3Vla1pmMmdWdnFjaEVsa28zSTlhU3hGYnQ4cjhRK29X?=
 =?utf-8?B?eFpHZVU5UnVXTnhnYkhYbjh2cDJWMHpxVmp5MDFaMTJlMU9NTnErZ3dBclN4?=
 =?utf-8?B?MUtSdHhJRVoxZGhtWENMaXFEemRlWkRDbnc3V1VYUXdaWERBcUdyZWFERFpp?=
 =?utf-8?B?UGplYytPWkZZcndST2Rjb01rRld1S1V1WTRhRkVvVk5vUUpUVHNyd1BOaG5k?=
 =?utf-8?B?WHRqSDV6djltS2pqRkVyTWliV21qKytKeWtqU1Q1aDNNM1RlUjFQTlhFSXFV?=
 =?utf-8?B?M1AzdlJxblVrb0V3aUVXdHVsR2RpWlhBZFcxVnJiMXZGQUtjSFhBZm43ckts?=
 =?utf-8?B?ZGt4eVplZDd0aWxacHBWOXl6ajZ5dXhTU3hCS0FFNUlFZmx4S2dvN1JhTGFv?=
 =?utf-8?B?d1BYMjFpRUhKckpRdmMzMkk2SXJ0ei94Qkd0V3NXU1YyMlYxcUdtR1ZrV012?=
 =?utf-8?B?cHNCd0YwSDd1ZDZ0R1JtMWQ2d3A5ZHJoMVFYdHYwTXFSeDMydmtxb0FKTVpL?=
 =?utf-8?B?ejVFWDJsdWpvYVp2WWcvWmFOMkNXQVJtRW5ZMTNnT2JyMXc5SzhJOC85QXR1?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1FE3F90D9822D4D897AD597B94A2A55@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94957e6-a03d-4c39-18b8-08dabc7036c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:18:56.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WaLB2nMYv+mkUc0OqXALVn0zSefcHjRCdjEw8TlAebBSwDjijzmd22sD2qEkFKld5J2xVoesQmXGrJXhU4Sf2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IG52bWUgYW5kIHhl
bi1ibGtmcm9udCBhcmUgYWxyZWFkeSBkb2luZyB0aGlzIHRvIHN0b3AgYnVmZmVyZWQgd3JpdGVz
IGZyb20NCj4gY3JlYXRpbmcgZGlydHkgcGFnZXMgdGhhdCBjYW4ndCBiZSB3cml0dGVuIG91dCBs
YXRlci4gIE1vdmUgaXQgdG8gdGhlDQo+IGNvbW1vbiBjb2RlLg0KPiANCj4gVGhpcyBhbHNvIHJl
bW92ZXMgdGhlIGNvbW1lbnQgYWJvdXQgdGhlIG9yZGVyaW5nIGZyb20gbnZtZSwgYXMgYmRfbXV0
ZXgNCj4gbm90IG9ubHkgaXMgZ29uZSBlbnRpcmVseSwgYnV0IGFsc28gaGFzbid0IGJlZW4gdXNl
ZCBmb3IgbG9ja2luZyB1cGRhdGVzDQo+IHRvIHRoZSBkaXNrIHNpemUgbG9uZyBiZWZvcmUgdGhh
dCwgYW5kIHRodXMgdGhlIG9yZGVyaW5nIHJlcXVpcmVtZW50DQo+IGRvY3VtZW50ZWQgdGhlcmUg
ZG9lc24ndCBhcHBseSBhbnkgbW9yZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBr
ZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5t
ZT4NCj4gUmV2aWV3ZWQtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPg0KPiBSZXZp
ZXdlZC1ieTogQ2hhbyBMZW5nIDxsZW5nY2hhb0BodWF3ZWkuY29tPg0KPiAtLS0NCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQo=
