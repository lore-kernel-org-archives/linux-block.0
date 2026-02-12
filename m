Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA82253EF
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908508; cv=none; b=sLUxoOs6h7s2RivfDD+fuzXodW3Xn+lJ8MMR33cWKMHPSZO4BCkcmADShY5zMbQFNfK9t4Ei6TnPViZ+aEetIS9D69OcqoXafUX8nhOP46RZvvPvI9E7LxbdVDmi0AZlHRT6VHQPR/nq7fp0XiPGn+qy33/13LHW1NBB5PDwETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908508; c=relaxed/simple;
	bh=SU9IhclmYAClkIor0Wj2kzs0hgoV8SbTOCEoQqrbUHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iez0dWCteMo9UekBdShFhLW0NI1kWQMcAVBOb6RNBlXqVq4pGaav3WfRhpG5JzsN1FK7pwwTv3hoIWXO+HN/woAG5+RgieemhBDPvWvtqlJx/khg8A+9QOzFJXp2d/OT0ceopZh1iMx7cT/yWCHxSQENacld/82zlSKnWDlC224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=lqev2ftq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="lqev2ftq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4327790c4e9so5297686f8f.2
        for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 07:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1770908505; x=1771513305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5IOSasBlsX0Zq7MQwRuynmqCbpOzr3vQNsDoSWsb48=;
        b=lqev2ftq/PYnJitIimWWg5gzKqLAXLI7REoSEr/nSjHtWKjGvTjqyK9pDBwsly/oyK
         iGJOPRIi8wSCCTmX/SdNgrm+1RxpZBmIuNeIFrGjj3kEbcUY4Cl0CEt97Jp/5ggp2PW7
         vYGCXl1F4+qEESN74SsjPFpVyuSLyl/lskzDGRR2lGQB9rKoTqQBLa5v5MOrgC/Z1e9Z
         t9O8twCiQKsQsObeuWxojR0VdKsmw1T56tPy/YtMqtbx4tHhh51gMv0J/ohYbpaWAi0W
         9y+RlXo85TLI2K+1WUy5um+254LJaYBCfC/FbapXMUgj4yVBB+1O6sllKlcFnZQ4X28h
         B2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770908505; x=1771513305;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5IOSasBlsX0Zq7MQwRuynmqCbpOzr3vQNsDoSWsb48=;
        b=XQFyUFDYN/ho8oToZNp4gNGGFCUj0697xWk2asu8T9218LGKEzDuhFz4208GSCpB7e
         1UldfR1SVQTr7NrA9K+rYeG2Wx6WgzFPUHJ6ON/JikG/jMDgvEX73U/am4ZIs8NlGxZM
         RztFtmWZOkZJKiuz61Dkr/+k9DMCWaPSgaxtgyn1S4QM44LPbsos3SXL2DNhZb2kHlRz
         /mAxZAn3COEMteChtdZKp8GvMXf3oba8H7auH3d+kNjmdBdf9fdUby4k2B0pYKwH+e07
         0RbvwQJsV/nlV/67ZVzWlPrVp+Q4VaBqN81whh7AjnEJs2bOxx3jwkLihFaI/7m+w28P
         eaIA==
X-Forwarded-Encrypted: i=1; AJvYcCUvWoY0m43q0sLdrBhZYBw7vO7BbiByWDx38RffU1jgsk0a6FIRpk93HOJazgN/wF0bD5UG/874pcj2Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFYQvMu42SP9ek2Q9+uz64EI49pHNEBAyQsVCgsR3VgqbNAEg
	02F+fTpjbI+05lNCgTIB/g8lAdQwwzAllV4hlCum/YSuSEPNMvtYms28N3RvNblsnJs=
X-Gm-Gg: AZuq6aKdwvRb7KsBcm6Wgz/gzl/CSfmy4HopnDxb6S4bQM5440S+XK9DQNydLdei6qm
	bFWixjGbRo+VO6qiOp3QDiJqeqUU1f4FPHTCtEPlFB5lIdHUWG8/O+wyt2Dv3C8WC4Vh3X3ZQ9P
	EI4ZceIjY9i3RwD9uRI5UXRD2dsLhHHxvUYCnEqBIUV9lXISAkvKvl6KI2U6L83+daMp0cbSm22
	Qc/bdlIV+E3pqIoBng1SEQJE16Ajj+BGL91Uk+APx45G1zZBaI+WcIsxB5mtr3YiOkkdfG1Gnru
	/4ZjkraxLAkx1leEHQM8osMXpNotOQLogq257hyI3ICuxom+sBH9RZiANCcXdBemgA+MRFPsTgt
	nFOYwcmZjfgvEWwl4viGjh50qPkgeqcOSh7L5Salkeuty0sZ7upEdLgKvmqJSh2ZjTBmTCpldc1
	YXcCk2IfwdziC9XGSdJJXhAJ+r+mrriDYg8zhvijMAhrP1Drar2K/W7TSnTvAm033LiZuZYGb5B
	uUskaUhDVO6MwvGk1+E0y1mMQ==
X-Received: by 2002:a5d:5f84:0:b0:435:e436:7fb with SMTP id ffacd0b85a97d-4378acaba28mr5911570f8f.50.1770908505145;
        Thu, 12 Feb 2026 07:01:45 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e5be13sm12942474f8f.35.2026.02.12.07.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 07:01:44 -0800 (PST)
Message-ID: <eaa83421-a07a-4ee7-81ad-f32d4a237ff8@linbit.com>
Date: Thu, 12 Feb 2026 16:01:43 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: always set BLK_FEAT_STABLE_WRITES
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
 linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
References: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
 <aYWNhtixUGuj3hat@infradead.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <aYWNhtixUGuj3hat@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 06.02.26 um 07:43 schrieb Christoph Hellwig:
> On Thu, Feb 05, 2026 at 06:39:29PM +0100, Christoph Böhmwalder wrote:
>> DRBD requires stable pages because it may read the same bio data
>> multiple times for local disk I/O and network transmission, and in
>> some cases for calculating checksums.
>>
>> The BLK_FEAT_STABLE_WRITES flag is set when the device is first
>> created, but blk_set_stacking_limits() clears it whenever a
>> backing device is attached. In some cases the flag may be
>> inherited from the backing device, but we want it to be enabled
>> at all times.
> 
> This looks like a bug.  If an underlying device requires
> BLK_FEAT_STABLE_WRITES, the upper device needs to inherit it.

The current block layer logic actually seems correct to me. The
underlying device may or may not require stable writes, but regardless
of that, DRBD itself definitely does need it. In blk_stack_limits, DRBD
is the top device, and DRBD's backing disk is the bottom device. If the
backing disk happens to require stable writes, this would indeed be
correctly inherited.

So the only missing logic is that DRBD still wants to enable stable
writes for itself even if the backing disk does *not* request it.
So it seems to me that this patch is the correct fix for DRBD's special
case.

Is it not supposed to work like that?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

