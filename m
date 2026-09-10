Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7EC48424B;
	Thu, 10 Sep 2026 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042521; cv=none; b=qcr7nIeiK47yPrjDY1w1+gCtei423ibI5N9VWSH0MQZ1LrC1ybskN2Kt9ADXI95t1YbMQZVHBK2YoXJ5ODlKIua1TZD8Lv5WidwgW6f31G+X5aj+mfTrkPh8gKnd3lH78XdxzWsvUHUAd5cIbN7GGCoAUh4A/NLzkEpEt/IcxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042521; c=relaxed/simple;
	bh=PwBrAIaMu8oQIyyulPBwR1jewchE2mu8edNRHoKxoqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJZ9nYJ46JIwjTwSSI1eIdKJz88Ig1ZpXFu6icggvJtCTocpvY53Xp5oQgnG9xh4hXqytQ8o8m3fnFNCWFCU33+7wo2yyJP6+niDDnVwr49pMNZxcN8aIuwuJG2oKjnXyx9Sg7Tje47HceFRQI0DMngCma1cttP/bf96S/ddt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68ACDxpw035979;
	Thu, 10 Sep 2026 21:13:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68ACDxJ5035976
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Sep 2026 21:13:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a3c9aa16-caf8-49db-b7b9-42e3f3c665c5@I-love.SAKURA.ne.jp>
Date: Thu, 10 Sep 2026 21:14:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Add post_release() operation
To: Gary Guo <gary@garyguo.net>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
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
 <DLBM64YIHJ5U.3NZZTGR2NP75Y@garyguo.net>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <DLBM64YIHJ5U.3NZZTGR2NP75Y@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav315.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/10 20:53, Gary Guo wrote:
>> Real-world container engines, test suites, and system utilities rely on
>> fput() from __loop_clr_fd() being completed when lo_release() returns.
>> But changes which went to the v7.1 merge window broke an assumption that
> 
> What change? You should mention it with a Fixes tag.
> 
> The message should also explain how the assumption is broken, not just stating
> that it's broken.

Unfortunately, nobody knows why it got broken. Please see "[PATCH 2/2] loop:
Perform __loop_clr_fd() after disk->open_mutex is dropped." for background.

I have tried a debug printk() patch at
https://lkml.kernel.org/r/3244d4dd-8254-47c0-9609-b1db53450c7c@I-love.SAKURA.ne.jp
that tries to capture buggy callers, but syzbot could not reproduce this problem
using the linux-next tree. Now that I am forbidden to carry debug printk() patches
in the linux-next tree, we have no means to (try to) debug this problem unless we
send such debug code to the linux tree.
