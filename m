Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994512F5B6
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198808; cv=none; b=Rt/5qFkrSXGO0vN2etD6cY4R9JUnHvLxqfO8lgdKIuiyBHiT7v9sNRvVPxwC/1qnnPiKnRhS8UgRYRA+5FlJPrU8HuJc2y5WiAtiPqojiWf0M4xjgApW9hqK2qTm0aaNjqGhN9CiMO+Mh5Ho2l06ftaDHkKoh7GbQD0ej5QbhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198808; c=relaxed/simple;
	bh=p975gcvL0dg0qtxOHJOQPwd7XPiUf8bzR6HutMbS+Qs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kcf/4mH/dKGHSu0EeSIAukPTa+xHTsQGQYHf1ZTasyNtwSoKbhNw4aczhE++4JN7w4eQvTMtRY2rMks8ZNiSA7k06vnxGaVYmRYsLs79hmCpnMpKCvzEO/l7xhFAfht7erSvgNR6pKErO/7BwOi3Nn8YvD+EpsuBIJIG1zT2rhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYXXzyMZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYXXzyMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA93CC4AF07;
	Fri, 31 May 2024 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717198807;
	bh=p975gcvL0dg0qtxOHJOQPwd7XPiUf8bzR6HutMbS+Qs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hYXXzyMZib5rHmuYOEaTMhV23J+1pbC8sEiIlzm39l5dBUfK1yov7KEPkzAIBJwJc
	 XDwKd4e7OuOxvKoU0+arIu7ba2o1mCAJyHZRR/0owWO2ETVHC9wYl8+OG2AZnKQ6Iz
	 KcOhUFnVhYpdOi8waJxB71K9KZWbCZRN0wingX2MJQDAJHmQg/veb49VAEiBufhhW1
	 XaMS54f2a8Xh5p4IuTgIbRYzYdRjcVysPxbu52zp9ka0n1M50ZX0XmV/6mcUXUlpk0
	 AJ5CzaV+W2xkmdoQWCM9oXyqoIB+Sv77xRzAcoUuE9QFlDWUqxoRAdW/qKuRKsOZRI
	 fJKEW2mAlgBLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA3A5C4361B;
	Fri, 31 May 2024 23:40:07 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.10-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <87063af8-c102-4e64-a00d-15d76786c893@kernel.dk>
References: <87063af8-c102-4e64-a00d-15d76786c893@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <87063af8-c102-4e64-a00d-15d76786c893@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.10-20240530
X-PR-Tracked-Commit-Id: 0a751df4566c86e5a24f2a03290dad3d0f215692
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f9a75179da33cc03594b882ed823cc5f4356d9a
Message-Id: <171719880767.1891.8455959760067586078.pr-tracker-bot@kernel.org>
Date: Fri, 31 May 2024 23:40:07 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 May 2024 08:33:53 -0600:

> git://git.kernel.dk/linux.git tags/block-6.10-20240530

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f9a75179da33cc03594b882ed823cc5f4356d9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
