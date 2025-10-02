Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F7273D73
	for <linux-block@vger.kernel.org>; Thu,  2 Oct 2025 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427380; cv=none; b=a5/3SNImcQMYRu23eVKbbbIEnnKwVCILsdEzTebPkY0UU9x188+Bp2KGSwSj+uLMn29YqSs5laf7KFDL+4EDnH6uHz3B3hVYhCKw2OpWXAi7chUZsN7wrBq+fDUZ08wajMm7FLSkW6s6wWzRto0TCgVUBrgtSNUpFZtL6FVawGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427380; c=relaxed/simple;
	bh=/gpoqir99bYhZPs3AnZMx81WblskSCOAT7j+iv5zwF0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OtDKnTW0fxdARbo9P52NRaKz/XLgDr6sFojTzYxLe6xjnGWm9btZO1NNSn91Aqm9DfEGl/24/e4j9jLW4N6Ww0Qe1R+QgLM8bBlnCdWkf2SQLuvyPs+4P1EQo/eYyb8gvgnV3fIzWPgFSbsP2sLpHyCEn3oqkOeutQ6K8lz2fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/dxGHLa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/dxGHLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1D8C4CEF5;
	Thu,  2 Oct 2025 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759427379;
	bh=/gpoqir99bYhZPs3AnZMx81WblskSCOAT7j+iv5zwF0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u/dxGHLabMDIW0MPjacQ9Td3kUe/GzDmnG21NgFGe7FlbeLBGqwWEKh1rQGCuZjOo
	 jqgW2l2lExPuHtZOAUM8KZitV4av2SI6LKfq6gmw10KN2G+9eXFc5oQvuCBUuWRhKR
	 WkDiveaqBxbOMzlq++4VbKdfd00Sq0O4kjyMxxMN8yuox9DkD8Yo5lo4SkyQdXXPJ7
	 DP/975XUZxxDW+F+W44BWk5h7asB5WeeI18szUAhuKAxo45EK3QDfZx0eUBs1HyA+A
	 xHJKB+k0j/qNaxDSnSLiklkFsIbnNDbNOM5/u8ERrpivKlkZHnHzdjxcY41sau0/hI
	 lIWvBcESPE5zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC339D0C1A;
	Thu,  2 Oct 2025 17:49:32 +0000 (UTC)
Subject: Re: [GIT PULL] Block changes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <124c358d-1d50-4691-942a-76ff75396be5@kernel.dk>
References: <124c358d-1d50-4691-942a-76ff75396be5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <124c358d-1d50-4691-942a-76ff75396be5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-6.18/block-20250929
X-PR-Tracked-Commit-Id: 130e6de62107116eba124647116276266be0f84c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1b1d03ceec343362524318c076b110066ffe305
Message-Id: <175942737159.3363093.1520091128043179946.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 17:49:31 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 19:46:25 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-6.18/block-20250929

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1b1d03ceec343362524318c076b110066ffe305

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
