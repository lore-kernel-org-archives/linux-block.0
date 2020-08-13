Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F21DC433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 02:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20022205CB
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 02:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cjIiYaFO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lugS+BEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMCiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 22:38:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53335 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMCiY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 22:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597286302; x=1628822302;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2NLBq3hMle5Sd+baaX2OZwmc/FL7/8Vc0an8XiEml/Y=;
  b=cjIiYaFOyUIExdYX/daCxSJvw+flNWs8GZ03/SXTUaEzC0RUfmi1ragB
   UqUd01MsyKSHtTx+93SV0D6YrqocwEOT+UQkKOyJHxGhTIofoU8eJi5ON
   2FrESZFozl3T8zyRE6eBXUhDlXjqneWJfCB61P3f8Rj0w2JyYTDmAn1zp
   CpuOf5PghAMWeVFFMvFgd3daAXs5uOmj4TS/+cF3XRMLhgqYStzg4v4SO
   H7+Si5l/oiR5SVvfD0h7npG1YUTgiygg+ORURCy9MLPgUtbCGWn03z0m/
   m/mn6Uaj9wAMb01I/13QHWUjVmrTjgklDa56qeMJd/QTGvueDmn8imSda
   Q==;
IronPort-SDR: 1DsSKYx08gBQZ38Mru32PSrKDgGW69i1oMBK+IoSEkFYWLBxzDWJthZz113bqAeB+iBUb+Ywg7
 zGSaCxqHA9LshOxk2hTfrMEoX5wMO/D3Te+EqBf8+FEDYwxpwpXSSW7IPzjIbqVMok7ef5btwb
 qrafxIrkDxWGnuK/eGMdI2LKkZogUGI70zUyJ13de7I+G3686L4lZSsjvmJROW2gjrWlm8llMI
 55IhV7bW+PDClj3ppUu0gYzkD7b09hmzaCvGa79RRSRasnQriXd6rsqadBbgdC/qLJMHvEbkpc
 2Hg=
X-IronPort-AV: E=Sophos;i="5.76,306,1592841600"; 
   d="scan'208";a="254225150"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 10:38:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCUHbnK5b0n6NqY4gYoVJBA+BFjUpiVVlJDZnc3U8O4qgM3J8BE5JII5e5biMvjEhzdyY3QDJFRv92VOqvvzSo5H6GUv/Jac1hsI96uhzFx30dzA5/xoFSNNJsaEZdjXdDmSfCbAXs6hXuLtY1OyGVQzrf8cbZU88cl4+wF+lpQgGCNumXWCs14fQelGjN5hdpEkIYdQl4BJc2r1EHvaFyAyBhooiEp4fFGZ9xaklX9vFmcseXGGoxBl5p87+R3VQR1cLoi+vPjKPL2vK79TPlHYKv+AYaZ3Zi3kRNDmgLu2jPlwP0f+Q/uU/LyE5z3eUKghUlB6xglfi9EbaEe4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bHUAZTwaPRh0sfRzywkgg2P637PtNCBg7npzsalulc=;
 b=DdrGsp+JAqdJEamncDbePkoZm0xvY7Imamj7oyvcspV0ccOqg6owWkSJTi26MjbOqAIbHPT1Dxxc3rnkMXmIiPD3oJvvVD7HmN8gjFJmImzhGpT9QJtFCt0mjEycmgkUfjcLneLFrKq5VJAkdFEBhcNL3E/yeMNBBoY9qwbHDbNHviMPInn967UO995e/d2uICAC4IxtRpryyRh+BwAeDDC7c85mmuNqf7QS6uZPKkyYN0iXO6FOl3FexwUu9ltdAEhmm8rIgsKg3tFdVqyyrP6UGJ7iRcvXL2sb6BwJrisykj6z2SITzCjThsFUv3Hh7R+K5o5GoTsCsmzc3cBgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bHUAZTwaPRh0sfRzywkgg2P637PtNCBg7npzsalulc=;
 b=lugS+BEmy1cV88ZRGLR+sdL3kxsoKUjtS+Q0Slc0JGIPVjqA6kVkK2I5EwtheSBfbLSq1A9AvasAb4XIk+vYdUzbysy6IoqvvS1a5/XaReZz5feHc18uT2aIkM2IbpKwecgL6JRwRR7WbManPQ23psMHxOU+mPNBTAAY1kPH/DE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4871.namprd04.prod.outlook.com (2603:10b6:a03:4e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 02:38:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 02:38:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] nvme: Use spin_lock_irq() when taking the ctrl->lock
Thread-Topic: [PATCH v2] nvme: Use spin_lock_irq() when taking the ctrl->lock
Thread-Index: AQHWcP/N3M3Ik/Umo0KIaIZ27EFWNw==
Date:   Thu, 13 Aug 2020 02:38:20 +0000
Message-ID: <BYAPR04MB496599E8B5ECCEBEE3E461CE86430@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200812232444.18310-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90cba969-9ce8-4c95-360a-08d83f31f151
x-ms-traffictypediagnostic: BYAPR04MB4871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4871A27ED024714D440B08B486430@BYAPR04MB4871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YY14KoncR9VdC3tLvgJbWBFYI5ByEhNAr5tSSmp04nzeneC4l3nHTmCVkv6MF6hO0IF4bSN3S/SALCGtGEgIT/kGH/gV+0YT9VYUQyGuR5lg8XZk+M32yQtdJxjfRssP2/S3JCPB915FJM8khmRARqdeUA+Kfm69YjLb0VXVFykSK6YD4ofMpBSntczQ0mO+HsUHLE/R/eKEzAvUHuDpRlV9qr5HOsFgBLnmCgyqDePYMowb1ZuTmJbnpWzuyts651xdyIRWMzqju1CBwCRvflhRQ4gY60lf3EfT4OJjHRnsXjrprywtVxRMcS6K6DcMzIzePgh3xttywp2513UMRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(8676002)(8936002)(110136005)(54906003)(66446008)(66556008)(9686003)(5660300002)(26005)(33656002)(64756008)(52536014)(2906002)(66946007)(66476007)(83380400001)(316002)(478600001)(55016002)(76116006)(4326008)(6506007)(86362001)(53546011)(186003)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TDzgBpNeI0BB4Vs5Sv4xAJCh3KspbonqBn2x0HOju7qfY5eFOkKk3SkYd4+MAFCUo0O/fjrvyZgrsN/wd5BUUP8UPZPPhUM48x/fPyClZHz8FiXWf8+A2LcLGEKki3WbSrAxRXbVnfTwLGSf6GiN+MgOZCIJL5G6sndSO0Yl9YsHu6EvxQvpZ5Nre40yg2NK8tztzFudD0QchynQg6UU2DpgyYXOWeYAxpVmvkPEVmVQnqH5piljuTANHcBtzkg4PleHd3ajZdmnfJKyULNLkFw0kurOe6SBlFYgEEt2LuMNaCRx1rT3oxuOIPnVFcAZbS9C6RYXRkPNmFImrWMEV1CYd8XL7ELCozh4gXfxxDFY6pEIhFeVNZ9uKtavVE6n6N3Re8S+bCskJSmgjNwhLjRv63iVVA7XC8p3yVYBTcfvizZKHMnO54KeBwiaLWSDnSy8Xz6iu+IML2fg1u+tIJ+hihJh6IV8UqpMXPa4Zf+SzymW7yJbd5UEqQ0o94LAyuCLR+sHspbhDLkEPLCqmOVrJClGvMBR0A2g9Mz+jksld7PIpaLTHdK8Ik9tQw+U4RetKuB1vKIIuvPPvcK+kPZ3jsG8UeHLS34Kmjerx6Up5ejRUB6OmdvdxQIkZYqaAmfHz51GkjSK+ZRRMwpMJw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cba969-9ce8-4c95-360a-08d83f31f151
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 02:38:20.6214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Bq3Fxvph4ERMIxQ4eF6KN7RTwp/SaB/FnUHiAyABbTjxe6BZO3QYn6acHiqL7wJt6lvIUJKlaDIfLGJvgMRQRIN3ozJv41/t9UukSa8MoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/20 16:25, Logan Gunthorpe wrote:=0A=
> When locking the ctrl->lock spinlock IRQs need to be disabled to avoid a=
=0A=
> dead lock. The new spin_lock() calls recently added produce the=0A=
> following lockdep warning when running the blktest nvme/003:=0A=
> =0A=
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>      WARNING: inconsistent lock state=0A=
>      --------------------------------=0A=
>      inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.=0A=
>      ksoftirqd/2/22 [HC0[0]:SC1[1]:HE0:SE0] takes:=0A=
>      ffff888276a8c4c0 (&ctrl->lock){+.?.}-{2:2}, at: nvme_keep_alive_end_=
io+0x50/0xc0=0A=
>      {SOFTIRQ-ON-W} state was registered at:=0A=
>        lock_acquire+0x164/0x500=0A=
>        _raw_spin_lock+0x28/0x40=0A=
>        nvme_get_effects_log+0x37/0x1c0=0A=
>        nvme_init_identify+0x9e4/0x14f0=0A=
>        nvme_reset_work+0xadd/0x2360=0A=
>        process_one_work+0x66b/0xb70=0A=
>        worker_thread+0x6e/0x6c0=0A=
>        kthread+0x1e7/0x210=0A=
>        ret_from_fork+0x22/0x30=0A=
>      irq event stamp: 1449221=0A=
>      hardirqs last  enabled at (1449220): [<ffffffff81c58e69>] ktime_get+=
0xf9/0x140=0A=
>      hardirqs last disabled at (1449221): [<ffffffff83129665>] _raw_spin_=
lock_irqsave+0x25/0x60=0A=
>      softirqs last  enabled at (1449210): [<ffffffff83400447>] __do_softi=
rq+0x447/0x595=0A=
>      softirqs last disabled at (1449215): [<ffffffff81b489b5>] run_ksofti=
rqd+0x35/0x50=0A=
> =0A=
>      other info that might help us debug this:=0A=
>       Possible unsafe locking scenario:=0A=
> =0A=
>             CPU0=0A=
>             ----=0A=
>        lock(&ctrl->lock);=0A=
>        <Interrupt>=0A=
>          lock(&ctrl->lock);=0A=
> =0A=
>       *** DEADLOCK ***=0A=
> =0A=
>      no locks held by ksoftirqd/2/22.=0A=
> =0A=
>      stack backtrace:=0A=
>      CPU: 2 PID: 22 Comm: ksoftirqd/2 Not tainted 5.8.0-rc4-eid-vmlocalye=
s-dbg-00157-g7236657c6b3a #1450=0A=
>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04=
/01/2014=0A=
>      Call Trace:=0A=
>       dump_stack+0xc8/0x11a=0A=
>       print_usage_bug.cold.63+0x235/0x23e=0A=
>       mark_lock+0xa9c/0xcf0=0A=
>       __lock_acquire+0xd9a/0x2b50=0A=
>       lock_acquire+0x164/0x500=0A=
>       _raw_spin_lock_irqsave+0x40/0x60=0A=
>       nvme_keep_alive_end_io+0x50/0xc0=0A=
>       blk_mq_end_request+0x158/0x210=0A=
>       nvme_complete_rq+0x146/0x500=0A=
>       nvme_loop_complete_rq+0x26/0x30 [nvme_loop]=0A=
>       blk_done_softirq+0x187/0x1e0=0A=
>       __do_softirq+0x118/0x595=0A=
>       run_ksoftirqd+0x35/0x50=0A=
>       smpboot_thread_fn+0x1d3/0x310=0A=
>       kthread+0x1e7/0x210=0A=
>       ret_from_fork+0x22/0x30=0A=
> =0A=
> Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported a=
nd Effects log pages")=0A=
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>=0A=
=0A=
Thanks for this fix, looks good.=0A=
=0A=
Tested-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
