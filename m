Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCDC2765F5
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286490; cv=none; b=VwOUfXk4jN/ylImvOEc0giQ2PsfNJQ+3BA8ez+Xu5IU/Xp0SA2hLmPRJLF8azHUqFTL0C0T2DksCrUn2WF+0cV4TwNbffnvOCOlBw/s6qdGCb+crL9y+yYdixC6TmCGtvmPqNF5b3HUeVLPQlg4u8so8ZiZwqK80uUo6HLuhZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286490; c=relaxed/simple;
	bh=lXCsbyuuDuCMDWrTMf0pJAZZkd5VL/3sa8AkD6VrTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ibcb+BssX5aH2moIupJEYNVZoaajWOFYmhuZS4VkY6ARwSnsfFiIkOFdstmmMHWVVve4OeeWLSaklv+L5zaAs1KuLORwwfk6M20FQgptoohcN+OV6Ga7urcHpm15nWcjJkLFNqKZMvCBFErCsa8LnfrUIJ+dQuVG7mvui6cTBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkcvX0cf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkcvX0cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A8FC4CEF7;
	Mon, 23 Mar 2026 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774286490;
	bh=lXCsbyuuDuCMDWrTMf0pJAZZkd5VL/3sa8AkD6VrTyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkcvX0cfbBl2TUQkdedrT5XKQ48pfww9rLd+IgQ5gxfKF2PPlwYJfq+3mYlGaj4kx
	 84Oi5ODWBzqmkc25vCkO5M+0QSJhSlWjycjaFCK6u6T8sjiDJPwTxBjsEpipgeVDx0
	 FEbFnA8MZe42cSPyBzrDYvpPjWuD1XhqlYlc5Ih/A6EiWjYXEK+LCtWyKP3OLowFqw
	 sHKRV6w7HqE/rGk45zq1wE81NdYL561AWTw2TpfskzHXEsoAaleex7+1+u3zEnRZQd
	 RTexJXIFUDDzMR7062JwAxo1Y4uSXIb7j3sP5R185OXRLzCeTMl4hPzY3VjOAFEqkI
	 3eN6TDEi/TbUg==
Date: Mon, 23 Mar 2026 11:21:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists-infradead.org, linux-block@vger.kernel.org,
	Keith Busch <kbusch@meta.com>, hch@lst.de,
	martin.petersen@oracle.com, csander@purestorage.com
Subject: Re: [PATCHv8 0/2] block for-7.1/integrity rebase for mem alignment
Message-ID: <acF2l2coqz2K3j-V@kbusch-mbp>
References: <20260313144701.1221652-1-kbusch@meta.com>
 <177349768999.37164.10048861817413145882.b4-ty@kernel.dk>
 <acF0aJa-GXGYPqS0@kbusch-mbp>
 <f348e3ae-1def-4728-b8c5-1b32e1e980c0@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f348e3ae-1def-4728-b8c5-1b32e1e980c0@kernel.dk>

On Mon, Mar 23, 2026 at 11:14:23AM -0600, Jens Axboe wrote:
> On 3/23/26 11:12 AM, Keith Busch wrote:
> > Did you forget to 'git push' this branch?
> 
> I don't think so?
> 
> commit 203247c5cb972af5d46bdb7d41ef40078048810b
> Author:     Keith Busch <kbusch@kernel.org>
> AuthorDate: Fri Mar 13 07:47:00 2026 -0700
> Commit:     Jens Axboe <axboe@kernel.dk>
> CommitDate: Sat Mar 14 07:44:30 2026 -0600
> 
>     blk-integrity: support arbitrary buffer alignment
> 
> and
> 
> commit 5d540162059598c3f79e12f96064825cc91f0f9c
> Author:     Caleb Sander Mateos <csander@purestorage.com>
> AuthorDate: Fri Mar 13 07:47:01 2026 -0700
> Commit:     Jens Axboe <axboe@kernel.dk>
> CommitDate: Sat Mar 14 07:44:30 2026 -0600
> 
>     ublk: report BLK_SPLIT_INTERVAL_CAPABLE
> 
> in the tree since 9 days ago?

The current gitweb doesn't show it:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-7.1/block-integrity

And I don't find it in the repo either:

  $ git fetch block
  $ git log block/for-7.1/block-integrity -n 1

    commit a9aa6045abde87b94168c3ba034b953417e27272 (block/for-7.1/block-integrity)
    Author: Christoph Hellwig <hch@lst.de>
    Date:   Mon Feb 23 05:20:07 2026 -0800
    
        block: pass a maxlen argument to bio_iov_iter_bounce
