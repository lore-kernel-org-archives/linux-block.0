Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755022AbdEKJxW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2017 05:53:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v4B9nrv1028046
        for <linux-block@vger.kernel.org>; Thu, 11 May 2017 05:53:21 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ac47qegcp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 11 May 2017 05:53:21 -0400
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <abdhalee@linux.vnet.ibm.com>;
        Thu, 11 May 2017 19:53:18 +1000
Subject: Re: [linux-next][bock] [bisected c20cfc27a] WARNING: CPU: 22 PID:      0
 at block/blk-core.c:2655 .blk_update_request+0x4f8/0x500
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, sachinp <sachinp@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 11 May 2017 15:22:25 +0530
In-Reply-To: <20170510175506.GA5084@lst.de>
References: <1493965539.7355.44.camel@abdul.in.ibm.com>
         <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk>
         <1494227599.2983.2.camel@abdul.in.ibm.com>
         <f1a1ced1-6f3c-8fec-2e2d-4db4c09e31fc@kernel.dk>
         <1494343101.11532.4.camel@abdul.in.ibm.com> <20170510075642.GA10943@lst.de>
         <1494409780.11532.14.camel@abdul.in.ibm.com> <20170510175506.GA5084@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1494496345.6713.2.camel@abdul.in.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-05-10 at 19:55 +0200, Christoph Hellwig wrote:
> Hi Abdul,
> 
> can you test the patch below?  I'll try to create a way to inject
> short WRITE SAME commands using qemu next, but I thought I'd give
> you a chance to try it as well.

No warnings with the patch. Thanks for all your support !

Reported-and-tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>

> 
> ---
> diff --git a/block/blk-core.c b/block/blk-core.c
> index c580b0138a7f..c7068520794b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2644,8 +2644,6 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
>  		return false;
>  	}
> 
> -	WARN_ON_ONCE(req->rq_flags & RQF_SPECIAL_PAYLOAD);
> -
>  	req->__data_len -= total_bytes;
> 
>  	/* update sector only for requests with clear definition of sector */
> @@ -2658,17 +2656,19 @@ bool blk_update_request(struct request *req, int error, unsigned int nr_bytes)
>  		req->cmd_flags |= req->bio->bi_opf & REQ_FAILFAST_MASK;
>  	}
> 
> -	/*
> -	 * If total number of sectors is less than the first segment
> -	 * size, something has gone terribly wrong.
> -	 */
> -	if (blk_rq_bytes(req) < blk_rq_cur_bytes(req)) {
> -		blk_dump_rq_flags(req, "request botched");
> -		req->__data_len = blk_rq_cur_bytes(req);
> -	}
> +	if (!(req->rq_flags & RQF_SPECIAL_PAYLOAD)) {
> +		/*
> +		 * If total number of sectors is less than the first segment
> +		 * size, something has gone terribly wrong.
> +		 */
> +		if (blk_rq_bytes(req) < blk_rq_cur_bytes(req)) {
> +			blk_dump_rq_flags(req, "request botched");
> +			req->__data_len = blk_rq_cur_bytes(req);
> +		}
> 
> -	/* recalculate the number of segments */
> -	blk_recalc_rq_segments(req);
> +		/* recalculate the number of segments */
> +		blk_recalc_rq_segments(req);
> +	}
> 
>  	return true;
>  }
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
