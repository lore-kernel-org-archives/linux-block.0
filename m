Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A56FC48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 04:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680B3613D3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 04:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhFXEip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 00:38:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58728 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXEip (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 00:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624509388; x=1656045388;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=93PrbGjH/5tWxsd6NbC4aDqd+/T9naVuqQW0kYIeo3c=;
  b=g+TbbE1LMcKA/Ozh7tk/UyMaHSI/xEsc40hTl2bc9BeewUUxm9NvfWRT
   6lBTaSu1x/JQgadmTzsKqRFbvUKdzpv2vuvNaOWW/PBu2Gw0dT2Sn6b8o
   p6Q7Q+iPPZ00dR9jJoaSGcMU7mUYfrMTAP9f9pFQ53S8yGYhf9LapuxNJ
   PWKP7VvrHB+kfAsxDFkNkQPNCHkKwUvh6tWT6X9+MTJkqOtUrFj/BtDRH
   vSzniClR/XiZwl0FQpTYKo4C40DAlgkEzbwfOBL95U/R/ZFR93vn0w4VA
   5GlBdN0/yNjUjGnKnDGma0t884OoY+SI5IrGxMgdbjRYgw2rh1OQpJjUq
   Q==;
IronPort-SDR: XeSySZ2CEJ2yN6ipMcFscKT13+Kingolug6HYRVShiEGYr5izgNzDtHaNVgwxnH0R4uqQlHc3v
 c+wXjZLAWT5kMagjGseKlfRaDfy3KRO3VVTJt/rbicgzsp+x47SahKWhyVhVmivBJ6FNmubeEN
 GN2X76ufIbTcbbuOdf7qYOjPZ/yqNbGSdNRWDCWUU/WdQlhYMnH6E0tNhFD5oZsnZErJJvK14k
 s5WYWrHbAj+ZNdQSIJ8LG//V+QabDlGNFNeUIf1Fa8b9JTHVsPMZKFQ5Ly5VMd2kvh2sp8Qv5D
 WU0=
X-IronPort-AV: E=Sophos;i="5.83,295,1616428800"; 
   d="scan'208";a="173330354"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2021 12:36:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMK1EP65se2QO5tFFRWy+dc/vOnqJJxZRv89YrTiu2FJPf+XgDT+gIH78DFuytWHlF8B6smOa5ZlyeLBFMxgjIKjnNoTa32/+H5jQFBSON6RMuAxSx7SkjAl+qT2rocuTWYe+kjH3SfCpWe7L3waoPop+Sw4cZXvLKSjvHuKZH5QougO9Uri/z3XCT+gSln34O53T3J4vLvj3KqDvGMNG5wIHgFO1wTy81giwbD6dRpiNrZXW4FALOxUwmX2j9AVQ1beMOVBNf5o1spsRNqYULFl27gGQL5G5+nwS8qG3GgkrzhOUoMUVVxB+ioh/9QVPIWSwukjSNl+aAxMOadwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eyld4zklObvqqqKMCzCF0DSBlf1MCRE7IkinFBxPJTo=;
 b=MeEqp/SiUq0KUlDfKL8DZ/fcaMcoNw5e6gBoxyGC3gCWbUonpnFVmdLMyLuuo/9lPNbrjOl6Yywa79ceMENfaZ2TEnIUD47qAW3FnMokGnVkLsx+CdIZapuseL6f4L000KeGyyjio5p8Ya1sij1a5TAT0zLhfewit3L2uMe/3rjYZTCw+Uaqe6DxQPiAN7wNvw7wVJxUT6kj1cWoEA0FvDwhJP/m8GG0WCPKVKzLUvoGvY5iN0kLBO34tuKAHJWWbt0BXxi/B2bZFangqtaVRkDFgKmEcPbp1LUaz6oDcpo3pbpKPNoVyZ+i2v8lJzDbt1oHaZDGYKBJe1tBnIVpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eyld4zklObvqqqKMCzCF0DSBlf1MCRE7IkinFBxPJTo=;
 b=UDveR0DAdyNugXwqIA7jQSq6YcpBOhJFMlQAlTjHHsHDbGnjmLpDTJsrNOsIjOyEivBm+h2gghD8ba+hP5ezQEK+ch4RT01TbnFB3lQaann/eCwmYYB/aJhnZAhNixf+V14mjhDxQyYr5OgmDYnhAoyNPKqD6lREnigDguRtlTw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5526.namprd04.prod.outlook.com (2603:10b6:a03:e9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 24 Jun
 2021 04:36:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.025; Thu, 24 Jun 2021
 04:36:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 9/9] loop: allow user to set the queue depth
Thread-Topic: [PATCH 9/9] loop: allow user to set the queue depth
Thread-Index: AQHXZ71Xsi2lrvqM3E2T/BjEMZdiIw==
Date:   Thu, 24 Jun 2021 04:36:24 +0000
Message-ID: <BYAPR04MB4965D4C98E4ACB32709A273886079@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
 <20210622231952.5625-10-chaitanya.kulkarni@wdc.com>
 <d433361c-f270-f1a4-4eb2-3c1c10e7e5ec@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:2710:3900:8c41:f527:7f04:3efc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3a6ec1b-97dd-4ffc-2311-08d936c99fed
x-ms-traffictypediagnostic: BYAPR04MB5526:
x-microsoft-antispam-prvs: <BYAPR04MB552670A7A08AE347BF74899586079@BYAPR04MB5526.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OVkDmU8OFtdKb7OA47Wkpppm2EL/ASENw55khkLs6qZqvRFlb1EA9SIj6jf61P/YhSzX5huzp3/IhKF7opxIvrNpQOsP09Ozsam5aL7cGq0ZaSrsMbRaZWvqt2mBR/jQ+/6A+yaH1Tt+5FfAAYcUVTmh2dqYU2KwGvzRzmfpbuTnimoz/G2AA3/O89mugXvIaIBxFNg6i6kw9mDFsTjbsDXABWiKazOVm1Ypj+Yscgmp/0Ng5nbWC8olBjGmdP8RAKtAcX87NBIYYiJrmue7lRo62MU/0kKz23o92eXw3FNnvPnntS9dEGanP9iyuqbH9l/7tsQg3g1sIc67+UoO95leoxnovYm7vhhIbPPENI5IjL/0BebAXOa2HMrQaoxc8Cr6gQxN+rwHXDqb+nBsK8+by5m9Rd1m6aGjszqL4SlBV4yMn2pbi9ygmP9t4o+M6vZfpWn6nHR1I77jBk+40v95Z1/FdRyFlEKRsZmcwEPAH2yeBv7LX3Pi8lWKNi19TnrLLHjetXchpFARmC6lmczVL1ELBfEG9FkhZhsOcIV+xQYuxDPcFpQ+lmunoDizeO4fI/7FQkJOx1xd7YKGp2UuzgBJ6mVu8cXnxx5H1z97cYgxwUKV9WAut/ZeOszGKH3zVnplstLeBfhUHqSXLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(86362001)(71200400001)(55016002)(122000001)(54906003)(8676002)(9686003)(6916009)(7696005)(316002)(4326008)(5660300002)(2906002)(52536014)(8936002)(76116006)(6506007)(478600001)(64756008)(33656002)(66446008)(66556008)(66476007)(186003)(66946007)(83380400001)(53546011)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z+X6WFNQJxg9KyVjElI42mDY8LGXr22+EQjgK0WmIquNV9QkYOsGpN+0hoEh?=
 =?us-ascii?Q?j7fflACgcXnD1nbxa6nYwwj8SrC2TYk5f0CYdLbN8yF8C33+Z4kv2Tb7VzI5?=
 =?us-ascii?Q?z5PKgVNVb6DwSsdYB+6ifP0SztGMxBwNVYfUje6sEU3VDxJBXNlXJ2a+7Qm/?=
 =?us-ascii?Q?iDA0dXiPWS2CGfUeD43cVsX0pSTsG9//GSF6g8DZqsKvuNk2Eh/yaDCWnxmP?=
 =?us-ascii?Q?tLS14yxSTGNicJxEvQo2f98OY2didMaPRiHC68jmpNvcmdhNM4kJetkFymml?=
 =?us-ascii?Q?qpPAKgBpLE6xoEPXrBF71f31uSOBzpvlcfXEBW9Z4B3tJvmonehDLBW4EAg/?=
 =?us-ascii?Q?Ys6gQFehVaBWROgJ1GlMf0yKwvSdKoI6d9q9iYgJj206okXW4oUrSnzoKNlt?=
 =?us-ascii?Q?XFfH7rPWbYLXP4lQZ+au1a7CSZDrcIpCTKvVT+pnI7yMi1p9T9xAZAaUvqyw?=
 =?us-ascii?Q?hTXREQh+9KazkUeBBt1sixuLLOeYLvLwIhYHVVFxn2e+/ZSEkFPmvU8rDoMr?=
 =?us-ascii?Q?uBByjvkgaQnuqS662E6mZhvh1oiT0NIiZscu9guOqebAmeEW/XMmVxDu+tS2?=
 =?us-ascii?Q?i+QsnhGGZvzKvjFGo+rC+v+r6uhstBpb3Dop6nHiYx5dOGVOMd/vNEy5qw4z?=
 =?us-ascii?Q?rHSJZZO3BblHRVZBX/Xm85pv5pBEvFMHp2/dTDR+5G6J0D2juesMLPlaVxko?=
 =?us-ascii?Q?nn06mqUGmNrVQTQc2vJYzAkfrzvjHOgV8Zq7HJ/3u0y9VsT41Iz0u0LhHFPD?=
 =?us-ascii?Q?jmyH9UTeyYAvONEOIt0zjp6n+pDgOzLu/35XevkV+5YX4IgPtR+dPmFNcySc?=
 =?us-ascii?Q?Myyrcld46xARgihzIh5G6bKfqaxZP11teweB1eP+oqzgClwk//2jtlJA/rdi?=
 =?us-ascii?Q?Y7Xza6vMo4q/+cB1Su4EvgtDqU8PXcWTNbCVtqpgx2ZYBgZih/5hc1jB0TYX?=
 =?us-ascii?Q?Qr5PtbAZkqHNiVHDkgbnPQoGLXxsV+qm+TT5U4Hyn0IwFtSnTlXXj7vTlKSr?=
 =?us-ascii?Q?BITcb4r8jfoBVtYu0DNqXAFsVGA+i7/WwcFw0u+uZofNrmU/zRXoiIf5xceI?=
 =?us-ascii?Q?EbAjMTDWPViP6aiywJCDwTR4uTXi0gPiN6lNaPiua3ATauivsbGPYEQA8Od/?=
 =?us-ascii?Q?nrs4Zx3bpcYQUPPw8ww/SChmktW6CQluSN/BNiNiEAMWkgRnXTFYgM0POFoG?=
 =?us-ascii?Q?/xlflGyXuyZzOPXbB+OCui7CtaZQQDQAOiXNIcHEja4Dqt4xe8HB3vzU3kQ5?=
 =?us-ascii?Q?rr6PWUE8wfx6o8leKsJKnQU/OeQWUz1xtk6C9hEnevNobQI1xoOWtAWkq1+a?=
 =?us-ascii?Q?wIgr2XbWTzEDc1DFAbPTt9Hb30/OF3iBRimySvRwhJpeesQjudPhixnbGg1p?=
 =?us-ascii?Q?3fx+bRhy+YJlaJwsYoJzM9yTElog?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a6ec1b-97dd-4ffc-2311-08d936c99fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 04:36:24.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dN8bJot6WA36FcJc6NPFitZz17ZDbasP+WugylX+LJ2Hw+QR8qQ1vUFubc5/APZMsPVvAEeASCbav/Duxpsb7dk3x3Q1i4C0GZpHhGrQ4Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5526
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart,=0A=
=0A=
On 6/22/21 4:27 PM, Bart Van Assche wrote:=0A=
> On 6/22/21 4:19 PM, Chaitanya Kulkarni wrote:=0A=
>> Instead of hardcoding queue depth allow user to set the hw queue depth=
=0A=
>> using module parameter. Set default value to 128 to retain the existing=
=0A=
>> behavior.=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>  drivers/block/loop.c | 5 ++++-=0A=
>>  1 file changed, 4 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c=0A=
>> index 6fc3cfa87598..c0d54ffd6ef3 100644=0A=
>> --- a/drivers/block/loop.c=0A=
>> +++ b/drivers/block/loop.c=0A=
>> @@ -1942,6 +1942,9 @@ module_param(max_loop, int, 0444);=0A=
>>  MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");=0A=
>>  module_param(max_part, int, 0444);=0A=
>>  MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop devic=
e");=0A=
>> +static int hw_queue_depth =3D 128;=0A=
>> +module_param_named(hw_queue_depth, hw_queue_depth, int, 0444);=0A=
>> +MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. =
Default: 128");=0A=
>>  MODULE_LICENSE("GPL");=0A=
>>  MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);=0A=
>>  =0A=
>> @@ -2094,7 +2097,7 @@ static int loop_add(struct loop_device **l, int i)=
=0A=
>>  	err =3D -ENOMEM;=0A=
>>  	lo->tag_set.ops =3D &loop_mq_ops;=0A=
>>  	lo->tag_set.nr_hw_queues =3D 1;=0A=
>> -	lo->tag_set.queue_depth =3D 128;=0A=
>> +	lo->tag_set.queue_depth =3D hw_queue_depth;=0A=
>>  	lo->tag_set.numa_node =3D NUMA_NO_NODE;=0A=
>>  	lo->tag_set.cmd_size =3D sizeof(struct loop_cmd);=0A=
>>  	lo->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;=0A=
> Is there any use case for which the performance improves by using=0A=
> another queue depth than the default?=0A=
=0A=
Unfortunately I don't have access to all the applications so I can come=0A=
up with=0A=
quantitative data, I can try synthetic applications such as fio.=0A=
=0A=
This patch is more on the side of allowing user to change the qd value=0A=
so they can=0A=
experiment, making loop qd flexible like other block drivers which loop=0A=
lacks right now.=0A=
=0A=
> Thanks,=0A=
>=0A=
> Bart.=0A=
>=0A=
>=0A=
>=0A=
=0A=
