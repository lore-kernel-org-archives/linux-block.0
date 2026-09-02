Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E0476CD4;
	Wed,  2 Sep 2026 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348470; cv=none; b=GpeNkwEdAk1BTxlNBxH5uxaji+sQLt7BQvbptlo15d6HlvJ++AAZAo21Q5ZEcOtsiHSvawtmDmDJfY0v/2XlzVQWo/naXflUep3daPV0OGjAB1rG8VZprtSRR7RrFsScMf4odTFKi1O0AImcxsF6pJLJGyFMINmNJTYDCBYbIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348470; c=relaxed/simple;
	bh=ifwkK6d/nXU95teqUaSVecGp9lkR6XJkhLT98uUhlHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCtZIuqXZEztP0HAmgwiqM8932o7RkTCKTlfyQ8cA5+EjqpCAc4j0bl486mWilOvyNU4xPjpZkQXtRQKC3TQ+kah8nR100sxlmxVzsnBZIFr+x79AfS0dZ5Gj8mZbAYQ6ypsdAJiSjuZBCEal7BauR+Q8Ri6m/2eRX/Ka5YodBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A2076732A; Wed,  2 Sep 2026 13:27:44 +0200 (CEST)
Date: Wed, 2 Sep 2026 13:27:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <20260902112743.GA11999@lst.de>
References: <1819786.1787768317@warthog.procyon.org.uk> <1895550.1787777192@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1895550.1787777192@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

Should this grow a comment explaining why for non-iov/kvec/ubuf
we check the alignment of every sector instead of just the
start alignment?
