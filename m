Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] loop: support different logical block sizes
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>,
 Milan Broz <gmazyland@gmail.com>
References: <cover.1503558155.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4c6d35ca-df8a-a998-8c4e-ef5177a6109c@kernel.dk>
Date: Thu, 31 Aug 2017 13:51:50 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1503558155.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/24/2017 01:03 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi, everyone,
> 
> Here's another attempt at supporting different logical block sizes for
> loop devices. First, some terminology:
> 
>  * Logical block size: the lowest possible block size that the storage
>    device can address.
>  * Physical block size: the lowest possible sector size that the
>    hardware can operate on without reverting to read-modify-write
>    operations. Always greater than or equal to the logical block size.
> 
> These are characteristics of the device itself tracked in the
> request_queue. For loop devices, both are currently always 512 bytes.
> 
> struct block_device also has another block size, basically a "soft"
> block size which is the preferred I/O size and can be changed from
> userspace. For loop devices, this is PAGE_SIZE if the backing file is a
> regular file or otherwise the soft block size of the backing block
> device.
> 
> Patch 1 simplifies how the soft block size is set. I'm tempted to not
> set it at all and use the default of PAGE_SIZE, but maybe someone is
> depending on inheriting the soft block size from the backing block
> device...
> 
> Patch 2 sets the physical block size of loop devices to a more
> meaningful value for loop, PAGE_SIZE.
> 
> Patch 3 allows us to change the logical block size. It adds a new ioctl
> instead of the previous approach (which extends LOOP_{GET,SET}_STATUS).
> Hannes, I assume you had a specific reason for doing it the way you did,
> care to explain?
> 
> Patch 4 is a cleanup.
> 
> This is based on my patch reverting the original block size support,
> targeting 4.14. Thanks!

Applied for 4.14, thanks Omar.

-- 
Jens Axboe
