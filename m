Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B61A5B8F
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722229; cv=none; b=iZdoIDBqXex0l9QFIlN9x6luSKP+VK+VdU0lFJj5iFqcxa6hsp2BS91KhBW70VuL5AOmDFlRBPaHRehXWFi1JbPF300hiAarZy2BZaV2VTL/dqOko0muWtwtcrziB0pO4LUh6FcfrDe7KX+fF6RESUlNetUYREY8vdYBScixHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722229; c=relaxed/simple;
	bh=rMMJPIbHSR+hBm11gpnVyzTOxHEji9+8oH1EEoUbifI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HQUkDFFGDTnQy1ZtBGCoot+7jczA0lSpDVEH35pCtnPCwQndCewtnx1Sk/ebYR5Mwn595hJreM1iyItb74XWlX8Bnv8wDAG3KBGk6m4tyOwN9HYTlZYac6acldjozftqgrAOJ0vqCY473WNjm5UuePb/KZlci0lyeaFILa7wR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYiusROL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYiusROL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8B1C4CEE3;
	Thu,  3 Apr 2025 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743722229;
	bh=rMMJPIbHSR+hBm11gpnVyzTOxHEji9+8oH1EEoUbifI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CYiusROLbKN23+bY+hPwpc6is6NIf/70PoVUz9UYgQBi7hCavqUJM+lOwImuobY0b
	 cTGKRRVwy95ML6zeaZEMdUiBYQ/eFZWijs4KXArqrBzRrir0dZFNv0HdFBt4K599HA
	 ++T6rF54BiM0rvv8eoPSypMjbHo7rUi1s2GMjbu9Gcb8Gu1HGBWxgjfRMc3FB3/iX1
	 KW2DTtheX4rAIOJp6EcCmbNaI09I9La6jrHR6RJ/GpVmXgkV1+YIm4rT1BjD0AiSF3
	 jXADWKqXrCFGywrbAXFLYqp1h6EIWOwruULf8BTjuAq9dFDDkI5OjuWwAxm6jgsAyE
	 xqoJ1ED+3dFsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6C380664C;
	Thu,  3 Apr 2025 23:17:47 +0000 (UTC)
Subject: Re: [GIT PULL] Final block updates for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <59ee82bb-7d4f-4a5a-8769-120c9dfdcc4d@kernel.dk>
References: <59ee82bb-7d4f-4a5a-8769-120c9dfdcc4d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <59ee82bb-7d4f-4a5a-8769-120c9dfdcc4d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.15-20250403
X-PR-Tracked-Commit-Id: 01b91bf14f6d4893e03e357006e7af3a20c03fee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 949dd321ded41cba661f4ec04c521e294e73b89f
Message-Id: <174372226662.2716716.9408975939917444058.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 23:17:46 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 3 Apr 2025 16:25:55 -0600:

> git://git.kernel.dk/linux.git tags/block-6.15-20250403

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/949dd321ded41cba661f4ec04c521e294e73b89f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
