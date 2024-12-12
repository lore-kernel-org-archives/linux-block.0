Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE433154BE4
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 04:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978110; cv=none; b=O94YfjYEWwCeQUhXieFQf5k4LS5aaMB9dUDBWMQsLsqaNVXPLXEho3P+o+W9TPWBSjk+yB2M/xrwCXZa2/D7zxouQhzdpS1X0cRoxzPEal1HzSnrsxXENGd+bI2WlH1wyHmmEc+3iQPyKc/WcK9ww31FmuOQKFfKNvz2nxE6cO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978110; c=relaxed/simple;
	bh=ilLvlZcUUBmdlXI8FEVjzvo7IS4oqNYGJn1FjuvEca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO6IF4tAFh8P7Z3ZRwnkWWrX/b88YMEayAkllPPvq3n9A5KTQIRUnA4Z+/ciyJcDKyauZsgXlxDp+zKgLhEhqSr98AdZGqdSa0JQTOHqZlrYWSsfoEe8jrsN/QTqwrYhFw/HLuxTJHTzrogk2PMf/1k+pORiMc3miL9AMFLz/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mWhQGVGh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mWhQGVGh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2162c0f6a39so13266055ad.0
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2024 20:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733978108; x=1734582908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3eQ5332V/XImi01nVR9uvfbX+zP8Oy213LJgoxa19qw=;
        b=mWhQGVGhK7ocZzEPwL4+s8hJreL/v2rshnO/2qrMEcm3Bj8EQamxsCSWcTdlW08laC
         YNGH+jXlJtjQpvE6USJmkZ14e1ZA26/CNuxS3PsKJXmCJyhjsg896ENHxTp5p9vOcmL0
         1y79IXKovXvRu++oZb+rAdQic5svkYtmJaPG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733978108; x=1734582908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eQ5332V/XImi01nVR9uvfbX+zP8Oy213LJgoxa19qw=;
        b=n4HZk7iDuyHlwjiPfL15gMYKytAxU70QQ87tmr34ShKrgvLPZLZ8LsgPD9yocP9iDT
         TReh5xDd7y+aAyVf53O+9EqZ4IohwPvF8CuvWgtooAxGISIvn5qLRrpeKgDSn+PWzVkX
         aTjVeJs1HcLKLLVXDIVpSqWQQKQDXlsR49UeNH3qhNy/b8zFntw0R/3+0aAi7JigFfnf
         IhvTvlviF/fyAajQAz3NaSHyqI1+7+/8mfU3+WTp8Lx/SmDTpvgxj4/+wkIQ886CHL7H
         mniY36U/lCii9nQTH8RED4sJVw9WQ1PNvPydEMjCf4/WFA7HbWIYsKJkBo9kg32oLqIr
         0sMg==
X-Forwarded-Encrypted: i=1; AJvYcCWVLzP52LzXoFbRWzKFrCNMMaKwhcWjGy3ql4wbSC5HRi+o0cZ7eH5d8U4mEXMN8yK4w+GzZ6VnfH5bpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TMiPQUvt/WoOZSPJEaXLrjP2X0WePPteU1Dqswde6SLljtMN
	5OixP0/l6YW6BqZGACqPY161Lo1rMVCN82Q/VNwpRDgV9UULopwTyEtnoiImKg==
X-Gm-Gg: ASbGncvdQCNoz3ZwqPWHC3juNkFzLX/UVb3FT9Jpak6JzMWxifAwoLA6tp7+ZpeXCIo
	Di5741xfL9+OU+SvC6XScgYULG1QeHLb846V9Eo4npAYM6GU5BMqPZyDz5D4B7xAv6cp/mU79NI
	BHOHxxl6DNfFz5car5MJTOnWats+gKi2krs4EXX7AChwsnzB9xYnt+cHrbIgMEmIxVAUnRTw6h+
	JQwjWw1g+KGVxyz5504wTOm1Y0KuCNDeYkGKtbexF7/hFwxKQU9kWda5Kvl
X-Google-Smtp-Source: AGHT+IEbTjYmoNjSHfYKhvMhadIRj8HQ01ctqbumJOOZupMel/xzlHR+iDynhJ3nrhudrJBVMZIUlg==
X-Received: by 2002:a17:902:d491:b0:215:44fe:163d with SMTP id d9443c01a7336-2178c873b07mr27094985ad.17.1733978108182;
        Wed, 11 Dec 2024 20:35:08 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164ec76ef8sm59938415ad.228.2024.12.11.20.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 20:35:07 -0800 (PST)
Date: Thu, 12 Dec 2024 13:35:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	caiqingfu <baicaiaichibaicai@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <20241212043502.GI2091455@google.com>
References: <20241212035826.GH2091455@google.com>
 <Z1pjJWkheibiaWuV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1pjJWkheibiaWuV@casper.infradead.org>

On (24/12/12 04:14), Matthew Wilcox wrote:
> > We've got two reports [1] [2] (could be the same person) which
> > suggest that ext4 may change page content while the page is under
> > write().  The particular problem here the case when ext4 is on
> > the zram device.  zram compresses every page written to it, so if
> > the page content can be modified concurrently with zram's compression
> > then we can't really use zram with ext4.
> 
> Do you set BLK_FEAT_STABLE_WRITES on zram?

Yes, zram sets BLK_FEAT_STABLE_WRITES and BLK_FEAT_SYNCHRONOUS.
