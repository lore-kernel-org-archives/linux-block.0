Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD913368AF;
	Wed, 20 May 2026 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247254; cv=none; b=O5GRvBYh6IJq7B3avjYesxOz28gY0aOHlk1eaSxeUQ+pXJHqEH35PUwGFP4Ms6oaq7MBXkVpB0VD4TkX0EuEps34Znt9FRARPQ3+I+c0Mzd5Kjq6ynIFEk5wC5BnSGVoSiatJibOntjci+uXTxjSyYJ4eIcv4B4b5jgg7D06fog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247254; c=relaxed/simple;
	bh=cfYq+SjH+p+YG232F3VRkdb2diPl1oNEJ31m4DeUH6A=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=H2koBLQEjVZDgBlNHKHpR9L+jJO4BhcrSS9MNijnEvcjUv3hX3gECWqB8rjAt16GI3PutGx7gVzJ4S1GrXsiWnEefCFr6eW71ZmMFoIF92V9ZR4lMM6DSXgkWbOqNL3VtLUWX/K3fZgYGQbkKw+tq9qQYTR0H1ogaYANw2MAz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YDVBch3i; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YDVBch3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=XB2OMyDi8b4+Shyxz45cEcm4xV0Vs3VCygezyQF4KrI=;
	b=YDVBch3i1WQ5MDHiUnSMfwDs6anstozmqJ9h+sSAvBdRaaWdYLmIvAFzVjoH/Z
	rKZ4pGzSSORfmNU0SVFky0nd7ldRCYlJTq+f9OlcJzW6E0NZa/d6YSpvBNbBSlhG
	RsM7uLvD1hOj/PHlcrgZU73TkuOT96AsPoFWyY4f7R6N4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnF9p+KA1qpSx1Bg--.2621S2;
	Wed, 20 May 2026 11:20:31 +0800 (CST)
Message-ID: <6A0D2886.1020707@126.com>
Date: Wed, 20 May 2026 11:20:38 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Ming Lei <tom.leiming@gmail.com>
CC: Hongling Zeng <zenghongling@kylinos.cn>, axboe@kernel.dk, 
 ming.lei@canonical.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/loop: Fix NULL pointer dereference in lo_rw_aio()
References: <20260519040103.22776-1-zenghongling@kylinos.cn> <agvqK_4EelxnXUvf@fedora> <6A0BFDE2.5000808@126.com> <agwgbZmZiwzZe4-D@fedora> <6A0C29F6.5080704@126.com> <agxJdUf1b0JSDAux@fedora> <8f5602c6-52c6-4c96-9c85-892160b1718b@I-love.SAKURA.ne.jp>
In-Reply-To: <8f5602c6-52c6-4c96-9c85-892160b1718b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnF9p+KA1qpSx1Bg--.2621S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDAF18uFWrGw4ruF48JFb_yoWxCrg_CF
	409F9xJw1kGr4UWan8CF43ZrZ5t3W5Xry5Jr47ZFy5ZF93JFWayFs3Grn5Z39rXrW7Jrsx
	AryF9anYkr1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8DEf5UUUUU==
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoR8H12oNKH89sAAA3T

   Thanks, I'll review Tetsuo's analysis to better understand
   the full scope of the issue.

在 2026年05月19日 20:37, Tetsuo Handa 写道:
> On 2026/05/19 20:28, Ming Lei wrote:
>>> This means |__loop_clr_fd()|runs while I/O is still active.
>>> Regression introduced by:
>>> 6050fa4c84cc ("loop: don't hold lo_mutex during __loop_clr_fd()")
>> Why do you conclude it is caused by above commit?
> Some commit in the merge window for 7.1 broke the loop driver.
> Even synchronize_rcu() + drain_workqueue(lo->workqueue) is not sufficient.
> Please see a thread at https://lkml.kernel.org/r/d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp .

