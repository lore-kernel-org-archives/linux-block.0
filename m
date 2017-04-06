Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49041 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933360AbdDFLq4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 07:46:56 -0400
Date: Thu, 6 Apr 2017 04:46:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 7/9] Guard bvec iteration logic v3
Message-ID: <20170406114655.GE9312@infradead.org>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-8-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491332201-26926-8-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>  	if (bio_no_advance_iter(bio))
>  		iter->bi_size -= bytes;
> -	else
> -		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
> +	else {
> +		int err;
> +		err = bvec_iter_advance(bio->bi_io_vec, iter, bytes);
> +		if (unlikely(err))
> +			bio->bi_error = err;
> +	}

I don't think that setting bi_error here is a good idea without actually
completing the bio, which would be a much bigger change.

Maybe leave the error ignored here for now with a fixme comment, and
then we can look into proper error handling in a separate series.
