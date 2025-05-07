Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E128B3F5
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626215; cv=none; b=qybbBzXqlHb+uPP9CQbwRneUx5NFdICPRWxfzpa/NnCV+45ogpo73p7GgBBKQrfhnUof7uIMKhVgt3yrhP1ED5e0D0gMEy4rTaVsNKBiVZTquh3MvaTnYv+oNY9trEuuU7qyt8bB+WUcKC0ZzjdZStP81vyYoDoWQRvr5Mhg8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626215; c=relaxed/simple;
	bh=k7SIiN+HGy8vISpqMNF4CPShVXE0ya3AiS+/voXYU9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlynB4QOX2VVUPktp8MTd57kH7kl3hv/h4Ne6YYxvEy1kcgAfqxSTK9gV0135Y/QyKPnUc4dSNrd3koHTYCM4Tl9vDCqt3M4R3KB+aOInhpyL+RRuyZtBy0w6cIo/2yjDPncOVwLxSHSVxfDndWVv8BXawiu5Yc4tv4XJ//twjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJcRby3D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJcRby3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CCEC4CEE8;
	Wed,  7 May 2025 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746626214;
	bh=k7SIiN+HGy8vISpqMNF4CPShVXE0ya3AiS+/voXYU9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJcRby3DchLAZGAtWP/QtxVslaMaqCdlcsuNwot6Z0F0RW4kY+YxYtHcoOscbOSCX
	 KPoXRxaWsAE+WM+nen3eFonXdaxzp3IqZuiOSafqXjoHua5n6KPQL1AHvlhVixDiiw
	 wdolSl7lj7IpMReVwY42ZfQObsjiw/jYrjlkkwORoPkMJ5TJeXRVFIWuku8vT46Qm/
	 ZdsmAnGCA6XoI5xlsoI52KTP5/hq6A11OscIp8r/0U2lQbEyiH76Ina0oDI+NNCRkD
	 QWprLxsiHrZb8wVcN1UMQ9GgYH5V4QAoNNS4DRFagi81FHghwd+VNdUO+1vMfGPtx8
	 4qyyeTv4rrG6Q==
Date: Wed, 7 May 2025 07:56:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH for-6.16] fs: aio: initialize .ki_write_stream of
 read-write request
Message-ID: <aBtmo7FHIogZuOX7@kbusch-mbp.dhcp.thefacebook.com>
References: <20250507133328.3040255-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507133328.3040255-1-ming.lei@redhat.com>

On Wed, May 07, 2025 at 09:33:28PM +0800, Ming Lei wrote:
> AIO needs to initialize .ki_write_stream explicitly for read/write request,
> otherwise random .ki_write_stream is used, and cause -EINVAL returned for
> aio write randomly.

Yes, thanks for the catch.

Reviewed-by: Keith Busch <kbusch@kernel.org>
