Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383260;
	b=CHWVMTRXgHr2OLRfF+dMg4FFZXvANfAklZmp+TqMef0U3t8PzYMUo5mC30vpnr6evfYn
	 IudCPwmzPjEtijVO+qj5bP1abBbhydmzWygn9Iv9FISCJ2NT6n5puAhRLh2KDBiWTT+XR
	 O7XT63f1XYVu6E1Gofk0CU0x79VPLKkDb7dNG1rFVkiVfBN2qTF3N6092mzoZY1RBN9Eu
	 CtvULkFLbUYhGj1JfAwo8YaH5EDzJZJJm0vAKlQpZX4QAOnxCR1hpUdFtvy82UGM2CG78
	 WHcSVoTmQ4nh0coqAigA3Kd1AysFCgIh2S0pSQRFNe8kpfscdM0fVduWyrVKh7t80sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383260;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=H1arpDa2DaFEB4ZVNLSW6OFZc6E1q5DK06T3D7fe3+c=;
	b=hDNqsh7+HUvK4Z5OS2WHK7+n4E13X+BGVY85wBK7gP4+vQ6DWz9Lb7/sD1ZwplG4dL1B
	 2X/xZ7sgKMkfg1RfNNfx+IPMZY/zSZYXRiHCsYs0madjeCinrwXDKQKxq4o1J8O+0+y0D
	 OnUwJOrcZdOp45YruZy/Pfpk9d04HAz5QhWekQzjtKmoFfB11i+4gdXELvsZfSOkUvUTp
	 3NHtMDNxv5yNmZZF3v/CXds+0pP8T/Vq3q5Q9rOr20Tsz648lFNVnf6/uUm9Z/z825/oF
	 m1Zb75/cvJqCLCIxvvGKli1Bu/M4q0yHDqtlFUPhPwIfqfxisf4cSKroB2se68bx0jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rn6+eB7j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0F606A33E
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rn6+eB7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3971F0093A;
	Fri, 30 Oct 2026 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383260;
	bh=H1arpDa2DaFEB4ZVNLSW6OFZc6E1q5DK06T3D7fe3+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Rn6+eB7jQHhbeIt5K7IpT0YNl4EhxtwrLrze3sVeJmoBIoAEVKQcKlO/UIiHv7XsO
	 4Dd4dDzAPXyulPJakX+8hhc2FoyGdv8gmtlSp19sQo61Rikug4jEn1Ob16esG17i1m
	 52oqWNj/kGh4ChXlLKZx/Yvh3XRm7eedNVddg905+A6Hhe7eJ9dJrnvNqUyqLqfIuh
	 x+iyMseqjop474JnmcRSdzWRHaDrb7CiDAqd+rGAbMXjG/a5V5Go9FTVFoGF4HWwsI
	 mfw+suWSYF8DwD3EnW1EFTIV6yuMyNxeOsgI0LbZTA4oQLn5+GNpXxQmeDNw4tKzzn
	 yWtcStEPhsqdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF9D3800471;
	Fri, 30 Oct 2026 18:01:00 +0000 (UTC)
Subject: Re: [GIT PULL] block fixes for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
References: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261029
X-PR-Tracked-Commit-Id: c8c53d669d4e45b3a804013251a34387d7e11bfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ebbaf8835c62d7541a6226672a6c2e8e6a5428a
Message-Id: <179338325895.1671436.16820356960495467163.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 18:00:58 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 30 Oct 2026 07:50:09 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261029

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ebbaf8835c62d7541a6226672a6c2e8e6a5428a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
