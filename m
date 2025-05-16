Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00927FD73
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421801; cv=none; b=RG/HnQzufIb77wkvOoeTOumviagTKtOalTohQtoV205nWKmvigqv87heoP5uZIdU2/kwS/dhBKLvqNgjgVJpTFE1PyRAC44Q21omEIcfsEl156+jlBYBIX/MlX6WuCjPdasn7Q7iPT4qQcacX7Hp0MIhjXlvbRyFX2dnic7JOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421801; c=relaxed/simple;
	bh=/V4F+6oj3nezpGac8Y1mVPk8KgwRF9IKj9d1zDuNMlk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NA1rbP8DM95xCYFpetZ63kYjdTehKiIpeObQ4/+nsNlTopVYy/bIpqOO0WVor+Rhslzy6QBZZKJ5q3MMLdX/ir16vEbxrJdntvnRPUh5NlGqTKb6jgWBc98g4lYBxdnpBf50WCRyx+bMroTRpKNhr9YvwPWvocdo700PNTb6QtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDPkFMAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDPkFMAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0FFC4CEE4;
	Fri, 16 May 2025 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747421800;
	bh=/V4F+6oj3nezpGac8Y1mVPk8KgwRF9IKj9d1zDuNMlk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TDPkFMAAeORzWtAaNRMI9bkcEJ+MWlrnoG6FaZEIDgVpD5EN/gzGrYGs/eT3Ix5no
	 tbNG5ARGfNDi/Kjq1qT6T5uRsTEgu0CJ5OMZrAXb/wxzW5zPTF/fBSYPe7nGmE4QMF
	 LdD/0lyKIan/SLOY8WlRKhftjG/ffWIYnrX71+7StggDH8Krnry/KBV7MvAlavkxuo
	 7sKe0VU6m9rlhV7hcR+eseEeDAWN8tgil3qWIj9C4XQMI8Ln7jDQIaLxkU22kzTacU
	 wkpa8hBjoABrQ1tJwBmSmy1p11e2ShneHosF8xi+E5++d18X8WAIA3qVjQ2Q+vnTXC
	 EePfxTRSgLNPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF563806659;
	Fri, 16 May 2025 18:57:18 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.15-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <23fdc0b1-60ab-4875-9bc5-4b666fe2279f@kernel.dk>
References: <23fdc0b1-60ab-4875-9bc5-4b666fe2279f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <23fdc0b1-60ab-4875-9bc5-4b666fe2279f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.15-20250515
X-PR-Tracked-Commit-Id: dd24f87f65c957f30e605e44961d2fd53a44c780
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6462c247b27e35393dbd8eda251a071de9ea8665
Message-Id: <174742183754.4031545.13336526633151692080.pr-tracker-bot@kernel.org>
Date: Fri, 16 May 2025 18:57:17 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 May 2025 07:25:24 -0600:

> git://git.kernel.dk/linux.git tags/block-6.15-20250515

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6462c247b27e35393dbd8eda251a071de9ea8665

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
