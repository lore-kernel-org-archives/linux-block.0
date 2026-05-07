Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4012DA762
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177550; cv=none; b=ebNpBF0dlRSS3nThalyg75gRuIPV/Cbwtw79dSSJaIH7iPdA61GuQ+/lmwufInJ/LPDd/LpQh8AzPP7Bt/N8XnJV1cM8KymA/7nOJ0hywHLNSgU4xNoXM9sgZK0rYHPxVBdHEKyoUmUyIXVTn1IrdkstLc1TPyJaHD9e8CmZHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177550; c=relaxed/simple;
	bh=nhFXydb0xZV+rEe/xtyu585U3MKjv53awL0/x4N18R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYAfTRgVKIlcghlOFYv/Kgi45Logi2uhFBESJGjsBDKS7/BJ/rThZmDyHgYb9ImT6w1bxdcNgKusRuqWe92Vc5FCwXcBf4j17peGr/OJYFXmuI/cMlGv9xVTI2tROmwYEcmBYc1whc/SHElU7G6IW3CUMeumKh9FKYZGncB546U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVhqP9SX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVhqP9SX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78E2C2BCB2;
	Thu,  7 May 2026 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778177550;
	bh=nhFXydb0xZV+rEe/xtyu585U3MKjv53awL0/x4N18R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVhqP9SXoo1MAgXfrQ6K5kcSnpObOkz23LlZVwAADhmT/eu25DEiz4u4R3kd1Vvsq
	 D4oCXPv1GQJsj8jY1DBMMYCx8dGEvhOSHSfAiMFOIAGI1jSko+EZDz6Z4OKQ4cfRoR
	 loqmWMpf91Yy6j3IohOHI0FAw5nZJO5+GPBkJMHYA8EkGAjAueUlqqucDlkF8XR6FE
	 Txj+L5fY0fwgnT8DDggsxIParwhH0COGYGBospnB1UKkgjVhETMC6ShRZEiknE0WG0
	 MD8pZGsIKfiLlOOnGJI1CC2lYmp33LNuMdlhbqRafUGov2eM23LbmtXMcl/+uoLvXm
	 aP/0owoOuoqJA==
Date: Thu, 7 May 2026 19:12:26 +0100
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Message-ID: <afzWCpJSqvjnTgpF@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427003457.1264511-1-coshi036@gmail.com>

On Sun, Apr 26, 2026 at 08:34:56PM -0400, Chao Shi wrote:
> In both cases the bio was submitted without REQ_INTEGRITY (because
> blk_get_integrity() returned NULL at dispatch time, so
> bio_integrity_action() returned 0 and bio_integrity_prep() was not
> called), and it reaches nvme_setup_rw() for a namespace where
> head->ms != 0.  The existing BLK_STS_NOTSUPP return correctly handles
> this dispatch; the WARN_ON_ONCE is a false positive.

This is what I'm not really following. The cached request holds a
reference on the queue that prevents the queue freeze from proceeding.
This driver freezes the queue along with the queue limits update. As I
mentioned in the other patch, that was supposed to ensure the block
layer had the updated limits before it could allocate a request, so I
think we need to understand how that was defeated to get to a real
solution.
