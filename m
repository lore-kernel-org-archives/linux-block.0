Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 6 Mar 2017 17:08:07 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 06/11] bdi: Shutdown writeback on all cgwbs in
 cgwb_bdi_destroy()
Message-ID: <20170306220807.GK26127@htj.duckdns.org>
References: <20170306163404.1238-1-jack@suse.cz>
 <20170306163404.1238-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306163404.1238-7-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 06, 2017 at 05:33:59PM +0100, Jan Kara wrote:
> Currently we waited for all cgwbs to get freed in cgwb_bdi_destroy()
> which also means that writeback has been shutdown on them. Since this
> wait is going away, directly shutdown writeback on cgwbs from
> cgwb_bdi_destroy() to avoid live writeback structures after
> bdi_unregister() has finished. To make that safe with concurrent
> shutdown from cgwb_release_workfn(), we also have to make sure
> wb_shutdown() returns only after the bdi_writeback structure is really
> shutdown.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
