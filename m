Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAC31F9BA
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891224; cv=none; b=orS4cSqoQ098nnB5mrc9Hp4lB5CjJUUiwm/zwavPVjJqNoCW4+qxsyZR65VZOUqfhE1wkFkPLLCg08eeFQp9WpIBrhvg9IHVal0rNGUl8KYJUn4aB9z4KljVQ5Ym7a4mGIaEXg0lht5YPGCcbtsW6/knwviEvjcXqzGOsGggISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891224; c=relaxed/simple;
	bh=sWweHHUUo7udvvA/+md6SXyLsOiMVqfLbTA7oLbC5uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=SPx0jXF7fUX7xJ4tBJmqe42J+4unIbLgPM+nxe2jbD0/uJXhvE45tF14ttGSn6JFzn0GEMzLdF2Z9bfbpd104px3GDNLogAFphKzSwfJ0DZs+amwnnKc2IlfL7XfkZGE3LC6qiXIhg2HXreLn9bh2kS3ByAP6HQPQ5GpDW9lyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHczuV2j; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHczuV2j"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bd80b3aa13so78933305ad.0
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779891223; x=1780496023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fXQaASvIzd3Xl5ViHRaAzTexLFKYxxm1JbU0Z645Tk=;
        b=OHczuV2jN81Uhy5AfjJxIns00GiTc9nVSUDwjJk55GjkCtmlswxyt5Rbd6bqzcjmJG
         mbhPFYe/VrMD+JfJXWEujmDlxoyRfeJVHQm5xuL2zNgyEzHfgL5E7BqoKOy7VDZ5ikaJ
         HUb1obnVAzHsA+/5z2iAXyDQxbleoLk4jzSUlxWcrgps20j3K03gq1Wo2DZ1VUe22Ldg
         L3lJiiMk/yQ25m1/Og26WHH04bJEA6ZvK7+8zH8ANZmvTHos/76YlaBaXRzrYImvQ0Gh
         DFmtk3du8LQW+0OJSpIjeBW7Y5BV7NXmxhI94PvhEziiVBa0bZefWzK23ZFANkVNF/8J
         9IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779891223; x=1780496023;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fXQaASvIzd3Xl5ViHRaAzTexLFKYxxm1JbU0Z645Tk=;
        b=hdQWKHQ1HfynAcrGgRA1OLoi2n9x5rhekjwU0DXGB9sDfpPvuCymPjiXsozaiWhwoM
         lmG5lmLDn6wSg1AKNGqYagPo5sFAsbUQYNXP7Qx1iQg+oWZq0bOvA+YU0k2OUkgl2XtX
         QRhC9DJhVsQ/vPM8u1UA5Y6Hc4c0nlwJ3XFx72A6SOkAYTemeqRs3u0uT4lxbPKd4Jzv
         NMADP2zZPH3YII8Pea4fZJxe72lsnc+BFKmAG2n9t2FYbaYPlLvcvTSnp10kn/MmzWFx
         +nzC4vDX61GO1ueWHUTASl6mzzhTt5iDADhVPzoB7kS3RcfATrAsgtCYi3Ta9RbHcPFJ
         8Nnw==
X-Forwarded-Encrypted: i=1; AFNElJ+FIqBIv6wEeO9n5iMatS7Wb5BXNKGTWO6XnhjM4mmMHsnUufLh410aAL7s7ELtE+pBgm9GSG0H4tn9FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKbd5Seoeg2sY6kRrarg+peMc5ukp7x8OI0TLdYi1aYLup9/q
	ajoUPzoMpWcXt7NiYXWIgi2/N+GE1MiahPUKeVnVxQn/57AtVnCwGQm0
X-Gm-Gg: Acq92OGBPHHzjHG+mfbEjuajDotU1pWpQ+mmgVOlKGYH+Um8FfIj+pNdaInasQpiQF7
	GiQFWUmF4ZMdpXomaFmo9p89W+rUwND1xpCijEo/ff8X4rdBelmbNSHSYZ6UYyjKQxvX51iNvkK
	2MSTjYpi0L2kVI6PNMG3UsMhaCP93n816r4ZJA5rABI9UCTJMSM1FV9yWed9YpJJkgoa8wAsr4X
	oy23d8bRsxMrdA/ifaivxyeZLn96+P85eTqfm2fWZ47ZqM9/2JRvoIjNt3gheUkCD0P0YHdDQtG
	l+SoU++idkpl/zjIIYe3s7TK8okBaZqZenQUWOo7JPrGdMLI7Jrf+4XDbqJhGRNrVxW9XbrDJsG
	mYV9CyejQG9MVZhguxbVfBtc2FjmqqkOpzuStz4p3avS/zecCYGhOUA+/Sr8YuKAF3Acqjpty02
	NDO3U/kaUiG3Nhsu4JkjbJYURbkHTKSYLatFErW7ZXon3MPGA=
X-Received: by 2002:a17:903:198c:b0:2bd:2de3:519a with SMTP id d9443c01a7336-2beb06ea5e1mr257189885ad.7.1779891222695;
        Wed, 27 May 2026 07:13:42 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c31a3sm155458115ad.55.2026.05.27.07.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:13:42 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] zram: fix use-after-free in zram_bvec_write_partial()
Date: Wed, 27 May 2026 22:13:36 +0800
Message-Id: <ahb8ELI3FxoMalaX@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260527072414.GA17856@lst.de>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com> <20260527-zram-v2-1-2fb84b054b5c@gmail.com> <20260527072414.GA17856@lst.de>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Christoph Hellwig <hch@lst.de>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 27, 2026 at 09:24:14AM +0200, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 12:49:24PM +0800, Cunlong Li wrote:
> > zram_read_page() picks the sync or async backing device read path
> > based on whether the parent bio is NULL.  zram_bvec_write_partial()
> > passes its parent bio down, so for ZRAM_WB slots the read is
> > dispatched asynchronously and zram_read_page() returns 0 while the
> > bio is still in flight.  The caller then runs memcpy_from_bvec(),
> > zram_write_page() and __free_page() on the buffer, leaving the
> > async read to write into a freed page.
> > 
> > zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
> > ("zram: fix synchronous reads") for the same reason; the
> > write_partial counterpart was missed.
> > 
> > Fixes: 4e3c87b9421d ("zram: fix synchronous reads")
> 
> That's just the last patch touching the line.  This bio chaining goes
> further back.  AFAICS all the way to introducing backing device support
> in: 8e654f8fbff5 ("zram: read page from backing device")

You're right, thanks for catching this -- will fix in v3 with:

Fixes: 8e654f8fbff5 ("zram: read page from backing device")

> 
> The patch itself looks good, though:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
