Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E921480964;
	Tue, 19 May 2026 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194293; cv=none; b=HX9d8NrtG8vTdDpPrXnoIEv0Hb2lt83VyRqSGjTWRh+FGT8JE0lMk3Jyr/vlV6Z/Y7ma7cU6aaNV0ieD+OnU3ANd+nL9u52+pJgOZE48i7TPB8wqTsvMLZ3mluze8tfeodK9i21eLHwLZ4osB1GvfkzI3LslSnWg3uwakdUd2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194293; c=relaxed/simple;
	bh=LHCyAppFAGL+5+r/Umgxp1Qt07TYEEqYyPmfz03fYBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCu2HiqbNxmuiK+/Ro2939NPlf9x79fmZw+kwr6OVGSn2qkee1vuQa0Wqy20J4vNzF/xskQ4Vm2GXoWGFi04ytpALogzVVyFh2vhS3Xn8BQvtA/pSNbg+ubw5xq1cuSf62+M31JXzw02KfkaC0LzLc5SeL+s9komDvB93jMsnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64JCbgMM015346;
	Tue, 19 May 2026 21:37:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64JCbgtV015342
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 19 May 2026 21:37:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8f5602c6-52c6-4c96-9c85-892160b1718b@I-love.SAKURA.ne.jp>
Date: Tue, 19 May 2026 21:37:42 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/loop: Fix NULL pointer dereference in lo_rw_aio()
To: Ming Lei <tom.leiming@gmail.com>, Hongling Zeng <zhongling0719@126.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, axboe@kernel.dk,
        ming.lei@canonical.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260519040103.22776-1-zenghongling@kylinos.cn>
 <agvqK_4EelxnXUvf@fedora> <6A0BFDE2.5000808@126.com>
 <agwgbZmZiwzZe4-D@fedora> <6A0C29F6.5080704@126.com>
 <agxJdUf1b0JSDAux@fedora>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <agxJdUf1b0JSDAux@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/05/19 20:28, Ming Lei wrote:
>> This means |__loop_clr_fd()|runs while I/O is still active.
>> Regression introduced by:
>> 6050fa4c84cc ("loop: don't hold lo_mutex during __loop_clr_fd()")
> 
> Why do you conclude it is caused by above commit?

Some commit in the merge window for 7.1 broke the loop driver.
Even synchronize_rcu() + drain_workqueue(lo->workqueue) is not sufficient.
Please see a thread at https://lkml.kernel.org/r/d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp .

