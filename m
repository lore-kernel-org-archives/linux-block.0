Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Feb 2017 11:14:38 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 07/13] bdi: Move removal from bdi->wb_list into
 wb_shutdown()
Message-ID: <20170228161438.GC15287@htj.duckdns.org>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221170958.21845-8-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 21, 2017 at 06:09:52PM +0100, Jan Kara wrote:
> Currently the removal from bdi->wb_list happens directly in
> cgwb_release_workfn(). Move it to wb_shutdown() which is functionally
> equivalent and more logical (the list gets only used for distributing
> writeback works among bdi_writeback structures). It will also allow us
> to simplify writeback shutdown in cgwb_bdi_destroy().
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
