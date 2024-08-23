Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C681C8FD8
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457323; cv=none; b=OcCtsUw+KL55UeLHoBXhgkPoVEn9FoGysoDq9dWajuwi2+M5ryj4B+/hzT6f7b5rq2/DMuGuXoJSrH72CbxyxAa0vQgNxGIlIWEEAjIysYP7/6vKwgkVq6Lgd4K7EeePCe+Uvi37U92KU2OWCpwo//autqDXkHQBGyL8GRrGLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457323; c=relaxed/simple;
	bh=G60Kz4zGjpNSzVHBuhMooQI3nveJVVpSiCUbe2YvRuU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E+OCioN5jFmJk9n3i59EdqGuu73oWx1J4NRfr5GckKXx2Qu72/IE5fSxBwiDK9i+Sk40yGDa81iTaoLG9IA10z5FyLMq1JsuavemQFviDc3dh5F0ptpGMnOASlWOolo9iR2oZiKGdZsFhs00MLnNHkyOQ91BHKyJOeZjyhvMuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFLjNN2Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFLjNN2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9913C32786;
	Fri, 23 Aug 2024 23:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724457322;
	bh=G60Kz4zGjpNSzVHBuhMooQI3nveJVVpSiCUbe2YvRuU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CFLjNN2Z+5C4Z+mhLqtldOMqHvXLkT8Sh4C+Yb/aEf+vvQ9ABjFgEqFOe3QCndunw
	 XFRqd4jFX+zpErZuM9puETZ/CO5kIOcDZfv3NPj4ayS3pnhtmL6XR0Ek5T9NUAS/zI
	 /9bvfFPMKu0MS16tahZfTnPmWYjnxOqqwH2h8U+/BvaJtWdlN79QJANaLxuATYDatj
	 9L8q7xeVDKcNnbGYiSPM6VyZzzI3r5xTSrIGL7g2YTe5BwcOm3kR5GBk6IMnQg8edJ
	 MUiZu5HqIBHmYRioq9E8j9Yec9v0GwOXFb/JZOdqFvrhtqjCvM6hiRLLi4dNFtMfNL
	 J/QwE8TiE+Yxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD963804C87;
	Fri, 23 Aug 2024 23:55:23 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <05edba4c-e219-46b9-8bb9-c4d71f859869@kernel.dk>
References: <05edba4c-e219-46b9-8bb9-c4d71f859869@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <05edba4c-e219-46b9-8bb9-c4d71f859869@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.11-20240823
X-PR-Tracked-Commit-Id: e6b09a173870720e4d4c6fd755803970015ac043
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5afaf917e802665d67673991974f5bc204dfa11
Message-Id: <172445732261.3115107.13158010522336321295.pr-tracker-bot@kernel.org>
Date: Fri, 23 Aug 2024 23:55:22 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 09:11:45 -0600:

> git://git.kernel.dk/linux.git tags/block-6.11-20240823

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5afaf917e802665d67673991974f5bc204dfa11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
