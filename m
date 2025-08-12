Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8C1F09B3;
	Tue, 12 Aug 2025 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754972746; cv=none; b=P/CWYEFRjzsQfIVcgCM3jwmLwsFRaC77ECrgTnzbBwBtSLnjQxq6+wlzm86aqvDxT9R9yaWmRnlZl1Okga1zy1GKLVtDBlvkHOcLhTLsk40yoG65L53v/UwhNfVNVKIOAdTyRy0Gujsrh7nXi7xZMRvynPTV0eU9Lg8j2+r5ePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754972746; c=relaxed/simple;
	bh=jn7VKIKwmh9yijF39BDSI8MmB0R0ozzp+ugiE5JuQGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RistoQ3R+oc3tI2O6lYayNVQxK493kBhIlClJEd0dyTtDdNAnyE28SGf/apgL9TrDQARyQLazowSxIZFXAMQs9MwZ40j8hYdRINnwaM1O4TkcapypU8Q3xtk9w3dbiz/AwLYl9749aSfIVPyEdthezN/wEp9kzWq1lIkQG0ezxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ECmQhPk5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ECmQhPk5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DYOAsvUTPlTJfsNrGGcHNre0gNCRuUiS7M0G90F4Jr8=; b=ECmQhPk5CTjtn3t2u9hlC/b++y
	+RRT1u4SPiMVjlM2ubuaL9oIgZuxipnWVW6Vhsp75jrtMIlHXViqQ9kdpefbmFFYK2pVqMLIwCJAC
	2phU7j8mVLoDKnkwkp1N8TdA8ERZS4X+lfqYz4JmCUCBqYmkNFu1xtU53iFEMPDiLeOeh9cAdeosQ
	++SGcr5023ok1aoWNvsClYH4774QndQXgkEMUdCDUkpoL8kf4RqmLS6WDaPkmRoMVp29ar0urc/jp
	dxLlWB32SG+ZqiDIxKbkQ8wySOyHbHT7wMTfV9/niRrjL92dhdkLu2owktpYiLaab//Dr73GqoWKh
	C+6x1daA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulgZv-00000009zbD-0H67;
	Tue, 12 Aug 2025 04:25:39 +0000
Date: Tue, 12 Aug 2025 05:25:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Rajeev Mishra <rajeevm@hpe.com>
Cc: axboe@kernel.dk, yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
Message-ID: <20250812042539.GT222315@ZenIV>
References: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
 <20250812033201.225425-1-rajeevm@hpe.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812033201.225425-1-rajeevm@hpe.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 03:32:01AM +0000, Rajeev Mishra wrote:
> Hi Kuai,
> 
> Thank you for the feedback on the v2 patch regarding error handling.
> 
> Yu mentioned:
> > return 0 here is odd. Why not "return ret;" to propagate the error if any ?
> 
> I understand the concern about proper error propagation. However, there's a 
> type compatibility issue I'd like to discuss before implementing v3:
> 
> 1. Current function signature: `static loff_t get_size(...)` 
>    - Returns size as positive loff_t (unsigned 64-bit)  
>    - All callers expect non-negative size values
> 
> 2. vfs_getattr_nosec() error codes are negative integers (-ENOENT, -EIO, etc.)
>    - Returning `ret` would cast negative errors to huge positive numbers

Huh? loff_t is signed; had always been that way...

> 3. Current callers like loop_set_size() don't handle error checking

If you start returning errors, they ought to.  Incidentally, it might make
sense to return the size in bytes - just move the shift into loop_set_size()...
