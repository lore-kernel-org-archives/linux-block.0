Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180C37F303
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822337; cv=none; b=SRsjv/WS/2rNQxIum36hkdJagtye2OO7qY00DP5lo6vaHzXiWu8chPODeTvbOoQcx0l9DhpAlMCUjXMOcdb+KvjkL+ysV/x7m7lwp0LdOoq2lQQyRReiFv1F1levTjq4xibPl7CjYQMqPUMUxUILAmysLoBN8fdjJDZOSof+zco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822337; c=relaxed/simple;
	bh=EMh7ppnn8x3WB+5rZ+zDhnAj7ui3Oe/fgDCu4NGFPw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chl7j8O7RYAhN4n1r6Tw+7WPUDGV5YJrg7ekzCeqC/USWCf2UQEQOXIp+HXzV6ZbJuIpkz9CEApF/H0Oq5Ly9OMx7xivEfTpKYEIpV/3d4Js26F/jKXMMf7KI6K8dkeDsN92G82qncixKbpl4pbZX7t6NsJwp37tivZxqZKyy4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RunFr/Rl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iebAm9gJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RunFr/Rl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iebAm9gJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784822334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kTcgSVyFAcPmMjSfflHV0yfNSOwJbU/zquJcaYOhNd0=;
	b=RunFr/RloeH28HEvCTdLsFaFwvExenrt7b8kGIXvHSn0savHx5tKtOm/bSCqZN5C0uG55j
	1Ol2yEwwznjH2xqMQQqDkPQc103pWPW1sHL6bKh1JteO0VbB2yV8MVGq3xKP6Nfhz0L76H
	Sy5k5vn5/OeKsRutpxDTxs0fAvadX34=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-blcxBnZuNxu_y1MlHgVQ9Q-1; Thu, 23 Jul 2026 11:58:52 -0400
X-MC-Unique: blcxBnZuNxu_y1MlHgVQ9Q-1
X-Mimecast-MFC-AGG-ID: blcxBnZuNxu_y1MlHgVQ9Q_1784822332
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472a798fc7cso548922f8f.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784822331; x=1785427131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kTcgSVyFAcPmMjSfflHV0yfNSOwJbU/zquJcaYOhNd0=;
        b=iebAm9gJSZao9PP4vqL0H7YVh+asDuk/PsK9Dew4zxfC9+tAScCxl0HwlujwNgwbRi
         c/v+sNAtCYkT9UVHwWnRwzzOtySxE7gf4TSLlfLjeL1OIEj+wA4KA1jiRF/wlqCJX1kU
         4nz1hXmedWS+yS4iEmYKbTrOALh311e4JF4prMCqfA/ybRbSxlu0G7G9KIBdxF6LaQH2
         G7Fv20T2sS8PDScKrxXDfqdmXUsY8gstanwHHLK85MabIvB8qa2M7usSJwp4oSnaw6GJ
         z2W1ojiuDsdphzSoxeE9wL9RIc9xESieh923r2vND96WZO8/C0hwH48y/BMKx2IVGw+L
         oTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822331; x=1785427131;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kTcgSVyFAcPmMjSfflHV0yfNSOwJbU/zquJcaYOhNd0=;
        b=a4qAHLNCVtuIBthkNdhkYBNU6sVCrl+zh5ZIRtH5pBcD12fa6QblvJFu60ccB70cqb
         ftWN24F3fjXaK4DxWKdxGTrgJ8TrC8MpTN8yjOsVfoEZBAjM7kYpk0Qu+4MrW2qe2cPZ
         cBtIc7cR/qtnplVOpy9Y5sWZVn6m+rwDar/UQoofjEWH+ncGyZbwdZTIGZA10J5KgjPf
         mJUphLXYlkHVucSOj56ecaYtttKjaWfRZX6yLKiRYNQ36PdPbr1nwRBb0AFRHbc9eCjE
         oZMwgupOGB4HqkXw3mLtQMzPghiTGJjmKrUYGZSjWpIxOA6huy30JCGq/gTLxVLdfs/2
         exNA==
X-Forwarded-Encrypted: i=1; AHgh+Rqvmh15sUbw4mNaVko4acJHvJqBMODqGYsfXUEMGnFyJxSYwVfc/NIqGQtT227LmK41YRy1obR/fcS2Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3IU9TqL/wqvj1UnUlhRYnGy25ZOQR6shmJY2nAJvMPvT51Y/B
	223DRefKlmuX8Ot9d6fNUEOhB3WqkP55YOC3E213/76srLhSA+HcCvw0f9sklD2ldki9JtxKJEx
	Fz6kxgIKdgU902+7UyieySPiApumVagi5jUTR7Gh2eBHiCys9EqhQ0foEpazyzwU=
X-Gm-Gg: AR+sD130isgEx7PzLPDt613r59rU/4HsmZKT93onKzeq0RfjGoZg4Wdo3rfqpWdguqe
	N70rSn8NVBEnmBOfHrEWfUvQEkUZotaRX3NCUCuRd7OIPGODFIfWv0vNk4pck1R5lkS6Oh3o2W4
	zGRKWR/GrmfY1+XbPAr2HSwTXF7oN/zREgz/E47xBgRFIEAQH6pySqugYaxmbYVCVqA3aKPHj+c
	15c/2TenDWnnu/3FlTXYIh+EEmCsp/G/Obyti3WsW1EJAXEWVxaZF0+8BmN+dr8CYMy0btWpT+g
	Jaq6++idVul3sj0rlCa+bSiHYVBINNCzPYX0iVa0LfsGSrSkouNsuxm4DTfFxjC34KdWqCQMlC4
	NGhyCBI8rnjL1smbQmSC46SEpd554LNixNCQ=
X-Received: by 2002:a05:6000:178d:b0:47f:7030:bfbd with SMTP id ffacd0b85a97d-47f8dcb2717mr4806740f8f.48.1784822331473;
        Thu, 23 Jul 2026 08:58:51 -0700 (PDT)
X-Received: by 2002:a05:6000:178d:b0:47f:7030:bfbd with SMTP id ffacd0b85a97d-47f8dcb2717mr4806698f8f.48.1784822330928;
        Thu, 23 Jul 2026 08:58:50 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85a2573csm15659173f8f.0.2026.07.23.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:58:50 -0700 (PDT)
Date: Thu, 23 Jul 2026 17:58:49 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/22] xfs: use BIO_COMPLETE_IN_TASK for bounce buffered
 read I/Os
Message-ID: <amItES6s54i1QSHw@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260723145000.116419-1-hch@lst.de>
 <20260723145000.116419-19-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723145000.116419-19-hch@lst.de>

On 2026-07-23 16:49:43, Christoph Hellwig wrote:
> Stop using the xfs per-inode work struct for completing read bios, as
> unlike writes we don't want to serialize reads on a single inode as
> there is no exclusive resource contention for them.
> 
> Factor the code for kicking off a read that needs and ioend and the
> task context completion into a single helper so that it is split off
> the xfs_end_bio machinery, which is not only used for writes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I would probably need something like this for fsverity.

When using integrity checksums with fsverity together, both file data
ioends and fsverity metadata ioends get onto the inode queue
(without checksums there's no metadata ioends). This way worker could
self-deadlock if data ioend processed first in xfs_end_io(). It will
call verify_bio to read merkle pages which could be already waiting
in queue.

I initially considered changing xfs_end_io, for read ioends, to just
schedule them instead of adding to the queue, but decided just sort
metadata ioends first in the queue [1] as a bit simpler fix.

The difference is that work won't be scheduled on the high-priority
fsverity's workqueue. Not sure how critical this is as with
checksums all reads would be the same priority.

1: https://lore.kernel.org/fsverity/20260721184346.416657-15-aalbersh@kernel.org/T/#u

-- 
- Andrey

> ---
>  fs/xfs/xfs_aops.c  | 10 ++++------
>  fs/xfs/xfs_file.c  |  9 +--------
>  fs/xfs/xfs_ioend.c | 32 +++++++++++++++++++++++++++-----
>  fs/xfs/xfs_ioend.h |  2 ++
>  4 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 49d21d905cc3..76918bd15ca8 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -580,12 +580,10 @@ xfs_bio_submit_read(
>  	const struct iomap_iter		*iter,
>  	struct iomap_read_folio_ctx	*ctx)
>  {
> -	struct bio			*bio = ctx->read_ctx;
> -
> -	/* defer read completions to the ioend workqueue */
> -	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset,
> -		iomap_ioend_flags(&iter->iomap));
> -	iomap_bio_submit_read_endio(iter, ctx, xfs_end_bio);
> +	xfs_ioend_submit_read(iter->inode, ctx->read_ctx,
> +			ctx->read_ctx_file_offset,
> +			iomap_ioend_flags(&iter->iomap));
> +	ctx->read_ctx = NULL;
>  }
>  
>  static const struct iomap_read_ops xfs_iomap_read_ops = {
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index c0c3a11e7ff2..d31a1dddcdc3 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -37,7 +37,6 @@
>  #include <linux/fadvise.h>
>  #include <linux/mount.h>
>  #include <linux/filelock.h>
> -#include <linux/bio-integrity.h>
>  
>  static const struct vm_operations_struct xfs_file_vm_ops;
>  
> @@ -236,14 +235,8 @@ xfs_dio_read_bounce_submit_io(
>  	struct bio		*bio,
>  	loff_t			file_offset)
>  {
> -	struct iomap_ioend	*ioend;
> -
> -	ioend = iomap_init_ioend(iter->inode, bio, file_offset,
> +	xfs_ioend_submit_read(iter->inode, bio, file_offset,
>  			iomap_ioend_flags(&iter->iomap) | IOMAP_IOEND_DIRECT);
> -	if (ioend->io_flags & IOMAP_IOEND_INTEGRITY)
> -		fs_bio_integrity_alloc(bio);
> -	bio->bi_end_io = xfs_end_bio;
> -	submit_bio(bio);
>  }
>  
>  static const struct iomap_dio_ops xfs_dio_read_bounce_ops = {
> diff --git a/fs/xfs/xfs_ioend.c b/fs/xfs/xfs_ioend.c
> index 40695d18dac0..37a3ae8066e9 100644
> --- a/fs/xfs/xfs_ioend.c
> +++ b/fs/xfs/xfs_ioend.c
> @@ -16,6 +16,32 @@
>  #include "xfs_reflink.h"
>  #include "xfs_zone_alloc.h"
>  #include "xfs_ioend.h"
> +#include <linux/bio-integrity.h>
> +
> +static void
> +xfs_end_io_read(
> +	struct bio		*bio)
> +{
> +	struct iomap_ioend	*ioend = iomap_ioend_from_bio(bio);
> +	int			error = blk_status_to_errno(bio->bi_status);
> +
> +	iomap_finish_ioends(ioend, error);
> +}
> +
> +void
> +xfs_ioend_submit_read(
> +	struct inode		*inode,
> +	struct bio		*bio,
> +	loff_t			file_offset,
> +	u16			ioend_flags)
> +{
> +	iomap_init_ioend(inode, bio, file_offset, ioend_flags);
> +	if (ioend_flags & IOMAP_IOEND_INTEGRITY)
> +		fs_bio_integrity_alloc(bio);
> +	bio->bi_end_io = xfs_end_io_read;
> +	bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
> +	submit_bio(bio);
> +}
>  
>  static void
>  xfs_ioend_put_open_zones(
> @@ -148,11 +174,7 @@ xfs_end_io(
>  			io_list))) {
>  		list_del_init(&ioend->io_list);
>  		iomap_ioend_try_merge(ioend, &tmp);
> -		if (bio_op(&ioend->io_bio) == REQ_OP_READ)
> -			iomap_finish_ioends(ioend,
> -				blk_status_to_errno(ioend->io_bio.bi_status));
> -		else
> -			xfs_end_ioend_write(ioend);
> +		xfs_end_ioend_write(ioend);
>  		cond_resched();
>  	}
>  }
> diff --git a/fs/xfs/xfs_ioend.h b/fs/xfs/xfs_ioend.h
> index 525865767fca..7c2a1ea3e6ed 100644
> --- a/fs/xfs/xfs_ioend.h
> +++ b/fs/xfs/xfs_ioend.h
> @@ -12,5 +12,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
>  }
>  
>  void xfs_end_bio(struct bio *bio);
> +void xfs_ioend_submit_read(struct inode *inode, struct bio *bio,
> +		loff_t file_offset, u16 ioend_flags);
>  
>  #endif /* __XFS_IOEND_H */
> -- 
> 2.53.0
> 
> 

