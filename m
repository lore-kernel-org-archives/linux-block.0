Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E85CC433FE
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 00:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiI3ATy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 20:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiI3ATx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 20:19:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C477D25287
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 17:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664497190; x=1696033190;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=fsCeakxMmaALgcGV22aTqBN9BBj6SoCCZmM1NnUnGao=;
  b=gFYp60JZ4/bkDydV60VyH4GjcxFnPxXs6rabC61Cczmh9QVmndrQz6gM
   /ekbODtq371Y0jPD4Txq+IcGyT0OUJOw0PeOdw+Q0T9qQJ/7N8qbMraVY
   7H5vLwfi9gTIrtXn74m1YI/JyzapETh8WFfTf4mFw3i7SxlNjTz7RO3TV
   /BgObIbwHUQ5VEHAu1ydvPyCmYPWx0FW3NanRy4m1XNrNdc4cXI2RUNCN
   0+N7VWRxBvCTc5Xwujf3h5OeKnJpSbybMQmTJqqWADP0g3E1icRgI6nTM
   sxqejdrjC7jlcFSUAWL8QBDYDIyv6bKOfECb5u4kWq1VC2aIieISiruU9
   g==;
X-IronPort-AV: E=Sophos;i="5.93,356,1654531200"; 
   d="scan'208";a="212626543"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2022 08:19:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ep97YF0buLQNpttgnRrQGCIgU6B/1tGDOlCYSglY7JPemF6bbcc9rGbXZDLbj1Nx8S7ZpQf5PfKdSak3M7gJdEJSAUoNgEORqVOySiMdKhRrK7mEGnrBeW3QBzXmwcNH5RsBqaai0doA7cZOZPqcsOAFFGXFN16MDv3JXE9h8OMNIX8105i2tXStGly0S3knCpaVtWGK1C3l68ZFb9ILe/S2rpsj52vWi2APLkpK3Bj0WtLNI3Am9qf53tKObwXUBM1x9YPU1sPYrQxAuDvaWR/svBrnC1a3L13Bw5ONRQzyxyL82tcduRML6AEhiaKJATIjWrMoimTaGbWjrYN9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8cu/u1/Hu/hrmslQb1EBZ3iiVAPscHOGYQAAhovgjI=;
 b=E0uCRrEVDNG0Klt43yXB+9EuygPgKqkLpfGkXbXKH/ddpqdUa0MFLbyMcDYjUn3Oq2GYxxJNxMMSeXLanEy/EVWsxfj8ng8ItHwBfqzyIIw+8fiNVp9hbNGdz7BUfE7Kb/bc5lMHzpQTnbfsmetjP2Up1RMRfOfEaX/kxKkg7XpOTNnSr4wc14eHYg7bUEbDIeu/XnhQ+mBTXuBj1q+hO34v86q0VMTI1SAB5Y8IZ/nMY2LXAr745p4E6aCznRXjh23OyN+VK3+6SrfD23oWqgWbKKRiSQY+GaSarurUana7wM/5Ns33rPTQFeTofSVVxaMpA2h4w+JpHIub8RZkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8cu/u1/Hu/hrmslQb1EBZ3iiVAPscHOGYQAAhovgjI=;
 b=u6eKRgs8t9ZPWWGjQpaiyy+Qe7wmb3Zs1BBHKudtFcmfIEKhKQRHSJn8iQMlpULccVyoNbobSvudN/UNLtRxzFJPfARyEsPFLChv/Xt5qVKnuBGt71Mpy0Dh0tt8WOw5wRfgvioJIqS4xkFKvRa4vZKQ9FbbmYSEeiAwF8GsLwE=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by BN8PR04MB5811.namprd04.prod.outlook.com (2603:10b6:408:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 00:19:46 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::da7c:b5fa:de5d:707c]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::da7c:b5fa:de5d:707c%9]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 00:19:45 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: lockdep WARNING at blktests block/011
Thread-Topic: lockdep WARNING at blktests block/011
Thread-Index: AQHY1GJXrtuQitm3Pk+3ExLt/WFGaQ==
Date:   Fri, 30 Sep 2022 00:19:45 +0000
Message-ID: <20220930001943.zdbvolc3gkekfmcv@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|BN8PR04MB5811:EE_
x-ms-office365-filtering-correlation-id: 8dee58e1-d73b-4611-268f-08daa2797a68
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siXOcw8IZYHzK76UejKqwHdcMiUdJ4fnL6bH+3yDyv48Mgb8OmHbQiAJkAnlRnwvHnkNY1q1l2K+sMxEgRy2GtbssMRMQ4fNGgkxBYGhLKt1tEPOblIdR2n49kDxHQ0Whf4c76O2nPkLzJggdD7JwRqgbyTH+siRqgrZkwuiUw26EqB4k77kQ7xAmlMufU7TsGKKdX0muKkAmsumlqQ3lzmt3T3Sj3bbNAVHkFeNCHKiv5B4vt4FmS8rWs5QEZtMzaXU1EdXmcEax4AO2nxda8bjAOjiLJP/r0f3mdTb//5EpwmC/LYEmIEG5XC3yhedHVtr5kZh7G8iT8E4WzdNQ70SXiYzBo/d+/ofTpBpA1l1hQg/RUGXahc4FSlZqAlexs6Uy04hWoCrrIXjqMNWjvCJk7QSZwZE9rVAZ7pStp3QWyQOkB1G3/0G8pq16+zfd1Kblmj9RrKRArxUV97l9eaMaqF3cfsDndEyOdoCwFdrM1SrbJfMXZBs+0WBsQYXOG5jryu6mtFIiYnU9NlXVaiQtfEYf1/sPb6aoRuQU8wraKHw/Tlw/l7nbBtcAF0uQoHsdlMik1aJsnMfXcwytLgSsrxItjAVSBz291t7PKQoszxUCQn1CXegRxdpxcQ1BrwzIoiWzvY9f1chAqOq2O5cNwKTbanymYz4bK3XEA/DFau5tQqCgro0ZsYvDxA8Y3IpP3deTVkXPPo8Q7JpyyS4xrhKCAXRS6PDrinefFuWg4+KENEuICzPTPOKvhDN4uK5rhIU7gweLu9qe1DNJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(186003)(1076003)(38100700002)(82960400001)(86362001)(38070700005)(83380400001)(122000001)(110136005)(33716001)(5660300002)(41300700001)(54906003)(44832011)(8936002)(91956017)(4326008)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(76116006)(478600001)(2906002)(71200400001)(6512007)(6506007)(9686003)(26005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9na3m9Vnfkn9wkfh6DG+sysBdqdRD3XWLqTEVrr6QVYmMnlLewacRkPQWXdS?=
 =?us-ascii?Q?qxyYyyfVkElV+Kb+144EVtXhplEblCOt+p9h+JOUQOvhfOuz/n0Oa4h8otJl?=
 =?us-ascii?Q?lW3aXSDlCFjKJbCFeqBBJhIwWH0nXe9IlvCqGiMGNjA4NoHj7vLDKwwtXm4/?=
 =?us-ascii?Q?bt2DDja77jziTIk5jTJTdHJQUPtcM0RvEbOWAq5imd6WtlvOHag0o75hxuFX?=
 =?us-ascii?Q?0Uoi0yPQsWS0wJDcRNLQSJJ8Qhf11vAY41w868wVFE30+/mfINiCTpdINcaE?=
 =?us-ascii?Q?rnR7Zxsdse2I73e/kxy9g97tgbQmWMVWCX40IpuZa/KHVef1T8hxcE6F+waJ?=
 =?us-ascii?Q?ufZFlUtAk+ctfVDwmvesbsRaLymsbBhhUEijG7LZehbdG8Nf7ny0FV36SCVI?=
 =?us-ascii?Q?4ZlW6zbqTEGACFuMbormbhdn9Fw1HDsdb/98AWwFRDF4zXJBkeRzZqJuLn6r?=
 =?us-ascii?Q?I6CpT6nlV+10aXKI8pgZsgOF9lZS+tJj66V8HrJRTYs2XAfkECoZxBXkYtQ2?=
 =?us-ascii?Q?r8D3c46OkghB3Wd18i+dM5INic3djvJ9F2NPnsX7WkC9YvX+My4Ad5Feb/4l?=
 =?us-ascii?Q?GFddMKvpI9D34ajcEI7EgGFk8Ltr5Z/p9tDFVgtUu87F8mKTa5HW/Bi0KVNY?=
 =?us-ascii?Q?fHq1622ZgxnE7pYrjpuJJ5TAC7di8pParXn5VH3/mOoyCPLcoPqTx4q9cYi9?=
 =?us-ascii?Q?GwwS88EzJqOLcht3MQMF1hXl57fcQkwnjLw/bS2lo5xbhqB78zx03yifDDFh?=
 =?us-ascii?Q?Xb3bPo+Ma62EGhkv5UWUaVRN52RxkPfArD+I1xfVWOkmTByq6b/WjlnqYVYN?=
 =?us-ascii?Q?28pg+Iz02dasnoklQ6u/Tg5G59OoB1kxjfwk5/kJm6BwElq521SFykRbL6Iv?=
 =?us-ascii?Q?sXSS18X+hnCcBZvh2PJBAxDX0GuCfUAzRexeYBraTGOM1cT2COqpEFpLm/uD?=
 =?us-ascii?Q?lxjsdd415/h85JqOIYsp1Ph7t9zdpL8CJjzBInn5Er4SV0PLuqx8IrmKqa72?=
 =?us-ascii?Q?e3zEZfyE59VFJjrondfh/IiHE/civ3eYze6rxUjgbEUYu6aITY04CWjiLh83?=
 =?us-ascii?Q?U+eFfdknvJrK6sQkQgrGJuK+xKQpKl20a7oUKIPo7qtvRC1kZmgv/uolwYDc?=
 =?us-ascii?Q?U7Cy0tqOXyTwRXz+n2reBGtKkzJ3TY+TpKm+4JAq/udOno7m1ysbDvr2LMGn?=
 =?us-ascii?Q?3qhSNyBxZ+J2amL0Wdasln25GZMwOsNQ+5LDDgKCoJ+TnShE3ZO5QEBqMktl?=
 =?us-ascii?Q?3ikI1DeAJVzpVIoR1qiABiLga4RS2YXhjVyP/UyCQTybn1hAPT5HaCJ0Kfjv?=
 =?us-ascii?Q?upHpz3vjsdzBU7Ees0FkMc2lE1DkodatXRvRMBDeAkCVQtCkZ8PCn+TlQ74y?=
 =?us-ascii?Q?teckwW5cXqydRMOt69uGA2++Ma0o7f32K1C9xGmaBAOsOb81RaSoAu6mgWCY?=
 =?us-ascii?Q?AyyGfMdRRje6xPmymkm2N2DcNahV1NrdYk5NuIajvIjEM8Lejx0cGallKPCA?=
 =?us-ascii?Q?YqJ/aMAQuGl1EKoxCMLZ4cdZOmSFSjBpHL/RbMqrAbkBYyNKk68ZYudPAeJ2?=
 =?us-ascii?Q?jiCJGHmeLizG3gN7j4/aaTehKyAkhNsVaZTD0rV4TiiyhauL0KP/16kYlPAW?=
 =?us-ascii?Q?IBF6v69t0vm39wvp4uFxLz0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <159A6BA42BA2784787D47DA4B7C20883@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dee58e1-d73b-4611-268f-08daa2797a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 00:19:45.4110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vw+K+YQiuuXocyaCs71VKEnHRqpWJGp0V+sUFDk6TkTmyHAEoJGjEMshqTuzbhxtC3bIe3UM6KNrYYUsqg9eAmYebsStPL9/FCr1uTIDVTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5811
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Kernel v6.0-rc7 triggered the WARN "possible circular locking dependency
detected" at blktests test case block/011 for NVME devices [1]. The trigger
commit was c0feea594e05 ("workqueue: don't skip lockdep work dependency in
cancel_work_sync()"). The commit was backported to v5.15.71 stable kernel a=
nd
the WARN is observed with the stable kernel also. It looks that the possibl=
e
deadlock scenario has been hidden for long time and the commit revealed it =
now.

As the commit title says, it restored lockdep work dependency in
cancel_work_sync(), which is called from nvme_reset_work() via blk_sync_que=
ue().
The test case repeats PCI disable during I/O on the PCI-NVME device, then
nvme_reset_work() call is repeated.

The WARN was observed with QEMU NVME emulation device. I tried two of my re=
al
NVME devices, and one of them recreated the WARN. The other real NVME devic=
e did
not recreate it.

I tried to understand the deadlock scenario, but can not tell if it is for =
real,
or false-positive. Help to understand the scenario will be appreciated. The
lockdep splat mentions three locks (ctrl->namespaces_rwsem, dev->shutdown_l=
ock
and q->timeout_work). In the related function call paths, it looks that
ctrl->namespaces_rwsem is locked only for read, so the deadlock scenario do=
es
not look possible for me. (Maybe I'm misunderstanding something...)

[1]

[ 3033.791353] run blktests block/011 at 2022-09-27 13:24:34
[ 3064.944407] nvme nvme5: controller is down; will reset: CSTS=3D0x2, PCI_=
STATUS=3D0x10

[ 3066.531825] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 3066.533372] WARNING: possible circular locking dependency detected
[ 3066.534914] 6.0.0-rc7 #1 Not tainted
[ 3066.535891] ------------------------------------------------------
[ 3066.537492] kworker/u8:0/904 is trying to acquire lock:
[ 3066.538807] ffff888102f24788 ((work_completion)(&q->timeout_work)){+.+.}=
-{0:0}, at: __flush_work+0xc2/0x900
[ 3066.541161]=20
               but task is already holding lock:
[ 3066.542793] ffff888116840528 (&ctrl->namespaces_rwsem){++++}-{3:3}, at: =
nvme_sync_queues+0x26/0x100 [nvme_core]
[ 3066.545294]=20
               which lock already depends on the new lock.

[ 3066.547563]=20
               the existing dependency chain (in reverse order) is:
[ 3066.549530]=20
               -> #2 (&ctrl->namespaces_rwsem){++++}-{3:3}:
[ 3066.551431]        down_read+0x3e/0x50
[ 3066.552421]        nvme_start_freeze+0x24/0xb0 [nvme_core]
[ 3066.553862]        nvme_dev_disable+0x4ee/0x660 [nvme]
[ 3066.555208]        nvme_timeout.cold+0x3f2/0x699 [nvme]
[ 3066.556575]        blk_mq_check_expired+0x19a/0x270
[ 3066.557865]        bt_iter+0x21e/0x300
[ 3066.558935]        blk_mq_queue_tag_busy_iter+0x7fd/0x1240
[ 3066.560356]        blk_mq_timeout_work+0x143/0x380
[ 3066.562602]        process_one_work+0x816/0x1300
[ 3066.563847]        worker_thread+0xfc/0x1270
[ 3066.564942]        kthread+0x29b/0x340
[ 3066.565973]        ret_from_fork+0x1f/0x30
[ 3066.567083]=20
               -> #1 (&dev->shutdown_lock){+.+.}-{3:3}:
[ 3066.568851]        __mutex_lock+0x14c/0x12b0
[ 3066.570010]        nvme_dev_disable+0x5d/0x660 [nvme]
[ 3066.571309]        nvme_timeout.cold+0x3f2/0x699 [nvme]
[ 3066.572678]        blk_mq_check_expired+0x19a/0x270
[ 3066.573972]        bt_iter+0x21e/0x300
[ 3066.575024]        blk_mq_queue_tag_busy_iter+0x7fd/0x1240
[ 3066.576431]        blk_mq_timeout_work+0x143/0x380
[ 3066.577688]        process_one_work+0x816/0x1300
[ 3066.578882]        worker_thread+0xfc/0x1270
[ 3066.580046]        kthread+0x29b/0x340
[ 3066.581081]        ret_from_fork+0x1f/0x30
[ 3066.582194]=20
               -> #0 ((work_completion)(&q->timeout_work)){+.+.}-{0:0}:
[ 3066.584265]        __lock_acquire+0x2843/0x5520
[ 3066.585426]        lock_acquire+0x194/0x4f0
[ 3066.586458]        __flush_work+0xe2/0x900
[ 3066.587484]        __cancel_work_timer+0x27a/0x3a0
[ 3066.588568]        nvme_sync_queues+0x71/0x100 [nvme_core]
[ 3066.589782]        nvme_reset_work+0x137/0x39f0 [nvme]
[ 3066.590896]        process_one_work+0x816/0x1300
[ 3066.591895]        worker_thread+0xfc/0x1270
[ 3066.592795]        kthread+0x29b/0x340
[ 3066.593654]        ret_from_fork+0x1f/0x30
[ 3066.594569]=20
               other info that might help us debug this:

[ 3066.596290] Chain exists of:
                 (work_completion)(&q->timeout_work) --> &dev->shutdown_loc=
k --> &ctrl->namespaces_rwsem

[ 3066.598960]  Possible unsafe locking scenario:

[ 3066.600167]        CPU0                    CPU1
[ 3066.600985]        ----                    ----
[ 3066.601779]   lock(&ctrl->namespaces_rwsem);
[ 3066.602506]                                lock(&dev->shutdown_lock);
[ 3066.603597]                                lock(&ctrl->namespaces_rwsem)=
;
[ 3066.604739]   lock((work_completion)(&q->timeout_work));
[ 3066.605653]=20
                *** DEADLOCK ***

[ 3066.606728] 3 locks held by kworker/u8:0/904:
[ 3066.607436]  #0: ffff888111fe3138 ((wq_completion)nvme-reset-wq){+.+.}-{=
0:0}, at: process_one_work+0x73c/0x1300
[ 3066.608959]  #1: ffff88811ddcfdd0 ((work_completion)(&dev->ctrl.reset_wo=
rk)){+.+.}-{0:0}, at: process_one_work+0x769/0x1300
[ 3066.610491]  #2: ffff888116840528 (&ctrl->namespaces_rwsem){++++}-{3:3},=
 at: nvme_sync_queues+0x26/0x100 [nvme_core]
[ 3066.612010]=20
               stack backtrace:
[ 3066.612819] CPU: 1 PID: 904 Comm: kworker/u8:0 Not tainted 6.0.0-rc7 #1
[ 3066.613951] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[ 3066.615613] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[ 3066.616532] Call Trace:
[ 3066.616985]  <TASK>
[ 3066.617378]  dump_stack_lvl+0x5b/0x77
[ 3066.618057]  check_noncircular+0x242/0x2f0
[ 3066.618734]  ? lock_chain_count+0x20/0x20
[ 3066.727613]  ? print_circular_bug+0x1e0/0x1e0
[ 3066.950865]  ? unwind_next_frame+0x21b/0x1e60
[ 3066.951388]  ? ret_from_fork+0x1f/0x30
[ 3066.951855]  ? lockdep_lock+0xbc/0x1a0
[ 3066.952361]  ? call_rcu_zapped+0xc0/0xc0
[ 3066.952835]  __lock_acquire+0x2843/0x5520
[ 3066.953315]  ? stack_trace_save+0x81/0xa0
[ 3066.953845]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[ 3066.954439]  lock_acquire+0x194/0x4f0
[ 3066.954931]  ? __flush_work+0xc2/0x900
[ 3066.955389]  ? lock_downgrade+0x6b0/0x6b0
[ 3066.955865]  ? lockdep_unlock+0xf2/0x250
[ 3066.956380]  ? __lock_acquire+0x2080/0x5520
[ 3066.956878]  __flush_work+0xe2/0x900
[ 3066.957316]  ? __flush_work+0xc2/0x900
[ 3066.957813]  ? mark_lock+0xee/0x1610
[ 3066.958249]  ? queue_delayed_work_on+0x90/0x90
[ 3066.958774]  ? lock_chain_count+0x20/0x20
[ 3066.959312]  ? lock_acquire+0x194/0x4f0
[ 3066.959776]  ? lock_acquire+0x1a4/0x4f0
[ 3066.960233]  ? lock_is_held_type+0xe3/0x140
[ 3066.960777]  ? find_held_lock+0x2d/0x110
[ 3066.961247]  ? mark_held_locks+0x9e/0xe0
[ 3066.961707]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[ 3066.962330]  __cancel_work_timer+0x27a/0x3a0
[ 3066.962832]  ? cancel_delayed_work+0x10/0x10
[ 3066.963381]  ? _raw_spin_unlock_irqrestore+0x40/0x60
[ 3066.963952]  ? try_to_del_timer_sync+0xd0/0xd0
[ 3066.964467]  nvme_sync_queues+0x71/0x100 [nvme_core]
[ 3066.965087]  nvme_reset_work+0x137/0x39f0 [nvme]
[ 3066.965627]  ? __lock_acquire+0x1593/0x5520
[ 3066.966173]  ? nvme_queue_rqs+0xa80/0xa80 [nvme]
[ 3066.966713]  ? lock_acquire+0x194/0x4f0
[ 3066.967180]  ? lock_acquire+0x1a4/0x4f0
[ 3066.967698]  ? lock_downgrade+0x6b0/0x6b0
[ 3066.968176]  ? reacquire_held_locks+0x4e0/0x4e0
[ 3066.968751]  ? lock_is_held_type+0xe3/0x140
[ 3066.969247]  process_one_work+0x816/0x1300
[ 3066.969746]  ? lock_downgrade+0x6b0/0x6b0
[ 3066.970279]  ? pwq_dec_nr_in_flight+0x230/0x230
[ 3066.970818]  ? rwlock_bug.part.0+0x90/0x90
[ 3066.971303]  worker_thread+0xfc/0x1270
[ 3066.971818]  ? process_one_work+0x1300/0x1300
[ 3066.972330]  kthread+0x29b/0x340
[ 3066.972746]  ? kthread_complete_and_exit+0x20/0x20
[ 3066.973345]  ret_from_fork+0x1f/0x30
[ 3066.973791]  </TASK>
[ 3067.963008] nvme nvme5: 4/0/0 default/read/poll queues
[ 3067.972454] nvme nvme5: Ignoring bogus Namespace Identifiers
[ 3098.224067] nvme nvme5: I/O 936 (I/O Cmd) QID 2 timeout, aborting
[ 3098.225903] nvme nvme5: I/O 598 (I/O Cmd) QID 4 timeout, aborting
[ 3098.226229] nvme nvme5: Abort status: 0x0
[ 3098.227499] nvme nvme5: I/O 599 (I/O Cmd) QID 4 timeout, aborting
[ 3098.227872] nvme nvme5: Abort status: 0x0
[ 3098.231401] nvme nvme5: Abort status: 0x0
[ 3128.432035] nvme nvme5: I/O 936 QID 2 timeout, reset controller
[ 3130.808541] nvme nvme5: 4/0/0 default/read/poll queues
[ 3130.816416] nvme nvme5: Ignoring bogus Namespace Identifiers
[ 3161.199887] nvme nvme5: I/O 936 (I/O Cmd) QID 2 timeout, aborting
[ 3161.201909] nvme nvme5: Abort status: 0x0
[ 3191.407811] nvme nvme5: I/O 936 QID 2 timeout, reset controller
[ 3254.895644] nvme nvme5: controller is down; will reset: CSTS=3D0x2, PCI_=
STATUS=3D0x10
[ 3257.299155] nvme nvme5: 4/0/0 default/read/poll queues
[ 3257.312480] nvme nvme5: Ignoring bogus Namespace Identifiers

--=20
Shin'ichiro Kawasaki=
