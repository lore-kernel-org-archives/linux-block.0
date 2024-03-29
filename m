Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303213B59A
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740458; cv=none; b=RfKRph0ARlN9Z12jw3/clLGkwM2Wins1RnB2JIglKBtZ8EOKMT5JodP8Pzq41UiiApvdBZ6QTXDd9H2XA+/uiMqilT+R2TuhcTHdqM/8hqC/CNPdhgKi2jSXzwC0KKp9FznRgIkF/GiKtc1KC9WlsgPjPXahLjsvqBH8t9q8Crw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740458; c=relaxed/simple;
	bh=1g9mW8lW82MoLUXbHlkWvtykfN4GyQGYOC1WLnCr/1s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hB59LmjlXv8tfShEdnrHUJzAfjsPb9JNiUX6S5MV4LweGCR97ROe67XZAX/zB1sE50SVHDS+LiWkemfctkoC32Yd73s+IlVvpzuglYRJ093IJRbU9CCEEtGubbby0KPoRdqNwgVs2LPaxApDygcOqj8J00EcbrgJzmrxobdGnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drzZdW6V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drzZdW6V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD703C43390;
	Fri, 29 Mar 2024 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740457;
	bh=1g9mW8lW82MoLUXbHlkWvtykfN4GyQGYOC1WLnCr/1s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=drzZdW6V2RUauhOUBGcQosHfnGvc7g/jClVvwg4I4Ou+CCgFM1tcZtraJAdlWtMFe
	 cLMfsG6BR/0Ec8NT5i5F5nHMzheOvJn066Aaia2TaxBDsOoaAojvI1TaN8737LG65x
	 lp01gML2OzKCOy5549g8F3j7wu4l4xOwJoh3SJ6M0Id0vF3xvpvrDVZpqe8h/BXMbA
	 l2KAyDpTfLK9EoF09PbHKe8ZsV5xSW6X2UE48QbIM/UN2HvW6jcqCddmJPFMLlmWmQ
	 qP5CZRc3VglobbGN21I00QNuKwh4EQezVGeXE6Lp8zmUEG2RtntxeGTzf90OAJIF6r
	 0BxT0u7y0ggmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5016D2D0EB;
	Fri, 29 Mar 2024 19:27:37 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <eed6cd8f-58fa-41b7-b442-141752d16237@kernel.dk>
References: <eed6cd8f-58fa-41b7-b442-141752d16237@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <eed6cd8f-58fa-41b7-b442-141752d16237@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.9-20240329
X-PR-Tracked-Commit-Id: 55251fbdf0146c252ceff146a1bb145546f3e034
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 033e8088a41a0871231cbf09fc6fd534830dbae1
Message-Id: <171174045773.16736.2904768378216926785.pr-tracker-bot@kernel.org>
Date: Fri, 29 Mar 2024 19:27:37 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Mar 2024 09:28:29 -0600:

> git://git.kernel.dk/linux.git tags/block-6.9-20240329

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/033e8088a41a0871231cbf09fc6fd534830dbae1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
