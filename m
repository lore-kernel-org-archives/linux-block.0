Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C824A078
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766778802; cv=none; b=iCxCwmAaR+MBcsZGWTVf2bxN/jJO/aFvg+uAWJLZSbh7CcB9FXUVMr98W9x/2U7RCKD1v4Fi4cUXS9MYNukeEeAt8bj2r/Ty/P2tRL+mJxsjQim3LHoS7qr2F1qZuDxBE71svH6C9Z3OIDyaykQEIynjaVuKeYnHRSGwcunf0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766778802; c=relaxed/simple;
	bh=k/+rNP4dWfbDoDRrfhq1+DVNaDj6ar8OLt+6kr7CyE0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IhjmuqXdbB41oN4R71txZ6wH9jkoVStdNzAvGU/6mQP8ki8GaR8/fr52og9uvNpo8P3v27aAMxucDGz8zFx8SM+Oj8lPIab3K6Jcc7RDx/nnP2+/vM3hIjq4E6qEt6bUyS+ZpLVERyxF0kxAt9khbWzQRQlIdt4B6/vsD4fwlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQlbwDml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQlbwDml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962BCC4CEF7;
	Fri, 26 Dec 2025 19:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766778802;
	bh=k/+rNP4dWfbDoDRrfhq1+DVNaDj6ar8OLt+6kr7CyE0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aQlbwDml+WmAQczXVx69Xhz7aSP93z0nhK5gxSjdpt0aA75fswTPN0MHJsrXBuyx/
	 JydE0CgBJTDV8qWwHtRqA/APnOB+BYRm0gnHnLdv11I7b0tPaCQ05W8QnCIb/TPAM3
	 eD3oQHzCO+y6ejf+bF34QZ8CqUOkb9E06SGJeyA9gRRAHmy9r6ilrAyo/IZ/cMEcB/
	 OiPioo09bdSXEBrdibND+nDBBaPDiSUqWLoI9HioT96kf7J/7JOMeQoRcj+S965iJ9
	 M1iCAWvlTy+8qj7OMAKRxV84WHtCE6ibaZmKuFJlLlXuQfj9PPHbvPK62F0Ylqepqt
	 zI9hzH4Yhla9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B77B380A959;
	Fri, 26 Dec 2025 19:50:08 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.19-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <b136d4fd-a686-449c-b2db-71952cf29ac5@kernel.dk>
References: <b136d4fd-a686-449c-b2db-71952cf29ac5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b136d4fd-a686-449c-b2db-71952cf29ac5@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251226
X-PR-Tracked-Commit-Id: 1ddb815fdfd45613c32e9bd1f7137428f298e541
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f0e9c8cefa913dd9bd1d79b9a68896ea130f106
Message-Id: <176677860672.1987757.13023947523405785281.pr-tracker-bot@kernel.org>
Date: Fri, 26 Dec 2025 19:50:06 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Dec 2025 09:12:28 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251226

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f0e9c8cefa913dd9bd1d79b9a68896ea130f106

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
