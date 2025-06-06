Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F17A31
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241880; cv=none; b=IzVf2Epc8V0mo2O8qU9nY4W7TTlAO2vTTu9l8edDGWBQGGaEX6qebnPRlrsvueLrRo+3dREeKl1HtRfuejRsK80jRGNOwWEiBB05lwcPjCzT7mZrq9ZRlTsFZEvsAr0X2b9C/p9BJXhoMRwYt3VNRNbF1mWo0XshyDyP0Iyflfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241880; c=relaxed/simple;
	bh=Ak28NV7kFuRRICDTvawc5aLoEGdbBj3UvbT/jYDdxiE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fv7S/0Y4PW+Vp19YECD1vy3d0vKT8S5id7oxu2AafOaT8vSVi94vkVYQD4BfzXRqhDkPnpognN6+bjeJAsHIqt0915aANRuZh28/VFr9hHNVcBHR9ZHQn+eJ6wW9EqRsxJDMhGCyCQD2/BROm6V/KNHZj9YKQe57xuftSCVyBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqOTfpo8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqOTfpo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A99AC4CEEB;
	Fri,  6 Jun 2025 20:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749241880;
	bh=Ak28NV7kFuRRICDTvawc5aLoEGdbBj3UvbT/jYDdxiE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oqOTfpo8n76/qZLP+sjdyS4JNMHpW1RAPZT0Jdov831OUbf7io03hPza269aiWIv7
	 DXz5dwD2xO+PVJkJ9pS5z6dwtOy5kZ0N2fHA6YBk2/82673YeyfieuhFzKndmgPj/J
	 u4oiO5Qf2fwb3dJ+Vt46NbOtL66P8/0Y3THnvZ9jbWhbQQVOJEvCdggybwwd1fw4kz
	 Wi6HKQjKtc9n13obEjBt1igq/JXtgB8RuBohD81ND2DwTlZ2dItttbllLvmWCuC5nR
	 Rsfl+iZu4/B92ynHDtL5F3FeCqDKxY7BFcy4GNgWL6jjjA8YirTKzGKZiW/AN/JABI
	 29JcCwPG0YREw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02D3822E05;
	Fri,  6 Jun 2025 20:31:52 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes and updates for 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <0c5db2c6-2e28-47f6-ac57-8b9a21415191@kernel.dk>
References: <0c5db2c6-2e28-47f6-ac57-8b9a21415191@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0c5db2c6-2e28-47f6-ac57-8b9a21415191@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.16-20250606
X-PR-Tracked-Commit-Id: 6f65947a1e684db28b9407ea51927ed5157caf41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d8854216ebb60959ddb6f4ea4123bd449ba6cf6
Message-Id: <174924191142.3981198.13484662495343894637.pr-tracker-bot@kernel.org>
Date: Fri, 06 Jun 2025 20:31:51 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Jun 2025 07:52:00 -0600:

> git://git.kernel.dk/linux.git tags/block-6.16-20250606

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d8854216ebb60959ddb6f4ea4123bd449ba6cf6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
