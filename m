Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731699;
	b=UsRkKjVd+WyF8PbLuH6x+yNSFtLpGHbSMq1EcbiENDRdne4NrssUUUp/DTeMwJaB9S5w
	 2dKCH8XDr2X3Isd7J1zard/Yriu6isQTPqsh69WZX0DkyUTa5jaTnsBDpeTCzmI3SCEAo
	 gDon0gsZyfGDn78RDG6bjK8aI/lijwTxazgyGqUgZpafoC7U6u9Rlz0o/qrrA7ABMV3ma
	 bK0Z7DicwnApuHAfBBbQAMPltZFTCkUEblndlOowZo+2zbYFvwL5STORi+uYsw7Sp4CnL
	 y+h31NEmJo0bp1jmGSJuQf4PaExheVjomUlCCETd1+7pVS5fflawSeW25Z4+fMG3tYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vGSWPVRPxP6ajcwPiQ6sdZfL0TLUXIf0aO/2OiD6KVc=;
	b=oKN6PPaVQ9sdEzkMQ8IZktbNnadEd/jLANtusAU2/9vKKyPazbkNsbheX1sXwsC4kn7Z
	 0a/atUavp1ScLXgSo4TO8fNtYf75uuv1yMUcv5NeXuBP6Xcyuh7QH0wwebjf70dizbn+V
	 p7Efo9l3x14h9ZMWvadvLKUH/3lppwN8Nynr9c9oFn4YIdxvnGy/D20KGLptdoKlG4vzX
	 752ijUeOteUUS1/QBqnTP/ChM7RoeuF460Ai8QTYqZO7lQA7WrfeTztfyyfCFboHN9tyf
	 W8dl8ydf55GzyAiNLpYAPz27//FzEgSRqOytbN+9qtl3bah2kOvS52Il97vleiN72zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ekdroZQw;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DCF606A319
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 05:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83DCF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ekdroZQw
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35f036b17easo282386eec.1
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792731697; x=1793336497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vGSWPVRPxP6ajcwPiQ6sdZfL0TLUXIf0aO/2OiD6KVc=;
        b=ekdroZQwFkiPENRkAfQ00zaPvtvBKfdjY97F5wA9e0DnZSRq0JuZCrAYfO67I9G9S0
         4/Ka4+P9QZTzXuqVafgx3IjUbmqLjef4GCgYFSJ2k3KO4soYF/zRRbjE/ppe5t3jEkgA
         BrA4kIhyGBkXXWE+wgB7+l773gYra00oSekvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792731697; x=1793336497;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGSWPVRPxP6ajcwPiQ6sdZfL0TLUXIf0aO/2OiD6KVc=;
        b=RgqWeuATaCSSYk0vaqUKAVSaNXIzlUTvC1rLiokRXyHFjRvVcUrm1iMeBkBa2W9UA8
         oj7U9QgDzd7aACKsudXVyrhJb+pmDgPokTFpdCCVQkj3KdNlvKX/8EotwpL27z0/yh4c
         tS/+1oki8vTq3cwxS2Ay0ABj0tmNhSOtzCp0wQy2XXgSl9teAnnbhFcmfh51fU61LZCk
         YUMmaa6VI0uZcpzVSXUpXJJmCglu0Nf8nlrGsS5jH9oV0FTczwDJDXXWj7WfKG2kWJ3t
         Zhd8qucyhvMzvvnzCsBUdDB/LVAQOZyLZfiMXfTDQHyUrFqm46bo6U9E5aD49t5EjQOu
         CqAQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8I+34DN0JUT3m2UozGlWDd7bUyzBwBo7wle6avtACcj7qjAdMQ4Ix9wtGkYtI0Yx6S3R0bFI5yFXUGA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJyehEZNB1rl7T+xP8ilxAxtZevsJaJE1UClSfYhny0nj42Y2pp
	T85wDQ3yatYNqRPrJZuG/TCNbB4KlCvlV9RwbFLMN3ix5g/RHriRD/HcoZCkyqSayA==
X-Gm-Gg: AYBFou1Ts2SnN8AKIjwFL3gGQqEbETcdWl4DBieIAqo161MaVTAZnpMl0j7738r+E3U
	v3GSK8KKSok36BWTPlvnE275NgQR7GcpxMZ0onQjopXOGSXdLQGmqLZoEvPuDYoHTZVnjo8J5zW
	yNy4SVhuGT1bom5dLrM9wR4G7wxIXfjYlg64z3SHza/5Cv+Pbj1qsG+FgEcF2eeYfVBBxWS39qR
	RX3zvKpDVUFr2bfX8qzvvUzG+Xjr86/gI2D6lldAQkj3EBvg4wiGfkY2gIifaYrov46LYLdoLPa
	KKLrk/TBv7psCb8ldRXzcWnCVJQ3dZ5nuVU4pHsJ2ndE2C6WjzHLVjcEWUQKT2foV+zveTOCftZ
	v6fLiKN+3N5hic29j7hzyOygwGm1W9fcivGvgtj8wkLfNDlu+flwyAuUW5muCA9YL3j4dxA1k1F
	xuM0UQJ2Asy8tRvysL9jWksoIWalFcKsnS1k7QLwpVLsPqV7dVSXQMkD6fjXa2Kh7VsPSCcBPb8
	Jikfq6W579+cP1iszPHWzB6u2ttjsaRUvCjtwIQnU8M8ZQ9a+n+0ZaQNHyFQGrxpibhGPW/pQSr
	K/FD4y5bQmOr2zTR5sKhxQ==
X-Received: by 2002:a05:701b:2309:b0:190:b2de:1549 with SMTP id a92af1059eb24-195bfcb294cmr2047930c88.1.1792731697413;
        Thu, 22 Oct 2026 22:01:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:30e6:10e1:f7d3:a06d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195ec82eabfsm5512711c88.19.2026.10.22.22.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:01:36 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:01:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Barry Song <21cnbao@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brian Geffon <bgeffon@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Message-ID: <atrnvuQkeldgPqH5@google.com>
References: <CAGsJ_4wMQteCGxQ7wxUKP2g96myo91ipF_zedFVVbxKdDrb=bA@mail.gmail.com>
 <20261022111151.960-1-hdanton@sina.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022111151.960-1-hdanton@sina.com>

On (26/10/22 19:11), Hillf Danton wrote:
[..]
> What I am confused is -- why decompression needs to run faster without boosting
> compression up. Where is the compressed material?

In a typical embedded device (e.g. android) zram write is swap-out
(direct, indirect kswapd, or backgroud service swapping out idle apps),
users don't see those.  zram read, on the contrary, is what users
see - because that's swap-in, read bursts when user brings back idle
app (camera app, etc.) which needs to get back to foregound quickly.
So, the read path is more important.

I tested the series against PE.

readers vs readers (no writers) 3 runs

    BASE+PE     IOPS 1,449k  avg 3.48us  sd 155.6us  p99.99 26.8us  max 280,820us
                IOPS 1,435k  avg 3.69us  sd 322.9us  p99.99 24.2us  max 540,512us
                IOPS 1,459k  avg 3.46us  sd  92.8us  p99.99 25.5us  max 172,186us
    PATCHED+PE  IOPS 1,457k  avg 3.31us  sd  15.9us  p99.99 25.5us  max   7,580us
                IOPS 1,475k  avg 3.28us  sd  14.6us  p99.99 24.5us  max   7,327us
                IOPS 1,463k  avg 3.32us  sd  17.2us  p99.99 28.5us  max   6,816us

R/W stream split makes sense for reasons that we already mentioned.
Readers don't need to be blocked on Writers - they don't compete for
the same data.  And, moreover, readers don't need to be serialized at
all for stateful decompression.

writers vs readers 3 runs

    BASE+PE     IOPS 1,271k  avg 5.57us  sd 1,393us  p99.99 27.5us  max 1,581,800us
                IOPS 1,461k  avg 3.43us  sd    78us  p99.99 23.9us  max   227,015us
                IOPS 1,444k  avg 3.48us  sd   222us  p99.99 23.9us  max   592,628us
    PATCHED+PE  IOPS 1,457k  avg 3.32us  sd    18us  p99.99 27.5us  max     5,620us
                IOPS 1,464k  avg 3.31us  sd    17us  p99.99 24.2us  max     5,621us
                IOPS 1,475k  avg 3.29us  sd    16us  p99.99 26.5us  max     5,620us

And, in addition, R/W streams split saves per-CPU memory.
