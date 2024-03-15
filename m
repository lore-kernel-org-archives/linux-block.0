Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90D56740
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710539947; cv=none; b=k3OqSWkRZU25KqnE0eJ3Jybvb86r063nAC8RtOmI656KhZs1UnRbMhOLNsK6v29QMQ/89w6tJDhrNOtopNnvPWthdDdC1c4IYTbHcJaGd8/kvmJp4iVf5psdoJAaf1o4Gn8c0RC83k4YJaKWOKspjVas6jlr9RmXwYnczSz+jxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710539947; c=relaxed/simple;
	bh=uj4ixObrxLwIfiJuEMBLvHGw3aZPlLqdTIGYx4PVrxo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fBWRy/rgrF5vAQk6/1oEA4P6bM6Nw/mtQ+tNo+52QXtmcZUXDAusN/RAxRldAPJj4EcOmaosQOBvG6sA6rAa3dQtabj5HJDyuB9wPmqVrUHuXHHQU/1UW7yMQVrvgB5Qi84AgWwktAjcg+r50tpBiZQ1VwJyZgIhpy5hwxMJKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJSSa3Ns; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJSSa3Ns"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F04BC433C7;
	Fri, 15 Mar 2024 21:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710539947;
	bh=uj4ixObrxLwIfiJuEMBLvHGw3aZPlLqdTIGYx4PVrxo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nJSSa3Nssnb6C+xJHHQl+pP6ywIHJ/3hJ/rIkhu+y7gkPh6w5B5h2SYdpvs/KXeq5
	 vGEXa4c/iUrfHujzQTfINguXuqAWJkbKFfyRkZFSID9VgETi2to8qv5D66IBIvGIfP
	 e586ue4hrHUb+y3W6AOW1pQi8gaejULXzyjujcYFkYQdW2g/AjX0SDfH7uKEjwOFom
	 YTR0pK7ZgOBrbjP1otmnWo2162lwtDT6yzYCmV44VrkS+0vk4Lc1WiHuUS9XPW5meX
	 AC2IWX58dsoJkGrmaRoi1dzk40LXpYyt0peGgP2F20X1NmVix7PA1LTazxE6UgJys1
	 2M8b9wXDkpOpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79B87D95053;
	Fri, 15 Mar 2024 21:59:07 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <83595457-f418-4aab-a578-274a78817d44@kernel.dk>
References: <83595457-f418-4aab-a578-274a78817d44@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <83595457-f418-4aab-a578-274a78817d44@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.9-20240315
X-PR-Tracked-Commit-Id: 4c4ab8ae416350ce817339f239bdaaf351212f15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 277100b3d5fefacba4f5ff18e2e52a9553eb6e3f
Message-Id: <171053994749.16900.13863315479099967909.pr-tracker-bot@kernel.org>
Date: Fri, 15 Mar 2024 21:59:07 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Mar 2024 12:55:13 -0600:

> git://git.kernel.dk/linux.git tags/block-6.9-20240315

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/277100b3d5fefacba4f5ff18e2e52a9553eb6e3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
