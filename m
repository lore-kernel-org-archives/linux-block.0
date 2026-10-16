Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD85379ECF
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160896; cv=none; b=mPGbO+tyEp9fln+2ka9CXlF30ydFKv/K2w0s3OGLL7JxGsPmILuoilcWIjmIYmNhYjtwAVn7SSMFB51ydj6wQIVE0nrSNZcb8xYCBZIrcLFZ6/9kZQ11dtvbmAEhkEOrYyLWEft0dHyaw/bulYvmDwJVMCB3vcyBG/YBSgGEgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160896; c=relaxed/simple;
	bh=GKozz/tp+bIJFpaOUq0zh72SepGChCeoHpNrT2chlz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gr5qSYf9GzZvJfhVkFk+bvWdXx7HGQ6xjXHMiujFb4gh6yHJSMhlNgT3bJvtCuFQpEV0NVDFnlIF0ZKMnY2w4+ODouCAJrsK/4n1/XaZ8qQA3Yj0SU8s5yuAxsBxpHbP1tN7btFAQPEkav7C749sIAnvLvz3o4077gvp8iJIuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=lPVO/ncz; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="lPVO/ncz"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30b6dad2382so15792496eec.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792160893; x=1792765693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=43txGlXvjyVAOxBJD3LVtjY+Cbo0l8Mor35q0LNFkb0=;
        b=lPVO/nczy2fUjgL8kAqdKTL186bWK5fY2ekFwMoseo3TzQbFgqhDdeLqS58K7qsv2H
         oA9hejzY6jtaQx0P9XZ81tSrtFu8J/YtXef+iYK80cYNbmLR9XDAsmhColXme7H/KYZH
         kJGbCCrWjNO0AL0OFapWYwFfgiVZIred4FhO4L0S9omIIhcu3PN1D4DXk+E3cVzXqPHu
         FG3801z5zWlj8eiQRu+H8XIyQgaUpeQSokt76//uhF/i5dJQWr31E7ze+7uztCx8zKaR
         dtu9AAB6RtXM1jRHNXwR62qxW1adp3apwrGU1FWowGd0GiPVUH9KNAr5h96bNbZMcW7I
         rufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160893; x=1792765693;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43txGlXvjyVAOxBJD3LVtjY+Cbo0l8Mor35q0LNFkb0=;
        b=E+5+GicDJDW1j6WhTSyvcnTcj2dfq9pU0RKFlwpf5NO5JUMebJ+CxSyTKHVB/eFE/G
         ZdFvXcmvvpvK/tkgrLzVRdQ1QNW38JccRm5Z5o9Yd59yz9YHB45SKOm9DhgThrFOcfpZ
         DPaICBbwofhQU6l/Mc0Lf6LAaOMKExNx2HZKbwlmZ5PtUpMHOEIiaXAmwgN1PVocoBKJ
         c/+vQJDAQKQcwHAeGhEFgvDolCCy4JSmx0Zb9WDqJqbMAQG8aMGc/KSzr4fZpt5mKckh
         xNC3FZK9SrEQM44yhE3ae+CH6q8RZdQIdcV40g21fB1wYQg6z6LHQ9yGn7Fb8X9byBSB
         3YUA==
X-Forwarded-Encrypted: i=1; AKwUvBxHsO9iZaUWgRWXfF0KcKWa7JrPAX8/nqwMtU55flfSTgfyoFYcpgyS+LZSALIyJOls8g5Vm8p1Iq0fBg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIci2x0G3bPyuLZFOjlspioGIno6OgaVXBCuK4TW7y2BO9fhpB/
	K6RYml2Pdu2XJXF9rjVb5uzmVyNkmmHWQTXKbX08DUSrXWHdnVFgdb+S+3bL7NWfs6s6ux67oA7
	XjG3l3E4=
X-Gm-Gg: AYBFou2GukUNyyxEaw/mGqO6cGWAB/bSA3wk0wNhiMtkGcVZC9HWn4HmMOo19EzlAs1
	ZeM7i39GqLgOt362Hs+dLsgUUsCbx7tOqEv3Ai3b8BjV7t/NFDYyVpkbxXXf5R+WrzUkEy9isEa
	vJWZ8YLI1rGyXlfNJBdjTeJIT1oi6eiLY7lTWDb6stWoNcHGbTKrfWTgBivwjq+wg3s5Vkl35X6
	2xO7LfvS5bj/tr/U26tDwfYtqdd+nwVNe3pQmU4ey8qZBv4WhjkYCj6BsdNYouj0/f+waHASAVp
	f6pMpSCq0jDyPMHqMQu+uhZy16Dy0jMaEa15Ig/ytxtV/BWt8pKX5Eoqa31yPsDzZC6HkGmKv2e
	LC1olPWzeZpfi7Ya9+Z3V2lJn4dMcHri6xhD4l9NFveuLOEORrSv9tYbqI0+MEwcbfNpC0gkMaK
	aeOJfXd9NbXTnYUJcnMIwsB8Ckn5O0nGcdVvA3ucfwlpX7oaJD6agtSya3K14bjPwSFYbNV07cX
	xQzSIuvrG7hVO5ED2FEPxupVFU3E0ieX1MHGIEUfQnVhpSZ9pXeNIhTFw==
X-Received: by 2002:a05:693c:88d5:10b0:35e:5ca:e0df with SMTP id 5a478bee46e88-35e05cae713mr11058517eec.35.1792160892526;
        Fri, 16 Oct 2026 07:28:12 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm7150945eec.14.2026.10.16.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:28:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, hch@infradead.org, 
 Tao Cui <cui.tao@linux.dev>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cuitao@kylinos.cn
In-Reply-To: <20260922043856.2020116-1-cui.tao@linux.dev>
References: <20260922043856.2020116-1-cui.tao@linux.dev>
Subject: Re: [PATCH v4 0/4] blk-iocost: charge flushes and zone appends
Message-Id: <179216089150.2070939.9793392159431285905.b4-ty@b4>
Date: Fri, 16 Oct 2026 08:28:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 22 Sep 2026 12:38:52 +0800, Tao Cui wrote:
> While testing iocost's weight-based throttling under concurrent IO, we
> observed that a cgroup limited to 1% weight could issue an unbounded
> number of flushes without being throttled: an fsync loop produced ~510k
> flushes in 12s with cost.usage staying at zero the entire time.  The
> device was monopolized while iocost reported no activity.  Zone appends
> were in the same position: the builtin linear cost model defines
> coefficients only for READ and WRITE, so REQ_OP_ZONE_APPEND is priced
> at zero and excluded from the latency statistics as well.
> 
> [...]

Applied, thanks!

[1/4] blk-iocost: add flush cost support with the flushiops model parameter
      commit: f8bc5c74d9eccc87d2e27767f92b8c11b3315d72
[2/4] blk-iocost: charge zone appends as writes
      commit: febdbf5682fa7e8f325b07a2c115e7632c4252bd
[3/4] blk-iocost: account zone append completions in latency stats
      commit: c38975c427cc3d3f6eb66a36143893be5cdf4ebd
[4/4] blk-iocost: fix stale comment in ioc_rqos_throttle()
      commit: 40607f9a6a5eaa071797481bd0ba5ea3ef1eb405

Best regards,
-- 
Jens Axboe



