Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BEF11CBA
	for <linux-block@vger.kernel.org>; Sun, 19 Jul 2026 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784479556; cv=none; b=ZUcexjHIzDhUZ0umVRjA/KrV0nHfBJH8WcGiEtrvex5QLaRHf834wJDvKjmCBHY1pRyfwzC/hDUhgx4T9NHVhA+WvylvpLFGfFAt0GCnq6cC1p3Pncr/cKFbzcwsdnWAN9xbEh87L9Lr7pXQfubCvc3k8XamUTf41TEB3eTM5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784479556; c=relaxed/simple;
	bh=a1WS7toAYXbI3ySMctumElN+TxJl7EpEoCaclxJISPU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QWupQXXBXWiVXcczKLutKSRVr0Kvw/Pg8zJ12KQTkVNY9K/1YUt61uHPCB77yhBhK0qVUS1T6XtMhW+qI3zOpCA7yqRYj6sj0Lb1SOmNPmfBx5ntj/+dzwIyorYVOSEyHb3GvnBTaJtWOKeaoxUfJdFQBbCpxZxa8kOP4EyMX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVOqI4qV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVOqI4qV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289901F000E9;
	Sun, 19 Jul 2026 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784479555;
	bh=smusKG8h3mE0UE9G9BivYMKA/lx6f3hvNlmRZWtIUsw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OVOqI4qVpDSfq+zYIHRPhA+OawchJgU3t3NB2dqVs2DmyJWdcsmGIwA4TWZ33cckQ
	 IVF2NNpHRqkYRJb0QDVc6I04cblJjFJnxvfH/IwcMuNids8XKacRdIPMFcGxREr1G7
	 yXuv5vlnZIH47p/KPZNmnmH5Mf7E3CtEeY2f55t/2JVOo0axsbIZFKkK4ugnAVvL2J
	 9NrTIEBo9QwzOgNBdrIBw8mpwzaMx3MsNW4vTYO9LFRJ9xQRvHByZ7aWn6nyHIFEhH
	 DNpSJR9gGEzKCYOaqbDGZjXWWWphzUaUIeJs+3c3f/02bG9fLK7tARvUYDjgxjUofe
	 oZ2oO3zHyzJ/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A1038119C8;
	Sun, 19 Jul 2026 16:45:27 +0000 (UTC)
Subject: Re: [GIT PULL] block fixes for 7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <5edc8456-eac9-4c74-bf29-48a9ee333bad@kernel.dk>
References: <5edc8456-eac9-4c74-bf29-48a9ee333bad@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5edc8456-eac9-4c74-bf29-48a9ee333bad@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260717
X-PR-Tracked-Commit-Id: df308a14585649f7683a560f5c94978ab4f8224d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 980ab36ae5972c83f683b939e50c469c4947229e
Message-Id: <178447952602.2771094.13288395334646988700.pr-tracker-bot@kernel.org>
Date: Sun, 19 Jul 2026 16:45:26 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 Jul 2026 08:41:23 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260717

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/980ab36ae5972c83f683b939e50c469c4947229e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
