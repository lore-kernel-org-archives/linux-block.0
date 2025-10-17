Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB130330B0F
	for <linux-block@vger.kernel.org>; Fri, 17 Oct 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716490; cv=none; b=fdUl6k63YCozB5mtziQzs0x6ImoD3id6kWhLx17Cyf61a5ETRHTbZ4lAlbrbxiJS6z31rmTJoUYB2MAsw1+NM9Z7yOXiPqLKm4AIlAWvJ3CzTAIYY/7nZzHFAZR2IyAnjErkyxUw1BACj0nR2G2e/356sEnrv9qIuYYDfX4IBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716490; c=relaxed/simple;
	bh=IL1vCwP7SivDOPpl12UMsTaWSKnAvnWydUYw+d4vtJY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C6YVGD16V8EHHnDYY+L6SJmkNq0eC7tkiXzeB4RQhOPgN9kkM01W33FNbHePRMbtM85ZD3mkP1xbX3TvDKUPxvqRNYyZm2asxsuAGlsqzQ45vyKaq7mMQR/0MCpB3A186Mgzn7RfwY6G4zdwNyKBHY+2Uv3W80FFpRyG87UNnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ7jLG71; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ7jLG71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1FCC116B1;
	Fri, 17 Oct 2025 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760716490;
	bh=IL1vCwP7SivDOPpl12UMsTaWSKnAvnWydUYw+d4vtJY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eQ7jLG712RL+kgK/RZL/PnZ/xG4NxVUKxOyy3SA8SsnN3ndj0Sd2sxx1ppZWQttMj
	 MFLm5cbdQ4hU67sJR9hnT5D2P/Q8DR5l00JN5WXnDfhQYQdbJBtDNebnUqvEoJcMsZ
	 +CUttBaGttN2uu5MtAKZ+bqlJ0+xcKHBJm6jBktcROTrprswGGBpB9xdIrxowW1Ix7
	 fQalTV8Fas5iX+poQ0qEaUSronvPhTmNa/iyCQtQHqxBLRnr5rzL7TzKu6etITjzNM
	 6b0CjVP9DPxjUaabOc3k4cu3o9fiuSNkkiZHkC2TKX1b1/OlUdUr+jCe1E6TDmkPE4
	 p2zJkipS90g6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF8339EF97A;
	Fri, 17 Oct 2025 15:54:35 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <f771a6b5-c524-4b69-ad07-bcb77cb3e334@kernel.dk>
References: <f771a6b5-c524-4b69-ad07-bcb77cb3e334@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f771a6b5-c524-4b69-ad07-bcb77cb3e334@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251016
X-PR-Tracked-Commit-Id: f0624c6646435c1b56652193cce3e34062d50e3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c8df15f758a69a7bf88ecf9b7f95dc7db2c463c
Message-Id: <176071647421.2681700.18002448492740315562.pr-tracker-bot@kernel.org>
Date: Fri, 17 Oct 2025 15:54:34 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 04:26:24 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251016

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c8df15f758a69a7bf88ecf9b7f95dc7db2c463c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
