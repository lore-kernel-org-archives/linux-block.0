Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839E28593B
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636012; cv=none; b=AZitqJB7DPNfajHUP+O37MB+HOqQxpt1xGHwtpGPnyzf6lrsB/wsbl5lT9MzwebB8gYeH8qON+SQ/saJkoP7x7HEfdpZka1Wj+x8WxnfWiWPMPGuHWQ0Hs4VEoMQhWdeCof479yIX2+lVCtHlHbmyovlgc3MsLURqgE/Y531dcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636012; c=relaxed/simple;
	bh=v+0xW/1Uk6FVbDENK4mTRv09ic4ELXF0OTGREWtKMjs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PpZUMIqXgRMp+IlhrBJbCXJpSCuDbTZ2Zut3Fv9SnNQLDADxk5FRuzlu2gcf/f5aXE7GW67g7wejv0tEt2fVSRcJmDuh4BtgUq9ke9QoeoYQSDP1YfYswGtdKLOyvtmUjGPS3tPLqaO59HFEROqIx+O54zSiUZqcCuO0V2hQMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilaGH2aL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilaGH2aL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 686C5C113CC;
	Mon, 13 May 2024 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715636012;
	bh=v+0xW/1Uk6FVbDENK4mTRv09ic4ELXF0OTGREWtKMjs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ilaGH2aLYFv2Xz/VI0X0u8OeuJWoEt7UK3eV09m8kU1vGiwj4BuMNmaNckdpmt27V
	 uNBg29X4OZLo3Ulz8IZZ7oWsG86qHL9QnkXNhG1D5p9Nz1FiPIl90GYqS0BUqfukMk
	 GpKkyWbkjemOU8IGeoShDCXHbWqcBHxUjLuXVyJShT0W51RqEZXqQUsX1tnsp4ZAUj
	 wvU8XP6eXayJ8n7fHoWxm9r87bSVNSNy7k76Oa1+MIkC7y6F2b/C9y6tTmiBGT7gST
	 F35yJj8ZQ7O0Q1dBUIAJ/eqLONShu7DWP4qPIVj9+1v4dUXrFLCxSyZD+BgXHlu3Pb
	 gNgdVhPDioXdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EF0BC433F2;
	Mon, 13 May 2024 21:33:32 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <93e54ea2-01c7-413b-a13d-2e731193acd7@kernel.dk>
References: <93e54ea2-01c7-413b-a13d-2e731193acd7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <93e54ea2-01c7-413b-a13d-2e731193acd7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.10/block-20240511
X-PR-Tracked-Commit-Id: a3166c51702bb00b8f8b84022090cbab8f37be1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c9f4ac808b017a0013cee92a30de980550145d5
Message-Id: <171563601237.15304.15688419053531716863.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 21:33:32 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 May 2024 08:23:44 -0600:

> git://git.kernel.dk/linux.git tags/for-6.10/block-20240511

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c9f4ac808b017a0013cee92a30de980550145d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
