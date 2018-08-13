Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 13 Aug 2018 20:52:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Matias Bjorling <mb@lightnvm.io>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] block: Introduce alloc_disk_node_attr()
Message-ID: <20180813185234.GB5606@kroah.com>
References: <20180813172531.7451-1-bart.vanassche@wdc.com>
 <20180813172531.7451-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180813172531.7451-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 13, 2018 at 10:25:30AM -0700, Bart Van Assche wrote:
> This patch does not change the behavior of any existing code but
> introduces a function that will be used by the next patch.

"next" is hard to determine in a git log :)

Try being a bit more specific as to why you are doing this.

thanks,

greg k-h
