Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C72066D4
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744766235; cv=none; b=pDEtH2wLapgpBjxFsiwiLw54QpQuRHa901lfcFZbE9809qcbSNcPSIpd1cQNGGz3B/UyLsIbdUiWFcB1zYWFKSwzp1BQs4PIS8dsp1S0Myex+QnI4MhWKIF8xPzd8uZKN6kxzuDDefyqbvqnf6Q6nyzzpvlLaDoju+bqwGmR7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744766235; c=relaxed/simple;
	bh=ZzNS94P04rypg+LBacON/u30ytgZIaydK7yOsJOBadA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmlKbAo3Z+k3HsvvkptRMrmHfJ8jq9k9tQHeYVdlxhHQsvQe8F63vwPYolF9oufoAjMmU8/rmjp9puKJB1wrvcsoYCFFh3bklSMjXSfk5fooneKg/QHy53O1Rwlj0qdNfIeYM4cozO7HdHLJVG6l0QQJjTNHxEgos3yXeBKlBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qJIOko5M; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qJIOko5M"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b3f92c866so144382739f.3
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 18:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744766231; x=1745371031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ezaz3PVaSjzi1KweuZ1yyCFtgimOOIZFhnqAtfnSgDA=;
        b=qJIOko5MetSb3PYyfgk+DdrZVrBa4yntVp73NtgKGIQqSKHhtlqKboR529Rlyz4+u7
         9fGyP4+Qi3MghZFWAs8tGWBdk8LQSJ3EUdgVQA23IAuyhUS1QZ8ph1mG4kEr9+L2kVt1
         e+OCmlL9xnuULTHeDlk50YGlrg+NCi5DIa8kIei6cIbbUFXmjIku8nWMcx+8ecR4rYMs
         v7FLI2HESDXckygSf1dkBR5iEbkIBHdoUuD11iH8aJqfJexE5NHewZgY2UcCc+KYO8q+
         w3JnFSlFjM46Zhcqpu3SbJicgFB1kzjsPk6p8x8jsZSn0SSN1D/4K5MKWJnARIl9pJPV
         M71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744766231; x=1745371031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezaz3PVaSjzi1KweuZ1yyCFtgimOOIZFhnqAtfnSgDA=;
        b=ON9ts4cID1Wg5welshuuBCoopWkYQu+Q+09zXtX2mv9jA1ITVVk5OOEZn7aoa8IP44
         BUWihxWta2+ano708X7Oxm7yQF2gFnabLEIh50XbPllGmgrKsmU7iqlNpvZivAp4qvUI
         sYykKlNr45emeSJkj+cRzlxZM+4M4KoNp3JJkqG6jK0iiKBvqb2weohfVYw9UlkPgqqJ
         R1yhbdD1GLpvdgsFEj75ChqsAW4MlC14pYNW5M9/9wSwNnz3yHTlxRT/jpIxvt+eQ+vP
         bGPlTzR/oANRiMV8+4qtkrj7d5S1aDrxZPQpjlYPRSJ0xbG0jN8U6aFFWfWi+R+xxVmr
         AtoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb16Z8q80RBgMzV4elOr9oSjmEPUBpAJcjQP83sM7AhIa8iNTCTndvImpBCX/7WB7SrQpRVAgStbJEnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmd5ep8FvDVRYvx0ajN2gFlWcYCmibk4RUV6GVCLIjBsu8h8S1
	jdLiXCdqIyBppM7USLjveW+OnFEX/4kvMY/jhA578eO76GsFn6YTtHt7gjsH7cU=
X-Gm-Gg: ASbGncsuKMM0OvVevVHvfFK3rxujzsIIAWZEOoSk/cv24cXRxlZ9KK5fDVVv18/xrCM
	5qPYgbJodawHp7L9Pt15UQ/Mc5meFlr7fnul4w2nrAVZ2YTtz7awMc3FYVPEHZklvN8lXhkqlk4
	XzjQTAdATRE+t7pkeXAEZcoaFFYwRLdl0N6UPt2FgDA7ea/1HUwN3QcTkhl2LuJeOlqaw19VCt+
	36BmIG9v713Iq5b1yt2imXb1lujEnE4WG4exFXFxo0QTn75PnhPHIqdcfLz53OTPniOfJoPp9/6
	B7vEtwT/eRU4WG6sCw9gUbRhismMwwCV5Bg3lA==
X-Google-Smtp-Source: AGHT+IHX/hBHRZAf3hH6+amtM2VZxnJ6VB/AV8+Wb/EETF8qutHLrfPCvTF/ynQhZZsNUazIqIGlmQ==
X-Received: by 2002:a05:6e02:1a4c:b0:3d5:eb14:8455 with SMTP id e9e14a558f8ab-3d8125ab86amr15103215ab.17.1744766231319;
        Tue, 15 Apr 2025 18:17:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dba648d4sm34430105ab.10.2025.04.15.18.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 18:17:10 -0700 (PDT)
Message-ID: <be1d189f-2c00-4b0f-979f-11fe4169d79a@kernel.dk>
Date: Tue, 15 Apr 2025 19:17:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org,
 Caleb Sander Mateos <csander@purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-3-ming.lei@redhat.com>
 <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
 <dc912318-f649-46bd-8d7b-e5d18b3c45b5@kernel.dk> <Z_8EQPd_tcY3NyvW@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z_8EQPd_tcY3NyvW@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 7:13 PM, Ming Lei wrote:
> On Mon, Apr 14, 2025 at 02:39:33PM -0600, Jens Axboe wrote:
>> On 4/14/25 1:58 PM, Uday Shankar wrote:
>>> +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
>>> +		      struct ublk_queue *ubq, struct ublk_io *io,
>>> +		      const struct ublksrv_io_cmd *ub_cmd,
>>> +		      unsigned int issue_flags)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (issue_flags & IO_URING_F_NONBLOCK)
>>> +		return -EAGAIN;
>>> +
>>> +	mutex_lock(&ub->mutex);
>>
>> This looks like overkill, if we can trylock the mutex that should surely
>> be fine? And I would imagine succeed most of the time, hence making the
>> inline/fastpath fine with F_NONBLOCK?
> 
> The mutex is the innermost lock and it won't block for handling FETCH
> command, which is just called during queue setting up stage, so I think
> trylock isn't necessary, but also brings complexity.

Then the NONBLOCK check can go away, and a comment added instead on why
it's fine. Or maybe even a WARN_ON_ONCE() if trylock fails or something.
Otherwise it's going to look like a code bug.

-- 
Jens Axboe
