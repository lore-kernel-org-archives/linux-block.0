Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667320764B
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427472; cv=none; b=Usk0TeAcwBg1tkbI2GChTcqBMM0mwCKjhPJBW5+kPFiEh1lFokjEUV9YBOq6I0snPSzselAXWGZ0TztwPbgmkw7Dv0nv9/BC++l5rS81Os0U6FYVCpv8BPwTL4/IBlN0O10qZy/Se2PbJ/rBsLKkWu5kQcmUepImyye5erkty7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427472; c=relaxed/simple;
	bh=gvcU+3zx+1+4cYzgvrkVvlK5WM0gScB6nsBZMFaABVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX8tRuGciiB/nam2kLuYr9XwU633jA/HeMYZOXlSwzeMPq3yfh+TfA+Esyg3SacMIqCnwq8U/skY19TAi50u2iUT+SHS69C0Q3ikvRNd1kwNC29G9OTIq6IG1yohBw8ZiI7bTx7sY+lUMVSMgpujpHKa8vNuQj/6WOqhKiPFYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6627767373; Thu, 13 Feb 2025 07:17:45 +0100 (CET)
Date: Thu, 13 Feb 2025 07:17:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Khazhy Kumykov <khazhy@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, ming.lei@redhat.com,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: Question about backporting w/ missing bitenum members
Message-ID: <20250213061744.GB19608@lst.de>
References: <CAE5=w7odv-cL6PJ=ie0bE5UYpfzEdqpB4vEo_FQm0fUTLDgXYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5=w7odv-cL6PJ=ie0bE5UYpfzEdqpB4vEo_FQm0fUTLDgXYQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 12, 2025 at 05:10:42PM -0800, Khazhy Kumykov wrote:
> Heya, I'm backporting 752863bddaca ("block: propagate partition
> scanning errors to the BLKRRPART ioctl") to LTS and noticed it
> conflicts in the blkdev.h header, where in upstream we had already
> introduced another blk_mode_t for bit 5, and this new STRICT_SCAN uses
> bit 6...
> 
> In this scenario, would we prefer keep the bit used consistent (so
> have a gap with an unused bit 5 - what I would typically go with), or
> renumber to avoid the gap?

It doesn't really matter as there is no in-kernel ABI  But just keeping
the upstream value is probably going to create less confusion going
ahead.

