Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB414EC59
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065128; cv=none; b=VWihyLV3c1qzLvIGJEgPSzaPUgKhQxbucr3xW3PyqtIyb+9i/A8TSUkHBaymZPyxtpbCM+wBMFo6AgXUELrVijp2w6Vxl6uS8DTg/UWL2eXIX5WOxHkl4+JZmVB9Tf4agpIRtnP2+0yPsxrwg9b3988Q4q/o69QWjxEcpSYd3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065128; c=relaxed/simple;
	bh=KaIe2dQbnXofLgkuPJEMTv8jsIUoQ7i48bxgD4UULn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c9E3GlrlSRdXxtnNJn802zdzaKaFlo6YD7wU8HElGlokvp1ztFvRs1PoVVKU3TreqDzDNINJlXvPzacxKiIaN6fouihR/ehBMpxv7qo/xD3q9s5X8ZhSLUZQ/Jk5TTMGgn3iFWlKYOxEQ+VMpUGzucQWaSud/ti4Ay3RUcLcK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZO729u/r; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZO729u/r"
Message-ID: <52a728e6-deef-4670-b987-435296b42047@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714065124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yi6LIj4GgMqxvDCgeL6VzfcEhDtEprReMoeTWofkwP4=;
	b=ZO729u/rDl2yIr49xLVfcgYprrpyoKb+Ah5QRZdMO9E7YQbPGBJ95wCJYRFkwIEN67eDw0
	fLc4QSFJLk8JkAbt14CwywjYQlNgy7dZNEYiBgEu3ccX3T08Kg3LJ0Byb2xzOQ0iDyLtQr
	/RUssYnH4Z6Tg66+IzN7d2NRuQsuHZg=
Date: Thu, 25 Apr 2024 19:11:59 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] null_blk: Fix the problem "mutex_destroy missing"
To: Jens Axboe <axboe@kernel.dk>, dlemoal@kernel.org,
 linux-block@vger.kernel.org
References: <20240425170127.4926-1-yanjun.zhu@linux.dev>
 <e69bea72-1454-46ea-82f6-c1d091ba8a58@kernel.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <e69bea72-1454-46ea-82f6-c1d091ba8a58@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

OK. V3 is on the way.

Zhu Yanjun

在 2024/4/25 19:11, Jens Axboe 写道:
> On 4/25/24 11:01 AM, Zhu Yanjun wrote:
>> When a mutex lock is not used any more, the function mutex_destroy
>> should be called to mark the mutex lock uninitialized.
> You didn't fix the title...
>
-- 
I only represent myself.

