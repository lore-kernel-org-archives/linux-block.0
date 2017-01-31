Return-Path: <jack@suse.cz>
Date: Tue, 31 Jan 2017 12:20:42 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4 RFC] BDI lifetime fix
Message-ID: <20170131112042.GC12921@quack2.suse.cz>
References: <20170126174532.15189-1-jack@suse.cz>
 <CAPcyv4hJR_4WZFhKkfbnAz0iLtu-bgSJVE804+ywaFTeYC51bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4hJR_4WZFhKkfbnAz0iLtu-bgSJVE804+ywaFTeYC51bQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu 26-01-17 22:15:06, Dan Williams wrote:
> On Thu, Jan 26, 2017 at 9:45 AM, Jan Kara <jack@suse.cz> wrote:
> > Hello,
> >
> > this patch series attempts to solve the problems with the life time of a
> > backing_dev_info structure. Currently it lives inside request_queue structure
> > and thus it gets destroyed as soon as request queue goes away. However
> > the block device inode still stays around and thus inode_to_bdi() call on
> > that inode (e.g. from flusher worker) may happen after request queue has been
> > destroyed resulting in oops.
> >
> > This patch set tries to solve these problems by making backing_dev_info
> > independent structure referenced from block device inode. That makes sure
> > inode_to_bdi() cannot ever oops. The patches are lightly tested for now
> > (they boot, basic tests with adding & removing loop devices seem to do what
> > I'd expect them to do ;). If someone is able to reproduce crashes on bdi
> > when device goes away, please test these patches.
> 
> This survives a several runs of the libnvdimm unit tests which stress
> del_gendisk() and blk_cleanup_queue(). I'll keep testing since the
> failure was intermittent, but this is looking good.

Can I add your Tested-by tag?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
