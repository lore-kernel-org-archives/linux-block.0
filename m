Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856313FEE;
	Sun,  1 Feb 2026 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769941160; cv=none; b=pC8fYo7jNXa5KsEinUw1cMAEEwVSHenD5JKNzAmtYmLLq6qY61GAJZ0SN/86/Og9+ogMnjzOF/x7depWeaK9DxWyuAn7kKeW3xs8tIQPqOwz8nNTJ8aabl85Aq+W07ZotoyecOH6ZNwJRblrtXqWi68fmzzg1kkkqIKwHOJWXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769941160; c=relaxed/simple;
	bh=l791/JQziHxDvos9Asw3LaD/6cvSs6Ny6pRTYEHGurE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=TMDV0c/puSnEhzYMkPevMfvoyZh8GVY2vQ/WTsS3JANB5oa8+Ny8cHstuE0rrAjTH213CwcPkd2p59bpbPX85X/Uf2VRxufAR5c4gvgsWu2wATumMUSz9aM5ZLQYv9hs8c29nqxamHOO/8wTl3AU2zV2kq8hH4BNZZWxwRtbTO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=CJf/VqnQ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="CJf/VqnQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=q6P610DI+HncYKG3xy5X4hGPgP1JvCNTGoiptoHB8p0=; t=1769941158;
	x=1770373158; b=CJf/VqnQRobh3yHsOBQ0oG1hSGtO6zQQyTiUbpN6wsjJZR2CiHPD8T8x1P65j
	gSzLkzhUE3BmiJDn/AvQQ0sLY6Bf6j9kzopGIjDN/r+SH+bIm/mIycfqma9oPX7Io17XyiVjisVjH
	BDmm7GfMcgcgE7xyGq5rwQbYmCQvN/IccnYfh3Cm6O/pVYZzF0+xkUtZxGaYRKq4nQG7Kun8JNQ39
	epc3bWMfM1Uqp/e2kaejOt08Zm9R26Luag9s5CD8/KYALRLuof/YZjKvlYaLB5RwhNyTc24LS3zH7
	mZPnAg4AoFtojx/H5ayJ9wHO6gUcmMPrBhnJY42183LOlVTTNw==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vmUXu-00EKvO-0T;
	Sun, 01 Feb 2026 11:19:10 +0100
Message-ID: <62de4453-17e8-47f6-a10b-39bf5a49fdee@leemhuis.info>
Date: Sun, 1 Feb 2026 11:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recent commits break loop device unmounting
To: nokangaroo <nokangaroo@aon.at>
References: <20260129131441.7c574b58@golem>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
Cc: linux-block@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20260129131441.7c574b58@golem>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1769941158;05be5bad;
X-HE-SMSGID: 1vmUXu-00EKvO-0T

Lo! Top-posting to facilitate processing. And Ccing a few people and lists.

Thx for the report. Does the problem still happen with latest mainline
(e.g. 6.19-rc7 or later)? Asking, as a fix for the culprit went into -rc5

Ciao, Thorsten

On 1/29/26 13:14, nokangaroo wrote:
> 	commit 08e136ebd193eae7d5eff4c66d576c4a2dabdc3f
> 	Author: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
> 	Date:   Wed Dec 17 14:00:40 2025 -0500
> 
> 	loop: don't change loop device under exclusive opener in loop_set_status
> 
> 	loop_set_status() is allowed to change the loop device while there
> 	are other openers of the device, even exclusive ones.
> 
> 	In this case, it causes a KASAN: slab-out-of-bounds Read in
> 	ext4_search_dir(), since when looking for an entry in an inlined
> 	directory, e_value_offs is changed underneath the filesystem by
> 	loop_set_status().
> 
> 	Fix the problem by forbidding loop_set_status() from modifying the loop
> 	device while there are exclusive openers of the device. This is similar
> 	to the fix in loop_configure() by commit 33ec3e53e7b1 ("loop: Don't
> 	change loop device under exclusive opener") alongside commit
> 	ecbe6bc0003b ("block: use bd_prepare_to_claim directly in the loop
> 	driver").
> 
> and the follow-up
> 	commit 2704024d83fa9eb8e5f16925aae340fd9d246694
> 	Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 	Date:   Wed Jan 7 19:41:43 2026 +0900
> 
> 	loop: add missing bd_abort_claiming in loop_set_status
> 
> break unmounting a loop device by a normal user
> (udisksctl unmount -b /dev/loop0).
> The device seems to be unmounted, but the path still appears in the file
> manager, and if the device is on an external harddisk I cannot unmount the
> disk.
> 
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [08e136ebd193eae7d5eff4c66d576c4a2dabdc3f] loop: don't change loop device under
> exclusive opener in loop_set_status
> 
> As a workaround I reverted this commit (and the follow-up before it).
> 
>   git revert -n 2704024d83fa9eb8e5f16925aae340fd9d246694
>   git revert -n 08e136ebd193eae7d5eff4c66d576c4a2dabdc3f
> 
> If they solve an actual problem it needs to be fixed differently.
> Commits 33ec3e53e7b1 and ecbe6bc0003b seem to be correct.
> 
> I will supply more information if needed

