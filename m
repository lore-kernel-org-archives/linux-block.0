Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D042069
	for <linux-block@vger.kernel.org>; Sat,  9 Nov 2024 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189651; cv=none; b=UbLsOTWvzVV/anJMp5Ug03OYO/ouOd44sms5a7kwDIsM2ew1J3UhRUYbjh5l1ZWGDe3qd+A2RP718GVz8EVZFDIj88LRe2O3qV0jgN15JQu48u0wMSg26LluHSe2ZawMtqEjbObRpf53DtR/oFmBGxqGYy/niRzFPnixls9znzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189651; c=relaxed/simple;
	bh=MAV58+L2Gr0ymJabbq2rCbzIFRP6ka2mt8xip1zAf9Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XTN7vJfr4fEeJMBFgu++2QClj9kemW7f/HWvLCxRPUl9W0veCIfmsD/L6CiP/j6rYNMS+p8QgwpfejZdxfJo1BxH7rVdaGIbuVWdWgZ/qkTWZq4mz1oSEiLrZ3+hoOI9x6S6hXa3XKxwSrkTlTqKodkBS0dJDiIB6H6G0CGtrgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+7uIUzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+7uIUzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17791C4CECE;
	Sat,  9 Nov 2024 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731189651;
	bh=MAV58+L2Gr0ymJabbq2rCbzIFRP6ka2mt8xip1zAf9Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U+7uIUzO5qL2a8kDfeBdKTy+6XQuJ8oXU2k9IrunPXk6JXbRddN6TBm0MfLQV0zSZ
	 OUTZpr9+HABMpmNSuzRYAYZ+x8hMpshpEbbwPz1avMv1G7yFveEHvNmlupTz1LXGhH
	 NUCc9ttq3EJnHi35gaiMMo3orfOLdaHH5vfUn0VjAZ1anhetGOvQQD5hzL09S73hFo
	 Sbg1TIFPrGi98nOSNR6OTNyJKOyroFI4X4ntmrpS9JjyQXUQAe6zp3OUJWjIyG1UIw
	 Cd9xPSQ5YVTXLsubKMM+F18H+OmBTnHFlZyK+jUsLEgQ2644IxKEVcG5J4PHxRxo9u
	 eJfwLEK2ziibw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1B83809A80;
	Sat,  9 Nov 2024 22:01:01 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <1178b3b9-6b42-4577-9cad-60fd899f391a@kernel.dk>
References: <1178b3b9-6b42-4577-9cad-60fd899f391a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1178b3b9-6b42-4577-9cad-60fd899f391a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.12-20241108
X-PR-Tracked-Commit-Id: 52ff8e91f916fa05dd47b5c30afa3286c30db444
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a58f4dd9526abbb83523ea515508ba714a1e6881
Message-Id: <173118966048.3021408.15592184473982699114.pr-tracker-bot@kernel.org>
Date: Sat, 09 Nov 2024 22:01:00 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Nov 2024 19:24:56 -0700:

> git://git.kernel.dk/linux.git tags/block-6.12-20241108

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a58f4dd9526abbb83523ea515508ba714a1e6881

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
