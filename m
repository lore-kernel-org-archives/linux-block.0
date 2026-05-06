Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6347ECCC
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083803; cv=none; b=rjo4NoC1zNoWfL4+o5H6JIsymX8LkoKofGxfI47rHmtVJTP+PRe1ptoUnopJ2JLhQhFcko5JSzZP8/YT1o1doVDcTJSJtgdj5urgDU8CgUW8S1sikmPEv+uWzG6qKGeUGyTPIoa2dWsD5bAyNPOJ3s7/X0hYHkM9Kd0SXrjHiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083803; c=relaxed/simple;
	bh=Ltmww/TaZRSwsxXdq96zMuTwAKSPAmUK/p/2gnFH3zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKyY5TBhf16NTBwNPOiUL0SVpG022jNoI5H2/Z3BOjXKgC3JSa09fv/Y4b5Bs5ZBanEypl0dPgun8VQMZuYMv9IdRxYyIwmQ0YYCURr8ClVDWJYXbchOhBg8ySgwurX7eXq2PyLTlbTqvjTQDe4PazbEVPW+vGSccUuvOVQM4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=mmPl582m; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="mmPl582m"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44e1860558fso2479921f8f.0
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778083789; x=1778688589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moQGF7pp1XOTZVL7jCjZax7yaoIeVu2C8Kbzu2VHlSo=;
        b=mmPl582maZOBg94Mw7SkavMVrzOXRF/CYKrGWNFAC4a8dxakRSYXlgnWBNqmB1hLmM
         EfbIie4E68+W7FRWf9jzB8AAe+0aMdf2oHo9qrTLZNcRN24DauWyiUr97l/zqa9mIFq8
         WdMuFOPgWB0K3nmjhdmKdPiQM2wnaSzngIs7de8Ujm8YaY4tI2KF2ejWz07UbZjOTh+C
         YKwoCdGnAIq484muAoMrofTbVhn5EwWTDIQ3KrHX+Xy+FtYM5kd3MvKt2fbZbp394NZP
         4E0zmnwzptkrjQe2GioovShdFNnZLgDSj5sEC1aae3wRKHmtXjrOWutCs3qoV7e3sit9
         2TMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083789; x=1778688589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moQGF7pp1XOTZVL7jCjZax7yaoIeVu2C8Kbzu2VHlSo=;
        b=GPwtUA2pXkmGpKeLVXjiJYY+CPd1nNvJC9m8w4t8XA+XUSY+SogXPQdABes47c33zd
         uv7+r7TlOoZTltXv0LPZoaT0N2y/m1sO5mowQfDDlGJNNf5+y4g4wFNirByPCOayQ3s9
         Z+63mANIRSTjwjWIujJ81t7VJ5BF9ulaCUnLT5bars3YXHkv3cmD+NScLa1xZ8voFgyH
         g1cpaevE9aqJJEVW6cpw5VTfCDBorQUrEd7PIN2QeV7Mj/GoNp5CA4BwMTRwCC6MsMQE
         gC/rlOzakuQJ0iuSPj5AM/2EfB4Ise+XR9TaLTZnBHM/uKs1iRSfq7hXeCa1WHEbzpxN
         WMSQ==
X-Gm-Message-State: AOJu0Yw0M19aeZsFtrWRE5r5S8CgYYejqClDIcKWI6DWT0ZybIr6dS6o
	E9o2OMIgs9ukx8+6enuV7cHcGkuU+D8+2bfTujr435gYR1EhOAygsniWl7T1kbPvlRTK8xEJ6De
	LfCaZMz0=
X-Gm-Gg: AeBDieu0dDv5c4lP0M0R+VZe5nW2DS/q18IxKvl8/B01VImV6bAo+LFeETyWYnhcsKO
	1eeE2Rd2Mck7CZDLOVPkwvXp7oCNs65r3UZBPV82YUKLkJ2IxNXQ9lIqM4tz+8z3Bb4jfoj8cJI
	otqC00/9lqs2if9rAowkG4HYFWsQpcyAwsBVkaeoHEOU7lfidZYBBZGZF0KkY0SjB1REHqHWxca
	qfdP2b01Ik8JL4cGNc9j3DQ3cKe3OwsO2ByKEUH7Mtd5F6Ctz28CthjACyAr2lHQ36o//LdndL5
	zcuOBA1LOfPj4MuZzPdPfCD85QIjGUzyDITN4R3dp8SB3BIVPstroFiXZrSkfRSfhbp2I9ird8g
	CHqOFEFs6ixYJLP8y/2EDTZTkRObjBbTwXMApgitQMky89vSxxunQvhCN9R1Hd2GE+/wpLCJ5Xd
	lkzFLNXI0VvdH2bpT2I09Fq9a9QanzdR0CPC1/WJQSY66ZxKnmNzsL3gYElIic51+Ka7fUEBX7Z
	mkTjt0zV9p8GAlX2kXQxxvD
X-Received: by 2002:a05:6000:2891:b0:452:9d2d:1001 with SMTP id ffacd0b85a97d-4529d2d10b3mr470946f8f.0.1778083789005;
        Wed, 06 May 2026 09:09:49 -0700 (PDT)
Received: from [10.10.101.107] ([188.252.209.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm13116925f8f.0.2026.05.06.09.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 09:09:48 -0700 (PDT)
Message-ID: <e9ab1605-2dd7-4364-b16b-dcd30d369266@kernel.dk>
Date: Wed, 6 May 2026 10:09:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: only read from sqe on initial invocation of
 blkdev_uring_cmd()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <64e053e4-24aa-434d-9b35-794d3b292628@kernel.dk>
 <CADUfDZq11PnyH5Vh8VjUzsV9Mxq6=0poGw--umMxccfwXiz54g@mail.gmail.com>
 <be3d5412-ec7c-4abf-b890-22c0b7295cc3@kernel.dk>
 <CADUfDZoBeHme=7MrSxm1dtGu7f-HY6EFDVcZZQRhaSdFAukTmQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZoBeHme=7MrSxm1dtGu7f-HY6EFDVcZZQRhaSdFAukTmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/6/26 10:07 AM, Caleb Sander Mateos wrote:
> On Wed, May 6, 2026 at 3:43 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 5/5/26 9:32 AM, Caleb Sander Mateos wrote:
>>> On Tue, May 5, 2026 at 12:38?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> This passthrough helper currently only supports discards. Part of that
>>>> command is the start and length, which is read from the SQE. It does
>>>> so on every invocation, where it really should just make it stable
>>>> on the first invocation. This avoids needing to copy the SQE upfront,
>>>> as we only really need those two 8b values stored in our per-req
>>>> payload.
>>>
>>> Maybe I'm missing something, but how does this avoid the SQE copy?
>>> Won't io_uring_cmd_sqe_copy() still copy the SQE if the command issue
>>> is delayed by links/drain/forced async or if the initial issue returns
>>> EAGAIN? The code change looks fine to me, but I'm not sure I
>>> understand the motivation.
>>
>> Because the alternative would be to copy it upfront and then using ->sqe
>> would always be fine. But we can just ensure start/len are stable. The
>> patch is about the latter, not adding any further copy avoidance. Yes if
>> you use async or it's a link or drained, prep will always copy it.
>> That's fine.
> 
> I see what you mean now, makes sense. As for making start/len stable
> in the first place, is this just hardening? Currently, it doesn't look
> like calling blkdev_cmd_discard() again with different start/len
> values after it returned EAGAIN would cause any issues.

Yeah it doesn't cause any issues, just prudent.

-- 
Jens Axboe

