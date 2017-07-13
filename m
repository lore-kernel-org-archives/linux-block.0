Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30395 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbdGMVHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2017 17:07:47 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mroos@linux.ee" <mroos@linux.ee>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: 4.12 NULL pointer dereference in kmem_cache_free on USB storage
 removal
Date: Thu, 13 Jul 2017 21:07:39 +0000
Message-ID: <1499980058.2740.22.camel@wdc.com>
References: <alpine.LRH.2.20.1707132319290.24138@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707132319290.24138@math.ut.ee>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-07-13 at 23:24 +0300, Meelis Roos wrote:
> [258062.320700] RIP: 0010:kmem_cache_free+0x12/0x160
> [258062.320886] Call Trace:
> [258062.320897]  scsi_exit_rq+0x4d/0x60
> [258062.320909]  free_request_size+0x1c/0x30
> [258062.320923]  mempool_destroy+0x1d/0x60
> [258062.320935]  blk_exit_rl+0x1b/0x40
> [258062.320946]  __blk_release_queue+0x7d/0x120
> [258062.320959]  process_one_work+0x1af/0x340
> [258062.320972]  worker_thread+0x43/0x3e0
> [258062.320984]  kthread+0xfe/0x130
> [258062.320995]  ? create_worker+0x170/0x170
> [258062.321007]  ? kthread_create_on_node+0x40/0x40
> [258062.321022]  ret_from_fork+0x22/0x30

Hello Meelis,

Thank you for your report. Can you apply commit 8e6882545d8c ("scsi: Avoid
that scsi_exit_rq() triggers a use-after-free") on top of kernel v4.12 and
retest? That commit has been tagged "Cc: stable" so I hope that this patch
will be included in kernel v4.12.1. However, that kernel is not yet availab=
le
unfortunately ...

Thanks,

Bart.=
