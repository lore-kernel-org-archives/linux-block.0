Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB8154429
	for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733010792; cv=none; b=dRroIfnKLoVI6sh6Pe1fO1DnlPTcIMyEYEDperPSePpy2S22W4sYmp5zhvCjqzgmtSGhoeWZdACjvCDXd9P+hOk5U1Or3NGSX4dMbFUR2XlAgtIEc4qBFcxgpyL9aXFbDCWsK1+TjfzLw/2WX2Yz0J29thOjlcsAvd6ugnrd3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733010792; c=relaxed/simple;
	bh=3M3EVbOUJspyUZzgctcw8Z2gi34VF+pjNhsJ6crcsN8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pn7QXiyRq5zKQzIFu3GZOepQpeQy3SoOoYiTDsT3YWcjSJ55j602f8haAJKLgPIHIt7ob63U7nBGN6ntKyUvOUzZby8bqdyUEzfkl/AfmyPwXR0qSxxmk3FE+oyrhhV7ppOKKqF7LXsPgcFkeb79tInxo461UogI/DKBx2hzVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVkPpxF/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVkPpxF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AFAC4CECC;
	Sat, 30 Nov 2024 23:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733010792;
	bh=3M3EVbOUJspyUZzgctcw8Z2gi34VF+pjNhsJ6crcsN8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QVkPpxF/tuRwZCxpk72S/tWx+e/Z1U6pl+oZdtJxVYEj1iJlWDDNb9WWw/t3Xxoxv
	 ixW2wr4XDMZtKYwJsL4TV2y854+Bg0jTJi4FfULY/6Fa0acz5a11QtE6kTzvnIWLOK
	 KMqMwKjPm7koexD/6R39Ku+Ofw2zS8uv1FAPKPfVtuZvi+56j/sAfFVO/nI9+H6aM9
	 CgBb2ktoEPewtm+WcCizazj2NvA8Zvn0QxxtsiwBiKa1Hkyg5fzVbamuvaFXIPRndf
	 W2s71O/T+u2faQF3BTdl2WqG86YGJ1s7DNjrMW6PyDjBdsmfx78FjKkn+uG4/033nt
	 RkBTAUeIWv8Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE0380A944;
	Sat, 30 Nov 2024 23:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] Final block changes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <3ffcb344-2ff2-47e4-8c53-a5b6d6b9a0f1@kernel.dk>
References: <3ffcb344-2ff2-47e4-8c53-a5b6d6b9a0f1@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3ffcb344-2ff2-47e4-8c53-a5b6d6b9a0f1@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.13-20242901
X-PR-Tracked-Commit-Id: 82734209bedd65a8b508844bab652b464379bfdd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfd47302ac64b595beb0a67a337b81942146448a
Message-Id: <173301080561.2511415.2512191771183364742.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 23:53:25 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 09:35:06 -0700:

> git://git.kernel.dk/linux.git tags/block-6.13-20242901

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfd47302ac64b595beb0a67a337b81942146448a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
