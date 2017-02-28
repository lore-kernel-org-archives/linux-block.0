Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Feb 2017 11:51:04 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 09/13] bdi: Do not wait for cgwbs release in
 bdi_unregister()
Message-ID: <20170228165104.GE15287@htj.duckdns.org>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-10-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221170958.21845-10-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Feb 21, 2017 at 06:09:54PM +0100, Jan Kara wrote:
> @@ -726,14 +718,6 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
>  	}
>  
>  	spin_unlock_irq(&cgwb_lock);
> -
> -	/*
> -	 * All cgwb's and their congested states must be shutdown and
> -	 * released before returning.  Drain the usage counter to wait for
> -	 * all cgwb's and cgwb_congested's ever created on @bdi.
> -	 */
> -	atomic_dec(&bdi->usage_cnt);
> -	wait_event(cgwb_release_wait, !atomic_read(&bdi->usage_cnt));
>  }

Hmm... I'm not sure about wb_shutdown() synchronization.  If you look
at the function, it's allowed to be called multiple times but doesn't
synchronize the end of the operation.  With usage_cnt, it was okay
because cgwb_bdi_destroy() would have waited until everything is
finished via usage_cnt, but with that gone, we can have a race like
the following.

	A					B
 a cgroup gets removed
 a cgwb starts to get destroyed
 it starts wb_shutdown()
					bdi starts getting destroyed
					calls cgwb_bdi_destroy()
					calls wb_shutdown() on the same cgwb
					  but it returns because it lost to
 wb_shutdown() is still in progress	  A's wb_shutdown()
					bdi destruction proceeds
 Oops.

So, I think we need to make sure that wb_shutdown()'s are properly
synchronized from start to end to get rid of the usage_cnt waiting.

Thanks.

-- 
tejun
