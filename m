Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18BB212FB3
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010283; cv=none; b=h0CvudJtKY6+RVMzH5rvY8FpB5q2pVO7GqzngVfcit48KmKMRV1rzhQLZUeGg4Y56G02OqXb1koHjQs/bu5XLVQa38e8dOOP+8y7C3PTKm09jyHzF2xBWaYlR+zcqYEgft7HNJhLQpyY4SVBrCnV+/sBQKuCvrZqVAJbL3TOlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010283; c=relaxed/simple;
	bh=KylWFueUKRWsuQheToh4wOI+jIQ+07hRH1BJMlvmqEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ8vVwK4rV9Vg/9p0Luv6I7iOBj+aZUysQ5qHyElX60hr7qmmb1CyDhvWqOERmOmG+oywAKwmrbXw3G9a2XuDHollk2X4KJRZV0xzeL5k+tnPzbWcWqkJLG7PoU3LgJTY25TyOCvfjojbHUTZ8n+bBN/+DyIrbPzRP1MH4CQSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ntMqTwkJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ntMqTwkJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gAOr3k+sN+jnpZ0rMd39VL4NJq+5X6WzFjJEE+fgXGk=; b=ntMqTwkJ555qY9BGMnmma3JdzR
	rcYLt3dpb/u3sRiLqMaZMxaiujQsjyLL/YQQeJs7U3bdkZUviwuhe/3EN0jY2QoApICo5c+Nbc5px
	XKKO80Efp+LBDzzk2pfTrrMA0brBQhDznGxQDhF40AdS/oDbUG5v1Y7q3P/ZMgV7tTrJeonh9gcXO
	jPsaXzoDPaYnc3hbjElcrUtVXxn0UiH/UK/NEEoF/PsayuQn5AVyt6g7KSbUwFLibDs3zA5c/NBDg
	lqk2S3SqryO8VvGnZK1dqfL+CdQ8WAzbeIsyS9zoRZ75sHxZKixN4prEkpypXWWdhaJ9ozBC1OmB3
	Gb5/VbJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6Ix-0000000BijE-2SH3;
	Mon, 03 Mar 2025 13:57:59 +0000
Date: Mon, 3 Mar 2025 13:57:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8W1Z7m_fWse8KWz@casper.infradead.org>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <913d3824-04c7-4cb1-a87b-01f9241a37aa@suse.com>

On Mon, Mar 03, 2025 at 12:06:18PM +0100, Hannes Reinecke wrote:
> On 3/3/25 08:48, Hannes Reinecke wrote:
> > On 2/28/25 11:47, Hannes Reinecke wrote:
> > > Hi Sagi,
> > > 
> > > enabling TLS on latest linus tree reliably crashes my system:
> > > 
> > > [  487.018058] ------------[ cut here ]------------
> > > [  487.024046] WARNING: CPU: 9 PID: 6159 at mm/slub.c:4719
> > > free_large_kmalloc+0x15/0xa0
> [ .. ]
> > > 
> > > Haven't found a culprit for that one for now, started bisecting.
> > > Just wanted to report that as a heads-up, maybe you have some idea.
> > > 
> > 
> > bisect is pointing to
> > 9aec2fb0fd5e ("slab: allocate frozen pages")
> > and, indeed, reverting this patch on top of linus current resolves
> > the issue.
> > 
> > Sorry Matthew.
> > 
> It's getting even worse; after reverting above patch I'm getting a crash
> here:

If you revert that, you also need to revert 8c6e2d122b71.

But let me dig into the original problem.  The fact that it's
kmalloc_large might be a clue.
