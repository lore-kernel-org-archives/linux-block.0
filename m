Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73A17A304;
	Wed, 16 Apr 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822856; cv=none; b=P/yMvjsZslgkPGJzlNsaPne8xjYQu2Zgja0r6qR2m/XsOT9RpUyoKkh+IR+g1Anl/PpkLZ486KBFeJBqE6Px8hq6k236LjeYb2eGRYYmNvENmrlR7N65PqOVNyX1tR4Cs6Cu0RbaytAo0IKu3Rx5Q9hueOnb9a0RZ6C8xO7htek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822856; c=relaxed/simple;
	bh=Wt1UAs/njkYHTo3ZOAJNS8WN4itweF/XlxN3NKn2w1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKUFQPPbEYWadXhChH3z3F1KNlbhHWj0N3tAOcQ08hnSEnQfeVpN/8BtNScaBviilFKN3qHDaKdURrkd8Pmyv6TirecxvqFqOzDZodgw7P/FBdBCK7OGxXYAP8XmZNLCA6686RQqUZsNAjWIlVQpH92N413sGjnpto0vtbuvThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB++JRMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB++JRMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF7AC4CEE2;
	Wed, 16 Apr 2025 17:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744822855;
	bh=Wt1UAs/njkYHTo3ZOAJNS8WN4itweF/XlxN3NKn2w1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WB++JRMqFAIuXKKetI+/DacXFbk4x87Zc/6gaMvwvUUYxzGRo5BcqCA60QOLZxAMH
	 wgpxQbubCkHZSq9WBefkOID5QP25YWcJoG0NDwEGmXNYUWHmYqlest1Ud/dg92yi2N
	 ikbcB8cI0zJZIidFx5xOeGP44cGUjiJ/Hv5ONHd5nRg+0Wu+QMWRY27sbSCYbKpB6q
	 pt0eogUwI9cLN68yXSiapVNfTO42tARLHV3OYFXYP1N1y1R2iAGdoJYkuNUhvc820W
	 wYwrQH0Oul65iE89u3k1LEvCe/otREhRuc8JHXMZKLul7yjUGrZir3TcKS+hsAChst
	 xWIv2ulQJnAXQ==
Date: Wed, 16 Apr 2025 10:00:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: inline sg_next()
Message-ID: <20250416170053.GA189808@quark.localdomain>
References: <20250416160615.3571958-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416160615.3571958-1-csander@purestorage.com>

On Wed, Apr 16, 2025 at 10:06:13AM -0600, Caleb Sander Mateos wrote:
> sg_next() is a short function called frequently in I/O paths. Define it
> in the header file so it can be inlined into its callers.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

I had been thinking about doing this too.  Besides the benefits for storage,
this will also reduce the overhead in some parts of the crypto subsystem.

> Is it a concern that this would break kernel modules built against old headers?
> If so, I could update the patch to continue compiling and exporting sg_next() in
> scatterlist.c.

No, that's not a concern.

- Eric
