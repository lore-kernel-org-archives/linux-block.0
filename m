Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034618412B
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103856; cv=none; b=J3L9cZF6HaB9hFcPvozEvVpFoUfLYyti5muClEhQGvanjKjNs4L4fcSbxf5K7HSBrQ0uimU12bb/qSZAeUTka1Qdxz1TBfcAYrBHfX9tt5QHVtScqAoq/sZJSZgZha6f0IsVjo5PEkDWd1iDFWwyB+PmQDJjFz+aYLax95V+XFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103856; c=relaxed/simple;
	bh=n8c/+wVAE5QOrM1RSBpYUB5sppzgph2ZNJOU835l6h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkiujzoSGNamC8G1nEXj/H05oIUF7ZV/OED6IHtAM/YrcxHsRPl1x2TK5EpmMW4NP8h5npmousjxut8Q24W/5Pp4su+eyAwf91vmZZtkfskJX1JMY4oYk9GfEl9V/t5ZMMQHvCzbqcNKrrigqngKHacvIx8lsT417/0jABgmz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8/yJLgX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8/yJLgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D435C2BBFC;
	Thu, 30 May 2024 21:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717103855;
	bh=n8c/+wVAE5QOrM1RSBpYUB5sppzgph2ZNJOU835l6h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8/yJLgXJoUaVPNqb8UqR1dNMO8LuEXLtGKAETN0X9LpMNgYTr1Oat9DspGx3o7TB
	 HuqsbpuBNX0Tr5NBlrrwl37ReWBEEe+yllbF9tZjrRlr3PW3zpTjVLSI+G43ItC2do
	 UAGQoKT3ImdqBR5kegcBeRctixFHXKVt0zf779tQmWs9H/tP80ioBelqQYDWijWKNA
	 VktSp0GGaohxROrz/Xh7mIoYx8h4gWQDnUEqEC4dBg/jppvZfk7j4W3jQWlGzdbQkd
	 FCMaB0W9iroopbU5/x2MI7xjW+G6ahpeSSHLTwJoZa4gYRUfGsj1o9HO2OS8cfA5Nl
	 QTI4h7Mgd5pdA==
Date: Thu, 30 May 2024 15:17:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH v7] block: Improve IOPS by removing the fairness code
Message-ID: <Zljs7Arkq9nBrHLQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20240529213921.3166462-1-bvanassche@acm.org>
 <Zljl3kAfL0WfFkoZ@kbusch-mbp.dhcp.thefacebook.com>
 <a5c1716f-b21b-42d2-8ce3-13627566c754@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c1716f-b21b-42d2-8ce3-13627566c754@acm.org>

On Thu, May 30, 2024 at 02:02:20PM -0700, Bart Van Assche wrote:
> Thank you for having run this test. I propose that users who want better
> fairness than what my patch supports use an appropriate mechanism for
> improving fairness (e.g. blk-iocost or blk-iolat). This leaves the choice
> between maximum performance and maximum fairness to the user. Does this
> sound good to you?

I really don't know, I generally test with low latency devices and
disable those blk services because their overhead is too high. I'm
probably not the target demographic for those mechanisms. :)

I just wanted to push the edge cases to see where things diverge.
Perhaps Jens can weigh in on the impact and suggested remedies?
