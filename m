Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D3221FCD
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011519; cv=none; b=VkLF7ErhjRc0VdvxOZZ/nBCIewJB0rvw2yC3GmupYNqtEk45EAydQ0H+H6Qmmw4SyGeCBnhfwdSpzbyrLJHW3MI3yFJb2q+lIx5uXnUdAMcqfROmC7hE3qj9sib8xwmnf2KH2Ryd98ntzt2e70bIC9WLd6PiyY06PA+CTgN7GaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011519; c=relaxed/simple;
	bh=t+RyrOIUOP51gmIIUrXO2JWUoUNyBDr8t5EpMiZLe/Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jtLjtbympJtbPpPLmkFZz9nqxtElAwqOERBEKFIdI8wS+UNroOc+U+APrDQ9QGG2xTLNUhITQmqLx7FqywalCZmQrvy+/6dyvD+7Exa2XR+z3ax3Gzxr4REtTLhlB5wbQc6kjlRjt9HtiDanEbjwd49fsdDfpRGIZ8oiPzh8KXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLyXWyol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLyXWyol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D427C4CEF1;
	Sat, 10 Jan 2026 02:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768011519;
	bh=t+RyrOIUOP51gmIIUrXO2JWUoUNyBDr8t5EpMiZLe/Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BLyXWyol6gmC4Snszt60t099ukIMNEp6B9qpIVJfAbWQujl0089lYudl9ZSNxq1Bs
	 21o5KxY8v42EsTKjoZ6JDI698HbNwCWqvPidECMr+XIgbnrxjrrvvx9w7fjxXHpEoK
	 XCIaspZCCIk58Alh9hW7GPjX21fTKCTdEQMLT4J0EECUtA3A9ShP1u29+kal6pMB4r
	 t5UNIUzXBU0ECuk3Y+osJ/SV69yTeapOjS7/8HyNXNzsE5JZDfm6iaoChTRvnCcrLA
	 PCmM8UPlXoFOzdEeLRgRCRRM0mzCnYe49dB9uM/nNZ0HQB1od3Ni2oU8FT21By3dyN
	 1lbOGtOe8tBrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6F23AA9F46;
	Sat, 10 Jan 2026 02:15:16 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.19-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <a4c67857-e36a-46f2-9912-bf2128392c52@kernel.dk>
References: <a4c67857-e36a-46f2-9912-bf2128392c52@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a4c67857-e36a-46f2-9912-bf2128392c52@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260109
X-PR-Tracked-Commit-Id: f0d385f6689f37a2828c686fb279121df006b4cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb2076b0910f3b19036ec7d50530113fcb9736c8
Message-Id: <176801131472.452892.1546815836227473762.pr-tracker-bot@kernel.org>
Date: Sat, 10 Jan 2026 02:15:14 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 Jan 2026 11:47:15 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260109

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb2076b0910f3b19036ec7d50530113fcb9736c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
