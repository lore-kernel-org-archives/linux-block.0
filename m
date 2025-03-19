Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87721CC52
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349281; cv=none; b=kao8o+kKutJWfo8+FHhX1KAA6WEkQn+SBrumCIQK435QrgbAaPeglA75FZ6e+PY7kBVYW2I3ukbt8px6L1OEidLvoIBIi2RhAKAt4gjqImpaKDHncYNvYNX6eEdMlJxxMRYG61ID7ay1/K2mp7U80NAQGwjkBYe4js433K/25mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349281; c=relaxed/simple;
	bh=O05zv9Gr7ij6UY/M3en/ncnaSQw7ZAi41fgFLgqI3zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhyfZO7yxb8Btm/sOyjIvEfmsLdvKm+EpaAMjy7/v6mb+AYAIGMv7jLh1QHU5qTN2wUjVlqEjXdmMKMXHHuiCxAQpjN0rsUMN7LniZhdnr5T0KLDsTkK3nQGYyfrE9UJn9Fo42bvx7qSTU7jozBsEzZABFydJYvRcqrF9DOuH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1K9tS80S; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1K9tS80S"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85e14ce87ceso6330039f.1
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 18:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742349278; x=1742954078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+ADK92XLUbLu1McrNmz+RFbt3c8h6ORFjxwugmoA+4=;
        b=1K9tS80SuM1wLi8vpMJcRdmTuX+726/S7gyHJTHUHuBJuYs13T+2pBvwVV4OBtr+Tc
         FEiHA/vnPF/lsVERYYYCXI0bZE+WGwyUWPXS9VkqyVYRDvlmU56BjBhA5kTgmRy/PeL5
         E2F0yJAoulFtlRo+J0FpiGcJbr9vrkUnfRDC6UmRKHFKpDpVoenNy7tvTWsqwLISE7vA
         ixBz4A0U+n2QimxZ+2HBpaOqswQm/NNQZmgmd23snugtW2mCKZXwqPuD8MpyS4Gk3P2H
         A4eAO5FBKl37YDidbHVfErLqnnjiykiDE8MKo2MzHM+jrKInxPCnCGbR+08I3K6u3nIH
         cnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742349278; x=1742954078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+ADK92XLUbLu1McrNmz+RFbt3c8h6ORFjxwugmoA+4=;
        b=Ro2t99LmpfqxOczuR5y9iu/quAbjjvi98sfYLaizCCFFKwe+3Ft3HSjK0+rNbS07+6
         f9wUF65VOS9SN81NF/uLARuz5RQOtwFpV6ni9wBiRYEQmfF6LMBRlaRcdRl+Aa2YmOWE
         qO5WudxyGPMK6dwoHaAaRJRdr03ORQO5/Iparknm6780whQYwXN1nvr2GHp85o8eS+wn
         ZjwLsXel/SVJD9IrRpELoLfI4qU7rRzzw8DDOJGUpdxbMwdq9GzIN8BdGejXtileCYnT
         eQNFzfpt+0yf1/opRFOCSQFvZOrsFvJOGrUPKrRe/wG25QOB7ydXphloaRjm82L5PgBT
         y0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXuO4chCq2uwkNeJLVFtOcut0/CEKXumWLuBp2y7mo/x0hYLWbWjkOdy8DNE4h8mWzVJ+J4y9poaHjOKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmPS0/P/SXrlnpllBQSDDrE+ZD5hNNTe8697dFT4KvapkLG8K
	WX9CZ0iKzEXJPTbh7UTKbEGKkk+eIZXth8ZpBDErBabncUVsBaRQhxsWpK3u1vU=
X-Gm-Gg: ASbGnct3Ub648E1iCukcQ2Fh2WyoTs/Gxh7EfzP0jquBqrKLaiXJIVWWF6IGdNwQV39
	6vEFtJbv6f+boy2mWTxqZlK3iKyPynWna4zmAHajUBYKIy5g2qE2dO9wzWlJfvtD6wQwtQc9gV4
	KixH8eI4nsz47Y1DifMFPJi2dNXoyKiACbIZAxi0gRud89tfzPXcc/fa6ouxQ13UyE5Pa7qaqQd
	kgVphKjEgyrPmcOvpMdm4YdLN/n0JtTXSRdDl++ib8vgUdOE0qlnl5sk8JUERFtbG67GgZc2A9F
	DIh3W1DT+S1ivyAAnzvT8Ke7urt6LK0OFIf/CqCNDw==
X-Google-Smtp-Source: AGHT+IG83dNvTQFpMCt3EQiPF9LPCDkl3G0nYDFFStwTN5nKFtl4tIC7PhUB1HeyZ1mWwotU30XEYg==
X-Received: by 2002:a6b:dd19:0:b0:858:7b72:ec89 with SMTP id ca18e2360f4ac-85e00bcf75emr547531539f.5.1742349277855;
        Tue, 18 Mar 2025 18:54:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263816ae0sm3029513173.119.2025.03.18.18.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 18:54:37 -0700 (PDT)
Message-ID: <a8d7e5bf-be50-41fa-8b1c-1dedaf7e6609@kernel.dk>
Date: Tue, 18 Mar 2025 19:54:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: remove io_cmds list in ublk_queue
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
 <c91dfaf8-d925-4f6d-8ced-06ecb395a360@kernel.dk>
 <Z9m+3qMBXgqDz399@dev-ushankar.dev.purestorage.com>
 <097f0495-b2e8-4938-9a0d-c321f618d49b@kernel.dk>
 <Z9nsjiynsQ9gRPv7@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9nsjiynsQ9gRPv7@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 3:58 PM, Uday Shankar wrote:
> On Tue, Mar 18, 2025 at 12:48:44PM -0600, Jens Axboe wrote:
>>> though I don't see any examples of drivers using it. Would it be a bad
>>> idea to try and reuse that?
>>
>> We can't reuse that one, and it's not for driver use - purely internal.
>> But I _think_ you could easily grab space in the union that has the hash
>> and ipi_list for it. And then you could dump needing this extra data per
>> request.
> 
> Another idea is to union the refcount with end_io_data, since that's
> purely for the driver. But it might be a bit weird to tell drivers that
> they can use either end_io/end_io_data or the refcount but not both...
> not to mention it could be a nice exploit vector if drivers get it
> wrong.
> 
> Either way, I think this work is follow-on material and shouldn't be
> rolled into this patch.

For sure, that's what I said in my first reply too. It's just an idea
for a further improvement, not gating this patch at all.

-- 
Jens Axboe
