Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 21 Mar 2017 12:21:44 -0400
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Tahsin Erdogan <tahsin@google.com>,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 05/11] bdi: Unify bdi->wb_list handling for root
 wb_writeback
Message-ID: <20170321162144.GC30919@htj.duckdns.org>
References: <20170313151410.5586-1-jack@suse.cz>
 <20170313151410.5586-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170313151410.5586-6-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 13, 2017 at 04:14:04PM +0100, Jan Kara wrote:
> Currently root wb_writeback structure is added to bdi->wb_list in
> bdi_init() and never removed. That is different from all other
> wb_writeback structures which get added to the list when created and
> removed from it before wb_shutdown().
> 
> So move list addition of root bdi_writeback to bdi_register() and list
> removal of all wb_writeback structures to wb_shutdown(). That way a
> wb_writeback structure is on bdi->wb_list if and only if it can handle
> writeback and it will make it easier for us to handle shutdown of all
> wb_writeback structures in bdi_unregister().
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
