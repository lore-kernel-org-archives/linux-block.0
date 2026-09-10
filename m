Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FCC353A98;
	Thu, 10 Sep 2026 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033517; cv=none; b=BrNrq2rIyZTm7MkJAVdXLcZW3kfYQE8eIStp19I4egtVk08FSGXLlkEz0ErRxri5NX6lGDAzF86lPOVSBNZt4tzdY697xaUuPQU44QwFLoBu8kYwlcNGKT4d2rBZZPwYOqk4UOkelcyB1sL0mlw4saQyFrD07AgILuekaoJ7KTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033517; c=relaxed/simple;
	bh=l84TTOIDqvwD3+3Y5T+muNrkmjxHsfnE6tUQJdjTJ4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHQaYZycUhzlPX2WBg6klunpRMQFdoLdWfTspTaaICPXW3txgZr4dcX64edMbwMgAKQ8Ck0kQ0z42Ow1Zq7F778J153Ibg+9QCQmAV/hLMW2cj3+/d8ngDuqatZRUd1f7WibbYmO+sq8fCezxpShML856WhZHkCjytMCHVdEOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68A9iCt6050966;
	Thu, 10 Sep 2026 18:44:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68A9iC9x050963
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Sep 2026 18:44:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <08b0057a-280d-4e55-8e94-e510ec1a371f@I-love.SAKURA.ne.jp>
Date: Thu, 10 Sep 2026 18:44:12 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped.
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        rust-for-linux@vger.kernel.org
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
 <9f1273a7-6dfe-46bb-966f-fe08876f4375@I-love.SAKURA.ne.jp>
 <3883b05e-0a34-43f7-b2a9-a46d2b0c5ffc@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <3883b05e-0a34-43f7-b2a9-a46d2b0c5ffc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav411.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/10 4:33, Bart Van Assche wrote:
> __loop_clr_fd() is queued from the lo_post_release() callback and hence
> may be called concurrently with or after another thread has called
> bdev_open(). Hence, lo->lo->state should be checked instead of assuming
> that it equals Lo_rundown.

No, __loop_clr_fd() is queued from the lo_release() callback.

This patchset passed sashiko's review
( https://sashiko.dev/#/patchset/60bf7af2-b84e-4056-9195-a26ad51ada46%40I-love.SAKURA.ne.jp ).
