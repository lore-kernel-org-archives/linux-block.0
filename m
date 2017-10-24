Return-Path: <mingo.kernel.org@gmail.com>
Return-Path: <mingo.kernel.org@gmail.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 24 Oct 2017 12:10:01 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: peterz@infradead.org, axboe@kernel.dk, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, tj@kernel.org,
	johannes.berg@intel.com, oleg@redhat.com, amir73il@gmail.com,
	david@fromorbit.com, darrick.wong@oracle.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@infradead.org, idryomov@gmail.com,
	kernel-team@lge.com
Subject: Re: [PATCH v3 7/8] genhd.h: Remove trailing white space
Message-ID: <20171024101001.cv6e5llflnkzhuim@gmail.com>
References: <1508837889-16932-1-git-send-email-byungchul.park@lge.com>
 <1508837889-16932-8-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508837889-16932-8-git-send-email-byungchul.park@lge.com>
List-ID: <linux-block@vger.kernel.org>


* Byungchul Park <byungchul.park@lge.com> wrote:

> Trailing white space is not accepted in kernel coding style. Remove
> them.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  include/linux/genhd.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index ea652bf..6d85a75 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -3,7 +3,7 @@
>  
>  /*
>   * 	genhd.h Copyright (C) 1992 Drew Eckhardt
> - *	Generic hard disk header file by  
> + *	Generic hard disk header file by
>   * 		Drew Eckhardt
>   *
>   *		<drew@colorado.edu>
> @@ -471,7 +471,7 @@ struct bsd_disklabel {
>  	__s16	d_type;			/* drive type */
>  	__s16	d_subtype;		/* controller/d_type specific */
>  	char	d_typename[16];		/* type name, e.g. "eagle" */
> -	char	d_packname[16];			/* pack identifier */ 
> +	char	d_packname[16];			/* pack identifier */
>  	__u32	d_secsize;		/* # of bytes per sector */
>  	__u32	d_nsectors;		/* # of data sectors per track */
>  	__u32	d_ntracks;		/* # of tracks per cylinder */

This patch should not be part of this lockdep series - please send it to Jens 
separately - who might or might not apply it, depending on the subsystem's policy 
regarding whitespace-only patches.

Thanks,

	Ingo
