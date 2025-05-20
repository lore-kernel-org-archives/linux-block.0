Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE414A4E0;
	Tue, 20 May 2025 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747745221; cv=none; b=ffcaZuiWrYNZgRI+vw+0Zetnh3FGY/4A8RZhcVICg/ON4ooren04OveTBjm7P3TV3ICe5MLgCqCaLyBtGHys+215LhN2AQi+IllsLQng4kChigjTZBC0Q5mawQP4/2rUYr/0LNXKcoF3CkzFtw5ZiDvACuiAKcHJesVgRuMQf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747745221; c=relaxed/simple;
	bh=ZTVDXCWpd1QEoEKJfvPRMxvirYpRzQgOcYKSupGJ4zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j43AuWZ+G+olXJlI4zpLK2XRlC5pV1MKb7C8EezXUE9tRVfEaM+zw9h9UBhLIHBbuNrRVFe9dINuv0t8tRHj/t4QGWWqXygZZjZozx8Pjh5jSCLLGpxkGe2nDjOhRCg0BzzSfgASrfrrLpPTIMdbsX/LZzWYgbKCFgmR52L4f70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2HeBJmdq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2HeBJmdq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZTVDXCWpd1QEoEKJfvPRMxvirYpRzQgOcYKSupGJ4zw=; b=2HeBJmdq+Q8wq6tgF53cu3I9gn
	UyWXlhaIVFxja+E9NUiyIpYm14biAPbYwvU5FmhWt28cpkRZKve/NF+eUKcLDn7LDoQoPIblMEI3b
	cYy277h886hzpZscnzSBkEiCV0cFHTWPGAyq8ATjWeF8tVCa8qRvbt5idGeD3IzQjNGi8Tq9cbJKk
	UYuY5468dxZjz4rv6xMyoM+kEku+sz1WYZutbD97EPd/i+vIWsTd+EGhUQAUPfoOuLsBlvsrylt6t
	ppubInRIIf0/xCuNEQUkJOTL3+VNVT6gTabweaRYi7Oi/HD0YbIlTtfxZA46xEVG3RB7EyVrsuRQr
	2LzOOynw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHMMx-0000000CutE-1Kj9;
	Tue, 20 May 2025 12:46:55 +0000
Date: Tue, 20 May 2025 05:46:55 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: "Xu, Lizhi" <Lizhi.Xu@windriver.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Christian Hesse <mail@eworm.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"christian@heusel.eu" <christian@heusel.eu>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com" <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
Message-ID: <aCx5v3h9snyI_Q9w@infradead.org>
References: <20250519175640.2fcac001@leda.eworm.net>
 <20250520030051.177205-1-lizhi.xu@windriver.com>
 <20250520073901.6fdfbee4@leda.eworm.net>
 <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <aCwlRMEuvvP31UGG@infradead.org>
 <BL1PR11MB5979EFA72DA54AB231D408CF869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5979EFA72DA54AB231D408CF869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 20, 2025 at 12:27:44PM +0000, Xu, Lizhi wrote:
> isofs does not support read_iter (I used a directory when testing).
> If it is a regular file, generic_ro_fops is used. In this case,
> isofs supports read_iter. When a regular file has a writable attribute,
> the problem will recur because isofs does not support write_iter.

All Linux filesystems do (or at least should) point read on directories
to generic_read_dir which returns -EISDIR as reading from directories
is not supported.
