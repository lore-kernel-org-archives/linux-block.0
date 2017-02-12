Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Feb 2017 13:32:38 +0900
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 05/10] writeback: Generalize and standardize I_SYNC
 waiting function
Message-ID: <20170212043238.GE29323@mtj.duckdns.org>
References: <20170209124433.2626-1-jack@suse.cz>
 <20170209124433.2626-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209124433.2626-6-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 09, 2017 at 01:44:28PM +0100, Jan Kara wrote:
> __inode_wait_for_writeback() waits for I_SYNC on inode to get cleared.
> There's nothing specific regarting I_SYNC for that function. Generalize
> it so that we can use it also for I_WB_SWITCH bit. Also the function
> uses __wait_on_bit() unnecessarily. Switch it to wait_on_bit() to remove
> some code.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
