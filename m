Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894071DFD8
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881099; cv=none; b=nnYo4uj2aRl9nCdCldTNQE2jqBr3TVogj1AgbmYfnTzVtLhplkpZgD2FYEQ2uYTgeXhhuFmP99v3DJv+M1Gi0S/wBjZ6mYtrxLzwD0btJ9N+VoJsAQqSRYKew0h2MUtdOp8f21+ZpM7ZiCmbg/hxGmqMUVM8Wy9/1ePLsSvmvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881099; c=relaxed/simple;
	bh=1ofbrdaWLVdHUGxBkgA93LdIUCYbEShz/TryfOVyq6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofQmuxIjvYuQM2GU/VLEeagMJ/asUoHkq8KC+wgppubqX15qnu5cpVh4DLNz8vq3uRqQZ+xLKPeA0jx06DAY5KIlE5Vs72ccp0cnyh9pXi+AvEDL5/wyYFmhULjXg82Tq8ld2lljY4lHEbDDaQWSzbDje3+SED494NzfcVqR0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LQ0fbwrM; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LQ0fbwrM"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-288a990b0abso1210103fac.2
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 11:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729881096; x=1730485896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIM5DGiJ6PGvlZJHET8vwbCjolmj9XxWNBNIURynsP0=;
        b=LQ0fbwrM7lIxclygDmyrE7gOipfktsrgJ5XFXZI1LJb1d8KkdCVIiEXoy4/dag75Tp
         Iq7VxpP1wssD4Gbvkz/vybMZ08kJAHXl88GpRLUyJwN0ZDHNyWSkBfTcqxAMDCPK30BD
         GAilL0wl9nSrQ9YaQqQe1JoXSMvoZ9DNj9vbHFA7niF2W0Axakdwdc4F73fdRhJ2WCcH
         AIom/2SX+Tx6M6W7DAeX3V4wmY0uZ63mQeBedbOaH9toDObfGF7jvyvz9f5ZHfuD5G71
         rgG5Tm8ry/i75mwJG2xG4nNZsYHxmSOmpFG8PP/uZ5PFfE1Ib2TQvt7PTi0kEt5f0etD
         l/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881096; x=1730485896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIM5DGiJ6PGvlZJHET8vwbCjolmj9XxWNBNIURynsP0=;
        b=U4RhfHqLjuyL3LzqFtDuO0/0y+ztGU3IFFuuZb270QrbL/bHBtKCL7wmxI5PpGYrrP
         VyUjaEWFWiBNMMNHJurNLeBxIjx2Bd7Wvm6RJDCp//lbJTn3Vrs7x8suiUuP1Uhb3ex2
         pTvQ8W1Ye9sDLTjTYY0ys+MxpqpQMF+uMG4K7yeCO3T0lTpBSCJohjdhYdDYiZKM7kFY
         8pYGFkFZJjzzJtXHYJu50ccex0Lsloa8k1HrtJ0b38K7veFrTIcj1liKCGp00cekjp7h
         V5c5vRvOWNg/mMWrGsyzFlcnHg2Q9ixiSWGYl7rEdNifkLsaeJ+lDYEC1VAckD97kpFp
         w/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCV2QJ0rLsVkNYk+eILWbBxTItQnwhu9DZBc5Sq3aaCrs61Es9Jt7us4XbhVrJAYsgXOD7MIlt/tE4y6Og==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRNzgStuNgRo+G40w2XSrJAIDogjjjIoaI0PcqVnYpR2BeFR7
	LuYpwukmldYqBZS/zlBHPOzBliCQN2G24lvZKoKb2THsUS80VtOLW04/0t/iRIAdkkuuTAmhCR/
	U4cdr8IHYtTdYrEL53uxuXVORpyOzsgf0OQyBViM5e+KhAFCh
X-Google-Smtp-Source: AGHT+IEr9jXs7b2AOWsWivDEC34tM6qcAevxNhAYRCEXmg0Jm92otJwx7oluktoSjg0Njxb5JAtK1LVjUCnS
X-Received: by 2002:a05:6870:d207:b0:277:eb15:5c60 with SMTP id 586e51a60fabf-29051af7146mr430594fac.10.1729881096380;
        Fri, 25 Oct 2024 11:31:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-29036eb60ddsm55354fac.28.2024.10.25.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 11:31:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 65AB9340325;
	Fri, 25 Oct 2024 12:31:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 5A05BE40EF3; Fri, 25 Oct 2024 12:31:35 -0600 (MDT)
Date: Fri, 25 Oct 2024 12:31:35 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, xizhang@purestorage.com, joshi.k@samsung.com,
	anuj20.g@samsung.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix queue limits checks in blk_rq_map_user_bvec
 for real
Message-ID: <ZxvkB/6KBq7XwWAU@dev-ushankar.dev.purestorage.com>
References: <20241025115818.54976-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025115818.54976-1-hch@lst.de>

On Fri, Oct 25, 2024 at 01:58:11PM +0200, Christoph Hellwig wrote:
> blk_rq_map_user_bvec currently only has ad-hoc checks for queue limits,
> and the last fix to it enabled valid NVMe I/O to pass, but also allowed
> invalid one for drivers that set a max_segment_size or seg_boundary
> limit.
> 
> Fix it once for all by using the bio_split_rw_at helper from the I/O
> path that indicates if and where a bio would be have to be split to
> adhere to the queue limits, and it it returns a positive value, turn
> that into -EREMOTEIO to retry using the copy path.
> 
> Fixes: 2ff949441802 ("block: fix sanity checks in blk_rq_map_user_bvec")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This passes my test for NVMe passthrough I/O using a strict subset of a
preregistered buffer (see 2ff949441802 for details).

Tested-by: Uday Shankar <ushankar@purestorage.com>

