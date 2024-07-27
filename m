Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E803B784
	for <linux-block@vger.kernel.org>; Sat, 27 Jul 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722119881; cv=none; b=qRT03wjMu6kzvSVZC7mMv/SB2iAYnlGrQs00i3YyRjOsYuwobQjfmoQivWFtEexZgKVVacWaowexs6pQ0N3nGcCR7yHaAMhJtbKthvdk+lQRbn0pwSOYnYtqvPhqJ09nv1MJtIrr4G0qvUoLcLWbJrKG5/ToZ7uUjTMuOd+3nQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722119881; c=relaxed/simple;
	bh=JmAeYolkLpdgShs/w5TPb7gb5nM4HQeTux5QvbgQeVw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J4fpXCXjTpri/i4f0qFvoaScDp5qeUOwYZ1Ga6oM43DwcFyFU8wPf3JTojhUsf+ZTqB8rPXh679BhuOzV9qD7OloynnhQKc0Es77kAhZzo3B0Y5SPmY7FefaEtIX2DboB4Oo8nTgl1U0trhZ040FPdVduAKkUJj1n6yk3iygY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx76bDSm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx76bDSm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA3A8C4AF09;
	Sat, 27 Jul 2024 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722119881;
	bh=JmAeYolkLpdgShs/w5TPb7gb5nM4HQeTux5QvbgQeVw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vx76bDSmAKRDEaomoLD0cyotfGlofTiRJS4+AZRC5ZVZUZZJtBup5YRegpSooRjrP
	 DThul8aaU40Vq2veahFakNGPPWnBZE+E3O4gXFjdyKuEHHRr4pKOEnrxCZJpaQnfrg
	 OWfCnlEsE4eU3urzlyWS3DW23GhasaqzxY3ZUlVAMqfWRU0lRMgL7RfRHsmDnoSo/t
	 cRVY6VjHg4QGFJ648sdEGHtlI6wBiSc9iA2kDkzNBErrxsvOAr8zGl8goK5VPSaRJU
	 lsqPLpocoaiATX1XrVZZ10sgSOEbU3wNTJwDjG6QWD+R79yJbfOLcyKTL+BZYNUhSd
	 XsZEQNVuDq6FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1982C4332F;
	Sat, 27 Jul 2024 22:38:00 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <b1213d87-c86b-4105-9630-e92b2834a08a@kernel.dk>
References: <b1213d87-c86b-4105-9630-e92b2834a08a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b1213d87-c86b-4105-9630-e92b2834a08a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.11-20240726
X-PR-Tracked-Commit-Id: f6bb5254b777453618a12d3bbf4a2a487acc8ee2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6342649c33d232c4e7ac690b98bcddaab10a4d8c
Message-Id: <172211988091.30387.1630670874150779569.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 22:38:00 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jul 2024 07:07:42 -0600:

> git://git.kernel.dk/linux.git tags/block-6.11-20240726

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6342649c33d232c4e7ac690b98bcddaab10a4d8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
