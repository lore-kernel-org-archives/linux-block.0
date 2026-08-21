Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC2391E7A
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316367; cv=none; b=u2J2dsHFQk1H5At/jNPc6ZR4VsFIdILO93uRg2CsHodv+btTOS8dfjmpVx9+9u2yu7mIYfaSubusN7VKtd8lSVhKCPpoIsL8v5GLuHU1YfnCCRrnwys96uza4GJbKWZyzRVmh6zuXe6jGZwXixYVB3I+waIKnksp724Bx/NyBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316367; c=relaxed/simple;
	bh=JLV4e1f2mU/2LvyMpFXDbCVR81DoMSlbTdP+wKxDhJc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=K7VHCPc4uDLOnGv2qx71tZyW3MGYhllgz/kaD7suS4a6RsSbzGJwJduRai+B7HP1QolyGMG+ns9cndGTr2t4A7PBFI2rhZXl3MQVVX5Nmrjhe4yaM4nWdgtcCAHf17eMvACy9ujb3166W1actMg6M0kklZygUsvnqEgJyXavRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67LCk3U5002036;
	Fri, 21 Aug 2026 21:46:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67LCk2rl002033
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 21 Aug 2026 21:46:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f5cb9935-1497-474a-8e96-661914f18a71@I-love.SAKURA.ne.jp>
Date: Fri, 21 Aug 2026 21:46:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [block] general protection fault in lo_rw_aio
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jens Axboe <axboe@kernel.dk>
References: <cdf41ad3-783f-4a14-8343-c893d6c50524@I-love.SAKURA.ne.jp>
Content-Language: en-US
Cc: Gary Guo <gary@garyguo.net>, Mark Brown <broonie@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Boqun Feng
 <boqun@kernel.org>, Theodore Tso <tytso@mit.edu>,
        kernel test robot <oliver.sang@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>
In-Reply-To: <cdf41ad3-783f-4a14-8343-c893d6c50524@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Virus-Status: clean

Hello, Jens.

On 2026/08/03 22:34, Tetsuo Handa wrote:
> Hello.
> 
> I am waiting for your response on
> "[PATCH v5] loop: Fix NULL pointer dereference in lo_rw_aio()" at
> https://lkml.kernel.org/r/30ccdd3c-6353-4a0f-bdc7-230ec3bf4765@I-love.SAKURA.ne.jp .

You have never responded for 4 months since I first contacted you at
https://lkml.kernel.org/r/e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp .
Nobody being interested in this problem has caused multiple issues for linux-next tree.
Will you become responsive on this problem?
