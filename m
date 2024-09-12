Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE72C80
	for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183440; cv=none; b=VffXnBBzclVxkImd7CAc0C66oRMI7Q/nmaS1gGAqrzUx1ST5a5pXouJw6SFkw4U5JRkJSZLJ1WkI3bKBDNBrBrnUXazrnqVcfN35iLFtz52hCak3kJ45FgugX+yUciUZ+uvnyJPMX0HAwU6oDHkHVu8vv3kYdxirssESAMClKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183440; c=relaxed/simple;
	bh=XylahOa0ugzX86VVhc+dxxot85/sN5miQZoddUcXouY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Uhf/u3ha5JSB/5giVzdaFbr5MlJOMqhhrfMHckMqjD4ELWDVU2gc5fG4ZdJZP+011ULRBB1yl2nzbrmbfmdwe62cTUmQM2C83NXJilqaQ5Rd/EMFs8hDNbaXMiUYtq9FqWSig5D5LriBXihWucWBD1LLRp0m6uJWqGsee8ksu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6PuI6+h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6PuI6+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A391C4CEC3;
	Thu, 12 Sep 2024 23:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726183439;
	bh=XylahOa0ugzX86VVhc+dxxot85/sN5miQZoddUcXouY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O6PuI6+hnWw0ydQGtdpEp+NxYJbRf9Bn2BkqPQICGbnljxU1JE/8ALfmS4bj7+HRc
	 RM68EVHvYrWdmvX8wqdQxA8QklAFKt7kifBIfd7V7r2scT5FpIRN/VkOF9qMzv0UZp
	 FrGFDheDNH9zWH3kbvxtLcsvR5hxOBNzX8xdb4PEyGf2+JmJyWjiRrCdw7CC5FdEtf
	 E4+IvwkXzHOyEr6/eV9Kk1AlNOcwdZY9PlEA3qwFlZ/qswxWxZjwsu07IqCpSFWyiY
	 9eyWzuKgMmez4L8jN68Zqsiz1IoXhPPo7R/lNH9pmQk4el08tXx7GXyOIU6ClYME0W
	 0xYtrRTGkTseQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA903806644;
	Thu, 12 Sep 2024 23:24:01 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.11-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <c8f3fba4-9cc1-4e7c-baf3-afb10ab7605d@kernel.dk>
References: <c8f3fba4-9cc1-4e7c-baf3-afb10ab7605d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c8f3fba4-9cc1-4e7c-baf3-afb10ab7605d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.11-20240912
X-PR-Tracked-Commit-Id: 734e1a8603128ac31526c477a39456be5f4092b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8e7cd09ae543c1d384677b3d43e009a0e8647ca
Message-Id: <172618344057.1754175.11871114086252516000.pr-tracker-bot@kernel.org>
Date: Thu, 12 Sep 2024 23:24:00 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 16:44:21 -0600:

> git://git.kernel.dk/linux.git tags/block-6.11-20240912

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8e7cd09ae543c1d384677b3d43e009a0e8647ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
