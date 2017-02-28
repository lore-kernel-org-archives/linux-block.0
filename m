Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Feb 2017 11:51:41 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 10/13] bdi: Rename cgwb_bdi_destroy() to
 cgwb_bdi_unregister()
Message-ID: <20170228165141.GF15287@htj.duckdns.org>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-11-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221170958.21845-11-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 21, 2017 at 06:09:55PM +0100, Jan Kara wrote:
> Rename cgwb_bdi_destroy() to cgwb_bdi_unregister() as it gets called
> from bdi_unregister() which is not necessarily called from bdi_destroy()
> and thus the name is somewhat misleading.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
