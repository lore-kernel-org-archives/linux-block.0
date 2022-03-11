Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB8C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 06:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiCKGZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 01:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiCKGZs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 01:25:48 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8AA195307
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 22:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646979884; x=1678515884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WF6HbHHlWA43pggQ9raIPZe1mtPn9zquiGvZNkxG/Gg=;
  b=abv1oM/pURF+mVRNgf10GqBQMsNw+vHrX/Meg4fY1DxlGaIkqdSuf9Dk
   sVzSoOScXoR6A00/tyNVGHqnxlwoBNsHmYyNXaW8wos/+VZNJ6Pv3hDo5
   qEW7KwIAmiePA2yo647galB4A+e0dLnAmyVjYeyb1ft7eRH+MxjcysqDa
   99Pt+dYQVYWhc7JXsoPD2V5lN7rqWhJlT5M7FGKpLrXi9UR1ZouudKa+0
   l1RWdW1ESXuNYBxWG8euCILFQRh2Ixpq0CTuHr/XRf+pwMn1XoGd6IOOh
   NsOSVwF7ogaZNQrR33HHSCuc3hCEQft9Mb7mS1RilH/R0Sj6zqI70oe6f
   g==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="299187269"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 14:24:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXUnPfDS6GJAa+Ev6FyQ1anXlMYVJq6KvYJH1HcVYSeqI4cPOF7+eIn1CceVUqmtEKKslp7TN8BnY2eDtqvEgrWJjkm30JK6Fp1UqkpQgc5oIbwOjbxHFSS4U81PwDJQwoMaWvSvE+rQogfE+/PvkJ4NbPwDOYNjhmdVVmI20POHcumBcDbiwFOgUaiquhpVE3EMq6y/PYkVojkdms5qREIDLolUWINbnP+KXYynvt6lJ/OA4NEOx/96/z6C8fodcbmwVlwxfd0PUdwFRnsNQS5KPg4JJ7YImWicSJ2ptCpk+o9i+wNeBY83w/DAsTKiffeuGeD5qqfmLcZv8mZ9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FDunTOdVXujjxMSk/nBb70q55cny037t175GqB7TyA=;
 b=ZvnxB7NOGsCrEjEuDCs3PkTnYZOUVc9T3al+eAOxry9MRkFSlveif2Io8MgSkGnj24+2y0ZTgvI8Ei4vMgSeRCi85+n/5UO0gC260ZrPutGXCgDEYVsqpO36gEtSlRHS51Rmv9mFHXL0gpaYWwjYED4QvTe441SdAApge7w9lUzjnzG18pDiXXIynZHAR+4YQwg+jF5wofFGoZdWtismFvKBjBWs9CyxvXyK37Wvopn6FIczTaauF9982fuzqKuNhZEnooFVKR3Iapi5tkJ0pUokDaRMv8Q/ehqsMysR+ju+vjbDG26EFUnCjIomA2RQfg606dhjKNCS/XDZoyYeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FDunTOdVXujjxMSk/nBb70q55cny037t175GqB7TyA=;
 b=sDfiAZgLu1D/+1gubhi9tymOlxWt9BwGzHohZyoxKIuHtOsq0I7h0sNd6FkibFwgQ6zVRYhI/PHPTaaaD/CBXZ1TBAjyfd+/IGaZzKfiBfTDTYaaNIYDDnGsU+v76ESKEezwIQXAjnbEZiXO7WDm5Wea//9LeDPmOjV1fKNbAj4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 06:24:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::58d1:70c4:5b35:6c0a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::58d1:70c4:5b35:6c0a%5]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 06:24:42 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Topic: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Index: AQHYNF+T3Cwh4555b06Tjj5eYItVAKy4YrkAgAAsjICAAAHeAIABJ3+A
Date:   Fri, 11 Mar 2022 06:24:41 +0000
Message-ID: <20220311062441.vsa54rie5fxhjtps@shindev>
References: <20220310091649.zypaem5lkyfadymg@shindev> <YinMWPiuUluinom8@T590>
 <20220310124023.tkax52chul265bus@shindev>
 <a6d6b858-4bee-10da-884c-20b16e4ad0de@kernel.dk>
In-Reply-To: <a6d6b858-4bee-10da-884c-20b16e4ad0de@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cf4836a-5c87-4d04-1750-08da0327d404
x-ms-traffictypediagnostic: MN2PR04MB6446:EE_
x-microsoft-antispam-prvs: <MN2PR04MB6446E562A7EABF6F998034A1ED0C9@MN2PR04MB6446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5PiK0Xzl+SK7QbPwfKd5OZieUnPDZ6yLItwjB4iOOyWNZEbYC5sNUu1RF9ylfFERRH3rXY5gNkkOANXAlieZdqP835BPs4D/D1q9z/knFD6CcHTA1VYqL4s8chrT7bmEoSvxKNp9CzaZ6xen3cfR+586bIDJCXiazqb3QPCmsAP3zeWyBu74GMXU7d0tAPlwIu2LbIwNPjXv5bjHJ2Z0G7rsleDdj9fikIyBweve4DtBSoTFDuHEeMIpPtkvju49rS4ivbkhFZ8N1lFs65S3Bx9XPjznjjeiBa9iMgDdo57lewSKSsP8BYCaI2jEiOHygC4IRnnnBFsyVm+swkXFT1n7SYIK84flvIUf89pjekstVrx8BYRrVcfk8s5Jz3H5CFPfaj71Zeb/EqcJIl4rkTvo3VGKJLtgfBGIdFyb8zGkL6/xqxuPqKytA1nedLdyf/iA76mdDOcELYVxumkAvqjE8kyzwFF/EBwO/nJcZLhyzzB4r7c0jUrWVCugq8XyJv7Oi/PlITTJ3FWJpnQGIQ6ULgNtNwu0B/tDoMsn6I/h9wNJLO8AQb4a+2yEU37fC4k5/VRDoPVSrYv5j5HKsBwjDsjcWdGTYd7wluyhUwwv5N4j2aRhX+GyGEdVewHiynYtp6ShIAdxRqxeBTCDUxyMN1g6BO7fhmQnKypzFW5ddb4KuGbG5P98/TIeWLQANKepJBLpnRbFQo+s98iLpUZ47bG/+0jm8pSEf/RClw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66556008)(4326008)(66946007)(5660300002)(44832011)(2906002)(91956017)(6512007)(9686003)(6486002)(316002)(83380400001)(33716001)(122000001)(38100700002)(1076003)(186003)(508600001)(38070700005)(6916009)(82960400001)(54906003)(26005)(53546011)(6506007)(8936002)(86362001)(71200400001)(66476007)(76116006)(66446008)(8676002)(64756008)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lMdMjKaprg50nq3oXVjwbpapNwtBmPGd+qZ+xwt1xDROoDmcZA8mqad+X6Xx?=
 =?us-ascii?Q?oJFnoBu+jsRely6nD/GFIOdg/mvOI7qeQsLxPFxDfhNACxXkYSv7qWKSFEKw?=
 =?us-ascii?Q?CzZQnc6WQYjy1YBzQy04OKrKkB5ZHsF21SXIrSR+khcEZwNfKXzaVrMzNuGu?=
 =?us-ascii?Q?0VB18Hu74cgJDNTVqlR75how5Y+BcVzDi7wIDGpv9ivicDlhpQSyFShDpya0?=
 =?us-ascii?Q?fhHYW5BJysMe+v4bJFbaMI0cw+rKIicjuc+ctFkkWC3/l60OlGNwv5ZD/v18?=
 =?us-ascii?Q?YvSCJaEIMTJ9oO9el0hxXqfqt9crYnvztbJ9dZ63+OKdqo94yvFMsWSn7Cf9?=
 =?us-ascii?Q?C45GL1WmLnAOrG4D6/ElTIfWXG7FqGDuLKyI5dwj5S+wyqDwBPFwXcAPmHrE?=
 =?us-ascii?Q?9YgR/3qJWQiDS8TQIwsx9Ts6LifuRk7apT3TxNK9L1uk8oMU4OdRmVx0zKM+?=
 =?us-ascii?Q?55EH7gijUFb2wQ9ZBYWCjkiJfcIL2IQH6sUiTw3+Ls7mfmn2JIvKbzm8XjNc?=
 =?us-ascii?Q?cA0c0B/Cp6bXDvBPLlVuVbyX7dWkV4tcTuD0biQeh0GLCZTNtgzwYJHWGnOo?=
 =?us-ascii?Q?dLmPV62RQrhekpK+HpuZOoxZnmznbNKnxdr8zQE1254zdc9BbiKOgDZsWkot?=
 =?us-ascii?Q?8wiiD9HIenUS/r1YgMVJCwP2gdLDLAoUlV5ybPvdjF66yPuj7N3rhwMNctgF?=
 =?us-ascii?Q?j7ubot9XeXp5uN5/uR+O78wzba9SB4Qcs9sz1hjc/G0CwmY23rlNC46e7Kfy?=
 =?us-ascii?Q?K2wpFZKx5MFYNdJ3LiOxPo+0/A4Iz/M23qf1zyhhfbIVVXpFZdhfJJlcmAqA?=
 =?us-ascii?Q?gLk/QYCmnIJFDWHY3ylKQppkuON4+rBr6hwY12kR70MnYKr2Q+nKP1lHDUjb?=
 =?us-ascii?Q?5rz8FPGyKJRkfr3lRlgIGmq/Qy509Khfp5Eo48UW/fUesmKe9Xhl0fc/muVZ?=
 =?us-ascii?Q?+EKR9pu6ABmB428iUYeyeVrezJLU5Pg8+SeYLOI6qU2q//XYkgaAyQKx21ct?=
 =?us-ascii?Q?TjLgeJFTLOx7QmJcUn8vn/RsBCtJf6Q4myJFInTFY4hTRH+tZcFyGfcv3Jz3?=
 =?us-ascii?Q?/TLakeOGqT9YUx8EkNkcSB85zFyFaBSaob0ZJGsJupmpUQq5O/A4GF5fSa/Z?=
 =?us-ascii?Q?IxoSVDRbXctgHqu/yL3UYTr13z7FdiXxiynl1kkvvU4Lzw90jC1ZXwDk4Cr6?=
 =?us-ascii?Q?j7Z6L2FoXav0aHxNR1usHzvTJbPioZVauzRHUYf4Sv19Lu9BrK8yXuSyK1jm?=
 =?us-ascii?Q?hPbJJX1hAkANiAypK2gS2iXSZFVv1O482qvDzKafLw1KXoY3eXMc6gW0YHWe?=
 =?us-ascii?Q?7ZyUQ2bLFr0VK3XL7HA6JWKWyR60FTZQ2RcPXj1MLPYLz0oOV1YjTziCVjPx?=
 =?us-ascii?Q?rCL1eR+LpwABqJ5nQWp5E8cdGiYp9JyL3gu+3p9+h9Zq3KtX9WYzmdKNrKBt?=
 =?us-ascii?Q?mXGthWnYfXrui2UQySGQNYH/ELtBM8fWnWdypdBpQGUyYWV5xj8z8lKXKnuJ?=
 =?us-ascii?Q?bO9CiFxKoFY0764=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04BF48407C48CB4BB32E25CF4EB7C7A4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf4836a-5c87-4d04-1750-08da0327d404
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 06:24:42.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /90PQ5I9SDYYU0JyI3g8aa5l+YE0lHW1X4sY2GX4b1Sd+8u9OdQLfRdY8dcH/6KaZSXQgp17Ov7+wOMa8QapLKJMm86uCFqUEYZ9DgOdXO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 10, 2022 / 05:47, Jens Axboe wrote:
> On 3/10/22 5:40 AM, Shinichiro Kawasaki wrote:
> > On Mar 10, 2022 / 18:00, Ming Lei wrote:
> >> On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawasaki wrote:
> >>> This issue does not look critical, but let me share it to ask comment=
s for fix.
> >>>
> >>> When fio command with 40 jobs [1] is run for a null_blk device with m=
emory
> >>> backing and mq-deadline scheduler, kernel reports a BUG message [2]. =
The
> >>> workqueue watchdog reports that kblockd blk_mq_run_work_fn keeps on r=
unning
> >>> more than 30 seconds and other work can not run. The 40 fio jobs keep=
 on
> >>> creating many read requests to a single null_blk device, then the eve=
ry time
> >>> the mq_run task calls __blk_mq_do_dispatch_sched(), it returns ret =
=3D=3D 1 which
> >>> means more than one request was dispatched. Hence, the while loop in
> >>> blk_mq_do_dispatch_sched() does not break.
> >>>
> >>> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >>> {
> >>>         int ret;
> >>>
> >>>         do {
> >>>                ret =3D __blk_mq_do_dispatch_sched(hctx);
> >>>         } while (ret =3D=3D 1);
> >>>
> >>>         return ret;
> >>> }
> >>>
> >>> The BUG message was observed when I ran blktests block/005 with vario=
us
> >>> conditions on a system with 40 CPUs. It was observed with kernel vers=
ion
> >>> v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc245 ("nu=
ll_blk:
> >>> poll queue support"). This commit added blk_mq_ops.map_queues callbac=
k. I
> >>> guess it changed dispatch behavior for null_blk devices and triggered=
 the
> >>> BUG message.
> >>
> >> It is one blk-mq soft lockup issue in dispatch side, and shouldn't be =
related
> >> with 0a593fbbc245.
> >>
> >> If queueing requests is faster than dispatching, the issue will be tri=
ggered
> >> sooner or later, especially easy to trigger in SQ device. I am sure it=
 can
> >> be triggered on scsi debug, even saw such report on ahci.
> >=20
> > Thank you for the comments. Then this is the real problem.
> >=20
> >>
> >>>
> >>> I'm not so sure if we really need to fix this issue. It does not seem=
 the real
> >>> world problem since it is observed only with null_blk. The real block=
 devices
> >>> have slower IO operation then the dispatch should stop sooner when th=
e hardware
> >>> queue gets full. Also the 40 jobs for single device is not realistic =
workload.
> >>>
> >>> Having said that, it does not feel right that other works are pended =
during
> >>> dispatch for null_blk devices. To avoid the BUG message, I can think =
of two
> >>> fix approaches. First one is to break the while loop in blk_mq_do_dis=
patch_sched
> >>> using a loop counter [3] (or jiffies timeout check).
> >>
> >> This way could work, but the queue need to be re-run after breaking
> >> caused by max dispatch number. cond_resched() might be the simplest wa=
y,
> >> but it can't be used here because of rcu/srcu read lock.
> >=20
> > As far as I understand, blk_mq_run_work_fn() should return after the lo=
op break
> > to yield the worker to other works. How about to call
> > blk_mq_delay_run_hw_queue() at the loop break? Does this re-run the dis=
patch?
> >=20
> >=20
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 55488ba978232..faa29448a72a0 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -178,13 +178,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_=
mq_hw_ctx *hctx)
> >  	return !!dispatched;
> >  }
> > =20
> > +#define MQ_DISPATCH_MAX 0x10000
> > +
> >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  {
> >  	int ret;
> > +	unsigned int count =3D MQ_DISPATCH_MAX;
> > =20
> >  	do {
> >  		ret =3D __blk_mq_do_dispatch_sched(hctx);
> > -	} while (ret =3D=3D 1);
> > +	} while (ret =3D=3D 1 && count--);
> > +
> > +	if (ret =3D=3D 1 && !count)
> > +		blk_mq_delay_run_hw_queue(hctx, 0);
> > =20
> >  	return ret;
> >  }
>=20
> Why not just gate it on needing to reschedule, rather than some random
> value?
>=20
> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> {
> 	int ret;
>=20
> 	do {
> 		ret =3D __blk_mq_do_dispatch_sched(hctx);
> 	} while (ret =3D=3D 1 && !need_resched());
>=20
> 	if (ret =3D=3D 1 && need_resched())
> 		blk_mq_delay_run_hw_queue(hctx, 0);
>=20
> 	return ret;
> }
>=20
> or something like that.

Jens, thanks for the idea, but need_resched() check does not look working h=
ere.
I tried the code above but still the BUG message is observed. My guess is t=
hat
in the call stack below, every __blk_mq_do_dispatch_sched() call results in
might_sleep_if() call, then need_resched() does not work as expected, proba=
bly.

__blk_mq_do_dispatch_sched
  blk_mq_dispatch_rq_list
    q->mq_ops->queue_rq
      null_queue_rq
        might_sleep_if

Now I'm trying to find similar way as need_resched() to avoid the random nu=
mber.
So far I haven't found good idea yet.

--=20
Best Regards,
Shin'ichiro Kawasaki=
