Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609684FB1
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497350; cv=none; b=rQXav4TDIoq/fms5OAHxbqcNN3c/KgaddpmTCvshWtfUkR99RbuBZeijuKJvleVY05VVjX1wyi5OiRXH4HaEF3pxAMPWOkAxzZF/jelGsZXPIDEAuIoDlyrM0nhlRetbjC+wNVDIygOBGkKCGL1YM7E3aUztJzQ2DaaCUbObHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497350; c=relaxed/simple;
	bh=AsCZkFIduvbVLPrcn9m/tFdLlWKnOruw1gcwUu/2OAE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=obPStiyB9iLbpYTD/KwIS8Enpxm8PY5Pey6q2iTTMCf4sO1i5seMm537G2+i2iNX0m1LWPKixw25k7HdG3iMrGLioVnR8TSQyC4CpMWbfoD2k4LScZ2S60uf8AkjDvQqRWpTn/amaVGgFO3pWBvq53l98oM5NFJAqNlnqxdQ3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Htzn9Y7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Htzn9Y7B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A480C2BD10;
	Thu, 23 May 2024 20:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716497350;
	bh=AsCZkFIduvbVLPrcn9m/tFdLlWKnOruw1gcwUu/2OAE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Htzn9Y7BnvYGUPrbmRIvASwf0eRdlYLhdJk3VmCAG88na+21PIJsDYRPeKR+5xNWk
	 2N/IzWsSxwQ1xqAqjWtl4Q6+7dgVrDB6CW6m+tpibXxH4/3UXJGD73SDo4mnSf0BdU
	 HEGwwylYZBugmB2si27xqGGO0u0lQFLvwekyK43dIQiJy6OK7s6rRSiwPJKLoYm0x4
	 TsDFGJWvuSo/wXxjelH12HDRoP0Z/YfaupKSp9hTnCDa/RMev5YS5/qOrrEsUPWJae
	 gEI8c4q79UbCtGUO2pUVrE8JkabwX5QQ0NP1lFOaKxVlJ+lSh+l7W9csftD/4kt4aq
	 lgp408a1tD9tA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2038CC43617;
	Thu, 23 May 2024 20:49:10 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <9287b1fa-f8d5-475a-8846-47cf79b1a577@kernel.dk>
References: <9287b1fa-f8d5-475a-8846-47cf79b1a577@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9287b1fa-f8d5-475a-8846-47cf79b1a577@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.10-20240523
X-PR-Tracked-Commit-Id: a2db328b0839312c169eb42746ec46fc1ab53ed2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4d88a60fe0e126b245583c5003584cf6751e536
Message-Id: <171649735012.28255.6436887610308054080.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 20:49:10 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 10:17:18 -0600:

> git://git.kernel.dk/linux.git tags/block-6.10-20240523

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4d88a60fe0e126b245583c5003584cf6751e536

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
