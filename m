Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
 <20170615081914.GD10599@infradead.org>
 <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
 <20170616073339.GC8682@infradead.org>
 <0ac0bb7e-ce8d-cb63-985c-ab2d1f3402f1@kernel.dk>
Message-ID: <09c3e478-b822-fcdc-f965-19e5680daaaf@kernel.dk>
Date: Fri, 16 Jun 2017 08:53:54 -0600
MIME-Version: 1.0
In-Reply-To: <0ac0bb7e-ce8d-cb63-985c-ab2d1f3402f1@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 08:35 AM, Jens Axboe wrote:
>> If I look at the mess for allocating the streams I think we need it
>> to bubble down.  That way the device can allocate the stream at time
>> of the fcntl and we can keep the low level driver very simple.
> 
> Mess? The NVMe code seems pretty straight forward to me. Is it purely
> the lazy alloc part you're referring to? I'm fine with bubbling down the
> hint and setting everything up inline from the fcntl() call, but that
> means we need to make things like btrfs and md/dm aware of it and
> resolve all mappings. That sort-of sucks, especially since they don't
> otherwise need to know about it.

This is what the old code looked like, back when it was implemented as
managed streams, for btrfs:

http://git.kernel.dk/cgit/linux-block/commit/?id=93b4d9370250ea9273e1e71775df85964ff52922

We don't need the close part anymore, but the device iteration for
constituent devices would be the same. On top of that, we'd have to
touch all of drivers/md/ as well, or it won't work for anyone that's
using raid or dm.

Why not just let it resolve lazily? That way we don't have to touch
drivers that need not know about this, since the information is already
being passed all the way down without having to modify drivers.

If you object to the nvme driver open coding this, I can put that in
block instead and catch it earlier. Then nvme would not have to worry
about it. But honestly, I'd much rather make it generic once we have
another user that needs this, than do it up front.

-- 
Jens Axboe
