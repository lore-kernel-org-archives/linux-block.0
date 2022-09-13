Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73018C6FA89
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 10:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiIMK6o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiIMK6Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 06:58:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C205FAEF
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663066681; x=1694602681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DBBntAuPtLkMlZH/hCm8BoiUUXHZassQgT4GGvmi8aY=;
  b=B+Jd67XnmndEgmP9UZHQxGybWDjIycjr76CxJNFNgPjR9Cgj5/3GD5sI
   KSysdAoMHF5tl+O9PcDkizriG0LoxvZn32Ic/7oaqyitrKKdlie2HX7wo
   KqX+oRlhtRwOFExPD8RawZQGwju4WXtAQwZKs88qbpIHQ3MH7CDvjlbZi
   Jw3WxgzR/m/NmaGOBwTjFdLaOSEdR7Jo6fdoGS9ZU8SVCvwRWJdMrgZND
   H9pWLvnXktZV6T5YpDTPXpV9dWOgUcmriQrktQVGjlRTZl4OY63Mfgyw9
   ZFMx/T1ZzUEywy43Y5QwqMF/t4fly6hyj1hBnjIQ9znWvFXOcscGNEWw/
   w==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654531200"; 
   d="scan'208";a="315497416"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2022 18:57:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy/Z20lO/Wr+J8cW2AuzpsqxzaF6YOVTK1mdtZad7bwObhThdQcb+k6akJ6uJg0joY93YJsgh/wqq1ceqGkEyHk9JNqhPnkedvQ299Ho4OmgldG1vgyqp6y9Y1dGOB0mz1AomumlST+l3ibZnPlfqeYxpUbdPkguvV99+VXF2lqmg5ODRZaZc8D2Ki44sKXpYRhXmClMZvfbYQ5I8xeQSRQLlDDUjxv6andnmqtoAKQ+J0lVaqyTyOZGWuR4dzpNesB1Wm/gksn3mFNUj7nRCgxSif2z1w5dXuBdMu3vjY2JI3aF3HaJ36NGnvRstgNJG/K7Ey1shqYGo5200BEyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqXayCpt53ACV0ax15rf5ZLYbVYV089JicTevL9i+FA=;
 b=ILJHVktkTF30t8cfjN+uS8urCGQXRnzKDi5E31f/MaaQYjs8gyzgH9eYcYMu+hinSJY59OFBeGtNrERbaNtmrVAyX84cwcrGFUlXrooEuTngS/G0TuyaLalDHgbxqpnjKZv1XzdnF6WENHQ7MHzJ5v+h1TllzEigz49/GzgIxXByhjlO803TIdaKacHuTuOzg4hp39twVbaSzk7UmZOfG6XPgGQq9OHXoV0sBDoPpk7Oi6SxyvzTumP/W7C6AsOPWvupcAvwtotEUqKCpcklVU1KHGR37dJU/3NjdOGSJZem91wvp5soSDSDg7gL7nz1jcgMGfIjXS7Z+UGIuCltOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqXayCpt53ACV0ax15rf5ZLYbVYV089JicTevL9i+FA=;
 b=pC3kvzxGQ1H90RJ8G7fAPWjZC9Kjv/vQskQTN1GISmpH+cYNgtqAlcb871kJOStcPsLYbvTbLvvT2SYuW3BgFYo9ZKfQycutbcrPsZi6prxkbOuFxbZr43T1tk3uACmHLynlhLwz9S0qgss26dBw+NTuw+NhxnnWUoEBVEnHEGI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB4951.namprd04.prod.outlook.com (2603:10b6:a03:4f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Tue, 13 Sep 2022 10:57:44 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 10:57:44 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Thread-Topic: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Thread-Index: AQHYx1+mi+gGx0U0bUWL/QGUEuZ50A==
Date:   Tue, 13 Sep 2022 10:57:44 +0000
Message-ID: <20220913105743.gw2gczryymhy6x5o@shindev>
References: <20220913065758.134668-1-dwagner@suse.de>
In-Reply-To: <20220913065758.134668-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BYAPR04MB4951:EE_
x-ms-office365-filtering-correlation-id: dfe04b9c-ad9d-485b-aafd-08da9576c94b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d6kuEJlNAYY9sF9kyT0akIOaS+O0hhmg90sUre6NwGcNHq5M3wc00Ol+/C5Lb99LVoXSoLLzyD4Gx+15259Zm8J06Fhdxa9jXOj/IfKaOUGhovUzEJurupQbECixu69/+x4DbRBK7CxhhuIAnW8wj21ptnRosEqwS7aVXJinvravJYWeaIFN+IJ/FYWD08GUeEXlyhkLZZJAWzhN5IqhT98u17PMW2uTToltggwU5e+Fm39+NqSUdjDyz7QLJLZ6iTrdWUSqT25rm8dzC7TQoGQhECIG5EUImwGLlv/0gMsL3XMCJHRFDUE774Nn31AZM0yTfTXPrtRFnODSMq7yHW4UXbrYplRRky4JwNbbKiDKF/WLFlPwuUpaHIcUFXvY8ploS1rVwYmub7BU/mo2nL4HnO3d/q1KcqZGCWwzr3JRQ5ujZ8cXLkSdWkZ6I1e4+VLaj+5ipqUgpHmp62Wg1XDTq+t7Xl7NSy89KK7JhbYYObv2Wp+v27zntsOKnjGanBGVZVFP+J3d5p2nr90iuk5LuK9miq5d7YpXC21uH++zD6WYTRCutpUmeGOeT59bt4YypQV2+XBMCwZ1IfIW51pi+wzQmjiIP86aHG78evqMY+DcdfFb8uGyMsjE17Ss+ZeJQOasJ0FsEAftp0cTkO390xicDYVbL3VkHiKykupsL/+Xc6mKhBi4OaCkZImSXNK+RG8zEnBUYDWkQgJksjaAvEZEoRBFEYB0Mjvlnw7HmRRUyCuwZY27Trnwgni8doEaO7mnvSa+H5NCkKX29A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(82960400001)(26005)(8676002)(41300700001)(71200400001)(6512007)(9686003)(122000001)(478600001)(6486002)(4326008)(5660300002)(76116006)(66476007)(1076003)(316002)(2906002)(86362001)(66946007)(33716001)(83380400001)(64756008)(91956017)(66556008)(6916009)(38100700002)(8936002)(66446008)(54906003)(6506007)(38070700005)(44832011)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jAxGsBFnTpbh5GkC1o7x9+aXS9sDXHmdw6bNCmrbYqEXGX7rmqid4qBifuNM?=
 =?us-ascii?Q?RNkd6l8+G+hYTzbcMmLGyCKz4BjiGH9KmTxlTP+GnsSq7bu7rD/EOiBwwH1K?=
 =?us-ascii?Q?UQukurIhksn2WKkQ65mhXdI4tHkJQXpeCz3dLDvevmfI/J5EiftX0CmVMTsG?=
 =?us-ascii?Q?kDVwFPL7uh6C7hNuYRe609BYyM6tycEjw6hO/e4LtEezHPgtRPwLQ0C1NN+9?=
 =?us-ascii?Q?3DA4hh/d6HUGd8VIbYI2zIFxQq4NeN3/MqogKkcZ3j2Qi80/lmboDtaOYYDA?=
 =?us-ascii?Q?3odThvx21AuzyCXuASWp2K3mYB/7J9DyT8laoz4ivFnA2L7M8m9TrO9l0JGO?=
 =?us-ascii?Q?WlFhseZSKBy+ceP5YfDER+wxEiEtJhAp4+C1HZQMGRZx9P85QSt/s+VWjnVZ?=
 =?us-ascii?Q?0wgB+Wwq0vqjavE3X1IcuKOFj0jhrH24bGKIUjabPk/exjN3nB8yJxZ0esVe?=
 =?us-ascii?Q?atsPYVSL+iW4Krwi99FQ7i2qVWTs2YNTfAJmbaF8s5OEQSCkSbp97m6tXH5Q?=
 =?us-ascii?Q?BjOu8P3IWEv09Y8JzfautQ3sO1097jH/ldlXzIjG94y51zh1E2sZHUnRWkWe?=
 =?us-ascii?Q?qB8r2Y2+7qtQdB8S6X4Sc/AJyMfaiKNriV6cK9ow/0ltGvv5fRYwBKvgIK3y?=
 =?us-ascii?Q?Zi/3bc1vEbcdUYn0pt/s+3SvRHU6Dul/51k5YsWOjpFwdWvjlu4D3fS6JlA3?=
 =?us-ascii?Q?ukduniQUMHmOJX5tP0AiNYT5cWmQ3INH9tpC9+qOOPAjjLgEgIw8UMdv/enA?=
 =?us-ascii?Q?WbgW5YuvOIVL5+CHtV/Xo35Y/vMykB0P6lNmUoiHzaZ5SUdBi8DMe6HX+2Mv?=
 =?us-ascii?Q?M4evCc/tYQvSHXqq4pNeHPOuxyJtp59ToNAS7q5gymjzu9zVhlhiyeTzaipz?=
 =?us-ascii?Q?Z8oHz7pyPH96E1P8IomEZNuebSxDdU3wwO9AIvZxhXe3s0cCfEaGYiCB3wo0?=
 =?us-ascii?Q?hUQMjsrcZQZ5agTqqrNYeKD7TeJz536sHpHZLaf4tI7XPiyAm5nlPlwA33VO?=
 =?us-ascii?Q?6N25H5ZXoQy2s9+ZOaWezrtJon0NXF8L+lLN8sIz5ygdijp4F2V1wcsuRKet?=
 =?us-ascii?Q?UZR2137LVwZu/1uLv+AQgEdD1i/UUVABrIGRUMy1JzxEESQ2i5hHEWUVtwhK?=
 =?us-ascii?Q?S/7fCnn8GDnstBElAkXf1joer++PO5D4RH+XHMBVC2lGMVCJw8PZOCmfq78E?=
 =?us-ascii?Q?ANjViO0WsLkxfAZg0FKxJEaGi+qcmHcCFaExetUVClyDR346QFeqeivQAIcx?=
 =?us-ascii?Q?lnL/sGzfd3vW2C/twa/qMJLv+u7qafx4WOJsrLiQGzKVSC/GwMwE2uHN3Wll?=
 =?us-ascii?Q?LuNcFNQ6T+6j5vq5HKlziWmGXxBX6UkTeAxsZrSuFPVA/6GaDmx8uXx0XfQh?=
 =?us-ascii?Q?6ELe4y6FxoNtrLRB9U4m9Xzv0uv9DmQTRqqibAEBimVtNsMbB7A+pqd8MxXx?=
 =?us-ascii?Q?093MRZRA3tKkcK9mmXonHaTAaJ3lheXpevU7K/COesSAzEx0qf21CxvaOJOC?=
 =?us-ascii?Q?xMziviRwaacMM7sgKLcd41G/jqLk6a1DagSJlgFmm0xoGtH2zub7IH7kiO1n?=
 =?us-ascii?Q?0vvgZR170xpG3JpnxAYTbVAmzEvLDiJqbUEa53P6DqaEruOQgmjwZDAEIMLu?=
 =?us-ascii?Q?azZ41f66Qi0M7ywsF/5O/Ts=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC5D9A1CB77F1B4C8AE464122FDFED99@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe04b9c-ad9d-485b-aafd-08da9576c94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 10:57:44.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9xpllTzwlG6TU4Ur+c2bBOULH+wnsjP94ir1JLYuO172OsT8sf9ArMQLcgtGAlE+MadhPr3fiNwb/HRqN1btL/Itkb8pbvt4YGZS3H/EXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4951
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sep 13, 2022 / 08:57, Daniel Wagner wrote:
> The target is allowed to change the number of I/O queues. Test if the
> host is able to reconnect in this scenario.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> I've send a fix for the bug reported in nvmet_subsys_attr_qid_max_show()

Thanks!

>=20
> Though I have found another problem with this test:
>=20
>  nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for =
NQN nqn.2014-08.org.nvmexpress:uuid:.
>  nvme nvme0: creating 8 I/O queues.
>  nvme nvme0: mapped 8/0/0 default/read/poll queues.
>  nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 10.161.61.228:442=
0
>  nvme nvme0: starting error recovery
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: possible circular locking dependency detected
>  6.0.0-rc2+ #26 Not tainted
>  ------------------------------------------------------
>  kworker/6:6/17471 is trying to acquire lock:
>  ffff888103d76440 (&id_priv->handler_mutex){+.+.}-{3:3}, at: rdma_destroy=
_id+0x17/0x20 [rdma_cm]
> =20
>  but task is already holding lock:
>  ffffc90002497de0 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, =
at: process_one_work+0x4ec/0xa90
> =20
>  which lock already depends on the new lock.
>=20
> =20
>  the existing dependency chain (in reverse order) is:
> =20
>  -> #3 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
>         process_one_work+0x565/0xa90
>         worker_thread+0x2c0/0x710
>         kthread+0x16c/0x1a0
>         ret_from_fork+0x1f/0x30
> =20
>  -> #2 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
>         __flush_workqueue+0x105/0x850
>         nvmet_rdma_cm_handler+0xf9f/0x174e [nvmet_rdma]
>         cma_cm_event_handler+0x77/0x2d0 [rdma_cm]
>         cma_ib_req_handler+0xbd4/0x23c0 [rdma_cm]
>         cm_process_work+0x2f/0x210 [ib_cm]
>         cm_req_handler+0xf73/0x2020 [ib_cm]
>         cm_work_handler+0x6d6/0x37c0 [ib_cm]
>         process_one_work+0x5b6/0xa90
>         worker_thread+0x2c0/0x710
>         kthread+0x16c/0x1a0
>         ret_from_fork+0x1f/0x30
> =20
>  -> #1 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
>         __mutex_lock+0x12d/0xe40
>         cma_ib_req_handler+0x956/0x23c0 [rdma_cm]
>         cm_process_work+0x2f/0x210 [ib_cm]
>         cm_req_handler+0xf73/0x2020 [ib_cm]
>         cm_work_handler+0x6d6/0x37c0 [ib_cm]
>         process_one_work+0x5b6/0xa90
>         worker_thread+0x2c0/0x710
>         kthread+0x16c/0x1a0
>         ret_from_fork+0x1f/0x30
> =20
>  -> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
>         __lock_acquire+0x1a9d/0x2d90
>         lock_acquire+0x15d/0x3f0
>         __mutex_lock+0x12d/0xe40
>         rdma_destroy_id+0x17/0x20 [rdma_cm]
>         nvmet_rdma_free_queue+0x54/0x180 [nvmet_rdma]
>         nvmet_rdma_release_queue_work+0x2c/0x70 [nvmet_rdma]
>         process_one_work+0x5b6/0xa90
>         worker_thread+0x2c0/0x710
>         kthread+0x16c/0x1a0
>         ret_from_fork+0x1f/0x30
> =20
>  other info that might help us debug this:
>=20
>  Chain exists of:
>    &id_priv->handler_mutex --> (wq_completion)nvmet-wq --> (work_completi=
on)(&queue->release_work)
>=20
>   Possible unsafe locking scenario:
>=20
>         CPU0                    CPU1
>         ----                    ----
>    lock((work_completion)(&queue->release_work));
>                                 lock((wq_completion)nvmet-wq);
>                                 lock((work_completion)(&queue->release_wo=
rk));
>    lock(&id_priv->handler_mutex);

I also observe this WARNING on my test machine with nvme_trtype=3Drdma. It =
looks a
hidden rdma issue for me...

>=20
> And there is the question how to handle the different kernel logs output:
>=20
> c740:~/blktests # nvme_trtype=3Dtcp ./check nvme/046
> nvme/046 (Test queue count changes on reconnect)             [passed]
>     runtime  32.750s  ...  32.340s
> c740:~/blktests # nvme_trtype=3Drdma ./check nvme/046
> nvme/046 (Test queue count changes on reconnect)             [failed]
>     runtime  32.340s  ...  24.716s
>     something found in dmesg:
>     [307171.053929] run blktests nvme/046 at 2022-09-13 08:32:07
>     [307171.884448] rdma_rxe: loaded
>     [307171.965507] eth0 speed is unknown, defaulting to 1000
>     [307171.967049] eth0 speed is unknown, defaulting to 1000
>     [307171.968671] eth0 speed is unknown, defaulting to 1000
>     [307172.057714] infiniband eth0_rxe: set active
>     [307172.058544] eth0 speed is unknown, defaulting to 1000
>     [307172.058630] infiniband eth0_rxe: added eth0
>     [307172.107627] eth0 speed is unknown, defaulting to 1000
>     [307172.230771] nvmet: adding nsid 1 to subsystem blktests-feature-de=
tect
>     ...
>     (See '/root/blktests/results/nodev/nvme/046.dmesg' for the entire mes=
sage)
> c740:~/blktests # nvme_trtype=3Dfc ./check nvme/046
> nvme/046 (Test queue count changes on reconnect)             [failed]
>     runtime  24.716s  ...  87.454s
>     --- tests/nvme/046.out      2022-09-09 16:23:22.926123227 +0200
>     +++ /root/blktests/results/nodev/nvme/046.out.bad   2022-09-13 08:35:=
03.716097654 +0200
>     @@ -1,3 +1,89 @@
>      Running nvme/046
>     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
>     +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or direc=
tory
>     +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or direc=
tory
>     +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or direc=
tory
>     +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or direc=
tory
>     +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or direc=
tory
>     ...
>     (Run 'diff -u tests/nvme/046.out /root/blktests/results/nodev/nvme/04=
6.out.bad' to see the entire diff)
>=20
> The grep error is something I can fix in the test but I don't know how
> to handle the 'eth0 speed is unknown' kernel message which will make
> the test always fail. Is it possible to ignore them when parsing the
> kernel log for errors?

FYI, each blktests test case can define DMESG_FILTER not to fail with speci=
fic
keywords in dmesg. Test cases meta/011 and block/028 are reference use case=
s.

Having said that, I don't think 'eth0 speed is unknown' in dmesg makes the =
test
case fail. See _check_dmesg() in "check" script, which lists keywords that
blktests handles as errors. I guess the WARNING above is the failure cause,
probably.

--=20
Shin'ichiro Kawasaki=
