Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516370;
	b=tmZfcWz68hyl/FzNr22qUwNY95Ucw4pqNYHMRDx+9xIyR09YAlafhObxhtDNkhuHqpbv
	 Hx909PnNUWPvCWtXz1PjrUl/wWAiJNdYSM0VuQCZmINVMFxSQBTsa4bjagqOEEV/igJPy
	 uqJFtDspRcLdk/syQHJ5caTVgWPJORfV945ce2DWZWa9CVXQ/UHMv1ssarOBLk6CdOwOY
	 IpbUIcp4vKAGfcRaBhhl/IRY26y4bfIAPHTiSN4FPGos+cVJtzIklzSr9ugZOvF1PM9+H
	 CY/COJIf4RtHnkDD7dOkwfxbMITEn7j+VCAJeIj3Afned64Bf9ZRufAVpw9kCWEHJlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=fhqQPB4XMnfyiI2uq0u1TLnRiFnbRNlZrECWOidHles=;
	b=iKKyfU6oJuO/GOX7YkftN8q0GsX47vE8hAyrNmWTtPi3zhILpGrIqosqL8EJSdD2bHfd
	 YyhdPCIvRWOmSNSFNxI8hYrQqfzKMXrnfkQtkgPyJfdJFDwsd8ENR+Q+ZkI1o3G7HIQkl
	 Yp4LTGOa81Jba9NVwSTA4bOOp16pi46ch7HOBnLCISRks31gZYCKGo8CQrrqAmHW61QQ6
	 pHglk2ZuQVVs8DX0Iw/W5Z0zviEO9cJbWlUg7iP474VNkR3/0cRyqf2ibUqGx6O3DwX73
	 kqLirj/Gbvt37Dw6Y2H/sWgseHwB7Ut2DoTKJJcbBzNQH+XMQbShhqUvDaG+6ARnPyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=CYVeJVEJ;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455960A260F
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 17:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4455960A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=CYVeJVEJ
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35ef6b49813so6371692eec.0
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792516368; x=1793121168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhqQPB4XMnfyiI2uq0u1TLnRiFnbRNlZrECWOidHles=;
        b=CYVeJVEJ1KM+wdsacNjapsabYjwSWLhrAOboaZh1EUNsCdZm4ANjhiP8hRfRgf5wTF
         N+CFAOmyiu2cF1qIfxLLwrZ30eyjlyVhX54fAoyZe8ss+yD2y40evJEYW/u6gV9bLndQ
         eGVDc6dnrRDjlgTdywWaMn9lqkzQ3lg8ILHErGTFLTaD30EpbJfjX0IZXj8YM/q98LXA
         HlQP5EN7wyiIwWgJqUAhykBSm+ZfsjLsuLTrQwi35q4duwu1vT0zO7aRbHQGXEJA2ect
         mSRjIKmRetP6lOtY20H9QtB/5Ip2Le7xOFY/ca48RWTLr+6YQL5jQd8BlJ3kbyw9tOUE
         Tleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792516368; x=1793121168;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fhqQPB4XMnfyiI2uq0u1TLnRiFnbRNlZrECWOidHles=;
        b=e3UqS2gjcS5Ga/tuZDtkV3klB9bJh3pS3Ty6bNxYFrolKk4j4UxyLYTga+qqPWnLxr
         29ur90D3YpNnzAVvpZLIp7iriv57qx/dKUspq3FHsq8g7gMOhOfx20/W1zr/h9lc0Src
         ExxLr+VfyIHFCL+5i1GyxBcGUFwkPnBwg4VTFTGs7S9Ke4LwS/kjjrxKOs63KNQ5R2He
         UJRKN5+nugl+YTWGRjNAr6qChqbnjkCJ/fr3P+wyXndSY8uLLyEyFHfnB5kCizLG72SF
         5XozpReKtd29HAoaZLo5xw2A8BqVvYaIU2gUOvNncglpeXKCSkUYzLvYF/7BDVPCokb3
         NIXg==
X-Forwarded-Encrypted: i=1; AKwUvBxwlCKl4haRGjwVNDomsKsIHr5u1lQiD8gQHQwg10A1eDJmdzyDp8HFO/s9LvN1sP45b0Gj1jcdbonCIQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLdxnf9QAue2zZYqalxcCDUT/UKl6UPiBdebqQP0VskvuaYUKII
	y71JYwEoqslFXyXiGUmOQS3SSh4t73I3EPIcev3GtJt7fAnAjynn8KbivEyBmd9i0LI=
X-Gm-Gg: AYBFou2dLfnB4FKb22SWkU9kiFA8Uidy7I4a/EOXg9T0vEJQM5bAvPCjUf0ZAYbT5yL
	aUchJfyCB8Inwo7rl5xQFJZ0cp9BlANcLj6VvFF88hjf7ZOSScp4hnKI10ejE9C4/BcWoGJSuU7
	PmsQdRv7Mx2ghycZ9ASz6PWE5lznvEMpJjSL1riVJjsOp0t3JqzLSzdibjWJnfIYobYrAqMOu7q
	5+T8z3brZn9LOnt/aGZAExVomZoYGFRDw0p9UY51Ie42+A8425/rJ57GfswmUHiQX8j5DSaA6hM
	OMHbsoUGF0WvspKVYyjbPusw5tVWO04GF+GlVnUdkTXD4vGwPiJ+/STuMqipr8ijV9098aXTs1o
	p8AiwIhRIa1tY2316nZlsRR7RzroubjRQufChjP6w7X65wiQEizinWIgvvsd0/RLc4Iy/o99ktj
	W9agCZts9aVi5Jpt+PCov6pttI9TCLohzOaMYHmPgEWg1iKGYIyQr2dYvLucIj96qzuJAK1MaKR
	CZq6Ax2cY+snNsO4ws1b1TkUQuZ6LRmswf1Bmloru65xcoV0nGECXHdPQdSvkI7xwhGC/g6d0w=
X-Received: by 2002:a05:7301:430c:b0:358:8f02:e0ca with SMTP id 5a478bee46e88-361a1668b25mr15610910eec.9.1792516368276;
        Tue, 20 Oct 2026 10:12:48 -0700 (PDT)
Received: from xps16.local ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ec6c3sm30711eec.7.2026.10.20.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:12:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: viro@zeniv.linux.org.uk, tz2294@columbia.edu, stable@vger.kernel.org, 
 l1za0.sec@gmail.com, kbusch@kernel.org, hch@lst.de, hare@kernel.org, 
 4ncienth@gmail.com, linux-block@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20261020170250.014BD1F000C9@smtp.kernel.org>
References: <20261020170250.014BD1F000C9@smtp.kernel.org>
Subject: Re: [patch 1/1] block: restore the iterator when rejecting a
 misaligned bio
Message-Id: <179251636729.3425887.10424065373314430369.b4-ty@b4>
Date: Tue, 20 Oct 2026 11:12:47 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 20 Oct 2026 10:02:19 -0700, Andrew Morton wrote:
> bio_iov_iter_get_pages() can extract some iovecs before encountering a
> misaligned one.  It releases the pages and rejects the entire bio, but
> leaves the supplied iterator advanced.
> 
> An iomap direct-I/O caller may subsequently reexpand the iterator's
> byte count and fall back to buffered I/O.  The reexpanded count then
> includes bytes before the iterator's current segment, potentially
> causing iterate_iovec() to read beyond the imported iovec array.
> 
> [...]

Applied, thanks!

[1/1] block: restore the iterator when rejecting a misaligned bio
      commit: 40d070cbb1906896d6fd65c39722d2411830ed9f

Best regards,
-- 
Jens Axboe



