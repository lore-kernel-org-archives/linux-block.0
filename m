Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859461DE894
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257412; cv=pass; b=H6SZfHSqltZFVHH9l6gS5QhxsXq6+1y0zTsBfeObJCeieIQxNaOfGrv9cng7AbA391FpsGFgaYNOVh6xRb8uCLfoOILFFvQ3B6yYhQw2yrRyQoz25ZiqR1Okq2AxKcerU7w377CeE6U0D/GfHPPmJ+fG36WndDM+bAw+XxwPLBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257412; c=relaxed/simple;
	bh=ZP4vSTi237WM7Shkp/cJXygtdRvJMxuMDi0qZjIwYCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3CboVJFcRG7P/McTjGJxVBWgmEzmi3sdKNHrSyzstCzs5i9Q3rwtnChAhBe8cBZQHTMuzebP6CdMQQ/sbq9+fUyCPAiCokwe1yNBBTlhJlj20qKqQXE5GBHtx42aNLXQl6qTuaVxQKBanzD0O7G/7f7LRLbdhUCOUW8E0D6A0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5iWKqd9; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5iWKqd9"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a5800772f3so53802246d6.2
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 05:50:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776257410; cv=none;
        d=google.com; s=arc-20240605;
        b=KoYs2rS/NaJ941QsFsBE+WSALwPdFh4ZjNyo4HRtqxa4SZu8g435DeHRtz3RQsCPX0
         CNU/NzPWP4Fvq9A9RJvDvfoJ/r/ypXQzD9clIP4xRCAP/Qe4IcVLnDpsqFRB/C80yOjZ
         hux1EiEX8wnnnmxvBIRv3ua0JDs3AvS5o9N0k7FcnldZLHRbj0ai3vksvSsMFCSVKciv
         r7qSOAjrWx0yXfXRQidyMmBOeVpc/Iejf3cG0yxYecfW53o8QCzhJKo6YsNpoBOVFARk
         cBec+KU/bS3Tpqd17uz9G2kFVIcPwMKf3S0xwBGs1wHejaQHtuX7q80FF7FzVkTa9kV4
         l+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D4tWC3t3xANgqGsaOz03y9MNl8MWkuRMcvKOFAlOirc=;
        fh=uEq2rD8sHYdPdwz+Qdk2yEb/c3MZjstBiFp3Um9BtCI=;
        b=Lt9/xZ1VWdN5HE6O2h9ZEBZw/iP28+//iDwfpWaxONhHIfp0jh2DBKgRr5QiR6l5M3
         ESEP99fALEfvQSMQANa19F5gespUeQDmMmphrzE5yV0kUeH3Sl4znGYxBB+sgMwYQyJ/
         ftPNv2evkHWZvDZ/rcJBz3/xdUi5C+AZPE09O8zkhlVHHQXbWZvJYscAlrfogRsi9nGy
         k79AzKm3JNjFpPz6zKIMtLJooUTtI3alDRT9WUZ3Yime47F5Wb0uwbsdbOfCxm9cr6YO
         vnj/onixWS+1/+1cFB6k6NIPs3qlTfbBKtGGjdquRUq3rxXf9/jKGOlqGNWRpkn5x9wx
         Ao3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776257410; x=1776862210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4tWC3t3xANgqGsaOz03y9MNl8MWkuRMcvKOFAlOirc=;
        b=U5iWKqd9C7K17mIJA9DrwIPET8xAgSIjI2Dt80xmicSUiKIzaYpxe+gAPBNblAuSWZ
         DfS+CTLbbUiRFEe/2OIJCdvbn6JwJnQ7g6nGwaiMzvYG92hq04dXUiQCOK0Eoykb2HLd
         +Lf49ORPa7Evp4kGLefWinL34LJAzskx2Z6snitX1Rv6AVyFHdge0ezE9QLgSPx9zXod
         FVeuIF7O8omcL+i2V4/a4lCBxO602uRsOUg5W+g+9Qi7EjUTXQTmpBqrC7Sqpf72WvLE
         bqo3c0owFzf9VVKtgZOxhriAdcbn/sj3rIAfY1XpB/TmMXUbfvX+qQp5Kw3NsVVjO3x2
         HWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776257410; x=1776862210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4tWC3t3xANgqGsaOz03y9MNl8MWkuRMcvKOFAlOirc=;
        b=CzBmGpZ551udL/Oif49WLSAZVBoOFQsHbRrCNy+1DQhQuBmZ7bBZyD7DAy7PXv8Qf8
         z3jXbepshyDHJc5pjYq7HZRF3gw4ljAkbO4YajQfy+PHEiHNm8kXmXlkR23QLT/MQuW3
         GFCbW0tcSxsC3naI5TFsjcoMnvUmny9PQwcZuO8LDdV3tLvVUujLsTD5ULViLDzBv4+k
         O6G/IykU00iPIm/zJsmn5Fmb3bKOT61/qJlrQo3Q2NCt8PC9cW190n+ZBhAGMD097Vuv
         vwmB6GJyI0Dh5NAJ1CBsEjmEbRkTFr9prizyIDaJb4xre29SHtK/deovqvSfs4rKKlnw
         GSow==
X-Forwarded-Encrypted: i=1; AFNElJ+WoN5nUu0y/UqS69ukErmivOjGl0qJfrXrz5osSps0kOQQPcYZarkkU0zrryxcamiG18/jY5XaoxkzDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx419rhbCHCMpibwXa2GKH6Ar/LFsi5J1mitMK+GGhP10ZAfRUS
	+8Ap6h7eLGNSM0YT56AltyPCMmdRwyBqCpDfTUj/9xFPwQZ4+movkXUkgVv/XkLTGgmPPb5zqxm
	tas6qkyv/6fhYISjY3SqnoIT/uPzFKq4leZOvJRbc
X-Gm-Gg: AeBDiet3cBaMhEmy+zMvfOVrylr0Fndl0IM0hylhx1dVhpEo4wUgq5hZnrxnyRTS4Cm
	sq09k0C8FnoTp69Lv+YgwkMG72AQdectDW+3QW8pju3+QGJv20/qTKcO+SOB2N7cbV+j+L++e8W
	TmtaKA4ue4qIBJ6MhVEwHhHt7bDQH8M0KCKgt54lzH8hLsVG3uai7lew08vWrIfSdPJ4s1Q6LaV
	pcQ31tBxmGxaR2YQ+eJ5iXOvQsPkuOwHv7DRT7FZ13EPaAcWo/EyIQrwkjLkaYIXqwqY0t0Mp9Y
	oVUoAT8RTZshq86ktPElOEmmxnSs
X-Received: by 2002:a0c:f40e:0:b0:89c:ede4:ea35 with SMTP id
 6a1803df08f44-8ac8613e90bmr340193926d6.24.1776257409637; Wed, 15 Apr 2026
 05:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409160243.1008358-1-hch@lst.de> <20260409160243.1008358-9-hch@lst.de>
 <adl1iqhldFvJwSw-@dread> <7f0d072b-97a7-405f-bff5-d3819de2e3dd@linux.alibaba.com>
 <ad2RKNo2FGhpzJQp@dread> <a7a74185-df02-4906-a0ec-f87e2394aa5f@linux.alibaba.com>
In-Reply-To: <a7a74185-df02-4906-a0ec-f87e2394aa5f@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Wed, 15 Apr 2026 05:49:58 -0700
X-Gm-Features: AQROBzBdnyNeg6M7eBa34eLrstKbL-D014vWbc0uebEOU17jGRgdz997IpSMUAE
Message-ID: <CAB=BE-SObq4hSO9s36H06eVtZzyj5OBPKJSOOYGJDDD38URN8w@mail.gmail.com>
Subject: Re: [PATCH 8/8] RFC: use a TASK_FIFO kthread for read completion support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Dave Chinner <dgc@kernel.org>, Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>, 
	Jens Axboe <axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> Basically what we want is to get a non-atomic context instead of
> using the current softirq context for read post-processing and
> switch to the task context immediately as you said, because:
>
>   - Our post-processing needs to work in task contexts since
>     advanced features like compression deduplication need it;
>
>   - Even regardless of our specific requirement needing task
>     contexts, using a dedicated task context for read
>     post-processing is much better than run in the original
>     softirq context:
>
>     - Algorithmic work could take extra time (especially slow
>       LZMA algorithm could take milliseconds on low devices
>       (however, we need a common workflow for all algorithms,
>       including fast algorithms like lz4) and verify work for
>       example); and long processing time will interfere with
>       other remaining softirq tasks like sound-playback
>       / network softirqs;
>
>     - If it is then deferred to softirqd, it just makes this
>       latency issue _worse_.

Yes, this was the reasoning when I narrowed it down to per-CPU
kthread approach. Patch has helped reduce app launch times which
has a direct user impact.

>
> But anyway, I think nice -19 can be evaluated if Sandeep have time,
> but such nice value should be set by the filesystem instead of
> the userspace since the reason is as above.
>

I will find some time to re-do this again, including setting nice -19.

-Sandeep.
