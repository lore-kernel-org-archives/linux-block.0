Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCF4A2629;
	Mon,  5 Oct 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210334; cv=none; b=HTx9+kihLNQiKLupyFri33s5Ir1u6Q0uD6MbPXv/iTfGdlfaLWYgxx8zAoqSg9owqVbrpig6Rdvac7nXLE1YEklETc5qilGayPdhfIkJwUw42hLaDRxmXcQddm+NbLRlw39nLM3PHbzrGvNOduG6JOcRBO1Scr7R2mFFEDdZnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210334; c=relaxed/simple;
	bh=FURY84a4hreewwSGvIRHpylE5IQ4G2Rm/RtDCflphd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErxX7fTiCiAKZhYUj4eH4ZpsuPtJgovM36NwTB4+HCEl0Dz+Umasr0fKy42fYxbj+1cZiiOx2h5xFpot2KfOmsuuq+t998rBfZTdgkuWbqviOUz3emCut+IaA2sqwrpltGNimmcw7W9J6GwpKMrsRCLSgebqrDDCkWMzWIax7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 695ENr1p078254;
	Mon, 5 Oct 2026 23:23:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 695ENrfT078251
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 5 Oct 2026 23:23:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d17920e3-ab22-47a6-a152-9393a34e9b3e@I-love.SAKURA.ne.jp>
Date: Mon, 5 Oct 2026 23:23:49 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] block: Add post_release() operation
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        rust-for-linux@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
 <472c3bcd-45d4-477b-9e81-3c68601dc18f@acm.org> <20261005084521.GA8879@lst.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20261005084521.GA8879@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav114.rs.sakura.ne.jp

On 2026/10/05 17:45, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 10:29:42AM -0700, Bart Van Assche wrote:
>> On 9/22/26 10:09 PM, Tetsuo Handa wrote:
>>> Add post_release() block device operation which provides a hook for
>>> performing synchronous cleanup without disk->open_mutex held, which is
>>> needed by the loop devices.
>>
>> Hi Jens,
>>
>> This patch series fixes a longstanding race condition. I haven't seen
>> any objections to this patch series. There is at least one other patch
>> that conflicts with this patch series: "[PATCH v6] loop: defer the queue
>> limits clear to a workqueue". Please consider merging this patch series.
> 
> No, adding magic out of lock extra ops is a no-go, and we've been
> through that before.

Christoph,

I understand your architectural principle that we should not introduce
driver-specific magic hooks into the core block layer. However, if you
carefully read patch description, you will figure out that we are facing
an inescapable dilemma regarding the loadable module lifecycle:

1. Deferring context is impossible: Once a function inside a loadable
   module updates state or invokes module_put, the kernel lacks any mechanism
   to safely wait for that exact function text execution to finish before
   unmapping the module, leading to potential crashes.
2. Delayed VFS/fput sequences are insufficient: They suffer from the exact
   same synchronization limitation.
3. Userspace modification is unacceptable: We cannot alter existing userspace
   applications.

Consequently, handling this issue asynchronously or synchronously is
restricted by structural limitations, making a rejection of the proposed
hook (unless you propose viable approaches that can fix this regression
without adding the hook) equivalent to leaving a regression unaddressed.

If you think that we should find the culprit commit first, please show us
viable approaches. Facts we know and choices we have are explained at
https://lkml.kernel.org/r/1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp .

