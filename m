Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Feb 2017 11:06:14 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 05/13] bdi: Mark congested->bdi as internal
Message-ID: <20170228160614.GA15287@htj.duckdns.org>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221170958.21845-6-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 21, 2017 at 06:09:50PM +0100, Jan Kara wrote:
> congested->bdi pointer is used only to be able to remove congested
> structure from bdi->cgwb_congested_tree on structure release. Moreover
> the pointer can become NULL when we unregister the bdi. Rename the field
> to __bdi and add a comment to make it more explicit this is internal
> stuff of memcg writeback code and people should not use the field as
> such use will be likely race prone.
> 
> We do not bother with converting congested->bdi to a proper refcounted
> reference. It will be slightly ugly to special-case bdi->wb.congested to
> avoid effectively a cyclic reference of bdi to itself and the reference
> gets cleared from bdi_unregister() making it impossible to reference
> a freed bdi.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
