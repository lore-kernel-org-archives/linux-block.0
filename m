Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Feb 2017 11:44:36 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 08/13] bdi: Shutdown writeback on all cgwbs in
 cgwb_bdi_destroy()
Message-ID: <20170228164436.GD15287@htj.duckdns.org>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221170958.21845-9-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Feb 21, 2017 at 06:09:53PM +0100, Jan Kara wrote:
> Currently we waited for all cgwbs to get freed in cgwb_bdi_destroy()
> which also means that writeback has been shutdown on them. Since this
> wait is going away, directly shutdown writeback on cgwbs from
> cgwb_bdi_destroy() to avoid live writeback structures after
> bdi_unregister() has finished.

Hmmm... the only thing which is a bit bothering is that after removing
the shutdown from release_workfn this would make the final flushing
sequential, one cgwb at a time, which in certain cases can take an
unnecessarily long time.  It's not a correctness issue tho and if it
becomes a problem we can deal with it by splitting wb_shutdown() into
two pieces - the unregistration / issuing of the work items, and the
flushing of those.  Other than that, looks good to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
