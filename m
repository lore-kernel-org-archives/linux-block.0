Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBCB749A
	for <linux-block@vger.kernel.org>; Sun, 24 Mar 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316934; cv=none; b=dozKA6yMoHRwYqCrldCBPnp+/u+nJqAm5FIKtkoxzJ76ikyXJZ1+m7OBNIBH426JaP9FG3q1JIBEJdGr6n7ANlZ6z1on+l3t5Q34m6X1C369ZmT54Xre2iRhCCYJAJSLwyFmdRo1JcFjwea+xim+VL+noS5H7duMs6LSKuIbLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316934; c=relaxed/simple;
	bh=3Ast2CrmJbetUoKupZJ0xPcufqlarszHYH7/2n/qlg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaLOtBpnQDiqGRwXh42u9AHpu+HHXQqa1WjAj6pQIaSd+9IwrCBXkhY1eqFJKgUXbUR5V6gJm3B3OXhFw/pTrun+JeTxPZLdlNh5m6Ua1yOBeiLnmGJhOR2oWfXG8IbbMppH75Qny8kVkJXjAMIdzgxy4buTOXEa1tblWD8RJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6918781a913so33906146d6.3
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2024 14:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711316932; x=1711921732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQClB/OlLB3Zz9sLCishbIZaPtgYfBjnjrx1cp3mZb0=;
        b=EqAGEpG6cpEqKlRHubV2usV4O6AwwAuGf3nZUu8mxlK6I4sACBLJEyHGOgkrjVlR67
         iRzZ6Di/TXdleZZ6fKlZMck7Sn82FmDEYSY4FgKmuTpQeTQuwnPphE42KjyJ3jfP4Iez
         mZqMen7/KIgoAClt04kfxHwzn429W8qSRtC3Dxpyp0XcvPM03ft8kCFRhlbLTbOwC3OX
         MQE5yH43/j6FLAnpuFMbjDD9dQiSj6qno6iwqjcb57MaURpymoDP/Aayyhb8W6MFduiy
         GnDaIpDmNMQ06shz1itpehgSDXRjn+3IdALCGTmD1LKcwzi5eI54nBvhpelqccUqoVY5
         n1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeR8ePUMtNtZH2tx7OHC/IOArbM4jKeDmZoUmj2XG0Nd/twIfdqHgUTBhvdZOn9xR/LwMXosAASvJ/l2lUaOC3q78m/2JA5Y+Icuc=
X-Gm-Message-State: AOJu0YyvyN69QjePjpR4o8W8w5R+OWznzu64Fc4sPD2yacVHSTE7dGIU
	qLVB5LpHDeqH8nrsuLqrxITK7w/Qx04nSKq2R8UuB7nC9EN8TPKJvFfnDaU50w==
X-Google-Smtp-Source: AGHT+IHwxCvzR6MAh4bjzMWcr+MSZGB7sFIjse/JkghXPSKnNyRC4kYYtoUtnWn8o5xc+CM0AhHM9w==
X-Received: by 2002:a05:6214:1308:b0:691:e21:736c with SMTP id pn8-20020a056214130800b006910e21736cmr7131454qvb.30.1711316931864;
        Sun, 24 Mar 2024 14:48:51 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id i11-20020ad45c6b000000b0069068161388sm3388777qvh.131.2024.03.24.14.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:48:51 -0700 (PDT)
Date: Sun, 24 Mar 2024 17:48:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH V2] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZgCfwkb8wMKBcshm@redhat.com>
References: <20240324133702.1328237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324133702.1328237-1-ming.lei@redhat.com>

On Sun, Mar 24 2024 at  9:37P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> For any FS bio, its start sector and size have to be aligned with the
> queue's logical block size from beginning, because bio split code can't
> make one aligned bio.
> 
> This rule is obvious, but there is still user which may send unaligned
> bio to block layer, and it is observed that dm-integrity can do that,
> and cause double free of driver's dma meta buffer.
> 
> So failfast unaligned bio from submit_bio_noacct() for avoiding more
> troubles.
> 
> Meantime remove this kind of check in dio and discard code path.
> 
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- remove the check in dio and discard code path
> 	- check .bi_sector with (logical_block_size >> 9) - 1
> 
>  block/blk-core.c | 16 ++++++++++++++++
>  block/blk-lib.c  | 17 -----------------
>  block/fops.c     |  3 +--
>  3 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index a16b5abdbbf5..2d86922f95e3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -729,6 +729,19 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>  		__submit_bio_noacct(bio);
>  }
>  
> +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> +{
> +	unsigned int bs = q->limits.logical_block_size;
> +
> +	if (bio->bi_iter.bi_size & (bs - 1))
> +		return false;
> +
> +	if (bio->bi_iter.bi_sector & ((bs >> SECTOR_SHIFT) - 1))
> +		return false;
> +
> +	return true;
> +}
> +

You missed Christoph's reply to v1 where he offered:
"This should just use bdev_logical_block_size() on bio->bi_bdev."

Otherwise, looks good.

Mike
