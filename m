Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999729;
	b=XLI/4ZdBUzWaQhLmImcZILWeVF/izU9dvsKGwWhrWU8eNoaas5qgOTO2pk2m5JY4boJa
	 Ct/gHuRYATuMBu5mxwRi3xbegnkwpEi9MvMez5L8E16hA3Z4X4ZTayfOnPAqhNI3C43Sc
	 b82pcDZ3VwEaHqh6VAIHv/EIHSIvbvtTz+etIkdHY7QUPfOJNZ0QaF6VXBFTh34/xh6db
	 sw2Ispxv0MFRXssh5PFDPQjDJDdfUO9c8gZALCRG6ywU23csyHgk3s6Xwys/G4NLECcTc
	 OI4EWOWFmWTgv/FTREQmf1aa3u2mxKBh85jlAAbEbwYGFdIGoQ5+dgFL5sv5NdFeyaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999729;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=dMkucSMu8frhcoqzkG5fJpFP9C6ZSM2b41VGlsuJsqY=;
	b=bZdtaDh8JAjRAO01frApBZn1jAzsbFkbYg3vDD1R4tneu1AMBtu0qHsYaUBgnxnXh8M6
	 N3rgqdI7aZxXd/xFLaJimlFhtLqk5MTrw3zoCGqhOj7nA2Ze333lEkQOnuoMWJ3lEH1cU
	 hAzyji7EQ2BsjaY878tikHwSSxbV0m0VZwhGW00ymaNQNxc5NSGAmdvML3MkuVRMdq/ap
	 DHK+gx9lNrlcKNLhJcr9iZ3u9G6qcIhj3/qFRiCASt0/tvi5LkmvDaju/xHYzcXv9o/M/
	 T7ZGuBq6Gbj0SK76so1zr/Cd+lU550eo/KlCmoTjyaAtHb9GSlFEqOPpGP6UwYVZbKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiLCs0HT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D3606A336
	for <linux-block@vger.kernel.org>; Fri,  6 Nov 2026 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiLCs0HT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069851F008A4;
	Fri,  6 Nov 2026 21:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999729;
	bh=dMkucSMu8frhcoqzkG5fJpFP9C6ZSM2b41VGlsuJsqY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=iiLCs0HTndKpM1hedwUHBdxiKwzyFdkiRmLwsmNkeYifSCC1Hm/2BPEJXOZcI6mqB
	 92lXQolJW+LxKXvspqVR1eU2Bj17oiQNGk0fdVghAxnwqb0sLvZhDYTGiTN7dW7Kum
	 dUIMRMEcWegwdoZnq8alC/CYBP9LrqJmkZGd6IsXta+pQ8GAwTsn/JOJOvPPdW6Gbh
	 Xb/2KqfLgKMx5cbSgLnno109UWFRFPrR2vVsh2LgM/YasM0JqoeOPF90S5rB9HnsVS
	 B59G4trdQDAFvMEPeN/GnwB14MHPP9RS7BWlWvxDviZx4Agz8m0QDHHMPGUvJQodHZ
	 aTR2OiIZgdgMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D86F33A549A9;
	Fri,  6 Nov 2026 21:15:28 +0000 (UTC)
Subject: Re: [GIT PULL] block fixes for 7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <d25cc9fb-590d-4f57-925b-b91f00da2672@kernel.dk>
References: <d25cc9fb-590d-4f57-925b-b91f00da2672@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d25cc9fb-590d-4f57-925b-b91f00da2672@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261106
X-PR-Tracked-Commit-Id: 28f7d31c2aeb350df9a0116093fade0a840fb4ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c53d8fc9a7571b63482548a7e5284ef9f025fd3f
Message-Id: <179399972771.876369.13409776268696394380.pr-tracker-bot@kernel.org>
Date: Fri, 06 Nov 2026 21:15:27 +0000
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

The pull request you sent on Fri, 6 Nov 2026 09:07:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261106

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c53d8fc9a7571b63482548a7e5284ef9f025fd3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
