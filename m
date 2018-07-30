Return-Path: <hch@lst.de>
Date: Mon, 30 Jul 2018 10:56:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/6] genhd: drop 'bool' argument from
	__device_add_disk()
Message-ID: <20180730085623.GA12038@lst.de>
References: <20180730071227.22887-1-hare@suse.de> <20180730071227.22887-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730071227.22887-2-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

I really don't see the point for this change.
