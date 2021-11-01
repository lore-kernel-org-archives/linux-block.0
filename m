Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35D4C433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 08:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA06D60F46
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 08:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhKAIg7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 04:36:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3134 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhKAIg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 04:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635755663; x=1667291663;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=1CAwjQo0hcd/ioeNOXZ04h6S6pIm0YxAT2Znxwv1UVI=;
  b=LhPjW8ot84aWby35O2yF147vHV5F+q0F8MFFn5L9KzeJQecfrI/Z2QfH
   j5FfWMrvaiuZWmRtl4dF7NthheZTNSpC59qJFwt8yEeGoTxttq5ofQLxC
   5rXUmTutjN9zTnUULE8oBcwtL2MCEL0xZENZQnL3GAS3xvNhwHUKSP9C1
   tMQsPO+RmzJC1f7vMIdzjjeOBmry3SyaTV3QHY9Tej/49ytUPNDwnuwI6
   NU2vKp+t0zeP+Iy/jqEbshMcDzjiiTRM6iwgGbf0ih6t8XpW5zl+5j0Uq
   zw3UXgPR7NGrgpYbp1tPahUjYXxcd9c3q2Zs0Tb+qDH6cUMs06FOCLR2Y
   A==;
X-IronPort-AV: E=Sophos;i="5.87,198,1631548800"; 
   d="scan'208";a="183360315"
Received: from mail-dm6nam08lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2021 16:34:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWvt0WLYRPP3phP4liEoYkdq9Ti6v76ETOXTu91ONlUo6ZHKbI8ppfDiCx68iJBOyhA3YExNnC/N3m/Db7Kn+Xr1qaiybBm5o41zGtLf2Y5rvMlmGl2YknPei1qigqmToG3U59R1qIrkjf3JAzyIA9fDjsgfRL1Pmt++1dgVXbIgvpCd2AQ+W5LKv4uZngt+jQgf7yrwe1jL0/6L2w/+n0AIXu6oDhO0kn7I+scj9/rM7WIfN4alxDF5BKOfrDcP8zgmhh12iaUUoahmmuZW1trzYTu4Pqf0hxyfxLSpx5B8j79tzsGpr2v2VPlgxc8TkKfagVoG9AoTcm0dvI6vgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkyZ8jmpilEhxrTp8ebTu3/VemuHp3J4OYVJx03JICc=;
 b=YFwKR1BAlrqRsTcdzWf20PPWLBv+2M2MyTDHptuH3AkVdQQIHblk85dksn/xnPMWXeSFFCSENqYgqbehfmE90BmGzI5Z8Fo28G/JaehiZstkX6Tp43rgNyiaTiXh1spQ51FfxAEBOtAu/KbSTWhFWpwyfnoOKUNv9CGSpZqx+catEyHdAELbXMcVyoGbZVZ5P6IZ0Ig+MCth2kV7tqAGietOFnxpq2lt0LPAjMEragjvNDWsYxGqfI4mebMLIjD6jph5Clg9SwoMPFrhngS6fT3+Hejb12qCoGpSI6957c+7HHcT08EDI2tnHR7Dheiq+psp9VzHI0XbBjvNRgl8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkyZ8jmpilEhxrTp8ebTu3/VemuHp3J4OYVJx03JICc=;
 b=wss2pqEFsyjz3PWW8y2ybKYu5q+C5lR3QCJn/1hnSsrLIIj23XQSJd99StBjThOIEH36hu5tdZKmQus4bTQM48GsWZXUTUbaKMXpKcvmg2QsOz3vLuhmsdLbI+1LxwP1ep8kv5jhoZjsAk7c1Z1QuiXKw0xDTz7JGE66Xq+gg9o=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by SJ0PR04MB7374.namprd04.prod.outlook.com (2603:10b6:a03:290::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 08:34:18 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 08:34:18 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Topic: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Index: AQHXzvtCAnSg404Q90iJ/hTDak5dVg==
Date:   Mon, 1 Nov 2021 08:34:18 +0000
Message-ID: <20211101083417.fcttizyxpahrcgov@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 066240a1-689d-4321-105d-08d99d12654f
x-ms-traffictypediagnostic: SJ0PR04MB7374:
x-microsoft-antispam-prvs: <SJ0PR04MB73740000523C4D80FC60E623ED8A9@SJ0PR04MB7374.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1owY1c/ViuTu4HdlWfajuAhT8/zoIjRb7nBgKYemzkdTl/TsMIJl93r+lSDUHK3OHxDKeJifxab0EVm/3DWI0eN/OEegodsNiSSpOWGoUUGxwuwIcbsfwpA5FUjqVtsd4lnT8iFE2eQXDcH2JSjUD1fXAq1X2zMig7rUBSUzap+S8pvPHy9GSESAjqudWasbJphW2B5oVjUHPaPvARLinlDS7qW1rkxxITefZxIeO8i8Hgp6seHu2lldKLrINxYRsha1FwvPwenpcz7Or97f0r2jxImcdPqg0YZpx0I7teBMU+ERn25YFpHS9czt26/ZpbMgF58tcWuz4ZrbL0rXk7v4BVtCZeamZaUcr6Ce71C6KHUi1GNRHk42CaEHt/AEJSujGvpoHVOGtle2mtSN3XjhIhaqjcfVyEkqAE5gNp9HKyAB2fKxxYpAPkZxTkyHhWl5H3a8CchBY6OG6PE9VJxuai70Ka8BM3gBBwZP34EI/eJW/NDSvXm/Xw5UrUP/tTWgAUoumYERLJ/ttvLnyGUb3FczUpAPTaOQbcILr/Boqm2qdjVZJwB5jkJB905gfKukDwKlCvJVjze/YkijnfEMS3sSMEpMHHoC8V2QrdczVszU8SFje5GalkCPZzxtrsauKCnTXhyBina7OK9TQgobbAv3LaMwGD2NFFdF/gycIUC4PsaCFUGT/y1c1LQneJelMytXeKdnXvQ4KfocoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(33716001)(186003)(86362001)(83380400001)(6916009)(44832011)(8676002)(6486002)(3716004)(8936002)(2906002)(122000001)(38100700002)(1076003)(508600001)(316002)(71200400001)(66946007)(38070700005)(5660300002)(4326008)(6512007)(9686003)(66446008)(66476007)(91956017)(64756008)(66556008)(6506007)(54906003)(82960400001)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?egCsuTyfblXhbA78D6n8V1Xg/vhoJeb+cWncXsykqYrOvBVd6ByRMLmbADE9?=
 =?us-ascii?Q?tTZw4fVZo034ak8E03UJq+uaxovbJzq19JmE72vJftY2I+ELHr3c+RFNzxBp?=
 =?us-ascii?Q?VWjdE/fK2vGW9PbJOaeq9JWamcdJICmlHi9fsenqfE/q0Yz+H2i26K4ppJhr?=
 =?us-ascii?Q?VpLrxm4vqtnjSULAao6cqOdHpDw4BRkRq4mTeQuixuGoHK4F0MKWNjIcPuwG?=
 =?us-ascii?Q?HdIqtJQDzlFu4BgewVCypHYy1Mw6tIjOBA1Ubnqcr5ApAszoQzg08kI3Qhrz?=
 =?us-ascii?Q?VInlcmwV8xf0gI+BrHfeCdC88LPnKlHfnFcKfbJ28X+D3k0Ocwlaiuz7Z66Q?=
 =?us-ascii?Q?8q8eTohroMYeomivFMQ34LTX+YXFQDeX9m7OmgDgV3aNJqfkQqFOdPhHyuGZ?=
 =?us-ascii?Q?RcBnc0n1YFFL94ktf9Cu0mi0vRGblhy/d41CbinTAh34mT2GL4KdJ0QI9fZ6?=
 =?us-ascii?Q?0YYDKdH7vzyKCuk/z6rrPbOoGuJBRt+/iB5DMUCU6jytIjjG8VCr6t1E1yBf?=
 =?us-ascii?Q?NjuoGNOvhD07kgAngVyFhzC1T4VrzI/bAIn9oLSUMdppqVdrZjNj+NoWwc3R?=
 =?us-ascii?Q?PpP2GJXtU5LHLrXiMTMBaJq1UPEJU5VUHkpQbYZmZwKaLBpliQf6Bhvsoe9U?=
 =?us-ascii?Q?qrFIEDiWCUqcGLOA5ILHTblFF/RoOMD+UxlRZCO/9HtoPTgCPyoPP3RRMZrp?=
 =?us-ascii?Q?Rdu7S91tiJxH4qYsAPZuAKzAgmp/8+MEAUtpgHxuNmr7/bd/0XHC2WttBL3s?=
 =?us-ascii?Q?hiLL5oWKXWe2t7a8L9P4JCKcJBCsaseaYLNK17WKZ6vZwKr2VJWHRptoeSjD?=
 =?us-ascii?Q?fUzZsTWgHSrjOb10DlVH/p0KrFuc1AxY71WFFcu6fIePA0XK5Mc9NI+LP9j2?=
 =?us-ascii?Q?rY6lo8SMJUeJz1L7VnyEXhZEyd0Z+ub4Yjr6d3iMwTdSGCobcjJwdu+sPF8X?=
 =?us-ascii?Q?JwO5mV/rBqsiNk98JuWJ7twVqxqnCWkGg1UzL97Zcx1Z8LCLpW/SusMarFln?=
 =?us-ascii?Q?hCbaC5F3XvwBs+ptLZbPqplf9BQfSdQ4i7bCjDjkqteDJixInMdwvv5QBy8x?=
 =?us-ascii?Q?5jtpNaN6yg82G6BvQXiBoiNRO0yyW+KUzbiRbMwgAvt+TeU0UKtdxc3gI1Bk?=
 =?us-ascii?Q?WNUaeGRnu0s02LUMpAhCUM/UKnwcVdxN0YmcKoxbQtqSkyBNYASP0i+ig3k6?=
 =?us-ascii?Q?iNfSTg//vs70SiYxeG5ZE9Y04b02Q/fG8mK0KQ317MSO3+UYZhExAt8i+LPs?=
 =?us-ascii?Q?hZp2a2rrPdvrO59+0fWo0k2nq1qVaBWUGG97asU1V9HhbFU/GivK8SngWld0?=
 =?us-ascii?Q?c4fblclhH8FiFDbUo/vDdWPDS6HSktJF9WrOuHtYPtygs4TkHJgDrjVHTt+u?=
 =?us-ascii?Q?CJzKTXD1eWw4rzW24LoirCEGm5qCn8ZiOHnd41wKg79xw7vcYQPRFcMHiZNJ?=
 =?us-ascii?Q?nM9CRTqEzBrDdNQlNX2aqYuouOJjDBaZduPkqJz3GatTIhDbo2SSLVYxSgNb?=
 =?us-ascii?Q?vjO6KY9Jv7h86vCLeicPO4GWKNAOqkVEau4JdDo3lKIRDd3/Ix2U59laJmdz?=
 =?us-ascii?Q?ekgBa9ax3ku1r0rLSRv8nYd43tJRAdUNuBKUMx3Smti5HvFGNQhnRhmconaQ?=
 =?us-ascii?Q?V2JJ20jPt0AGz6EUwxSKSgA3MKnfz9YW4K6QjKGSLO2pYJft4FYlIaXDm0dO?=
 =?us-ascii?Q?MLgCMp7jGKfTLhpzsH75+II6VNs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB0955B9C9FCBE4E8435629069D1C97C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066240a1-689d-4321-105d-08d99d12654f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 08:34:18.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+kL0UNazOhHrcneoNxbBZ0tYZCOgjGGEwKFg6wBsGNPCOaCTjG5y1GqMMfj6vuVgn5EDq7pKMrGvrZ4i1I3WmuPotSIUO8lFk9cx/OYQ28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7374
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I tried the latest linux-block/for-next branch tip (git hash b43fadb6631f a=
nd
observed a process hang during blktests block/005 run on a NVMe device.
Kernel message reported "INFO: task check:1224 blocked for more than 122
seconds." with call trace [1]. So far, the hang is 100% reproducible with m=
y
system. This hang is not observed with HDDs or null_blk devices.

I bisected and found the commit 4f5022453acd ("nvme: wire up completion bat=
ching
for the IRQ path") triggers the hang. When I revert this commit from the
for-next branch tip, the hang disappears. The block/005 test case does IO
scheduler switch during IO, and the completion path change by the commit lo=
oks
affecting the scheduler switch. Comments for solution will be appreciated.

[1]

[  121.677521] run blktests block/005 at 2021-11-01 16:24:21
[  371.819391] INFO: task check:1224 blocked for more than 122 seconds.
[  371.826660]       Not tainted 5.15.0-rc6+ #41
[  371.831786] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  371.840349] task:check           state:D stack:    0 pid: 1224 ppid:  12=
23 flags:0x00000000
[  371.849471] Call Trace:
[  371.852680]  __schedule+0x9e2/0x2240
[  371.857052]  ? io_schedule_timeout+0x190/0x190
[  371.862330]  ? _raw_spin_unlock_irqrestore+0x37/0x40
[  371.868070]  schedule+0xdd/0x280
[  371.872062]  blk_mq_freeze_queue_wait+0xc0/0xf0
[  371.877351]  ? blk_mq_queue_inflight+0x70/0x70
[  371.882554]  ? blk_mq_run_hw_queues+0x13b/0x410
[  371.887856]  ? finish_wait+0x270/0x270
[  371.892363]  elevator_switch+0x4a/0xa0
[  371.896857]  elv_iosched_store+0x16e/0x3c0
[  371.901698]  ? elevator_init_mq+0x3f0/0x3f0
[  371.906643]  ? lock_is_held_type+0xe0/0x110
[  371.911556]  ? lock_is_held_type+0xe0/0x110
[  371.916473]  queue_attr_store+0x8b/0xd0
[  371.921050]  ? sysfs_file_ops+0x170/0x170
[  371.925789]  kernfs_fop_write_iter+0x2c7/0x460
[  371.930965]  new_sync_write+0x359/0x5e0
[  371.935533]  ? new_sync_read+0x5d0/0x5d0
[  371.940177]  ? ksys_write+0xe9/0x1b0
[  371.944483]  ? lock_release+0x690/0x690
[  371.949046]  ? __cond_resched+0x15/0x30
[  371.953604]  ? inode_security+0x56/0xf0
[  371.958171]  ? lock_is_held_type+0xe0/0x110
[  371.963075]  vfs_write+0x5e4/0x8e0
[  371.967196]  ksys_write+0xe9/0x1b0
[  371.971321]  ? __ia32_sys_read+0xa0/0xa0
[  371.975962]  ? syscall_enter_from_user_mode+0x21/0x70
[  371.981733]  do_syscall_64+0x3b/0x90
[  371.986028]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  371.991799] RIP: 0033:0x7f24adda7387
[  371.996085] RSP: 002b:00007ffd9c80f2e8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  372.004366] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f24add=
a7387
[  372.012213] RDX: 0000000000000005 RSI: 0000562156826120 RDI: 00000000000=
00001
[  372.020060] RBP: 0000562156826120 R08: 000000000000000a R09: 00007f24ade=
3d4e0
[  372.027901] R10: 00007f24ade3d3e0 R11: 0000000000000246 R12: 00000000000=
00005
[  372.035746] R13: 00007f24ade7a520 R14: 0000000000000005 R15: 00007f24ade=
7a700
[  372.043629]=20
               Showing all locks held in the system:
[  372.051235] 1 lock held by khungtaskd/62:
[  372.055960]  #0: ffffffffa64483c0 (rcu_read_lock){....}-{1:2}, at: debug=
_show_all_locks+0x53/0x269
[  372.065649] 1 lock held by systemd-journal/584:
[  372.070902] 4 locks held by check/1224:
[  372.075452]  #0: ffff888118fc4460 (sb_writers#4){.+.+}-{0:0}, at: ksys_w=
rite+0xe9/0x1b0
[  372.084177]  #1: ffff888120717088 (&of->mutex){+.+.}-{3:3}, at: kernfs_f=
op_write_iter+0x216/0x460
[  372.093771]  #2: ffff8881480a0a00 (kn->active#131){.+.+}-{0:0}, at: kern=
fs_fop_write_iter+0x239/0x460
[  372.103707]  #3: ffff888148d66858 (&q->sysfs_lock){+.+.}-{3:3}, at: queu=
e_attr_store+0x5d/0xd0

[  372.115258] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
Best Regards,
Shin'ichiro Kawasaki=
