Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <20170126174532.15189-1-jack@suse.cz>
References: <20170126174532.15189-1-jack@suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 26 Jan 2017 22:15:06 -0800
Message-ID: <CAPcyv4hJR_4WZFhKkfbnAz0iLtu-bgSJVE804+ywaFTeYC51bQ@mail.gmail.com>
Subject: Re: [PATCH 0/4 RFC] BDI lifetime fix
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 26, 2017 at 9:45 AM, Jan Kara <jack@suse.cz> wrote:
> Hello,
>
> this patch series attempts to solve the problems with the life time of a
> backing_dev_info structure. Currently it lives inside request_queue structure
> and thus it gets destroyed as soon as request queue goes away. However
> the block device inode still stays around and thus inode_to_bdi() call on
> that inode (e.g. from flusher worker) may happen after request queue has been
> destroyed resulting in oops.
>
> This patch set tries to solve these problems by making backing_dev_info
> independent structure referenced from block device inode. That makes sure
> inode_to_bdi() cannot ever oops. The patches are lightly tested for now
> (they boot, basic tests with adding & removing loop devices seem to do what
> I'd expect them to do ;). If someone is able to reproduce crashes on bdi
> when device goes away, please test these patches.

This survives a several runs of the libnvdimm unit tests which stress
del_gendisk() and blk_cleanup_queue(). I'll keep testing since the
failure was intermittent, but this is looking good.

> I'd also appreciate if people had a look whether the approach I took looks
> sensible.

Looks sensible, just the kref comment.

I also don't see a need to try to tag on the bdi device name reuse
into this series. I'm wondering if we can handle that separately with
device_rename(bdi->dev, ...) when we know scsi is done with the old
bdi but it has not finished being deleted
