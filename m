Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Feb 2017 11:07:43 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 06/13] bdi: Make wb->bdi a proper reference
Message-ID: <20170228160743.GB15287@htj.duckdns.org>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221170958.21845-7-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 21, 2017 at 06:09:51PM +0100, Jan Kara wrote:
> Make wb->bdi a proper refcounted reference to bdi for all bdi_writeback
> structures except for the one embedded inside struct backing_dev_info.
> That will allow us to simplify bdi unregistration.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
