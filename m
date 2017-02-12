Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Feb 2017 13:41:34 +0900
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 09/10] kobject: Export kobject_get_unless_zero()
Message-ID: <20170212044134.GG29323@mtj.duckdns.org>
References: <20170209124433.2626-1-jack@suse.cz>
 <20170209124433.2626-10-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209124433.2626-10-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 09, 2017 at 01:44:32PM +0100, Jan Kara wrote:
> Make the function available for outside use and fortify it against NULL
> kobject.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Cc Greg?

Thanks.

-- 
tejun
