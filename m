Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260BB17BA3;
	Mon, 23 Jun 2025 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750657619; cv=none; b=uavEW9BEYQ5uOzTwn9Mfsk5fO+2+roA/XDHsEDKoTMlG1Otp0HOn5YIUn1xdwoGr/uj0/6GRsQC5R7dIcVV5TODAzgqrA1tkHjvMZ/DkGbUnTxjalDPkBSEwVRPVCp/J0WZQNRRI/soMwTlnuxxihHxvHyngSwp97tRCO0T6X8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750657619; c=relaxed/simple;
	bh=YF2ysI6Gsu1Fr2aEPVzN+jQxArLEdi6wuWcqecPDEZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBTIm25DRK+ulHa6/ytJ/Vj8imibijCwKimDfPQ7DRsfuIG5fsjKaKMns6zcYXHGdhinWiYrSf44ZOteo2o6exvvR8lIElQhysXfpLnVkHf35y1af53W2P8jjaR53ybcH7u68HKU5NxlysIf1W1adpGQmc0AEyEw9WRUSlps+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0dBm/wmS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0dBm/wmS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=51AXkIek1ybzAoyOQAa6v/j60O6/LY3qNFu2ASRbKp0=; b=0dBm/wmS6T3+fLQZUdiUeq0TmX
	h8X9gXB5RSbs3CG1SEF1hnJI58lbWf4/P0d0cHsPlz/BhcaWBREwz1I7GLr7zvHT8bNhaBnreBEBk
	y0AnJYd1ZtSqifCA2i4S5mesBI2cc81bdDKnbLr6KYc7QCZRiX927a0skBMVBHhiiZer4cfG3fjE0
	4die7Qa5CNsqq4CoMCa4wYAN+zLGtgNKRGHIYvubmcbKbwUKPLb/GFf33iF24LCwJhQrkmDrOSsne
	8pK2nxp1vd+WK8ITuWTBbMBj6nYOB4vNaE5lGDTO19aDlw4d5gXfJscn2kpqYZXVXO84C20uAToM2
	fNFM30Ew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTa1B-00000001f9A-0j6W;
	Mon, 23 Jun 2025 05:46:57 +0000
Date: Sun, 22 Jun 2025 22:46:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 11/27] block: Protect against concurrent isolated cpuset
 change
Message-ID: <aFjqUXIyi9CuY0aM@infradead.org>
References: <20250620152308.27492-1-frederic@kernel.org>
 <20250620152308.27492-12-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620152308.27492-12-frederic@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 20, 2025 at 05:22:52PM +0200, Frederic Weisbecker wrote:
> +		 * running block kworker on isolated CPUs.
> +		 * FIXME: cpuset should propagate further changes to isolated CPUs
> +		 * here.

I have no idea what this comments means.  Can you explain it, or help
fixing it?  Or at least send the entire series to all affected
subsystems as there's no way to review it without the context.

If nothing changes please at leat avoid the overly long line.

