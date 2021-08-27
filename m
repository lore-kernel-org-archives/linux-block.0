Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE0C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 09:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E81660EBD
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 09:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhH0JVX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 05:21:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42153 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhH0JVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 05:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630056034; x=1661592034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q43vEmNnDxjN82oav3v8nUZjQcNv6yljPL8jaLjeNRk=;
  b=MA1FkJX4rDqZAamWtYVctPzdlA4WSYbRrkWhtw/PvzslasXYv1A5tDRZ
   XDoWHuzhc43zXPS2iQyqdUOP6lno8Jx7HY0i2heIZnLj7KDY9MT9rHPlY
   0WKVZZvnkgYU7f4Kx70qO+uHiZhs5DK35ARdrIKFO0tAPA0SuCvFUdJqH
   e6XwNDaM/yzKsJD3nuZkNJyzO0KsBo2HXHUhiH90nYRsXNOYueT0uuOhx
   NhcgrftOO36oyMag+IDn9DzOv9s78+vAMdQiJ8rAyAP0WZ9Xx5Ynr5GBM
   1lWZyuoF9yRTm4c0wtartY8BCVPGBXy6b9ruMbFH5j9PnTWMQH7P/0nH4
   g==;
X-IronPort-AV: E=Sophos;i="5.84,356,1620662400"; 
   d="scan'208";a="290168160"
Received: from mail-bn1nam07lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2021 17:20:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKx7zrPP89FS68fyska3uonqTqNtpGq9GgXDftn7sHYdW4dUzISk7SI/i3LsYbpHsYtuSpBvsCdhhP10eC8frwugt6FPtf1I8CwivBYyW3gxf1GfipLCH/Ap4xoVSak2ttwDJfM7HX8irqC9A1wQKx3iY8xfrOUjNhPpT34FyTLReCxvCDcb3X7VlveSL0ai5DB8Dur02Z+VYMHEANzcNtat1sgiyrV4ziKwkv9usxh0/hillQwQwvynEdGwta/DX3cbXNQnIjCjaH1D6hgdD0zoys/YLSSPUAYxgp3qM1z9tK5QHdiwFDAgSZ+l7rfTJTRmPAVuL95xX/w/pawfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q43vEmNnDxjN82oav3v8nUZjQcNv6yljPL8jaLjeNRk=;
 b=SohImKJThkZjYQhk31kGOs/Or6fJ7j0JPI6SLWH53V4jyhoeJZgbxTzfsL1yNFAICxqJ2zK4JpaABawDIFUPvLCfHcfAoB6p+3tBveXdlzXVfjs0Q1TEeVwaoLUPzTgwvXYW3zZz32m0fnW8cgQA2xiBG9iLEFfl44tHAHXXT8b0ozlPR+iXYTll9YC34vazh0y1VIN1n9Fb2WEn2rjx2vVxE2ggT6kIZEAKLoNJj5fpoISbiYzh179Oe5tUQFvqcNSHtZFxTnBqqpoSAvh3XTTJJ934sr+VyByw/btHoWNvHIXh9JI3qgOm3TibIfqCtoEzahy5ZrEJOyci+6QaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q43vEmNnDxjN82oav3v8nUZjQcNv6yljPL8jaLjeNRk=;
 b=gMQo2cO9nAaZJTce/YWOEGNdbG7cnSlyoIOAHtY1SfOa86brwNJzcGSGC8lCp0f/6+ZMYEUpzPjjYxQYXhfgfpreTmXNxGQs9p5S+5H4DUJv/KeSO7MeH/KihuZKfYts5sVhxvdsU0HiN5x6UyaBsgNby2ScS09cQ1YR3WfMoNs=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7719.namprd04.prod.outlook.com (2603:10b6:510:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Fri, 27 Aug
 2021 09:20:30 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%5]) with mapi id 15.20.4457.023; Fri, 27 Aug 2021
 09:20:30 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] mq-deadline: Fix request accounting
Thread-Topic: [PATCH] mq-deadline: Fix request accounting
Thread-Index: AQHXmQo/gX/I8ls140654nArQfUln6uDLcOAgAN09wCAAHS+AA==
Date:   Fri, 27 Aug 2021 09:20:30 +0000
Message-ID: <YSiuXNolj2STI1DP@x1-carbon>
References: <20210824170520.1659173-1-bvanassche@acm.org>
 <YSVmEWtARsGyrEW2@x1-carbon> <18594aff-4a94-8a48-334c-f21ae32120c6@acm.org>
In-Reply-To: <18594aff-4a94-8a48-334c-f21ae32120c6@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95cd7701-743d-4df7-bd45-08d9693bea5e
x-ms-traffictypediagnostic: PH0PR04MB7719:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7719EEB996776F5C23E075C9F2C89@PH0PR04MB7719.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3s0rvoIixav3968WmxybUnrwwkiYao6GTvjJTP733EJ2X+VbEagmOXJSnKgyj8RbRF2acL0wWQwPnJ7YfXo9b28YDEV87KssWMsPXM/DWyd0khIUHdgz9zVmSwEh+1rNLmRrYLZPDnUOZbUYyACMQAue9kq/A4tEiky3dQJQC6jrWJk3Dt3dFE1vdUxdDecg4NkPUG6XchGvDdTHtJFidtHNw4hzcAmxyWv8aOMuPcU0nq+2sQuJL9Ipa8mRo/bO7rPkcyQJO4JJ3Dw0qDSd8zBpgfPiwWW35xnWB/1I84ahmXQOcFnzM6ArGfGwarRufP8S5eql5Nt38tABh5lk3PlHyXMxgVKotEVwcFPeXIDdQBntGay78gUKnDOPVk4/Isbo83eQ3g48YixK4gViXdutN1BODfq/DvxQ8cUw+1lLWBdi+H4ewYrH/IK5PPR/GFrxq5pjeOl34WmT41SjAyItD0Xt/LldFefR/AmkfdQ4fh1n+lnFk3LhHNhZhYCi79daCw46ApXu+Cu6f3e0DltelasHsCoRi92N2LBVdIDWOs5qZ2DODp9zh92jfRdmys0VPQC8qR7rA0KjZh6MCQIcJxvP0UD2YJIen1Wwqqaqg5/VxlOcrGnKUC5eZJGMacnUDToSbV18MnyU1R2LGxhOi5n0WQ82gQn/Tgzi6aVHQUsKruOr24DO+tSiwrlToVgT6WkhFeUbtHjuwVBe54/FO8S6coQxK4wQJGhiHIy89FUXyrFchTN+KJMbJnRNSS4jRS+AbzCS4ws/8n+2SMC2E+v7J87JgPcw3pGZadQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(376002)(136003)(39860400002)(366004)(346002)(6486002)(71200400001)(66556008)(66476007)(6916009)(8936002)(38100700002)(66446008)(64756008)(54906003)(38070700005)(33716001)(8676002)(6512007)(9686003)(316002)(66946007)(83380400001)(5660300002)(122000001)(966005)(186003)(4326008)(76116006)(2906002)(53546011)(26005)(86362001)(6506007)(91956017)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g8mpir9+U73W0/BedFeNJ56BvvIaSCL0nlrRjRrdFfVvRQ4u4Iljq++3MXpQ?=
 =?us-ascii?Q?HYmsp0/SzS/W0Uln39FpeIJdHrQUgrF8V4wUSpFMLkg9n9C/ftqoSFDgVKrk?=
 =?us-ascii?Q?Hs2L+aZ043ctvwz3OZ53Y5qoNM6yI3EarP3VGgwOKxqhL6zZB/SxCDDrrs4x?=
 =?us-ascii?Q?nafrNsNnu09aSFzt/TGb1a1Xz/1PB8BMUrso3uoItF+RyIoQ7eYnHDau9mV6?=
 =?us-ascii?Q?9ooBL4Jj0mz8M9Z2DWwx4wK2gTYNoFiNABVl4du/DRpxwXRYfPvGr2/Fqzhe?=
 =?us-ascii?Q?IIo5CVnmeolhHkue607bMzjGjbaShf5+kTGPqBRM7M3iJg0r/6JE4zzu5+Bo?=
 =?us-ascii?Q?6GCfmV0nQke09PtKnY+7mTdqjK88pitcmFOaOaHNH8D+bppCgy6TkK40UONd?=
 =?us-ascii?Q?wN50fQhgAHisKfq9FJgMoF6WFJV19XuXb2XCCH8u+WGjpVtx7sm2oy+bPFLz?=
 =?us-ascii?Q?vAZzOo+S2IjIOxmOik97y6Jvu45CN5rvy7u/RtB0q1iwk0cP4O2U6By8QDD5?=
 =?us-ascii?Q?P/1PiWEBZ9QA27k/SOyiPpn4P/vXDN3P3iAWrmp4OPP5roVJ3xKMcxWtDrNf?=
 =?us-ascii?Q?jidSM2DA9Tp0CtXnjzdsq+pzGG+PwJW8a8lr2rn2yVEIo4mgAmSobOeEE6ld?=
 =?us-ascii?Q?LB4ES9Qz6H7M033j4EGW5xZwzlBOL3phc9ivbTdj+Nnx+UEJIjCjlQh1h20Y?=
 =?us-ascii?Q?zFUdzv70y0xC486yfBByNYfOKfY7Fbz6o6AFqF1BNnU1V54v8q+jBOEC/rGN?=
 =?us-ascii?Q?xJaCRrGkVHP4/0Y3f6DkHhsaobiggPUG4yS8J1M9iR9Y2AhtNZWUFaoN/8ml?=
 =?us-ascii?Q?E34wHgZsl7jz53deGmYKVKHyF0X6EuCowcrH60dWmZiQoww+qO7+22mLAzQA?=
 =?us-ascii?Q?K2MZAcQBiABVuVO5mpBll+DudaQTNa4GI/VzkySE6sgCZtHncrqKPrDUF51W?=
 =?us-ascii?Q?LRJo6p4svObgg0veFBWRVsycmEMJPQ4mbvvZ67Bg47une63uiQabq/CL2IPq?=
 =?us-ascii?Q?TjPya2LriSiJyEUh/2rApK7qFH0IDndSDEvp2ohCIx3JGwItVOTOgf3muNU3?=
 =?us-ascii?Q?wP3LN6F0QxGTSU8FYuTSGCDz8JuNY4nZcsecoVh3D/PrNxEe7jx2p/2tsxd0?=
 =?us-ascii?Q?WmLQ4DtIsSe/2llejV79qIWrBIRCalJGXe5fnGkDdhtOs+4j4jVy5KobCHA6?=
 =?us-ascii?Q?Wpga6ZEA8/Wz60drnWa++alnLY5Wj9DiM0kBp78CD9XwA1gxZ6UZtOwHMWCl?=
 =?us-ascii?Q?aklHsGPG0dM7JUtpm6bw90Ac724qveV432YF/f+erWS+SpVToCvI2QzW0OxS?=
 =?us-ascii?Q?WWXIzfpaJfVnOpH35kcHax27tAHUbQGewTyfqV/DqWaeLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FEC81548D85FD42BE5E4E3BA3EA642D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cd7701-743d-4df7-bd45-08d9693bea5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 09:20:30.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zf6LT4C0Mbg07ucQUf4PDuew/G+yG9WN+R0Z5VemwiZ2y+FGVy68sSJGuJks4Gtx8MCuysX6OhrdI0V4OIwHdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7719
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 26, 2021 at 07:22:38PM -0700, Bart Van Assche wrote:
> On 8/24/21 2:35 PM, Niklas Cassel wrote:
> > Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Tested-by: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Hi Niklas,
>=20
> Thank you for the help, that's really appreciated. Earlier today I discov=
ered
> that this patch does not handle requeuing correctly so I have started tes=
ting
> the patch below.

Since Jens has reverted "block/mq-deadline: Prioritize high-priority reques=
ts",
which was the culprit for the 10 second slowdowns in the first case, there =
is
no longer any urgency for you to fix the counters to behave properly on
requeues, since without that patch, the counters are not used for decision
making anyway.

Looking more closely on how it is solved in BFQ:
they have both .finish_request and .requeue_request pointing to the same
function: bfq_finish_requeue_request()

bfq_finish_requeue_request() also sets rq->elv.priv[0] =3D NULL; at the end
of the function.

Also see the big note about how this really should be solved in blk-mq:
https://github.com/torvalds/linux/blob/master/block/bfq-iosched.c#L6456-L64=
62

Is seems wrong to clutter multiple callback functions in both BFQ and
mq-deadline because of shortcomings in blk-mq.


It seems like the way forward is to add a RQF_ELEVATOR request flag, which
only gets set in req->rq_flags if e->type->ops.insert_requests() gets calle=
d
(by blk_mq_sched_insert_request() or blk_mq_sched_insert_requests()).
Then blk_mq_free_request() only calls ops.finish_request if RQF_ELEVATOR is
set, and similarly blk_mq_sched_requeue_request() only calls
ops.requeue_request if RQF_ELEVATOR is set (and perhaps also
blk_mq_sched_completed_request() for ops.completed_request).

This should enable us to remove ugly if-statements from .insert_requests an=
d
.finish_request for both mq-deadline and BFQ. (And BFQ can also remove ugly
if-statements and comments from their .requeue_request callback.)


And no, we cannot reuse RQF_ELVPRIV, since that flag gets set by
__blk_mq_alloc_request(), which is at a way too early stage, since at that
point, we don't know if the request will bypass the scheduler or not,
the flag has to get set at insertion time.
(Since right now, a request that has RQF_ELVPRIV, and have thus been prepar=
ed
by ops.prepare_request, might still not get inserted into the scheduler.)

We should probably just remove RQF_ELVPRIV, and as a first step, simply hav=
e
blk_mq_sched_insert_request() and blk_mq_sched_insert_requests() call
ops.prepare_request immediately before ops.insert_requests. Because current=
ly,
it seems that all elevators only use .prepare_request to clear private fiel=
ds,
no elevator has any real logic in their .prepare_request callback.


Kind regards,
Niklas=
