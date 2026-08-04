Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F523D566B
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822104; cv=pass; b=r0UDIAXbjcYMV7zpFBUCFeodLfBnKTMPi0KVvynzck8J3/Qgvgsb4kyk8Z8w1tSW44FFKOyZTCapTHwk+ZH1blPbxY9l++DWAXwKdZl7qCgP2BKs2726BY/McsGuUiBHswgSz4HJMKp3o4e6TAyuoWJBz0n9U6Z5dFS6Jh+WU5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822104; c=relaxed/simple;
	bh=rc9GeNxYacpB0CYdtKD5SwN4Gkn3z306jaLlyKihy/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZjnmVZ4k/IVH+wRQYJ4wJogLuxFuYIyrRoV4zPolZsSWh69KOQ+4ryzDF07seaI0UBsZAR+kYfAGq5qSvCLX2Wiy50mt5Lk7GLYVykLpKMpyPvV+/J98FDzug9nvoKBhjhXN1mUcFQXseR/4Nt79KUej8r+f+slmVrfM95ZLk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArA/7I1e; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArA/7I1e"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bf9466412fso3536389e0c.1
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 22:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785822100; cv=none;
        d=google.com; s=arc-20260327;
        b=goqm+pyzKWwP2bOrOAAfYVDBJAZNxGXXOfWH3Esm5YVssgwoC/UJ+0w8tPSlH9oFaU
         qtBfG+ntlDuYhJW6emP5qcsHdcFPQIWRtA3/fdnoM7oQtqU33NMsgeFEfT4j/REKQmzo
         XIyOlMhitEZVmDjSGDJAaj1SXKyHIGbdBXPQXeV+Q6CPhFHAiRsjEPoOUPOkIofHvgA4
         w0ivinlc6QTysYtYSesGDdQFqgZCt2leVw4xszN74b7b3HmOAH1lDTZWU9bdBBOtNdd9
         9Q7s2h0O++lRjPTYjwHmCnRAFV8h9wPjbD3nH8jdW1tbUDGoEP22lD21+lsT0Oe03+XP
         kYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rInnpLn4lCoCkOv7jPR28G7eG35rChpZ+1ECCyGIUL0=;
        fh=x+oHhfXK3wSMbNhK7dttym1lgiBfv5Nr7YatwvCsSy8=;
        b=ApNBS2fj9kKDRjIzV8+m7uXDjC0ZyeC1gBzMqAFX65pEt9Y9Fc52qNKfrhCxhsEd7/
         KJbb/p5ft7znRzl85+r329rU0qpRY+D+003O1D/w/8nBc3AizbKucs75UmKcXf2zoitJ
         /8toWDMgtuFhQPu4mR906KpWlcewRT17aMjJTL8aQbVlpGi98YRPW++0V+wOnjOGB4X/
         kEK0GBUa+34WoMX9NIl1ZFl10taCembW6Pgq9dfI8eGXXvGEOlb3UJ4GFfS3smpnBgee
         n39X5C0vFnysYy8bHy9LqAPgWpvxxqjRK60Drz1qW85i+L+awAxVoWqkRdSk/6DS2y5S
         YAXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822100; x=1786426900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rInnpLn4lCoCkOv7jPR28G7eG35rChpZ+1ECCyGIUL0=;
        b=ArA/7I1epmEq1FcuR0jPbRr+NDW4ixF65EgSLV+Q55l2e4pgWImltE6JVVzTwwdbFK
         SdOH44qoNMMbRwhtRKjJBhhzVpNlDCejhxpggxElI09K9pQsEF7VieRBRpKc1/0vrgGL
         zJPxm71lgp1sKJiwB/sgtppoQaDvmnPLuv3IRU/aJFZo1AYWGWdL882H4KpXju2paxTG
         GNvjz20DmOGy7s1dXQQceJ5NyRYIKW+euAkFvvrr3xUlXUCeyktSQ+TNqvTpl1I5p8vL
         kSa15CkulS/Kk3hD/khk52wgSjEaisyEmgfOI4XxRpxSQ8yVgh+KzPFPRWHbRFsYwsTA
         DQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822100; x=1786426900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rInnpLn4lCoCkOv7jPR28G7eG35rChpZ+1ECCyGIUL0=;
        b=B/NanOdlKoe/OiavOswtEBjGsngew27siy/n4c+1JItleZLBB5rcjdhH/Oq808YIWY
         dIKobmtaDB8BjFO/3N+wiXfQUs4CKR4vQs9iSErWFQ9gFuPMG9urPGJbscUHrSnyweo1
         cWzQhWc/vy0SthBq3f4149HsO+XiR9VP4WjGT7Mg+EqP1C5qgapvFlXO6BjJnQMAjI5j
         uApgpWmPJVBu83Q0FhTTi9ftT9fvv+hCCQXnUiEOrPbYscDdK/bfShjYJGRWT9fDGzFT
         g+/QgPcU8BwKvYg2lKxvStwrIbCu94o84zAvV5IWfHfcGRC5SXhNmsNWi10qYXUNMkpO
         0wQg==
X-Forwarded-Encrypted: i=1; AHgh+RpBAFT9ithEB/PnMxb+ITfDQ4Wt6vQ5/hraWUOuOOmV4KidvUQtzEnUUjXn2sDh3gaVkM3GWKufVFVnlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNqCXI/rOQBhyugbLLj6nOZ7/xxlFYFw6Mxw4b+kkco3k/LNA
	8SUyB/SWBlxH5wvz/UQPPzxB08WTZEEYxiZGVIi5ov5SYLN+vK6A+2aBzUja0HtL82knBJI4B2i
	23FlA/R67sNjkhXAqCivyDBsAW7V0l0L2UDBJxA==
X-Gm-Gg: AR+sD13pP2SNDDYO/I2upg2+e9/LkOSCejGq45jQVeveS0MOBk427l0vCK09gRsIgbF
	AFvRThaHxQczX6q37hWOFxZDFBfDOU3DEZ+AwKYr+KnLdemmwkxn1zQ6HD4B1iaImg2reaQfgrT
	4BGFEJMstlzQ1DqPgOfps9QwqIn8s3jBlm390x0Qz4HUbsh8m8G1FuxvF/aeQpqLFS0Pec1cWpt
	gjjXTmMGjgwvaVErwURHe5bKmW/9Cs8hvyOFhP5n9UYeMI2y46oYkkpE1fqW1ODXD2OzE9IK46g
	GeObzImXmx+KkmAdeqbBj87SMbdMlzRk7Ol+x1aKJG5sITOQSgRwpZB3IOcqpQN7fwCLUg10dtD
	hECHJROFDfSA=
X-Received: by 2002:a05:6123:161:b0:59b:396b:cea7 with SMTP id
 71dfb90a1353d-5c3877df378mr4440525e0c.9.1785822100407; Mon, 03 Aug 2026
 22:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709131904.596684-3-adhikari.resume@gmail.com> <20260721164027.637078-1-adhikari.resume@gmail.com>
In-Reply-To: <20260721164027.637078-1-adhikari.resume@gmail.com>
From: Ramesh Adhikari <adhikari.resume@gmail.com>
Date: Tue, 4 Aug 2026 11:11:29 +0530
X-Gm-Features: AUfX_mwfI0PujMCVMpuXqdjToL4iEJ74LCkACizhvZz_t7EWwXIGY2aXg00R9eA
Message-ID: <CAC-THR8O=g=566evNCA-fmiprLaCL2f15w3dEjz8MSgAG4cMRw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] badblocks: fix rounding bug and validate input range
To: colyli@fygo.io
Cc: axboe@kernel.dk, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens, Coly,

Gentle ping on this series. Patch 1/2 has Coly's Reviewed-by, and
both patches address:

- an RCU stall / kernel hang reachable via the nvdimm ioctl path
  (badblocks_check() looping with a non-advancing cursor)
- a 32-bit (arm/i386) build break from 64-bit division helpers,
  reported by the kernel test robot

Both are tagged Fixes: and Cc: stable, so happy to resend or rebase
if anything's needed on my end  just let me know.

Thanks,
Ramesh

On Tue, Jul 21, 2026 at 10:11=E2=80=AFPM Ramesh Adhikari
<adhikari.resume@gmail.com> wrote:
>
> Two related fixes to block/badblocks.c:
>
> Patch 1/2 fixes the actual reported bug: round_up()/round_down() don't
> modify their argument in place, they return the rounded value, and the
> callers in _badblocks_set()/_badblocks_clear()/badblocks_check() were
> discarding that return value. Depending on caller alignment this could
> leave sectors unrounded or, in the reported case, stall the CPU with a
> non-advancing cursor when reached via the nvdimm ioctl path. It also
> fixes a 32-bit build breakage reported by kernel test robot, since the
> old rounddown()/roundup() macros pull in 64-bit division helpers not
> linked on 32-bit builds. Unchanged since v6.
>
> Patch 2/2 hardens the same three functions against the input-range and
> shift edge cases the round_up/round_down fix exposed: s + sectors
> overflow, and rounding itself wrapping past ULLONG_MAX. Revised in v7
> per Coly's review of v6 =E2=80=94 see the changelog in that patch for det=
ails.
> The remaining open item, bounding bb->shift where it's populated from
> the on-disk MD superblock in drivers/md/md.c, is being sent separately
> since it's a different file and a different root cause (missing input
> validation, not a rounding bug).
>
> Ramesh Adhikari (2):
>   badblocks: fix in-place round_up/round_down usage bug
>   badblocks: validate sector range and shift before rounding
>
>  block/badblocks.c         | 40 ++++++++++++++++++++++++++++++++-------
>  include/linux/badblocks.h |  6 +++++-
>  2 files changed, 38 insertions(+), 8 deletions(-)
>
> --
> 2.43.0
>
