Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3E38AC8B
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 03:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949158; cv=none; b=FvIKssXaeNRtKrYfu7Yhrm4Qsnc6tvMj/j4mETfhYc3fqPSS1uD5muc5E6bokJox+v/jhb5J57rIHmvurDNwhoQ/qaoBj2tDBXxj3mM1JcJLTF7/se8xd2aY/uQRV4fiIY4pE3htKwJyBbCC5enxdZqbtoX5PgRc4/VvgbpqqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949158; c=relaxed/simple;
	bh=BnoLwqViMef5Sd5t5PCbinzXp/aVFcgIxst8Orqjids=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DBN/gD5+XxtjGoF2zglmuZVj4brHhyxz3vMfbRG/qyznZIIuvaUotgU5woQZA55/3jzleXazW3Mm25erJ35R3DnEv9KWmzc6T4qWkMxbJ8dqETug185fFNHgct0g7TSBxUHFpJnq/GlxjFK3H4NHwWprxn9sW7nD5wYl6zyPos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOKvNWeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOKvNWeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2231F00A3D;
	Sat, 25 Jul 2026 03:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784949153;
	bh=U+k0EtPQ5GA/GHTDSMGJ7xohOvxP6NiSdp49Q7bvKKM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UOKvNWeQ0Rwhmahaxwh32Yfy2Q8Wi3UwgDd5wQ8v4mWCG8kpULR5w32+dnKpoXJm9
	 z5FbNYjaTDTnbRQSHhuccSIT3+8MqBgbTR9WpwhXsZaW4mDRJBn7DlYk0sRZRkAIha
	 GPa6pVs4W/8EJVfDSeM8DeehYWtIWKxLELkHV8xdf3m/+Mg3azzorNtgrY1QglCekB
	 G+9WiIt13x4FVN82CIgfKAZKJ5b9zP+TSKoHyY4jtiV8FzMdPGOHl1ML+yLKyLFCZO
	 O9wcUOSMuZHNA+g83GJwUdhamycNLC/NZLp2/QhM/ZiiHPp0+DNFdynFXcfd5cHBQs
	 VRpODocPv0kUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DF5B138111DB;
	Sat, 25 Jul 2026 03:12:01 +0000 (UTC)
Subject: Re: [GIT PULL] block fixes for 7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <3f1dae20-214a-4b2f-b13e-2c996b31acca@kernel.dk>
References: <3f1dae20-214a-4b2f-b13e-2c996b31acca@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3f1dae20-214a-4b2f-b13e-2c996b31acca@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260724
X-PR-Tracked-Commit-Id: 093fbffe03f5c1bb9c10a9e5aa65b23250844403
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ce37745d4bfbc493f718169c3974898ffec8ee7
Message-Id: <178494912062.3393598.5722314186890666923.pr-tracker-bot@kernel.org>
Date: Sat, 25 Jul 2026 03:12:00 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Jul 2026 19:33:51 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260724

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ce37745d4bfbc493f718169c3974898ffec8ee7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
