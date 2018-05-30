Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 30 May 2018 01:47:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"bgurney@redhat.com" <bgurney@redhat.com>
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
Message-ID: <20180530084753.GA29413@infradead.org>
References: <20180525211432.20359-1-jmoyer@redhat.com>
 <9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
 <x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com>
 <a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
 <122bc1d9-a074-7282-6812-aba26f4868f4@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <122bc1d9-a074-7282-6812-aba26f4868f4@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 30, 2018 at 06:22:04AM +0000, Damien Le Moal wrote:
> That would necessitate splitting elevator_init() into a generic elevator
> initialization function setting up the elevator related fields of the
> request queue and a second part setting up the default elevator (e.g.
> elevator_set_default()). Doing so, the function elevator_set_default()
> could be called later in the device initialization sequence, after
> information from the device has been obtained. It would make choosing a
> sane default elevator much cleaner.

For blk-mq this makes entirely sense, untested series here:

	http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/elevator_init

For the legacy case we always need at least some I/O scheduler,
so we can't just defer it.  But I think we could still switch to
deadline in blk_register_queue if we found a zoned device.
