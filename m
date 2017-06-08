Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHv8 0/2] loop: enable different logical blocksizes
To: Hannes Reinecke <hare@suse.de>
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org
References: <1496922405-38302-1-git-send-email-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4e55adfa-d4f0-9602-99e7-0a5ef4e37209@kernel.dk>
Date: Thu, 8 Jun 2017 08:40:26 -0600
MIME-Version: 1.0
In-Reply-To: <1496922405-38302-1-git-send-email-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/08/2017 05:46 AM, Hannes Reinecke wrote:
> Currently the loop driver just simulates 512-byte blocks. When
> creating bootable images for virtual machines it might be required
> to use a different physical blocksize (eg 4k for S/390 DASD), as
> the some bootloaders (like lilo or zipl for S/390) need to know
> the physical block addresses of the kernel and initrd.
> 
> With this patchset the loop driver will export the logical and
> physical blocksize and the current LOOP_SET_STATUS64 ioctl is
> extended to set the logical blocksize by re-using the existing
> 'init' fields, which are currently unused.
> 
> As usual, comments and reviews are welcome.

Queued up for 4.13.

-- 
Jens Axboe
