Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9936F413
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822301; cv=none; b=o9tdjw3H4BbxunNUNNO7aHIjjTGy4t0OQ2SlmS66SplBzYYb3P6cX/Tl1Tnjbrhp+U2J/s4rxVD9Vlu7MEzIywPBuCpmBjEKUwGkLhxra/YPQJBGDCSF2azNw+OoIgljNJpd6nK8n+RDmXdB4CJ9bguNneXSp/V3tW+V4i+OFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822301; c=relaxed/simple;
	bh=9EO6ulHMr3YqHGsK4YpR9AgaoPzfQdOVd1XJ/D9DFbw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VDHB6ZHvu4Ms1FQO+sRcUmPyXm0TN108+iyKDw+b821A7ugwPH4vv7lN9gu6LLt2gjQiRtYjzxoeyzMbEv+NVShYbUMVp0DIXkMzRL60sgZNf0Turej1gkyMgaRu0merXW0Zam4CVS9ze8Nu+KohJZBK6gBqNRgas2pLDDgPqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN3szst3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN3szst3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA2C4CEF7;
	Fri,  6 Mar 2026 18:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772822301;
	bh=9EO6ulHMr3YqHGsK4YpR9AgaoPzfQdOVd1XJ/D9DFbw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uN3szst35MSU2RrHjnyOpTSP67IJLRW9BdCrc3QsXpcTqzkv7nCDsUNlgs0KPrTwv
	 DGECno/Pt5K1Rc5oqZnqhanzF/N6fBmfqethn0vNPT2i5Ow40uYHTPOahPZqZre1sx
	 eG2zwf/5qIk3mipIYmA5zaqYrYhtPDbuWTRGZG10KAgBP3It3VbHfECVOU5RlbSSP9
	 +4dExttoxC9LEt75SOMdbBniysNlHaUt0Gaif4f87m4N/7PiDZxZp/RYPWQOCeSiET
	 sO/C85mmYl7RFpV+aWM+HEOELySO7kxeXmBwlmtYq5JwuakGSRrcZNz5T+kbpK2lEh
	 1SbTpDmqchlEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEAC3808200;
	Fri,  6 Mar 2026 18:38:21 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <70536a1f-5d9e-4014-a051-f3a6aa7e8dea@kernel.dk>
References: <70536a1f-5d9e-4014-a051-f3a6aa7e8dea@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <70536a1f-5d9e-4014-a051-f3a6aa7e8dea@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260305
X-PR-Tracked-Commit-Id: ce8ee8583ed83122405eabaa8fb351be4d9dc65c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a028739a4330881a6a3b5aa4a39381bbcacf2f2f
Message-Id: <177282230015.7628.11969383729219971095.pr-tracker-bot@kernel.org>
Date: Fri, 06 Mar 2026 18:38:20 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Mar 2026 19:43:57 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260305

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a028739a4330881a6a3b5aa4a39381bbcacf2f2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
