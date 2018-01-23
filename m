Return-Path: <keith.busch@intel.com>
Date: Mon, 22 Jan 2018 17:16:29 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme/pci: Start request after doorbell ring
Message-ID: <20180123001628.GT12043@localhost.localdomain>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
 <45a16b4c-fbc0-106d-df37-439374c7b5dc@kernel.dk>
 <118beb1f-54eb-c65d-1c9c-4775ebde1fa8@kernel.dk>
 <20171221210250.GA2975@localhost.localdomain>
 <6ffc074a-3c5b-c76d-d213-6606a77626e0@kernel.dk>
 <20180103202105.GC11172@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180103202105.GC11172@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 03, 2018 at 01:21:05PM -0700, Keith Busch wrote:
> 
> I've removed the submission side poll in a local build, and amazingly I
> am observing a not insignificant increase in latency without it on some
> workloads with certain hardware. I will have to delay recommending/posting
> removal of this pending further investigation.

This took longer to narrow than I hoped. I had been getting very wild
results, and there were two things to blame: a kernel irq issue[*],
and a platform bios causing a lot of CPU thermal frequency throttling.

Now that's sorted out, I am back to tuning this and the opprotunistic
nvme submission side polling once again does not produce a measurable
difference. My world is sane again. Will try to send an update for
consideration this week after some more testing.

 * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=a0c9259dc4
