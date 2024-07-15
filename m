Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A213D28C
	for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721079340; cv=none; b=qUuBvZXZjx9XZy1C4ZfoPQ9fG9M3Yq1Pn45dvv/I+kmrQvK8VO05brszJyKBibUoszPv7SHcxMwJ+I+7z86m6FQyh1jp9yncRSuQkARrS0ig9GrMsshmTDJ8oaGLYIpv4UXJv/EUfPmpMrXNdOTEogbBS1fuQQHpdqkaWB8brrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721079340; c=relaxed/simple;
	bh=IJLXEjIfhcoJzQZe22uPzYTpjtns8+2kKJ27p508HBo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U3maERNKDeNI4LOAbtSjRVkuTTyMKp30CUAj1wa6Z24vKbmyXAWo76DcwLIxzTm45nRmfiSudl9Qk8O8L3Xnd4QiY4OUEYJcGtLEEnTkoMgzy5izYePFOxQQKx3pYzxuZWnXVGt4oSgug1jDuQvavJFBIjJZ6QZHGSzMFSV0hpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgScpBFt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgScpBFt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64BA1C32782;
	Mon, 15 Jul 2024 21:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721079340;
	bh=IJLXEjIfhcoJzQZe22uPzYTpjtns8+2kKJ27p508HBo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PgScpBFtH+0YrnjJbZR0Vu0ViT/h3tqte/KTt9OuntebvkCLXF40UGRJI2MNw02BT
	 0vjmrg2R27tsLZTcltVFUWKGj/Bdmr0eoGTn6ZXre5/KXICMLi20yem3M45mqnm/Tr
	 BoQd0CsVwh62em6ztnIiI/OVSIYwr0rg7UBTmuzE6JIXa6svdqkaX2newyu4RichW0
	 568IUhvNrE4QYaIcNWFrtRuPDllDdn+DJUmEy5phpsAGJ6t9exX23V7sFjxtuVZqmw
	 OUXbD6gPB2LJfqYomEU1uZsy2OvQJsUAua7xjkxzoWBt3VRsUISYBE3l2WZB2kzT5z
	 vrG4YQ19a/JDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CBCCC433E9;
	Mon, 15 Jul 2024 21:35:40 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <e988d4c4-f8b2-4cdb-9915-790abf69bfed@kernel.dk>
References: <e988d4c4-f8b2-4cdb-9915-790abf69bfed@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e988d4c4-f8b2-4cdb-9915-790abf69bfed@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.11/block-20240710
X-PR-Tracked-Commit-Id: 3c1743a685b19bc17cf65af4a2eb149fd3b15c50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e7819886281e077e82006fe4804b0d6b0f5643b
Message-Id: <172107934037.10457.9787013617320332306.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 21:35:40 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jul 2024 23:44:25 -0600:

> git://git.kernel.dk/linux.git tags/for-6.11/block-20240710

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e7819886281e077e82006fe4804b0d6b0f5643b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
