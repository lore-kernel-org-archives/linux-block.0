Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FF1CB53C;
	Tue, 22 Oct 2024 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627698; cv=none; b=MKYzRMj9UeclSvB9RQxo+GoDiTpxPGzOB0qT6tdLM/yXi6lIM9KZE3DFPRfuGZp4+dL9n7iXqAmRNVAQsjAat6Rfu/Y1UB5i8R73ClASdT36M7qDH/n5U9/qXFs3VvMXrl+KMc4TX/9bsZAaDgMQMK9ehkFWgyI0BsMWNGQE6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627698; c=relaxed/simple;
	bh=Hk0xNR3Fju0A7zaWWstaidK0qFTATTNNp5GlZTkq30s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtOsEZgD62vBYsUzu7/tNX/YvasqdCo9yDFkicPOWH1FHbVYnZTYNlpiLZfx2IzT4Sq8TOKhSevB9WJr79L4od897UYuWM60ImtI5rOBUefwHMcuM6hUYluJdYEW0YVpap9xBRFyLT9bMySJia82CK/Z4q/jR87yUiKP8T+JrzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUtTB9HS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUtTB9HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84F7C4CEC7;
	Tue, 22 Oct 2024 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729627698;
	bh=Hk0xNR3Fju0A7zaWWstaidK0qFTATTNNp5GlZTkq30s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUtTB9HS0aGAN+s7gc6O25pJPo09tfrIjlSh4WM4agZwgipntxOjgC4RRQDwWnjDU
	 JAALIIfOi3RJi0TfOC/CdigAe97i2mKJNsPikJbiPn0o5L0j8J95e51Use47hrfJWr
	 j4U6vnOAvcZNMA5Rh336gPmmemJR2V6sguUj5bqiwHCCasIYczEx1Lkyqwamju6WCk
	 rydwF7+2SEl3Wn+eEFN7Mf8X2Pjn2SJmnCptQB9xgZb1qx++LNEL/THPn8XOaJa7Si
	 R+CKH917BjxZ2+JYNmxjxouuy8IXzUzPC7qRi1iQuVT7d/FeSsUxhHZSXIGFOsMlOL
	 801QdlLQNPW4g==
Date: Tue, 22 Oct 2024 14:08:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Wang <peter.wang@mediatek.com>,
	Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Make blk_mq_quiesce_tagset() hold the tag list
 mutex less long
Message-ID: <ZxgGL_DhYwBcrFvE@kbusch-mbp>
References: <20241022181617.2716173-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022181617.2716173-1-bvanassche@acm.org>

On Tue, Oct 22, 2024 at 11:16:17AM -0700, Bart Van Assche wrote:
> Make sure that the tag_list_lock mutex is no longer held than necessary.
> This change reduces latency if e.g. blk_mq_quiesce_tagset() is called
> concurrently from more than one thread. This function is used by the
> NVMe core and also by the UFS driver.

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
