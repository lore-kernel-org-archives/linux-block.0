Return-Path: <jgross@suse.com>
Subject: Re: [PATCH v2] xen-blkfront: fix kernel panic with negotiate_mq error
 path
To: Manjunath Patil <manjunath.b.patil@oracle.com>,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, roger.pau@citrix.com
Cc: axboe@kernel.dk, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <1540918161-31283-1-git-send-email-manjunath.b.patil@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <2d099bff-648f-e9bf-f2b6-127eb97852fb@suse.com>
Date: Tue, 30 Oct 2018 17:52:39 +0100
MIME-Version: 1.0
In-Reply-To: <1540918161-31283-1-git-send-email-manjunath.b.patil@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 30/10/2018 17:49, Manjunath Patil wrote:
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

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
