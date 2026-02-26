Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BBF12D21B;
	Thu, 26 Feb 2026 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075010; cv=none; b=NJJcmTM5XPbKBJWW9wswl4/2kTyoRrADY8RJDK11aQsUy9sbgL/xHfzvQcDRDS8GQqzxKgEjthFBI1xt3rdbnWQmdAA0pF+fzUhsunfhIUYo3bdNto7npxNXUm5uM3OjnlOk26dUhZCH2JsbST93nxhBrx9D+ppGM3H45GgcVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075010; c=relaxed/simple;
	bh=w4nmxgg6B2apbZjFl/wiFqr3+gpq+vuQ3u1MkV8t4+8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ocYvZ3lMj1thnXjtmsRG0tUNNVugElXPwItfCIKNMR6wEc2hnk+JJh9c1u2MRx8Cfo6LsiFwb9vdvY7eA/eLFUxvkR93SoIbsDs6CAFoE4eViUasKUPFpwfQWV/00H1JzRsn/VC90jVi+ma/lrec8iFgWVb8GEg39JilpKDE2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kf7vD2PM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kf7vD2PM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D073DC116D0;
	Thu, 26 Feb 2026 03:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772075010;
	bh=w4nmxgg6B2apbZjFl/wiFqr3+gpq+vuQ3u1MkV8t4+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kf7vD2PMlRugco/gixwl6qO61uIeodj7f+pX287GNC4q7nt63hRP6khor5FKThsPS
	 GsHH9OI7giafksCC0Cye9sdUcyIjZ+Uz3SvTD8dEBcfteBtTPohLvfu2+NdwUxLnty
	 2nUPZkCm4J92i4NLFTradHtn4rXOoFr0Vg/qg/RI=
Date: Wed, 25 Feb 2026 19:03:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, Minchan Kim
 <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, Richard Chang
 <richardycc@google.com>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] zram: rename writeback_compressed device attr
Message-Id: <20260225190329.8f76b847d391c71d58988234@linux-foundation.org>
In-Reply-To: <20260226025429.1042083-1-senozhatsky@chromium.org>
References: <20260226025429.1042083-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 11:54:21 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Rename writeback_compressed attr to compressed_writeback
> to avoid possible confusion and have more natural naming.
> writeabck_compressed may look like an alternative version
> of writeback while in fact writeback_compressed only sets
> a writeback property.  Make this distinction more clear
> with a new compressed_writeback name.
> 
> ...
> 
> Andrew, the code in question is in 7.0-rc1, it has not been
> released yet, so we think it's safe to rename the attribute
> without breaking userspace.  Can you please pick this patch
> for 7.0-rc2?

Fair enough.  I'll add

Fixes: 4c1d61389e8e ("zram: introduce writeback_compressed device attribute")

and shall queue it as a hotfix.
