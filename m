Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE381D86DD
	for <linux-block@vger.kernel.org>; Fri,  6 Sep 2024 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649964; cv=none; b=kKRQlG7fhfZuVDPulEhXhzK5fHNluVs3Lyv6rPI9acFie4VdgzNJEGhRLeZfry6kSFYuTAbjh6s+uoS/zFx6skTPRpMIR7A3PiJdg8z/mxFZMBfPmfpq8QLpANTnblquYXhosvYl+eOhfjyNtR6JgAhHY5y/3h1Byy8u7aBlo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649964; c=relaxed/simple;
	bh=/pkEdm04PIkj/cQKIXpefdmXQ3pGIHCVLfw8GNFO9s0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KndzOgz7s6wnq0c+siwporsMpky37rsq37jROFbva/zHd94OTHIcDKpLmWifrsoFTVTJBlEiDZWfiSv/fbSR5BLFpi9bYz75/HEsyqf6jLbF+3EtbB/XTmhcnJUjst+nc4LcgBSeBM/jB6wVsDaRCOV6vMNXNKuewyozdXhAvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0abU6Tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0abU6Tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB83C4CECB;
	Fri,  6 Sep 2024 19:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725649964;
	bh=/pkEdm04PIkj/cQKIXpefdmXQ3pGIHCVLfw8GNFO9s0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V0abU6TfXw4Fg8JSxrnyJ8tSkGdCblmh07dTjSgMK/H88OyWCiGjvzY8SYC5EEsWZ
	 4aab2q4WcQxBIRjemrpTJQVdmGP5KMudSSOJ7t3ac5VrGylgZHoPPLJeoIPy0IOHq0
	 FUoftbtl9/UsqXDcmRCUrq8oQ6ow7L8e57b3zKbgy2y9bJcPU6l74uwnjW2yU9toWG
	 trpE43S5WEzfvYHYuMUquDkCh3ZKjWcZzSTH9TuCxXWLYzVLjulGemmunlmVsREwym
	 VyRUIN+NNkuX4atimfp5zXSd53Kxm9nscULeyON1NtA8tbLyKI6VlEReuWGbUZEvso
	 s7W6ZqqlL7b9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD63806644;
	Fri,  6 Sep 2024 19:12:46 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <e49dcbce-3af6-47b1-96ee-a1046324b152@kernel.dk>
References: <e49dcbce-3af6-47b1-96ee-a1046324b152@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e49dcbce-3af6-47b1-96ee-a1046324b152@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.11-20240906
X-PR-Tracked-Commit-Id: 4ba032bc71dad8d604d308afffaa16b81816c751
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b66f0b119c96dbb6b976f1d75b7bf69960069bde
Message-Id: <172564996528.2497610.13245999054596638984.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 19:12:45 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Sep 2024 07:30:56 -0600:

> git://git.kernel.dk/linux.git tags/block-6.11-20240906

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b66f0b119c96dbb6b976f1d75b7bf69960069bde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
