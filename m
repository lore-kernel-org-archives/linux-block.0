Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938B211C
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994382; cv=none; b=GmtzC7fq+r97WwXWR5PRWO2He7oEJakzSlMOJpNg1qlA1wf8hFJzXNmZy3VmkYxGvwhZKWtWKkpSlJgYm8t90jPC/iLx69/eCnCfofthuC06U257vVzRyCII4biCOMS0/Fkwi3qADwt9HkSAvvbYzKEf1Ucaazo8JiokhGmxlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994382; c=relaxed/simple;
	bh=1AX25iEg1MxhnD5UtAuwlfAqR0MHHRQ6cafvezuHuAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y03uKMgxa+dWyKsU1vZEIIbx2MPf9zlDul0jtEoCGFinAs3miV/rf+oSsfT5bPQjvPLraH7Wa3jbDcXX5YDKoUee5t7IiJGgZZJIY85PGYpWvL/H9mMqb/I+ikQ/lSlAerg1j0gOgDJikQQwyrEAIOyM0+cj2ioZbHfZpW4HDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=j8E8Y3SC; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="j8E8Y3SC"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3dd87535709so52860945ab.0
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748994378; x=1749599178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RuCMRQ7iYf1qMbtxSnk4SgDnOMirNXiJvRPwnEkEhZs=;
        b=j8E8Y3SCsu+4W7KtcWR4O6USu/xjiL14hIXSJWtHi7Sgx3cQQKR+cSCiwUJS93dqQK
         4/LGDZmhTxPG5pDA5aMWSB8z5mWmKIECqi1upMNjGF8gySd+hnr1nBw2dA65dPE8onaL
         k+HMSirO9FgPj/l9BVpzYWhEig0YBziZZCWmluKeEdwMtJOsGFIW9kI5cnF/QLfB+JNS
         a8TfEeR6F5cq9+MPukit7250gZsjgzFzW0ChAOu10NkDCFKBxJbFbutl3hkj6IZObgIt
         LQyJ1IJlgo2tfLWp4fnXfr/ytK0HGk8kU1qKuphW9cvc6jfNxHmryZQv7rtE6C0xpiaX
         kJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748994378; x=1749599178;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuCMRQ7iYf1qMbtxSnk4SgDnOMirNXiJvRPwnEkEhZs=;
        b=EVCBGyqkvWQhF/7I61NNpiWzNhlnbYjlGoUkc0djCXqqLep7KaSGw7OiPuj9T7cW0e
         MgWJUl7PJumpfqmSVWcKUXicb/wC9GD6/ubp6CPlbok6XQN5jG+5jROSgIPdmijxxvuA
         TUzAKApgWfRNg9QxAhZsKAt/sk1lR5et4qUizRol6Or3t9xy7IkMFKugiqIAEkdV8vHY
         beJLF+YueYv9pTAOHQX1kHGNdEA/5/T8dPfRkSVbFZrvbJj1FKyD7aXQEbf3T6R+vN9t
         hNC2pZ+oSERwcJRD89lti3K4jC4j5Zx1PXZ5jPdRPirzdXfsbs4xy1UFynHSAxXqdaZ4
         C+sA==
X-Forwarded-Encrypted: i=1; AJvYcCXFGkTmTH5yqnyZo+rWy9Zrg8iManrbE62i+6Zx1YMzvlF4DKyIQ0FNrNxLQs4Lm6v2Qjk2tHEO0pFM8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmtYROQE5+DgKf1PynrDu3GiOSbpcqW3EG8OGVcXrM7HXxY3F
	8Uw+D/wuvaAg0E2d6eKeBPMn9Yuj1whkbU5+ADyqzljfeutiwXtL+leUbdM+wwL4hYQ=
X-Gm-Gg: ASbGncvrqTHd0dx6v8ks8LcKmf2xPheu3Q+jQGfcrCZA8PRHlpMV/jmbNvu+G2QuSrY
	JsBfWRWBwOyPlaXoM2r3isEVIV+plZvFN1fP5QrGuTjitzW+s3ZWlQDaTQd/CetMpI0DZsg4cfC
	uOTfaG4pyyOdYZtWhDF6Er33DzxsHisXDI1jD+uAdkEYcduMhDXOXWBgdQgAi/AeJB7kGIsV153
	/0ECqvfKhwm25EbxssoIyeknW5S9OgXz/6bWotHMr8GwVKHa43wDPJWKOGI1zCdAMt82EMWpG95
	XbRbFvELeB8elmLk6RaA4T6sRkCIiO6ytouFDZLjywKAacBm
X-Google-Smtp-Source: AGHT+IGYxRcht2r/aeHDnGMEQTh1TXnGFF8yWmcQVpHA/odKJUFXkUEETt44KPk3mlf7gnGLbRmvvw==
X-Received: by 2002:a05:6e02:4414:10b0:3dd:c04e:49af with SMTP id e9e14a558f8ab-3ddc04e4c9bmr174695ab.3.1748994378409;
        Tue, 03 Jun 2025 16:46:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7dff26csm2455246173.22.2025.06.03.16.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 16:46:17 -0700 (PDT)
Message-ID: <7458912f-d3a3-4cf7-b668-eb0e78590b75@kernel.dk>
Date: Tue, 3 Jun 2025 17:46:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: flip iter directions in
 blk_rq_integrity_map_user()
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603184752.1185676-1-csander@purestorage.com>
 <e37d8707-8770-4f20-a04a-b77359c5bc32@kernel.dk>
 <CACzX3Atwuv5RNqk5vah8J3Ce0i6sZdF+Tmnbw1K9qpDLU9bXxQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CACzX3Atwuv5RNqk5vah8J3Ce0i6sZdF+Tmnbw1K9qpDLU9bXxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 5:34 PM, Anuj gupta wrote:
> On Wed, Jun 4, 2025 at 12:24?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 6/3/25 12:47 PM, Caleb Sander Mateos wrote:
>>> blk_rq_integrity_map_user() creates the ubuf iter with ITER_DEST for
>>> write-direction operations and ITER_SOURCE for read-direction ones.
>>> This is backwards; writes use the user buffer as a source for metadata
>>> and reads use it as a destination. Switch to the rq_data_dir() helper,
>>> which maps writes to ITER_SOURCE (WRITE) and reads to ITER_DEST(READ).
>>
>> Was going to ask "how did this ever work without splats", but looks like
>> a fairly recent change AND it's for integrity which isn't widely used.
>> But it does show a gap in testing for sure.
>>
> 
> Yes, you're absolutely right. blk_rq_integrity_map_user() is currently
> only used by nvme-passthru, and Keith recently added a test for that
> path [1].
> 
> As for the user block integrity interface in general ? it?s been a bit
> tricky to write generic tests so far, mostly because there's no way to
> query the device's integrity capabilities from userspace. But that
> should become much easier once we have support for that via an ioctl[2].
> 
> [1] https://lore.kernel.org/io-uring/20250416162802.3614051-1-kbusch@meta.com/
> [2] https://lore.kernel.org/all/20250527104237.2928-1-anuj20.g@samsung.com/

That makes sense, thanks for clarifying.

-- 
Jens Axboe
