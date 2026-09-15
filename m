Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A43BFAC0
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507790; cv=none; b=S0NXCGF+cVXRZRx/6mEupEu6DR4LcFDR8JqqKetx/S2xOEhJvNFBb64OqkMyUW3AdPwB6ztxL6whEvxN1PNBHEMx2ry9KcTJwCbi65mw+HqM6qDQkXAyU9wCH7M+4UbLQVU6Hk8UHyTkRCIMGE4WOB1FOM4gA7iiHufKsKMl9Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507790; c=relaxed/simple;
	bh=yx5Fr+divRbcs9QYGD9iNt36K1csv117Cvf/nf+9DGk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P81KgPJs2fVVWzzd99fuGdlBzyr5a9igOU2014s2PxGqt8cJ8HOT/weKhht0DRA2zfSKCBzdPYgecs1L4di19sGbNpYGbSGb4J4QioqyRSCwpd2GDUVfRwyuTahUQ7/vNlAFwCnzyCobrirxwSKjftkCiv0/hbs9Q3PQqIylpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NXScDh/5; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NXScDh/5"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yx5Fr+divRbcs9QYGD9iNt36K1csv117Cvf/nf+9DGk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789507786; v=1; x=1790112586;
 b=NXScDh/5Kt6PuKHPxL8z2ZNGhXF8x8/+5McOWFwZYhBW3qHEv+AKZC6UXAAqOu4hwJEiYOMb
 /Gwl6Fop+kcDDxbep9x4DlSkciBHFXbLIalkRTYC3C4Ej3eiyq0v3Q3Vfrf0irBpmZa7L1nIZuU
 dUbrwAKuaFlUh1iSEAxI5DDQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bf330ec59736de2f;
	Tue, 15 Sep 2026 21:29:36 +0000
X-Mizu-Trace-ID: bf330ec59736de2f
X-Migadu-Flow: FLOW_OUT
Message-ID: <829d5857-6f28-44c2-ba9a-d9b7a3069b89@linux.dev>
Date: Tue, 15 Sep 2026 23:29:31 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 for-next 2/3] block: allow error injection rules to delay
 bios
From: Haris Iqbal <haris.iqbal@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260830012002.80275-1-haris.iqbal@linux.dev>
 <20260830012002.80275-3-haris.iqbal@linux.dev>
 <20260915091146.GC15715@lst.de>
 <6bb6b89f-d71a-4c1b-b6a3-89e3f3c02e2b@linux.dev>
Content-Language: en-US
In-Reply-To: <6bb6b89f-d71a-4c1b-b6a3-89e3f3c02e2b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/15/26 23:24, Haris Iqbal wrote:
> 
> 
> On 9/15/26 11:11, Christoph Hellwig wrote:
>> The delay does look fine, but I'd really like to not use up one of the
>> scare bio flags for it.  Can we insist on the delay only working for
>> an error, so that we never have to reinsert?
> 
> We can do that, but that's only half of the feature, and the weaker half 
> IMHO. Only delay with a successful completion covers a more useful 
> scenario for testing in the upper layers.
> 
> I am thinking about how else we can do this, but did not find a nice 
> approach.
> 
> Maybe we can #ifdef the new flag on CONFIG_BLK_ERROR_INJECTION?

I forgot one small point in favour of the flag.

We can remove addition of __submit_bio_noacct_nocheck() function, since 
with the flag the re-entry after the delay would fail on 
blk_error_inject(). This would remove confine the change to 
error_injection files.
