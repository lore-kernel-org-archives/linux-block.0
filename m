Return-Path: <hch@lst.de>
Date: Sun, 1 Oct 2017 10:00:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 1/2] block: genhd: add device_add_disk_with_groups
Message-ID: <20171001080003.GD11554@lst.de>
References: <20170928193637.24707-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170928193637.24707-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

While this looks okay-ish to me I really don't want people confused
with three variants of add_disk, we really need to consolidate
our helpers there a bit..
