Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359B78F39
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401254; cv=none; b=Y9MgLEk1MTOc/v4XrfZjGRsZ/oQ30OUKyU5s0iQd9wliHlDqDB2gVPkX0ygYsTztB5lwJOtyGfVtjOYGFkXdqo5DEN81cKyqdMy8WzR5GkwwbdmVXWKDX6Ft0Xs/JqNX0DH5ZBxwQNgB7e7xr/TaSPBAJPJ+zvJycxSOPqdBpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401254; c=relaxed/simple;
	bh=BsCY0jNRKQzScSsREki/uGn8RYBcAjrgFAWMKmVfAco=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qMWLxbsK848JMi+s33yd9Hg7F8VIIIhfheqjxe0Sx/tn/vklz/iZL1M+MVMOIZvvMfzH1RNFzsnKGtP/xdjfL65TjDNK5y3UDbyoFoE2qJn1mJkcDBrDq5o49YNtJ8cB/vNElDIrNgSeKEP8IurHI2rSHCsFIwXjFw+HuObCEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5n79q/5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5n79q/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861AFC4CEE3;
	Fri, 20 Jun 2025 06:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750401254;
	bh=BsCY0jNRKQzScSsREki/uGn8RYBcAjrgFAWMKmVfAco=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G5n79q/5hLHrLiIq3o5TN0UceHZuNPMctWFLxCv+p48z97Oa6CyUdftgy1yKSYqRl
	 wPDEf8SgPkzkK5hGwCociMvPfcQmoKce20dwQHFOqPxK4XKu28BTxmsO9leZeSzNkq
	 xFh8zPLB9sd4RDVEJr3amKpXjsuk/089uYUoKVXuv1lJ2zTUoEo0lNoruccaD0nb6h
	 LD7bGR6wzw7VQE4a79Kx2oSZC9MZO5v8UJLOrjOEhI9QoMySLTwsnguH6JXRkA59Y2
	 zgOMGvvVnBPgJBZjGb1hPxcDdw3FRCLX+vWShQW2DBrlAxo4EmNcrOYilcEeBg7IUH
	 HHkMsKqr98a5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBFD38111DD;
	Fri, 20 Jun 2025 06:34:43 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <e61a5bf9-4f23-46c2-89c9-a0567f92df94@kernel.dk>
References: <e61a5bf9-4f23-46c2-89c9-a0567f92df94@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e61a5bf9-4f23-46c2-89c9-a0567f92df94@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.16-20250619
X-PR-Tracked-Commit-Id: 8c8472855884355caf3d8e0c50adf825f83454b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75f5f23f8787c5e184fcb2fbcd02d8e9317dc5e7
Message-Id: <175040128221.1104049.13275426191880833933.pr-tracker-bot@kernel.org>
Date: Fri, 20 Jun 2025 06:34:42 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Jun 2025 21:55:34 -0600:

> git://git.kernel.dk/linux.git tags/block-6.16-20250619

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75f5f23f8787c5e184fcb2fbcd02d8e9317dc5e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
