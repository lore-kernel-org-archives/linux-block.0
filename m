Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0E1292E8
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198989; cv=none; b=D2Kn+zrrkeQn7QEhjoUhYYkR1d9wxXsryWX63avjQbnfZF+3zzutYzbBORmmNRpDIKi0SpoFh+8OmFgB1RC1HFt4XyWvTIsk3qNRw7ac0bu1zoEBgHrT7CTfwSFnQW/KRXAEAuuB/ldRYnFEr5V6z2gO/eClksHVnaBknKCpRiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198989; c=relaxed/simple;
	bh=tbH3ZcfEZi1hTyHe1rC+rgg4mr+vvSHAw05EM4mwVZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jePLq2CErweWt4FSgtQHwcse9oCbUljQ4evGSeFIV/+rgNQxp9NkTYpJDocxsNdna/LMxKt2dPCGBwax+PMNdnQfDbGT81R4Kjz2SQ/xATkstOqOM/4w+9XRwR5Vv6FiRZntp91qzatvq//3OcWwLZPNdBL8XOJsio6U3ylMsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PSBvhXYp; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PSBvhXYp"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bee01886baso85296739f.1
        for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 08:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706198985; x=1706803785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WyHxjKtVXGSwGC6zU0Wll0qpN4a6mMfynNab9F2/w+A=;
        b=PSBvhXYpNkFCyR7iGOAemGEYqQ5+s1kqmfy9SH7e7fCf9TnRN6c3qDxJhmkyoAmMJz
         bP/h1TcjdcHjG5sW0L/BubkqzKkUzpvs7Zh2lXOlVB3Q0e1R/UP+IEqNnBYY3jSrXu0L
         /KkJGWfhBDxuCfzQxl4AoCqu1HBNjZtFgEF1mRCMhnsD8SlvxMSH8s8VT+3zl+oIEaKo
         mSjJPEcHD8ug9QiZhwJ+k2BQPyEEjlhxxtEuW3+ugm/lU26OXNAgpoyf4+A43vaI5VKV
         rMkA+hsexEbhk2NnV746wgMAqllVMzCIe86CIFvsZYZs2246yxWpROQ5qpdIb81pIlBt
         vmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198985; x=1706803785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyHxjKtVXGSwGC6zU0Wll0qpN4a6mMfynNab9F2/w+A=;
        b=OpTxC1EkfRELfASHMdzyxiEqwOuN46Xqt+2uhTXv8bhcrpVq02Wm/jMuhu8sdQmW7W
         baEvSdFGtdSl+XpWjgzq7L+g7ZFtDCzAnW530r4dEZoS3Y7D4yWFbF6zxak5UP5j+lT7
         fbhr9o6ggA7HMZT4JlYBs3FcHsq4Sr0ADjz3EiD6LpnpGutf55qGYsak8OeE9whHVkhj
         dlgEVUjqfRN/4kM/WPb6WshhNQ/Kf3XEtm7DY76R5PEXqCOcSbtOYe9edguN4H7/Lnks
         gxZjmWBdYc4xI1Mv9GXktG/F+N2MxR2alAFgTiWmLeWJNK67rWFjAuoqZ47PWKzxioDc
         XikA==
X-Gm-Message-State: AOJu0Yy1HyytyqaHrZP8YTtOG8CZ5UWCGN02gGwPTTv2wIofo4iOyFMs
	8yA/eV/ULFIGqevQ2kFk5jXmoyTtQe4nTcWPnejkqI5dkZZUq32qNOCbaCeSDhc=
X-Google-Smtp-Source: AGHT+IFCFF1erf4MT7gNzcrY0j99+IrW8aynC/2V1tHd5SfWQOYOTsc0TDco8BBXVgJlZq753TCFpQ==
X-Received: by 2002:a92:cd83:0:b0:361:9667:9390 with SMTP id r3-20020a92cd83000000b0036196679390mr2721223ilb.1.1706198985222;
        Thu, 25 Jan 2024 08:09:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s2-20020a02c502000000b0046df6e19b9csm4572238jam.34.2024.01.25.08.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:09:44 -0800 (PST)
Message-ID: <07de550c-2048-4b2f-8127-e20de352ffde@kernel.dk>
Date: Thu, 25 Jan 2024 09:09:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, RFC] block: set noio context in submit_bio_noacct_nocheck
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, tj@kernel.org, jiangshanlai@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240124093941.2259199-1-hch@lst.de>
 <be690355-03c6-42e2-a13f-b593ad1c0edd@kernel.dk>
 <20240125081050.GA21006@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240125081050.GA21006@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 1:10 AM, Christoph Hellwig wrote:
> On Wed, Jan 24, 2024 at 08:40:28AM -0700, Jens Axboe wrote:
>> On 1/24/24 2:39 AM, Christoph Hellwig wrote:
>>> Make sure all in-line block layer submission runs in noio reclaim
>>> context.  This is a big step towards allowing GFP_NOIO, the other
>>> one would be to have noio (and nofs for that matter) workqueues for
>>> kblockd and driver internal workqueues.
>>
>> I really don't like adding this for no good reason. Who's doing non NOIO
>> allocations down from this path?
> 
> If there is a non-NOIO allocation right now that would be a bug,
> although I would not be surprised if we had a few of them.
> 
> The reason to add this is a different one:  The MM folks want to
> get rid of GFP_NOIO and GFP_NOFS and replace them by these context.
> 
> And doing this in the submission path and kblockd will cover almost
> all of the noio context, with the rest probably covered by other
> workqueues.  And this feels a lot less error prone than requiring
> every driver to annotate the context in their submission routines.

I think it'd be much better to add a DEBUG protected aid that checks for
violating allocations. Nothing that isn't buggy should trigger this,
right now, and then we could catch problems if there are any. If we do
the save/restore there and call it good, then we're going to be stuck
with that forever. Regardless of whether it's actually needed or not.

-- 
Jens Axboe

