Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5848665E
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261859; cv=none; b=KvsNs7T+TU6xtBSCR+DHiIESpSChsJvgPahBSJMz1JdwEBp0w2/IyecpGeRXzZv73ZiH3tdozz6SR+j0pEUVMU3viW4KeyZ/SbX/EhOoBDTbJ9ZFrukzCKZm4FuNCfg/RZDWpuJjpwgOmmHdIh9ufwiYy+zyvfRzv7N15O5saiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261859; c=relaxed/simple;
	bh=/SXC5W1Zdye0bheR6xaQyMsEFyiHSciigKziNox8ugo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gxYHq4PlgR7n9C60jfymJ/T62UM1F1b07M1BeyUZFKxd5YIIr5eRyEULbx5gMJCiVxfPUi82JqeFnOiuj7uigEfTe0RjY0eXFCbFzdgmorcG9jzWCu0957gS+Mvyj6qTGSdtU5uPM0RK8qjzi9txxLdg/Oap1+iBOcLl3n8vmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8vJoRBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8vJoRBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7471F00A3A;
	Thu, 20 Aug 2026 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261856;
	bh=2IqKesBksdVfdCkIU0GpCimhsixcAMYytGCpT4Vu1N4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=n8vJoRBdso9m1nH1yekjbMFYE0t51/7XBrW9WocEdYUqGlQPrnJnB28eAFOFuR6P7
	 IVJGi45bnzvVWUU7SMmWls4GPCCNBHL47rhg5gloWVdOM5pge35gNjQM0rGi4wePtY
	 DGkg6TXMC2niseHjeoNMMjnX0HI353Yb1yIi0LwyQYZT9v09l7WMsHWBcM1GItoRSz
	 xUYlHbgG1hrzUfCSKEqfGZAlM9OS0YupLRXSRJWLWeA4uewV3dlIYfM9tNfkiqkUHB
	 /zfJmRRyySLSadyv2bdY1tWnWDdNKCLDkTy75uMnAewOGRiCwl33wG1E5MWr5y3QCV
	 5sJezFGq7Kj5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AF73811A44;
	Thu, 20 Aug 2026 21:36:47 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <8787a176-6f4b-47fc-a309-867acf9fbdff@kernel.dk>
References: <8787a176-6f4b-47fc-a309-867acf9fbdff@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8787a176-6f4b-47fc-a309-867acf9fbdff@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.3/block-20260819
X-PR-Tracked-Commit-Id: 326d49039c10b65522ac7277b19b9b5c42ed1aeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55ab7e14222e5f0b0fd9f7711ca391d2924b35e3
Message-Id: <178726180597.499287.10275859256070351120.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 21:36:45 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 19 Aug 2026 14:30:37 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.3/block-20260819

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55ab7e14222e5f0b0fd9f7711ca391d2924b35e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
