Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679EFEB64D7
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 02:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFVC7P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 22:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFVC7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 22:59:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261E171C
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687402753; x=1718938753;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=VJ92Xpf3QH8AnEHSTylNwqfNEq2UbQXezvA9s+VsBZk=;
  b=GjjGBx4P/ozmKtW5aaIROvtYvniUvAfck1mHqibnX2yIK++/xcJTVWCb
   YAV5a9G/6LyW3YhjEysJ6tmvn5IEbWLRRJoIiAn3NQGl/tctHwviXSZ0g
   hBfT9luEp6Cr6B3V+YojF6CgnXs0/Y3pBC3BeeE0E8lvT6qlPXl7xnyi+
   UG+x5W9BDyD45Cd6CFf1AccNGyjlfYJowscm5noO8W3bXAnSeW82k4G26
   wEew3GSUmmfjpXVioVrpFyKpk5DRH5mBrGFpKke5NuMIIJx/PAfUV/hdm
   /vqbfmXkOMHL0e22GC5/g2L3Dah4T1BDQlf1HnJiDCDItbfcVToiiT2b0
   A==;
X-IronPort-AV: E=Sophos;i="6.00,262,1681142400"; 
   d="scan'208";a="236593118"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2023 10:59:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrEV+1QPvEw8WmMMBD2H484wtn3xzO6y5AOB9u6hIfh2zB0Ll3jvOGexTvo/f2t2xz70MK6uRXVFDmdmG7dvlNE2xZRCrhHD9NtvOKt49RydqvGnRp+g9F28U1Fjx2Mx5UcPKXW9i9fLZObAn6XWoHX3+t7FU26I2QE2JhXahzhWAzabeEQ8Nf+NOmf6XpxKo/t6YGxxqxwkabrvdC8APpZleJxcievh7nPgWRswVN5XsNW8dBd6PNfeCJtoibXDx4iqD88iuGZDgrLzgEIBLJzKjAZSHu6/XwI3BrABKxdHbO6XFuxfuFQpw6qHBNt/3bXpRX5VYm8TFWHMBVuosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP/u7ztBZsY50BNfuMAcwgCphQG86JFnDaVAufluD8Y=;
 b=IDpR179R4cSxj4T2C+wwZK3aelNZ2uyCbYMyn3CMluEygMZved447BQCX+ykI0vDuRVyr+/kj4BGvnXWUC5n8YmkASjnr8F1IeUdQ8b6MozvimVBBqD31+TcMnGrpNCHSkbahB6VcAHTtQRbr3ewI9xLVeYeTX05LnE3IQu7hG6WkvpSNgKo0YdMIroOb02zwHxt89zf33xQ4Y8mByY5z3r1nfntMEGxgwYlA2a+G+TCBwdd4w1I4V3yS5NqnFisWxHzUXLaJe4Mk/fuPiqM7NYsu0DQLdKR8R5ykDfRczMO7L/YsOTkjwqJ57EL8SbiJxNMu1OTckjFualW+6ZpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP/u7ztBZsY50BNfuMAcwgCphQG86JFnDaVAufluD8Y=;
 b=gnCFLNMpQ70MceNKUZMjSsiHTzJI238A1w5mC7hOcNuUHNbQ8dtVTR8k35Y4U3+N72ohQnA7eNrDbquy6zzzVmuXId8crZwyZ84uPTv/U7oWEybUhImAH/SKo4hc5R5f7eNrBTf5G8D27KqKrQpl0SGGOfYdD+FemI+rjzOVJuA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7490.namprd04.prod.outlook.com (2603:10b6:303:b3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 02:59:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 02:59:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [bug report] WARNING: possible irq lock inversion dependency detected
Thread-Topic: [bug report] WARNING: possible irq lock inversion dependency
 detected
Thread-Index: AQHZpLWEPywKL/pwDEezKpZ6JbfPow==
Date:   Thu, 22 Jun 2023 02:59:10 +0000
Message-ID: <pz2wzwnmn5tk3pwpskmjhli6g3qly7eoknilb26of376c7kwxy@qydzpvt6zpis>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7490:EE_
x-ms-office365-filtering-correlation-id: 17a01e3b-429a-4df8-3a5e-08db72cca72f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFui4HI3HymA2f8K4TaOf2a2FRIE5RH2rdgGL7MCGDtrulwBA/fBdlK4GBM66eBIy9cSysnd3+c/BjBALNEMQGj8DEKqZXKBiRpIQd4TjMwfo6t9ZNC9ZuhyEpkHFuz4C9VyCNkLt88WZ//WBZATEljmd46eJlBUaO/nhFp11Vt9DcsESN1hCdcdZjLfg4/8iGQhAbiEWtjpl0R8mYcJ3oMthXZhYtnUzpgkTj3xojWDgN0kODui6BNLvHhDYreK9xVVn8bMMmxX6zBz2WjIMqSGtwRUsINWVnIcKXaxiTcdtFY/XvxYra0wWUq077fBSXmislvUxUSU/GQoNgEPSN3I7sf8YyRoO40y4daM+xGpLyOppq3651nbcCVXuOtZ3Iw72DVAmhMW2LNIJcJWtiRdhLpOVNUjK9AxnB2MdpfcagnzNDxkt3lxCbjrdSjGjZwqGEY3UgEkLeJutu2kCcYqeI8l9GqtVTqCxgnmzNNd0PJshQLMKD2whGcd/J0lFXa4BNFKnQ9eRp7c8ZQqdYFyFHVQxi1g7iKfcTK/+4QwFS/pTLIr1Y5fVY52f5w9a0Sob60GHyvJyn7mGbCeajfgjSue93HB+jQVt4XcWZyyFQ31JyM6U/eRC2IBNXyW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(110136005)(6486002)(71200400001)(66946007)(66446008)(76116006)(66476007)(66556008)(91956017)(478600001)(64756008)(186003)(9686003)(26005)(6512007)(6506007)(8936002)(316002)(41300700001)(8676002)(5660300002)(33716001)(44832011)(2906002)(38070700005)(82960400001)(38100700002)(122000001)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PF5n8ctxUSZMsWXEZhQ3exY4wb6dCNbQ22XtP+yrckk6MhV0CXyQy5xPe1Qi?=
 =?us-ascii?Q?vJqQCArGhLLz31wF8b3dmdVorDuDfBHocZT74TlCBzaGbhsjVtRsY3DHnHGS?=
 =?us-ascii?Q?LnfaD7RJW4w+ebmbIyj+aKfVdmtzQraDa1/6sJmZNxRdEm34U3RHv3AGMvuN?=
 =?us-ascii?Q?8fG1mFliXKI1mp+hc0gI34nhAHCk+uQROffga+CwdNhAEmZyfBcg5FT2QemU?=
 =?us-ascii?Q?DIBzgPHMJNk2ptQWIJPFcMcXRnAukAbMzWwpi/FhQC5N3hgn+9kIxFFiPgn4?=
 =?us-ascii?Q?TvmvNPSWERnvqqBYDPLf77EittVZws8UgAuslnyeooPBwQEw9B9iaMkvEOw1?=
 =?us-ascii?Q?MBKRWBZVLnfuOqKStAMZH8KCjyUB/zZxTIjOKQplofMVHeeLHzuIfAmW8rtz?=
 =?us-ascii?Q?6ujnp5+hZFkR/AAD7BXiSsvYX/VCxE4cRb82lcaesR/ep2Zzh5cw7gkFfAdu?=
 =?us-ascii?Q?oe2AVwSjzpZDJ/6kJ4G+KrpbNNEONDP6tKAxytTdB5qyIS/hjiaIfu9EAbLi?=
 =?us-ascii?Q?HZClPdnR3L8iA5j+MHb1M3/qaZcBR69TBOMtzzMLkydjxG13GlqXcFPNOMrw?=
 =?us-ascii?Q?urTUA7q1LCfeSnu98L5PlksknJua8fzPhnpwincuqiCpfXrBJvgvgW5An+Uz?=
 =?us-ascii?Q?g5T+g2QyxQo0JF1fyzn6FJlsxaIfxcbilj5JnnVzenvqi/eVY3NAYcS6jRxu?=
 =?us-ascii?Q?2ephElw7g10XQ6uEWmYzD+5D9a/4hux1w7yZfTjYo+Yua10iOwxzBpCFNx4x?=
 =?us-ascii?Q?L8oeJ6yEXV5mP0DfxyG4D/n0jxj2Rj5O0PaZ7kpmEGFjAtAy5yl8ZIgFIgmd?=
 =?us-ascii?Q?ZNapgfaGguuTcpV3AJMYgfi4avwWI4OGHAwIqFFG/U/IHvjrYXkuCJTFn5f9?=
 =?us-ascii?Q?8K3IqZri+eFC8s0x95lusHtYuvY7g/2hpvKSeQcSVhVOulVKlJwXMyMG+fqT?=
 =?us-ascii?Q?Z+x35oIVJOYIQI41lDb14uQAxLfu+pcq0Zg+Vnasb9BdOprD3BMNzfMFo7L6?=
 =?us-ascii?Q?Cq5sWTCgoLVUxiJPsgh83IQYXWd5pHrJKw2/mtZ/Fdvn6zIsg8Wq0xLYZkIA?=
 =?us-ascii?Q?Eaqj755nXc4u2ILvm2/Md/F/hgutNn1maOplcnHgM2iN7/cJe/zBnF2jXdJ0?=
 =?us-ascii?Q?ME9dll++mIwujZfGIeX6uV8PjdXBAxGuy0QN1BRudsY+PopudDAgeokFAER1?=
 =?us-ascii?Q?NvuDK7q4j0ukCqgwDaKq+jFd/BSbTbrWcubwPAy1zzMzOgDFwamzdoFIKwMK?=
 =?us-ascii?Q?A+ZtC5a2C8iuMo9rSFx5VhcQSJ2boP60la29lZr5Bv9pBcnY7EqtafylBvXX?=
 =?us-ascii?Q?4JZ+CDDeaGbSyS2+a0iY6l3/uzYtw4Dt3EqEnV5PDGOAa+W0O9iUfmaqen2K?=
 =?us-ascii?Q?V2H7Eo7IQpw7/7saJNX5bgXChwRbMHS6LDY3uhD/UQWNcx8sxlKTct7Awi35?=
 =?us-ascii?Q?w/nBvVmanaKly0UTGIyoWWeAcFwP2Lfu1nBjDfvZ4bvmxoNQ2wlnKH4WVnZI?=
 =?us-ascii?Q?2f5mynAq4sqZOXQHtuEBICS1D86Mfp58wiqmnQUA/jLkZFP84D2uCL458jyR?=
 =?us-ascii?Q?2Pp4/0AeFlSBA58N55Y2hNQXuMMUp8MWDtz5Bfw7YKaT8BKcKbIyI2xEJ/lR?=
 =?us-ascii?Q?KYtr9uWDzKlm6D48zg2PCl0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2690886E8210004487401728329024EF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XNfimr3ea6ZwCa9gHKSUQITBp9y11DLu4RrTwsT80wA+fAsL6LUASUr6tLmnjKFRRHWE+tjNxOtsCF7A7RUs0PduYNVFn+SBT2A1DKZ30Ai3x3rmPatekSQ8sSVyipTe2/iAnQqTUJWvnQs3xzZ6VxLgiqg4Y60sPMMRYpFM0XVjztI43H1vxI3pTQIzRTakJPrm15VGt3ZPsbJ3DJHSXJQZG/DzBugy+1chzYHG8L0CYvuxmFGRngVo1CLctJFeH/uEE9ItEys0tFa83xbIqjmJuuJHDPlNNkjOivXxoPqcvAuum/itCygUL4E/Cilbu5fZIm4GLWcOFZFJrvZFuoSxQpUTAjmB1y/8iPl0+esSLEtZqAxbiFp8uPADXorrZ1XoGZY1PE2EKjWwrti/TwpCIFdGAk9wVXTM/QiHov49Z8BsO2+MPRBO8zOEHRwEpBGDiRXONYS5/BgbtBRzYI+aHuszXWvgsxZvm3ih8T0TZ3P7/4GCKP1qqVv+qi4MyIZCbUvfzkCVAqN2gMiE+tRROQWASPbuJiPgFBVpeZj3naJkrms5gUA4Iop0KtcF9m5W3OI+w70wIS4JNk4M5ryc8OYcmmAbh6bWbwrL8fYTHfTXcc9D8EoXW7wkHyyTWBNYbSBEzkGJ1OCou9jVq9RDgzWgXs1M9kjNNYBC540j0/wzTLNARL936HIcYlTjMOl8Wrn4a7tcNE7Nel44CQ1zeEPyg0jOs/JFXJ2RAkFsZZhwABRtzYaOMhDMgIzIu8By7fyX6YvqWb4ggpulqJEXPVr1thG0imM2jLOrU61KQhMh0MOxl3LvQ0E4UBEd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a01e3b-429a-4df8-3a5e-08db72cca72f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 02:59:10.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKg/zwc4s2+IWjoLtTg6h1Cjxo5hzaedGyGQpDYHxIGaO4LZzg6kQOFQOSTnJYrPLlTVVpXmDeXYH8lS7ZdGFbr/xJGScURfEghgzCN2+eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7490
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming, could you take a look in this WARNING?

Using kernel v6.4-rc7, I observed blktests block/027 failure due to a lockd=
ep
WARN [1]. The failure can be reproduced in stable manner with my test syste=
ms,
by running the test case after system reboot.

The lockdep reported a lock named blkg_stat_lock. I noticed that the recent
commit 20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")
introduced the lock. I reverted the commit from v6.4-rc7 and observed the
failure disappears.

[1]

WARNING: possible irq lock inversion dependency detected
6.4.0-rc7-kts #1 Not tainted
--------------------------------------------------------
fio/10956 just changed the state of lock:
ffffffff98da0a98 (blkg_stat_lock){+.-.}-{2:2}, at: __blkcg_rstat_flush.isra=
.0+0xe1/0x600
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)){-.-.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(blkg_stat_lock);
                               local_irq_disable();
                               lock(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu=
));
                               lock(blkg_stat_lock);
  <Interrupt>
    lock(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));

 *** DEADLOCK ***

2 locks held by fio/10956:
 #0: ffffffff98a3fe00 (rcu_callback){....}-{0:0}, at: rcu_do_batch+0x300/0x=
cd0
 #1: ffffffff98a3ff20 (rcu_read_lock){....}-{1:2}, at: __blkcg_rstat_flush.=
isra.0+0x7d/0x600

the shortest dependencies between 2nd lock and 1st lock:
 -> (per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu)){-.-.}-{2:2} {
    IN-HARDIRQ-W at:
                      lock_acquire+0x196/0x4b0
                      _raw_spin_lock_irqsave+0x47/0x70
                      cgroup_rstat_updated+0xbf/0x430
                      __cgroup_account_cputime_field+0xbb/0x170
                      account_system_index_time+0x1b3/0x2e0
                      update_process_times+0x26/0x140
                      tick_sched_handle+0x67/0x130
                      tick_sched_timer+0xad/0xd0
                      __hrtimer_run_queues+0x4a9/0x8d0
                      hrtimer_interrupt+0x2f1/0x810
                      __sysvec_apic_timer_interrupt+0x143/0x3f0
                      sysvec_apic_timer_interrupt+0x8a/0xb0
                      asm_sysvec_apic_timer_interrupt+0x16/0x20
                      _raw_spin_unlock_irqrestore+0x36/0x60
                      __wake_up_common_lock+0xd4/0x120
                      percpu_up_write+0x75/0x90
                      cgroup_procs_write_finish+0xad/0xe0
                      __cgroup_procs_write+0x23e/0x410
                      cgroup_procs_write+0x13/0x20
                      cgroup_file_write+0x1b2/0x730
                      kernfs_fop_write_iter+0x356/0x530
                      vfs_write+0x4c2/0xca0
                      ksys_write+0xe7/0x1b0
                      do_syscall_64+0x58/0x80
                      entry_SYSCALL_64_after_hwframe+0x72/0xdc
    IN-SOFTIRQ-W at:
                      lock_acquire+0x196/0x4b0
                      _raw_spin_lock_irqsave+0x47/0x70
                      cgroup_rstat_updated+0xbf/0x430
                      __mod_memcg_state+0x9d/0x180
                      mod_memcg_state+0x3e/0x60
                      memcg_account_kmem+0x18/0x50
                      refill_obj_stock+0x430/0x740
                      kmem_cache_free+0x2a4/0x330
                      rcu_do_batch+0x34e/0xcd0
                      rcu_core+0x8a6/0xdd0
                      __do_softirq+0x1d7/0x857
                      __irq_exit_rcu+0xfe/0x260
                      irq_exit_rcu+0xa/0x30
                      sysvec_apic_timer_interrupt+0x8f/0xb0
                      asm_sysvec_apic_timer_interrupt+0x16/0x20
                      cpuidle_enter_state+0x29f/0x340
                      cpuidle_enter+0x4a/0xa0
                      do_idle+0x340/0x430
                      cpu_startup_entry+0x19/0x20
                      start_secondary+0x22f/0x2c0
                      __pfx_verify_cpu+0x0/0x10
    INITIAL USE at:
                     lock_acquire+0x196/0x4b0
                     _raw_spin_lock_irqsave+0x47/0x70
                     cgroup_rstat_flush_locked+0x124/0x10d0
                     cgroup_rstat_flush+0x38/0x50
                     do_flush_stats+0xa9/0x110
                     flush_memcg_stats_dwork+0xc/0x60
                     process_one_work+0x81f/0x1330
                     worker_thread+0x100/0x12c0
                     kthread+0x2e7/0x3c0
                     ret_from_fork+0x29/0x50
  }
  ... key      at: [<ffffffff9b85e500>] __key.0+0x0/0x40
  ... acquired at:
   _raw_spin_lock+0x2f/0x40
   __blkcg_rstat_flush.isra.0+0xe1/0x600
   cgroup_rstat_flush_locked+0x724/0x10d0
   cgroup_rstat_flush_atomic+0x23/0x40
   do_flush_stats+0xeb/0x110
   mem_cgroup_wb_stats+0x346/0x420=
