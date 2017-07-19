Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55859 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932661AbdGSQFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2017 12:05:35 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "yagmur.oymak@gmail.com" <yagmur.oymak@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: 4.12 NULL pointer dereference in kmem_cache_free on USB storage
 removal
Date: Wed, 19 Jul 2017 16:04:48 +0000
Message-ID: <1500480287.2494.1.camel@wdc.com>
References: <alpine.LRH.2.20.1707132319290.24138@math.ut.ee>
         <1499980058.2740.22.camel@wdc.com>
         <952856d9-5f6b-98db-98e3-6348d428e894@gmail.com>
In-Reply-To: <952856d9-5f6b-98db-98e3-6348d428e894@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-07-19 at 08:13 +0300, Yagmur Oymak wrote:
> On 07/14/2017 12:07 AM, Bart Van Assche wrote:
> > On Thu, 2017-07-13 at 23:24 +0300, Meelis Roos wrote:
> > > [258062.320700] RIP: 0010:kmem_cache_free+0x12/0x160
> > > [258062.320886] Call Trace:
> > > [258062.320897]  scsi_exit_rq+0x4d/0x60
> > > [258062.320909]  free_request_size+0x1c/0x30
> > > [258062.320923]  mempool_destroy+0x1d/0x60
> > > [258062.320935]  blk_exit_rl+0x1b/0x40
> > > [258062.320946]  __blk_release_queue+0x7d/0x120
> > > [258062.320959]  process_one_work+0x1af/0x340
> > > [258062.320972]  worker_thread+0x43/0x3e0
> > > [258062.320984]  kthread+0xfe/0x130
> > > [258062.320995]  ? create_worker+0x170/0x170
> > > [258062.321007]  ? kthread_create_on_node+0x40/0x40
> > > [258062.321022]  ret_from_fork+0x22/0x30
> >=20
> > Thank you for your report. Can you apply commit 8e6882545d8c ("scsi: Av=
oid
> > that scsi_exit_rq() triggers a use-after-free") on top of kernel v4.12 =
and
> > retest? That commit has been tagged "Cc: stable" so I hope that this pa=
tch
> > will be included in kernel v4.12.1. However, that kernel is not yet ava=
ilable
> > unfortunately ...
>=20
> That patch fixes the problem, as far as I tested. However, it still is
> not included in stable by 4.12.2. The problem persists there, and is
> fixed when this patch is applied on top of it. What to to about it?=20
=20
Hello Yagmur,

[ Please don't top-post -- this is considered annoying in the Linux communi=
ty ]

Since kernel v4.13-rc1 has been released and since commit 8e6882545d8c is i=
ncluded
in v4.13-rc1 I assume that it won't take long before a stable kernel is rel=
eased
that includes that commit. BTW, Greg just announced that that commit will b=
e included
in the next v4.11 stable kernel. See also https://lkml.org/lkml/2017/7/19/4=
94.

Bart.=
