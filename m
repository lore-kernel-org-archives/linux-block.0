Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9B233149
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698325; cv=none; b=UIQ/uLI/5GaVt0kw3lPuQkUIbHjrl/wjoM/iUDucJ5nNvqtn0gGNqnl9jjKxjHB2pS1RxKb1ziivZMnuatNg2kxoVOzjRTXNGzLv8xQ/aYSHwsUmvTCngVPqc1zRgDb+brhQvBenR2savRx44SYaBkjMgd6+eWLa1H5znPQBbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698325; c=relaxed/simple;
	bh=whQFO0imdqg5QUuh6ridbMtxCHkQa/EwXHMd6X70r/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgBbCZWyZYuyEvtlKbuh9fH/lyRBsuYMDmuV5Js9qAT9BlIoQm4+Sw3e0v0SqL8Lb9pTy7j1UJxsIkz1gLUEfLCNxssILwVfXmHhVJhT6oD48kSTyzwCOcxuU8Kv7ZRp8FqWChaAuAC036mnBmmHmQq+/VJn+wsG0fMatwk6w5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE/vJbin; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n8XZk00q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE/vJbin";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n8XZk00q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769698323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m31pY/sxRUdVfac4+BuGSMMKkDrCtKZLQDSOVfYYwBg=;
	b=LE/vJbin+vML3GMH8ozEbd+Ymh4W+biVwpOENBcAlkwfaXUZ5No4RrpGMt0sDJzqNKJzu6
	/p2nXMiGdRHLsqsEINhB343v2bYgCiWR38eFf6ROFA3Qe3pIyAtEASRfbfz1o/Ph1MES4p
	Sl2y19jl0MBrZEoDlQ+bT4MVzXFz5yU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-iRXEI_eAPb2RkXCYT6YAuw-1; Thu, 29 Jan 2026 09:52:02 -0500
X-MC-Unique: iRXEI_eAPb2RkXCYT6YAuw-1
X-Mimecast-MFC-AGG-ID: iRXEI_eAPb2RkXCYT6YAuw_1769698321
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47edfdc6c1aso8340585e9.3
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 06:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769698321; x=1770303121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m31pY/sxRUdVfac4+BuGSMMKkDrCtKZLQDSOVfYYwBg=;
        b=n8XZk00qTMzK2Cjxlcj2wK5j2URV+5RJ/SAOd3zOCAmXtv8T6pxPw4zvyK8Lqjiwwl
         I0W0dfjtEbPO0q+yBazr19sqn2x9WnG7xsaVu4/EX/JjCy3tFDVs0+/YRPPEkBIOYKqK
         yAQKpvJOf7HkUyj8HELQHkQdJn9Ir9EVykf6Q7c9PENEZfAQt1M5y+5WjapZwzwpoG0J
         B9o4nZz1yKSuDiAM8vKSVVDp9Aut8I1xY04DYJxPspjkj0xnyXpXCcZ5RqneCQKSEUyc
         4HG5JkCfu+gz+G+vZBOZtTQJJOzxrQbNKcV5g1tAvejl4yKV3Gcm86SKyU72H5tW1HMF
         goPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769698321; x=1770303121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m31pY/sxRUdVfac4+BuGSMMKkDrCtKZLQDSOVfYYwBg=;
        b=pHfPz/MGU8hS1//HJyhXxFKOfFbouSROy33qp5JHeeQpdMfL+gKehRsh8axqqFqb8T
         81C9Vo6/OlQWX/eD50TuzEBT8VkxS90jpfNdlv6TeEp2G7m63IKMhTw2izG0BUfGVZaM
         mfDi/7Xo3dyKH1vK3FGzDV4D5SKYSjy/j8YJMXh/BuXGeeV8sixvvfb9YSt1AgBcaZDq
         gswBlKkOXrPLHJGnvSz34PFkJ/Whu1+1cmFQ1zGogKsKm7pVyEb8qRMhtnFpIkoWJMjg
         o4iQmEOQcIW5QQtWAqAP12qSuuTm0VVesZu1EvWEgiI+R1kkWkhSpbejFJbM3hqJqbrw
         q7pw==
X-Forwarded-Encrypted: i=1; AJvYcCWyZB2SjqoBwjxJ+9s/5LdyDk/d3rRTgMsbNJmg7RCCX4uFGPjz0yLlCMbqmon9Yj+QymKfP/zR2JdZKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2AI9EnewBCC3vdNpXs+4r9n5fRR8KOZqN0Z9gNvX/5DnxUqQ
	c2hiQYzeD+431zUIuQZiq9y+TuWxV+31jDxzZVVQHC+NgPU6FQ50Z7tbI2q1UhS8UHVs/URdHV2
	T7YzeBg6wBg5Tt6qmCNG06CYKcaBHVaYgMyCSFH1/6BEKB4/UveN/Pz/kly4M8mU=
X-Gm-Gg: AZuq6aICW4qe9m8iKXUsNGdTfkfSxcNTg5l6ZFborrDIbwoAPCrZoJnpBtcxI0xt4GO
	3cDPCceAfJMDdHd31OyBPx3sWCSYHwP+D/vGj36ER9r4AeyKt9NoUqoLxsO5wiOkPVJRSXdl0SK
	sWKOww9b+e5/cXkMZcmjjBu0/jDxmYIwpGZPJSSBuMfrWs2D2X14kTeVWWBpRrVOO3l8CKyK+QN
	YG+Tmvm5mwvVeiXEKhWBFmIHzIr/DHQkPpy5ysdEF4K/Er/kZ1pbCw1b6rBHSwSsZvFSccc8xfx
	pGTytdZjDeWy1cjSrqZ93eYDEs0nyooh71EjPqR56DA7rnMq8Db6cFcQSanjj83vVPvwDjyeJfQ
	=
X-Received: by 2002:a05:600c:4f4f:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4806c7cc86dmr120529885e9.16.1769698320792;
        Thu, 29 Jan 2026 06:52:00 -0800 (PST)
X-Received: by 2002:a05:600c:4f4f:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4806c7cc86dmr120529435e9.16.1769698320273;
        Thu, 29 Jan 2026 06:52:00 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d31651sm5851205e9.4.2026.01.29.06.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 06:51:59 -0800 (PST)
Date: Thu, 29 Jan 2026 15:51:58 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/15] xfs: support T10 protection information
Message-ID: <5xaomhu2q2jf3w2hbtkh22dytfiqc6wqyslcfoiqdcwgsud5wk@4ykdof27ntxb>
References: <20260128161517.666412-1-hch@lst.de>
 <20260128161517.666412-16-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128161517.666412-16-hch@lst.de>

On 2026-01-28 17:15:10, Christoph Hellwig wrote:
> +static inline const struct iomap_read_ops *
> +xfs_bio_read_ops(
> +	const struct xfs_inode		*ip)
> +{
> +	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
> +		return &xfs_bio_read_integrity_ops;
> +	return &iomap_bio_read_ops;
> +}
> +
>  STATIC int
>  xfs_vm_read_folio(
> -	struct file		*unused,
> -	struct folio		*folio)
> +	struct file			*file,
> +	struct folio			*folio)
>  {
> -	iomap_bio_read_folio(folio, &xfs_read_iomap_ops);
> +	struct iomap_read_folio_ctx	ctx = {
> +		.cur_folio	= folio,
> +		.ops		= xfs_bio_read_ops(XFS_I(file->f_mapping->host)),

Hmm, can we use folio->mapping->host here instead? Adding fsverity,
read_mapping_folio() will be called without file reference in
generic_read_merkle_tree_page() (from your patchset). This in turn
is called from fsverity_verify_bio() in the ioend callback, which
only has bio reference. 

> +	};
> +
> +	iomap_read_folio(&xfs_read_iomap_ops, &ctx);
>  	return 0;
>  }

-- 
- Andrey

