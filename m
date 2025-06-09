Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641A24EA85
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461371; cv=none; b=bOFXzNp7hvFlz0+zD8XIyk/dJODT5079uG6W3792qI6nUh/evshhdDbfp17S6G9PpDfd/I9JYjOlJGLZNZisBTDa1ys3xAelr3homDagzGw801ngTf7UYWzt6tsyvBnsRliqrZZlsZgLdxNuDdmqvUKVdLf1w8hd6p8D78g7aWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461371; c=relaxed/simple;
	bh=x/EnJWl/k0jsWW6PMMleDnU0RrJaBN65jDQeKCebf9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zvkm92t+5t6JrpRvpqznv3F8L6hcLVLMpUnrKpq+DE0opsap+QhhkQ/NSJOnmxRJmxlx2yGmlw0jZN3KAuD6WTzi8NyVII2Dwp/Q13/cN1Dwu6u0p3fT9BSr+FqfnafmrwVMLc6vgbZ8bbDifa/O2HY1ZY3HivrjxUgLUf8K0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcCM6Xef; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcCM6Xef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4007CC4CEEB;
	Mon,  9 Jun 2025 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749461371;
	bh=x/EnJWl/k0jsWW6PMMleDnU0RrJaBN65jDQeKCebf9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcCM6Xef1yXTIWZcPmZjtcgsQzFN2XcKqh4ZFgV/ssN08Df0aKJHSfW//3gGknsq4
	 WAAVwhOUqvFQIwxv3rTywGa505tQWx/zpxsFsZzwo9mD6MGKmnby8DbAQlAXmp9Xg6
	 eFXBxwvw6SfZbk/imnjKFjU5HvxLFkcz26baZpWESbsVhgp7wWWAlyj0/HDaCxSdPh
	 AP3oJSH6CU+mTNrtuzcW+tVnuvFC9V8xLGQVhaml2twXc4LLF4iioOMA4i8TBgTU/X
	 NYSq+NV8ws968V9Peb1nASUuJTkJJrWdIqfwfXLb0+9A8RgPkWWgcWgpx6j4vSJWvz
	 +qSltiFz1+BLw==
Date: Mon, 9 Jun 2025 11:29:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aEapdy-c6G35Q-vx@ryzen>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-4-kbusch@meta.com>

Hello Keith,

On Wed, May 21, 2025 at 03:31:05PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Register the nvme namespace copy capablities with the request_queue
> limits and implement support for the REQ_OP_COPY operation.

Since you never initialize Descriptor Format (DESFMT), you will use
Descriptor Format 0 (No SNSID, 16b Guard PI).

That is understandable, since your block layer API intentionally does not
support cross-device copies. But I would have expected you to somehow
mention the descriptor type format used somewhere in the commit message and
somewhere in the code (as a comment).


I haven't followed all the work that has happened wrt. PI in the block
layer recently, so I don't know, but I can see that nvme_set_app_tag()
can set a app tag in the request itself, and that nvme_set_ref_tag()
supports both 16b Guard PI and 64b Guard PI.

Do we ever want to set the ELBT/ELBAT/ELBATM in the nvme_copy_range struct?
And if the namespace is using 64b Guard PI, do we want to use Descriptor
Format 1 (No SNSID, 32b/64b Guard PI) rather than Descriptor Format 0 ?


Kind regards,
Niklas
