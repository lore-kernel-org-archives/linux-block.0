Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97E2F360A
	for <linux-block@vger.kernel.org>; Mon,  5 Oct 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791216048; cv=none; b=dIVZjTLonoQl6WUn1j3RoKVf7rGsHVY5PDnuDvK0oocHOgq7zOTxztu8YAHkf88eyZL13FopyJxOE61xSgnTIl7+WIIuAI9VZpc57tO0pwpkLvo7YoDp5rRPr8/Tgtj2cYmGXD7RUidvGS8oNzSdmwk/ndxCiJIBUDus3/az1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791216048; c=relaxed/simple;
	bh=vDhcoDs+++6jTpDcE7yfejhS5W0hL1Wy+TM5R2LXN90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzA5vUI4BWfkj2wAgOCosoratG3ud2y6HxWAbKvCsYwpOHPmDmk71dUkLtnVsQBuP1bDxbaQJfnueCcsL3Wj1vKP0Oh5qF6SWGKBcyUwrk162blBXArcgUUBkO9RwnyH0iQ0ZBTsq+0aIkYoXK1QnCWTpdutghZzwjgCeSgOrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=eEfYpAvr; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="eEfYpAvr"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-34ca2d54925so3324349eec.0
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791216045; x=1791820845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blKtgKABl6ZvuHILCmQEnw5uMNFlpnL4aOfuP1Zm1FA=;
        b=eEfYpAvrFe5q7W4/WjtPBP5qpKqNCdG7EOoiYpWfudbTXKNk7TG+6Mehs9K6CGL9b7
         weg9ObWIbWRSTfSdrBBe59zVKdDII8qCZhm12HigXbR6sBF3nWMPOphFP0b52dXMejN/
         f1xzv61undV3xeIbq0xeWKFbqxlZDxC2iYZA3wIVuL/vjCD/ntJTkoBD1qLC6cR+5/ia
         BBfBjjqMbNXErnARyAGjcTRvzoy5UNt8X956QQU0s1vg3nTeu61XJneAE4EI7xjHR1Eq
         8x78gT+rlhGB6aqgB2LnnKbD2jzEbfH1S7rGcZzlVhrZiFBiXN2P7R73mvsB2Cs5CozK
         0YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791216045; x=1791820845;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blKtgKABl6ZvuHILCmQEnw5uMNFlpnL4aOfuP1Zm1FA=;
        b=WyoKzK7JjvmrIEYEzM3dOgZpqN8N1EbjDM6SdtSqybktobOJJjg5sFCgajsQGMXxj2
         jvqQjo+zXtzQ8HQvjID02ADSHd+X2GEOdNc750MOetJg+8fUy0081TyTVkDjV8Pxtu3t
         cX0UdYPr4twS++XmtYkmsg3CMXftZKnGkqeME4ab/iNF3REJy7ae4CDNtPyziIgVZ664
         rhxfXHYcATnk0gOShX3weFK9dLldW8t6yoNdTU+Cen1EiufVuImXLciN6zo4K5sP/vXr
         kIov/7+VWlXhoOeVjzHqW+81f7ou4GwbAR9W1XTBEinr58i9FsHSEs9LgVhM8eVRzaHh
         HQLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkC167jdbPx3SztUwE4oUrcn6+/OGRZRsk453Ia4K9Ewii//dOxb3RIHQ4zLQ9GxnGYVfQdMKO2b5kgQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7UYVtW6fmvJVXz+k6q6QU5w0o654ieA85bYvCzbovz33RF6mk
	ERjkTDwq8/WsNNfk3ZQ+GOC1sIAAsVUB1OdNwtALReI9au0EDGdgpz79mxMVTmV270c=
X-Gm-Gg: AYBFou01e9YijhPYwSMve1MCnPA2xI7FnEH2bYdI8mP42Sfm5vrWDn7LM4NtlJc9pYY
	7jtZ70uGIWwhPKRYwQAnXdcrl1uB90zC2+6lhwM+lLVNk0Id7NEnkaUVYZrsystvMFWWwL/HpHF
	pxp+o/uXcV+4pvWUwlJEhX+I1HxedD6kdUNzU7hwSCn6PtI9216P6GpOl0yG5W5KjfQkKYChxEP
	sY1qzCpSjhSRxKx5yrEwWidc5f/ZEenFTgrwLsNZTsOWyUOWAWIAZmAfQENNyHhSMoClSgyrl94
	iR5cAR6Cpb1/xZsneBRzvyms5pecV9oCwxxFkjnEszUpCXTC40WmfdkGZ3WwTprgk4QeUHdVIrn
	TatdTxZ2lA8eRmWjscyrLlE9azN0CQKgfpw9swNwcRPqQSecPWeM+a3yIG+lWbXpqMhlFYkW2lU
	NikHisvSbBzjgnw6d0TAl+iZqJFrNp6xWLkqCqtx5tcJ+tZbIaLLjtvgmAfDWWNYHZjtEoqTXSv
	igONIGyIWLL4N87YXQvCZizAxlJdg769tPc1FHJuva15niU+ZP1DIGhEQ==
X-Received: by 2002:a05:693c:41ca:b0:351:2cd6:5857 with SMTP id 5a478bee46e88-3512cd6593cmr4959516eec.27.1791216044630;
        Mon, 05 Oct 2026 09:00:44 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3513aacb39esm6290694eec.14.2026.10.05.09.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 09:00:43 -0700 (PDT)
Message-ID: <c2f6dc35-2f75-4c54-9265-8a18baec9f4b@kernel.dk>
Date: Mon, 5 Oct 2026 10:00:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Floppy fixes for 7.4
To: efremov@linux.com
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <348194a3-e542-45df-8be9-eaed588c07a7@linux.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <348194a3-e542-45df-8be9-eaed588c07a7@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/26 9:21 AM, Denis Efremov (Oracle) wrote:
> Hi Jens,
> 
> Floppy fixes for the 7.4 merge window, based on your for-7.4/block
> branch.
> 
> Please pull

Pulled, thanks.

-- 
Jens Axboe

