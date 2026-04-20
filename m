Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479EB3AC0FF;
	Mon, 20 Apr 2026 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691290; cv=none; b=H0VtYmAEou4hWuDkKYoBZxBnfUYAUB40haOEmax9RPLBVIHiHWC4L4tUoRcN+kdNhuXMAPBjvyp6U1Udq4S8QzNbCSJbv+vvpNtEh9rc6+Udgs/2YoetJhIApMK59XLWZIJY4RpbDMFH6vi7i/z0ovjI/h6hbsH1mWDBloIbuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691290; c=relaxed/simple;
	bh=5s0WCW5ncurEKPR3DliQJ/wktBb9wJvN/Ob3yPyMsOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmLOfa5NoFc2sxYGQAaWqqibppJK1fsUMmMnVuAo4b7jwwsgPjw7P2sZqRIgQkb92iG4ptdruh7+xjHGxwc64RBnoPhobog9BySDEG8y1rPGzBBFpv2HqQkB2++c9Ju+mEcF36G5Zd58Bph/eq9iLYdwvej3Ft+fPzgMf8KmnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joaJRXqv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joaJRXqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F550C2BCB4;
	Mon, 20 Apr 2026 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691290;
	bh=5s0WCW5ncurEKPR3DliQJ/wktBb9wJvN/Ob3yPyMsOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joaJRXqvlwXjVLJjA69d/Zz39I4UEVUN0LTfxQWleL9jKahMAaIQ2MO2rYqi1BjWG
	 bEwPda650UXLOr8AJ3osMw3l6KPfuO8RzcQRf1dWXgx9SlTfHFg1AEro9vB0YMteu5
	 PXFL9BLrk+RFwfGLkLbByybiGyBtDcP/m4tF4Hm5XFWkyuNm+1TGI8iUoT7p+JYMXl
	 3rxkHjftQNia2zfqR9x+TsTI19dwo++NY/z7D87I+QRaHFzywv4/Tu+4d4GtDBhG7M
	 VWtojjQfRuzi1FJAaCTQJw1nPEyzOaa9Oz7qwvfg+vvLyxpFsVwlXmabmnN4yVWuUQ
	 WChP061I1yPcA==
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.6.y] blktrace: fix __this_cpu_read/write in preemptible context
Date: Mon, 20 Apr 2026 09:21:11 -0400
Message-ID: <20260420-stable-reply-blktrace-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416100859.2492-1-681739313@139.com>
References: <20260416100859.2492-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Apr 16, 2026, Rajani Kantha wrote:
> Backport of da46b5dfef48 ("blktrace: fix __this_cpu_read/write in
> preemptible context") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha
