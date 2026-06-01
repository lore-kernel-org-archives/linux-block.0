Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41241465B4
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780274683; cv=none; b=tPkT3nR9ZmnRYFO57wVcmFLb2+7uX4XavBUyR4QoO8HYxb2Q4kkxTeR+r3oGYmUpA3D4TkHDKhuFXJy88Mug2dpMyHT0IRQOHYghxXSpaTySOph0Q7i5vsHuysqYdaf0BQVGy8up5ycqGoPU8IzM1XD4eASl8lIXSQQxnOh7TIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780274683; c=relaxed/simple;
	bh=RWJMxm0mcoidGYohsR1XX4hr67EU9O4T5Q28SfNmPFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quCPa/ivndhN0jpaL0+lPZkddO3KmmCWJWY+J/BQNwA1eIm5pYorlAfj9mOiih9f0kPLLcjB/qHSlKEarCMDujQT0oR4RoKo0m6zMAXB4WsCc74N76eQBbfgpQa+T+D/bedPn3hBjiunn958draymf+FAz5cVVnY+OBP7xvn1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AyH87CHF; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AyH87CHF"
Date: Mon, 1 Jun 2026 08:44:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780274678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vl0+i9lBVVrChfNcXDU3z/ylyAnTJmpZS1smzdIiy48=;
	b=AyH87CHFsWkATRHkmQkgeLR4UJ+4tVYLBNSr1cxz3MHymtYfbr0UGdeQLEuYU7yxAiA3/v
	pAnKJ4aSEVeUhCsQbrBbG7C0dpND4Z81NiS6UeDDDx25j2hg+h9/T3XSS3zMznwEPPiMnM
	w0AxCaVty8nmj913IxznD/pKablp9qI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: Barry Song <baohua@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] zram: fix partial I/O config check
Message-ID: <ahzV6P4n2SICvh4R@MiWiFi-R3L-srv>
References: <20260531-zram-fix-partial-io-config-check-on-akpm-v1-1-eb085d98faea@gmail.com>
 <CAGsJ_4wB5XyUrPpg1O-pkySxo91RsHxaaUkR+Kt+heP4_OeeqA@mail.gmail.com>
 <CAJxJ_jgk8o12OYAi68JznpwKYTUJOUizp2PAZvNz2VdVGJWstw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJxJ_jgk8o12OYAi68JznpwKYTUJOUizp2PAZvNz2VdVGJWstw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 06/01/26 at 08:25am, Jianyue Wu wrote:
> On Mon, Jun 1, 2026 at 5:38 AM Barry Song <baohua@kernel.org> wrote:
> > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > index 6e1330ce4bc1..72f89fd5572e 100644
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -1510,7 +1510,7 @@ static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
> > >  {
> > >         atomic64_inc(&zram->stats.bd_reads);
> > >         if (!parent) {
> > > -               if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
> > > +               if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_ZRAM_PARTIAL_IO)))
> >
> > However, I don't see ZRAM_PARTIAL_IO defined as a Kconfig option.
> 
> You are right. ZRAM_PARTIAL_IO is a local source-level define, not a
> Kconfig symbol.


How about removing ZRAM_PARTIAL_IO and use PAGE_SIZE to check?

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 07111455eecf..ca0c29482283 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -221,7 +221,6 @@ static inline bool is_partial_io(struct bio_vec *bvec)
 {
 	return bvec->bv_len != PAGE_SIZE;
 }
-#define ZRAM_PARTIAL_IO		1
 #else
 static inline bool is_partial_io(struct bio_vec *bvec)
 {
@@ -1507,7 +1506,7 @@ static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
 {
 	atomic64_inc(&zram->stats.bd_reads);
 	if (!parent) {
-		if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
+		if (WARN_ON_ONCE(PAGE_SIZE == 4096))
 			return -EIO;
 		return read_from_bdev_sync(zram, page, index, blk_idx);
 	}

