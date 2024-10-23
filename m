Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CB4A3E;
	Wed, 23 Oct 2024 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660762; cv=none; b=HmQAVeSK1O7RyGBCUEkF5qFLO5Xq7EacPpLdT/mDwkYIn3PGiQqMywY9DLEApBTVIlfrEnkqKKJA3xJ/+XDn4Wq4p0GYnQrq5D9fHCikfMaLeW2EdeESHZrcdQieSaMgdomsjHCJ2xfNHJmjJQKhXiO7it6yAWcn7J5bvuYQPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660762; c=relaxed/simple;
	bh=mTbTUpvKrMr5s2D/rIKWym5N1Ya/8Z0hWn58/SGi7XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT6LFJT635ga74Vo52reEwt//HMbcMrz3jlCYt3GMxCYdLDx0lrRxNniFV6dsfc0s5bOE40YatTL3gIKFcHqH+1/MNRHWHuxHjvzwC+/9hEDIacaKcoBV8QatADCXn8cPjiQbOoS+xS2T1/WkA2w3DcKli2PlJmfYIcACYVJOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AB31227A87; Wed, 23 Oct 2024 07:19:15 +0200 (CEST)
Date: Wed, 23 Oct 2024 07:19:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, zhuxiaohui <zhuxiaohui400@gmail.com>,
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support
 mq ctx fallback
Message-ID: <20241023051914.GA1341@lst.de>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com> <ZxWwvF0Er-Aj-rtX@fedora> <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me> <ZxYRXvyxzlFP_NPl@fedora> <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me> <ZxZm5HcsGCYoQ6Mv@fedora> <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me> <Zxb8KaoUVstRCxiP@fedora> <fe49daac-5990-464a-aeeb-c7c5f9d4d156@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe49daac-5990-464a-aeeb-c7c5f9d4d156@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 22, 2024 at 04:23:29PM +0300, Sagi Grimberg wrote:
> I agree. NVMe may have a unique need here, but it needs a tag from a
> specific hctx while the context requesting it does not map according to
> the hctx cpumap. It cannot use any other tag from any other hctx.
>
> The reason is that the connect for a queue must be done from a tag that
> belongs to the queue because nvme relies on it when it does resolution back 
> to
> the request to the completion.

I wonder if we should byte the bullet and not use a request for the
connect commands.  We've already special cased the AEN command because
it was causing too many problems, and given all the pain so far connect
might also have hit that treshold.
