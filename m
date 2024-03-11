Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20C56777
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186181; cv=none; b=ei/jRsWruPqrddOSjYu4Qh0E2LIEtKrDjuEN3M4cyNdXeuEFF+Dls70gc9Mp8YXf52NTCtyRCj30Vn71Xkj20lrSKt7/EV3Hk4FeLMtH/oyjTXBetQVmIDzCvBE7d8GaYE91z9rDFpbDhRCDEMWaDnHA9i6XJOh+Ia3UDmmxi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186181; c=relaxed/simple;
	bh=mxBn82Eyn7zcPAq/BsiCsn5kYrco35lzSO0nlYUpCKk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dVtCg2g+9vBbcCUA5sv2kZVPHH17+2HHRX1wiWnQH1niZKD2f8cpvxpR+F0e9bSP60TKLmK9og0/pQHRl8RWpQtl11JETHJF6QgljjKWw2KPrdWUP2MFgRDOyQOvuR6yQve/xvhJOwqC5XP79ncda8KcHCmNYDh9D4Ik4BuT2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfzjOO0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfzjOO0e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DD89C433F1;
	Mon, 11 Mar 2024 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710186181;
	bh=mxBn82Eyn7zcPAq/BsiCsn5kYrco35lzSO0nlYUpCKk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RfzjOO0eTW2fa2oA9HC2iLcgKdayuYFSqiu4j1tbjyvSD2jyy+cv2x9D/9VjTcB8q
	 hv7wSY4jhbtmU15j3pXSdgALCEzWvgEF9Mi0Fal4HeRFe+qLsaZkyEv+dmvV0KwbdF
	 3Nsg0E6f1fsjssy4s8Y2JLByFKFe+9d/Dd9ih+Maze9atalcucXsU7e9c147GnqJDU
	 ZkBDK7agI31Iuo8RiuBrr04N1KgVzBJJlIkcy4/qAaTriWQF7DARDofgaHqUNSN9R6
	 tGoUQtZl1CfP72ut3LN1TmGv5g/87M4FIftHIigkZC1Kr+i5sJbXgesRjouzME/Zk4
	 /RHDx7WaGOiCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BD50D95055;
	Mon, 11 Mar 2024 19:43:01 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.9/block-20240310
X-PR-Tracked-Commit-Id: 5205a4aa8fc9454853b705b69611c80e9c644283
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ddeeb2a058d7b2a58ed9e820396b4ceb715d529
Message-Id: <171018618149.28701.2702357760030002089.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 19:43:01 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 10 Mar 2024 14:30:57 -0600:

> git://git.kernel.dk/linux.git tags/for-6.9/block-20240310

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ddeeb2a058d7b2a58ed9e820396b4ceb715d529

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
