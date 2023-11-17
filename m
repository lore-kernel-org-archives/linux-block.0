Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D542A1A4
	for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjhdsvpd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6174C433C8;
	Fri, 17 Nov 2023 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700259358;
	bh=UmyNbs44UQqdoeU3kbYKBAfeA0vh3E55g5Rw/2OILME=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HjhdsvpdcbEEZdNIYWm1zNkuodo8ll36+64GmAcyl64T6Ik/Axo8wOec0TpUuedqL
	 7pYt5+gtxMOSa313xJeBLo1WpYs70BfvoeoKIVqBoO+bZDhTGv7x7Dvyy8hJW+9igR
	 fbnUW0i1YXzyqrL6gy69tVD1bS6cad9cgLWLvtlkRrxDdrsGuekUpDSQ78XRwDvJNi
	 IMkvt/gCNYpl7xPadvQYpaH+GgB9SnOmMETrT2B0SUqy/6rarZaDEzWk+5GjYa1FFT
	 DqzW/BRN7MksOOESr7/bIhCDftCjQ6BJPf/QdSw6lLCX/9iQ3ZeB6t4u7guouYNqfh
	 2rJ59o6/i8CIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D562AEA6300;
	Fri, 17 Nov 2023 22:15:58 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.7-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <3b2b5978-3c83-42c7-94c2-e44018ac8fb5@kernel.dk>
References: <3b2b5978-3c83-42c7-94c2-e44018ac8fb5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3b2b5978-3c83-42c7-94c2-e44018ac8fb5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.7-2023-11-17
X-PR-Tracked-Commit-Id: b0077e269f6c152e807fdac90b58caf012cdbaab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffd75bc777b4f86bee0e49a1b9f2c45dc4503001
Message-Id: <170025935886.27809.3637820229389855952.pr-tracker-bot@kernel.org>
Date: Fri, 17 Nov 2023 22:15:58 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Nov 2023 10:41:28 -0700:

> git://git.kernel.dk/linux.git tags/block-6.7-2023-11-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffd75bc777b4f86bee0e49a1b9f2c45dc4503001

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
