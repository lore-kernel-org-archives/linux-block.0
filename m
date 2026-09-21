Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72C2BEC5E
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951806; cv=none; b=trWJ+pA/8sHApB+OMoNRficoKgRAmvZg69eSc8bgiguVWjBJf5lApadxMCj2uX4sxxlQo5k8UZHk3A1EqU3M7kSubd+SVzFnLSZvAHQHUGZ15Ew3kgN2Gc2Mic1JqHlntPR+OJzzOxh37A9JCJ8AGnb5zZ4wj5RpvMmng++nm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951806; c=relaxed/simple;
	bh=Q68W6DJvOvJF0jsWE/lYPQUA3cwXS/yYZA9Ji6n8c58=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r0EwIskr61jCl/SvnOUiTMM/yHqKIuViTRoNM4LgkNWPE7xoUV7oC/WVqE84xhjNF2boV9+b5W4B69JwA4bs1mEna3U6reHRZvBrBvSQBEG6D4Ce7tjtEGTF6duDJIRmLNSTsQL4RL8dj6YK0AVeKL8iXivNmVMo2+KIm/JGV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dXtaNntx; arc=none smtp.client-ip=95.215.58.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dXtaNntx"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Q68W6DJvOvJF0jsWE/lYPQUA3cwXS/yYZA9Ji6n8c58=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789951801; v=1; x=1790556601;
 b=dXtaNntxNTYmUuqoFPGiKy44Xq8IolNzeaSw6mOcRltjA+e75RfBjyAzYY2WJGmTs2Ed0MGP
 NkV43j2wtLyjkLParyRz3oTaCOxyzV7b8pcznRLyqxbKSMiS4zPntNxWAcZL+Jg++mKyieTFAKv
 0BKp1bXJd2xt6D93y6BmptcQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da597ef8d03558fc;
	Mon, 21 Sep 2026 00:50:01 +0000
X-Mizu-Trace-ID: da597ef8d03558fc
X-Migadu-Flow: FLOW_OUT
Message-ID: <7141040b-5a15-471f-9bbf-9a18bed864e7@linux.dev>
Date: Mon, 21 Sep 2026 08:49:56 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-next@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: next-20260917 and next-20260918: merge of the block tree breaks
 all zoned devices
To: Damien Le Moal <dlemoal@kernel.org>, Mark Brown <broonie@kernel.org>
References: <20260920125846.1806521-1-cui.tao@linux.dev>
 <20260920231226.771a0e21@canb.auug.org.au> <aq_5QycDLgQGCc86@sirena.org.uk>
 <d97685b3-f22c-4a27-a7d7-24b2ac7dfbe6@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <d97685b3-f22c-4a27-a7d7-24b2ac7dfbe6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mark, Damien,

在 2026/9/21 06:37, Damien Le Moal 写道:
> On 9/21/26 00:18, Mark Brown wrote:
>> I did say when I did that merge that I had no confidence in it but
>> nobody responded.  Can you please send me a commit on top of current
>> -next which fixes up the resolution appropriately?  I can drop extra
>> fixups in relatively easily, it's probably safer to take something that
>> you have tested.
> 
> Mark,
> 
> My apologies for not replying, but I was traveling. I had looked at your
> resolution but only quickly and I did not notice the incorrect comparison
> causing the issue.
> 
> I am attaching a diff that cleans up the conflict resolution.
> 

I tested Damien's patch on top of next-20260918.

It restores the zoned null_blk here: nullb0 is created again, reports
host-managed, and the queue chunk size is back to 131072 sectors
(CONFIG_BLK_DEV_NULL_BLK=y, "null_blk.zoned=1 null_blk.gb=1
null_blk.zone_size=64" on the kernel command line).  So this looks
good to me.

Tested-by: Tao Cui <cuitao@kylinos.cn>

One question for Damien while looking through the merged code: both
parents had the power-of-two check for zone_sectors, but that check
also disappears in the merged result.  Was that removal intentional,
or should it be restored as well?

Thanks.

> Thanks!
> 

