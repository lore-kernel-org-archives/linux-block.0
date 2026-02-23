Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823C30BF68
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864263; cv=none; b=uvrI0XXOxmh2u7I2R6GwDoFoFOM9cKP1xxJspCB7EaTnehLedXTDqRLS88Im3NcLYR5UhOkizsxrgd4BmYJWJA3SgqRK0YTWRFL9KM+2S+aIQmLalNmech/u6YG21gnCg22DQeGfirkrg60mpLMA9VsVDVGlu2P3fWiE8Ha3fKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864263; c=relaxed/simple;
	bh=MR5ciRZF6Zno4BX0SmwN/fFbYSR7uxw2QkI3BYG/rdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRjMn9BsDW46embvehuZPkGs36ggKi32+iUH83BocPKY8d9Vyjo6V4nz0F3y8c1ltuHP6CSa5KneMRi+qjEcq6hR8bdRrMNxwUKHPfh/oPFFY/eGkp0kLU2h/BPekR6IYtnU/fP6zfJ/8H+czP5qsPYlrtclum1nPxiqJGXv/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2Bni0h8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2Bni0h8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCF6C116D0;
	Mon, 23 Feb 2026 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771864263;
	bh=MR5ciRZF6Zno4BX0SmwN/fFbYSR7uxw2QkI3BYG/rdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2Bni0h8C4Sz6wl3toSEMohn2+oYiqgV28MOp2r/0Woma1C5ZB37LLQU9FnysgzSh
	 UtPYpJvsctA4srDRs9qFKxWrnvnrqV1QyDUqmv9JiSZvZSbkRxmYE0qlQwhrgcC4nG
	 feiEbDnb/ab8P8ZYq78u14MOAyhEePG0TEWCZTw8zmO24scrgzKlHBkeaiVWd8zPnk
	 t6l//BTB03SIdAIRYChGySe6K90nC/YTxq3T/8llGzT7vXxMZS+zpfDR8A9KXdy1sX
	 haM6hp7ESNH+wsgG1W0fw9cMUYOdBZ9tVCa+8jTBJIJruYDCrUd/44BcfFPG0HXWNa
	 Ke436O9uT1FEw==
Date: Mon, 23 Feb 2026 09:31:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	csander@purestorage.com,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv7] blk-integrity: support arbitrary buffer alignment
Message-ID: <aZyAxTqM0ABwDswl@kbusch-mbp>
References: <20251125185718.2190305-1-kbusch@meta.com>
 <aZYy3L-UVjgNQS11@kbusch-mbp>
 <b1c7cb9b-f790-4e3d-b1bd-4f4f516f9b3a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c7cb9b-f790-4e3d-b1bd-4f4f516f9b3a@kernel.dk>

On Sun, Feb 22, 2026 at 09:29:50AM -0700, Jens Axboe wrote:
> Looks like that got missed. If you rebase it, let's take a look and see
> if we can do it for this kernel release. It is on the bigger side though
> for this deep into the merge window... But since it's still early days
> for the release as a whole, we may be able to sneak it in.

Just resent it. That would be cool if you want to squeeze this into 7.0,
but it's also fine if you decide to wait for 7.1. As long as it's staged
somewhere for upstream inclusion, I'm happy to backport this as needed.
