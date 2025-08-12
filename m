Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2D2E0410;
	Tue, 12 Aug 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985553; cv=none; b=X5KuAN5w4cMAwekuQd+MxhcwE0A321uU/L6skRB1juNq5VAdTp+5ovhxAEMaxWVVJ/Xss0ZCzb4eTzmjnwW05WFhMaUzvpxFVWvAP41Kf/XsMOAuRx3crOiut0Y0ZKqx9hyM8DuPEwkQ+Zw2sZmFMgoTSQNYf8i/jEFFXuwVXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985553; c=relaxed/simple;
	bh=S1PwdsId4eDIha95kORFrOwN42BU9NJ/foahGhV8L7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx5rP3bTKHOjkGyaVMBaTo8Zr9YZS1LuLXk27LRXM4mfN4uO2ZyKPePczmOzE2DyOXEUpbkpdXY2aQTXaj1KOpme97mfUwJgkY5QxfLMh9YlfTCXHQhJjqzwS/i7gXTHRIAX5mqpPKQ0bvgieR/AlLUTYUsPI+ijvVKlniX3kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=belUHZ5w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="belUHZ5w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vd1f/4Sp7X7PECw8VCBF/HCYX3GWhKDPDeSyyBxNL0o=; b=belUHZ5wnvzwGG+QVZgWBECz07
	H+yQPI+U+xjeTV4rMC6T/tolOAGXgux1DhEgBcB8qF2ZPrCrWxRM+nX4Ink/cdL5uCFnG+u9ogJU5
	n6GwC6PT4UmbFBkf66HmSAQT4tXZUPDZ4jKw+FbBZCG4B1Uf/zlHySxvq3UogpBeRJ/bCKaojpkrt
	ghwOMEGWoPj+iymXYuf+BHktP8CVDfV5UykJJACstqvhec+DAeuSoxrZTPP5EeoKvgr6O+m8s3g4y
	oQvuFUY52hwL5uQ1r/eehnN5SdMPalKRqjegYNxaccEx2rA9QRh20c2wAoIEV6GSVSnNzS6J9jLeN
	en+D4YxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uljuY-0000000AAuT-1FIF;
	Tue, 12 Aug 2025 07:59:10 +0000
Date: Tue, 12 Aug 2025 00:59:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: introduce flush_policy sysfs entry
Message-ID: <aJr0Tk36ZNiCg8mQ@infradead.org>
References: <20250807034838.3829794-1-chao@kernel.org>
 <aJnLXmepVBD4V2QH@infradead.org>
 <c5195d5c-5f71-4057-9522-228b48e4cd90@kernel.org>
 <aJruCTOjcj1nEk-S@infradead.org>
 <dec5b832-53f1-4274-902c-418f01df9458@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec5b832-53f1-4274-902c-418f01df9458@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 12, 2025 at 03:53:54PM +0800, Chao Yu wrote:
> > What did you use before?  At least for older qemu the default was
> > buffered I/O, which can lead to very expensive fua or flush calls.
> 
> Previously, I didn't use any cache= option, as manual described, it
> should equal to cache=wrteback.

Modern qemu actually split the cache option.  You absolute want
cache.direct=on.  If you don't do simulated power fail testing by
killing qemu (or run real workloads for the matter, but who does that
:)) it might make sense to just ignore the flushes with cache.no-flush=on
as well, which is what I do for my test VMs on the laptop.

