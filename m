Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858A8BE5;
	Mon, 21 Oct 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523781; cv=none; b=FjBJXuJe0iyqmM4RIdbpILsATJ6It2xxdW8o/qyQz6T9H6znIvYWIUD8Rjy1ibxt0PTNSfN0Mh/IUy88nYBa7v+RVuQAikhpPCs+vVA6H+K739bLOUHlLi3pjyU2lZKVT0COPo02fiYEQoNzQ2T+IVF9KP//X/bW814GcS9hw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523781; c=relaxed/simple;
	bh=5H6TrOPGo6rxS30FRSlEU6+6xgiYlVPWMWR3Nh1cc+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjcLpJ8p2fgMj19iVd3GemJv4dctWfudiQq7xzhlGfa3YfB5mhTrucowts+oouPvyFgAvQCMjRx+BdEwZZWkNAfzbQaY8zF2HFe+RvvEaZ5/9K+hTFwYdayO2II6Y5ZtuXor9NVilppPK0Jh3+VlBpRb+kPmuTM22eqqjJwnFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOLi7ECk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOLi7ECk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8533C4CEC3;
	Mon, 21 Oct 2024 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523781;
	bh=5H6TrOPGo6rxS30FRSlEU6+6xgiYlVPWMWR3Nh1cc+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOLi7ECkopbDKIZxPWiiHSnznKKNnZj1oKXXNWgTkyR9KYVVPPoadz3cL012vzZFG
	 oqcHzzb+p5TbZSBSS/8P3UoOMbCZBQsOjfdoplxic8045bqBbPepP3fSzfLuH6yxJ3
	 p0oGERjo3oJj7EWKM7FVoAdKnY4MFsP5pTvEQ7nwomsqu5OM1rl7LOCGndQo6Jnnpb
	 p54sKv/F138CKy3yrzTxUcIUuihg1+c5ndj7jXJ7/FvUCn9zApx9cElpDVCEO+wPK4
	 F0Oe0klfyM0CjPQY010ZiEfmsUmlgGjG6ayxyL8BJ4RocLPxprkgKSfdhK9wjwZmb5
	 wrbQza3SsNOaA==
Date: Mon, 21 Oct 2024 09:16:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH for-next] nvme: use helpers to access io_uring cmd space
Message-ID: <ZxZwQospJV2S7XN4@kbusch-mbp>
References: <c274d35f441c649f0b725c70f681ec63774fce3b.1729265044.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c274d35f441c649f0b725c70f681ec63774fce3b.1729265044.git.asml.silence@gmail.com>

On Fri, Oct 18, 2024 at 05:16:37PM +0100, Pavel Begunkov wrote:
> Command implementations shouldn't be directly looking into io_uring_cmd
> to carve free space. Use an io_uring helper, which will also do build
> time size sanitisation.

Thanks, applied to nvme-6.13.
