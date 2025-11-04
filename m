Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41602D63F6;
	Tue,  4 Nov 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254441; cv=none; b=AA2qhl3OR1UrDdI/o1uwMiKc0ZGfb24FWvlJ8N0jz4lVofablqALcaHARY19LNOvExDq5SuV6aLn5i+Ojek+v4Y5mlP3LQ11LhbY/d1bkGt3pnFWLYuUfBQbVef6Ich4QcvFYibElgWY2cH6UGfe0nIo3is2AsdL9oOP7M5jt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254441; c=relaxed/simple;
	bh=bbCYkOb0m1hmfcH1PpSVq63nlGj8S9v00vPnusG7aMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv+78YBqDuo9QZPK4657DO93MV/pjbj12TcBQpVAnNMF/Fgi8Kpx+sTfZTPIT+vtAPIzQOOA7/keanSIGb+Hj1EZUNmekXWe8WWVE57/NoM1RsKuaYA8XTkIlruSBD46PqUxBP3xIZOfhBl7+lK0TrNEUNUH+En7im3y/FKx9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uNZ89OYq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uNZ89OYq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dEJN4ocBpprdAIAww2E/EDsJDYT9P0uXWKdSQct0wOc=; b=uNZ89OYqr+tKEqJJotav95ICdr
	3WvMCuqQKl7SZDNx5W6uEAn2A6MLD8ihcBcqEV++jGZmUOUEeTcnPLu/Om3ifPA+Iua66izl5iTOe
	lcKp27uKg/56wphIGqOx+HTiYe3JyoknZH1knD9Q3ZjSG0jPKBu1lQUH0ioLFe8tq999HD4QlWp2r
	5kgQ+OqMi2YfDbQNf3ply/yx+xXpQbZ4OOd5b1Bvc7DuoVCaIh0tZFELllv6UOjXVzPCfKogmFwxv
	G8dT+yB6HC1wIFU4tiU2hGvflzJqmHTWkJmloQiKsgnucwvD/qeFI5gSqNTvmC0pVdw61VMIXrCPD
	GvX1lK7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEsg-0000000Bghw-2nOu;
	Tue, 04 Nov 2025 11:07:18 +0000
Date: Tue, 4 Nov 2025 03:07:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: shechenglong <shechenglong@xfusion.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com,
	chenjialong@xfusion.com
Subject: Re: [PATCH] block: fix typos in comments and strings in blk-core.c
Message-ID: <aQneZipPwoRsoeeA@infradead.org>
References: <20251104062113.1929-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104062113.1929-1-shechenglong@xfusion.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 02:21:13PM +0800, shechenglong wrote:
>  	 * usage with stacked devices could be a problem.  Use current->bio_list
> -	 * to collect a list of requests submited by a ->submit_bio method while
> +	 * to collect a list of requests submitted by a ->submit_bio method while

This now adds an overly long line.

