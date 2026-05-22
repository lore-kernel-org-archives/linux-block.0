Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92974594A
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779420521; cv=none; b=md2EbFv9K/Y4k09cGtsk/qtHD6ydw1wQUkl2bEmwiQ9TlzizHHWZMHqNDUlW0Z5W0So9BQD0Jwq+O5h2rK9ilaEC+L3EWfwg1UyNGWajrx90XcSA+tHbE6tpxh6qX1qQe84TQK9CeYfXTndMv0j+V//GKlkP9z6CRfEPfGBtJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779420521; c=relaxed/simple;
	bh=rvJ1UvHpDBUygkk/A7TVTUaLJ69XIuNlsGG2dT2j9tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqmsO6zFvFFfLs28uVNMy749wA7wYkWbbHuwf+qhQHglfm0ZcvH5EZNFJYM8eGXQBFPB1NM5hjKhn2B7r+cQ1o54nkvtbNnUOyrjhEc8IyeOWUN1F1c9X98WTCN3Og8aPhP3GmO/FfSmpBDVGpZt1yNtyJ4ggMzxMU5y7t6Moo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64M3ScQV028240;
	Fri, 22 May 2026 12:28:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64M3ScvP028237
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 May 2026 12:28:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e4deece5-d866-4a44-9097-eaa1e2727c0b@I-love.SAKURA.ne.jp>
Date: Fri, 22 May 2026 12:28:34 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: add sync_blockdev() in __loop_clr_fd() to prevent
 UAF
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
        syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com,
        Hongling Zeng <zenghongling@kylinos.cn>,
        Bart Van Assche
 <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20260522025451.845068-1-tom.leiming@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260522025451.845068-1-tom.leiming@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/05/22 11:54, Ming Lei wrote:
> Fix this by adding sync_blockdev() in __loop_clr_fd() to flush all
> pending writeback I/O before clearing lo->lo_backing_file. Since the
> loop disk is already closed at this point, no new I/O can be submitted
> — only writeback remains.

Why can you assume that synchronize_rcu() + drain_workqueue(lo->workqueue)
is unnecessary? Since we don't know exact commit which is causing this
problem, we don't know what has changed.

