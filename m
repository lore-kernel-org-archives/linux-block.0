Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897475;
	b=TjLMCQzYiXd8gQyaQXPP8bIeW97tny7yGjEsW8vWdKnnvXUU17pHVF10ZyuCKaZIrMBk
	 MMHicJ8lREkqqbYZ/mgEXE6YsDbVptxmE5la5zZlCQexBFj/8+myjIre9OWHguiVBYwQW
	 89USHqgRTQc1RrSw8WVv2owFEsip5D2uKK1rc9FYbR4WzsAAlL5IztzJ28AbScEHsXQKQ
	 tA8oJldmRDaDlJplzZJxiR3AeI4xm6tw0Z+a1REnlKA66J+dJnSLIfiCyOqkVk+JsnhQz
	 MMquFJPJQMXsdtyIHpmGQjXemZXtEzim8AwmoJZGi8xFONSQE0056F1WU3nR7vXQfPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=y1r6eP3MZcz5E3klo5Of29Yq/gpHVF8H+eq3WvDPbMs=;
	b=zjTlqCSnXUobDLSJskJ0w4fNMJgf0cVCI8zJYD1dov3Ou5Js08v5Ema9oLJtZoPq8KxW
	 /chqlBmPW6xV83/6003RkIlFznORYTxk6QCIH+sOQW//y3hOaoG6KIYz8CyeKkwWuFs7X
	 tv1imu0yYuUywrh/5SswonpJl686MQoYICOGjHOCS2E1nu8pu5NqA+lcdoppbm5qOpQeM
	 jEPqfMRzeeYziv9ql7MObjr4SwyOF2ZYos1AYRz1wT8KaRBRFEBtmwNaNkPlZ16nLn1tx
	 6Ilr3fPL9mfB6g3Lnq6p/OKylaumoSSYektB0xjLTqmrkVdOZmgPiAIr0HYDTPqZFMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9lNmgk2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847AF606A31B
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 16:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 847AF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9lNmgk2
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4910b863b84so644306f8f.0
        for <linux-block@vger.kernel.org>; Thu, 05 Nov 2026 08:51:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897474; cv=none;
        d=google.com; s=arc-20260327;
        b=k9Xpa0+uZlvLg2Ag0QlQ5VByqMCgVY0ydws7QtbReq6offVTe9LBQeiOdtVswnPFBo
         ifcGzFIbUCT257xi7OG7NSlauqOcfyoHXiPHi+QNqnwIcgFlJaBb+fIXnBRmMgH99zh1
         vDjTz1taN/R+pL8r6bHFoS6szoyqiSC1w2CP4l3zV4A1PatzCMGcIOmz8u37y0O/Pask
         qqI9F0thWSPpmLAA8PdkIEAQHLw0OoNkCkfqliHgbaOmFZ1xyh6LIEQGIit/2m4kUPRF
         ZoWyiUO4PA9v9WsL7o+W5jE+sS769v9gUPrlBWmlFrSQ1lLLwT+Ka8kxuj0/+r2S9kMk
         oQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=y1r6eP3MZcz5E3klo5Of29Yq/gpHVF8H+eq3WvDPbMs=;
        fh=dXQ2onQ24IU+7ukj4ON5CFc+eSoQDs4LV8LRCCJSAsM=;
        b=Cdc2THCcLd5PllpeHQifY7xPllgdUajUOyjrSl4jaNCP5pJz1zpYW/cR2ce2tE8dV/
         0DsprJ5vmHtcdm2S/S7SLV49s8D8Azl+xgEoukJTEPzv7n7zgsRaIPlzW+YQvjcfYYxm
         F7hrS202ce4EzNGo6fZwb8o4ZIg7sUtOKftL9bRbrr21HlNgNRa/6HTa5poIhE0a5LcD
         4VV9oi3W6fAcgRa2N2EVbt7Ae4bOA7eE4VXP2kkWBSXm9FUqEb9jDRF2tRem7t4u9z0d
         Bm0MuK7rOI9NbmHI67e7IDJ3v8IOxrRNwSklzyXmfXAKKRiXsfRmHFDBfNyp5LM2puzW
         9WAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897474; x=1794502274; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y1r6eP3MZcz5E3klo5Of29Yq/gpHVF8H+eq3WvDPbMs=;
        b=k9lNmgk2mlglkMu01nb/rHiPuzAhhpHBCToJt4Q141nPL9BHNDN9QEl2JPY93lwQhY
         cpx8NVrZgpOyEsHpOzwiEthnSQnK09GnFWO87egW+cWGHK1gHCXjQQhthO/J1KpsK3BI
         shzCgQVcF0QKX0GG/oB8OHefPPVNu5GXCsgotoMh1opf1HuSSxPh6E6NuZmAbJW1rHKn
         eZAdowannYioCP55sWJ6iWpiNdDItFNQAqHMo9WP5rwWmBx42h53PwNwM1CKHfN4Em1n
         /VYWFhR4uERiVivbwVyumm/fVHEuXIBqO69S4iJPyiG7XrElQUstslDyAyeKwe3nEfPt
         B84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897474; x=1794502274;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y1r6eP3MZcz5E3klo5Of29Yq/gpHVF8H+eq3WvDPbMs=;
        b=ows9I6leuKCUUsBcgWdq3U9JDp7jeoj8DtvJgDuBz/tf6z2TzR/zFnwIgU+3UHjQZs
         gSXg4zo/rGfZwFkzYTm4jH9wHMHfwcpk+YSNCnTpJntlzWHq4R0bO6N2HQI/Mw2gmH+U
         qs7j0dCXXStiidjgLWRKh8z/n7DegZeTWPSj+dJvaAmFm2pLE1n0jojJQO2D5iKZ8weI
         UUwaY2gGNiUjtEScVPQ3d0xzLI31rP/8z3MokWaba95bXAygsjDhuoLnAKmBJFXaLMVV
         a68dP8Qx3W7LDtf3C+moWM0jPjy3JJ37uIgv3CvLfr036y02q4vZYEUzyQuex3+NoCWK
         eTAw==
X-Gm-Message-State: APuU4Z+wprWi518LRh3Ap+0Te7Sr2RIalQDaDrPSyxLBuSthtl5Aihl/
	sMm9h5Z4kqtv/egEhbPsr5NcRVkeqVFnFndf+Nx8/yOLOwDr4pQMujUyeepzuyE5KYtiE+ko/k3
	KmP6O4hZp4LDZSerltC2pW3Rj2z67AtnLPi0mdrRwKBQFIrE=
X-Gm-Gg: AYBFou0XSXWm0zksFDmN4auACXqM9Va4AHF8HfMza6uKax72L4t1Po0EWvwAnmLslu7
	W2Js4K3N+90ofWRGCgm2chWt3O7LkbrIA7UacWyRTOe9qsGUJA00M/dCsP2oYgLBTTHTdk2/BHS
	m+U2aVVikiNCrabUm1Gpyd3n5MNhEHxuQmIOs5P+5UWKOHHnw3aBqs1UMQN2AMy82DWs4M9154x
	1q/OsvkUuBTRwmZENqb367IECww79nWVIjD4caX5P+RxBAjUkwJVbIrzJ4eU5Oeis++YQwceek/
	VLxUDg9x5fwxtqFyHAyXUv60PANq1m7KTS6BrlWNpewTcrHSVeNseFtfrZRJ3TGZGUJ+qO6NvDF
	85tOhqeVrbhEhl0G18LTNmHtyiMUsYA9jDu8=
X-Received: by 2002:a05:6000:26c5:b0:48c:585b:8825 with SMTP id
 ffacd0b85a97d-492792c4957mr306092f8f.18.1793897473783; Thu, 05 Nov 2026
 08:51:13 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Manoj <manojkumar148700@gmail.com>
Date: Thu, 5 Nov 2026 22:21:03 +0530
X-Gm-Features: AclHuK9XT25eDPcpJr3ifOV-JoKWOgSfmM7b9vtq7R6WV-XkdXSOkIobpT9k-vc
Message-ID: <CAOVdN54PFMXo745xZYTx8kEa+ECpxbup5VoLVu1oSD9fvsVZ_w@mail.gmail.com>
Subject: [Question] blk-wbt: LAT_UNKNOWN_WRITES with concurrent reads and
 sparse writes
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"

Hello,

My name is Manoj, and I am a computer science student. I have been
spending some time studying the Linux block layer, particularly
writeback throttling in block/blk-wbt.c. This is my first time
reaching out to the linux-block mailing list, so please excuse me if I
have misunderstood anything or missed some relevant background.

I started looking at the interaction between sparse writes and
concurrent reads in the WBT latency classification logic. From reading
the code, my understanding is that stat_sample_valid() requires a
minimum number of write completion samples. When that requirement is
not met, the window can be classified as LAT_UNKNOWN_WRITES. In
wb_timer_fn(), that classification leads to scale_up(), which
increases the write queue depth. I noticed that this path can be taken
even when read completions are present.

I wanted to understand the effect of that behaviour, so I made a small
experimental change in latency_exceeded(): when there were read
samples but insufficient write samples, I classified the window as
LAT_UNKNOWN rather than LAT_UNKNOWN_WRITES. The intention was to avoid
scaling up the write queue depth in those mixed read/sparse-write
windows. I kept the existing LAT_UNKNOWN_WRITES behaviour when neither
sufficient write samples nor read samples were available.

I built the modified kernel, booted it under QEMU/KVM, and checked the
WBT tracepoints to confirm that the classification changed as
expected. I then compared the unmodified kernel and the modified
version using five paired runs. Each run used six paced O_DIRECT
readers and one buffered writer issuing 4 KB writes, with an fsync
after each write. The writer slept for 80 ms between writes, the
readers were paced at approximately 1 ms, and each workload ran for 20
seconds. The test used QEMU/KVM with virtio-SCSI and a single queue.

The result was not what I expected. In all five pairs, the modified
version had higher reader P99 latency. The mean paired P99 increase
was approximately 1.76 ms. P50 latency and writer operation counts
were essentially flat. The sample size is small: the two-sided
sign-test p-value is 0.0625, so I do not consider this statistically
significant at the conventional 5% level. These results are also
limited to a virtualized test setup, not bare-metal hardware.

The trace data showed that the unmodified kernel generally scaled down
to step -3 during the reader workload, while the modified version
mostly remained at step 0. I initially suspected that the later
scale-up in the modified version caused a post-reader writeback burst,
but after examining the timeline I could not support that explanation:
the readers had finished before that later scale-up occurred. I have
not established the cause of the higher P99 latency, and I do not want
to draw a conclusion that the available data cannot support.

I am sharing this because the experiment made me question my initial
assumption that holding the write queue depth would be better whenever
reads are active. The existing behaviour performed better in this
particular test. I wondered whether these results or the test setup
might be useful as a data point, and whether someone could help me
understand the design reasoning.

Is LAT_UNKNOWN_WRITES intended to allow write queue depth to increase
when write samples are insufficient, even if read completions are
present, on the assumption that sparse writes do not need throttling?
Or is there another reason for this behaviour that I may be
overlooking?

I am not proposing this experimental change as a patch. I would simply
appreciate any clarification, pointers to earlier discussions, or
suggestions on what I should read to understand this part of WBT
better. If I have misunderstood the code or the intended behaviour, I
apologise, and I would be grateful to be corrected.

Thank you for your time.

Best regards,
Manoj
