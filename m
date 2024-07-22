Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06E3F9FC
	for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681103; cv=none; b=W5WXcFkW+S2B21f3SY4IOCV3Q5Mfa/udwsdeHRAFZXBK0cY8b86ybKvg+WlghRnAYgHDe5AiMu6oumoAvPdDt0oxdH3vtTJCN+4ZTp9hjZUYM9XQqFwdVm/Exh+NFu4BOQkATYdLI4UwKBR+q7Nb6VIX5N6vPGgMkQzPOuN0nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681103; c=relaxed/simple;
	bh=YUD+QlCDRaF3XucB76Q1+TT+4GoATYhdwLHXlM1tVdo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MAQarSO0j/dp3QVImLViueY2eFtMuxYKvbaqzVOCog+a/3D5Ju7tYalElmx/ONyORJ3NPbyET6fjHDOBoZxhvfhDnTsYWkabPXmikZq7IZIFRnBRczGxjxhb1onC97BG3EK7Se1WISjvnP292JWbOFk6z5GXL9MHFCCoNYZfFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNY3fFvs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNY3fFvs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DFB1C4AF0A;
	Mon, 22 Jul 2024 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721681103;
	bh=YUD+QlCDRaF3XucB76Q1+TT+4GoATYhdwLHXlM1tVdo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vNY3fFvsU8zxQnOip3zbc1X54cQuicNfjo8k0EFGVd7/qb/j8mrVqSGHrkklHkUYX
	 nw32S/3qAQYMszKWXksk/tlHEKdb9ShKKnfTIhFDJX/jAysYO/uKA/4fZM9sJ6zs3a
	 fBvRrE07oe6JrwvQctoG7/ydohRNyCghWrK/FdcRAHjV9ifpO2xXeckkb3dG6qVmh0
	 WmBV173vlk/TYu1gqyRq/RtBJ9nclKZbeGJ53GGDjsOs8Llyc/j52pJOe0Vk6E6W+9
	 r+ME+O4kmuMyXJCiLbMiH/YaOgsjjZQ+9rWtxroqh6+DpJ5uYbd1wTtFF9V28eAMu6
	 Hppgp6ZmSMSdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 602EFC43443;
	Mon, 22 Jul 2024 20:45:03 +0000 (UTC)
Subject: Re: [GIT PULL] Block integrity mapping updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <5e4f743c-9919-4c9d-92cd-2bfabb4ff35e@kernel.dk>
References: <5e4f743c-9919-4c9d-92cd-2bfabb4ff35e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5e4f743c-9919-4c9d-92cd-2bfabb4ff35e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.11/block-post-20240722
X-PR-Tracked-Commit-Id: 74cc150282e41c6c0704cd305c9a4392dc64ef4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0256994887d7c89c2a41d872aac67605bda8f115
Message-Id: <172168110338.32529.10251041107732563742.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jul 2024 20:45:03 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 07:52:00 -0600:

> git://git.kernel.dk/linux.git tags/for-6.11/block-post-20240722

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0256994887d7c89c2a41d872aac67605bda8f115

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
