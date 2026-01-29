Received: from smtpfallback04.a1.net (smtpfallback04.a1.net [194.48.128.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13E205E02
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.48.128.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689989; cv=none; b=MQ5NWBLcfw9nPj0I92/qEYW9e8jnMgHR4jB+osXqqGqPYl8lcXqfIuSz3RW4DkVZuFqgVxGBsrANI/5tHAi9TTuBqjRgpGdT0oNIhe3XVIKZ54faAxSOhX5YOypbnyhMNG4aRbHWzzur3uVr2FsUqsYYUtvlbXAat/WafwUGf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689989; c=relaxed/simple;
	bh=akakqK6ecUVgMw7nEG6Jjwn+5pm2eVq8jb4NkCoSgw4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=IfI2ki0yZQYD5vA5bXIH/QdC++N0jmVmxacyrQsMVvu0pC4W20oCkfHWieCJ/yl2JfntHTIqbrOVHqMvf5Gz9MSW2EesLzMBsG82T+FUIp+N5/boJeGe62ErpaC1eQi8L/dJObn5Wj/HcETFiJrR0W2bW3hebVL5/iD9hZhT+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aon.at; spf=pass smtp.mailfrom=aon.at; dkim=pass (4096-bit key) header.d=aon.at header.i=@aon.at header.b=mK+w1f8U; arc=none smtp.client-ip=194.48.128.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aon.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aon.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aon.at header.i=@aon.at header.b="mK+w1f8U"
Received: from smtpout02.a1.net (unknown [10.247.84.12])
	by smtpfallback04.a1.net (Postfix) with ESMTPS id 4f1yxQ0hWKzYl0R4
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 13:24:10 +0100 (CET)
Received: from golem (unknown [100.86.142.102])
	by smtpout02.a1.net (Postfix) with ESMTPSA id 4f1yxD6HPyzGrqny
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 13:24:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aon.at; s=resmail1;
	t=1769689441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ooGkKpKzGL9/GyOJubLs29sRBP46f6dCngsP/Z4u69A=;
	b=mK+w1f8UtFyspzDD1qggsxERzDkWlI57iZ7dScXZtyqlJIJVGu/Fge2YfqleQqHD2qeUvs
	e4aOtSm7k7/3CYSx/uo+kVBh1jDt1nboqcbytp6ZtDqJXN8PRka+W7oiB72N7xRkxv5/GX
	gW3Dnv06B+qjqfRtPTNpRXb1kNlpWddwLPwjlNC5XB9J8vgBXWhlZVDVaAz78KjezXndpc
	9IV82lU21923gqKLj2lIKk3mQGnBc1riYtdL7NKpg4QSFd9euD+IH0gyrss5Bs3gMXa5xW
	WJT/251g6hOMnpyX0L4WoWHTnUb9ZBa5SPhAZYKFShXbVfm/G8vjdl6ISbvQwaaWu+V0Bc
	ESQD06PFXWUVROx3Hea2yeoUxvvfEXGME6SA0HZWwbde1Z7AztkuJURxjJQv/v/JAKgu8d
	uCv5HYsrIXSj43Wj1eF/PzXGcBpsd+fT2FYUHgYVfy2/LRFuZHsXB2y3ipEBbCl3esl9iB
	6JbnoRZFnW8g/w1dKQpeBQR1Umi+bjIxg9Al8GOCMLMU9AhFL9mQTgJ+GqfnViX7auFpdU
	deZ3nmpYKqtRm2TSmQ5ni1avMAGLq1wBMIHS4LiKnMFaEKCLy33YgrtmS/i4BH5NpUfPvv
	LgRU6mmmBN5vX81By6hwMuQZd3289MwnuyqHLSQywwI2i2UXsxw64=
Date: Thu, 29 Jan 2026 13:14:41 +0100
From: nokangaroo <nokangaroo@aon.at>
To: linux-block@vger.kernel.org
Subject: Recent commits break loop device unmounting
Message-ID: <20260129131441.7c574b58@golem>
X-Mailer: Claws Mail 4.3.1git129 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Level: 

	commit 08e136ebd193eae7d5eff4c66d576c4a2dabdc3f
	Author: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
	Date:   Wed Dec 17 14:00:40 2025 -0500

	loop: don't change loop device under exclusive opener in loop_set_status

	loop_set_status() is allowed to change the loop device while there
	are other openers of the device, even exclusive ones.

	In this case, it causes a KASAN: slab-out-of-bounds Read in
	ext4_search_dir(), since when looking for an entry in an inlined
	directory, e_value_offs is changed underneath the filesystem by
	loop_set_status().

	Fix the problem by forbidding loop_set_status() from modifying the loop
	device while there are exclusive openers of the device. This is similar
	to the fix in loop_configure() by commit 33ec3e53e7b1 ("loop: Don't
	change loop device under exclusive opener") alongside commit
	ecbe6bc0003b ("block: use bd_prepare_to_claim directly in the loop
	driver").

and the follow-up
	commit 2704024d83fa9eb8e5f16925aae340fd9d246694
	Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
	Date:   Wed Jan 7 19:41:43 2026 +0900

	loop: add missing bd_abort_claiming in loop_set_status

break unmounting a loop device by a normal user
(udisksctl unmount -b /dev/loop0).
The device seems to be unmounted, but the path still appears in the file
manager, and if the device is on an external harddisk I cannot unmount the
disk.

Bisecting: 0 revisions left to test after this (roughly 0 steps)
[08e136ebd193eae7d5eff4c66d576c4a2dabdc3f] loop: don't change loop device under
exclusive opener in loop_set_status

As a workaround I reverted this commit (and the follow-up before it).

  git revert -n 2704024d83fa9eb8e5f16925aae340fd9d246694
  git revert -n 08e136ebd193eae7d5eff4c66d576c4a2dabdc3f

If they solve an actual problem it needs to be fixed differently.
Commits 33ec3e53e7b1 and ecbe6bc0003b seem to be correct.

I will supply more information if needed
