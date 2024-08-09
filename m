Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518915A853
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224684; cv=none; b=alX5kGIbcYoGwAZg6PQIXxN5FRr20g/XtZN5F6CofFBNx1j3zgccp3yLh1fPLp8rg1WgEJ+trhSEeFtQ1omnI86ZCN/6SGjXjEMXybqYT2xVopWVFxJXuIDfzyI4e/+nAg1d3CWn6lkilFMT5wVdw2qDfS1y50S5+K2r8VpF+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224684; c=relaxed/simple;
	bh=STIyrd0dJ9eyVFYGdt+vwhxASgXRaVWpFJtNz//znmw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d3f5ik7STUW15JCxg5UEdBv5km9GLXbo5Ku/B7u3oDxjPOrCs5oX7p3mFhh63TJMLZVvAcYauqaSYX8cNzCrLWJ8sC6fHxr6H31GLems3GqLZpi+hEuYquudoppVEWyw9pcg/nxtfMSpwKR9hJrxU2ujsAGVaTMiJqBMG9KqMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npDHgaVl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npDHgaVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47EEC4AF09;
	Fri,  9 Aug 2024 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723224683;
	bh=STIyrd0dJ9eyVFYGdt+vwhxASgXRaVWpFJtNz//znmw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=npDHgaVl03cHJ+OGY5WGBzCUOXEy1n9i3HZIpKLPUmaFZMY+rz74huvCeggg1OLjK
	 uKvbPZ6ki3qv1H2SlQkq+/ADIrp4hr+V6AIy+OIlM6ZsoD8DxK/RG2MLyCHK1z8Lde
	 RuXqWxxEo/9zeRC0rnuAS49izfPphc7idNq8BxxkdkXMC5KTnACNIGuninjdY9rwfN
	 nDJNYv9VjZv3jwwwh7H2FCblgPOqkSXU6SLkoZmQaecOPLc8uEfNqtd4z1x2R/C0YG
	 hlLCXox+NwRgTGyL3J8fWehbsdo6KZXq25zNKBqbz4IFf/PJvpI/2wrWZVWBGN4A32
	 cfwBRDbdAh/Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE00382333D;
	Fri,  9 Aug 2024 17:31:23 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <4e41d24b-fff4-4ec6-b963-cc1b8fdf64a0@kernel.dk>
References: <4e41d24b-fff4-4ec6-b963-cc1b8fdf64a0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4e41d24b-fff4-4ec6-b963-cc1b8fdf64a0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.11-20240809
X-PR-Tracked-Commit-Id: eded04fe3bdad9b11bc82b972b4c6fa79f1726ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7768c4881d1b69bd95dad149d3b558c8e7de91a
Message-Id: <172322468255.3855220.9475691496268784788.pr-tracker-bot@kernel.org>
Date: Fri, 09 Aug 2024 17:31:22 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Aug 2024 09:00:13 -0600:

> git://git.kernel.dk/linux.git tags/block-6.11-20240809

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7768c4881d1b69bd95dad149d3b558c8e7de91a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
