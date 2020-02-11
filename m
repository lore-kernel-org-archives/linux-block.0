Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF6BC35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 19:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355B12086A
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 19:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="V5irnS2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgBKTaa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:30:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:11641 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbgBKTaa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 14:30:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 11:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="406046022"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 11 Feb 2020 11:30:28 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 11:30:28 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 11:30:24 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Feb 2020 11:30:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 11 Feb 2020 11:30:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFzVBUILw47C86J2SgkCwIxMYPblWJWlOGF8NCyEe2Q323PGxneFoPNcFXVDZTdbitsVH9pxY+sIoXnK50rRtt4UpyW5pchrYcAcR6Qr0R2SrxU4rf9JnmZxwrAc6P0EF3B9kdBB/kIzqTLk0AJRc7/NKyNxoHU+tMVF9J1QMgZtNltG/+OU2h5LvE0MJLGOGBZLjw4goPyw95NlDWgKPD31HjijWfcUT84ZbM0h7LX6/sDW/W48G0VcS/PyJANjHtNvLjZ1Y02Fl2jZyhbqkH+TOhbfHnFMrStpVbcTJ9Mjyc+HqpPpS/K4r3ahf+K7JCo4mqK64tvbE+pQPi6XmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHL+gSrXklqN5To6q28bip0rsCMwZ7pp+VDOIH1WKDw=;
 b=eHA+ePi4PqkYBLz5UYVkGiWt6A1+qa++7YcasxMk2mWRouihb4gxGDVmjCtwJ63/FkBQI0s10UmRn2xnoCQd6HiE7PVx2+hUJHTCbVQ7Nokh1k6VCXUaWmm3kE5jq/1A83+hFpdBxzJoF12t+YOFNPsNlmRDCX8iZCyGZ7qiJv4H2jXCrL2H2HVUuskjIimk56yz+RPmuz0toYosveReS6O/HbapFxRmgYcYQSitNwg0x3dkGbVeKPL78/VjvOyiGUV5gP4bwH4PhxR44d1pVarptr3by0PdTa+MKVgCszI05qhTBk+6hdLIbAxL9kVKjVBMLtLopbTSq2RUhgnPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHL+gSrXklqN5To6q28bip0rsCMwZ7pp+VDOIH1WKDw=;
 b=V5irnS2M266fP3E5Gqh3pgt5EBlmbUiN7VS8R5/BpO2GR4EVp8xJGBGn+o8VoCggusXnjrk1Y1Kz7qY56tgcAuZ5MZG7pl8n7LQFdWuxSZisU0l3ykcHZMt0ezpHHKyuoYlwZpOOp/alNVuPOYwcAxVHe4YybOZqVQh52cwQFG0=
Received: from CY4PR11MB1351.namprd11.prod.outlook.com (10.169.252.137) by
 CY4PR11MB1399.namprd11.prod.outlook.com (10.173.17.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Tue, 11 Feb 2020 19:30:19 +0000
Received: from CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::4989:9d34:1d46:f384]) by CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::4989:9d34:1d46:f384%9]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 19:30:18 +0000
From:   "Wunderlich, Mark" <mark.wunderlich@intel.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>
Subject: Fault seen with io_uring and nvmf/tcp
Thread-Topic: Fault seen with io_uring and nvmf/tcp
Thread-Index: AdXhDtQrqxADyDVdQge7HdIgujH1ow==
Date:   Tue, 11 Feb 2020 19:30:18 +0000
Message-ID: <CY4PR11MB13515FF9DCEFD14FF68FC65CE5180@CY4PR11MB1351.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [192.55.52.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f8a080a-a5e2-44b7-0be0-08d7af28d42c
x-ms-traffictypediagnostic: CY4PR11MB1399:
x-microsoft-antispam-prvs: <CY4PR11MB139961FC7279CE7A3F366432E5180@CY4PR11MB1399.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(189003)(9686003)(4326008)(64756008)(55016002)(478600001)(66446008)(2906002)(186003)(66556008)(316002)(66476007)(26005)(66946007)(33656002)(76116006)(52536014)(86362001)(8676002)(6916009)(71200400001)(81166006)(8936002)(81156014)(6506007)(5660300002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1399;H:CY4PR11MB1351.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DgmaFSgcAonakA/OpY3V7UWOfJcl9wLhI4AWSE/1Iaqw9fS8RrqBOkTLX2nrfX5PFEuVO9gTV7Qox/BFuZISTzm0mabj7zo/Yt80nVPMEBXO4cPKZN8T0/XrDCwEoj4L+KzVLIGFXKQrFAW8LlKkH/fbRHDY34JPNqfKXrgwdaeq5gjevaAWMoIwsQ333zGxu3I69X0ESaaW11c27iD2/DfE4AeRNR8jw/ETCi10Ed0KvJheAMWHu7az0IvSvBhs7d63gUrk30zLeCq7QEe0TtVUO4GGBRyX7O+VRhhiDGYOdyQNGdMwAZprF152C6xt10joLmcyDIsKr1W9DuL2Ht5ogVXp8HfgbOyL+kQPBQUl5//y+s1ZenfSl9EwOe/sNSYzsdIryxU8g43NCOk7aemMV4h7pebGWbGu9qO61WVRwt92JWOnqfSnTfw0lcUA
x-ms-exchange-antispam-messagedata: s5bkoRi1qtwaQ6NiDMMLlg1zUDYnC8xDrXC1nVKszzShCdA0CP6MD3ww9DSb8f9pAK6jesIgOn6nL0KuYLhmVUZOmzorF0AI5YUjvCsGxYXwPCxdUs+9JlYGHKjrs3JyeCrfxHaUHHbff1gJbEJd5g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8a080a-a5e2-44b7-0be0-08d7af28d42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 19:30:18.8573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7g1ru5meQhj3pRNsDjZJtiSzG7NkCJl/2GUv7dhQ7RACdwdsB7V7UUZfFCT4wT/rzShVJ9kRXLoW4OtsYh7zQNY7+e0LObzcRlswoS2sQsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1399
X-OriginatorOrg: intel.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Posting to this mail list in hopes someone has already seen this fault befo=
re I start digging.  Using the nvme-5.5-rc branch of  git.infradead.org rep=
o.
Pulled this branch and running un-modified.
Performing FIO (io_uring) test: (initiating on 8 host cores, TIME=3D30, RWM=
IX=3D100, BLOCK_SIZE=3D4k, DEPTH=3D32, BATCH=3D8), using latest version of =
fio.
cmd=3D"fio --filename=3D/dev/nvme0n1 --time_based --runtime=3D$TIME --ramp_=
time=3D10 --thread --rw=3Drandrw --rwmixread=3D$RWMIX --refill_buffers --di=
rect=3D1 --ioengine=3Dio_uring --hipri --fixedbufs --bs=3D$BLOCK_SIZE --iod=
epth=3D$DEPTH --iodepth_batch_complete_min=3D1 --iodepth_batch_complete_max=
=3D$DEPTH --iodepth_batch=3D$BATCH --numjobs=3D1 --group_reporting --gtod_r=
educe=3D0 --disable_lat=3D0 --name=3Dcpu3 --cpus_allowed=3D3 --name=3Dcpu5 =
--cpus_allowed=3D5 --name=3Dcpu7 --cpus_allowed=3D7 --name=3Dcpu9 --cpus_al=
lowed=3D9 --name=3Dcpu11 --cpus_allowed11 --name=3Dcpu13 --cpus_allowed=3D1=
3 --name=3Dcpu15 --cpus_allowed=3D15 --name=3Dcpu17 --cpus_allowed=3D17

NVMf TCP queue configuration is 1 default queue and 101 poll queues.  Conne=
cted to a single remote NVMe ram disk device.
I/O performs normally up to 30 second run, but faults just at the end. Very=
 repeatable.

Thanks for your time --- Mark

[64592.841944] nvme nvme0: mapped 1/0/101 default/read/poll queues.
[64592.867003] nvme nvme0: new ctrl: NQN "testrd", addr 192.168.0.1:4420
[64646.940588] list_add corruption. prev->next should be next (ffff9c1feb2b=
c7c8), but was ffff9c1ff7ee5368. (prev=3Dffff9c1ff7ee5468).
[64646.941149] ------------[ cut here ]------------
[64646.941150] kernel BUG at lib/list_debug.c:28!
[64646.941360] invalid opcode: 0000 [#1] SMP PTI
[64646.941561] CPU: 82 PID: 7886 Comm: io_wqe_worker-0 Tainted: G          =
 O      5.5.0-rc2stable+ #32
[64646.941994] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 0=
6/29/2018
[64646.942349] RIP: 0010:__list_add_valid+0x64/0x70
[64646.942562] Code: 48 89 fe 31 c0 48 c7 c7 40 21 17 89 e8 f9 5c c6 ff 0f =
0b 48 89 d1 48 c7 c7 e8 20 17 89 48 89 f2 48 89 c6 31 c0 e8 e0 5c c6 ff <0f=
> 0b 66 2e 0f 1f 84 00 00 00 00 00 48 8b 07 48 b9 00 01 00 00 00
[64646.943442] RSP: 0018:ffffa78a49137d90 EFLAGS: 00010246
[64646.943687] RAX: 0000000000000075 RBX: ffff9c1ff7ee5a00 RCX: 00000000000=
00000
[64646.944021] RDX: 0000000000000000 RSI: ffff9c0fffe59d28 RDI: ffff9c0fffe=
59d28
[64646.944356] RBP: ffffa78a49137df8 R08: 00000000000006ad R09: ffffffff88e=
c3be0
[64646.944691] R10: 000000000000000f R11: 0000000007070707 R12: ffff9c1feb2=
bc600
[64646.945025] R13: ffff9c1feb2bc7c8 R14: ffff9c1ff7ee5468 R15: ffff9c1ff7e=
e5a68
[64646.945360] FS:  0000000000000000(0000) GS:ffff9c0fffe40000(0000) knlGS:=
0000000000000000
[64646.945739] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[64646.946008] CR2: 00007f4423eb7004 CR3: 000000169940a005 CR4: 00000000007=
606e0
[64646.946343] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[64646.946677] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[64646.947012] PKRU: 55555554
[64646.947138] Call Trace:
[64646.947260]  io_issue_sqe+0x115/0xa30
[64646.947429]  io_wq_submit_work+0xb5/0x1d0
[64646.947615]  io_worker_handle_work+0x19d/0x4c0
[64646.947823]  io_wqe_worker+0xdc/0x390
[64646.947998]  kthread+0xf8/0x130
[64646.948141]  ? io_wq_for_each_worker+0xb0/0xb0
[64646.948349]  ? kthread_bind+0x10/0x10
[64646.948522]  ret_from_fork+0x35/0x40
