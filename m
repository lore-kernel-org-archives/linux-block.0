Return-Path: <keith.busch@intel.com>
Date: Thu, 21 Sep 2017 17:12:46 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170921211246.GB10713@localhost.localdomain>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-10-hch@lst.de>
 <20170920225822.GE1379@localhost.localdomain>
 <20170920235250.GA28865@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920235250.GA28865@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 01:52:50AM +0200, Christoph Hellwig wrote:
> I noticed the odd renaming in sysfs and though about gettind rid
> of the /dev/nvme/ directory.  I just need to come up with a good
> name for the device nodes - the name can't contain /dev/nvme* as
> nvme-cli would break if it sees files that start with nvme in /dev/.

Ah, didn't know that. I'll fix nvme-cli to handle this.

We can still use a different naming convention for the multipath handles.

> /dev/nvmN ?

Looks safe.

BTW, considered persistent nameing rules to symlink these from
/dev/disk/by-id/? May need to add an attribute to the multipath object
to assist that.
