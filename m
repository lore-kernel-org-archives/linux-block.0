Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] btrfs: use new block error code
To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
 Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
 Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20170619105536.GA24075@elgon.mountain>
 <20170621131723.GH21388@twin.jikos.cz>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2bd7fd59-71ad-8ff5-65f7-3b6f1d51ccbd@kernel.dk>
Date: Wed, 21 Jun 2017 07:48:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170621131723.GH21388@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/21/2017 07:17 AM, David Sterba wrote:
> On Mon, Jun 19, 2017 at 01:55:37PM +0300, Dan Carpenter wrote:
>> This function is supposed to return blk_status_t error codes now but
>> there was a stray -ENOMEM left behind.
>>
>> Fixes: 4e4cbee93d56 ("block: switch bios to blk_status_t")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Acked-by: David Sterba <dsterba@suse.com>
> 
> The patch depends on the blk_status_t patchset, so I expect that it's
> going to be merged to that.

Added, thanks.

-- 
Jens Axboe
