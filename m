Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFF2BE63A;
	Thu, 13 Nov 2025 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022433; cv=none; b=Sx0EkyVywuEJtHx/G7JOiId5nCA9ROgCFeckVz6mFkS3zjvjdtrJlw4Tq7qPWmd3/wPEMRheGnAjytLNqKswJjWoynewMvEOrPBadUFP92DkkjLIbsVQ/x9K/TIO/GbvUoK9V2QVc0I6FnMPHq09zruL0nhBb0T0S/qklDQkivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022433; c=relaxed/simple;
	bh=AVF40JvW0rvtlK/7YsGxBBkoai1eJAeOfCxgFSzmMNs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EK/Y4fDB8zQALlEZnAOyn1EARJXwSB1JlSfgAc2ZSL+O4YtXRlFc2xX1ioHWoHpBEpybgHD8RnL39zsmuqTbdkljzawohRp52cplBvUK0y2dylwkXB/QTAbEPmJAA891d07Vje3RkraB5JBgTEbo6Ej095dmhqNRK4PKSbxU2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=v9AoO4/x; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="v9AoO4/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763022428;
	bh=AVF40JvW0rvtlK/7YsGxBBkoai1eJAeOfCxgFSzmMNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v9AoO4/xhdatZfIAkcpeqA/C2uwgWepWQ4qgXPvSr35mXwv5nFEed+zaue0uHrr3+
	 DAckeEzFlBbnRrjSLNHgALe1z6aaX7vJ3GQekJzYsS3M7cfRO+rtWacjhNaEO5IfRF
	 VyPoK2fzb8lR/FAFwTO5D9822ABvID+ZIQ9Y9Jm0=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 6C5226F4; Thu, 13 Nov 2025 16:27:05 +0800
X-QQ-mid: xmsmtpt1763022425tw34gw48d
Message-ID: <tencent_49B963DEC2577A5762510FF7CF38ADEBF306@qq.com>
X-QQ-XMAILINFO: ON4JYNczNu10K3dFLsf5HglgDmwpEuP5H8XoKG04IMwTQ8yCPpA2mifQWPpYrz
	 o5qgq+eBwXEoSWwWT+yqgrKyYduVhCxX026WfrfLSzist5VcexfZAmplvA/rMWzw/ed4v86o0FVt
	 BIskcAFTKuWZTnvpQTmvPrwsKtcKXSyZOvUcyujZ4CBbQHl0qLfLL2KpA4mx0ILjg7W0b13BZldy
	 aE+7lX98uC7ukkgCGpMMmZoIXxsby/NNoqbskgPcYqHtzUEvDjRMN9LEZL13HZ99a828C+CJL6jw
	 CuR/wjGznU1hlnVpQWA8Z81jHH8VKR6hNNHzQEQi0kghVnIHaTRtpt2tyZZTfJFtM65F8TNT9WqZ
	 tEeq+3G5YjMfY+Tz068PsOh2eCSeUXue2WN6aGB9LpUTktA+odXphwQW47DCOGGT+QsUdklX/n7c
	 F11pIEvY9ZSgPJFR1pAfMzn2YokID++F6k3mowS9xH75TVuvES7Oi+WMlM/ArB4GUHpPhRe21qUb
	 8IVEtcYTBbXGmgsVGoIF4MTbyVvWI3bwnHv/463GOPwqnL+fFo7c6JM5XFg01Kp2iBoGjqm28zot
	 hpxPH6s8hu4IADxAXiGS4Z8I5yujdmOxoBXJV6LEc0t5WNI7N4gYGc9FW+WKs91X3tdhzRxt3ILN
	 HqvG/AP+OSAK7qdeMA7g8p6TdePYbaB26Kdzu739HK3uzaSWG6L2SzEHINyX9+trG8IvQoeuTITx
	 MrypEPn35jsS+jLUhE9StSv2l571etihy/onHzQAv7Uz7S9ScMITFezsmcGlpwmyfXlOQDxC3O7L
	 nDpOW/FV1bqNHNXmItvHR/iyVN8U68lFFdiYxjlwYfpd23LwkKFuVsbPjrN7w7JLGnL84FEGHywd
	 5TDcBxXrQDgJcxjcyYCFOtRlVouNLW6XVdA73uQem/6d13C9/WJ0i5CPQ95MEsOlX3/nHMpc8Df6
	 VMYAoz2/aKv3rkvJnMk0Kw5AJ7uR5qsvM3i/GeAhIVRZwIIBve1zpmHSbkKt3Vg+xQtUx2AcaPUA
	 oo8F8Bl/Znq5G0v3oS0xls21QS7OufUdGDN207iO6p6/UfGuE/K7Tyz9NiXL8SJGpyp+uzbw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liumartin@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Date: Thu, 13 Nov 2025 16:27:05 +0800
X-OQ-MSGID: <20251113082705.3325765-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <kyprvtaorfdq3a6fsddaww4jg6ixv253rfonrdv2snyhq4pkuh@zdei5bgqzd3o>
References: <kyprvtaorfdq3a6fsddaww4jg6ixv253rfonrdv2snyhq4pkuh@zdei5bgqzd3o>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On (25/11/12 21:40), Minchan Kim wrote:

> My preference is [1], which is very close to how current post-processing
> is implemented in zram, w/o complexity that dedicated kthread handling
> introduces and so on.

> [1] https://lore.kernel.org/linux-mm/45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org

Yes, I also agree with this. Introducing threads in writeback will increase
the complexity.

