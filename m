Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD82500D0
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159700; cv=none; b=kyiVYrtW8AmCZf3LCwjETGZlXEqtt9zsdNDX2n0TlZhdnkLDJEPv/Sadal8nfZH4xN0CgKTSONwuumuY540PuoMf4lURHMonMsNfiMQctAb7Q2u0fm2VUDxtErqUVrwFzDES0DTE34AJg/zxSjICG4KnOXM4ylbu1wvnCe4ZjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159700; c=relaxed/simple;
	bh=v3DbBB+GJe0EuKnLtQTCcpweBDyiJlEShjH6sOBzXMI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jChxI4SP8rrf+K+fr/bER0loZxrYK8DHum0I5kkG/Kj/JwcwcW9O2dAG0s+RzBykHg73WQboe0BXBtxFE8crNe9K7tDALzpZ8xviatAfaBOCNtzW9SknG5qLRuaP6zs13eh94xlD47wshV+wUPgBO9iqgwD9o84tMj4XjUF9RUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgusc1fS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgusc1fS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DC8C4CEE4;
	Fri, 21 Feb 2025 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740159699;
	bh=v3DbBB+GJe0EuKnLtQTCcpweBDyiJlEShjH6sOBzXMI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dgusc1fSOSSjdNiXOB2j+CnRFHi31qU59+Xg3pjbQzhS8X9q+VnufhNUhFDMZv4JI
	 NOS5+vYjk3zzq7F0KA2pin3JdAOdqzJOV4vOscqvhLkk7++Yg2lHo9qZ88sWfxKm0u
	 nKLuhTHp/OogX51oMATUCBs571hDrnnvLCyO53v5fjh4jIwG04NXs4FFDeCCqVRpvf
	 qtfphRKingMuGe4rzoWoLuF3u2aqiX0pizb2iiQ4VXCDLss43rf8Sui68HcQiVkbSc
	 gvJwsvxx88Epky+b//Fv9pQJYo1oy1lRQB7yaL25xsdmFUL5guAdJY37xxjp4IHOIn
	 aa75dlxXpK+NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB49B380CEEC;
	Fri, 21 Feb 2025 17:42:11 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <3f1e6c92-ea9b-4d7c-95b9-9cb72311582f@kernel.dk>
References: <3f1e6c92-ea9b-4d7c-95b9-9cb72311582f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3f1e6c92-ea9b-4d7c-95b9-9cb72311582f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.14-20250221
X-PR-Tracked-Commit-Id: 70550442f28eba83b3e659618bba2b64eb91575f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a61cb6e150ea907b580a1b5e705decb0a3ffc86
Message-Id: <174015973060.2152716.4419994551647218976.pr-tracker-bot@kernel.org>
Date: Fri, 21 Feb 2025 17:42:10 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Feb 2025 09:49:41 -0700:

> git://git.kernel.dk/linux.git tags/block-6.14-20250221

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a61cb6e150ea907b580a1b5e705decb0a3ffc86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
