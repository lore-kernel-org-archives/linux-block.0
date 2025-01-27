Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9AA14E2E8
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995047; cv=none; b=Rhuupw/KYV0rCQ2noOli+Ytpwa1oOvQnXO+NCm45RGx1ajZ9CKE8Ei9SyF8wZ+P1dBSvHH0tsumYJ2PKXIvpbfWgP8Ql13LI4XQhC1lSEmkLLmoMxhEH+r5wJL/R7ZnbMYDiWWlGRDrtErS2ITVBdb1m4uGck6u3RebpbZ9hRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995047; c=relaxed/simple;
	bh=WXa2YJuiY0ajuOmlaEQtEB/6JZudO0/adZLI3G3ihj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o78g+K5ltRVsbiWCyv0MWyyZqYnmPMF8eOXP6NpAEpIn9Ugy167u9p47FgjytD6uvKp9wMy2iQGDhaQIISZILCbYhqLIRm26Nu14QsusO3a9VAOtA7VwRhygnYGGq5DOvFZTh0K35VELDM0OrLfLSp7yUKANm9s88e4H9eT9GtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzkShxc4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzkShxc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF58C4CEE0;
	Mon, 27 Jan 2025 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737995046;
	bh=WXa2YJuiY0ajuOmlaEQtEB/6JZudO0/adZLI3G3ihj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzkShxc45o6Inpo+sIiqo0h43EnBDypXGHHC/FEVup6W/ufdTLisj0W5T6gIG25hT
	 18sSWfgzp/I1CVhs9s18clswhZNuwkXVcqzeJoAQPBIDGFpMytdJx/XcrcE2d/zq27
	 011o9mwkwVpyKxUyTLVYtB4vWbCM2TmW+zaHjW+kQW8mOL//k4owIsyB5K9fOYGvtm
	 m6Aw5s2MNXumD618aVqPvNg9CfInf+uaL4zJLv1oEG4os3wqzcoE4GetoEmiePQDBi
	 EedINY/t5XuZZhkXIpB3l87LD0UDMg+8biV24Q3xKK9M+OZ50ZAyLUuH3xRuqk1syO
	 EBAWWa/HQkXlA==
Date: Mon, 27 Jan 2025 09:24:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
	Jane Chu <jane.chu@oracle.com>, Andres Freund <andres@anarazel.de>
Subject: Re: Direct I/O performance problems with 1GB pages
Message-ID: <Z5ezI5qHksE3Tbzy@kbusch-mbp>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <Z5euIf-OvrE1suWH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5euIf-OvrE1suWH@casper.infradead.org>

On Mon, Jan 27, 2025 at 04:02:41PM +0000, Matthew Wilcox wrote:
> Now, since postgres is using io_uring, perhaps there could be a path
> which registers the memory with the iouring (doing the refcount/pincount
> dance once), and then use that pinned memory for each I/O.  Maybe that
> already exists; I'm not keeping up with io_uring development and I can't
> seem to find any documentation on what things like io_provide_buffers()
> actually do.

Yes, io_uring does hqve this capability. Here's a doc describing the
liburing function that sets it up, and explains how to reference it in
subsequent IO:

  https://unixism.net/loti/ref-liburing/advanced_usage.html#c.io_uring_register_buffers
