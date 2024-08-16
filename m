Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975861C463A
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842447; cv=none; b=oL7o++nMCcrxKSz48Nk1Y8O7Bk2G1DaV6RWnVhKuep0cCgI3h/MsaL9EnkkZDcsnuFUzvoT2IER2T62w5RWLIcevO43xnIgsQznjGK4Cj1U1r1m+3AsQ9qXTj4cZY22NuC8Up8c0eoS/pilypnFTiYWBygnHOfqYBCxTAjCRBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842447; c=relaxed/simple;
	bh=iA2Pi18XHgd2JrjK55X/NvRVWbwlgeKEENsjC+Qd5lc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KXlWASx0dFhpcFyUyXp3xurEKx80ow5EQ+N38IkiBeoSMdPF2PFsn1b3giwycmPBBNaaqehLv8xMMOa9P6xkTdIx3Qk280CX3t4OyIpbMucGhZd3jmPBrE8Pi7GBnMH9+nwwRJrTIab9KOFvPNkqYwU1BECsnBn6qpRXYunUQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePT1zTm+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePT1zTm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2800CC32782;
	Fri, 16 Aug 2024 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723842447;
	bh=iA2Pi18XHgd2JrjK55X/NvRVWbwlgeKEENsjC+Qd5lc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ePT1zTm+MzuiTWNfrJMF6lMLAlcMGvyT71cZ/Kj2t4gWB60q3FVuoeJGp3jvQa93d
	 lS46OZoEsPCXVOOQptW7HS0YxCwnxL/J2cRQz/8vmuhRK92k7nU1isEmLFS3QUp5ap
	 j/wVQZNOQ0XxbNer6ElLb4cLkzIHkIIEQ0uOPQ/gGfFOa8fybk6f0KEeLKq5npaaMZ
	 MYKSNW8qddk8tbHc0SLYUP0QhjL7PJp2NmTBjA8C/UgT3yVeLbtHrQhH8aUEbgFpDX
	 uCU8qjd7K/ta0Uue4CMv74P71QOzqpBKwq0Eu3rDJOXou9CfsPLf3wDNDMscs1d1/H
	 sfkT8IO80b/OQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE7138232A9;
	Fri, 16 Aug 2024 21:07:27 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <1c41cbc8-dd07-42ba-a192-665103012e64@kernel.dk>
References: <1c41cbc8-dd07-42ba-a192-665103012e64@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1c41cbc8-dd07-42ba-a192-665103012e64@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.11-20240824
X-PR-Tracked-Commit-Id: b313a8c835516bdda85025500be866ac8a74e022
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85652baa895b59b94bea29c77cb9b51cf7120deb
Message-Id: <172384244636.3626293.1706479866897913727.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 21:07:26 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 13:02:50 -0600:

> git://git.kernel.dk/linux.git tags/block-6.11-20240824

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85652baa895b59b94bea29c77cb9b51cf7120deb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
