Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH] nvme: fix hang in remove path
To: Rakesh Pandit <rakesh@tuxera.com>, Ming Lei <ming.lei@redhat.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20170602083208.4518-1-ming.lei@redhat.com>
 <20170602180435.GA23335@dhcp-216.srv.tuxera.com>
 <244bc065-92eb-c3e0-faa7-11569fc326d6@grimberg.me>
 <20170605084434.GA30864@dhcp-216.srv.tuxera.com>
 <20170605084732.GA30881@dhcp-216.srv.tuxera.com>
 <20170605194532.GA2549@hercules.tuxera.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <23b9bc87-81a0-93e8-3730-f07e68e46702@grimberg.me>
Date: Tue, 6 Jun 2017 10:10:45 +0300
MIME-Version: 1.0
In-Reply-To: <20170605194532.GA2549@hercules.tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> Note 7 here is NVME_SC_ABORT_REQ.  Also we would avoid walking through
>>> all power states inside the nvme_configure_apst as
>>> nvme_set_latency_tolerance was called with value
>>> PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1) which sets
>>> ctrl->ps_max_latency_us to U64_MAX and tries to send a sync command
>>> which of course fails with error message.
> 
> Even though this change from this patch does fix the hang, just tested
> again and I can see above error message "failed to set APST feature 7"
> while nvme_remove PID is getting executed.
> 
> So, sync requests (while nvme_remove is executing) are going through
> and not everything is handled well in .queue_rq while controller is
> under deleting state or dead state.

The error message is expected because queue_rq is failing the I/O, did
you see it actually hang?

Personally I'm not too bothered with the error log, we can suppress it
conditional on the ctrl state if it really annoys people, but if we're
conditioning on the ctrl state, we can do it like you suggested anyway...
