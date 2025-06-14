Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850072E7F3B
	for <linux-block@vger.kernel.org>; Sat, 14 Jun 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924624; cv=none; b=RyVrYtcEYl6nRSinFT0qL142tCrRefRDPp00BUdPirhL0kl+idk7VJwnnkxQAYbjSWA5tG+z1Nrr0k5FhP5qwdupl4dYKZeguEoI4mftP42WRyTaGktgdXxgyqLDZ18jR0z3qUu+ZAuB7xK5C6daZTP04jzeJhbHMSbE5Vns32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924624; c=relaxed/simple;
	bh=qBlC7j71j+/nHChiUVK7URRV9SW0QdYLa/pbWU9i8hI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fRSoTguwTFlenK49qKXD3ezxx2I2AEiOhdeta8uVe+RGey4nDVhhLaYEAAQhWrJ+w6ZMA0X220hBznC3yuHIifWz12Q/mEfNJ/PafVt1iscDobMhvhZBRQ6ETWE1Mka5fZSG4PtPE6r4ryTK5GCGq6pMZKNxdph3C1BeeQxH7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkMjPnxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkMjPnxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14288C4CEEB;
	Sat, 14 Jun 2025 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924624;
	bh=qBlC7j71j+/nHChiUVK7URRV9SW0QdYLa/pbWU9i8hI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KkMjPnxF7VIvuD95Aa/aK9gW04mLCOv1TMiEog3Q+nhlAbjqG9LuwXmeiBbHTHuvX
	 HEMjb33nCabvxjIsoAOf0CeowRZKhg6/1KuNGit12q5/HgvYTruWWih7UpXm0nDTVQ
	 TuWe1zDCrLim1rcdG9IJXKKXM5ocj39S0y+HrZU5+PGNpbeV0SQbN027nsg3qhoCJE
	 8zEvo2o+hXXfOo36H2e44+rQRRH7+JW1NLTPu+J61snu/5wAXv4uuSbgAsz2eo58eq
	 kSWw2xRmFHNzdiciaauXygjouPlCw1X6qow+8X5krukrDh53i2vzMoGxSJTNSVO62a
	 EH7xd8iPA+xew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD93380AAD0;
	Sat, 14 Jun 2025 18:10:54 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <250c7955-0561-4bd1-9108-b3ff0ad236fe@kernel.dk>
References: <250c7955-0561-4bd1-9108-b3ff0ad236fe@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <250c7955-0561-4bd1-9108-b3ff0ad236fe@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.16-20250614
X-PR-Tracked-Commit-Id: 9ce6c9875f3e995be5fd720b65835291f8a609b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f713ffa3639cd57673754a5e83aedebf50dce332
Message-Id: <174992465317.1140315.15257633017956965970.pr-tracker-bot@kernel.org>
Date: Sat, 14 Jun 2025 18:10:53 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Jun 2025 06:34:33 -0600:

> git://git.kernel.dk/linux.git tags/block-6.16-20250614

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f713ffa3639cd57673754a5e83aedebf50dce332

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
