Return-Path: <prvs=835290d02=roger.pau@citrix.com>
Date: Wed, 31 Oct 2018 09:22:25 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Manjunath Patil <manjunath.b.patil@oracle.com>
CC: <boris.ostrovsky@oracle.com>, <jgross@suse.com>, <konrad.wilk@oracle.com>,
	<axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] xen-blkfront: fix kernel panic with negotiate_mq
 error path
Message-ID: <20181031082225.zp2cnrfuinpbilv5@mac.citrite.net>
References: <1540918161-31283-1-git-send-email-manjunath.b.patil@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <1540918161-31283-1-git-send-email-manjunath.b.patil@oracle.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 30, 2018 at 09:49:21AM -0700, Manjunath Patil wrote:
> info->nr_rings isn't adjusted in case of ENOMEM error from
> negotiate_mq(). This leads to kernel panic in error path.
> 
> Typical call stack involving panic -
>  #8 page_fault at ffffffff8175936f
>     [exception RIP: blkif_free_ring+33]
>     RIP: ffffffffa0149491  RSP: ffff8804f7673c08  RFLAGS: 00010292
>  ...
>  #9 blkif_free at ffffffffa0149aaa [xen_blkfront]
>  #10 talk_to_blkback at ffffffffa014c8cd [xen_blkfront]
>  #11 blkback_changed at ffffffffa014ea8b [xen_blkfront]
>  #12 xenbus_otherend_changed at ffffffff81424670
>  #13 backend_changed at ffffffff81426dc3
>  #14 xenwatch_thread at ffffffff81422f29
>  #15 kthread at ffffffff810abe6a
>  #16 ret_from_fork at ffffffff81754078
> 
> Cc: stable@vger.kernel.org
> Fixes: 7ed8ce1c5fc7 ("xen-blkfront: move negotiate_mq to cover all cases of new VBDs")
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>

Acked-by: Roger Pau Monn� <roger.pau@citrix.com>

Thanks, Roger.
