Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5518D
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944980; cv=none; b=qZy1RgIgICd6ZDrVU4WniuxvQYrHUH4/rMk5/kyNLAGSDdyq5FpJLljFbnnNkczd4WjZIUu2613/n0QSdtj/mA7VpEy114Msr6TsYgFkgjpGS3X3fCybJ5kAwozVq2y8OH7x+PE8Pk9BIT3jjbgo/B1WzUtLkLrb5z2UMf+tbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944980; c=relaxed/simple;
	bh=Wun5gZ55+TgGsK+y2+b4alFZnxiePjaLHakGz2lDKWo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fyTiJkq1omzTI4JITFO7HVdXywpANPAx6/PNSnXGf9ftD98Gk6fbp4545gBUAJQLSgx9zcSaskTixgANbBfNiU3r9Lxi1e2uJsOti6X7OCNxveh+R8+c/6vI05SvYf50BcWkMoKt8apsKM4NycXgXRWhTboxOBNEP1wtS3A4M2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib63dzVc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib63dzVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51406C4CEE4;
	Thu, 22 May 2025 20:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747944979;
	bh=Wun5gZ55+TgGsK+y2+b4alFZnxiePjaLHakGz2lDKWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ib63dzVc3x6mlvOvh6CfFWAs9eVWbbJkcrQi8IIg8yMgahPO58J8igsmOnwCMTSKw
	 Dk3+2es8j3s2c0Vyp0/8SJh4GJFQubJ71ys7QRHHmpme5Bjw7ekylg6wLmEcv0Hqd1
	 pVQ1e3l2Rm/FKNfkTuaR4cWip/o4luBZhTz/kmoJzavjkz+hBEUzaX0My3sUtjTolS
	 2UNSMT/nKVd3Nrd+2RuGRiaXTJmHxo5UWhEVOc0afrbnxGyf4chNRBRWJKmS2gHhPa
	 F6q77Sd0P0qSIsD2a2EsVbB4gd2iWZLOv4NhySo6fT9//LQBm2+Fnzs3hLrzdafS7O
	 duhfuad979W9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5C3805D89;
	Thu, 22 May 2025 20:16:55 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.15-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <75e87d71-b83f-40b1-9f60-dc3747fc5fc0@kernel.dk>
References: <75e87d71-b83f-40b1-9f60-dc3747fc5fc0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <75e87d71-b83f-40b1-9f60-dc3747fc5fc0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.15-20250522
X-PR-Tracked-Commit-Id: 115c011f5db7e5f1a1f4404a8f5b5c87a3534362
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a11a72229881d8ac1d52ea727101bc9c744189c1
Message-Id: <174794501462.3008483.10965690973163790465.pr-tracker-bot@kernel.org>
Date: Thu, 22 May 2025 20:16:54 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 May 2025 13:58:14 -0600:

> git://git.kernel.dk/linux.git tags/block-6.15-20250522

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a11a72229881d8ac1d52ea727101bc9c744189c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
