Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FA182AE
	for <linux-block@vger.kernel.org>; Fri,  2 Feb 2024 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906610; cv=none; b=FWs2/g7LLm8AuJyY9TNJcS9i92C/VzKn8/9c9WaB1ABF38YWvvcYF9+c1BqgLdxDzaf/BJNZ8xzIRJ3rb227uoW7SV22ra6PB2a2WboN+dqjVmeLiKxKoJxnwIryWATaelaUijQAbeSwA19z5MaCy1w0pNLBhnNUfihoRwJ5mU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906610; c=relaxed/simple;
	bh=ZhhBXjzgC9ltI3d7VKLnmSOZkKEnoNa/VT3Nzebfr9Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A5uWfh4Iy8O4F5iR8WFgx9hr96EkCUd7Ipe+BTA1kL8E2PWZ1wUfmlCi9xZTsUVMg1MpPTA13QrFVoCw8P0vh9MaVjlQmu7uO3vOO8BGrdxMRxuNy3eDkJwJQ2hDUB1Kp/WiYxqIej6N/fyAkj0KGPn+Tpde6iKZLr7Sa01T8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1o8sDxa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1o8sDxa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A19E4C433C7;
	Fri,  2 Feb 2024 20:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706906610;
	bh=ZhhBXjzgC9ltI3d7VKLnmSOZkKEnoNa/VT3Nzebfr9Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y1o8sDxa8oOq0IWSujUljD+d9iAmvMFaBXn7vccDyuRsMKLoBRUMTOBWDS1ujzT86
	 B/Ba0YXoelPWIdSYGVoQ59xdA2Uvx39OPIlAMQNmJMwaU9DZ7AhjqWAfnfi8/SLaFj
	 1DMwLqphYDEe63WMVPcbPkeIUMVQsXN0b1vWthtGui0sKzlQbdiocvWnFYRqDquG8l
	 Qpfz8hV67uFrAgRdceLBIq2R9J0SbqnlL0JT4P8O7KschwZT6lnvd+ioAJ+vE3m6jv
	 xeRDbi1/KqfATHas2SuCBOh09CRn3Y3Pj5U46SnLA+meKy08fhov/LlfaoKJgGCgT/
	 mPML850r4goSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 905A9C04E32;
	Fri,  2 Feb 2024 20:43:30 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <7f20bc8d-bf11-4101-9fd3-844cd954d338@kernel.dk>
References: <7f20bc8d-bf11-4101-9fd3-844cd954d338@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7f20bc8d-bf11-4101-9fd3-844cd954d338@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.8-2024-02-01
X-PR-Tracked-Commit-Id: f3c89983cb4fc00be64eb0d5cbcfcdf2cacb965e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 815a76b9644eb91d005c56773e344bfcaa4971c9
Message-Id: <170690661058.32059.15397683836948140904.pr-tracker-bot@kernel.org>
Date: Fri, 02 Feb 2024 20:43:30 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Feb 2024 08:16:02 -0700:

> git://git.kernel.dk/linux.git tags/block-6.8-2024-02-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/815a76b9644eb91d005c56773e344bfcaa4971c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
