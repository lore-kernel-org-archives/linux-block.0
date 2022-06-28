Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB850C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 00:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbiF1Ajx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbiF1Ajw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 20:39:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229DBB87C
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 17:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtVreOPA0gKSTL2f3HGSD8cHdyH8O79q3xwFW1oqxeTUtnb64VAmxjojYOW7Kl5u/yuPt/MATBzz8DTvSaJMljCNYLeG1aYUt6QwscCCeCU/uq3drvoEBZ4C5xgBWyy+fd7YIPiyY1PESQPlfN9V92HHeX/T+fGKdVE6jY0G/YYBcNmNGnvhmaUj8IPwSsWMzTrrlW9C7x6JZqlu7atfCuTU4vDAAtt5+ejitn6u8gypxHbNA5HA2jFDLpEQY/GSeq+Ky9zQCHcBkYdsH1J6Mm61yeI/2i5kYBkFOMbtNfUvg2Vp1AqV2inQ2r2lHP9QDfsZRxPnt4ZuWKPNW0q93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKXYrv09hd9vZKB0Zu9dXMOVCs6Sh9pqWKzNNYU97LU=;
 b=I6rtCRDHfWDeBO3RuX3Ing9+KJYH3f6Aah4r8jb2oRXnHL6Px5tuZX1qd1o6o1gN+E4b5w6Bc2v/PQfOS8QiO6fnFso2AWo6knpg9UtB174Dtndkan4inKtz6PiXMW8PrQuktEPA4U4E0FQBT3xsM3ajaKNcgcZic9E38E4s0NAnOYiNWcLzeEaiyUGN/DHwrmCkCDxsfY5+5SEdl1UYvDXHHlOyS643kPLkLtawUHabGmIxQ1c1gPq5JQS4MzQFz8Lcsq8/nqnO/v1ET+9/LtUQMy2tS8R2lrWVV1BW0T3rnuX+157SLEmDKi4syZGgNTA4PfD+ojdj4x04HZkEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKXYrv09hd9vZKB0Zu9dXMOVCs6Sh9pqWKzNNYU97LU=;
 b=XQ5yzr8kVx0NBidiQIlupnLUP/kpQ6KLnzA3ouFnu4rwuxD3fsM/BN0/o+sPrt3fxSynpVba4uHeryvx+f5TWuxX1WrPqEB+Mcw3+kXiAujdJ1AaPA6lGz8hEpXplgrMc0B56wJjtWc6HKll8HBhBvb6LC67/B9KXx5WEG4FVejfkGdl7fTVNv9Da1kbGAuli8rvstaRV8ymqtnAJMDZBz9E4vmjKuh6pZuJmhJf4pCDsnfVckCW2bZh9ZwrF7OZI9AQhB9qaP5c8KzA0TdygkP620boF/b+vwzBpQ5M2EBGRMk5TwVvd4sds26NM6UBLmlBGEFwOrA/b0IwbNcjTg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 00:39:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 00:39:44 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 6/8] block/null_blk: Add support for pipelining zoned
 writes
Thread-Topic: [PATCH v3 6/8] block/null_blk: Add support for pipelining zoned
 writes
Thread-Index: AQHYioTPCXP/ZixtREunWB0d9oxpPq1j+hSA
Date:   Tue, 28 Jun 2022 00:39:44 +0000
Message-ID: <05441933-6a41-9b9d-a81b-2784f40840f8@nvidia.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-7-bvanassche@acm.org>
In-Reply-To: <20220627234335.1714393-7-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63669bfe-3000-410b-f869-08da589eb243
x-ms-traffictypediagnostic: BL0PR12MB4931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /827AXJeNNyeCn7HW5Q1Gy1eqNLlajyEYS5KidCWSgrP0x7NC+/eobv/9JYIXpdr7ZxZNDa6e76FRTfnTtIt3VlC835B/bbD6kTy4GffIjMkKDugXPjLER8UsbXH8N/r+GDRnHMe4Pfw7Lw3bMjdrv68h7WJPC0uTGZO4lsEGGPM5XUG457ReAEEd2v1sYwX8Tsnh8Qhm2uaTOfwgh02ulKU1OvwAZpENe+rKfeu0rhB+2+5ToITy1JoXFpyrX5ALwqWiYn7G0H8fUbC2UpJShyOKyIoNYv2L9Q8SCjNTarCsbBPS/nZft/CaiBmkHT+Mi8Oakwg9nX1gfTA/ANSkQxOK0vivRZ1ePAXQFJkMQ/F0AMQ30h8xHCHOWUx9SUkULtEKTeJde5ZH6prPjC2w8BjMHG5I+vmohyyi7w/MYqt2OW9Ig55naUvoBuH9/TV8Om4aom6NOEkieBKW2NHuGDfFCJOKU/BLlDdU4yWLCn+2Mmk/53u09Dgpe/1IP2Gb4CrASyAyxLtMv4Rx83l6CgA7bURbmj2IwIsGjFFlAsnK4lRbYQX3RTI2fDtDDzkoUWwA4yB6iRBEMhwu4TyxQv973zfucAXz/LJ79wHt57EAZX0cTFpOdxZJETySUoYrjotUvLRpEE/Q3LbED8lnYIiSfPAc9+pb0gS0EVbwOA52sJwLq41rBEQRAGJVkbpC4OmfpS2IxeUrgqueOx3iOhoGICxTS9OGTlasjm8/2uwyqaO+e0fT4Ew3svhsV7hpNmvjKMVdt5uebRtTr37Anw0gcLhssRc3x2OVd+Yst53yH4y+nBcSxyCKHkKbUVSmAgxgWENXMagaJKzURqjBoi7JenGPETOvkRn+Xi+WQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(66476007)(316002)(2906002)(66446008)(66946007)(66556008)(91956017)(64756008)(122000001)(8936002)(31686004)(76116006)(38100700002)(38070700005)(4326008)(31696002)(8676002)(5660300002)(6512007)(36756003)(86362001)(71200400001)(83380400001)(53546011)(186003)(6506007)(478600001)(6486002)(41300700001)(2616005)(54906003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS9yWVArK1BZUnVuTkNXT1o1S0VaMEdoVjNSM0U5N093Y3cvU3ZDMWFXc2E5?=
 =?utf-8?B?VExsWDZJMXRlNWM2SFdGekUwN2NQd3dueUpXZi9HSm9SQ2N6Y2ptQkNpb3Br?=
 =?utf-8?B?UkZ3RG83ckExN0JCS1lZTmtrTllveERYUUtDRVRCSUxhMGpRYXRBeHRJWmRP?=
 =?utf-8?B?My9vaEZHaE1lNU1sMzRGM0xJcVZJWjJIclZ4Q1RVQWJIMFFITENRQ3FXdGdt?=
 =?utf-8?B?WU1adHNiNVdxSW5JNW4zRFBZYzZobTVvUENoT3VVUFNnTms4dkJQTm9DM3J0?=
 =?utf-8?B?SGdNZlpvQ1I4Yi8wZ2RuMlNLZTJ2MjBGMVlUTTV2Wm82UWJ4Z3puU0VnOUIy?=
 =?utf-8?B?ZXpLRjNjVWgyMlhNODhHM3FtV3c3NURia1UyaiswdVcvZEZiYlpja1FaWmhF?=
 =?utf-8?B?QXdCUjg1U2FUODA5SDU2QmlIZks2OVIzbmVUZkpySUlNcFhUcnhNUVNsWlVJ?=
 =?utf-8?B?M0ZXNVphOTlUa1dLU1cxMFhGVFZ3ZmpMb3pkOU9icGVFb1U2ODByYUl0amVL?=
 =?utf-8?B?N1hoL3ZZRXlrYVFmR2FtN0YyOGRkREExMG9UQVNnMlYrMUFCQjF6cno5Risy?=
 =?utf-8?B?c3JxejV2YlZuSnkwTmZBc1d2STYxYm9tSUw0cnBZYkFWa21Mczk0WVg3c1hE?=
 =?utf-8?B?cHB5SHV6K2I0dmQ2L1JvNVNQaURLWU5Nc2wwcm10RFNSUHYyNkhweldkU0No?=
 =?utf-8?B?Y3dnVHZrVEZKeHB6NGoyUHJCRWYrWm8xVlRBZW9odFV3SGk1MVRlSU96dVd4?=
 =?utf-8?B?WG9SQ09rRFA5OHlOemp6SHZwWk9rN1lCL3hpdUNncVhxeDVwcnUxMWFsQ2Rz?=
 =?utf-8?B?V00xa3NYUlR5RGNzTm05c3hnL0JvVUEvcnJOQ3dnYStpSjU5QTdaNkl0OHFO?=
 =?utf-8?B?OERBMzBPWTVMbnloNklFcEQwWTdiR3VMZ2R6eGkrdjJWbHRiaTI4ajdvQllR?=
 =?utf-8?B?YzlxT1JDelRFUzhYWkJuakRJdWwvaHJIamVZSFMzSmdWS2RVVjNsUWdaZWR1?=
 =?utf-8?B?aHZYY0l4RmQ2OGtMNXRYUlNyUkFTdHJUb1dVT2FiSGxRZ1hwRjFSUng0ajlr?=
 =?utf-8?B?UytZRTJpQ2ZubzhtbW5MczVmdkpTV3V0NWpHM2w1YytJd2pyNk1jeGJ2THNx?=
 =?utf-8?B?RTNzTUFYK1lqTkpaYXlhLzBEM21HV3M0OGNNTGpWQVU2TEFQYjJRdE5hVUR6?=
 =?utf-8?B?QzBuNjdhc0JMZWVqRUMzSDNydHhvWVY0d2FNbUFONllJSGlRQlVwazJCZllW?=
 =?utf-8?B?MlNJMlFvRDRIdStyZno5UXAvQTJLQ1dxdGhva0RRNkJNaGRSN0FGdC85SEJu?=
 =?utf-8?B?RThXQ3cvL3p0bUJoUE8yRHZGSDRRSElBMlNNMGYyK3FIYW9RZjUxWDYwUk1X?=
 =?utf-8?B?czUvbEhSb0hPaTZFdUJXYzJBMi9SU091ZndJLzd6cm5tU3Y4bndUSVM1VFpQ?=
 =?utf-8?B?eDBIVVpPWWdEelNKVHVPL01VYU5sbTh6OHpNdWhVODR1V1VTcnNRREI0VTlP?=
 =?utf-8?B?TGgzcmZGc1BWeWFoMUNGZ0oxMTFiTHFjcTFuUzlVZmhtNVVqWE5HeDVubU5z?=
 =?utf-8?B?eTZJeWFTQ2s0SW04akhIbVA2KzdxWmNPZ3FxWjIzNTBXZ1JsbWtrMCtjTDVq?=
 =?utf-8?B?MlBxaU9zNDRlbE92YzBFcXdnWlBGOWJVclpmZ3l6WDZHMXBvbUlTcUUxOFUv?=
 =?utf-8?B?MGNSU2IxQmpXRjRRU1BKWEpsTmIwWWo5elJXb0pQa1E5TytvMkNyb05mYWxk?=
 =?utf-8?B?ODlIQUN1UXk4Nk9aeFBaRGUxQlVaVjlQRUlEUW5uQmxuRGk5QnhlVzBCZkVy?=
 =?utf-8?B?YnYwMldmeE5iRG1EY20xN2lmdk1kTHpxTC9WMXFtNjd2VENIbHZTbnJjeEZF?=
 =?utf-8?B?Z3pBaU8vUER1dExMbVRQSmVOVnFvb2JqdjEwNHNXZkhtNEZYR25JS1FEZEhB?=
 =?utf-8?B?b1oxbnJ3RTA4VVFTc1ZDbkZSYVk5b1JLY2JLVkZjclBKOXFBSFF6Q3ZjaWF6?=
 =?utf-8?B?cWh5MGsvVFBFSXlXSEc3cXdqWXZMNVFrcXlOWWNTMHJCdWVVSGU2b2QrMEF1?=
 =?utf-8?B?bDhwVk9DdEVlQjNnb2tqM1VzYnR1TGEzZHI5WGF5M0VmN0Z0SlFNMmNTTFVH?=
 =?utf-8?B?aUMzVlJqTzFOQjkyT1QrbENFTDJZU1d5aEM5QU1WZ25ZdTlKZkhHbVI1cFhG?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89FB73ECD9047C4F8B6027518A59993A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63669bfe-3000-410b-f869-08da589eb243
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:39:44.4597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+dLDxmm9bFBIt+MrRbhaOQpm3tcL3m4LFxfGoAH396cUrr46t9K1lAlZskL7YBvqA/RuukDwLl+lEH429UXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi8yNy8yMiAxNjo0MywgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBBZGQgYSBuZXcgY29u
ZmlnZnMgYXR0cmlidXRlIGZvciBlbmFibGluZyBwaXBlbGluaW5nIG9mIHpvbmVkIHdyaXRlcy4g
SWYNCj4gdGhhdCBhdHRyaWJ1dGUgaGFzIGJlZW4gc2V0LCByZXRyeSB6b25lZCB3cml0ZXMgdGhh
dCBhcmUgbm90IGFsaWduZWQgd2l0aA0KPiB0aGUgd3JpdGUgcG9pbnRlci4gVGhlIHRlc3Qgc2Ny
aXB0IGJlbG93IHJlcG9ydHMgMjQ0IEsgSU9QUyB3aXRoIG5vIEkvTw0KPiBzY2hlZHVsZXIsIDUu
NzkgSyBJT1BTIHdpdGggbXEtZGVhZGxpbmUgYW5kIHBpcGVsaW5pbmcgZGlzYWJsZWQgYW5kIDc5
LjYgSw0KPiBJT1BTIHdpdGggbXEtZGVhZGxpbmUgYW5kIHBpcGVsaW5pbmcgZW5hYmxlZC4gVGhp
cyBzaG93cyB0aGF0IHBpcGVsaW5pbmcNCj4gcmVzdWx0cyBpbiBhYm91dCAxNCB0aW1lcyBtb3Jl
IElPUFMgZm9yIHRoaXMgcGFydGljdWxhciB0ZXN0IGNhc2UuDQo+IA0KPiAgICAgICMhL2Jpbi9i
YXNoDQo+IA0KPiAgICAgIGZvciBtb2RlIGluICJub25lIDAiICJtcS1kZWFkbGluZSAwIiAibXEt
ZGVhZGxpbmUgMSI7IGRvDQo+ICAgICAgICAgIHNldCArZQ0KPiAgICAgICAgICBmb3IgZCBpbiAv
c3lzL2tlcm5lbC9jb25maWcvbnVsbGIvKjsgZG8NCj4gICAgICAgICAgICAgIFsgLWQgIiRkIiBd
ICYmIHJtZGlyICIkZCINCj4gICAgICAgICAgZG9uZQ0KPiAgICAgICAgICBtb2Rwcm9iZSAtciBu
dWxsX2Jsaw0KPiAgICAgICAgICBzZXQgLWUNCj4gICAgICAgICAgcmVhZCAtciBpb3NjaGVkIHBp
cGVsaW5pbmcgPDw8IiRtb2RlIg0KPiAgICAgICAgICBtb2Rwcm9iZSBudWxsX2JsayBucl9kZXZp
Y2VzPTANCj4gICAgICAgICAgKA0KPiAgICAgICAgICAgICAgY2QgL3N5cy9rZXJuZWwvY29uZmln
L251bGxiDQo+ICAgICAgICAgICAgICBta2RpciBudWxsYjANCj4gICAgICAgICAgICAgIGNkIG51
bGxiMA0KPiAgICAgICAgICAgICAgcGFyYW1zPSgNCj4gICAgICAgICAgICAgICAgICBjb21wbGV0
aW9uX25zZWM9MTAwMDAwDQo+ICAgICAgICAgICAgICAgICAgaHdfcXVldWVfZGVwdGg9NjQNCj4g
ICAgICAgICAgICAgICAgICBpcnFtb2RlPTIgICAgICAgICAgICAgICAgIyBOVUxMX0lSUV9USU1F
Ug0KPiAgICAgICAgICAgICAgICAgIG1heF9zZWN0b3JzPSQoKDQwOTYvNTEyKSkNCj4gICAgICAg
ICAgICAgICAgICBtZW1vcnlfYmFja2VkPTENCj4gICAgICAgICAgICAgICAgICBwaXBlbGluZV96
b25lZF93cml0ZXM9IiR7cGlwZWxpbmluZ30iDQo+ICAgICAgICAgICAgICAgICAgc2l6ZT0xDQo+
ICAgICAgICAgICAgICAgICAgc3VibWl0X3F1ZXVlcz0xDQo+ICAgICAgICAgICAgICAgICAgem9u
ZV9zaXplPTENCj4gICAgICAgICAgICAgICAgICB6b25lZD0xDQo+ICAgICAgICAgICAgICAgICAg
cG93ZXI9MQ0KPiAgICAgICAgICAgICAgKQ0KPiAgICAgICAgICAgICAgZm9yIHAgaW4gIiR7cGFy
YW1zW0BdfSI7IGRvDQo+ICAgICAgICAgICAgICAgICAgZWNobyAiJHtwLy8qPX0iID4gIiR7cC8v
PSp9Ig0KPiAgICAgICAgICAgICAgZG9uZQ0KPiAgICAgICAgICApDQo+ICAgICAgICAgIHVkZXZh
ZG0gc2V0dGxlDQo+ICAgICAgICAgIGRldj0vZGV2L251bGxiMA0KPiAgICAgICAgICBbIC1iICIk
e2Rldn0iIF0NCj4gICAgICAgICAgcGFyYW1zPSgNCj4gICAgICAgICAgICAgIC0tZGlyZWN0PTEN
Cj4gICAgICAgICAgICAgIC0tZmlsZW5hbWU9IiR7ZGV2fSINCj4gICAgICAgICAgICAgIC0taW9k
ZXB0aD02NA0KPiAgICAgICAgICAgICAgLS1pb2RlcHRoX2JhdGNoPTE2DQo+ICAgICAgICAgICAg
ICAtLWlvZW5naW5lPWlvX3VyaW5nDQo+ICAgICAgICAgICAgICAtLWlvc2NoZWR1bGVyPSIke2lv
c2NoZWR9Ig0KPiAgICAgICAgICAgICAgLS1ndG9kX3JlZHVjZT0xDQo+ICAgICAgICAgICAgICAt
LWhpcHJpPTANCj4gICAgICAgICAgICAgIC0tbmFtZT1udWxsYjANCj4gICAgICAgICAgICAgIC0t
cnVudGltZT0zMA0KPiAgICAgICAgICAgICAgLS1ydz13cml0ZQ0KPiAgICAgICAgICAgICAgLS10
aW1lX2Jhc2VkPTENCj4gICAgICAgICAgICAgIC0tem9uZW1vZGU9emJkDQo+ICAgICAgICAgICkN
Cj4gICAgICAgICAgZmlvICIke3BhcmFtc1tAXX0iDQo+ICAgICAgZG9uZQ0KPiANCg0KSXMgaXQg
cG9zc2libGUgdG8gbW92ZSB0aGlzIGludG8gdGhlIGJsa3Rlc3RzID8NCg0KLWNrDQoNCg==
