Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A0C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 12:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbiCJMls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiCJMlq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 07:41:46 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20101148909
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 04:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646916045; x=1678452045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oLRiEa7zVw3t9JmTbwZ+NQ6IfshLPL5imXvIFtwcPok=;
  b=TW/aWVfAvecLoxc8Sc9BNF7U3/putlj4eWNaoypjBzWe92FpeMhtqXym
   udi0GbNeNo2kUvm2Psg9YWi3Y+BOgZSwyxngCuqcVU31mcXGQGYIzRuOJ
   xLtSMEXo93cbj4B4gjU1zPyAvSIhrrYIW7DVjCUCtwGs8I3mZuaJisdew
   hVAOuQE5zJhVrr3SjvVU0BojFfzyh3fhdQEu4HcwU+UbtPRsySP6iBlRM
   3S1nK6mbbwmrQq/Pk9hxIpLwGsbnbYtn1i1SsTGccttCpTcBsQejLNvFe
   Q/vlqONyekHznBB944p1LzZDArRJTfOJS6BWzxP58nsT/RXt2MzGkOLHG
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643644800"; 
   d="scan'208";a="199808152"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 20:40:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWnYEfdX5jsBp4YLLgjrgZI9WkrjFbtyo+8lypJ+p7MSFAjvYTNXksXDGhQCfzo0zltpsbGyG6AnlDF6tB2kLfMrXABtM9KwdXk51N4RSyRPVn8prVSsUS5Bf5s8+Zc5PzeUhM++4s5DX5KU/kvMqasb5rTI8A9emNA9aTjA90bBzXisZRVHAB8T5PJ+453rfswRfFygM2zdypfcR22DzG6yzx/Jz5USdO72O4ojVJarpZt8NHwmGrcexAX2mmoqJ7v8D/kYpvXYzAAg9NbUWJ3104dXuIudtP7Dl665lAd24mgLUe1PvfhV7vlVUL3NFQCl6/SXKQvbBN2ml9qxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XndtXg2lqMAIJ6luLv3mTf0J3qVjHwQsnjVzJiMFvQk=;
 b=PymgoHdNnXtcJxrCQVs0UwRc5jWJ9TplgYVwgXb2k+Ul8MmQX4LXG011iitOQwfBzv13JsFDTEfcz+wZcOs/OQm4uEzO2czSZqLOWR9opLh1/+J7IH63N9mARgZp6BYH6ShLT/jMeMG3Y6WHh8O6FNs01bfClEjU6CXdrF6sJACWNtJZoem5TquCANWH+RenT9z8MytACMnXiBwxTpftYaSGcE0OI1gAQuhdjc3o/nntWEwo9w0irHTCT3ObW38sBmAEDoJhTU2bT4H4EXG062TlQPjnvZnt0iyppOUbrlmWbEefQCKrNECK/zLAX6V7W17mR0aSe7PcA0QIiYv8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XndtXg2lqMAIJ6luLv3mTf0J3qVjHwQsnjVzJiMFvQk=;
 b=QEDaVS812GdFalNit0dGL1WEPOfgxhGql8S+b/IRQgdliAM2ZhsoFqVRC1w/9w/wwVoknnKOWHOFr2e2d0XrGkHeklwTrVoqDoTpkekfc7NYPsYHSfNoEhkmHVT+MI31oOdXNqo1ejU3u4mFU78QEdmm5rSCFFaBW9ByCtESAYM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB5312.namprd04.prod.outlook.com (2603:10b6:805:fa::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Thu, 10 Mar 2022 12:40:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::58d1:70c4:5b35:6c0a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::58d1:70c4:5b35:6c0a%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 12:40:24 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Topic: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Index: AQHYNF+T3Cwh4555b06Tjj5eYItVAKy4YrkAgAAsjIA=
Date:   Thu, 10 Mar 2022 12:40:24 +0000
Message-ID: <20220310124023.tkax52chul265bus@shindev>
References: <20220310091649.zypaem5lkyfadymg@shindev> <YinMWPiuUluinom8@T590>
In-Reply-To: <YinMWPiuUluinom8@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b287ff1c-71b0-4d1f-549d-08da029325e1
x-ms-traffictypediagnostic: SN6PR04MB5312:EE_
x-microsoft-antispam-prvs: <SN6PR04MB531278D075C65F70298523B6ED0B9@SN6PR04MB5312.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gnu8pdG6NI/5yPBDGahg+aHB3r3I7hcponQU2iByr1f6KpyrxUdGxRAWvg4/vslmzcX5BRBdEJgRCnrDJ7NVViYi8cC7nqk+nP/o5NpTJeJLO8NI7Msgh1lOe+mS0g3BDog7YlUa0mH2QCbxV3jYrWyIxnRhhf7MLBMf47c/5K8onJodohFawfRp4JPqq5Nmwt7ZhiS86IKirlRKsGe7GAC94rDM+IeWNBc0JHsdGIJXOz8BpFIHjDCKdZLkuSL9pdnl7QMh3NOkUDUhrJOXbA7n7wUo92TfKEIqeZ067mWjzjv+jWeadLelBiWj1G1wWhYx/A61Ufy/kVHm5y/89NdfLOoXQfyJ6sQ5eQPTvQ+erNeU/6/o+exLu1wiX09ijhvdR2n01rkK67Hk0R+1nLRo+k4OEYfI4mj5Liazb1krf7qyr6qb/GtciHMkTb8WxO82YWfZ6peNNAE4FBjyQL4r076o6XVJeRUQ+KsP19EVrHtTSc6TwJDrgu/4c3ZtA7Fy95BD0/vg0FHRik9xub6V6Y8nNRKTOFf4UrvqKI6OtR2HmPGJA4z3XAheRysHhcTo+rekoUAe3m7OVf0OezLaiQM4csNi0tot4r70+fUo6bcqKph73EylmhjFcXgnE9i2V/Ktg+aD6tEWDaxCS9VPM5d8MoP5k1BZto3b4tL9OpfHxtmZk7C8o3akQ9CggwuGbNOn/EbV7cawsZ9ndRPfxvoSGzP4/+YhUmO/8Wc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(1076003)(6506007)(186003)(26005)(33716001)(6486002)(9686003)(6512007)(71200400001)(508600001)(38100700002)(122000001)(66476007)(83380400001)(86362001)(38070700005)(44832011)(2906002)(82960400001)(4326008)(8936002)(66556008)(5660300002)(316002)(6916009)(8676002)(54906003)(91956017)(66946007)(66446008)(64756008)(76116006)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OeY5Q24O8B2jPOW20NKeYqBklSD0uA+Lp39Lka8nonrRWsbIVbdLdxVN4trZ?=
 =?us-ascii?Q?YSci2iXuFTIQJWsiQVYkXN8oHVo1btF1Ek9UpSefNcJSuzOuydRORJ/LcWxK?=
 =?us-ascii?Q?0oUlmxusS8F8xqOcL313j6WNKlXjeqqkgaGkbew8MzHY+R+wyopTk9/fiex2?=
 =?us-ascii?Q?27p2Vvyvn+5RJt2uCF9ioSB55LLVCuhjeAdhpRkYiqxDnaLr/XfW6bheUN0z?=
 =?us-ascii?Q?p2lokcnzqEIVUJ4t1Lee2TmAtn9fQM5pOpKuWmA6HUbS9Wfa16FoidWe/Loi?=
 =?us-ascii?Q?reFaYcO4oovbaYXhBQsFYngsRBpa2DsvrmReih7AoesuwqtWftoZMKWlVXk7?=
 =?us-ascii?Q?qFqbxH0zHY+L09Xbr2+uIHrK2E2y97Hg+f0x1+rK19+Ix2NH5No7G2NjEaVI?=
 =?us-ascii?Q?eRqoIL422YLH7nIkHo2xbnDC6gzVLrtJTjTKnv0LKkQygBXVpR9jSeZ10tEd?=
 =?us-ascii?Q?0RQ86517FYEADhmF64d9l1QfBcWuiDqJ5Ht4h6UlaPUJ75VPP6gBVuiC1oqt?=
 =?us-ascii?Q?2DlEgmR+Zi/0t+pT6MokcubBcV3CnJk+fsbBHXgJtzFvTkqDCKuq7Obx22OM?=
 =?us-ascii?Q?RBYadBqASgEichd2eD0EsgeQyUrKr2LJvbR0f6p8CG8NKB3/q6tu8xu+B/TK?=
 =?us-ascii?Q?ZcvwQo76BuGmBVaecJ3HXNiTbjvYYD0o27n+2fT5u9ZVy78A1kKHoUnFhSzN?=
 =?us-ascii?Q?Yblf3t/f9vyKA7Aa6LdjGKiZrOOaUzuMtf57V12vnGmqjbWuSPe4lZosqFou?=
 =?us-ascii?Q?II2j48HrFD8AyHRzeobr7KJMOHH4nl1DEfGrM9GxAnJ47FClaatDRXrSNdxI?=
 =?us-ascii?Q?SwJ/AX7jxdd0A+f2f02y4h903FJ5SG5XlojfZQSZJHVzWuzLUIxrc/a2wpmv?=
 =?us-ascii?Q?U21usG9Y21fkTvhjXE5vzr6CFVhhL5+bO5otr7Jl+4MbyQommyN2Z2iamJph?=
 =?us-ascii?Q?Hmd59GrqfBDsTpW6AFtS7h9BJHW7j6g/QYWfFc+zfIAxwUhQMwODTe4Ex+xN?=
 =?us-ascii?Q?2lq8dU9RswInkzybfmHRmtVYorFIQ2wOnP0/lcjn6RaAlKzspz25oPX2wJZ7?=
 =?us-ascii?Q?TC3CtjemNcM3lB5MV4mMSOaH2Q1sFguagg4g81593xjmwg6Id4n74gPCNe2l?=
 =?us-ascii?Q?fkm6nFIP41SzpbOraxR5vhhZaq8OmbP+0kWk9rHKi7Itna83EOUhz1WDbh0q?=
 =?us-ascii?Q?XubD/+k9Bg9ySUKgDPMOxbQRWBDRLG0Sto4gYVrHp+Okfgx7GzpCO7iR51BN?=
 =?us-ascii?Q?TheHNzbd4BZkAaJQ+y77O1bmxz+FHnM7GAHDSCeG5i0NPZIhD0S7/n6tG1Xo?=
 =?us-ascii?Q?Ad/TaMbUSPB90LaCIaKPPoaXmN3xUbUCPpLw/VOF2qEIuOQp4Qdf8h6ipImM?=
 =?us-ascii?Q?3WFNIJ2+Au4CEGKv7d/inls2sOriUKl3IbG1ohqe+sxgwG8tFediu+Egombz?=
 =?us-ascii?Q?t2XjW4N4mmiLk+HgAztlYxgWAtv4yfJI77R2GmJCS6IB35l6b23s74ZAvmFO?=
 =?us-ascii?Q?kYD3pbiWvwFbDVIkL/ideD8MIXIywXCjjh6bzVyXdwQEaiFdvox61xDcEPYQ?=
 =?us-ascii?Q?CGLLXpreFvxSLR/iWqGbuMo4Xl0garrDdzGjE5SvJmwQNmuwRT+dCy4JVA1V?=
 =?us-ascii?Q?+W7TWsmV0aeMthavkjRJtfMf4fzYOCuFnfT/07xbjDG3P856LDs75t0WCEcs?=
 =?us-ascii?Q?U+zGJEfVTMDIYPaCgjPXqsaC48Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAE5175634E706449A9E0830EC704CD7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b287ff1c-71b0-4d1f-549d-08da029325e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 12:40:24.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4TNCx9e5NG8PGXZ0o1cTXbuHoRP7xxQwd9E33+pTJTDHSeWwm1uvmxxqkqzfbRCi6VZUYffKAdxomyOPjLOPH5uyK5Tdi/2pdXvaZGz7v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5312
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 10, 2022 / 18:00, Ming Lei wrote:
> On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawasaki wrote:
> > This issue does not look critical, but let me share it to ask comments =
for fix.
> >=20
> > When fio command with 40 jobs [1] is run for a null_blk device with mem=
ory
> > backing and mq-deadline scheduler, kernel reports a BUG message [2]. Th=
e
> > workqueue watchdog reports that kblockd blk_mq_run_work_fn keeps on run=
ning
> > more than 30 seconds and other work can not run. The 40 fio jobs keep o=
n
> > creating many read requests to a single null_blk device, then the every=
 time
> > the mq_run task calls __blk_mq_do_dispatch_sched(), it returns ret =3D=
=3D 1 which
> > means more than one request was dispatched. Hence, the while loop in
> > blk_mq_do_dispatch_sched() does not break.
> >=20
> > static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > {
> >         int ret;
> >=20
> >         do {
> >                ret =3D __blk_mq_do_dispatch_sched(hctx);
> >         } while (ret =3D=3D 1);
> >=20
> >         return ret;
> > }
> >=20
> > The BUG message was observed when I ran blktests block/005 with various
> > conditions on a system with 40 CPUs. It was observed with kernel versio=
n
> > v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc245 ("null=
_blk:
> > poll queue support"). This commit added blk_mq_ops.map_queues callback.=
 I
> > guess it changed dispatch behavior for null_blk devices and triggered t=
he
> > BUG message.
>=20
> It is one blk-mq soft lockup issue in dispatch side, and shouldn't be rel=
ated
> with 0a593fbbc245.
>=20
> If queueing requests is faster than dispatching, the issue will be trigge=
red
> sooner or later, especially easy to trigger in SQ device. I am sure it ca=
n
> be triggered on scsi debug, even saw such report on ahci.

Thank you for the comments. Then this is the real problem.

>=20
> >=20
> > I'm not so sure if we really need to fix this issue. It does not seem t=
he real
> > world problem since it is observed only with null_blk. The real block d=
evices
> > have slower IO operation then the dispatch should stop sooner when the =
hardware
> > queue gets full. Also the 40 jobs for single device is not realistic wo=
rkload.
> >=20
> > Having said that, it does not feel right that other works are pended du=
ring
> > dispatch for null_blk devices. To avoid the BUG message, I can think of=
 two
> > fix approaches. First one is to break the while loop in blk_mq_do_dispa=
tch_sched
> > using a loop counter [3] (or jiffies timeout check).
>=20
> This way could work, but the queue need to be re-run after breaking
> caused by max dispatch number. cond_resched() might be the simplest way,
> but it can't be used here because of rcu/srcu read lock.

As far as I understand, blk_mq_run_work_fn() should return after the loop b=
reak
to yield the worker to other works. How about to call
blk_mq_delay_run_hw_queue() at the loop break? Does this re-run the dispatc=
h?


diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55488ba978232..faa29448a72a0 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -178,13 +178,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_h=
w_ctx *hctx)
 	return !!dispatched;
 }
=20
+#define MQ_DISPATCH_MAX 0x10000
+
 static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	int ret;
+	unsigned int count =3D MQ_DISPATCH_MAX;
=20
 	do {
 		ret =3D __blk_mq_do_dispatch_sched(hctx);
-	} while (ret =3D=3D 1);
+	} while (ret =3D=3D 1 && count--);
+
+	if (ret =3D=3D 1 && !count)
+		blk_mq_delay_run_hw_queue(hctx, 0);
=20
 	return ret;
 }

--=20
Best Regards,
Shin'ichiro Kawasaki=
