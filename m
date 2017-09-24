Return-Path: <hch@lst.de>
Date: Sun, 24 Sep 2017 16:42:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170924144248.GB13681@lst.de>
References: <20170918231453.27128-1-hch@lst.de> <20170918231453.27128-10-hch@lst.de> <20170920225822.GE1379@localhost.localdomain> <20170920235250.GA28865@lst.de> <20170921211246.GB10713@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170921211246.GB10713@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 05:12:46PM -0400, Keith Busch wrote:
> BTW, considered persistent nameing rules to symlink these from
> /dev/disk/by-id/? May need to add an attribute to the multipath object
> to assist that.

Yes, we do.  I've just been trying to push out udev/systemd work
as long as possible in the hopes that someone else will do it,
as it always seems painful.

But I think we should also offer versions of our id attributes
on this device to make life easier.
