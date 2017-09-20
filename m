Return-Path: <hch@lst.de>
Date: Thu, 21 Sep 2017 01:52:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170920235250.GA28865@lst.de>
References: <20170918231453.27128-1-hch@lst.de> <20170918231453.27128-10-hch@lst.de> <20170920225822.GE1379@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920225822.GE1379@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 20, 2017 at 06:58:22PM -0400, Keith Busch wrote:
> > +	sprintf(head->disk->disk_name, "nvme/ns%d", head->instance);
> 
> Naming it 'nvme/ns<#>', kobject_set_name_vargs is going to change that
> '/' into a '!', so the sysfs entry is named 'nvme!ns<#>'. Not a big
> deal I suppose, but I just thought it looked odd since '!' has special
> meaning in shells.

I noticed the odd renaming in sysfs and though about gettind rid
of the /dev/nvme/ directory.  I just need to come up with a good
name for the device nodes - the name can't contain /dev/nvme* as
nvme-cli would break if it sees files that start with nvme in /dev/.

/dev/nvmN ?  
