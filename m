Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA330C371;
	Tue,  3 Mar 2026 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567956; cv=none; b=K9dG8fBPYGig34n69IZghNyjSxdVGoID0X0C9s2UEyTxm68kMCqphvDb+Zw6nZReFzLpe8Uq3BW+PY3Cieyll8ThdA+LFFzcrrePDTaOanuh0yVmdvgCwAgAwVhKLFfobOcreUt0zAsatmLHfiXGWuKOl7BpJA/LPqahI9Lguqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567956; c=relaxed/simple;
	bh=Offn+cWfyVQnO7cnCitxgwD22KLBZz4vb3W9bWlZREk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AatiJYeJAxNlbxpTz4qDmkqMviLT3Qwx1dOlFuaSAnQQRKALym+qf8J4uGBWtIzZKSZxbg62uVyq7/ndfoXJzzRsUwcgrCVJTKFR4MHhshoNmQKkhcFEycqDaIckDj57YKlf1W3vDDLkO9tbfIJ3PE5jz0kpZe4Ftgc3oFWDJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HXilqqmT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HXilqqmT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I69sJWzEc4DoGD6hymaavNFuGuaf0osaNh6hSc/6Ia4=; b=HXilqqmTWOmTVAC9Te4+7irIwA
	DjIzn2lvo0kF9iQXTpvJclrIMNL4TX2Gc/PH7Hc/6ou/NXwTrbQAkhKqg5D7smzIRzhCsIimfrR+F
	GHceqPMGqcNH67m3ARMerBP2yo/9s0d6/NM9n5UVlWKnwSn1SzGId7d3wFwRNARKbaM+0yMawu6Q/
	a2yZmrCYI5NHfJLYgKL0xwrMN3Gfk8dnKxD4f0R3YfKljVn+Ui91svsxK3gPTXkO6YmcDVFOF7XiS
	/D4LKc9hRAtLXXXlD10Yqj4+ny061VyP6kp9c79PesHHIG5d6nyDz03U9cDxQ+I24ICXELzdZSQEW
	icUbp7RQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxVte-0000000C6RU-14Gg;
	Tue, 03 Mar 2026 19:59:10 +0000
Date: Tue, 3 Mar 2026 19:59:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, kees@kernel.org,
	gustavoars@kernel.org, linux-hardening@vger.kernel.org,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] iov: Bypass usercopy hardening for kernel iterators
Message-ID: <aac9jn0oSDw040Hj@casper.infradead.org>
References: <20260303162932.22910-1-cel@kernel.org>
 <aachxPdUi2puxQKq@casper.infradead.org>
 <8c2c2a3f-c718-4275-a2ba-b796438e9a13@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2c2a3f-c718-4275-a2ba-b796438e9a13@app.fastmail.com>

On Tue, Mar 03, 2026 at 02:41:33PM -0500, Chuck Lever wrote:
> On Tue, Mar 3, 2026, at 1:00 PM, Matthew Wilcox wrote:
> > On Tue, Mar 03, 2026 at 11:29:32AM -0500, Chuck Lever wrote:
> >> Profiling NFSD under an iozone workload showed that hardened
> >> usercopy checks consume roughly 1.3% of CPU in the TCP receive
> >> path. The runtime check in check_object_size() validates that
> >> copy buffers reside in expected slab regions, which is
> >> meaningful when data crosses the user/kernel boundary but adds
> >> no value when both source and destination are kernel addresses.
> >
> > I'm not sure I'd go as far as "no value".  I could see an attack which
> > managed to trick the kernel into copying past the end of a slab object
> > and sending the contents of that buffer across the network to an attacker.
> >
> > Or I guess in this case you're talking about copying _to_ a slab object.
> > Then we could see a network attacker somewhow confusing the kernel into
> > copying past the end of the object they allocated, overwriting slab
> > metadata and/or the contents of the next object in the slab.
> >
> > Limited value, sure.  And the performance change you're showing here
> > certainly isn't nothing!
> 
> To be clear, I'm absolutely interested in not degrading our security
> posture. But NFSD (and other storage ULPs, for example) do a lot of
> internal data copying that could be more efficient.
> 
> I would place the "trick the kernel into copying past the end of
> a slab object" attack in the category of "you should sanitize your
> input better"... Perhaps the existing copy_to_iter protection is
> a general salve that could be replaced by something more narrow
> and less costly. </hand wave>

As I understand it, and I'm sure Kees will correct me if I'm wrong,
the hardened usercopy stuff is always "you should have sanitised your
input before you got here"; it's never "yolo, just copy the amount the
user asked for and if it's too much, the hardening will catch it".

I'm definitely open to the original patch, as well as other alternatives
that narrow down the cases where we can prove that we're not doing
anything wrong.  I just want to be sure that we all understand what
tradeoffs we're making and why.
