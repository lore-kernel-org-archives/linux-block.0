Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B443D6F
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746209244; cv=none; b=palk6IprL52mD/QKTqB+TVd4GvEp0kMGsIZorpE3WBiYzGdynig6CsfT1oH/OksBoyqFQePxjVW+vpNdSqA+a9ERvzbsphUbfRn0lALpO0UH2n9sPxPen2JTdQ9zITCz1yLD3ogGlUpHfBbZpmDu6+1/8gSNqnefMdqQ4OZKZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746209244; c=relaxed/simple;
	bh=C3GFOz94DCedZja2X2S2MIT85l5u5tfuadlCFdEjVVY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Jic4HcGa1W1Y5bivHOjDrrgsnqESAdv2mkR+uHkZiBCGjlyWBX00XcIZSd7vaWyhfVC2t7ePs5ezHXoI/mWvi5gwihWUhzTfY5meb0P1ANGPn40LQBvCyPZ77bxIDkz9AVSrad7w5L6HMsL+vO5h7hKIcNKj54PJoNWbHUTewEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqeybK2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqeybK2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A42C4CEF0;
	Fri,  2 May 2025 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746209244;
	bh=C3GFOz94DCedZja2X2S2MIT85l5u5tfuadlCFdEjVVY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UqeybK2DJn5a8z1r72g9SX03UYGqYJQmaMldnsWcY6u91cm5/m8aRsc4Gt6nzl9W5
	 mCqTCC4ecBUnkiX51n382iGLfsd/YG5ll+qfcPFH7EtjfbeJ6ac0TQmC6EiTaKOVAV
	 KDD/n7Bdx5eAdZJmRm4XKmCaIKLGq4bx2FdjtMVzLk+k/fqLgGWMihfpiJ1qH7dqKO
	 Yv34meGAJ1ro7o+RUPeBsMNp91Gad350RV1Pbg3BRExTpmEp4clIHzc58SMrPwhYoT
	 oimZCKcqpJX8c8SVDBBXQ7LyFWk6FlBQcHg4hc+kqEytYVT9JhzrxVd/8per7B555t
	 8UyG9Ef2fJKlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71C81380DBE9;
	Fri,  2 May 2025 18:08:04 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <8f571ccb-f9ea-4bdd-8cbc-b87c158eac41@kernel.dk>
References: <8f571ccb-f9ea-4bdd-8cbc-b87c158eac41@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8f571ccb-f9ea-4bdd-8cbc-b87c158eac41@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.15-20250502
X-PR-Tracked-Commit-Id: 6d732e8d1e6ddc27bbdebbee48fa5825203fb4a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e205ff48fab413fa289f5381fdeab9e19940b7b0
Message-Id: <174620928310.3693103.1479177058977742795.pr-tracker-bot@kernel.org>
Date: Fri, 02 May 2025 18:08:03 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 May 2025 11:04:07 -0600:

> git://git.kernel.dk/linux.git tags/block-6.15-20250502

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e205ff48fab413fa289f5381fdeab9e19940b7b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
