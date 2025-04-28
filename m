Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177626D4CA;
	Mon, 28 Apr 2025 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848142; cv=none; b=KtiR4uirKDYx9vxtQvu9mmfpqIGEqLD3Rjrxze75p/kwp61+6vZnHubBLqL62PsfFSfk0XcNoDPK5CWas++B7ON9tyTfzNWIpRFSItKK0e2ScCoemDgUNYUkgDUrdfu7tmhec4xk7aKw8nukyhrKf6PTz0XwIwxxsCxEPKcl9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848142; c=relaxed/simple;
	bh=Khe/Y7na+S2+8ZLqPv3RSW6SrBL7l+Fz0deKc0jwBoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF3/cHkYSUR2DtzI0KKxT7nYUjCdN6/1OcUP7MTPx8SIPA1KiGrivBOju00qYzMw4dMjfyqBk9N5ekYuvVcA5X1rwAtNNFUCP5hBMyhKMSl7D/4Th/Mt3OxD1jM3BN8+lDNRrgwdWt7xiyGPy+6Osug6dwtv58gHtGhTTCF0/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qPZv55Ab; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qPZv55Ab"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hYyDWO4UiVdBFgSSIMh4S+1GtwQdko2AoZG0evm59qQ=; b=qPZv55Ab+i7pbYcSBXVuvJioJG
	MdhJZTTpK63PaAJ786mDAY0M34PPIQb0YxmA/8cr553o2dBixG+sxs5ZOaDK0mW/bZkcQdhh7oqcD
	L+XCQoivwv9NoP0GklLoF88IQEeaTD2+9vp8yBiifSuUugyQ0a+mkpRaXd6qpha2NE2J1BggFtoDd
	T7Lh8532rEOHYmlH60Dior/RJbDXw37NOLMtKZZJ1kftncg+s0R4sx28Nut2YYO2bBZFtvFazS/+4
	WYiPGw1K738FWZWqrQ1d3OF05a5tToUglx0eAGOx1DvR2eFbHh7XotGgvNOCfotqOmIYjQlN6r4Fs
	f1UIGtvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Oqx-00000006XPJ-2Oae;
	Mon, 28 Apr 2025 13:48:59 +0000
Date: Mon, 28 Apr 2025 06:48:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com,
	syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] loop: Add sanity check for read/write_iter
Message-ID: <aA-HSxKfbM6WCgek@infradead.org>
References: <aA95UNX_BHq7GtP9@infradead.org>
 <20250428134231.3215496-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428134231.3215496-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 28, 2025 at 09:42:31PM +0800, Lizhi Xu wrote:
> On Mon, 28 Apr 2025 05:49:20 -0700, Christoph Hellwig wrote:
> > > +static int loop_check_backing_file(struct file *file, blk_mode_t mode, bool change)
> > > +{
> > > +	if (!file->f_op->read_iter)
> > > +		return -EINVAL;
> > > +
> > > +	if (((file->f_mode & FMODE_WRITE) ||
> > > +	     (!change && (mode & BLK_OPEN_WRITE))) &&
> > > +	    (!file->f_op->write_iter))
> > > +		return -EINVAL;
> > 
> > This looks a bit odd.  Both callers have the open struct file, so
> > we should be able to check f_mode for both cases and not need the
> > change flag as far as I can tell.  Or did I miss something/
> Changing flags? What are you talking about?

About the 'bool change' function argument used as a flag.

> The helper function does not pass fmode, but passes 'blk_mode_t mode',
> because it is used when executing LOOP_SET_FD or LOOP_CONFIGURE, but not
> when executing LOOP_CHANGE_FD.
> I think the purpose of this helper function is just to facilitate code
> management and facilitate similar problems later.

But you can just check file->f_mode unconditionally instead of passing
the blk_mode_t.  The BLK_OPEN_WRITE check is only needed for force
the read-only flag separately, and can be kept in the caller before
the call to the helper.
