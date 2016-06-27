Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35348 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbcF0Qa1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 27 Jun 2016 12:30:27 -0400
Date: Mon, 27 Jun 2016 09:30:12 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@fb.com>,
	"Nicholas A . Bellinger" <nab@linux-iscsi.org>,
	Mike Christie <mchristi@redhat.com>,
	Andy Grover <agrover@redhat.com>,
	Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	linux-efi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/3] block: provide helpers for reading block count
Message-ID: <20160627163012.GA11116@linux-80c1.suse>
References: <20160623133016.3781907-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20160623133016.3781907-1-arnd@arndb.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 23 Jun 2016, Arnd Bergmann wrote:

>Several drivers use an expensive do_div() to compute the number
>of logical or physical blocks in a blockdev, which can be done
>more efficiently using a shift, since the blocksize is always
>a power of two number.
>
>Let's introduce bdev_logical_block_count() and bdev_physical_block_count()
>helper functions mirroring the bdev_logical_block_size() and
>bdev_physical_block_size() interfaces for the block size.

>@@ -1226,6 +1226,13 @@ static inline unsigned short bdev_logical_block_size(struct block_device *bdev)
> 	return queue_logical_block_size(bdev_get_queue(bdev));
> }
>
>+static inline sector_t bdev_logical_block_count(struct block_device *bdev)

Curious, why not just return u64 instead for all these instead of sector_t (ie
dealing with lba, it reads weird)?

Thanks,
Davidlohr
