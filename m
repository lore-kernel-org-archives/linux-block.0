Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574A2C327C
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533657; cv=none; b=CrVIFo1kk/sGiBelkOv7sR6JvreaqsVpNSNOL4FDuS8xd8VS0CfVXXg0nnwiBR+TvevGARxzu3B/rFtXIwjVi7nBNm0adpzv++Dp6K2DEUXPCedGB8VTtOU0GCgc9x0K2b48vYWsbp8vyxJzHUBmkimRiPpPMOhv6954q5Aw9aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533657; c=relaxed/simple;
	bh=U3EQwThgYA9v2eHarmdstc3+HludTk2+jYR8f/NXDn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc+Qdj8dg7bg7IrMLrrnzJOn9a9UGZ+Zk1RcbQAxJ/Qn4GT7xevYq5xLTrfAelQbDoEZmIxaLwl3frkYdv1sMeXarWzDj98/0mYr64Kkb5uwNjD/5cd5A+fhsPkfrc1xorGSxLHK5ojxI++zxC7O6t3CZ+dKuy5mMLoL+QRB8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8643C68B05; Thu,  3 Jul 2025 11:07:32 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:07:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/3] block: Restrict the duration of sysfs attribute
 changes
Message-ID: <20250703090732.GF4757@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org> <20250702182430.3764163-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702182430.3764163-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

You are not limiting the duration of attribute change, your are
letting the freeze time out.

