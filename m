Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8825C433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 00:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiKOAbc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 19:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKOAb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 19:31:28 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB41A39A
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 16:31:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzfZD3JmjAvIMd3kxZxemD0eHSAKu7FuxKjcWkrvV9DPsUSOGx6QUeUgn+t2HjmxKJ3p2QD85gBeBtcB6GGcJTHasxno/mZpXztAuLDqblu3VuX/kVjNGTC6f1gvydbxl+cLHFryi19B+TifSYVrPoiCWZ88BDN2PVyLZ777Sw4nzSXCDSeLA0LPK/fmRJpTH2XGLwwVi+brEH1vrN8GEfYWpvATLubQe2Wu5pyCjGuJmtq24bg5dIbo/jCIJDGneEvEPOUN7zea/DjI//0ANOKlAqVBGRPYlkHsT0JtzyU6KrBoTIPASUhWCYS40n+VoEP2hV8/TyUbtzt9sYvhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEw+jooUqpE6/rXpktPGpXkN9bIgcxH9eP9HerW5Q4o=;
 b=jBh5XhmpZj9E7YZeqCoUVcT99Nb6cx8lJpzPuyVOHc+MJO7qQVfFnaDiSAW36GMfFd5eCVzYjqp7C5uVq47EdJWtTNwjwg4kF6Ymnb9sL608DxGUwnVURVsR5EjJro3VDx7xGIjhqDHjoTB2GSLdlmKfBGuRsY29HVCVyIrMThg0G7ctbN26xcp3tgZiqtwFzUsRYwOmguhJzEf1WzGtnzKgk8BVqwPOEpQkb3REIvRggofU+VYA37td33WN5H3KVU8CzPDAfgTv4SLIvp+9KKQ5E8yTdVL8fhIdF1A6oxV83LuI9nLLxWtRM8f4tQn4AruMvlmTQDygknRaY1mFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEw+jooUqpE6/rXpktPGpXkN9bIgcxH9eP9HerW5Q4o=;
 b=KoLrvelBlnXPUVJTQGrYii+o1gzXVe6uRmZqN8d9UsEbqMnpXgsWCPLJ9Gm9rvabTIEGMyzP4/QIyKekN7JXoCz8rhlLXJ9p7+s8wQ+K90oZIMMKpxXmogYjRiEduF/yrwwo90qI+OpjGiGPa2s8ez2tcqSB06FWkRtNWQLeLigmPkx9PCEZU4qWhbOiZPBUQqskzKDJZx4gRhWr4kUIjM7mAubhulrAtOzpLQ3fWhcHgM171UE5qPLHj7JUtRsQ1QrvaZ9GOK4LPzoexAF2iXxdGYV/YejCLl3Noia+vPh3kdLJ74wJugcdxX/eBhTdWT90KTteU2KKxA40grGoMQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 00:31:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 00:31:25 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH V2 0/7] null_blk: allow REQ_OP_WRITE_ZEROES and cleanup
Thread-Topic: [PATCH V2 0/7] null_blk: allow REQ_OP_WRITE_ZEROES and cleanup
Thread-Index: AQHY2TJaRm8x3gTq0UKs9aoNT4Pu7K4/YMuA
Date:   Tue, 15 Nov 2022 00:31:25 +0000
Message-ID: <1ed140a7-d9d6-3ec0-5798-e1bbc564017e@nvidia.com>
References: <20221006031829.37741-1-kch@nvidia.com>
In-Reply-To: <20221006031829.37741-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ1PR12MB6362:EE_
x-ms-office365-filtering-correlation-id: a904fa75-2bd6-43c4-c1f2-08dac6a0bab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1oA2o13uBG8DJ8sffdhcb9Pxg8mKY93Q6hCUIGPivU268qdNjBQrRHGfGXzObuH9Geo81+/DhodrL/Z+h1vKNw8PV3kXMhYoJ+VKKOGw1TzisQyNXxysVa9JiJFepeT1C80AkF+VQd62yp7tLZSs9xN+Np9NIA6YwaROtxA5IlysR4Mh3//3aYU5wB57kIu54Se9Nt4BLomFatRGaDpT5JrM/FgjqDaPyWS265B/e2ce22HIUxka5csOz3fKN1FahQYJ9/omKByjC2hoWdVtQTxIbdSHvwDugjtwruMPXeUxM+X8iYDV8oL1Yla7to++WMRfg5s8pgLKbxfUam/uxYn70BXjHI5gCFwFXVaB9h/0V1N61GtW9792ZyrW/RBOXXcJdPEvplEkWqmkdv1bwlM5N/AL798Wz4fcRWwONhL3e3xnAxk0HAm2dxw2yKm4X4Kzdh/lkt4MMz+AAsDQ4KHwDg5vUISQxxd4E+HdtIMVePqQKEb/5rHkgaADHPrS4BVD8mzTAw4HfW4kwJzlkOvfgamkKFu+iVZbcATBq+1E9tywXwPLSDIwYIkrHJMOwDvlWICwgK6soF/65Zmzi+EAyzFB6vYVe+t5uvv+jgu1Xa+Cs/NC3x+ana2kPh5CAeaFBomI9+Id8aeWlIVz0jpPGW3MkWiI1UW4fMW2E997mpXIdGhx3xrXjE517RjelN+W2ODEIFHOhWVjPnlvj397sk34VdboneROqrWZ6r4+slmLoHTWwU+9k0hygbiD9M2+1wjLyv3tcbe7/MjmP8vjogt6Cun97biuOYtHxwD4+4wInYzysBrvQ+zOZfYXvneGNi1taU/0DYwlErEWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(31686004)(86362001)(31696002)(36756003)(2906002)(38100700002)(122000001)(8936002)(83380400001)(186003)(38070700005)(2616005)(91956017)(316002)(54906003)(6916009)(478600001)(6486002)(5660300002)(6506007)(53546011)(64756008)(8676002)(66946007)(66446008)(76116006)(4326008)(66556008)(41300700001)(71200400001)(66476007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWZSQWE5ZXM0aHRNMi9CZVlQVmI0d0pxQ0Y3MWg1aERQZ2xvSlY3VUppRVcv?=
 =?utf-8?B?TG1zU3ZOODdQTjJRMVhmNmMrdlNCTFd4SnFYSFJJeG93azBtN3JGNTV1MWlQ?=
 =?utf-8?B?Ujllb1pjSjdmY3hCazNJbDlyM0J1ZmFJelppVTMzVU9GZXRCRzFiRXYvVGhl?=
 =?utf-8?B?Y0RFRjdrejd1Q0U4SEwzV3hXVUJBYU5XTXBJaW5PM2I5THNhR3gvZVI2b1d5?=
 =?utf-8?B?bFVqc1RPYUhUMlFsQ2k2L2Y1WDJHYk5XRWtEYTA4aUZLYmVZR29aNW9NaldB?=
 =?utf-8?B?Q2xGREVsOE9hNFJLTFlkNU1wNW5tL05jQlJsaFFuTGo0RnExSFdGRFB6WDdp?=
 =?utf-8?B?ZENFbFZYVjlnaDA2QjA0Y0ErbXpvaVVyOGhxbXZ1S1dRbHhWZUpMNlVqZ1ZW?=
 =?utf-8?B?Z2hoVk83TmFHU1RZQi8yZDJsWUV3LzZreGs3M2pyeUpKbDh6ekozYkx2ekEy?=
 =?utf-8?B?akg2c0VkMksvZTl4RkJMMlVuejFDOUh4cmViMmV0UGcvQzg3NnBRUjcwMHJX?=
 =?utf-8?B?OHp1bWtCWWlQZ2k1UFJ3bm0wem94WmlsVUtsRk5jaVlXVFFPbGJLVWJRQW5S?=
 =?utf-8?B?dGRZTTRNMHB0SEJMU3RTV3hCMzljYVpkcHRnZFU2K1M5ZXc4RDA5NVIyTWdE?=
 =?utf-8?B?TWlTVXZMM0xMR2tMN0UvcmV0MDRabVNIRk83Sk9hVVNLRzhXNkwyczVSUHp3?=
 =?utf-8?B?OTZSbkRUNXZSdFRldDdRZ0hyckFtak1iRURMa05OMTkrSlora3V2bzNHdGVi?=
 =?utf-8?B?RUdyYWRBZjFMUUEzWGtjcFg2N2JvTy9yZ1luNGlNOGdyZHBHUXpoRStPYXpZ?=
 =?utf-8?B?cFdXS0Y2c2w2VUM2S1NFaEJlNkdQWWpjclk0cXdVc05pWFFMSG9NckVKSXhD?=
 =?utf-8?B?RzF2YzY3bGlmS09Cc3o0NjJTU2pZWUhLa2o5aHlXaXYyVzN6ZklyOWJ3ZE9o?=
 =?utf-8?B?N2crenJxdGxYbDU1cFF6d29SNkxDZ3BnaWlmbHIxZUFIazdHbndJZjN3ZGRU?=
 =?utf-8?B?VkIvZWg2UXhHaitEcTZ6eTRGWng3akxpVmp6VzE3cWIrWE5QN21sWUxhK0Z3?=
 =?utf-8?B?b3dEczcrUW1ySlZib3hSUFJ2U08yVGEyaE0vRVZIMlc2RGRQT1IvcHdsL2Rm?=
 =?utf-8?B?bno3U1VlSC9rcVowQjNaeFB2VmR3dzFmd3ZTczM5RWFpcmt5R1BkRVJNek1z?=
 =?utf-8?B?NFB5OEN2TUlqcXBWZ01TVlc3MWhaQjBnblI3SUt6L2RVZ3Ixci9WNHpYTTBz?=
 =?utf-8?B?UW9BeXBmNEFaaTNsNHBOQ21zdEpHVjhGcnErbWhtWUJWTUM3bEZwRExVWlhO?=
 =?utf-8?B?SmJXRWl2Z0tFR1R1MEZQQ2c3TXU5UzdRek43WDBQN0tnWlhZcDh3MzJvUSt6?=
 =?utf-8?B?WGd5SkhkWjJmRW96b2hVYmlrMEViUHJ4OTRFSnd6b1JuT0pzQjlCSGg3MDhD?=
 =?utf-8?B?WnpFSmNPeUVxajF4cjJ0YzJ0aTVvMmcyczRBcGVTb1cyRDBzUGZHbVhuRFBW?=
 =?utf-8?B?WXhUZ2hvVnh1WmdjYmNuNW0zY0hEM0JLWDNlZVE2bjZ4Vi9sZThyci9SM3FZ?=
 =?utf-8?B?QUQ5aWZIV1NzbDlNVGhZNEduS1JoaUQ0WXdXRGI4dzJGZGZNT2ZEMjRJQmJH?=
 =?utf-8?B?LyszSmdKVk9LaGYyOHJNUk9IZDN5MUw5ZVpUcGY4RWtsSWpZWW1wZ2Z3dHJX?=
 =?utf-8?B?U2o3Qi9iRmM1dDlLbFJpeWFZOGNuZHlaRGFwVWZGVDdrWjJTRG5SaDZSVm9X?=
 =?utf-8?B?dWc0c3NiQk1HaTkvTnFZNWlXdHRxblZEYldTZGE5R3dhYlF5cm1LQUY1eG43?=
 =?utf-8?B?Z1VQdEZJQ2padGFPVFVXZmJxd015Z1hSM000enprZXF4MFViR0pQU0sybVN0?=
 =?utf-8?B?VlNUYkpLRUxnNG03SGIvYzNKZWRxYWpGdjgrUGhLVlpoWWlQRlgzTDY4QXhT?=
 =?utf-8?B?N3JZNjhTaEl4MDRrdWdvWDB3L2oxWUhYNVY2S2g2alJ2TUNLbjNSNnFnaWtO?=
 =?utf-8?B?eVh2Uy91bjEwTmcwODJERURpWXY1a2tKQXp3TUdhM1o2Q1Jlb0RCeDNVQmRM?=
 =?utf-8?B?aWRhdlFRNTNUOFkyR2lDVDdGTmt4NldncDlHSE0rSVoyYklHbkx4dnB5Y3ph?=
 =?utf-8?B?aEhIUTZZdTczT1E3QitkbE1vaVBqWGNXZ3ZNWE1zdmtWTXhXck1NL1dRdk5y?=
 =?utf-8?Q?YIo6iFnO9R2MTce2cg7qG02WWHgly8SwksyyWJxmr2ED?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6FCB512766A954BAA33C5E71C96C919@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a904fa75-2bd6-43c4-c1f2-08dac6a0bab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 00:31:25.4934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfcHx2/PzllGJVDV7boWyFjaSmY5Xien2NtznddbcIpRibWo6gBViJ6pLlnnMc/b7w4SO5w0fYHO4JLQ5fiECQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvNS8yMiAyMDoxOCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IEluIG9yZGVyIHRvIHRlc3QgdGhlIG5vbi10cml2aWFsIEkvTyBwYXRoIGluIHRoZSBibG9jayBs
YXllciBmb3INCj4gUkVRX09QX1dSSVRFX1pFUk9FUyBhbGxvdyB3cml0ZS16ZXJvZXMgb24gbnVs
bF9ibGsgc28gd2UgY2FuIHdyaXRlDQo+IHRlc3RjYXNlcyB3aXRoIGFuZCB3aXRob3V0IG5vbi1t
ZW1vcnkgYmFja2VkIG1vZGUgZm9sbG93ZWQgYnkNCj4gZmV3IGNsZWFudXAgcGF0Y2hlcy4NCj4g
DQo+IEJlbG93IGlzIHRoZSB0ZXN0IHJlcG9ydCB3aXRoIGV4dDIvZXh0NCBta2ZzIGFuZCBhIGJs
a3Rlc3QNCj4gd2FpdGluZyB0byBnZXQgdXBzdHJlYW0gZm9yIHRoaXMgcGF0Y2gtc2VyaWVzLg0K
PiANCj4gLWNrDQo+IA0KDQpJIGFwcGxpZWQgdGhlc2UgcGF0Y2hlcyBvbiB0aGUgbGF0ZXN0IGxp
bnV4LWJsb2NrL2Zvci1uZXh0IFsxXSwNCnRoZXkgYXBwbHkgc2VhbWxlc3NseSwgaXMgdGhlcmUg
YW55dGhpbmcgbWlzc2luZyBpbiBvcmRlciB0byBnZXQNCml0IG1lcmdlZCA/DQoNCi1jaw0KDQpb
MV0NCmNvbW1pdCA2Yzk0NGNkZjUyYmIwNWE2NTcyODAwYTE0ZWRjZWE1YTkyOGE5OGE0IChvcmln
aW4vZm9yLW5leHQpDQpNZXJnZTogOTM5ZjgwM2M1NGIwIDU2MjYxOTZhNWFlMA0KQXV0aG9yOiBK
ZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQpEYXRlOiAgIE1vbiBOb3YgMTQgMTI6NTg6MDkg
MjAyMiAtMDcwMA0KDQogICAgIE1lcmdlIGJyYW5jaCAnZm9yLTYuMi9ibG9jaycgaW50byBmb3It
bmV4dA0KDQogICAgICogZm9yLTYuMi9ibG9jazoNCiAgICAgICBtZC9yYWlkMTogc3RvcCBtZHhf
cmFpZDEgdGhyZWFkIHdoZW4gcmFpZDEgYXJyYXkgcnVuIGZhaWxlZA0KICAgICAgIG1kL3JhaWQ1
OiB1c2UgYmRldl93cml0ZV9jYWNoZSBpbnN0ZWFkIG9mIG9wZW4gY29kaW5nIGl0DQogICAgICAg
bWQ6IGZpeCBhIGNyYXNoIGluIG1lbXBvb2xfZnJlZQ0KICAgICAgIG1kL3JhaWQwLCByYWlkMTA6
IERvbid0IHNldCBkaXNjYXJkIHNlY3RvcnMgZm9yIHJlcXVlc3QgcXVldWUNCiAgICAgICBtZC9i
aXRtYXA6IEZpeCBiaXRtYXAgY2h1bmsgc2l6ZSBvdmVyZmxvdyBpc3N1ZXMNCiAgICAgICBtZDog
aW50cm9kdWNlIG1kX3JvX3N0YXRlDQogICAgICAgbWQ6IGZhY3RvciBvdXQgX19tZF9zZXRfYXJy
YXlfaW5mbygpDQogICAgICAgbGliL3JhaWQ2OiBkcm9wIFJBSUQ2X1VTRV9FTVBUWV9aRVJPX1BB
R0UNCg==
