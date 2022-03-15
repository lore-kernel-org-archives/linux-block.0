Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DECBC433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 11:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbiCOLLr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345625AbiCOLLq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 07:11:46 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1054F9E1
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647342631; x=1678878631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ShaqmphVfmKwfM4q72bP1kM4eH/elOgV5lYWzyvYbWE=;
  b=bO/5+kJDk65EDjgl3TM0517cN8ZUef2oBa3z7SsBb8Vp2g/TpMHALi7p
   bBlG7KX83Kp5PHg5S5rPk5ls2hy/EVB9QWqf2s7hV4Boc5/uMd0DBRsJz
   TRIJtbkpinEI3Pb4jEBAJjm5R/ijs55HD+cNKFooazjUgXDIPWYi9uAeZ
   gRKPX65Q4u2sZpMwJ/Y9SRkgIN2QwVVVQqpqZ/t8HAvgTkBL57wsusvVJ
   gmGuT3/Xsg7x6pWxWdOWczZ3vSA1grgy7JgRfgtP7Km3qtowMda0ZsGZy
   IDXD3OEZRrxl5yqgzHSF2v2pE6TESRBcqkOGlXMlnWzo6NWAkcPv20EH4
   A==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; 
   d="scan'208";a="195402494"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 19:10:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrlOjvwXaPgvfvAO8c1NyKE4SeBJIHxLd+xS4sw70IzlO2w3bJUjSBE5zqrxQMZXLXgdCsxDWSulK8JH6Vs4Cy6tcob5onts8seC+TQmnMi93ea8rqKdXiudTtyNuab1328khSXpPyxECc/Q9JBx3lQ7jIARC0stRMSzOLUiY4n6IvphONm8djhwu6GVMPIYMcu8mGiMaYD984hgQXwdnuYvb7z1y6hllRI8dc1M9xabK/oCSB3FrgDvTLp/HMmqJ1Kud2wS4HECuvUzWWqjPAeeZac/hhS7ZZ3glxgThWa/W5dxPKhsqJWHuM+vi3zFITo/EoTSxcgpxgJnClG0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0gqlAKAMJLBPPE4Uvf8IMRPXA9M0vCtW7oFsvhIeME=;
 b=F3A3uXhRfaavJ+iyVCa5WcRE+5hx+kmbtV+LuuHciS+s5lBs7fyWSBv6H7PJ5P8O7VZzQsQRFpMw6Qh6HM4mzAgVgRkUACRraauXlqtKPOZW9EXK9IVaBwmef+WJyx6eAJN7K46t2to/ta00GijSfnoJoETe5vPlp6rBE7QzRdXbGHfrgpClfKF2CqK+ibuNkq84vZRgnbPD4poVWcdJcC53s+WTIrbjYhqPk9yCM8Q/EbNLsB/lynGcDv04SyffmO/IUzmN/WJbHIq3ONOYD9zDJWJ7HkwTzCPqzLIghbvZcP23UENb78M8pYljtBwmpZB8Uc/1d2omlNivlYgiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0gqlAKAMJLBPPE4Uvf8IMRPXA9M0vCtW7oFsvhIeME=;
 b=I5b3Nf+e2zXJPsl9awrV5PlfVdtPe4HOXdU0kxtfAJb8vQl39HAr3D7sD8DKzVt/OoiksKHlMLWDgtcIGH4LxoRVxlFQxEIWRf39E6aqIJpnRb2aXqYHmbYJ1hdbMeQKI6DQaJjhuMXA6kSVUTJwnRoXMBR2D/wS9A0gsDVMzhM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB3785.namprd04.prod.outlook.com (2603:10b6:5:af::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.21; Tue, 15 Mar 2022 11:10:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 11:10:29 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Topic: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Index: AQHYNF+T3Cwh4555b06Tjj5eYItVAKy4YrkAgAAsjICAAAHeAIABJ3+AgAA5uACABGx7AIAAGrEAgAF3oICAAAzTgIAAU9UA
Date:   Tue, 15 Mar 2022 11:10:29 +0000
Message-ID: <20220315111028.i47qcfi65ukzjbmh@shindev>
References: <20220310091649.zypaem5lkyfadymg@shindev> <YinMWPiuUluinom8@T590>
 <20220310124023.tkax52chul265bus@shindev>
 <a6d6b858-4bee-10da-884c-20b16e4ad0de@kernel.dk>
 <20220311062441.vsa54rie5fxhjtps@shindev> <YisblCKgf6xC0/ai@T590>
 <20220314052434.zud5zb5wqrjljk4b@shindev> <Yi7n9mgblKcC7msM@T590>
 <20220315052431.zhj6d7srkhjudiua@shindev> <YjAt0adsedXWldSI@T590>
In-Reply-To: <YjAt0adsedXWldSI@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e61be074-1392-45b3-3f1d-08da06746a71
x-ms-traffictypediagnostic: DM6PR04MB3785:EE_
x-microsoft-antispam-prvs: <DM6PR04MB3785BEB3FDF2B4038599DAD8ED109@DM6PR04MB3785.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EaP4g3v7wMWfirNmnz6X0iNoyI3JA0EiuPhoN9wG0mhmZhPy154ZP3YzQfMt+cQMszrSGCoWRwKNwUwiNElTlhjtpBTc+XoiIwaWsc/6ucy4LYrqMNr9Xc/0NJQvqkzqTQwI7scotcVYIOeF8vVAYEXqfBMmKQ7+7YsRmuf1txdU5RJFfB6a09mC0awqf/2ucRS5bg997smaGWukr86+twFjawG+JmKQ7Yt0fR1o6Bc91IE86kIG/mg9OvQsWaVw4y2qnQpZ/0cRzcozfhRtDPvtxx3GSt+Tu4P3AYCMfq5E8iTdhYMPB7oF6xZxlJTMMDn6gkp5IFc4mriTxsljkijW11rDtebLctAnrMNKjWs/KaNakGclm6R8O2JDYva/JrgNYpEFoWpwXfg82behyIwrNbwnXpoe7w61MMPrx1xlTmzpfwf6tp+hWQfJ5ZAxcaE46Pi0zQa/JykKcRujD7YDFrhp38UizifBzPlEwxou2qyNkObC7/YZs0JahpsOVG3ykrN2sZzfjX6vk2efV7F5I7CbVPtv+1q/LmZ+FbaxlKYvs8YSSBBONcgjg6eYJKsVuxy8DpYb6C9KCvBw4/lu6+mlLScYjt422zB3rQAKrjz0NNcH2K4+1EATxHqCXJay64Z/3u2X8XjoHIBIlzJaUHAHu/SUjJ0DQu+I5ewzMulJhUxRzbYIBPKNORgroKO9T1f28Fq9XL+Cy9BEcxr210hlyVR8QeWOvXAWQY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(2906002)(122000001)(82960400001)(6506007)(38100700002)(53546011)(30864003)(8936002)(5660300002)(44832011)(6512007)(9686003)(86362001)(33716001)(1076003)(26005)(186003)(83380400001)(6916009)(66556008)(316002)(54906003)(66476007)(66446008)(66946007)(76116006)(64756008)(6486002)(91956017)(8676002)(38070700005)(4326008)(508600001)(71200400001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MMTr0AFQLKf5vt3yMp0+in81CFXCAsHeTiN+xDz5vPf51aK5KIwA2Jcsj1SA?=
 =?us-ascii?Q?+O0+WfQpP6mo7qX6N+0tQ7jLC3ESVfBtSdbXF2hs25sN4SLM3uxo2ALcNoU9?=
 =?us-ascii?Q?5OzSe1j5LfCGrXlqYaZZHYZpvb0MKbixDjfsBcq1ULUWH8htH5gqZq4etRva?=
 =?us-ascii?Q?jcd69TWO1pXZbM7ePoyDxypuywZbVL4eTY9zV6sfaePJRRK1iG7H/IXR7nN7?=
 =?us-ascii?Q?ez2ex5NIiulsv+sYwlqqqVCBO6/UB7lxWeLK7uSyIKkO0KRV7tAGINVQDbjg?=
 =?us-ascii?Q?9D9tgei4yT+zcmG12ak11vaAQmVVOqpaYsNq9dW1BU0fyfwX0ibLcQLURLH9?=
 =?us-ascii?Q?JqFrELLy+ZV2MUlluEzSGylThqgsXEH4OdC4zkSjM29ikB9x3kacBWeSI+OE?=
 =?us-ascii?Q?AxnjjVi8eXALTIJcZLgAtGVYGzpOZ25jJXrDahH+W3v5OusiDFhs2KzgThMd?=
 =?us-ascii?Q?Tg7SEpO8YHA1KsXoMa0M3os6RHFNATsPVQlpmItgmGAERh5jDEKcmSmWFqgO?=
 =?us-ascii?Q?8ORvJF9NrOTcXaAbUuKMo8xMtZfD1nYhFODtvEAnlNlgq9A2nYjr1e8MAf6W?=
 =?us-ascii?Q?3TMDZ8fEraXTDmtl0GBYeC9vfgUUNXYlWwGqcYDcbZDa32oeca41Sc5d9M4d?=
 =?us-ascii?Q?PoIpITC21Wow3s98fiUFI3m/WA96gKSWEjO3sWr3nHxP1wcAYKLcV6sRuOsP?=
 =?us-ascii?Q?HNwCeEhb4Rrx1MdfGrdM6y058P50b1KNB18wNzT/y4ni4xAFS9/cIy1lhq5A?=
 =?us-ascii?Q?82pBZOoZ1PKLXcgJ4ShdGpN2K/dWv8mvzY3T8dp6skpzb/ULli1a43cxVi+/?=
 =?us-ascii?Q?NzullohoIqrbhE5UunI8ZRPTofxoB+X2GFuIv8KXu3O0rwuQE5RnVDi8sHBh?=
 =?us-ascii?Q?irBFd0qV5RyHU79HetD8rfBgek9OlVxEH8ZWcZio6CTCawJyYcbixrBJ6FFN?=
 =?us-ascii?Q?ecCNMw4I1e7l4RIfzO/3wmd8RXMQu8lK+lhekUbbXy94EXPhddY/4i8sqoG6?=
 =?us-ascii?Q?MPRSatAJ+xtVJDvvxQqymz589Dn5lkej4WinrbdlXHsqBv24tQYOj2cx/SGp?=
 =?us-ascii?Q?zLuyLTgtrGWU8FOujw/DYimn9svOo/hbc1SnXqQEuFykIuwbNwHZgL2DHnUE?=
 =?us-ascii?Q?eWqFKyJkiAvY0mhf6qraFBcAXqAaaHJWwP4h9KauW66PKM+G6GklsVw/k0My?=
 =?us-ascii?Q?+tubXL1QqJFuors0N01K+zYee9YopLkseMacFiPq8UMcUTGRKmXLoI1q16+W?=
 =?us-ascii?Q?D6sAPpT+6e1rtq1w84rtMCxporxhshZ81JoC7inwYyR92gQNjp1YPR2pkp8r?=
 =?us-ascii?Q?0WbNRoqu9SmAx9m05YsLGWoA+rUPwGsTvIrYhFodrblR/4TD3ESUOQJC+kUI?=
 =?us-ascii?Q?OMmzSSLGAKcNcodbk9FJUyiEiRCylGRxh4rvi+E2yCMToj5ewbM5OWbxH9qC?=
 =?us-ascii?Q?TIej/aJZ8rFEPp1d7MZgNEg8EaPLhklcqLqS+sOJ+ndH5h4TY86dHZeeRbHJ?=
 =?us-ascii?Q?YVEg0+e0tKNV/Wc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5893C23321CA041A426692A60C288EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61be074-1392-45b3-3f1d-08da06746a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 11:10:29.4388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbTfmqlFLSiXj3zCFBUJOBZ+cPz36mHCiHozV5h0XQnxFviq3x+03KCW7m0WJMYbSepPE+WT9BAak1VrZeFTEoku4V9o5XeroKkMDuT03mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3785
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 15, 2022 / 14:10, Ming Lei wrote:
> On Tue, Mar 15, 2022 at 05:24:32AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 14, 2022 / 15:00, Ming Lei wrote:
> > > On Mon, Mar 14, 2022 at 05:24:34AM +0000, Shinichiro Kawasaki wrote:
> > > > On Mar 11, 2022 / 17:51, Ming Lei wrote:
> > > > > On Fri, Mar 11, 2022 at 06:24:41AM +0000, Shinichiro Kawasaki wro=
te:
> > > > > > On Mar 10, 2022 / 05:47, Jens Axboe wrote:
> > > > > > > On 3/10/22 5:40 AM, Shinichiro Kawasaki wrote:
> > > > > > > > On Mar 10, 2022 / 18:00, Ming Lei wrote:
> > > > > > > >> On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawas=
aki wrote:
> > > > > > > >>> This issue does not look critical, but let me share it to=
 ask comments for fix.
> > > > > > > >>>
> > > > > > > >>> When fio command with 40 jobs [1] is run for a null_blk d=
evice with memory
> > > > > > > >>> backing and mq-deadline scheduler, kernel reports a BUG m=
essage [2]. The
> > > > > > > >>> workqueue watchdog reports that kblockd blk_mq_run_work_f=
n keeps on running
> > > > > > > >>> more than 30 seconds and other work can not run. The 40 f=
io jobs keep on
> > > > > > > >>> creating many read requests to a single null_blk device, =
then the every time
> > > > > > > >>> the mq_run task calls __blk_mq_do_dispatch_sched(), it re=
turns ret =3D=3D 1 which
> > > > > > > >>> means more than one request was dispatched. Hence, the wh=
ile loop in
> > > > > > > >>> blk_mq_do_dispatch_sched() does not break.
> > > > > > > >>>
> > > > > > > >>> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx =
*hctx)
> > > > > > > >>> {
> > > > > > > >>>         int ret;
> > > > > > > >>>
> > > > > > > >>>         do {
> > > > > > > >>>                ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > > > > > >>>         } while (ret =3D=3D 1);
> > > > > > > >>>
> > > > > > > >>>         return ret;
> > > > > > > >>> }
> > > > > > > >>>
> > > > > > > >>> The BUG message was observed when I ran blktests block/00=
5 with various
> > > > > > > >>> conditions on a system with 40 CPUs. It was observed with=
 kernel version
> > > > > > > >>> v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593=
fbbc245 ("null_blk:
> > > > > > > >>> poll queue support"). This commit added blk_mq_ops.map_qu=
eues callback. I
> > > > > > > >>> guess it changed dispatch behavior for null_blk devices a=
nd triggered the
> > > > > > > >>> BUG message.
> > > > > > > >>
> > > > > > > >> It is one blk-mq soft lockup issue in dispatch side, and s=
houldn't be related
> > > > > > > >> with 0a593fbbc245.
> > > > > > > >>
> > > > > > > >> If queueing requests is faster than dispatching, the issue=
 will be triggered
> > > > > > > >> sooner or later, especially easy to trigger in SQ device. =
I am sure it can
> > > > > > > >> be triggered on scsi debug, even saw such report on ahci.
> > > > > > > >=20
> > > > > > > > Thank you for the comments. Then this is the real problem.
> > > > > > > >=20
> > > > > > > >>
> > > > > > > >>>
> > > > > > > >>> I'm not so sure if we really need to fix this issue. It d=
oes not seem the real
> > > > > > > >>> world problem since it is observed only with null_blk. Th=
e real block devices
> > > > > > > >>> have slower IO operation then the dispatch should stop so=
oner when the hardware
> > > > > > > >>> queue gets full. Also the 40 jobs for single device is no=
t realistic workload.
> > > > > > > >>>
> > > > > > > >>> Having said that, it does not feel right that other works=
 are pended during
> > > > > > > >>> dispatch for null_blk devices. To avoid the BUG message, =
I can think of two
> > > > > > > >>> fix approaches. First one is to break the while loop in b=
lk_mq_do_dispatch_sched
> > > > > > > >>> using a loop counter [3] (or jiffies timeout check).
> > > > > > > >>
> > > > > > > >> This way could work, but the queue need to be re-run after=
 breaking
> > > > > > > >> caused by max dispatch number. cond_resched() might be the=
 simplest way,
> > > > > > > >> but it can't be used here because of rcu/srcu read lock.
> > > > > > > >=20
> > > > > > > > As far as I understand, blk_mq_run_work_fn() should return =
after the loop break
> > > > > > > > to yield the worker to other works. How about to call
> > > > > > > > blk_mq_delay_run_hw_queue() at the loop break? Does this re=
-run the dispatch?
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > > > > index 55488ba978232..faa29448a72a0 100644
> > > > > > > > --- a/block/blk-mq-sched.c
> > > > > > > > +++ b/block/blk-mq-sched.c
> > > > > > > > @@ -178,13 +178,19 @@ static int __blk_mq_do_dispatch_sched=
(struct blk_mq_hw_ctx *hctx)
> > > > > > > >  	return !!dispatched;
> > > > > > > >  }
> > > > > > > > =20
> > > > > > > > +#define MQ_DISPATCH_MAX 0x10000
> > > > > > > > +
> > > > > > > >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *=
hctx)
> > > > > > > >  {
> > > > > > > >  	int ret;
> > > > > > > > +	unsigned int count =3D MQ_DISPATCH_MAX;
> > > > > > > > =20
> > > > > > > >  	do {
> > > > > > > >  		ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > > > > > > -	} while (ret =3D=3D 1);
> > > > > > > > +	} while (ret =3D=3D 1 && count--);
> > > > > > > > +
> > > > > > > > +	if (ret =3D=3D 1 && !count)
> > > > > > > > +		blk_mq_delay_run_hw_queue(hctx, 0);
> > > > > > > > =20
> > > > > > > >  	return ret;
> > > > > > > >  }
> > > > > > >=20
> > > > > > > Why not just gate it on needing to reschedule, rather than so=
me random
> > > > > > > value?
> > > > > > >=20
> > > > > > > static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hct=
x)
> > > > > > > {
> > > > > > > 	int ret;
> > > > > > >=20
> > > > > > > 	do {
> > > > > > > 		ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > > > > > 	} while (ret =3D=3D 1 && !need_resched());
> > > > > > >=20
> > > > > > > 	if (ret =3D=3D 1 && need_resched())
> > > > > > > 		blk_mq_delay_run_hw_queue(hctx, 0);
> > > > > > >=20
> > > > > > > 	return ret;
> > > > > > > }
> > > > > > >=20
> > > > > > > or something like that.
> > > > > >=20
> > > > > > Jens, thanks for the idea, but need_resched() check does not lo=
ok working here.
> > > > > > I tried the code above but still the BUG message is observed. M=
y guess is that
> > > > > > in the call stack below, every __blk_mq_do_dispatch_sched() cal=
l results in
> > > > > > might_sleep_if() call, then need_resched() does not work as exp=
ected, probably.
> > > > > >=20
> > > > > > __blk_mq_do_dispatch_sched
> > > > > >   blk_mq_dispatch_rq_list
> > > > > >     q->mq_ops->queue_rq
> > > > > >       null_queue_rq
> > > > > >         might_sleep_if
> > > > > >=20
> > > > > > Now I'm trying to find similar way as need_resched() to avoid t=
he random number.
> > > > > > So far I haven't found good idea yet.
> > > > >=20
> > > > > Jens patch using need_resched() looks improving the situation, al=
so the
> > > > > scsi_debug case won't set BLOCKING:
> > > > >=20
> > > > > 1) without the patch, it can be easy to trigger lockup with the
> > > > > following test.
> > > > >=20
> > > > > - modprobe scsi_debug virtual_gb=3D128 delay=3D0 dev_size_mb=3D20=
48
> > > > > - fio --bs=3D512k --ioengine=3Dsync --iodepth=3D128 --numjobs=3D4=
 --rw=3Drandrw \
> > > > > 	--name=3Dsdc-sync-randrw-512k --filename=3D/dev/sdc --direct=3D1=
 --size=3D60G --runtime=3D120
> > > > >=20
> > > > > #sdc is the created scsi_debug disk
> > > >=20
> > > > Thanks. I tried the work load above and observed the lockup BUG mes=
sage on my
> > > > system. So, I reconfirmed that the problem happens with both BLOCKI=
NG and
> > > > non-BLOCKING drivers.
> > > >=20
> > > > Regarding the solution, I can not think of any good one. I tried to=
 remove the
> > > > WQ_HIGHPRI flag from kblockd_workqueue, but it did not look affecti=
ng
> > > > need_resched() behavior. I walked through workqueue API, but was no=
t able
> > > > to find anything useful.
> > > >=20
> > > > As far as I understand, it is assumed and expected the each work it=
em gets
> > > > completed within decent time. Then this blk_mq_run_work_fn must sto=
p within
> > > > decent time by breaking the loop at some point. As the loop break c=
onditions
> > > > other than need_resched(), I can think of 1) loop count, 2) number =
of requests
> > > > dispatched or 3) time spent in the loop. All of the three require a=
 magic random
> > > > number as the limit... Is there any other better way?
> > > >=20
> > > > If we need to choose one of the 3 options, I think '3) time spent i=
n the loop'
> > > > is better than others, since workqueue watchdog monitors _time_ to =
check lockup
> > > > and report the BUG message.
> > >=20
> > > BTW, just tried 3), then the lockup issue can't be reproduced any mor=
e:
> > >=20
> > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > index e6ad8f761474..b4de5a7ec606 100644
> > > --- a/block/blk-mq-sched.c
> > > +++ b/block/blk-mq-sched.c
> > > @@ -181,10 +181,14 @@ static int __blk_mq_do_dispatch_sched(struct bl=
k_mq_hw_ctx *hctx)
> > >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > >  {
> > >         int ret;
> > > +       unsigned long start =3D jiffies;
> > > =20
> > >         do {
> > >                 ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > -       } while (ret =3D=3D 1);
> > > +       } while (ret =3D=3D 1 && !need_resched() && (jiffies - start)=
 < HZ);
> > > +
> > > +       if (ret =3D=3D 1 && (need_resched() || jiffies - start >=3D H=
Z))
> > > +                blk_mq_delay_run_hw_queue(hctx, 0);
> > > =20
> > >         return ret;
> > >  }
> >=20
> > It sounds a good idea to check both need_resched() and 3) time spent in=
 the
> > loop. I also confirmed that this fix avoids the BUG message on the scsi=
_debug
> > workload as well as null_blk with memory backing. Looks good. For this
> > confirmation, I modified the hunk above to avoid duplicated checks [1].
> >=20
> > As for the loop break limit, I think HZ =3D 1 second is appropriate. Th=
e workqueue
> > watchdog checks lockup with duration 'wq_watchdog_thresh' defined in
> > kernel/workqueue.c. In the worst case, its number is 1, meaning 1 secon=
d. Then,
> > 1 second loop break in blk_mq_do_dispatch_sched() should avoid the BUG =
message.
> >=20
> > To reduce influence on the performance, it would be good to make this n=
umber
> > larger. One idea was to refer the wq_watchdog_thresh as the limit for t=
he loop
> > break. However, the variable is static and defined only when CONFIG_WQ_=
WATCHDOG
> > is enabled. So, I don't think block layer can refer it.
> >=20
> > Assuming this fix approach is ok, I would like to have a formal patch. =
Ming,
> > would your mind to create it? Or if you want, I'm willing to do that.
> >=20
> > [1]
> >=20
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 55488ba978232..64941615befc6 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -181,9 +181,15 @@ static int __blk_mq_do_dispatch_sched(struct blk_m=
q_hw_ctx *hctx)
> >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  {
> >  	int ret;
> > +	unsigned long end =3D jiffies + HZ;
> > =20
> >  	do {
> >  		ret =3D __blk_mq_do_dispatch_sched(hctx);
> > +		if (ret =3D=3D 1 &&
> > +		    (need_resched() || time_is_after_jiffies(end))) {
> > +			blk_mq_delay_run_hw_queue(hctx, 0);
> > +			break;
> > +		}
> >  	} while (ret =3D=3D 1);
>=20
> I am fine with this patch, so please prepare one formal patch and see
> if Jens and guys are fine with it.
>=20
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Tested-by: Ming Lei <ming.lei@redhat.com>

Okay, I will prepare the patch. Now I'm running regression test run for
confirmation, and plan to post the patch tomorrow.

I also confirmed that the BUG message is triggered on stable kernel v5.10.9=
6
using scsi_debug. The patch above can be applied to this stable kernel and
avoids the BUG. I will add Fixes tag for the commit 6e6fcbc27e778 ("blk-mq:
support batching dispatch in case of io"), so that the patch gets propagate=
d
to stable kernels.

--=20
Best Regards,
Shin'ichiro Kawasaki=
