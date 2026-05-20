Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A122424C
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258979; cv=none; b=VMk/goVQAPIva8tmPHPDHRvt+0qUlSI4SX8t7tZ1jG8vEizTDaGnBWS2RN8ZfPvxwQXaMQE+rx5qA18187JzTFZ71AL/YeU34RDTIqJgCkNP9kpc2ZM1XeTOKLx411JxYlLLfooPE+aozjpSepC/ImY8y2P8rv/G6XgZqTzOpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258979; c=relaxed/simple;
	bh=qQgrW8IdMoyKO4wpJufeEeKGM7FMDEmRklHEU85yJ00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHym6gvcXtydA9mwrvKTwzWnRAApK3RFPkfTbFnat7NaIvGyLDYX+kWB7UYMxK0vZiN0thUpXYEHeQIrsj70LzHzBJVZeoSLRLHKzfBX2vjMaR8tlhagOrU2FP6OyPZCnS2tsfzKhPg7GxvHLYovvDy5yDHzFGelkP3Sdylrrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64K6aG2a088654;
	Wed, 20 May 2026 15:36:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64K6aGq2088650
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 20 May 2026 15:36:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>
Date: Wed, 20 May 2026 15:36:12 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
To: Ming Lei <tom.leiming@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
 <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
 <e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
 <c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
 <f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
 <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
 <9b2032d6-3f36-4d2b-8128-985c08a4fa37@I-love.SAKURA.ne.jp>
 <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
 <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>
 <ag0lS_CbKO9R5CV8@fedora>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ag0lS_CbKO9R5CV8@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp

On 2026/05/20 12:06, Ming Lei wrote:
> The IO after close(loop) should be from writeback. rcu/sruc isn't necessary,

Gemini's comment is that drain_workqueue() is not sufficient for waiting for
do_req_filebacked(REQ_OP_WRITE) requests with cmd->use_aio == true case to complete.

We could remove synchronize_rcu() prior to drain_workqueue() if we defer
lo->lo_state != Lo_bound check to workqueue context (or recheck in workqueue context).

But I still think that we need to guarantee that all "cmd->use_aio == true" requests (including
ones which had been issued before hitting "WRITE_ONCE(lo->lo_state, Lo_rundown);") have
completed before doing "lo->lo_backing_file = NULL;".

And I don't know whether it is safe to use
"blk_mq_unfreeze_queue(lo->lo_queue, blk_mq_freeze_queue(lo->lo_queue));"
immediately after drain_workqueue() because we are holding disk->open_mutex.

