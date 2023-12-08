Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1837D3E
	for <linux-block@vger.kernel.org>; Fri,  8 Dec 2023 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KACjTvuo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 378F4C433C7;
	Fri,  8 Dec 2023 20:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702068327;
	bh=f4pp2xStVt7D86FvvQ+g04YLTRN35jg2ZWG7h3JNpkI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KACjTvuoHZa25peac6AfkApdaW66IGGuMbw0P3D4pmPaj5MFqA9RgVVhIJoOXGNqq
	 WI0KA1cw0otomSWWCXATKQJa4jiWXc29mokb8RY85TFL4Y2U7jRrpqVNwqFWCqgC1J
	 LbQ6uhXp4Uimz7VJ37GWZyfG3H2Bsr9E+NpryvdlNftUjo3daFMyjrCa6m35Qvmep5
	 oVtRWEWUbTiN7V/ZMvocCmKa/ZdUgCvvW7g5QknkoFf+7+cCwV3S2FE8oIpmmnJ4S2
	 PQC3T3Vhwg0a2l48rZf4brcA1xB3HVV0IvFjg4LAaqhaCmBJxz2xqCblcVk3+qDMrf
	 cOcgTunq9YjVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25AC9DD4F1E;
	Fri,  8 Dec 2023 20:45:27 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.7-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <10082935-2c7f-4f88-b318-b8543583987a@kernel.dk>
References: <10082935-2c7f-4f88-b318-b8543583987a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <10082935-2c7f-4f88-b318-b8543583987a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.7-2023-12-08
X-PR-Tracked-Commit-Id: c6d3ab9e76dc01011392cf8309f7e684b94ec464
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d71369dbe0c5c1217dc681d6871b7918b2996de6
Message-Id: <170206832715.6831.10573900674815316451.pr-tracker-bot@kernel.org>
Date: Fri, 08 Dec 2023 20:45:27 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Dec 2023 10:48:57 -0700:

> git://git.kernel.dk/linux.git tags/block-6.7-2023-12-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d71369dbe0c5c1217dc681d6871b7918b2996de6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
