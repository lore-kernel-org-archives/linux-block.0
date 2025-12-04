Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E827466A
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764820988; cv=none; b=L/M3+PUfRCGzmon4E0pHHsuSBigMrG7oK0cC862Jr7JF/93YbsV+57kZlMTxJJD/QsyN9g3YoEuAVFZpFRlwPgZEOnXRZdttpokl6GY20yuBgxVWQUinWyNQZ4CzNatY/Kevhqg94dzGOvVm1Fc7zojdSMtEadjyiNn8ftB3PfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764820988; c=relaxed/simple;
	bh=r0MqsIEwe7Hpgd5bv1SdiNIZXqFYXuDLuuaf1cqwQu8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CMlfHdxslF22a+gJgFBZpnn9TcTNKtjDUo8Irga2k2G+YP/4jJZ/DA472UNeaJZMx0kA0MoRZ8DCVXs1CI0FkcFM+Kkl+ZCk6q/9MfDcbaVibJjCzplbMC1TmNU4pXlQ5IcKhn86HMauCxX+mmF0OKR038GdIwo7hL1EYD8pHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syfX6TnM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syfX6TnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68662C116D0;
	Thu,  4 Dec 2025 04:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764820988;
	bh=r0MqsIEwe7Hpgd5bv1SdiNIZXqFYXuDLuuaf1cqwQu8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=syfX6TnM5e/Hp/iigwgxSTKXcnbSPobM7QSVqz3+BKTLL8xqWBDobn0Jsl7eyN5+P
	 oSIsA+zZOqwbBYVDMXie4g3rGCPDkYznnCsApkcD0qQeD93l25+DC7K431SWZkl5eO
	 W5sg3GHL+dXBTqfFEzB0uZ82EV/ibH+nUrm44a7a1Mm3KvnPTBxv/i9K9hn8kIKgKg
	 lfHLBHwYfv59B2CFDVrQV4nSwvYgQQXmiBnNXCPBbpBhNRu8BbwAWbiZiD1i8OzhHt
	 qnu/onIm8MnJupLvP559rwZlk0W72oZYtXnpUn8aFNdp5kOobkb6i9NrmtucsjtPf5
	 chVgJNPpqKRLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3CCD33AA9A84;
	Thu,  4 Dec 2025 04:00:08 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <e62f9ce3-00ae-4453-8047-1f938a5d51a3@kernel.dk>
References: <e62f9ce3-00ae-4453-8047-1f938a5d51a3@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e62f9ce3-00ae-4453-8047-1f938a5d51a3@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-6.19/block-20251201
X-PR-Tracked-Commit-Id: d211a2803551c8ffdf0b97d129388f7d9cc129b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc25df3e2e22a956d3a0d427369367b4a901d203
Message-Id: <176482080708.219416.8768764612691209658.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 04:00:07 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Dec 2025 09:12:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-6.19/block-20251201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc25df3e2e22a956d3a0d427369367b4a901d203

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
