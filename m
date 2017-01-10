Return-Path: <chandan@linux.vnet.ibm.com>
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: axboe@kernel.dk, jack@suse.cz, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        anton@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] direct-io: don't introduce another read of inode->i_blkbits
Date: Tue, 10 Jan 2017 10:57:55 +0530
In-Reply-To: <x49r34bgba5.fsf@segfault.boston.devel.redhat.com>
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com> <x49r34bgba5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <4971281.Bg9JD0zqnv@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Monday, January 09, 2017 04:42:58 PM Jeff Moyer wrote:
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

This patch fixes the failure,

Tested-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

-- 
chandan
