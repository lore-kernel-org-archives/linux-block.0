Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E43E5A30
	for <linux-block@vger.kernel.org>; Fri,  2 Oct 2026 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969477; cv=none; b=BYiB2KiLko76ZYIRwoYFCfgMmK0kZvaJjcvnkAejl1x+ovy85lbOPtdyyRX0h6hpzmq9Ro+cPQK7cp5jJ4ZLMZkNcz25lwBLgzAyeKZSQ33wTn98tWgY8VapVH6T6Hlq1P4Ev/hQU/SCE3Nz775iCoNL7DpTBiiUcJuP7gCe/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969477; c=relaxed/simple;
	bh=EoE2CM7nVCsUeBXPHEFi8qlhx7WUEz9aABRR2scCUu8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uGzyQOODxaX16JAvT1tanu3cEXePs1SxIGijXTkw5hTtE+m8UKbv3NvBywUnGt1V1+vArFGQ4s818fJOsrt9lIYTKCJ35YiH2SvdTsfz3vHeFyoVgSEJv0nqBaS+aLzvxAHH/wyI31iYNeYrGP8MLreN/aQErp/duN+9HvFYXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0wifhsC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0wifhsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052B71F000FF;
	Fri,  2 Oct 2026 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790969476;
	bh=LC5TgaUnm1Xf6l1jkrR4cLTzrpEFQxnR68fo28FS3LA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=X0wifhsCsC0bB+wxVxOv4LOqw6WYK1kFA5WQ1iY5tvOd/KTcmEsVTAyzO2JvzJ650
	 f46HBS/0r/5Dc/0PJ85Z8JXpFD0o3C4p7EfQ0AIkt6KT7QFSYB81p57EpZgdJh+uu5
	 Iv9T2Y09G3pAm4M0ynXrGRCPCuB3GzyMby35PJpfoEpWnkv2AccCP2q2/RqjtV40Io
	 twpglmwP/RRj9G783oMKnIqyunU5nJB2cVgKYEmzsDL6oAct3ZTHaRY8Q6FB6m7Lez
	 WvGuUn9n3FFPCou++VrJ+ESi3kNfiar8nzahirjDpucl3jXxTG3MGvIv1kOH9Ak/X1
	 s00VBdhFFbgvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16403811A6B;
	Fri,  2 Oct 2026 19:31:15 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <4fbdea09-538d-4be2-8492-bca0aa570e15@kernel.dk>
References: <4fbdea09-538d-4be2-8492-bca0aa570e15@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4fbdea09-538d-4be2-8492-bca0aa570e15@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20261002
X-PR-Tracked-Commit-Id: 684b413b5483f57c890c171b9400076a0143b918
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b7cab693ba2bab63774bf5b988e8a61b2ef0f32
Message-Id: <179096947451.3555183.13996561838545323384.pr-tracker-bot@kernel.org>
Date: Fri, 02 Oct 2026 19:31:14 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Oct 2026 08:50:11 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20261002

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b7cab693ba2bab63774bf5b988e8a61b2ef0f32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
