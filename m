Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682BC348C77
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742683; cv=none; b=jF0zKX15ex+EEtRNesXSu5mL2pT32lzmgZ7X1kMgEeIGlAeCyhgSDvz7Ua8WZyZPAuAX7ZsOZlcToYIUYw798nB8apE/D1Zmtcjh6qKnVlUtohuZxInshkliT5mghEgcIJSIBDrVQPSo79v9gvRi66BQfUAIUj7TDRf2q6LvFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742683; c=relaxed/simple;
	bh=6bUWNVh9Un8BdioMLfas7piVaoglcE8nneJf+zPrBkw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DZff3WmYROOKinEuqsTpxhar/z9PBvigHnSCH4ean0ILD1rhMlO7o3FFk7QCxhA9QUbPsXpfCa3BdfObMnwwxSl2j8RPa06t0AIUViRYme47eVunlcodeJJg+Jl4DIyLiLEUWWjfe3IoP2LmGy5k+10pRshEihOx9NEfDV2ZYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StFWiRhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StFWiRhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7661F0089B;
	Sun, 11 Oct 2026 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742682;
	bh=XXPvDakrvfz5a/NtgtDLaNGU4atoajh/4YclHL2RtTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=StFWiRhzEc+Kpcx3ykhovEjohM64Vi1qHFAJ8vFrlKsuky6xAaGlPlrjgCxGa/Q5I
	 qKruI414uubCX3OL96m5cs1pA9HNqfjt7Dq9vrGR6yhhndj0KtFajAlmGpMMly3ZoF
	 PlNWewmzOz3pGNM2Vl+/vq81AGJDRXmOeBQCSn3krF0jiAMD/ZTWVUEUkUUF5sHAjp
	 PJNAkMq4giZFCwZJz7N3cWMEXC/VwNhr77BDaLke5J/2ocA6M49bMrz2uIpCmwiVi2
	 QIXoivU6xx1hMMobHtAgplpr9ec0g6w3Q6/RioMYuiN4t40fCRjseEc7rxX9SIh6zc
	 YWnKb58Z0bU+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A28938119D3;
	Sun, 11 Oct 2026 18:18:02 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <130f6944-5862-4c10-ba2c-48ccd1b2088f@kernel.dk>
References: <130f6944-5862-4c10-ba2c-48ccd1b2088f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <130f6944-5862-4c10-ba2c-48ccd1b2088f@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20261010
X-PR-Tracked-Commit-Id: 41cab3a71dc7be62114d91cc849424879062d324
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4375b45d7060a6a3f41e14a9181c5c913ea474a4
Message-Id: <179174268082.2129915.13947965720510235474.pr-tracker-bot@kernel.org>
Date: Sun, 11 Oct 2026 18:18:00 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Oct 2026 07:13:48 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20261010

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4375b45d7060a6a3f41e14a9181c5c913ea474a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
