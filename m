Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B5327185
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650595; cv=none; b=fIB83LpG/8itKceSSfH/GPt0hDniJMzg+F414ydWN1QrvQ3lAbJnihXZHZfE6fWXvbOwTsSlA4Tp9xnOWCeO80T4V9J93eWP2Gq5IZ+G+RSVphbRFHgndX5trUrWy7XEf6N/LPzOhDjmBsHBYdwluCzBWRQHVMVGgKNk9w9hVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650595; c=relaxed/simple;
	bh=AL28R5C8wuUFgNaOVpWFHgYjFMqmYvcDP7BAmVefvuw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DRR4rHU7AL3v3dT/1sDit9xNpphOheg24kPIAVAFpttIT0lD5ApC8ZfbC8v5ZDCmZQ+ZQ0xbFFjTmfhKY/Fbsa9TuSBtP93fDWDMKR5NWvGmD/29w1V5lt0x9Ge2CzL9Zaf0PfkkjRCzjv/jEeohvwGytZiJkK4bME3p98odvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTC8R89E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTC8R89E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721E0C4CEE3;
	Fri,  4 Jul 2025 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751650595;
	bh=AL28R5C8wuUFgNaOVpWFHgYjFMqmYvcDP7BAmVefvuw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZTC8R89EF5APJZfVzUIuVrV8AHC1hD1+CjsxJBwXqePna23IxbK9I1dqPThcH4LD3
	 O558RbGknvxkEQlgCz2fC/X3BfBVDuMYnsyl/l8e7iydYXOjLWG5TfI916+GFJh3Ic
	 3Sl8j68gum4hVWED5Brf/cnxZDUpKpTvXjJdnkX/KDWH0jSGA/5MBEIQvDW04Wkf+W
	 eoAgol6wGaAC0DE7kMu9BDKGbFYThXgtWaR2mCd3X3gegQ02fL+/tihOl6mL4MqK3J
	 8G/S2j6fAqhm6l3/I0zC1bh4N58gerBjoSZvSAy5+LOZsTD3Z+2J7EiZxbivcXmmHd
	 vOi1F2rCH9QjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC0B383BA01;
	Fri,  4 Jul 2025 17:37:00 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <67e6b4d7-0eaf-410b-94c8-a9ee2cb09de6@kernel.dk>
References: <67e6b4d7-0eaf-410b-94c8-a9ee2cb09de6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <67e6b4d7-0eaf-410b-94c8-a9ee2cb09de6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.16-20250704
X-PR-Tracked-Commit-Id: 75ef7b8d44c30a76cfbe42dde9413d43055a00a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1880df2cf44af6266b48a905596726c267bc2b04
Message-Id: <175165061930.2287194.7956584572134314266.pr-tracker-bot@kernel.org>
Date: Fri, 04 Jul 2025 17:36:59 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Jul 2025 09:34:17 -0600:

> git://git.kernel.dk/linux.git tags/block-6.16-20250704

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1880df2cf44af6266b48a905596726c267bc2b04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
