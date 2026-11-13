Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595205;
	b=V/0NPV2rQodugGOP7C23MtO43wzVPF6XpXLvEFaHhXpGDPaqXhY49cb8vtlS2zfGjUCn
	 W6TEAFlcRLvx8RFErjufSEeoSPxBYF93si2GY94hX712dRNTH1bwUa2pcJ6wVnpKMJp2h
	 5KFan7tgQhEMJKra+HjEd2NFbiAcTdfMRfNy/xVC/kYtUuT73cpFTCku85mT4mDGg4tsq
	 a/JkusacN8fZ4s/ATnMErqDKCN00/exsey8jhTqzd1DCpI6KkTJMJVLEtUnwp8Dm1tEEz
	 5HSgMQse+rKowYiAfpMMHT4gNVL01swjUbuMdwnMh8UQLZK7B5O4aDMw8oe30FO0zvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595205;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=01RayTQsiwTurj2dQdGI8sbYfaZ/HgH+O+UwQo9KTBc=;
	b=VoG0JLqTog5v+gLWa18/SqmDYbMcN9XFRs0CGRvQwmo3h7084l1znFr0gJr9cI6uuUbo
	 hN9E9Y2i4GkuPkzotRGxL0JxeWvtwdKUBpScjk+zkwqE0pHlVZ7v8DoO6cZfqaYXgAzUC
	 Z3U2avY4okqUNXxZibDDt+4tSvNdKaClo0U+6hIsIK9pBZ2PKirVPylHC7h2mhbrylWcv
	 vZ5N+iQgUePCpL9Lj2RlRcjadFKJIJ1wTvtVJAFNvP1AY7svLTRZZC2T536MHadVYC6JC
	 VQwroymxY384oTDY3WtoH4L25KP4aZSzMmG93PJjR77Eu2eYFoHKc7ps5WsyEcno9iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAGuS0c+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28067606A332
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAGuS0c+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055471F000C4;
	Fri, 13 Nov 2026 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794595205;
	bh=01RayTQsiwTurj2dQdGI8sbYfaZ/HgH+O+UwQo9KTBc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TAGuS0c+kHSiC4nAVUrZgARMyjCpAnYImEWMPsxMC5QCJqxh3hyicSY6+UdvHRKm4
	 RaSgvS+OLiPMJpzUzV83fpAbpJ617C6NFpuVrCRwVev2VtTHpSK5v8wRVhfNDHRxDV
	 QK69mwqJOWTtvWfPM16jRWmsrwElYUkQ5feNcsP64NwDpzL5cyHzE7FK+LwDmIz7mt
	 /uyuowJsooWuplCY9gozW47oBqOpy3dSQUGl6OR7MO7yiaROzRuaT6daEWS62cEEwn
	 +IvOBVFCgr6TKqetb+OSW0TVu414Vjgc7lGHgxUsxjStjzyFLNUsuGA3jBlbCGWlUJ
	 8C8Jpn/kSXEFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1694392E998;
	Fri, 13 Nov 2026 18:40:04 +0000 (UTC)
Subject: Re: [GIT PULL] block fixes for 7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <0c3fd1a8-c530-44c9-9dd0-3dec5a6dea11@kernel.dk>
References: <0c3fd1a8-c530-44c9-9dd0-3dec5a6dea11@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0c3fd1a8-c530-44c9-9dd0-3dec5a6dea11@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261112
X-PR-Tracked-Commit-Id: 7cc2dda4f7aaf596c1796184649007151ff98f8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e93fd809fb5692d1571bd008988ba734fd7fc976
Message-Id: <179459520344.1692124.16613985314285983516.pr-tracker-bot@kernel.org>
Date: Fri, 13 Nov 2026 18:40:03 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 13 Nov 2026 05:54:11 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261112

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e93fd809fb5692d1571bd008988ba734fd7fc976

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
