Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB607EF10
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711137893; cv=none; b=W1R/Cc5KbAQ7jje7hyvRfBLiBHDjHNqtKMOjr8zpwRZoDBSKFvmTHk9kdQxrjkj/ysXClTbINsZyheMWWAuD5hEYQFyh+4W9i9RX+ZOpGdv23/SvnePcBYc60PbLX5q49Wba/I6xK3j5+I+omK8J0gLFng0gvAPJGRX91R+Yy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711137893; c=relaxed/simple;
	bh=cy27tsKHOEFBChfBvL7PbQZp0DI8giPW75N0aQE2vrw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KfZxq2RmjbeayulA7Pb6LARQOUs370br3UxOkkiTBSihbhSR/ARkM36dmg32bQlsfEfs6uB4fZgwR20z2cg15Jjan7OAj03DRe0mhC8n/BxUVA4lNVIM/FgsXSXBkQisaTxzmKt508d8BlocU+1UnhiwAXuNoZ9sQZMM5Q/X/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frhE7fUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frhE7fUk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B799C43394;
	Fri, 22 Mar 2024 20:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711137893;
	bh=cy27tsKHOEFBChfBvL7PbQZp0DI8giPW75N0aQE2vrw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=frhE7fUkQzLIIPhNd3AqzJDefso2uY/00cUWfhgMCXJHet3UWQh6BOnZOamwAZkTQ
	 ko0ivH3fNYkmbrqFZzvzuLUuxecA0ZcRVLKtMP1l/CA3yna2JjN4CInfEERzTDBCuy
	 pwI04SCvj8HUEWQ1vLv1vUi1kLJEpFXJNL5TkMu85pmqeOeZEoAAtQMVXJybk0ebqi
	 n0jXJg/niumiuZFlTf4c5Jbl8ol1jL7Cc+wowL1zoi42nMfCXNgVRByrkNHxCiIsVP
	 PTlcwqxGB4TCwwv2BJCRyRn720Hw2+jsfZHKwdCRQN3/hKl8x24MMzJIigERl60YoE
	 JciHa2TuEJ+3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82F23D8BCE2;
	Fri, 22 Mar 2024 20:04:53 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <64206ee9-68fc-4ff4-8b28-a9fd0e09aad5@kernel.dk>
References: <64206ee9-68fc-4ff4-8b28-a9fd0e09aad5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <64206ee9-68fc-4ff4-8b28-a9fd0e09aad5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.9-20240322
X-PR-Tracked-Commit-Id: 07602678091c0096e79f04aea8a148b76eee0d7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3111d9c3f7250309f451cfbf55845a74e692d41
Message-Id: <171113789353.14477.272322132352747422.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 20:04:53 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 11:09:10 -0600:

> git://git.kernel.dk/linux.git tags/block-6.9-20240322

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3111d9c3f7250309f451cfbf55845a74e692d41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
