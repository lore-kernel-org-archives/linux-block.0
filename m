Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 6 Mar 2017 17:08:49 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 07/11] bdi: Do not wait for cgwbs release in
 bdi_unregister()
Message-ID: <20170306220849.GL26127@htj.duckdns.org>
References: <20170306163404.1238-1-jack@suse.cz>
 <20170306163404.1238-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306163404.1238-8-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 06, 2017 at 05:34:00PM +0100, Jan Kara wrote:
> Currently we wait for all cgwbs to get released in cgwb_bdi_destroy()
> (called from bdi_unregister()). That is however unnecessary now when
> cgwb->bdi is a proper refcounted reference (thus bdi cannot get
> released before all cgwbs are released) and when cgwb_bdi_destroy()
> shuts down writeback directly.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
