Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD81A9B46
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239359; cv=none; b=YhH8hSIPjiPd/wziyG+pmWRtltmn4gki0a/nO9lMhX88UdjudC5o9Oi+t4GJr09oMi9aE0ekPxcBcZeFyJeXzQxDBwmz4xqMgQP3pG5KSSnxMaejX4Wpqb3pPlMz4zj5QVDfRcVdJfLJx0kGcUK/Jimay56rrPHGkc18XIZL598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239359; c=relaxed/simple;
	bh=Ixz8RCtg8g8V7E/6WGZjz1yMxVCPngbv4aV7wfsh5Do=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FFKqWOcwHhHJzHZ/5MwukS0sEqxmnLRtiBvqTKKH/rWLD8Tt+Cnf0CHOJ8kQye8RKzGKnmlN5fO6NoQmEa0lMp/mic5+mD9T7/4pCDybi2RxYi6L7DQrM4q6Dmtj8K311WRCao7gpbxS3kFZ2v+Klnwbvw0SXc0Jqv0NhD1KHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDx5dYPN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDx5dYPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F7CC4CEF1;
	Tue,  9 Dec 2025 00:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239359;
	bh=Ixz8RCtg8g8V7E/6WGZjz1yMxVCPngbv4aV7wfsh5Do=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gDx5dYPNFAsOlIZD0vrsi6qad1pIBVvsVZMyLeelNbsvR0W3jk6No7bxcIJjcWxZ9
	 hFxBnj5Ua74eqM2AhFWDUR2//eXNeASR9XR6puFRbv2XVbzTdCn3F7uYBSAOhpLV7E
	 FHupsLL/+oPdoqKIFt0sNtnJReB0gM74l00tSyZ4X1cQqv0rvc2v9Dpy/odKqcgepy
	 s9KsC7TPHKyH9TIOmkEJKI/HzPazmvLfAXgeFmcSSC0oaDzZucWdA3LhrBQNVJ6+fm
	 GdBgqByIb1dt0r7bPnqxwgWR2F+OoiBPnBg9Bp1lj3Qx2bJl5NcwkBguuxxUeKFrY1
	 Wz64C46pSEfeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28703808200;
	Tue,  9 Dec 2025 00:12:55 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block changes for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <34687025-4ddd-4d54-a910-557eb9090566@kernel.dk>
References: <34687025-4ddd-4d54-a910-557eb9090566@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <34687025-4ddd-4d54-a910-557eb9090566@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251208
X-PR-Tracked-Commit-Id: 0f45353dd48037af61f70df3468d25ca46afe909
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4482ebb2970efa58173075c101426b2f3af40b41
Message-Id: <176523917448.3343091.13745063547727664734.pr-tracker-bot@kernel.org>
Date: Tue, 09 Dec 2025 00:12:54 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Dec 2025 13:29:37 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251208

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4482ebb2970efa58173075c101426b2f3af40b41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
