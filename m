Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E915886D
	for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727302074; cv=none; b=gLOEEDT/DcDb3hHCVJDhgrnzdQt3IF4OG3hNhw9CnUmW+VD+pGaMbPLmG9f0oFNoKU4TDO5Dbzxgqxl4tiP/+9xSGpIMadxQmwMsO11w0s4W1O3pShQ3BUGk6aBv76Vl+lYBLf29Hu7HPKqNrI1Bo4Bv+JS3XnPWIVkKLsRjoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727302074; c=relaxed/simple;
	bh=jWC4YucxiJpaq2XHjxA02+t3iar3tOZe6M3pLLcbt/s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DVdpairMQSqEFgrtUfTmmFMQp9BzPKn1AcFD6+aqL+g9Ch1MxCv4DC6TEXufO+4oGz6Mh84ngeXKWz/PAJLcmPNaGH/DlMOMW3yw9fpsotNB/000Y05o1TYUUEK8wYxo0aw+puGX8IGTtrCtqEB77NQnqs2N+YORHgu4hoNMTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwkOZnTO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwkOZnTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EBDC4CEC3;
	Wed, 25 Sep 2024 22:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727302074;
	bh=jWC4YucxiJpaq2XHjxA02+t3iar3tOZe6M3pLLcbt/s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rwkOZnTOlZIzB8BOKJucT4v7q6qRdx2KsNqmud5bvDOwPbmFKLKY/Zka9y3HO0c6N
	 jy7+/kng1HBms6lhB4OiRj+slxSqqhR4D+i04Nt9scdQftckRutAC4dEQpbc+xAuOn
	 EGSy9meXptugXerOgFEyJDkgVK2wJQsJzzNfMwkqNRpJIADGDhJYd7KOZEeoVF6O0l
	 jYR9IpaXj7+wGa1a8Ar6LSFQ8q625QTZVWGjUUr++AsBZAtCp6TDcDX971fhIn3YUg
	 rUbseQoWPvPiaezPqUI7VxSjtvRlOKzKJaOt+qWGfHh95Ar3eif4DY2H5JO7ky7Nof
	 CttSHxICnsqEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712773809A80;
	Wed, 25 Sep 2024 22:07:58 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block changes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <fb8ac999-d7d3-4037-a7d7-c13a1400a820@kernel.dk>
References: <fb8ac999-d7d3-4037-a7d7-c13a1400a820@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fb8ac999-d7d3-4037-a7d7-c13a1400a820@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.12/block-20240925
X-PR-Tracked-Commit-Id: a045553362b53fb8f34bb1c3e5de5e020af79550
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11a299a7933e03c83818b431e6a1c53ad387423d
Message-Id: <172730207694.743114.335589188611967613.pr-tracker-bot@kernel.org>
Date: Wed, 25 Sep 2024 22:07:56 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Sep 2024 12:05:28 -0600:

> git://git.kernel.dk/linux.git tags/for-6.12/block-20240925

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11a299a7933e03c83818b431e6a1c53ad387423d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
