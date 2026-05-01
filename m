Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE935DA78
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661020; cv=none; b=Yatp5PqXo3nAOWT2wrQQ/xCuONTMVXfvNWwtZYWeIaCSrRA5jc70PGwlacNd4S60p2dqhCwp8UOcIysA8wiCDi/E6+fi5hCl/MBLN84gC7KFZtayTz7l6iNaxbs5wBxF7brHD4fLBIpcsz1blkkN6DIgrN4BUzZhygR7WxppeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661020; c=relaxed/simple;
	bh=vTwO8EIAyQEoQe0ERynzB01EuYPlAH4cPjDt95QKl0o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E/Uxf8Pbv4ASc3jssAEu59HZyWti+nE9vuxRIhBFa/9a7I6qXKAnwu4DOQHBi/NBGchGgCYq/2VY9BftCRvGo3CokrtGqypTK/HYJxWMTu3N08l3CY0ucsjHUc/Og/MkypsTbybhitTqxQt2OH3Hblz3xIGy1LCI+Gjxp3ykGFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD4p/Tje; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD4p/Tje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6972CC2BCB4;
	Fri,  1 May 2026 18:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777661020;
	bh=vTwO8EIAyQEoQe0ERynzB01EuYPlAH4cPjDt95QKl0o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TD4p/TjeW5YBw5BHVq6To7Ng9F7GoVyS/C9XL6yTkgyPnM5aPTnU5RrWAOKgqQomf
	 E61fa6GzLIuZVLQF/VxRjvaBLqI9cTgjoN8wsA7U9nNbjjxgEe7GHc8E7anb2zY9BS
	 lmsohaLA1ef0GNmSFv7zBLbYPwi9y3svdjonY+pr2v/m4MMK/9jCN3O8oQK/YUg9oQ
	 +Wuurrc9I3I1pw0ZfPWwsBQ+kVCRfIgRYh+pXhjNYoKQFLJjGNyvkh/8TcXD2aXFI6
	 NjfN+1dCULt+fqOoT21E8xfZC9Eg0WVZDXtdWlUzFNWdip2Y7fGoHaGeB3tsZ3eWct
	 uzdEvMe4Dq9RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BEA380CEE6;
	Fri,  1 May 2026 18:42:55 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <8549b9c4-487f-4d3e-8b23-8e83297d11be@kernel.dk>
References: <8549b9c4-487f-4d3e-8b23-8e83297d11be@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8549b9c4-487f-4d3e-8b23-8e83297d11be@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260430
X-PR-Tracked-Commit-Id: 7e36e03d192a5547757bd8f9d9052a60f64e6d17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fe0be6dc7faf984599b1e356ead1c49b64ed3ca
Message-Id: <177766097356.3581397.10603012647537877410.pr-tracker-bot@kernel.org>
Date: Fri, 01 May 2026 18:42:53 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Apr 2026 19:49:46 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260430

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fe0be6dc7faf984599b1e356ead1c49b64ed3ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
