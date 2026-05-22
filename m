Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF21D63F3
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779421551; cv=none; b=NJdvXYiDDP32yD9RMYGalsGyVEPVaS09vm07PMccld+T8NTFzJFmFH5ZatfBNNXEVPD4IqqilMlMMNQxsCKhCjvWuwARkEuREiHF7NuQH7JmtZZ6rn4RSzUwGKxiM+8FrYgVTAgC6Bndik/G0O04t7psxEHii5zJXv036NUO60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779421551; c=relaxed/simple;
	bh=3M55AxIaIuhW4/KRxVkxEobeqm/VUAAV3PFU2bHYYYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2TsnxLqgVS6nIAUlaR7OlESTNnH/qWJePjl6cy/q76Gc3Rm4TGATdJJpoIl094YJimFncvtq7VFKW7YOo0Sq0ZXyRbjQ4y+jMJMRFysW2ltCVL3XrTNSuQ3DAmhCdTlSqYjE9FkOlYbQsoPUhgH6AcR6T/qqsysCzL0h8B478o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayqGFstE; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayqGFstE"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8acae26e564so85585576d6.2
        for <linux-block@vger.kernel.org>; Thu, 21 May 2026 20:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779421549; x=1780026349; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EbrZINEVRAlL91+mNqx/QfsjRY0fCFp0F31hsGeiuBo=;
        b=ayqGFstEXjOsTwZxBRkt0WUdF7EeYZKWnanQ751lbfQCarWjN/qWKQfqFeCgwxgxse
         dAf7M0FJf0sWHBniTmeNRBvs477wg1k/rMVOA+qEOGvEIaFL9He0N0barewVTFl5o6ME
         VkQp5G5zDQswV5K3t9tLOyfDU8f85RuwsjWi4isBq57YAh59CUMT26a13PTjEZSViW9m
         HPtZKvZ3k+/d5oSL7zsDvPyr0TrFjfnFSaXXxONlkwEt2h4oSKOu29yp2QD7jOugugGp
         AQvUFn8X3PbIyvMdAZ+mGRdoBpwq7wgcdHpGo4yVc3sMIN0JJM06LuH3IFuu+seFv8lQ
         5iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779421549; x=1780026349;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbrZINEVRAlL91+mNqx/QfsjRY0fCFp0F31hsGeiuBo=;
        b=eUehItfMgBYiEDVomjiksB0CmJUBkBKznuBzSW3diLOwnYlylP28eT/Y57zb+Gj0tG
         7QZUeaTBRg9eBWdxK79d9+1AphQ25abc2oA05Te5U8+yScoA6F1H2UZJrSJPlh+2QEer
         Qq7fcKPHoVNuovgWBjJRcYHq2cyibyVFkH9qGvcbX6Vw+JXt1b50dCXfHs9faMogk+cZ
         KgJBeyoBV+dLcgH9ugl/+4+Tr/rvAx1UQJiIK6D5GM9GbcoFjcwyyBfNjCjHs6OykkpT
         Y6r/cHDDEDvUZR++nZXe4O6zNqv3afwuxZo3ebs0G7mq9qk8H/jFcD3TaHgyCIKHVNbz
         X09Q==
X-Forwarded-Encrypted: i=1; AFNElJ8mzCw9DgWvvkk11nvn2UyNsD0KFjeHi95YkiMRvnY3HTmrOO2H2oNU8M5SbZ/HP0UTgEgvE9Lv6P9Jkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaE2WbN+2phbaiFrIZEKmrRdxSPOV7sWqg9ZC09m0CLbb0DuKU
	ryFsBqprUR9T1IJNnwcSciMAjIucgfgcAsQVGDHRDExI+dqnR86tLwUx
X-Gm-Gg: Acq92OFWVTdH6KS4z1VckB3QHM6MJubygyQSpyor4ffTmR2xY5niN0PICUlRvVfdNBN
	78casyPZQi1PLbwMxiB6ouv0MtPkyZjIvusWUInZQluZJOu0UcSb4r6ArqjYkFys0UIAPztPeG7
	aR3KPdRiS9tZmGDghxH45sbMREN/Rx7M1GJ0fl05IXoaMalS7NihI4hlZUwePErekdR0VgNpDRb
	WeZ2lJNjdcClSxrQ/R3YLB2EmIiz6YzcuL1JOk+6F0HVcErNorUPTy+V5/jH4DHLjbzQ/5oAckg
	C5EP/9FG2js2Op1h+pp1DWPBRvDC4YX/3QnZmKy1yj1IRH56zrMT8dR6KeIAselG6d3L2jzEkWr
	bHdBVvB+h9z4Ngk0ix4u2Hgtz67nNpZuUdMKpdxn7oT0YMjrWvK6/tP4yklftNjisanYJsLe8+4
	ZzH91mcX2Hyd+xDyMpQVVNQxpHB3RVdU/49AoOddcO074p7qjPwQ72AVZRwt2CYqbPHRN2n6q/k
	cC8ByLQRnHHCBAg78eAeXy2RlgXTRg=
X-Received: by 2002:a05:6214:3018:b0:8ca:21b5:2e0e with SMTP id 6a1803df08f44-8cc7b604e55mr35958076d6.6.1779421548830;
        Thu, 21 May 2026 20:45:48 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131acf9sm6503376d6.43.2026.05.21.20.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 20:45:48 -0700 (PDT)
Date: Fri, 22 May 2026 11:45:41 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
	syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] loop: add sync_blockdev() in __loop_clr_fd() to prevent
 UAF
Message-ID: <ag_RZc908B64hTFG@fedora>
References: <20260522025451.845068-1-tom.leiming@gmail.com>
 <e4deece5-d866-4a44-9097-eaa1e2727c0b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4deece5-d866-4a44-9097-eaa1e2727c0b@I-love.SAKURA.ne.jp>

On Fri, May 22, 2026 at 12:28:34PM +0900, Tetsuo Handa wrote:
> On 2026/05/22 11:54, Ming Lei wrote:
> > Fix this by adding sync_blockdev() in __loop_clr_fd() to flush all
> > pending writeback I/O before clearing lo->lo_backing_file. Since the
> > loop disk is already closed at this point, no new I/O can be submitted
> > — only writeback remains.
> 
> Why can you assume that synchronize_rcu() + drain_workqueue(lo->workqueue)
> is unnecessary? Since we don't know exact commit which is causing this
> problem, we don't know what has changed.

When sync_blockdev() returns, there can't be any inflight IO:

- no one can open this loop disk
- no dirty page cache any more

So why do you want to add rcu/drain_workqueue?

Fixes: 1fe0b1acb14d ("loop: only freeze the queue in __loop_clr_fd when needed")


Thanks,
Ming
