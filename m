Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020A078B5E
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590541; cv=none; b=tz7NEKEbNW2eh6m29LJ+CFQ0UJuUUh/q6+26lKzBj5xQ3q5+d1iU0JVoCJxz2DjZViC7E+bYqhGNuj4iX8Qjz/UNITinulLwopX9En9AaZJA1dbhIQG5oDmLpZ2w2bawOariD0BZfCBUr5ypTd0WDveTEfh1kZBb0Lun+gSEx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590541; c=relaxed/simple;
	bh=rSGFobPyTkrtYOKrWnakciYsu5Thh2UHXGCu4vHBxx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSQLuyacsAXzjl0BB27HX75jHpbGZ3wbNXUrZTYu0qJA48RcwEbeqEwvxw2pg4M7GuG1sE5cLfHr9Pa1ymRVBj2CfgKY/Cpe2HM9WhzCXoexmusZcpLsZZLYPVyvs9KHZhuo9OqhCmj7uQj+PQ4rvq5icjaIksenLEqbN38cWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=nKE7NNwt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nKE7NNwt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc49b00bdbso45209265ad.3
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2024 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709590539; x=1710195339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CARpH995S3Hk2OhajVVG/E9yFa4bHHeBmVGYbe1yvEM=;
        b=nKE7NNwtDebQIvzwuNHl5MXrTWR1UYwV5rImMRz1fx4XP2MDAGkd2QtFgsPkmI1Du+
         wXCtUsUKqskJFBoNfABQdyfii/cyc0e2lhvzqDeACTDNcUxB4rFIPDxRkHxlw4q/LBzE
         KEHIEjVZskCndd0JygzSttr8UDvQWtOlI662N2fVlVAxc1y7ZQf6H9WH4JHpXNQIVscU
         gBnbaIDCnr9enEdVG2l2qmplVGSy8wYbLigXTRwDwpA66xljxLSNE4ilcNSzcLbqqWzY
         6nB1h4GnI52/dzRdr88JxXAZtmYHZshYZuxeEhN6ppCduLyn0g1ncwOd/iZ6gF1IJYnh
         CPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590539; x=1710195339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CARpH995S3Hk2OhajVVG/E9yFa4bHHeBmVGYbe1yvEM=;
        b=Txsm4JhR7DWg0MKdt7eHl9nVTO7EW9kDZJpy4qzFbpDQQ0CP3slZ/6HMHlgqrAsOL+
         LG4b14nPG6miwPzdbodczp0sfk3Hg0rA1NJVcZrmo4b3jR8XggDRdlKlfMqM0Ew8fmjE
         C84ih6vc67NmVGNE6OfP1ZIfYRfzj4lZMT0VnAhuirWkDOi8mqNxPTcNq/sUpFt3DarT
         tiV95NC2b8h3gh51hbRBTJoCnnc0GbnYvL9Cgvma92OY7477l1BkeT86sOiGgqjlRW+e
         ICpE398I4+VcbKbnM4R2eFosbyncRPy8RmfrMV7scoAqbI1RkCwaMI9gI4v1XDLEyUAR
         5H4g==
X-Forwarded-Encrypted: i=1; AJvYcCWo675Pe9iqgd8dv+wQV5XvV4D0XGPvPmhqZVtRS+gZNW1Azc0PpGGgOUx/sGMFsTQ/91XJzJ+PrzdUPxc7s5VBwmWbTK37eU9o2aQ=
X-Gm-Message-State: AOJu0YwLSLl2a87xxfFcWaPqQ5OhXYWnLcnu1w71CklmkmK8rkMBA8nL
	XHJAKkSwaDjGqf6MJc2rt0tEzXZnp12X+EoG7WblX7J8Hmt5c6p2OMLmpM3TpYA=
X-Google-Smtp-Source: AGHT+IHjDF0RDc8u5rnaR/asbdM4SN8DQz/RLkAlmnt/uLBjLn0m2kj8Q8ebupgqkBNzu1lOIT8Y/Q==
X-Received: by 2002:a17:902:64c9:b0:1d9:f5dd:2480 with SMTP id y9-20020a17090264c900b001d9f5dd2480mr80144pli.54.1709590539370;
        Mon, 04 Mar 2024 14:15:39 -0800 (PST)
Received: from dread.disaster.area (pa49-181-192-230.pa.nsw.optusnet.com.au. [49.181.192.230])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902b28c00b001dc94fde843sm9007439plr.177.2024.03.04.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:15:38 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhGat-00F5P7-2j;
	Tue, 05 Mar 2024 09:15:35 +1100
Date: Tue, 5 Mar 2024 09:15:35 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 02/14] fs: xfs: Don't use low-space allocator for
 alignment > 1
Message-ID: <ZeZIB0G3zjaq7dWK@dread.disaster.area>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304130428.13026-3-john.g.garry@oracle.com>

On Mon, Mar 04, 2024 at 01:04:16PM +0000, John Garry wrote:
> The low-space allocator doesn't honour the alignment requirement, so don't
> attempt to even use it (when we have an alignment requirement).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index f362345467fa..60d100134280 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3584,6 +3584,10 @@ xfs_bmap_btalloc_low_space(
>  {
>  	int			error;
>  
> +	/* The allocator doesn't honour args->alignment */
> +	if (args->alignment > 1)
> +		return 0;

I think that's wrong.

The alignment argument here is purely a best effort consideration -
we ignore it several different allocation situations, not just low
space.

e.g. xfs_bmap_btalloc_at_eof() will try exact block
allocation regardless of whether an alignment parameter is set. It
will then fall back to stripe alignment if exact block fails.

If stripe aligned allocation fails, it will then set args->alignment
= 1 and try a full filesystem allocation scan without alignment.

And if that fails, then we finally get to the low space allocator
with args->alignment = 1 even though we might be trying to allocate
an aligned extent for an atomic IO....

IOWs, I think this indicates deeper surgery is needed to ensure
aligned allocations fail immediately and don't fall back to
unaligned allocations and set XFS_TRANS_LOW_MODE...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
