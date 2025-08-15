Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25E2C15AD
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271501; cv=none; b=rGmML+8smaDuiNymJn2nU5gj98gAIWlfX5JnfdBjRneEUdxtvPcwi3SzfWoj0/o4iCrchZubi7ohp0mbpiropODf2UhiyXPUFyrTzUJgCAe6Cez1d9R2Ytc1EAks9rgJQHymfKt+0NsPmURCDgCicNOyj7XtgIp9c9wMyMR7190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271501; c=relaxed/simple;
	bh=EPQYeqVx3hmoTRxMB0fvSmrm7b9EkRyMGRaThIN1hqk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JjYwUrwgRLsHpeDMBSc4xcEHuYelKr/tjRPsmDUl0Cm/yaonPJc+CDL9sNBJrK1x5TbHxF9iFSz211XEP+F4eiyqaEQ6on730tQWTuzgLJsu6CaEtkpy9s7UxD6A5GlHqis0OZ1i/545b/9RtGs2jY7FPLDN5zM20GEYMj0hIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUHNbBFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUHNbBFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDF8C4CEEB;
	Fri, 15 Aug 2025 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755271501;
	bh=EPQYeqVx3hmoTRxMB0fvSmrm7b9EkRyMGRaThIN1hqk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cUHNbBFnFUpoMTO3aeVXYU1ii/iYAoib0Ri6zNX8cFAUaEEwntavuuiSmpFaUt+T7
	 hYvNwo7Z9hW3NziPxpUC2O6wsruPFe8dRnCgu/aZ/yZ4IKHHY3JNPRTpofBFtOkq5Z
	 pyXtNBKH/FJn6Fi8AkS7649m0Vaq5JM+Bc9AaUT+lQq8NiDXxAV4jRlUUBElUNM+dd
	 7DbpH1cMqZLXzwh8it+clcDEH/OmYbQgp+S0psRdmndkPHYt1todrICvhfindfcwZx
	 e1MU0uINc6B6L+zcy6WgfvkDLpnHdkxEO4w5U0MH07RyiUU8PC0vSOB95WOPtaprLG
	 cremDHW+hRs1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F8B39D0C3D;
	Fri, 15 Aug 2025 15:25:13 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <7dde5580-bc75-4418-800b-c4d58bc600ed@kernel.dk>
References: <7dde5580-bc75-4418-800b-c4d58bc600ed@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7dde5580-bc75-4418-800b-c4d58bc600ed@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.17-20250815
X-PR-Tracked-Commit-Id: 8f5845e0743bf3512b71b3cb8afe06c192d6acc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee94b00c1a648530333d9734200be7a45e6e00cd
Message-Id: <175527151197.1135747.6704614117326531902.pr-tracker-bot@kernel.org>
Date: Fri, 15 Aug 2025 15:25:11 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Aug 2025 09:09:37 -0600:

> git://git.kernel.dk/linux.git tags/block-6.17-20250815

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee94b00c1a648530333d9734200be7a45e6e00cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
