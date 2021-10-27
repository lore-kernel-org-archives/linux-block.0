Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA55C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 10:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622B360EFE
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 10:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhJ0Kj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 06:39:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17169 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbhJ0Kj2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 06:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635331023; x=1666867023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A2/MsW24N28+PbWPQ6txr6/OsbzCtHdk8bzNuQQNt5Y=;
  b=ED5lX61XBM0zgpDMpgmLjHL0D4IB/2cklk32Ggb40SBVgsipATptVK57
   UYXXpBYXHiMREPQ0piuHkSmyGESpeckmHy7XIh5CEN0zeN8GO70gn6IeM
   OZvfCDNFNeqPmTjD64ve1kQLUPhg1eq6NRS9qUGaMOvPkdfY1tcAqH9H0
   8nCliAlmbhe3LHzCWIn7muNNsAcKIzsh/WXPGpPsDa7fskpO9e1DfRuFH
   IeWwrCqQwLnC5UKa74zrdqysp1eA+OqZdVtwEb69hbAWsEBZrLSN0KHv3
   M4WptOX4CwfrkHTXbEjYXslGN1TTxdz3ugjgh8MoPfUzfyD2VuBX99/Ku
   g==;
X-IronPort-AV: E=Sophos;i="5.87,186,1631548800"; 
   d="scan'208";a="183958938"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 18:37:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNA/rhfh46IC4WEKAbjeGKCDr3x9XSv7nZya9diCUS70ZmMzNOxoGVdULQi1W9SGhMr3AevnpTDFOuyTEUlPoWAFNVocrWj7FDLb4hiu/8Qb25vwl9VF9ikdXj1Bp/Pl+Y4bWz8ihaHweec3WA9LI/ZtIMI+VrIsceglfiGAT0M8RTfiuDQe88fEo3y37DcW/m4WP+6AUT6CILXaMdrGAnKieyH7SMSCjAsn6wrUAuC4oHiuq6Xrem3T4U8ZdAgDP+6d0rykaaZE5Xiq66aJcbuaGDqkvyKQiUOLw/dlZPcEgVFTBK4/SnFSKccDrEp3wX8ElHZWOxzdNQQAf1dYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKNGmhsaKefuyIGJjeIpUGPQb8963UbA2FDwE/IbnUA=;
 b=bNDqSGkBfvv0eSFhFKABwWwofhE1H2cJdYlOjbszOw5GMBikAb1Ml/kfx6HAf1u1+Mg0k4euCnPsfGdl/ZKDOnGoh/VnRzA+Xl4QY1MK09QY27fBcZ2xuz6LcZcPJDmxiOrGHbpLVursZUv+D2N2EMeifz5iIFKSJ6YcXkiL/wo1CLsAsotZR9JWAYfG/xiaU53txvWf/sHFHfGiKIyNlRjihmokIY09I8gthUm1XLCv02rkrJhVtaFNPCMmlo/p1TA+yvt8fNQizyjX0fM7b2DCu7hx1i8HGuAeRn/OOaL34C9Y5u/l/HzAUwRnR+F3EFnRDcE5MM77ZeXHNvuBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKNGmhsaKefuyIGJjeIpUGPQb8963UbA2FDwE/IbnUA=;
 b=GPnPgZhMw39AYxer/z/RJVaf/QwRvWW8tiSMHTPQuKHwYslz7dQM+KBjqTPJY3hVODFHpTe0EY+0mCFwW0DAaC2/Fjk53l60dB7TasGiB08YFi4akCfyy/01u5Wcq77i+zN+f+hDArxgnaU+egEgEJVr8F/E9eSxW7mObR6actw=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BY5PR04MB6931.namprd04.prod.outlook.com (2603:10b6:a03:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 10:37:00 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 10:37:00 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] blktests block/029 triggered NULL pointer on latest
 linux-block/for-next
Thread-Topic: [bug report] blktests block/029 triggered NULL pointer on latest
 linux-block/for-next
Thread-Index: AQHXyx6R5wBxL9OBcUCxaRAv3tP/8w==
Date:   Wed, 27 Oct 2021 10:36:59 +0000
Message-ID: <20211027103657.volbawehcsaolz4h@shindev>
References: <CAHj4cs-Co0mnojrWKGs5bhNrywTVW6OGtDp4yVN8RzaHPO4bog@mail.gmail.com>
 <2b2282c2-67f8-db19-cb13-1fc90664dada@kernel.dk>
 <CAHj4cs9R5ZV+WaOGxWot8Qj9cth2S3wvT4-R0qZc5G=rLPDMAQ@mail.gmail.com>
In-Reply-To: <CAHj4cs9R5ZV+WaOGxWot8Qj9cth2S3wvT4-R0qZc5G=rLPDMAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fccddaac-2cfb-4bc9-f8b6-08d99935b548
x-ms-traffictypediagnostic: BY5PR04MB6931:
x-microsoft-antispam-prvs: <BY5PR04MB693119E2EC17979F251A8136ED859@BY5PR04MB6931.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LNtFzdCuWiiaTqEeVw7D9Klt298EdWg1ZGe1tkUUVVnbQhGZQ5pVc99B2CLWAjowiGw3q7PBTaTZNlGrOvcceU9os0OHlV1ewtC/l+hhGlM/P2s2lbGCpkKu/D/CQyogEdfYzDq7eKWQcSX1/7Nfu2/WBoNHnMWDoKuLn+OEt+bpSnf9VaU6EBnHBCNMx4nWnVfDG7nHkRD+Wj3G8tMklby9fN8YntvTDDrrFzqyF1/4zLEbvp55zsiRbbB1h4OUqlNJNb24lystFwOXUhIvqs1WisxW5op3xyUKAlfVKAEzFLpF2IRetrVYHT2d0ZLS4bVuyhFO63m093EUCM6RkQUAnDq0u8PUAX+4K3+zV+ylz6NNu9xbIJxfvc4g921WteokpRdriWKTnhbZAf2woPDcYo1eIOK/DDV5JzbE47jJHN6qVKlmqxAuwXU+uGKlESIXWEF4Y+5XY5Cs+oVD4Wsqt8NmnyJ2MkX0x0aQdF3FiQBd2V1NRyrxq+WJS92La1o9+Y1lGpkRgyDMEpXW14dKn4K4lUoy6PpTNI+lG8Y2DdV1b/XN7aNt7dgGU5Ji65O+rIfbZMcPDYB42qYWwz2r/ZqX4bZGShlQGU12tSErBVbOUUvVLfJCqmOIFg90l/LABZsyWxEaDSrHAXeL0zr/LwW7yrZZuWRVfFZdNSMxxSAP3Xes13FjHte8/CeDHXyIZ5PBRwNFQ+XbLB/wWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(8936002)(26005)(66556008)(6916009)(6486002)(91956017)(2906002)(66476007)(508600001)(44832011)(186003)(1076003)(45080400002)(8676002)(76116006)(64756008)(38100700002)(82960400001)(66446008)(83380400001)(5660300002)(122000001)(6512007)(316002)(38070700005)(54906003)(9686003)(4326008)(86362001)(6506007)(53546011)(4001150100001)(33716001)(71200400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m1pI3Lw5iJS7N+1bTYZCuidyRAfv8sVegD2tPB86KVIBTQPkR0dQ9JYmkN6T?=
 =?us-ascii?Q?qOJRbHmC7a/h6toNEBJlf6DZix1kEF0isn7niqqastG2uGeHgJpiqzfHlaud?=
 =?us-ascii?Q?76hf0qIXiKmGejGrkt5Y95/L+oYgr707J/iCX0FRSxdS3l9m+qGNrJ/2BxU9?=
 =?us-ascii?Q?OmCcsUhOar+MhAwv7PTjcXQulev/jUDTxtwzvyigRJ8w9WNxSM/2EXr1QSTG?=
 =?us-ascii?Q?WyARNvVjTbcxgMEvJblr2bFT0+ogQBF3u15WcVh3z+0+AEBpJNOsdusClE2C?=
 =?us-ascii?Q?FRj9fHZUrts9s9OSBmNY6ug7nDMNHF4TjSz2l7tZSl0vMEHzAEm45HybTj3Q?=
 =?us-ascii?Q?QN1yPu6wK4vRYbNACbC66FtrG8vxMWkHUGJ0vz17yqNZwmk203d63K4Fu96o?=
 =?us-ascii?Q?IfHAzUTy3dKk967Zifd7hGn9RxRU2E7JQ7xGPZc3E47HItsrSGFiXLf+nzJZ?=
 =?us-ascii?Q?b2b5QODSdxhY4i+ML0yTE0tzdlZNKd32mLQJLHXmSxOolIymHx73DI8T4LsP?=
 =?us-ascii?Q?/QSepU0Ewx6vTg/jFrdeegA/5xwZ+QRy7D+ozh/K5lzbwQMQ8fWd3iLW4idO?=
 =?us-ascii?Q?/OzJ718AEOKMt1uwsQ+PEM87E7MKwDbnm3lMn1SAav62MMAhN9/L4/hOtXyV?=
 =?us-ascii?Q?3DaCflfjT57rD3lCP7NQ0OuzWy444FdTsW9Kq4R8j+EyekDF7PTt9bImkcY3?=
 =?us-ascii?Q?HYUwbd5XZ7FifoHF83aZ/egc2EXCQiCf9pUVHe1yzeEMtxvjK269ExnllOZz?=
 =?us-ascii?Q?+c9H+lUlBgDdvU0AGO5R6VwphrMiIBq1U81P4NDx5aMwgN1e0Je60EomVPhF?=
 =?us-ascii?Q?iQMnXZ45Iz4nIftSYUsc8DcvpNle1PfOXe2tpE/kep3o5pB+jHiS2rrHOJwd?=
 =?us-ascii?Q?VPBHC8cfVWQjhAL5163pq5TopmQu2qaEfeoyKkhwJQw/H4K8AD+L7zq2uPGc?=
 =?us-ascii?Q?SYqxrdUmc6SRI8brjR4dnzSgtVpWgEcuU8k7Icwak9NQM1tjIp1ZLIHcZIZQ?=
 =?us-ascii?Q?5wKLpDxD7fkzxD8KpZgjDMUXOGIXW/+g76c6Tm/2OyQ8bvgQ5HvekoaXPgCR?=
 =?us-ascii?Q?S5yyg8/X/3bj3ks9uFLIvM9SyYa2dd4CX5HTu9pEoVG/8kTaZr93lnbG0hcu?=
 =?us-ascii?Q?yIcXjATWaibyAPX8C4V6on4x3nfi18zD7sSAkhLVMTtzp3B7b+Mn/UQ7DiYr?=
 =?us-ascii?Q?WScIfxSViC0LZkGPcM5x4XaD5CvWNuVDeTCBhXaygf2fw5nLDEgVbBGfxgW/?=
 =?us-ascii?Q?CQCp/J/BozWLvTE4Qzpe/yYssCYh0NNC3pqjxuIkaFYm9OWS1PjQZrdURVRq?=
 =?us-ascii?Q?SlVsgmZGUYV2HxF2cVsR/e2ICBfZhdawGsSO1ubMFkTcj5aeHca7W80vW/oC?=
 =?us-ascii?Q?clp9R0Lx2hFG9lmOtQl0a/Ds2mvEEkH9cVKjyfiDb+kZSv6mvDsjXLPq4EAz?=
 =?us-ascii?Q?FUGheCuAJaqvazyR1/64B4aLInRwNiDlq7YorQ5rDqFcmKqhwpwH+vPsCETN?=
 =?us-ascii?Q?vrmytkkzmvkX9xeI80l/Ly4d498/FWzvsrrV+BodOuTGFx3IoLuSEkNNAHgs?=
 =?us-ascii?Q?VCNDR5wVDWaOH86tDtbhSspfjTX9xBx30x6/mTcRYxkdy4YnTXzdG8sgh0DU?=
 =?us-ascii?Q?9+7EwfajK5SNYS5M9g1YIN07An3ZHik0tgHq8qQzg5LyeeDkW9eG7fGUutbh?=
 =?us-ascii?Q?MkcNTdCdDkhALl5ZqWoX5U9jOMs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9D016E45F7EE740B29275C4EDCC320C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccddaac-2cfb-4bc9-f8b6-08d99935b548
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 10:37:00.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tvrGVxuY7vJXq4pbV9jL5I3ML90nyBPHwU16zLmZmAoLt8M8SsnsVZne+DVzfU4ipLQZ3Hz/B+6Nj9Axa1huw6rqyr9FKpIjGUowGmst9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6931
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 27, 2021 / 14:06, Yi Zhang wrote:
> Hi Jens
>=20
> It still can be reproduced with the latest for-next update below, and
> it's 100% reproduced on my x86_64 environment.
>=20
> 7c5835a8640c (HEAD -> for-next, origin/for-next) Merge branch
> 'for-5.16/scsi-ma' into for-next

I also observe the null-ptr-deref during blktests block/029 run, using
for-next branch tip, git hash 7c5835a8640c. With my configuration, KASAN
reported null-ptr-deref in blk_mq_map_swqueue().

I bisected and found that the commit 0a593fbbc245 ("null_blk: poll queue
support") triggers it. Reverting this commit from the tip of for-next
branch, the KASAN null-ptr-deref message was not observed.

>=20
> On Tue, Oct 26, 2021 at 10:44 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 10/26/21 3:33 AM, Yi Zhang wrote:
> > > Hello
> > >
> > > Below NULL pointer was triggered[2] with blktests block/029 on latest
> > > linux-block/for-next, pls check it.
> > >
> > > [1]
> > > 9b3b463f3955 (HEAD -> for-next, origin/for-next) Merge branch
> > > 'for-5.16/block' into for-next
> > >
> > > [2]
> > > [  110.508269] run blktests block/029 at 2021-10-26 05:29:11
> > > [  110.535182] null_blk: module loaded
> > > [  110.674174] Kernel attempted to read user page (d8) - exploit
> > > attempt? (uid: 0)
> > > [  110.674212] BUG: Kernel NULL pointer dereference on read at 0x0000=
00d8
> > > [  110.674236] Faulting instruction address: 0xc0000000009414c4
> > > [  110.674251] Oops: Kernel access of bad area, sig: 11 [#1]
> > > [  110.674272] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA=
 PowerNV
> > > [  110.674308] Modules linked in: null_blk rfkill sunrpc joydev ofpar=
t
> > > ses enclosure scsi_transport_sas i40e at24 powernv_flash mtd
> > > tpm_i2c_nuvoton regmap_i2c ipmi_powernv rtc_opal crct10dif_vpmsum
> > > opal_prd ipmi_devintf i2c_opal ipmi_msghandler fuse zram ip_tables xf=
s
> > > ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea
> > > sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm
> > > vmx_crypto crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirk=
s
> > > [  110.674485] CPU: 60 PID: 3469 Comm: check Not tainted 5.15.0-rc6+ =
#3
> > > [  110.674520] NIP:  c0000000009414c4 LR: c000000000941638 CTR: 00000=
00000000000
> > > [  110.674556] REGS: c00000003aea77c0 TRAP: 0300   Not tainted  (5.15=
.0-rc6+)
> > > [  110.674580] MSR:  900000000280b033
> > > <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 84428482  XER: 00000006
> > > [  110.674634] CFAR: c000000000941648 DAR: 00000000000000d8 DSISR:
> > > 40000000 IRQMASK: 0
> > > [  110.674634] GPR00: c000000000941638 c00000003aea7a60
> > > c0000000028a9a00 c00000001ad8a8c0
> > > [  110.674634] GPR04: c000000089287e00 0000000000000001
> > > 00000000ffffffff ffffffffffffffff
> > > [  110.674634] GPR08: 00000000000000d8 0000000000000000
> > > 00000000000000d8 0000000000000400
> > > [  110.674634] GPR12: 0000000000008000 c000000ffff9e600
> > > c00000001ac416c0 0000000000000000
> > > [  110.674634] GPR16: 0000000000000001 0000000000000001
> > > 0000000000000000 c009dfffff94f300
> > > [  110.674634] GPR20: 0000000000000000 0000000000000000
> > > c0000000028e72b8 c0000000028e78a0
> > > [  110.674634] GPR24: 0000000000000001 0000000000000008
> > > c0000000aaa53838 c009dfffff94f388
> > > [  110.674634] GPR28: c00000009d527698 c009dfffff94f3a0
> > > 0000000000000002 c0000000aaa53858
> > > [  110.674942] NIP [c0000000009414c4] blk_mq_map_swqueue+0x1a4/0x490
> > > [  110.674982] LR [c000000000941638] blk_mq_map_swqueue+0x318/0x490
> > > [  110.675021] Call Trace:
> > > [  110.675038] [c00000003aea7a60] [c000000000941638]
> > > blk_mq_map_swqueue+0x318/0x490 (unreliable)
> > > [  110.675080] [c00000003aea7b10] [c0000000009420e4]
> > > blk_mq_update_nr_hw_queues+0x244/0x480
> > > [  110.675128] [c00000003aea7bd0] [c00800000f3e2d60]
> > > nullb_device_submit_queues_store+0x98/0x120 [null_blk]
> > > [  110.675182] [c00000003aea7c20] [c000000000648aa8]
> > > configfs_write_iter+0x118/0x1e0
> > > [  110.675224] [c00000003aea7c70] [c000000000521494] new_sync_write+0=
x124/0x1b0
> > > [  110.675281] [c00000003aea7d10] [c000000000524794] vfs_write+0x2c4/=
0x390
> > > [  110.675299] [c00000003aea7d60] [c000000000524b08] ksys_write+0x78/=
0x130
> > > [  110.675316] [c00000003aea7db0] [c00000000002d648]
> > > system_call_exception+0x188/0x360
> > > [  110.675335] [c00000003aea7e10] [c00000000000c1e8]
> > > system_call_vectored_common+0xe8/0x278
> > > [  110.675355] --- interrupt: 3000 at 0x7fffa1aefee4
> > > [  110.675367] NIP:  00007fffa1aefee4 LR: 0000000000000000 CTR: 00000=
00000000000
> > > [  110.675393] REGS: c00000003aea7e80 TRAP: 3000   Not tainted  (5.15=
.0-rc6+)
> > > [  110.675429] MSR:  900000000280f033
> > > <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48422488  XER: 00000000
> > > [  110.675482] IRQMASK: 0
> > > [  110.675482] GPR00: 0000000000000004 00007fffc592dd30
> > > 00007fffa1be7000 0000000000000001
> > > [  110.675482] GPR04: 0000000143297fc0 0000000000000002
> > > 0000000000000010 00000001432bd791
> > > [  110.675482] GPR08: 0000000000000000 0000000000000000
> > > 0000000000000000 0000000000000000
> > > [  110.675482] GPR12: 0000000000000000 00007fffa1d2afa0
> > > 0000000000000000 0000000000000000
> > > [  110.675482] GPR16: 000000010dfd87b8 000000010dfd94d4
> > > 0000000020000000 000000010deeae80
> > > [  110.675482] GPR20: 0000000000000000 00007fffc592df54
> > > 000000010df83128 000000010dfd89bc
> > > [  110.675482] GPR24: 000000010dfd8a50 0000000000000000
> > > 0000000143297fc0 0000000000000002
> > > [  110.675482] GPR28: 0000000000000002 00007fffa1be16d8
> > > 0000000143297fc0 0000000000000002
> > > [  110.675718] NIP [00007fffa1aefee4] 0x7fffa1aefee4
> > > [  110.675750] LR [0000000000000000] 0x0
> > > [  110.675769] --- interrupt: 3000
> > > [  110.675789] Instruction dump:
> > > [  110.675798] 2c290000 41820168 e91c0600 7bc926e4 e95c0048 7d28482a
> > > 7d29a82e 79291f24
> > > [  110.675845] 7d2a482a f93d0000 390900d8 7d489214 <7d08a02a> 7d08883=
9
> > > 4082004c 7d0050a8
> > > [  110.675885] ---[ end trace b9b604499c6b5b71 ]---
> > > [  110.814135]
> > > [  111.814148] Kernel panic - not syncing: Fatal exception
> > > [  113.674122] ---[ end Kernel panic - not syncing: Fatal exception ]=
---
> >
> > Should be fixed in my current for-next branch.
> >
> > --
> > Jens Axboe
> >
>=20
>=20
> --=20
> Best Regards,
>   Yi Zhang
>=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
