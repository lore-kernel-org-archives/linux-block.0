Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0D288CC
	for <linux-block@vger.kernel.org>; Sat,  9 Aug 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754718886; cv=none; b=Y8Mk6bEIwol727Nz4JgE7h+/uwxsChPw/fur+iFY6XvTbEIibQ83g4NfqLuhuxL11dtzBiQgYywbNWm9Caw2k0d/PKUA5uBQu578rPS2NdT5t7v1Isds1nzKe7kmKC1BX1sw9HloLftxN7kmSQtrVSp2erwqJmuFkNyicgNtPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754718886; c=relaxed/simple;
	bh=t6onad3o9Cn60nkUwyIEeA02vVGBc2o51JRphj8dZXI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LHpMYaHjfag7wYuEQ98+fL/crCsret6oQNUpJC3ccMLRcWondQt5hnwhrseyedJFMnWDrsWpdw3k3QBKIpe7lYCq7POchoF4HEpuJoTaJexkofXmQ6Y0V8AG57gBywkJbu+h1MqNgqy9eNP1XMRPkZ4gTOddu+dPibuoff7XkUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYbpbVRt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYbpbVRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696ECC4CEE7;
	Sat,  9 Aug 2025 05:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754718886;
	bh=t6onad3o9Cn60nkUwyIEeA02vVGBc2o51JRphj8dZXI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kYbpbVRt3nH2TTYKtWFWF58JvV3fanDWw2PbfYflJTsDw9CsIhs2Sq3kATMjpFVkE
	 HBMvFcZ6SJmhc6Tj7qCMjnJn5i6s86rZU7H6NSCyDU1jlUiXzDYkuuVAPxs3px6DHV
	 O4E0Iyv5/0NKULPmiNEMzBThe8SiZFl764H05gl79D8Gxtrhi2Qex3vNqBp5rSglyF
	 L+Em0yDPonN6djG0UFhBpkwwpkV8EhxNkcAF/hEn9ACDAOPp/BMQOPPdgtE2cFLY5v
	 OVsJm936YOWGaqn2Jo+n2yDSlqbX/wUPAgGo5vXNmuxMSZnyW0nrJXKi+DqIcGJTxm
	 Zi0o9NMLaYqKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1A383BF5A;
	Sat,  9 Aug 2025 05:55:00 +0000 (UTC)
Subject: Re: [GIT PULL] Block changes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <3c66a9e3-ed41-4f9a-bf19-e6e5a6a38693@kernel.dk>
References: <3c66a9e3-ed41-4f9a-bf19-e6e5a6a38693@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3c66a9e3-ed41-4f9a-bf19-e6e5a6a38693@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.17-20250808
X-PR-Tracked-Commit-Id: 45fa9f97e65231a9fd4f9429489cb74c10ccd0fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2988dfed8a5dc752921a5790b81c06e781af51ce
Message-Id: <175471889911.391257.18237977049143964679.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:54:59 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Aug 2025 11:20:33 -0600:

> git://git.kernel.dk/linux.git tags/block-6.17-20250808

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2988dfed8a5dc752921a5790b81c06e781af51ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
