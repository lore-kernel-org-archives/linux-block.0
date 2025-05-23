Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1050A1A0BF3
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748008138; cv=none; b=dMbq8gYjeL+WprG+p495h7g8mNWftaGYV1ltFOhy+L6C7Ow3XKgy88G3MvaQYTs0qS+ZWKU7zc20sD950L58WQ+4frCy9wkb2icKxi/AeOeYSXMybKZ42UD+lf/npVcHaADhWTi1OJkabPViA7PbhM3KVOHLURE+zDSqw8w4OKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748008138; c=relaxed/simple;
	bh=CeQL813KTKaDoNfewIcVNz20KXODZ3WH7x4GImGwJyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Abd6apONPB9RVC8k3d9q+a5EZh0jb2jV6mLPHpIn8r6k7CnhPqQsxY04dwjNw7Xka0sXq9fzK6Z+vkH4e+1hSRIm3MzCJsBVWoWAnS0PXtuTtEJUDZ274IM94hM/LDhgyC48yzaPgOY5f99iC/4sluwShQr/JUWKu1PBkYFLxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWVqpn34; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWVqpn34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FA9C4CEE9;
	Fri, 23 May 2025 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748008137;
	bh=CeQL813KTKaDoNfewIcVNz20KXODZ3WH7x4GImGwJyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWVqpn34X0SRNI5jAJ5XhNvNx8heDzL8DwIlnnamlxem/vydmXt/JasLzCreQ09Zg
	 DddLj4Eu8IYMCzUh8nsE1VND2DwFGoIt57JbxJ5pS3tZc/7xYWrER1Jiv7dqvetCXM
	 cB4AL07X3zQUxAT8RjZfVv+qG7U3x4KRgnUAP4T+wLQ7xfkghw5Ghg05T5mYavBNqb
	 CwVqj/3JHr00UCu7LE8kCwfUsZUkA8oJJPu3FWn6/DnQ7b0zjuabSlNp9wau+mffdv
	 3AnuC3aYdIePZeR465+JNsB/Bh2X6vNTQtqN9ngZ6S80OftHDm+Md+1TtsdIBVaLMf
	 UR5lgMm0a/0cA==
Date: Fri, 23 May 2025 07:48:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDB8xmc3Up0STRVO@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
 <aDB6Hdp9ZQ1gX5gr@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB6Hdp9ZQ1gX5gr@infradead.org>

On Fri, May 23, 2025 at 06:37:33AM -0700, Christoph Hellwig wrote:
> On Fri, May 23, 2025 at 07:26:45AM -0600, Keith Busch wrote:
> > Darn, this part of the proposal is really the core concept of this patch
> > set that everything builds around. It's what allows submitting
> > arbitrarily large sized copy requests and letting the block layer
> > efficiently split a bio to the queue limits later.
> 
> Well, you can still do that without overloading the bio_bvec by just
> making bi_io_vec in the bio itself a union.

I like that idea.
 
>  - bio_add_copy_src not updating bi_size is unexpected and annoying :)

Ha, I currently have the submitter responsible for bi_size. Your
suggestion will make this easier to use.
