Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59373 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdDJXrm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 19:47:42 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "longli@microsoft.com" <longli@microsoft.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "sthemmin@microsoft.com" <sthemmin@microsoft.com>
Subject: Re: [PATCH] block-mq: set both block queue and hardware queue restart
 bit for restart
Date: Mon, 10 Apr 2017 23:47:39 +0000
Message-ID: <1491868058.4199.28.camel@sandisk.com>
References: <1491437781-3565-1-git-send-email-longli@exchange.microsoft.com>
         <1491438735.2787.18.camel@sandisk.com>
         <BN3PR03MB2227E6DBCAE0365A013B7972CE0D0@BN3PR03MB2227.namprd03.prod.outlook.com>
         <1491450335.8994.1.camel@sandisk.com>
         <DM5PR03MB2490E70D9B18A701A81005C8A00D0@DM5PR03MB2490.namprd03.prod.outlook.com>
In-Reply-To: <DM5PR03MB2490E70D9B18A701A81005C8A00D0@DM5PR03MB2490.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-04-06 at 04:21 +0000, KY Srinivasan wrote:
> > -----Original Message-----
> > From: Bart Van Assche [mailto:Bart.VanAssche@sandisk.com]
> > Sent: Wednesday, April 5, 2017 8:46 PM
> > To: linux-kernel@vger.kernel.org; linux-block@vger.kernel.org; Long Li
> > <longli@microsoft.com>; axboe@kernel.dk
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>; KY Srinivasan
> > <kys@microsoft.com>
> > Subject: Re: [PATCH] block-mq: set both block queue and hardware queue
> > restart bit for restart
> >=20
> > On Thu, 2017-04-06 at 03:38 +0000, Long Li wrote:
> > > > -----Original Message-----
> > > > From: Bart Van Assche [mailto:Bart.VanAssche@sandisk.com]
> > > >=20
> > > > Please drop this patch. I'm working on a better solution.
> > >=20
> > > Thank you. Looking forward to your patch.
> >=20
> > Hello Long,
> >=20
> > It would help if you could share the name of the block or SCSI driver w=
ith
> > which you ran into that lockup and also if you could share the name of =
the
> > I/O scheduler used in your test.
>=20
> The tests that indicated the issue were run Hyper-V. The driver is storvs=
c_drv.c
> The I/O scheduler was I think noop.

Hello Long and K.Y.,

Thank you for the feedback. Can you repeat your test with kernel v4.11-rc6?=
 The
patches that went into the block layer for v4.11-rc6 should be sufficient t=
o fix
this:

$ PAGER=3D git log --format=3Dshort v4.11-rc5..v4.11-rc6 block include/linu=
x/blk* =A0
commit 6d8c6c0f97ad8a3517c42b179c1dc8e77397d0e2
Author: Bart Van Assche <bart.vanassche@sandisk.com>

=A0=A0=A0=A0blk-mq: Restart a single queue if tag sets are shared

commit 7587a5ae7eef0439f7be31f1b5959af062bbc5ec
Author: Bart Van Assche <bart.vanassche@sandisk.com>

=A0=A0=A0=A0blk-mq: Introduce blk_mq_delay_run_hw_queue()

commit ebe8bddb6e30d7a02775b9972099271fc5910f37
Author: Omar Sandoval <osandov@fb.com>

=A0=A0=A0=A0blk-mq: remap queues when adding/removing hardware queues

commit 54d5329d425650fafaf90660a139c771d2d49cae
Author: Omar Sandoval <osandov@fb.com>

=A0=A0=A0=A0blk-mq-sched: fix crash in switch error path

commit 93252632e828da3e90241a1c0e766556abf71598
Author: Omar Sandoval <osandov@fb.com>

=A0=A0=A0=A0blk-mq-sched: set up scheduler tags when bringing up new queues

commit 6917ff0b5bd4139e08a3f3146529dcb3b95ba7a6
Author: Omar Sandoval <osandov@fb.com>

=A0=A0=A0=A0blk-mq-sched: refactor scheduler initialization

commit 81380ca10778b99dce98940cfc993214712df335
Author: Omar Sandoval <osandov@fb.com>

=A0=A0=A0=A0blk-mq: use the right hctx when getting a driver tag fails

commit ac77a0c463c1d7d659861f7b6d1261970dd3282a
Author: Minchan Kim <minchan@kernel.org>

=A0=A0=A0=A0block: do not put mq context in blk_mq_alloc_request_hctx

Bart.=
