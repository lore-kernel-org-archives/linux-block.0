Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F9332EC2
	for <linux-block@vger.kernel.org>; Fri, 17 Oct 2025 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707939; cv=none; b=jZRlBxjySrFqgxoPkLpECJj1avUC2SMqyeCdqyTuWgvZIXJQn7N2FQr6ra1vW264fFQs0DcjUCFB3eC1/3TQRDePrwk2M1PB7bIz49a2Qo/gD7P8VPmcD3RxdcR3Ab8tbDisD+evcMeDWD3uMRAxcUHkQ1ABCZ8W5n0nsGmQDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707939; c=relaxed/simple;
	bh=fEqOZHENW101nyGGVFWjFzdvuWu8N9VFgKe0ZBvX8uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO5i0Q3+WM9U93CXuXqertBdNv5URJhpm5Ezoc8bnT3OodpICMZaWg5jk2oFwWH0nwyjLej4tp5KH/hFl3wMygOxo3cl4nGp7tQF1azMJabMewcYEPihcyEPGNT0txGVi0nyfYZ3AmVJHWxkhZwEi0BRvJmR5BzT9wd54OE00LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q9Vup/W8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q9Vup/W8"
Date: Fri, 17 Oct 2025 09:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760707923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f71h8Ye7tXtrUALo58XOTWsmozwAwRWfYyh/tabgjOs=;
	b=Q9Vup/W8a9cmOFck47SPsREgIvYAYt7cHBTLPtr8ym96HlcL0QzoMMSjlUuMJTGLxA4rUl
	il1wzkp4YmtDah+1LZBlY+k3BNVD8ZwovZadjXQD3bOSxYK6B6HO4TLmZ1g6DjurCCF5ef
	LBbC0vbMDe2RZr0X+hivKOItG1fy9JI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <6strysb6whhovk4rlaujravntyt2umocsjfsaxtl4jnuvjjbsp@sqf6ncn3yrlm>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
 <aPHemg-xpVLkiEt9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPHemg-xpVLkiEt9@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 16, 2025 at 11:13:46PM -0700, Christoph Hellwig wrote:
> Umm,
> 
> besides adding exports without in-tree users, this is a patch that's
> never seen any relevant mailing list, in a pull request that the
> maintainer hasn't seen.  That's now exactly how Linux development works,
> does it?

Christoph, I wrote that code /for bcachefs/; the rest of you decided it
was nice and started using it too.

Then you removed the export talking about the "abuse" of bcachefs using
it. WTF?
