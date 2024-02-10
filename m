Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57F5C8F0
	for <linux-block@vger.kernel.org>; Sat, 10 Feb 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582375; cv=none; b=mgPSkhdlHuyioAxFrdHHdmO7xWgbFw+2uOQmOshenfwTEyeVKcGGJvnvbwecUwAmnwX3MEsYQQUWnPedNej7jQuRXlh7juTyT25v91UeVtNG7e4o3TJ/NFOpdrFfm5h5k9kni/dFFGaRpxmcni6m7M/hi27vOFmFaHlWEbLgUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582375; c=relaxed/simple;
	bh=c+KjeAjfZIKQhoXTBRt4PipR3yahZdYBEzTJkzg5D74=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=S3XB7vw/kCpFwYE2C7p/eCUgeeh4a/5rZ4/iDdz5LlFUoVMS1CAsvQrt6KCR6Aj2XT+svDM57ejM5Dl3bUHpwUYd5Ejelcm8yT/5eLsNglVtYO1WN3V8pbbyAINKLfhM+XyUPlcXVRsBCNrVs95G4H+ig66MCi47+ZhMwrFJzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azvLY9I5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azvLY9I5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A411DC433A6;
	Sat, 10 Feb 2024 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707582375;
	bh=c+KjeAjfZIKQhoXTBRt4PipR3yahZdYBEzTJkzg5D74=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=azvLY9I5x+ma41J7KrGFRtZjr/qz1NVhb+v/mKzM4GE2DZY219oozliVLTZvor8KQ
	 GDSKde6ZtHBHHhTrd+FpysP//qdodMGpAom1h04W7IiKaRycN6e5HyVaz1ohmAorp7
	 JuzjhSpZxF/bOpT1koxaLZtufjoXrwNLEObddElHeY+LuLr6Hs+DOZAkvmX7FfU+al
	 O3N2nnQPoJ9bSuTELCBMcCqKBOOyu2RtUhV3pRtCgwiK7MF+yN6I3PKxHOaoIm9Akh
	 EQ781eX9zQMlgibFpS543MlUTPfIO582jhYd+P69evE19QWS726Fj9UeVDuhlIN2bc
	 pd4BdwCip4XQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89C65E2F2F0;
	Sat, 10 Feb 2024 16:26:15 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <d020ae53-c231-4a8b-ac6e-b7ca9788073c@kernel.dk>
References: <d020ae53-c231-4a8b-ac6e-b7ca9788073c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d020ae53-c231-4a8b-ac6e-b7ca9788073c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.8-2024-02-10
X-PR-Tracked-Commit-Id: 5f63a493b99c848ad5200402bebe26211e00025a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5b6244cf87c50358f5562b8f07f7ac35fc7f6b0
Message-Id: <170758237554.1913.6344985720683488683.pr-tracker-bot@kernel.org>
Date: Sat, 10 Feb 2024 16:26:15 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Feb 2024 07:16:47 -0700:

> git://git.kernel.dk/linux.git tags/block-6.8-2024-02-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5b6244cf87c50358f5562b8f07f7ac35fc7f6b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
