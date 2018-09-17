Return-Path: <hare@suse.de>
Subject: Re: [PATCH V3 00/17] SCSI: introduce per-host admin queue & enable
 runtime PM
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20180913121546.5710-1-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5b608035-1100-2cf3-e9f9-47a513267123@suse.de>
Date: Mon, 17 Sep 2018 08:34:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/13/2018 02:15 PM, Ming Lei wrote:
> Hi,
> 
> This patchset introduces per-host admin request queue for submitting
> admin request only, and uses this approach to implement both SCSI
> quiesce and runtime PM in one very simply way. Also runtime PM deadlock
> can be avoided in case that request pool is used up, such as when too
> many IO requests are allocated before resuming device.
> 
> The idea is borrowed from NVMe.
> 
> In this patchset, admin request(all requests submitted via __scsi_execute) will
> be submitted via one per-host admin queue, and the request is still
> associated with the same scsi_device as before, and respects this
> scsi_device's all kinds of limits too. Admin queue shares host tags with
> other IO queues.
> 
> One core idea is that for any admin request submitted from this admin queue,
> this request won't be called back to block layer via the associated IO
> queue(scsi_device). And this is done in the 3rd patch. So once IO queue
> is frozen, it can be observed as really frozen from block layer view.
> 
> SCSI quiesce is implemented by admin queue in very simple way, see patch
> 15.
> 
> Also runtime PM for legacy path is simplified too, see patch 16, and device
> resume is moved to blk_queue_enter().
> 
> blk-mq simply follows legacy's approach for supporting runtime PM.
> 
> Also the fast IO path is simplified much, see blk_queue_enter().
> 
[ .. ]
> 
Please don't do this.
Having an admin queue makes sense for NVMe (where it's even part of the
spec). But for SCSI it's just an additional logical construct with
doesn't correlate to anything we have in the lower layers.
And all of this just to handle PM requests properly.

At ALPSS we've discussed this issue and came up with a different
proposal: Allocate a PM request before _suspending_. Then we trivially
have that request available when resuming, and are sure that nothing can
block the request.
Far simpler, and doesn't require an entirely new infrastructure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
