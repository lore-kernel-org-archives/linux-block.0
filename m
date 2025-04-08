Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474F22D7B2
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152664; cv=none; b=ZgJNklsFnLwPNt0x8EMROxgaPsw5CbRm7It4+cGyNBf5EFx6KfVTaevsz0ra8G44NSRLhUvimqJrnaUCFQm9SWhYXHbyrA7z5UStlphgMfn8RG7+HUUBOQGM3Ot43DVNRarmpyLiwNzcquIILRKrtUATKpUdZL3HzvDTHsampns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152664; c=relaxed/simple;
	bh=vMn/pqlIgdXeLiIiX6Qi2jw179hC4RQghNBS8hGqYZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4b8X9Ij5n2KSsozg5EBq+MMfolBYB4Ykt1Ho9WcTHVYswOsktyx0CvBTw23vaANj6stSeAGAO4Ohl8736GbNjaWm9b5+SOq8mXBkgCmNzqdvES1J375mLHsdtdG27qbke+YJ0vgQBhcR8otN2XNihWWnkXNI1gvaVkTfLZWVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vW5fBzAe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vW5fBzAe"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7398d65476eso121728b3a.1
        for <linux-block@vger.kernel.org>; Tue, 08 Apr 2025 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744152661; x=1744757461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4e6TcScSbS46TYPzeS1oWS93atKNlcHoXycK2oxcMQ=;
        b=vW5fBzAe0imxu4fNHVLF4G0+rBz6dchsprA38wmkFpTUyJDs6MmA0hRVK/3TJEarkR
         wcOFCYgPGCGbQxejqah1vjSnYWaXl0Llt8YGa3+DTV/7ykPq0WdD21xS7uJ0HWEwy1W+
         vduYKCqV9Vb+QmQEkayZNQpKBCaFWcN4XG9PYDTduUz/euckEU4pCV1wLbfeRWF581FW
         23v7nbe75gdUBCvuyyczWq7xsX14MWOIYjs6iktc4bOM0b6I9ByH6sGQEfQ84LGPztfG
         RnI46D+hkTBe7mJ49Iu6Ggr54GFr/RqMqjyuan0gzOJ1Bo0AevAjEMsb7A4H8f53AL/O
         C3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744152661; x=1744757461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4e6TcScSbS46TYPzeS1oWS93atKNlcHoXycK2oxcMQ=;
        b=fI3wXXDqN9z/vba3izgo+nV2UWxrDyHYs08OwRBcKmDf5ceUDiWWot1VhzziRYAaxz
         3P5lQkv7QCa5ypckDh7xJeEQD5ifdtAvcftBwU3xJ7e1q4bAlA7+LtOV/CJe1H8Zri3V
         Y66wpQqptmCMnYdYq9xxmeznM3SdZJQhKpjGGss8fh3rWS5LXQU46XVRyG9Rh3fxx98j
         oSS1WxZSdm/oa1ArvkCFt14hyUoyd5baEhTkiyEuaYbIncIzkO9rjZqrKUP+F3Fu/rjh
         oiaNjRobViVBsl5l8E3uV69fpsGVqmFamlrpqTnY2PHSE3uyBH/0r9XgT5ydLl+KDQED
         gwcA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Lggzyuot6hAwa4zRFQ6Y4yzl6y5BHDRjfrFTxItOD5ywLaG0IqTUScLx+fs+zNJK9hyjKN+KaNcXwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgxtLzdTny8XFevMY2RuOPKwJnZYp/qwt3jinCzefq2M1FJMA
	q+Zrv/oGISzp02WRS+u5CgtR5jQgNplVFixkA9ftAN/QwmoBT4oq7KjDcyvyXRI=
X-Gm-Gg: ASbGnctyRJfrMA/BYTwXXlbtF5WYsCPCGLBuQoMlhCQrEL0L/W9WOYvhGDTTma3tj2K
	EfZ9rsOBjnHH3jGuOe8KRw9NJJSudSAEltm5h5zP9vaSnQg5AfUyFky1bF1GutnyqFl5Qd8lovX
	ganFcUenUSqHeLNqDG4jpBiD06A3CSObjs8tivfTNhZHMEtAX0+WdDM6SUhYjZcCYC4ECCnPytd
	UFq0vk4pqluZC63zHb/wwHardYQYQ5xt/8dC2MeIRG+ADvVXItpFywoe+WZKU8tShfCGnieIk+8
	MF5TP7/PUWQQ+AW99mBeCmmJq9gNisa8ysic/H8lOU62cVRmD2K/zuBnVqYcVq4lvQkeGlTVL3Y
	pijYFhCdxhpoTyvuh/fA2lc2qHMqG
X-Google-Smtp-Source: AGHT+IH1vqfq5KmC7q977AO5WgEcrZQ60lrohQ1dtQpSWtpSiqHurs35gj5R27z5qJYFLZ4y41PN8w==
X-Received: by 2002:a05:6a00:2411:b0:734:ded8:77aa with SMTP id d2e1a72fcca58-73bae4cc284mr829197b3a.9.1744152661136;
        Tue, 08 Apr 2025 15:51:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0a71sm11117925b3a.113.2025.04.08.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 15:51:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u2HmT-00000006F85-0aHp;
	Wed, 09 Apr 2025 08:50:57 +1000
Date: Wed, 9 Apr 2025 08:50:57 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 02/12] xfs: add helpers to compute log item overhead
Message-ID: <Z_WoUawfJ_QFF5kP@dread.disaster.area>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408104209.1852036-3-john.g.garry@oracle.com>

On Tue, Apr 08, 2025 at 10:41:59AM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Add selected helpers to estimate the transaction reservation required to
> write various log intent and buffer items to the log.  These helpers
> will be used by the online repair code for more precise estimations of
> how much work can be done in a single transaction.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_trans_resv.c |  6 +++---
>  fs/xfs/libxfs/xfs_trans_resv.h |  4 ++++
>  fs/xfs/xfs_bmap_item.c         | 10 ++++++++++
>  fs/xfs/xfs_bmap_item.h         |  3 +++
>  fs/xfs/xfs_buf_item.c          | 19 +++++++++++++++++++
>  fs/xfs/xfs_buf_item.h          |  3 +++
>  fs/xfs/xfs_extfree_item.c      | 10 ++++++++++
>  fs/xfs/xfs_extfree_item.h      |  3 +++
>  fs/xfs/xfs_log_cil.c           |  4 +---
>  fs/xfs/xfs_log_priv.h          | 13 +++++++++++++
>  fs/xfs/xfs_refcount_item.c     | 10 ++++++++++
>  fs/xfs/xfs_refcount_item.h     |  3 +++
>  fs/xfs/xfs_rmap_item.c         | 10 ++++++++++
>  fs/xfs/xfs_rmap_item.h         |  3 +++
>  14 files changed, 95 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
> index 13d00c7166e1..ce1393bd3561 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.c
> +++ b/fs/xfs/libxfs/xfs_trans_resv.c
> @@ -47,7 +47,7 @@ xfs_buf_log_overhead(void)
>   * will be changed in a transaction.  size is used to tell how many
>   * bytes should be reserved per item.
>   */
> -STATIC uint
> +uint
>  xfs_calc_buf_res(
>  	uint		nbufs,
>  	uint		size)
> @@ -84,7 +84,7 @@ xfs_allocfree_block_count(
>   * in the same transaction as an allocation or a free, so we compute them
>   * separately.
>   */
> -static unsigned int
> +unsigned int
>  xfs_refcountbt_block_count(
>  	struct xfs_mount	*mp,
>  	unsigned int		num_ops)
> @@ -129,7 +129,7 @@ xfs_rtrefcountbt_block_count(
>   *	  additional to the records and pointers that fit inside the inode
>   *	  forks.
>   */
> -STATIC uint
> +uint
>  xfs_calc_inode_res(
>  	struct xfs_mount	*mp,
>  	uint			ninodes)
> diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
> index 0554b9d775d2..e76052028cc9 100644
> --- a/fs/xfs/libxfs/xfs_trans_resv.h
> +++ b/fs/xfs/libxfs/xfs_trans_resv.h
> @@ -97,6 +97,10 @@ struct xfs_trans_resv {
>  
>  void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
>  uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
> +unsigned int xfs_refcountbt_block_count(struct xfs_mount *mp,
> +		unsigned int num_ops);
> +uint xfs_calc_buf_res(uint nbufs, uint size);
> +uint xfs_calc_inode_res(struct xfs_mount *mp, uint ninodes);

Why are these exported? They aren't used in this patch, and any code
that doing calculate log reservation calculation should really be
placed in xfs_trans_resv.c along with all the existing log
reservation calculations...

-Dave
-- 
Dave Chinner
david@fromorbit.com
