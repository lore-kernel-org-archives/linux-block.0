Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] direct-io: don't introduce another read of
 inode->i_blkbits
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 Jeff Moyer <jmoyer@redhat.com>
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
 <x49r34bgba5.fsf@segfault.boston.devel.redhat.com>
 <4971281.Bg9JD0zqnv@localhost.localdomain>
Cc: jack@suse.cz, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eff698ef-2677-bb7c-1caf-2b99d95050e7@kernel.dk>
Date: Tue, 10 Jan 2017 13:31:11 -0700
MIME-Version: 1.0
In-Reply-To: <4971281.Bg9JD0zqnv@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/09/2017 10:27 PM, Chandan Rajendra wrote:
> On Monday, January 09, 2017 04:42:58 PM Jeff Moyer wrote:
>> Commit 20ce44d545844 ("do_direct_IO: Use inode->i_blkbits to compute
>> block count to be cleaned") introduced a regression: if the block size
>> of the block device is changed while a direct I/O request is being
>> setup, it can result in a panic.  See commit ab73857e354ab ("direct-io:
>> don't read inode->i_blkbits multiple times") for the reasoning, and
>> commit b87570f5d3496 ("Fix a crash when block device is read and block
>> size is changed at the same time") for a more detailed problem
>> description and reproducer.
>>
>> Fixes: 20ce44d545844
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>>
>> ---
>> Chandan, can you please test this to ensure this still fixes your problem?
> 
> This patch fixes the failure,
> 
> Tested-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> 

I've updated the patch, thanks guys.

-- 
Jens Axboe
