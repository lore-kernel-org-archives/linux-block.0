Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BC2A1BA;
	Thu, 13 Nov 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020536; cv=none; b=UZdzehRToofQ/pEvCzgCg7yrfq16H4cZ+hXU+d0Dr8q50ghbZp20M1z/6d/sf3OLIHsyRCFYtdrYZIaae6fDa3XIGYB42Q9zftseQfaFk7Fg+w7v/n/74hI1QQ1lRanQK8EWj4m8nF0lDFZZ5v0u9a7vXSXVfGBDZ7CkSTNZHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020536; c=relaxed/simple;
	bh=swa1iz9lIJYaRcE252xEGLS58GUF2KRd05CElalUAmY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LLFwM5dq2EJbkw/i3PWsSt5/XOsrrP1D2vnUKM2jgWU5S9zuKpOffbdL67ZXXh/bJIIblCq1NZTCOJWhckOFFnOH63anQmoxdEJKuxXNSCPTEb3SB20SoVFjwtsqsvyD6GWaNnO5CbTvRoDaCXlPd3t/S0mm8Vpw2JjSMXErvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=lsZ/AFs/; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="lsZ/AFs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763020523;
	bh=t5xHITYUt6oFMxXRYSXMZYMrVmkRWvp/mzkgT57QABw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lsZ/AFs/ch1AnbI2jmg3cJUhWwytfpFQ2qR3NmCqw5L5pbMMQvdsmQmjVtT0OQpMc
	 NxZL+Pn0mfPJxyCfohWTs1GZ0/1WwP2ZVvJlKCiEaMXqmqvZvOOzEcRSYFFFOqVnJZ
	 jhLGckLvpzLcsstCbRvPfDN9iTCsXHdSzIDK9utA=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id DD4BA6FE; Thu, 13 Nov 2025 15:55:20 +0800
X-QQ-mid: xmsmtpt1763020520t39bf1js8
Message-ID: <tencent_FE5751D11BB7EC389B2BC0B957DEE0D75E06@qq.com>
X-QQ-XMAILINFO: OWROGFTRp+d+cprrP6KWNZeBoDbPIt355KIOdz7m8YO0yifwHSmyC318L/1UFM
	 HQjK+iAcQMCwKSjbrPtsC5tB5a8AQ5NdkcSrP9g4SAB5M4UIEHZO06KxjpYRmJAc8xTyuCg9LlGq
	 2cIfEHotv7sPvLZW9Yj4KYRmoGTTswTwG0SgP3lychboOjo5ANiK8wtzYXpws2pqEPNivta748i6
	 pSvYwiaYLC2r1eyW5Rqi+/wasPYhDwZtFVo2Ctc3S5WKG3tXDd2l948ROigBSTe8pNiBWqNo9J7P
	 Y+YOGhxBUiansipAfh862fXC9tuiIa/mY2XrqH43W/GdLREfobKISqlXBaXB7z0Isfew4KXbXNPw
	 Bp8ihfv828SMU/k4BGO6GbV3ZgitsyvLzxgpBzKP5Ug6bEOQnbY3hwRmm00qedwc5cgyQQOonmJu
	 TJwybxJcPuiXot9KClyFQ+YytKvS+XeyWU55jbgPwR5yev3JeIjtAS//4Hsl7DxZO2M2rohbge6F
	 MjdmlR0esGEzMoTaZ4i8wS2kIPOMTSKZwK3vZMwSqVv9nRgWTxhiCAoD+tP2tDRzf6sOntmyKyE2
	 YbtwkgagBwt7zxLZc+4tiO2LoIFyTPN2PSo4DiheTdf1Okc/l7mE9Q/qzGCb/bD/XWE/L8U7B2Uu
	 UTIrycqxeiWo2kjQduzJk5FTavIWDSqN9UBHxos8docNkd9idrMfClQ0kOLAEMD5BHe36JHivPPi
	 5k/ACopMxuB8EB/rXIY7TexiAC8A6i3+L9MNdk3R7bURVbPE37d42w6u2tDPNXLw7vJBXemPUqTc
	 1t8w4B7KS1kpPOmBItMQdSwu5CjAn7s8wVRhMaU4O0bxG69jT90Sbz4p8IFDchKKbz034dKP3rb/
	 Q80MXqdJo7lTocENwm7HbaajYcVZ4H2EBaR6cPsVcCzUrveJxFkDWnb7bVpbg+fymO0RbL8Bv0N/
	 r2L4NYeTwjWJWIJVdq48tDELGZB4kCw8t+ybRkOGzVoGGROUCB4LyoTCunSIB7PdGXNtLybsLrr/
	 v6cBaZZ+j8xXLec9dlGuqjcy/Hy+vJNlEjD2lRRg3+OgfGG38g
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Date: Thu, 13 Nov 2025 15:55:20 +0800
X-OQ-MSGID: <20251113075520.3325126-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <x6ksirxv2xffhzpvdxmm5fa7r4b56mlh3kbhopljdsvwzg62wm@rrsslefk4rb4>
References: <x6ksirxv2xffhzpvdxmm5fa7r4b56mlh3kbhopljdsvwzg62wm@rrsslefk4rb4>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Nov 2025 11:04:04 +0900, Sergey Senozhatsky wrote:
> How was this number chosen?  Did you try lower/higher values?
> I think we might want this to be runtime tunable via sysfs, e.g.
> writeback_batch_size attr, with min value of 1.

I haven't conducted any tests on this value. I just set an empirical
value of 32 based on the submission queue length of the storage device.

As you said, providing a sys node for configuration might offer
performance advantages for mechanical hard drives.

On Thu, 13 Nov 2025 11:20:15 +0900, Sergey Senozhatsky wrote:
> So I wonder if things will look simpler (is this the word I'm looking
> for?) if you just have two lists for requests: one list for completed/idle
> requests and one list for in-flight requests (and you move requests
> around accordingly).  Then you don't need to iterate the pool and check
> flags, you just can check list_empty(&idle_requests) and take the first
> (front) element.

Yes, using two linked lists can reduce the complexity. It's just that
before I saw your submission, I couldn't find a better way to avoid
introducing locks. Thank you very much!

