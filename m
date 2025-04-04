Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C971C68F
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757917; cv=none; b=JItZAzSBfkpKr88burQQXy7dkwB444go0Hcws1Kh1oVAAdGzTOtQ831xpPOG/2fSKR0wBdNZfu0zg3MmAb3fe7enl9aUZPh0JG9NdAUK4+3KxN8svbDABcq/h6MxK3bZzJxOz75FaEhpSaQIxZLbOGTzV4jzQQ1fjsrbkabSOcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757917; c=relaxed/simple;
	bh=J5iD6faKud1jnZbcPPyRFQ7NuCZu+ZA2aWLrNkzF8TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXJqY16a2BeD1rgrF6yeDfEHx5N81I/b4XsHP0foukremRaO9uiRmm/p4Nw8v4Ozojk4SUV3D+FcoV/v79PO9sivEHd2EfS+EJXU5yr6e418ui8Zk5mjcVg/oBxqzUgfkjQ3xF0gfwhBINjvAnovTpBAYfdKSZi1GsDcAivOS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF59A68C7B; Fri,  4 Apr 2025 11:11:50 +0200 (CEST)
Date: Fri, 4 Apr 2025 11:11:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
Subject: Re: [PATCH] loop: replace freezing queue with quiesce when
 changing loop specific setting
Message-ID: <20250404091149.GC12163@lst.de>
References: <20250403105414.1334254-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403105414.1334254-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 03, 2025 at 06:54:14PM +0800, Ming Lei wrote:
> freeze queue should be used for changing block layer generic setting, such
> as logical block size, PI, ..., and it is enough to quiesce queue for
> changing loop specific setting.

Why?  A queue should generally be frozen for any setting affecting the
I/O path.  Nothing about generic or internal.

This also misses an explanation of what setting this protects and why
you think this is safe and the sound fix.
