Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:30351 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755135AbeASD6M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 22:58:12 -0500
Date: Fri, 19 Jan 2018 14:57:37 +1100
From: Dave Chinner <david@fromorbit.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/2] xfs: remove assert to check bytes returned
Message-ID: <20180119035736.GL16421@dastard>
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <20180119005741.32058-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119005741.32058-2-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 18, 2018 at 06:57:41PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Since we can return less than count in case of partial direct
> writes, remove the ASSERT.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/xfs/xfs_file.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 8601275cc5e6..8fc4dbf66910 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -590,12 +590,6 @@ xfs_file_dio_aio_write(
>  	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, xfs_dio_write_end_io);
>  out:
>  	xfs_iunlock(ip, iolock);
> -
> -	/*
> -	 * No fallback to buffered IO on errors for XFS, direct IO will either
> -	 * complete fully or fail.
> -	 */
> -	ASSERT(ret < 0 || ret == count);
>  	return ret;
>  }

Acked-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
