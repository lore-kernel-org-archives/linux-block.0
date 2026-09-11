Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8735A5135
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158364; cv=none; b=XJi1ICmquQW83nG1Ith5nNt0aLOg+OkdBul/agS7+Hm1Oy/BDfYudCJKj8FTmCd5Ah/ueRhdjboH8ejSMcSwZ6C0vVlzxnlztmVv/DsRv1QvqCYqipuolnlkbzLOKunmPTo6BDMX4INypxfpGpIB+bKc5vDTwVCx3aoCxzE8vtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158364; c=relaxed/simple;
	bh=0wA591x+Pr35seOMlP6N2WHBaPNsOI1ZOe7IV8LVTkA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VaA+pZbRrE4Es4ol6biTc98HtbUThKffoYRVE3D/fiTkgrkxGcJgmUndgmsc45qG/G7fCcvMNzR0HqmuZqmS53gIiu4mz30s+WmWGWZGQO7bcJjMk3KAjY8HSG9e7m82cED43wWybs8a1scN0xtIJtD7gOqzKddmHS7ij7EjcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR4WW8Z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR4WW8Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DA51F00893;
	Fri, 11 Sep 2026 20:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789158357;
	bh=FMYoMtRHMFYSr3QqYKBqdK4rTA2gv2mMBqmCR2eWgds=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=oR4WW8Z9bYYnEXuAQVDC/MAUcbd/lB6Jhdj8ldTEccJbvbIOWpOoLslf6rnDvnJ53
	 g4fT3QhZsrw6/ArSt1tsLZb/DhFSfeyLg9ut+X3YcQ4uu3FLWJe6dgo2ohNpWWPDR7
	 yxM7iRZ+hgCRR1UNUbPoWxIFoIR5YMpXM4PNUzb9P+bsSmEal2+xjJqOY65tGsOduE
	 eX9DgAyKuosBdFxwZ63DkVkIy5EvMa+GxmMexdhw7fPq5sbm7ObJ4bNSDFtSJTTeTS
	 O4LPRBST64slX2mkrwYL4p9vP1mmYEtuB1RKgN95ReyzIF9NrBgndtmzNjCIKEi+n8
	 qQLGAdZAw/TTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C5A3924451;
	Fri, 11 Sep 2026 20:24:55 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <1b9b8e2c-463e-43e1-95d7-308c07b500f0@kernel.dk>
References: <1b9b8e2c-463e-43e1-95d7-308c07b500f0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1b9b8e2c-463e-43e1-95d7-308c07b500f0@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20260911
X-PR-Tracked-Commit-Id: 94b1a3ca9b8db3151f1416263704c159a9470da5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35ef102063fd6f39e045e6d4e92ac04d3d29c0bf
Message-Id: <178915829445.3095760.13019100650811204609.pr-tracker-bot@kernel.org>
Date: Fri, 11 Sep 2026 20:24:54 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Sep 2026 05:34:43 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20260911

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35ef102063fd6f39e045e6d4e92ac04d3d29c0bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
