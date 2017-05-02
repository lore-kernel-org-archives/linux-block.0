Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29929 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdEBRj4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2017 13:39:56 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tj@kernel.org" <tj@kernel.org>, "jack@suse.cz" <jack@suse.cz>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "scott.bauer@intel.com" <scott.bauer@intel.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "jack@suse.com" <jack@suse.com>
Subject: Re: BUG: KASAN: use-after-free in scsi_exit_rq
Date: Tue, 2 May 2017 17:39:52 +0000
Message-ID: <1493746791.2552.9.camel@sandisk.com>
References: <20170420211849.GB7387@sbauer-Z170X-UD5>
         <1492811357.2499.9.camel@sandisk.com>
         <20170428214647.GG22354@htj.duckdns.org>
         <20170502144125.GK13916@quack2.suse.cz>
In-Reply-To: <20170502144125.GK13916@quack2.suse.cz>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2017-05-02 at 16:41 +0200, Jan Kara wrote:
> So I'm also not aware of any particular breakage this would cause. Howeve=
r
> logically the freeing of request mempools really belongs to
> blk_release_queue() so it seems a bit dumb to move blk_exit_rl() just
> because SCSI stores the fact from which slab cache it has allocated the
> sense buffer in a structure (shost) that it frees under its hands by the
> time blk_release_queue() is called. :-|

Hello Jan,

My concern when I wrote my previous e-mail was that I didn't want to add a
scsi_host_get() / scsi_host_put() pair to the hot path in the SCSI core. Bu=
t
I just realized that scsi_init_rq() and scsi_exit_rq() are not in the hot
path so adding a scsi_host_get() / scsi_host_put() pair should work fine. I
will post a patch.

Bart.
