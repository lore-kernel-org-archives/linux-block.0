Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89348C43610
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501A821019
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="zSFi0Wg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501A821019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbeKPKup (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:50:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43971 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbeKPKug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 05:50:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so9769937pgv.10
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 16:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X1GEoJJK+UNhOkjdC245liGBUbvTxQSkakHM6BRG+ms=;
        b=zSFi0Wg4E0kmg2hsWmVmNdlKdNmmvFXhUdB9J+8ub66TpY6GsbxYznDAGWV47L10zN
         l0r+GbT81og7X+4tHTefy4jcCZC7J9QzhSLudEJcmV7nd/qVezLue4AZE5CLvp3dKFmc
         0OTNBb7fC76mCt8W/LTX7BWbPCOI9ReagZVcMkrjHQlJdeVp0DOnOK2YeZ7QNsOcIv7x
         yB/4vYgPiS+KUgk6sDn/F9DIPkyPcdeMDMTYF4Om8gU41KwW3EH8a29SBCPPhL0sKw+Z
         a+oKwP/EsTLTJgfqqazY46cOIcvrEBEpClt4e/oyjn3fQD/2RoN0jr4iHE9CNiKxEGH8
         wTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1GEoJJK+UNhOkjdC245liGBUbvTxQSkakHM6BRG+ms=;
        b=gSB5BSVziReZWl8CWGKqQUUnsOp2sYbCm2q7JZXE7U+bq7DrV3HJ+QvsCMRat2JLaw
         qtVZASUzMDDNbopCEdhLsCTERV06wYsRTn0NcxM5BjfmDdcDrH2WL0YEw8rELMfARbOn
         Mg00GvselX9XlowQfidtKm6NRetdTHn7yW4U5mZUtslRtvB5H1SJruWeFBVTxRTlKdlo
         3lG9aggl47TZqzY6ZVBu3f79wz0Ga9yHQQxAx8gkNA1g/2LHkGI87LqJz8DofLlyvP+F
         HUzidMBoy2QNBkpRdU1+BnZxfLNldnBPgIygKwANsx2PB/TMKPwSsb5CivgEHpNKx9Ez
         XJ/A==
X-Gm-Message-State: AGRZ1gLaA8bc5kb/gjCu5Txh/Zh0At0m8C7M/fzBQh4zAwK/ZxP+nghk
        x/Xr7IkDeb0BvE6imePfdnbfOQ==
X-Google-Smtp-Source: AJdET5cnzukDvAzvCEuOsZlVueOAE5LwQxO6M2EEVLTu0Ii6FYx/UJMF0RjEsO5hujQKgpl6f/PMcQ==
X-Received: by 2002:a62:f54f:: with SMTP id n76mr8747535pfh.59.1542328824202;
        Thu, 15 Nov 2018 16:40:24 -0800 (PST)
Received: from vader ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id a73sm13988092pfa.7.2018.11.15.16.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 16:40:23 -0800 (PST)
Date:   Thu, 15 Nov 2018 16:40:22 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Coly Li <colyli@suse.de>,
        linux-bcache@vger.kernel.org, Boaz Harrosh <ooo@electrozaur.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
Subject: Re: [PATCH V10 10/19] block: loop: pass multi-page bvec to iov_iter
Message-ID: <20181116004022.GE23828@vader>
References: <20181115085306.9910-1-ming.lei@redhat.com>
 <20181115085306.9910-11-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115085306.9910-11-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 04:52:57PM +0800, Ming Lei wrote:
> iov_iter is implemented with bvec itererator, so it is safe to pass
> multipage bvec to it, and this way is much more efficient than
> passing one page in each bvec.
> 
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: dm-devel@redhat.com
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Shaohua Li <shli@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Cc: linux-erofs@lists.ozlabs.org
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> Cc: Gao Xiang <gaoxiang25@huawei.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: linux-ext4@vger.kernel.org
> Cc: Coly Li <colyli@suse.de>
> Cc: linux-bcache@vger.kernel.org
> Cc: Boaz Harrosh <ooo@electrozaur.com>
> Cc: Bob Peterson <rpeterso@redhat.com>
> Cc: cluster-devel@redhat.com

Reviewed-by: Omar Sandoval <osandov@fb.com>

Comments below.

> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/loop.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bf6bc35aaf88..a3fd418ec637 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -515,16 +515,16 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	struct bio *bio = rq->bio;
>  	struct file *file = lo->lo_backing_file;
>  	unsigned int offset;
> -	int segments = 0;
> +	int nr_bvec = 0;
>  	int ret;
>  
>  	if (rq->bio != rq->biotail) {
> -		struct req_iterator iter;
> +		struct bvec_iter iter;
>  		struct bio_vec tmp;
>  
>  		__rq_for_each_bio(bio, rq)
> -			segments += bio_segments(bio);
> -		bvec = kmalloc_array(segments, sizeof(struct bio_vec),
> +			nr_bvec += bio_bvecs(bio);
> +		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
>  				     GFP_NOIO);
>  		if (!bvec)
>  			return -EIO;
> @@ -533,13 +533,14 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  		/*
>  		 * The bios of the request may be started from the middle of
>  		 * the 'bvec' because of bio splitting, so we can't directly
> -		 * copy bio->bi_iov_vec to new bvec. The rq_for_each_segment
> +		 * copy bio->bi_iov_vec to new bvec. The bio_for_each_bvec
>  		 * API will take care of all details for us.
>  		 */
> -		rq_for_each_segment(tmp, rq, iter) {
> -			*bvec = tmp;
> -			bvec++;
> -		}
> +		__rq_for_each_bio(bio, rq)
> +			bio_for_each_bvec(tmp, bio, iter) {
> +				*bvec = tmp;
> +				bvec++;
> +			}

Even if they're not strictly necessary, could you please include the
curly braces for __rq_for_each_bio() here?

>  		bvec = cmd->bvec;
>  		offset = 0;
>  	} else {
> @@ -550,11 +551,11 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  		 */
>  		offset = bio->bi_iter.bi_bvec_done;
>  		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> -		segments = bio_segments(bio);
> +		nr_bvec = bio_bvecs(bio);

This scared me for a second, but it's fine to do here because we haven't
actually enabled multipage bvecs yet, right?

>  	}
>  	atomic_set(&cmd->ref, 2);
>  
> -	iov_iter_bvec(&iter, rw, bvec, segments, blk_rq_bytes(rq));
> +	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
>  	iter.iov_offset = offset;
>  
>  	cmd->iocb.ki_pos = pos;
> -- 
> 2.9.5
> 
