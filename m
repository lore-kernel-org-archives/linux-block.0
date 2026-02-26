Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C438BF68;
	Thu, 26 Feb 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092889; cv=none; b=uL9Sqesy4U87crmgsgThb0kCl2b4RP9Ugzra64Nsn2awuyMhIBb4ZzvsATvxfBDITGhs3F4/+w2hi75hwwqTcOxHxNUUIc0QkXjPciJhDq6UnanDVtC3NevnJRFZNJnhCkskvZX9x+AgoIbOxj20MyGDmUZxS12m05NQJs9btao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092889; c=relaxed/simple;
	bh=3sfrdCB29oEXL3KJoL+J5uaz+wquoAS1wW/bgZeqLzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWoHtPI+1ajOeYx/DwbaW4N7EbTr8d7xlMQ+XBlrG34/voxJ3yrsQi2VHyO5Z/fNjwILWeJ8v92usB1Cv92h9uEEGJ77gUG58b/9/swBsqWgl+xmOePkYky8uj1ZcjeCl5dMKCbvm11E94kn6pFKBiIZrHNuwPeObHMpuzYwHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6rw1H6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6rw1H6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7A6C19422;
	Thu, 26 Feb 2026 08:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772092888;
	bh=3sfrdCB29oEXL3KJoL+J5uaz+wquoAS1wW/bgZeqLzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6rw1H6y+vqnuONK6Ysu4jhs1mtWgILyhWX8bkvjNuDWTNWJeY1kZ2SS4YKjpc8LI
	 FHcKTU3VS5txnq2yS9u0CzzWjkdfg/G0GzxpgnA0MIIG0LClu6Tc57h4ezhaxkbICf
	 iS+OH+/nfIYWOzK/be/qhYjSi5jydhVOUM8YBXRMZwCYOXMKS69JInmD3oJC7O9eTT
	 FK4aFl4YMMllcrVPJIiat+0ZFX7NoYAGEn3V1vkvVKtRSN4Mmi2na/iWXdKEzeHOPM
	 D3x8gyB4NAnASl9JDNjaUOA7YjXaZqh4FKt2grwkSrMxbXz/Gs5GJoJMd6qV+LO7AO
	 bXvBpLcRvEtyA==
Date: Thu, 26 Feb 2026 00:01:27 -0800
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, Brian Geffon <bgeffon@google.com>,
	Richard Chang <richardycc@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] zram: rename writeback_compressed device attr
Message-ID: <aZ_91zBGSKfpsUii@google.com>
References: <20260226025429.1042083-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226025429.1042083-1-senozhatsky@chromium.org>

On Thu, Feb 26, 2026 at 11:54:21AM +0900, Sergey Senozhatsky wrote:
> Rename writeback_compressed attr to compressed_writeback
> to avoid possible confusion and have more natural naming.
> writeabck_compressed may look like an alternative version
> of writeback while in fact writeback_compressed only sets
> a writeback property.  Make this distinction more clear
> with a new compressed_writeback name.
> 
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Richard Chang <richardycc@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks for the quick fix, Sergey and Andrew.

