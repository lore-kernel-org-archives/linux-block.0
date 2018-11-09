Return-Path: <jgross@suse.com>
Subject: Re: [PATCH v2] xen-blkfront: fix kernel panic with blkfront_remove()
To: Manjunath Patil <manjunath.b.patil@oracle.com>,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, roger.pau@citrix.com
Cc: axboe@kernel.dk, xen-devel@lists.xenproject.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <1541725843-2019-1-git-send-email-manjunath.b.patil@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <9414b993-15f6-941a-fc2b-e96147e4fb26@suse.com>
Date: Fri, 9 Nov 2018 07:16:22 +0100
MIME-Version: 1.0
In-Reply-To: <1541725843-2019-1-git-send-email-manjunath.b.patil@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/11/2018 02:10, Manjunath Patil wrote:
> When we try to detach the device, blkfront_remove() tries to access
> blkfront_info leading to kernel panic.
> 
> Typical call stack involving panic -
>  #10 page_fault at ffffffff816f25df
>      [exception RIP: blkif_free+46]
>  #11 blkfront_remove at ffffffffa004de47 [xen_blkfront]
>  #12 xenbus_dev_remove at ffffffff813faa4c
>  #13 __device_release_driver at ffffffff814769aa
>  #14 device_release_driver at ffffffff81476a63
>  #15 bus_remove_device at ffffffff814762eb
>  #16 device_del at ffffffff81472684
>  #17 device_unregister at ffffffff814727e2
>  #18 xenbus_dev_changed at ffffffff813fa89f
>  #19 frontend_changed at ffffffff813fca19
>  #20 xenwatch_thread at ffffffff813f88f9
>  #21 kthread at ffffffff810a486b
>  #22 ret_from_fork at ffffffff816ed2a8
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>

Commit f92898e7f32e3 already added that.


Juergen
