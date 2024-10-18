Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3F7485
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729292223; cv=none; b=FlTVY1cNVgcpIjoUwEbS39NNyj5NERiQQfo6mEw516D11dQTW94UscpOSXWXQ/zwMo12xfrgGsz82DXo5HOYeWYkMxqUYRfVQOMDLN2A+4IcvMuFqC5VpVSbRtflOwTUSaOvTTLVn2dcedxk4g9BM8/FHJaxu1BHEwV0X4ZbY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729292223; c=relaxed/simple;
	bh=SsSV0FI1JzuQPcBhHXS3u3kf+vgZger1NkujCylzPn8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YR0UhdM0PKICFdFF33+k25JWv+LiNwfmq8obQRnvJcwGIRseF1ZswXvOMKIYYfzAn8TZlEtWL0iL0yIWwoBIqWQq/zM66aZmxOVNfRe9ky5NFy1lAb124qWRHa150nLbZIq40qoxb1Cf3eQUheSJpQFj7eTvkVF/o+OUMR0awiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMc3/E1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMc3/E1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EB2C4CEC3;
	Fri, 18 Oct 2024 22:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729292223;
	bh=SsSV0FI1JzuQPcBhHXS3u3kf+vgZger1NkujCylzPn8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YMc3/E1/mU0QQ0GlzXTLP5c1kfa4qw0PKdxFlR0UBiCGbJlGw3hGkivOoi3GCxty+
	 z9FDXjWrXwhI1tEG8FSkwJDUnlfTZENylD4l21i16j5/mxkhRSEhDYpq0J3R1u8Als
	 DFQ5XNu/wDtxjBrPIvH09DPwrFFXp9jPdx5ZIZcrAXCsPuXNuYFcdv7lGemlBw9KiA
	 wkkPPyI1Lq/ZatHRVbHGvz2EKtkESfMyFOCgub6dQJ65fIkWNPS40Gx4ISQ/9VIcGw
	 wkZ6VGTa/e2WdIoCmLZoQth6KHAy9S665oQ5UXs+yTNxgJ3Rh11VpZHaTzxmqNZ972
	 b2uIOC3PDVf/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF9E3805CC0;
	Fri, 18 Oct 2024 22:57:09 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <72c65a83-f629-45ed-b9b9-bc3efd88e86b@kernel.dk>
References: <72c65a83-f629-45ed-b9b9-bc3efd88e86b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <72c65a83-f629-45ed-b9b9-bc3efd88e86b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.12-20241018
X-PR-Tracked-Commit-Id: b0bf1afde7c34698cf61422fa8ee60e690dc25c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8eacd8ad7a658b805c635f8ffad7913981f863c
Message-Id: <172929222855.3285619.16132534262748967286.pr-tracker-bot@kernel.org>
Date: Fri, 18 Oct 2024 22:57:08 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Oct 2024 12:02:27 -0600:

> git://git.kernel.dk/linux.git tags/block-6.12-20241018

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8eacd8ad7a658b805c635f8ffad7913981f863c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
