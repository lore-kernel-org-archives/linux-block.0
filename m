Return-Path: <mwilck@suse.com>
Message-ID: <1507113192.22324.1.camel@suse.com>
Subject: Re: [PATCH 1/2] block: genhd: add device_add_disk_with_groups
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Thumshirn <jthumshirn@suse.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke
	 <hare@suse.de>, linux-nvme@lists.infradead.org
Date: Wed, 04 Oct 2017 12:33:12 +0200
In-Reply-To: <20171001080003.GD11554@lst.de>
References: <20170928193637.24707-1-mwilck@suse.com>
	 <20171001080003.GD11554@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Sun, 2017-10-01 at 10:00 +0200, Christoph Hellwig wrote:
> While this looks okay-ish to me I really don't want people confused
> with three variants of add_disk, we really need to consolidate
> our helpers there a bit..
> 

Can you give me a hint what you'd like to see?

Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
