Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D5274B53
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273003; cv=none; b=eQX6PkbpUl9ysuAycjnFymHxb2+Ln1c9eFDtIZC4SBnxsiPycLDMyLacskANCCAX/x9pDlLFoyQtFIt00/2Krw8nlrxfnK0+NAbdMVrPW2e6UIy5gmDCbgfNY9d+9w+AsqIL1RA4EP8kBs5JIIdpkAdDro7cFmxhIn64Vs6/m04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273003; c=relaxed/simple;
	bh=bBYjPInL8Bj3mnCiwH2Ref9sfDMnbmBo+xfwFDH04JQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DoFZ27VRjIF2omGyaL/OW0m/o7yoh7fMnFsCWdmwRpSYUEQwrL2Ef1+GaJu/1nQHxT/ekbt8fIj87urRn7aN0VJ7M9T5SjCVD9CTMPJTWK5dPaAJ8Td0t6zYWYBmto3ME6iiJTmmXN16/yTX/92exO1gfHGiUzrzqWmPiiQCRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJd1GCui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJd1GCui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89289C2BCB0;
	Fri,  8 May 2026 20:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778273002;
	bh=bBYjPInL8Bj3mnCiwH2Ref9sfDMnbmBo+xfwFDH04JQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fJd1GCuiS/BOJ+E7jMhkYev6RXVl75MeSRxXCyOR4TETJpUTsx9OJQoFQRDtzN9Ye
	 yTin8CJHtltBhgSEVeX+yMzdmv7bMyUwv3YmEDDkd4Sn3TkE4G0zCVgKVlNc/Ko+dL
	 JcCqqnTHHHhq6hsOYwVkxCx5nZoJID0nN/2pnw8m4vgHKDTch/HrhP0jZALOpNwCsP
	 Qt9QYxy+UE/MYqP6NrF7/Yjt1qreCQapXiYuPNd6xESLlobNx9/hPzo6IUFNka6Hf3
	 IpU4Q0WFsaJy5CfYoy8k1ZYTAr9g0yDQ+mAKGZU/EfgfKqToXkAUBeFmRyUKhIhoEp
	 lcd7eCqMrMC5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD2E38119C3;
	Fri,  8 May 2026 20:42:32 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <36745ebc-0658-48b4-9878-982d5644642a@kernel.dk>
References: <36745ebc-0658-48b4-9878-982d5644642a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <36745ebc-0658-48b4-9878-982d5644642a@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260508
X-PR-Tracked-Commit-Id: f7700a4415afb3ac1767a556094e4ef8bd440e41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbf457c584b5cbd0d44e8f05edaf3e189e894a68
Message-Id: <177827295081.841904.6522987089993134099.pr-tracker-bot@kernel.org>
Date: Fri, 08 May 2026 20:42:30 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 May 2026 13:23:12 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260508

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbf457c584b5cbd0d44e8f05edaf3e189e894a68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
