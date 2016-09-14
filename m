Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block_dev: remove DAX leftovers
To: Christoph Hellwig <hch@lst.de>, ross.zwisler@linux.intel.com
References: <1473846973-18798-1-git-send-email-hch@lst.de>
Cc: linux-nvdimm@ml01.01.org, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ecd353f8-ae9b-b219-8db4-e6e37b19c81a@kernel.dk>
Date: Wed, 14 Sep 2016 08:42:41 -0600
MIME-Version: 1.0
In-Reply-To: <1473846973-18798-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/14/2016 03:56 AM, Christoph Hellwig wrote:
> DAX support for block devices was removed in commits 03cdad
> ("block: disable block device DAX by default") and 99a01cd
> ("block: remove BLK_DEV_DAX config option"), but we still kept a call to
> dax_do_io and some uneeded i_flags manipulations introduced in commit
> bbab37 ("block: Add support for DAX reads/writes to block devices").

Applied for 4.9, thanks.

-- 
Jens Axboe
