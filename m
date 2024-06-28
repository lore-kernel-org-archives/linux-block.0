Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00D1CE098
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594073; cv=none; b=re4Ex13KO83c3fRg66TDwp+RziPSPIklWOQ41G4NqKD5ZpKg0NBD9FHqg0ZmT0MHIDPsxx3G1BHRZE2Pd6S6AQjAZZK/wWxBcNdF/qvRd/cHqgADd56tzRqVMl6RdNBg0sguzZ20/bp79yFFLRS+UnS+aR1V4z8mvLZbtYPNUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594073; c=relaxed/simple;
	bh=+oElqHtaPsO7VefS8Guz9e7i4ftTfesV6q86fjVp0S8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AiSjGPOzLP3p6P4DzYwwIXBx4lRO+ibMirI1DBr24FZ+5LIcA7Eh20DEUOeu1CdHoRFwX85Y+RNyt3wI7Vs5lcG+nsu3D7SxvLCYqnP3NDr3+bKd3gxN0TaGgQXOeHBWkixjiyeXkHMPhyQEbXFfwJtkoLzqjE4ueE2MmSbRpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExZes9aE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExZes9aE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDD0DC2BD10;
	Fri, 28 Jun 2024 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594072;
	bh=+oElqHtaPsO7VefS8Guz9e7i4ftTfesV6q86fjVp0S8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ExZes9aE9UttzJLG26vuwxsl/AFAT5AXB+vbKVzJmRp5EEAGmdi1zmjXaWY1sZnhM
	 uDz54Zfy/ciA62QaR+SGYXhT5qcZ4I6mC69RxCEnvgx8jBwb1J3pcBjBZPl40kUutO
	 kasUHlSASfHDXTYtm+2qDfDwmBa0MS9lKpZfdTIRfSSOJSNRl7ra2kMVLh4aod+0Vj
	 viIlSglQM4aQFqkmzA+Y5ylAjLx0LqnOAppEnu+jYyd9Yd/LZw/2/IoKB1bO3vjo3s
	 hc4zAEmkHwYCIfgMpasYAA452CYsOt/khoiiCuH1gk2o7K/Yjy/FRPX3lQQARgF2kX
	 TI8YfhORmBiNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C35F9C433A2;
	Fri, 28 Jun 2024 17:01:12 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <57af218d-4c23-41b2-bc1a-401eaf393888@kernel.dk>
References: <57af218d-4c23-41b2-bc1a-401eaf393888@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <57af218d-4c23-41b2-bc1a-401eaf393888@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.10-20240628
X-PR-Tracked-Commit-Id: cab598bcef0971f11679b048cc9f502cc8143c88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd17613f464e15ad0ca83de7ca79ba72e4e72f75
Message-Id: <171959407279.14402.2314861456774730134.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 17:01:12 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Jun 2024 09:08:48 -0600:

> git://git.kernel.dk/linux.git tags/block-6.10-20240628

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd17613f464e15ad0ca83de7ca79ba72e4e72f75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
