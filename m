Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA58121CC48
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608200; cv=none; b=HyL2R8H+RrZWsJzww9ZVUgmotcv5b8r1Gjgb2Jd1fE6FDr5tY9i9hUzx11AwjjOqrmNuVIAbNdmHFvhmnp6RP2TBmgOZadUeXGoX1qQaTlnLgzmNDAIpnAFCr6Og9ex5Ja4C24FGpqJ1XY+PsMJZOQJonRmTxpiScRB5kdsfhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608200; c=relaxed/simple;
	bh=3R2SjKUNmP83/oGu9+yTDeKRM+F+zALV+Gawu+Nt4Zo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dsLF1D030e0Pg9wp6e+0z5lklwOLpHJo+L2xfjjluNjb9d6UpbopxNI0dxTfN8tWJczQGcpdDG6cabzSEFadeCBDqfI3e6kPeEC5i+hol3cbxxXWPsfK1rmJMro0gBVu87dCPF/bu4MUMXus0MJFoCU+aSePKpvzxGXfslgwbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aywB93Cq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aywB93Cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54A1C4CEE9;
	Fri, 25 Apr 2025 19:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745608199;
	bh=3R2SjKUNmP83/oGu9+yTDeKRM+F+zALV+Gawu+Nt4Zo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aywB93CqU6F81h57ImM3y9rJ8RwAlhHF19hJTDKHDu7ePPhasXRLV9vNMikOPPhRb
	 KdukXYw3TOKAvGF1alW6PNzeQ6j4LXLV1CGF5HV8G97EJE3gxsAG/n+dTBE9OXpavN
	 MXNxw7m7uL4XcFgxN8ch22hjPbxsm64FDMcxKY694IQdn8o92ucxxT4XS+5WVtKtS1
	 iGsCGfyVprMZtavxOr+JwLIpqcx41i5XLimY+rUfSvwo7+3h+10+aPXzy7LX+Azqht
	 Mi5kU2Ke1b6wEFII5oTEHHPAF8p6zAvxjwYqdBJM8bp0TPuSJ6gpy3/AGWpIga9A+b
	 8XHOk07rpV0Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEFB6380CFDC;
	Fri, 25 Apr 2025 19:10:39 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <011eb55a-9a9e-4d59-8efc-8b51037fc306@kernel.dk>
References: <011eb55a-9a9e-4d59-8efc-8b51037fc306@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <011eb55a-9a9e-4d59-8efc-8b51037fc306@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.15-20250424
X-PR-Tracked-Commit-Id: f40139fde5278d81af3227444fd6e76a76b9506d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7deea5634a67700d04c2a0e6d2ffa0e2956fe8ad
Message-Id: <174560823866.3807435.4585818399154044396.pr-tracker-bot@kernel.org>
Date: Fri, 25 Apr 2025 19:10:38 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Apr 2025 10:50:54 -0600:

> git://git.kernel.dk/linux.git tags/block-6.15-20250424

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7deea5634a67700d04c2a0e6d2ffa0e2956fe8ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
