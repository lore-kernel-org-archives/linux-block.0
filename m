Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0151D53A
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632025; cv=none; b=UMKlGwHdbDirglUFmSqprs3hQu/1D+Vm/T1lBTmcFQY5DbnYBbBUPj6/oBm54c3RdkclPjdYY8XJm+2xopbcaF5vIQ4/wapNuYVdeduiR9sxfb0VjQbxPSfv1Zu6cxA3R/Sc05PRUowrQQvq8GSotSmW14MoHevn782GurSGpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632025; c=relaxed/simple;
	bh=fMVFdlTbxfzNsEfzzZcJasxPQmuT8SZepW1fKlDIwGw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oupGVg2N+dvdi3K8va42SgfYcikw7tDtvuIQZ9XEUOfrne+COPR9uS+Chl9/2wvwrbs37vv24DLl6KaSk7XfL0cbh2v7iL1vQDF115euEqGNDt/hr7R5+Q+EAOkgidtsT+TxSx2CKzl1JKsFJh46mQiP9PV20GlI9LOrP9NGzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlCouuKG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlCouuKG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 540D0C43609;
	Fri, 19 Jan 2024 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705632025;
	bh=fMVFdlTbxfzNsEfzzZcJasxPQmuT8SZepW1fKlDIwGw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qlCouuKGRm/fDdOCkd75Sm72NpVime5vObpWO/aWGmV5rTStPaa6vcJC/gC4Pix0e
	 dwkd601B5iL7lILVUQTVG+Jmi5Vnii+Ph66yEMCXC6+ZRijtwbigdpBkilQP+O/Q6O
	 OGX0F/c4um8ogoKgItI7nKc70fkjvqkNV1eul6mXozTYZKraT0tcqNPeAcSvWSsCbn
	 Mu82Cwv5uBpy5pRMLHnJ73lbOGnnYG6ZvXecX8J7+HoLa3ZGiAqDCcw+MEza0b6BMV
	 twbbGspTrwbykjobqM7tZTZzxcoyjIlOuNfSuRE+52/ky+wz1VQPii5k/nJz5iqDm2
	 iGtYvBtO7WW4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42AECD8C985;
	Fri, 19 Jan 2024 02:40:25 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block fixes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <78f34b79-cdf9-4240-a25b-90a948490e36@kernel.dk>
References: <78f34b79-cdf9-4240-a25b-90a948490e36@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <78f34b79-cdf9-4240-a25b-90a948490e36@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.8/block-2024-01-18
X-PR-Tracked-Commit-Id: b2e792ae883a0aa976d4176dfa7dc933263440ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847
Message-Id: <170563202526.16016.2959873453653822353.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 02:40:25 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 15:12:38 -0700:

> git://git.kernel.dk/linux.git tags/for-6.8/block-2024-01-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
