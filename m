Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] direct-io: don't introduce another read of
 inode->i_blkbits
To: Jeff Moyer <jmoyer@redhat.com>,
 Chandan Rajendra <chandan@linux.vnet.ibm.com>
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
 <x49r34bgba5.fsf@segfault.boston.devel.redhat.com>
Cc: jack@suse.cz, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <899a8860-90d8-1856-f7b6-b4cc76227d34@kernel.dk>
Date: Mon, 9 Jan 2017 14:44:46 -0700
MIME-Version: 1.0
In-Reply-To: <x49r34bgba5.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/09/2017 02:42 PM, Jeff Moyer wrote:
> Commit 20ce44d545844 ("do_direct_IO: Use inode->i_blkbits to compute
> block count to be cleaned") introduced a regression: if the block size
> of the block device is changed while a direct I/O request is being
> setup, it can result in a panic.  See commit ab73857e354ab ("direct-io:
> don't read inode->i_blkbits multiple times") for the reasoning, and
> commit b87570f5d3496 ("Fix a crash when block device is read and block
> size is changed at the same time") for a more detailed problem
> description and reproducer.
> 
> Fixes: 20ce44d545844
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> ---
> Chandan, can you please test this to ensure this still fixes your problem?

Please, that would be great. And if so, then let's fold the two.

-- 
Jens Axboe
