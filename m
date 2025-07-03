Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03813C82E
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533751; cv=none; b=K9N8Z7r+aXiVsQlj637GqhcH+JAowO7kPZ9dMG5Es0XVd7PPYU8keg3TKSLZt9zJFcPMWDOAYWiXWWYLTjOBMEs3XLZ4Sy8ViT+2M716V4uypkM7qGvGEWB0rgVbcEr/73O9Gwj18tHIc892yhs9KOLhL/dkhyawWihQmHTP3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533751; c=relaxed/simple;
	bh=L3OqQp+TqpqWebCRXu/q5UG3tlU0zH3uyyd0hyMA1lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi6sKUzwnGkDiC5EWIhzuxZXR1yiSg0Uqv9TNSCtGH29CD/GM+hsEJ7CHDHZqDihLvOJham1fuOxIAc3Lj2fO/77eWtICHyp205yZmHcyyphztDzu1yn74d8I+I+Xk/e5ubOSPuHSPBa9dmJf+w/1g2QgKrTlKyTsfQK3Y1jR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7560E68B05; Thu,  3 Jul 2025 11:09:06 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:09:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue
 attributes
Message-ID: <20250703090906.GG4757@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702182430.3764163-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

I'm still very doubtful on this whole approach, and I think you are
ignoring the root cause, which is dm-multipath keeping a q_usage_count
reference for an unbounded time.  It is only supposed to be held over
I/O, and I/O is expected to time out.

You'll probably get much farther by changing dm-multipath to not hold
a q_usage_count reference for something not actually under I/O.

