Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CAA3D561
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126657; cv=none; b=COBUzR4D2yiLENnNRaQVeHJ8+HPwuJkOBsJKJhmZ2kn7L8Qhj68DYdOco8KJrNAlcVl+XuhYs5c2BR9+1Y/KNtbmmRQhGhEc4AXo/K2lQwWl5o50kguVl38VBA/ovgnfKB9abX5BDClCcOrIiSi95smETExyM3etX3zblIoOap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126657; c=relaxed/simple;
	bh=nEfpgv9JNJbaZ9ZrJj0AmRxV8fwUJHgrNj/LxpXCj7A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Z77PTi+yVInhgMCV0b0OEwdA/xbR3RucrPDU6T2Enp9gkk7p4/MUrmTUtS9V7F5sQ1QM0WiVbbwbDIiyDMlKhUrbJswNSRSaXTRN86KFgDau0+wk/jdkr4wMOCWbSQlqvqhH1fxqAmvtOZ7oG/SU8h103mgOcdgGcToTKAbPq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4nhFBJb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4nhFBJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46C0C2BCB4;
	Tue, 14 Apr 2026 00:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126656;
	bh=nEfpgv9JNJbaZ9ZrJj0AmRxV8fwUJHgrNj/LxpXCj7A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H4nhFBJb0f3RWmV9Z7T5h1H35qvVWgwhlJYTkHLzR1Xfeu3Kj2GQeCHXyRi2nAEZu
	 QIJwJHxWOEGHtZ7d4uUxnHX5PV5YID+/yblXSZ761Qc1EU2r5h0e5DHrqRoYlwiH9C
	 1zsUqfv/pw7sWW4YtdotSCgYV37eslbMtVDxHkCtn5v6LSOF9zWEIWtBamalUKwXVC
	 mtH2gHr7tHtaH8Wx8/ZRE+RY3zuIycYTOgnB3pEbR/QerIEKBsXbK25ihVqR2va4WZ
	 hCJQBCqiduWanP3PuzazQWzGWuQUTSlCsXYZRZbTqA5y7qMTgmAk9qQBBwUn2MuUDb
	 xxf0yiarv8pGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FED93809A0B;
	Tue, 14 Apr 2026 00:30:29 +0000 (UTC)
Subject: Re: [GIT PULL] Block changes for the 7.1 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <d59c7b0e-1cc8-43ae-89aa-ca37e08387f9@kernel.dk>
References: <d59c7b0e-1cc8-43ae-89aa-ca37e08387f9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d59c7b0e-1cc8-43ae-89aa-ca37e08387f9@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.1/block-20260411
X-PR-Tracked-Commit-Id: 36446de0c30c62b9d89502fd36c4904996d86ecd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fe6ac157b7e15c8976bd62ad7cb98e248884e83
Message-Id: <177612662809.619168.8660881948475696230.pr-tracker-bot@kernel.org>
Date: Tue, 14 Apr 2026 00:30:28 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Apr 2026 17:40:24 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.1/block-20260411

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fe6ac157b7e15c8976bd62ad7cb98e248884e83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
