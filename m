Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D01B278
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170511; cv=none; b=rEAFd/m6nwGsQLC37ZYgwB4r/N5TqnTgsIZRDvio+Vkx+3b4kJxl1JsH00pDMsTuOnRpt1ImJimnu+UgXsei436gxEjeY0UNyGVWQDyqMXh58orFWyb2wetRpIV7Us0iplcawmNgY3LTNvNIhx77KO/Qo2VJlqSlv+neqQdELN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170511; c=relaxed/simple;
	bh=HkAPa/4QG3yJRZwFPBPBelviLjeV+wcyoIRAeNov33Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFEGx7/jXgWO3rMdGXW16fCJ4VPRXugzt5OXOIu1ZYbm++v/QeOcdVctLziecIS31KLgp9R2zDjteGj9v/8ETXsAiJjjMCIu7i0w2BalLaQUR0bpgIHnaSJz50kS0rtINWJlfqtz9kklUae0lxMoyv7P/uGhBcj/g7U3oKvg3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C5CB67373; Thu, 25 Jan 2024 09:15:04 +0100 (CET)
Date: Thu, 25 Jan 2024 09:15:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org, p.raghav@samsung.com
Subject: Re: can we drop the bio based path in null_blk
Message-ID: <20240125081502.GC21006@lst.de>
References: <20240123084942.GA29949@lst.de> <znc7pqdsqkznoszbzhvxyyphmpqbesjh56ygn5xt5fjej4glvc@mcccy2dky5eg>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <znc7pqdsqkznoszbzhvxyyphmpqbesjh56ygn5xt5fjej4glvc@mcccy2dky5eg>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 09:31:25PM +0100, Pankaj Raghav (Samsung) wrote:
> The subject says removing the bio mode in null_blk but here you are
> asking an open question about the non-so-relevant ones should move to
> blk-mq. My input is for the latter part, FWIW.

Well, it's two different things.  My prime concern right now is
null_blk, which is very clumsy due to the two different I/O paths,
and actually broken in that the bio mode doesn't respect various
I/O limits that can be configured, and at least in zone modes also
ones that aren't configured but required (I/Os spanning zones).

