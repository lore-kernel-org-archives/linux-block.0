Return-Path: <hare@suse.de>
Subject: Re: BLK_EH_HANDLED
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9e264194-b314-14ae-e0e0-d71124418386@suse.de>
Date: Wed, 23 May 2018 15:20:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes the BLK_EH_HANDLED return value, and instead places
> responsibility of timed out commands entirely on the drivers.  Except
> for some odd layering vilations in libiscsi this actually is
> surprisingly simple.  The last two pathes contain a respin of Keith'
> series to refcount struct request in the eye of timeouts.  Once the
> BLK_EH_HANDLED special case is gone this actually seems the EH fixing
> approach that seems the most sensible to me.
> 
YES!

Cheers,

Hannes
