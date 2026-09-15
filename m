Received: from mta0.migadu.com (out-114.mta0.migadu.com [91.218.175.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE03876CC
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507495; cv=none; b=VX8WGm0oAVHAwvtlfSZrQcfb4b9d6/5jyz/yE4GUfGDCtjdhbfUp9oaIGtOCvmJigmW6sHDp285nTiLPiRWQ56ay8YWsZ0ZzNVCG9kN1e0lqDrlRDVJixQrQH+YLmWM/X91izWdxH8xxt0mLEcfzbS1I2gQuyPU9EeDUkoYLgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507495; c=relaxed/simple;
	bh=I0+RkRvGqL1aCvF39DMr9vLXaraMhC+jzk+S5Wrh5eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGag6SHap45ppQNXWWiQJZyItebgTQztonFbICnxHK+gZx1X68g1GS+Pi6ZUQgxeGpg/xCQQv2sYSIsecIm/AlOma+66N4NDAuS9SRrvJvklx4kufqxfhMTfjeqTzHSm6DceuKH+LqB43ENZNKDW23z+9RXN1W+7iMGIgsVEWtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vjE/lTVL; arc=none smtp.client-ip=91.218.175.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vjE/lTVL"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=I0+RkRvGqL1aCvF39DMr9vLXaraMhC+jzk+S5Wrh5eQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789507492; v=1; x=1790112292;
 b=vjE/lTVLXuUVqoTHogKbMRf8++FFMjlIKydy3xLytVAOVa0WjIfbpxg1gf7l44Aw7130W2sh
 Qu2uV+Nw8PducfKteBhCIamUPF05MFduo7+pf4JqKxN8Bfds2hHpYVSnzMvMsdeQHUlFCxzretA
 agloehMe9LSDXwRk7B480ttU=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 59d463225cf82e34;
	Tue, 15 Sep 2026 21:24:52 +0000
X-Mizu-Trace-ID: 59d463225cf82e34
X-Migadu-Flow: FLOW_OUT
Message-ID: <6bb6b89f-d71a-4c1b-b6a3-89e3f3c02e2b@linux.dev>
Date: Tue, 15 Sep 2026 23:24:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 for-next 2/3] block: allow error injection rules to delay
 bios
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260830012002.80275-1-haris.iqbal@linux.dev>
 <20260830012002.80275-3-haris.iqbal@linux.dev>
 <20260915091146.GC15715@lst.de>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260915091146.GC15715@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/15/26 11:11, Christoph Hellwig wrote:
> The delay does look fine, but I'd really like to not use up one of the
> scare bio flags for it.  Can we insist on the delay only working for
> an error, so that we never have to reinsert?

We can do that, but that's only half of the feature, and the weaker half 
IMHO. Only delay with a successful completion covers a more useful 
scenario for testing in the upper layers.

I am thinking about how else we can do this, but did not find a nice 
approach.

Maybe we can #ifdef the new flag on CONFIG_BLK_ERROR_INJECTION?
