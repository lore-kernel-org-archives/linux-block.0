Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BC35838F
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423214; cv=none; b=Mt8wpTJLqIaYjKRFWRut01Eb3WSBUWuoQEW1+z7hSAbt4N0Ti/4Xo39z/465pma58miWkGgU2X1FLpBZavrJ6Ms0lbVnpJlP/9IKOTpAtmOadW0exRw7J0lKU2XJfwYtT73V9f3RZxTPK3/ggBwQ0Ini/Atren6Z8xZYLvuMvPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423214; c=relaxed/simple;
	bh=vE1iQxl6AOaGXDd3TKON9jGfwDjb3tStRdw5eWeUeSs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cZPS3weHerIlVk24K2YAQwzvTCnxMJBb3rFQDeY60JMquyZRwnp5DpRnV3KnFWk990+L18hQL7EkxrJ4UaOv8NBcGgQdSSk+mzfbjPr4s/B4fTMV3FdiRVnOWr1V0cqronh2fJ0+WtqiNhMIPs83wqffYC98XEmI/I75aI5F/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6ztJlhn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6ztJlhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE32CC19421;
	Fri, 13 Mar 2026 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773423214;
	bh=vE1iQxl6AOaGXDd3TKON9jGfwDjb3tStRdw5eWeUeSs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R6ztJlhnNf/MvL7yq8ItEa7bbMWgzZUSqE5EqLMFkiGpETNGQkYttYPgXW+MiifRD
	 NrBhs/v9C4PqsMSuIjPS342CX94VaeCwBmcjiqYyy+gCmZ297Q7o7ghzgjhdpbI2Vu
	 M6Iqs2t9VXDVPwkdsy2CEDjlWOvlHUp60fc0egKMJr2wlxTyZa0kFeHfbAEpN4tm9W
	 vrRd5VG+f+GYjzBqgsubzEutqvAIXtN/zJMq/kbbdHZKPdCUV71atT+jSVMGi6Jo1e
	 HucBJSrSJ6SmVCvmcK9N5OrIP5G53cREeE5awgnjIb5ddrmvvopnwDYOhwibQXlX+L
	 duYItRz4iIXgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C803808200;
	Fri, 13 Mar 2026 17:33:30 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <e5ffce8a-1a3b-4c89-8ca0-8178b9046cf1@kernel.dk>
References: <e5ffce8a-1a3b-4c89-8ca0-8178b9046cf1@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e5ffce8a-1a3b-4c89-8ca0-8178b9046cf1@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260312
X-PR-Tracked-Commit-Id: 7d0abefec48dfefeec28dc7c3105a88c43747d02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73548503dca50d2c2aa8c8cbb6eb8c1bf5959b21
Message-Id: <177342320859.1438840.804066954805552955.pr-tracker-bot@kernel.org>
Date: Fri, 13 Mar 2026 17:33:28 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Mar 2026 05:49:43 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260312

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73548503dca50d2c2aa8c8cbb6eb8c1bf5959b21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
