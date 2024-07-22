Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691A45BEC
	for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681103; cv=none; b=nfi6DhCJ9wZqTdhyrBhGRJkVqTgl0w7A2yc1dt6Rr9qxaYOggMdUIZxh7ZfTOsIlszvQyomj0mR/zo7i1ShnoNAvpb90txWeglGvqvEWl+ajzKJC7wYXrcZMASjXHQkyPjIgqme+xkScqsph8KMk5WvrVH8fIKhE5LJHLvanpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681103; c=relaxed/simple;
	bh=/I6GzYFSuDhN+R5nc5i/5l0a2VGud4e7J60ooUYD8dU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LtI3rarOEJ68/iIsMbqR+HAjEHXq10BnvEAHOq7Ll9UT4Lovt0G6EgF19LovfFxExtw+s0cNGlI5KpAed41tmSBNDWXv3NFa7/N0lAl1Xxyg0HXf+Fcew0q2fJtAHebKiZffE98H16hRVf9XU+r+JBrBEvPEzqIDBPrx1UQe0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ1oIYPg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ1oIYPg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9699AC116B1;
	Mon, 22 Jul 2024 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721681103;
	bh=/I6GzYFSuDhN+R5nc5i/5l0a2VGud4e7J60ooUYD8dU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nZ1oIYPgyc0CxEBhwzlzbklKKNRLyNykR6uchaa6b1w8cCt6kNEv5AxRlLnTx8lux
	 yqT66PGD0i2NBDL7+6Vul/EJgGhIe6NAUsItnGVEAHNgFt/CjfDjlVW4VyqzkyUM+q
	 gsN13XyYkBjLMgK4XqbOZDcLbpdx4QvAdPCePMbt2AY71vIWcBXgwYh+kHe0YhgB8O
	 MQiXNB1dbXZDLCSBO9rxzJ3QTQnhcP077GL4R4izAfViC7NIPBgqtk6nGG1uJmYCdd
	 TfHrEVfHhMzTNl0zkE/7kuKZaDllbqcMMptxGxE4b4s2a0yZUtjI4xueIbJc+Zjzud
	 XVz9hpk9d9zng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B21EC43443;
	Mon, 22 Jul 2024 20:45:03 +0000 (UTC)
Subject: Re: [GIT PULL] Follow-up block changes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <505fe3f1-27bb-4791-b4c2-12c99d0da624@kernel.dk>
References: <505fe3f1-27bb-4791-b4c2-12c99d0da624@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <505fe3f1-27bb-4791-b4c2-12c99d0da624@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git for-6.11/block
X-PR-Tracked-Commit-Id: 89ed6c9ac69ec398ccb648f5f675b43e8ca679ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d080fa867092c1db078dd72d70cb256642f7b18
Message-Id: <172168110356.32529.6353199337698383309.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jul 2024 20:45:03 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 07:57:07 -0600:

> git://git.kernel.dk/linux.git for-6.11/block

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d080fa867092c1db078dd72d70cb256642f7b18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
