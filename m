Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBA241103
	for <linux-block@vger.kernel.org>; Fri,  2 Jan 2026 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385368; cv=none; b=au1ZZHw0ngA3J8nVu6WBkjGvyNwiNw6FQYklZU6FhxJh6ZnIDtX5bqzDkgEzzWIliPMNfYh8VJwTIKnEQgyx29/m+AocapDCq4Ekj9esz33OkvaZgSwwkSILY/3w2m9lyrsWHdfwt/LI0sdm8hUh5FqOaw2ESCNTHsXnRZwpeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385368; c=relaxed/simple;
	bh=3Pd625luLsZ9BP0lPyOKJLZcogzByoXY2iKsKuUzYsc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oegTy0pSbyHTvfGQEs1qJT+sNjHbRPQALA2aBS1BXUeKAS5j9QjAPsz1x5xwWD6i0G4Xe8k0pv5w9l9rFT6N8TsXweYmTOjHKK/U+fx+a6oVhXV0sNqWLSxL7t+abxpXwTiZ+fY5PJ+3NFxqFt7/saZG1W6HP/qkcIxdLWlNtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifFAVORF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifFAVORF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E7CC116B1;
	Fri,  2 Jan 2026 20:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767385368;
	bh=3Pd625luLsZ9BP0lPyOKJLZcogzByoXY2iKsKuUzYsc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ifFAVORFVRtjvmhIaZj/PxXHvQ1cJ/MJ+A8EO+MxwBAzTHcrWxXzOsgIFTLaae8yd
	 8c5LpqR2LNWnJqr7j4vjrZvjN/5T3idCgjK6Dje0ZQEhGiA9KIgdLe/5ExpF/CYc+C
	 JIk2BttH64q+g31e5kJv5a1Xn4XE0aZIomaF+qBK9yyNJ8BG7dY/ApK7UhFwyPDkLy
	 9dDXUZ6B2RiOjjw9wohX1jjcq2/ekQzztQvmiy55AJfJ2BAOw3CNFoCW49L+Eytj9S
	 WdA32HhmhJnPrzFZrbV3sAIMYp37XKzsFhZWoO/KT/Jswea5tWUNAn3K1K5cUtJHkj
	 WvB8zq8ZH2RFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 785D6380A962;
	Fri,  2 Jan 2026 20:19:29 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.19-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <8176248f-c50a-4e2f-8eb0-a16f1bb3122b@kernel.dk>
References: <8176248f-c50a-4e2f-8eb0-a16f1bb3122b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8176248f-c50a-4e2f-8eb0-a16f1bb3122b@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260102
X-PR-Tracked-Commit-Id: 69153e8b97ebe2afc0dd101767a9805130305500
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bea82c80a5d64247045280b6d23e3ff95c355f56
Message-Id: <176738516795.3999225.4806017516038639189.pr-tracker-bot@kernel.org>
Date: Fri, 02 Jan 2026 20:19:27 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Jan 2026 09:13:26 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260102

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bea82c80a5d64247045280b6d23e3ff95c355f56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
