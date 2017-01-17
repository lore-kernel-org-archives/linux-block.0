Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] partitions/efi: Fix integer overflow in GPT size
 calculation
To: Alden Tondettar <alden.tondettar@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-efi@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1484519516-18295-1-git-send-email-alden.tondettar@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3c9bc8f7-7fb8-64d7-f195-7aadfd2cbb14@kernel.dk>
Date: Tue, 17 Jan 2017 08:03:14 -0800
MIME-Version: 1.0
In-Reply-To: <1484519516-18295-1-git-send-email-alden.tondettar@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/15/2017 02:31 PM, Alden Tondettar wrote:
> If a GUID Partition Table claims to have more than 2**25 entries, the
> calculation of the partition table size in alloc_read_gpt_entries() will
> overflow a 32-bit integer and not enough space will be allocated for the
> table.
> 
> Nothing seems to get written out of bounds, but later efi_partition() will
> read up to 32768 bytes from a 128 byte buffer, possibly OOPSing or exposing
> information to /proc/partitions and uevents.
> 
> The problem exists on both 64-bit and 32-bit platforms.
> 
> Fix the overflow and also print a meaningful debug message if the table
> size is too large.

Applied for 4.11, thanks.

-- 
Jens Axboe
