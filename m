Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE8F15699D
	for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487943; cv=none; b=tq5rJCKudatzGRdzvNWV2k/Ipy1mx2YkyW/+7U8XFvn/AYSUYX5GefCmtKn07KuusOEmzjx2//0OqRmZKRgkCuigIV/0B1sWyr88DEJCMziq1GLeDDISGIPEHXFCEMYze2ZnDOI9//GMAIRkBVqCruN34wKzMItRZvdPLkX7bi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487943; c=relaxed/simple;
	bh=89C4/+ssxuiiV63pYSI304fdYnjIq4tMgBvkG3/nDB0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rwk8FX6ypz/CQHkRuGkqtnWh1ohzSJP0+Xc00M4cM/Vb137egs1QfQEceiuE4+XR7Jykno6UUscCAawGEuz68JeB2j4y75ebTO/5zwWyTIC3TWaPxBT5jlvtfWJ/Qdjhqk80cQbTSfvbS0EwpWj0dUH/yqwfbKNCiKQskwXfzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HClfnsm6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HClfnsm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6275DC4CEC4;
	Mon, 16 Sep 2024 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726487942;
	bh=89C4/+ssxuiiV63pYSI304fdYnjIq4tMgBvkG3/nDB0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HClfnsm6+jeLskQTnoqoZ/qeJQVmQBVwNYWha8DSGVlgLkKGX1sXSayZjhBfD0Icv
	 PX/lPEVDiF/wtBmDxOhVwA/0fsCGKFVB6Jcr/YMj8iF37w+FL8EvKL3VEXKxL6TcW9
	 FyH1J22Mzvp858+gMNFF1BOWJXq8c1N1LADL4xGjQVUMziahvthpYt1h0ruB0anLIW
	 LHQ3PKO2c9hgnIHV+STZpRkWCVdR8VSroUYIqYn91AmOyis2eo0dkvAuTLpS5Z/eon
	 iYLYjlewZymhVKtRTLKSarZdVX1zu3l6RTaPTArhRA6KGoJSl5x6rvIGcMLXgS0bLs
	 KGVKWu9TNRDyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344893809A80;
	Mon, 16 Sep 2024 11:59:05 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.12-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <00feaa2a-c4b0-445f-ae13-a23c5435c47b@kernel.dk>
References: <00feaa2a-c4b0-445f-ae13-a23c5435c47b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <00feaa2a-c4b0-445f-ae13-a23c5435c47b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.12/block-20240913
X-PR-Tracked-Commit-Id: d4d7c03f7ee1d7f16b7b6e885b1e00968f72b93c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26bb0d3f38a764b743a3ad5c8b6e5b5044d7ceb4
Message-Id: <172648794373.3670563.12545618414233317833.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 11:59:03 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Sep 2024 11:02:17 -0600:

> git://git.kernel.dk/linux.git tags/for-6.12/block-20240913

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26bb0d3f38a764b743a3ad5c8b6e5b5044d7ceb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
