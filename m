Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6DFF9D9;
	Mon, 28 Apr 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844563; cv=none; b=L+xClNQXP2VR+OcHchFl+NzTjApOU2yCAcvnVJpjPS4A97Lyw+84rGJXZCCfBD4oBKKSv6QI7sBfSLDzQ9NUum7+d7SqbVclCATGzNR06RwsgYjJUfCFoTW84dn2peXtES5qrnr6+jfPQT348k3m832MJXvT59CrJfyJxiWMHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844563; c=relaxed/simple;
	bh=OfdCzcsUB2ilgdOgD4rk0hL11+NKio/98qEEv4OfyYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2veMT54zFLQuKS2aSPsHm0+4poY/MTngn4T1hctbNIBYL5e2CkSKCNts/hXJgGp7RiD+kIL1zZ2ew2vlMMLno31H7Yq9V6lmCt4TY53el8ldoY5NbKDWdo4iy3nbN/KSYhC/ljbbdvd1LvOFkDXCKZ+wt7btj/UcOF67WCIlcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEidS2zS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEidS2zS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vq8nMSLzsV8XHUktKchk0Wgy+yl0XLAhgtJbvSVMH5Y=; b=oEidS2zSQXqimIyAzV7HQy62fZ
	kw8RbKOSBvU4r9Q9Vj1FfkQjGm1QQqyJtEOZI9FnN61hk0tT5hp9GsTgR9LkjytGi+Rsr/rmX9BqH
	pSMBA56LfWZlC3/Au2IJmn0IKFfNUYgEZIS840gKj5tyKkZuWRYcFWhudB3PJBicBdcse1QrGV4q/
	85OheFcF/REI/qtnuOz6TmuNILmS2T2IAbFkQfJImBIdbR5dJntP0yFJgeA8imM/eoxFqGLT+E7xz
	MykBz/niM9cTyKU7TdhqhFG5d7H20kNZ/5U5tqOUUIv5PpXfrfyNxTLiyj2wsiPGw7XuyLh6ioCdM
	kBdbGcXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9NvE-00000006GMN-2CfP;
	Mon, 28 Apr 2025 12:49:20 +0000
Date: Mon, 28 Apr 2025 05:49:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com,
	syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] loop: Add sanity check for read/write_iter
Message-ID: <aA95UNX_BHq7GtP9@infradead.org>
References: <aAuOC8djgRrq-Gdj@infradead.org>
 <20250426021055.312912-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426021055.312912-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 26, 2025 at 10:10:55AM +0800, Lizhi Xu wrote:
> +static int loop_check_backing_file(struct file *file, blk_mode_t mode, bool change)
> +{
> +	if (!file->f_op->read_iter)
> +		return -EINVAL;
> +
> +	if (((file->f_mode & FMODE_WRITE) ||
> +	     (!change && (mode & BLK_OPEN_WRITE))) &&
> +	    (!file->f_op->write_iter))
> +		return -EINVAL;

This looks a bit odd.  Both callers have the open struct file, so
we should be able to check f_mode for both cases and not need the
change flag as far as I can tell.  Or did I miss something/

If for some reason we could not pass the fmode, the helper is
probably not all that useful.

