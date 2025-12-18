Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9A35294C
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075848; cv=none; b=BtLypkz9lW29mFUqzlcbVhvUdMw+est8WLh2XqGNYueeZNo9weYSEhy6wGtQ6m2XSMqxx2zDBzPNOaMcjHvKT2qBSV7c2D9hNMfyTgT83PGbOZB7vmzKkF60WXxGttit36LNJNQ0uDmGDcnmb/Tes+6mu3qZyhzYNqHmMeS75v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075848; c=relaxed/simple;
	bh=E7v8Jd8q4ZT+w8P4DgFjN83tk23oPHQ/i6x63PK3GgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK4bjWHR38ZpfLwA3iZC0MmpWC/fsDApxERDquH2rynryVO93fAMSfVeBiJve4+XwRW9nZQWO9vCY18vUfCSW3CR3MBhGepWIjacoUFL19p504MHJYdl49K3m2NIsN6hefKEixiAW3lGRBkwlynD8gqSNng0yrYULE7j19YgLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NyWhpTAY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NyWhpTAY"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so1434490a12.2
        for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766075845; x=1766680645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yqc+N7ACejUphaJlZEZfPqDo0ScYeTZ8ibI5l4T2etw=;
        b=NyWhpTAYORI7nTn3UaI61aWmI7gaMU8pzpNhOmBGgHGCMRzdabbfg+sHGHSRcxKyUK
         dRsH1kDdo3Ppvr9mRCXY/qeL+74uixxMlLfAhvD6ZaEs2xlgo/0SluAqPKCnfrAnRGoR
         RVziHFs8IL5cX/68gmf7e6LmxIlRSQf2C/7RVCSVFFVQaZvJeyA5nUXckJIgWR5eullI
         1xQdjwOssc/If7hWwcxNyUn3MD/KibXwMp81kC+SDxBeGRuyu0ICB7IuV7BG9E/oN0Go
         pyj6vCA/FaOZ6SskIDOR5EWSxJGTfUCtLGSR3sIW7bfGD8dd6GmdrvlfWG5A9Dj7+vmZ
         rtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766075845; x=1766680645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yqc+N7ACejUphaJlZEZfPqDo0ScYeTZ8ibI5l4T2etw=;
        b=aziQc4pfX9bamsquPA6nWWl3WHY+e+wCROynadBUmwHHn2ASkRyXfsHqelyaGa7UH+
         VsMBNNpVhu8AaxnfmfODYQ+jumzTCs3RfttoHc/epg1WSeb5qcPqQeV4K4ISJIutqxk3
         xbUUUAYGM8oOVaHCj+brw1MH8L+aOrHfG9XG4avO/ybKpPv3dTwStQEpGzuQm5hrxY8u
         YvyBIBIhT0kucleFQJZr5tMdLndeqgd5cryhqVYJjdSR+v5HfMYNXOf4X95bVnDaSr9z
         /C0d1FwjAmPkLFCuX2GG+S4m9C/aO2cKmXPfijk1bk446xp9l7gsotCoQ/Xy4ehm2o+R
         uV6w==
X-Forwarded-Encrypted: i=1; AJvYcCVzrYIU5VJQmGVUv0b8I1AMqm5pkEu2LIVkCyH62Z1fkepHgXuS4xV9CLHio136NI8Zi8sTlHpTQvSH2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDoYbWpprtIWHUTlrER0KpkB517h3PUWkxS9NV5ORij5iKFq1
	CQWyIR8Y+fbelAB3H6/uxYd0a1exTq/LgEzfMjTzPfJ/dRZaiNiaYZ9XMoqz44liiYs=
X-Gm-Gg: AY/fxX5p90fIf1CHn0bSMjgRhxvmfS5Ut+eZbmt3t2/v9x4uWpuqEpgh/tOB2RoFcsd
	ykeWYRa8pwfXX9IeVUxDqj8bRbZuJMgxSQRlPBly3i3Ql2vlt2pT5zc7rpHVB4LR+dC7+xgWHTa
	flQLtx4Vb0bVxMXGlKpfkSvtha8ezhyrEHtSMs4N1LDMds/Z2lbTyzSxyV9TQtfoh7o8e/03xRA
	I9MxF0NlpwvPRNirN+S3spu0HGHelSARy1yVzgXxjMGp4X+QreHCFv8UqYRtVBAYSIcZNwC7kZ5
	FV9jrg7F3Nnz+W/OXA0+YGEE3XknxDh7maIG4U6zx9BWQUIc24XuwKPqyFUPfo42PPBZ1pKNnPd
	N0Fm7OAtzd/8g2Y8VZ3mhUf9EzDcMsSmaykhye0ZKgm+vLVgU5pn/yqzip5nVv8yPPYu851iAqZ
	ddplXFgKheG3FKRubtzg==
X-Google-Smtp-Source: AGHT+IE8sbMBdxmYf1QUCA7nYTzxwvOawDzPmQWwc6q/kQhBr7eVDkvBVM6zGwZBGDYi05K2pKxZHQ==
X-Received: by 2002:a05:6402:34d2:b0:649:c56f:5847 with SMTP id 4fb4d7f45d1cf-64b8eb5fd19mr28872a12.10.1766075845006;
        Thu, 18 Dec 2025 08:37:25 -0800 (PST)
Received: from purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b588b0b3asm3010982a12.35.2025.12.18.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:37:24 -0800 (PST)
Date: Thu, 18 Dec 2025 09:37:21 -0700
From: Michael Liang <mliang@purestorage.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: always clear rq->bio in blk_complete_request()
Message-ID: <20251218163721.qfn2e54stbp2r7s4@purestorage.com>
References: <20251217171853.2648851-1-mliang@purestorage.com>
 <aUPAgtbWVql9SkoG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUPAgtbWVql9SkoG@infradead.org>

On Thu, Dec 18, 2025 at 12:51:14AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 17, 2025 at 10:18:53AM -0700, Michael Liang wrote:
> > Commit ab3e1d3bbab9 ("block: allow end_io based requests in the
> > completion batch handling") changed blk_complete_request() so that
> > rq->bio and rq->__data_len are only cleared when ->end_io is NULL.
> > 
> > This conditional clearing is incorrect. The block layer guarantees that
> > all bios attached to the request are fully completed and released before
> > blk_complete_request() is called. Leaving rq->bio pointing to already
> > completed bios results in stale pointers that may be reused immediately
> > by a bioset allocator.
> 
> Passthrough commands keep an extra reference on the bio and need the
> pointer to call blk_rq_unmap_user from the completion handler.
> 
Are you referring to nvme_uring_cmd_io() and nvme_submit_user_cmd()?
From what I see req->bio is cached in both cases and from the comment in
nvmme_uring_cmd_io() it actually expects req->bio is NULL after I/O
completion. Anyway my point is to me blk_complete_request() is functionally
similar to blk_update_request(), and in blk_update_request() req->bio is
updated and if all I/Os are completed it's cleared to NULL. So I think
it makes sense to keep the logic consistent here. But anyway let me know
if I miss something here.

Thanks,
Michael
