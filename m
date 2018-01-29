Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] xfs: remove assert to check bytes returned
To: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 ak@linux.intel.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20180129145741.29486-1-rgoldwyn@suse.de>
 <20180129145741.29486-2-rgoldwyn@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4f2acf1e-6c73-05b9-d9fc-1a07fa0627a7@kernel.dk>
Date: Mon, 29 Jan 2018 11:50:09 -0700
MIME-Version: 1.0
In-Reply-To: <20180129145741.29486-2-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/29/18 7:57 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Since we can return less than count in case of partial direct
> writes, remove the ASSERT.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Acked-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Minot nit - you should probably reorder this patch before the other one,
otherwise you'll have a point in the tree where it can knowingly
trigger.

-- 
Jens Axboe
