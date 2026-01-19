Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB77221275;
	Mon, 19 Jan 2026 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790079; cv=none; b=urHokC6mkW46SD9DVkE9pveMTxbvn7WP3gpOEVKU+x2NdhHJwqA8mZuZ1EVIeTn+iC1zxNMQNHzhUeJjcAKsYZ5+aG7J6KrXdXSAik+5flC9+rNAdNar1drhFjWygQXJD2IoJ+GX+KU3woymLTC9ekHWQxYWijWgMQzghIMbbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790079; c=relaxed/simple;
	bh=YVy/1y+q+QVasfuOK09hlzjhuU7NPNg3Wonyo/pdW/s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s2LAhpFJnpDPeGirYip1uZVK2pPpVMezYmuNV/r3nCTHz0icOpUKMv4uCjoB1d70iGovWcNIGzc6DXxq9lZCizBpn2rDPfriLaAYPNkeZmIkYCgjyrXyRLZNM9fscKiINONse0GUNp6lBVf5Gkl8IQLCkL+7Jq6x2m7u+p5IVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZKGhiebf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZKGhiebf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ED4C116D0;
	Mon, 19 Jan 2026 02:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768790078;
	bh=YVy/1y+q+QVasfuOK09hlzjhuU7NPNg3Wonyo/pdW/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZKGhiebfTjbjAZzdeRmF2R9ic4BcynR0XIZ3LeGjkdjM5rECcyFPeIdQZFRD/WQZ1
	 WF5lIJx1xVmKmmB5lEseKryywNtXQ3ZtBhMt9sAzh9f8sqEUrDpa4PwdYAT6XNpRi8
	 2gzvF6+uuF9z1WX77IvNBChBpauX6F0NIam0igDc=
Date: Sun, 18 Jan 2026 18:34:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Richard Chang <richardycc@google.com>, Minchan Kim <minchan@kernel.org>,
 Brian Geffon <bgeffon@google.com>, David Stevens <stevensd@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCHv2 0/7] zram: introduce compressed data writeback
Message-Id: <20260118183437.6b11e6c43c7701759b73d22c@linux-foundation.org>
In-Reply-To: <20251201094754.4149975-1-senozhatsky@chromium.org>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 18:47:47 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> As writeback becomes more common there is another shortcoming
> that needs to be addressed - compressed data writeback.  Currently
> zram does uncompressed data writeback which is not optimal due to
> potential CPU and battery wastage.  This series changes suboptimal
> uncompressed writeback to a more optimal compressed data writeback.

I'll move this series and the "zram: use u32 for entry ac_time
tracking" series into mm-stable soon, but the review coverage is thin.

It would be good to get some more reviewer input on these zram/zsmalloc
changes.  We haven't heard from Minchan for a couple of months.  Is
there someone else who can step up and help out?

Thanks.
