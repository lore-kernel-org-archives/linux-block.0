Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B425C81F
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333298; cv=none; b=ohVfavhckdFTzT9qW/vJenuk6PhzttTO3NPdDTTcbSlG2aCMaUTHORIPXOhBJvT4K024VwLtdUTwAlWAakUlpF51/dEHgaEDwuTKdOvs25suXnwNCiZXXrMc7IlJ/U9ohsETiFDauu7YV3SBnSbZDGvklC6+lV/d3ki8zeC3f2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333298; c=relaxed/simple;
	bh=MGqBHlfRDrVxcmk2EPImRTpJPJYE+2rYOX+WqRjNrPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0SqvT4y0GgLmR2574cbAUE1oBQZMawPsqxFbtttSDLifTr0BU5C9W7nbFCutkQ/zS5eA1/Rm/2snrXVaBKtM0/vbpVZdSLo6fI+9mJ5ufRymvmbfeB0r2EnP5yF8lvW+hLk5EvhZKcAQz+iyL4XVr6OZfbyGfbMvoRvWmVrCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1ZxBFOKX; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1ZxBFOKX"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-867355d9c4eso31930039f.0
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747333296; x=1747938096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/C1KpHBgALZXKW/azerT8WsdA1SRCuWfyvYCdkhgTU=;
        b=1ZxBFOKX4hcx/gLOJaeDXHAS1+i/jqrm6TstatELC7s8FtQu+1mNb96nv99HRvBKVR
         2APHyWM/US4Cpo4FGgcu4unFaP9SKZ4blORzwrNeGZ/9yHkVHBrMlH7AgHXlRSJiRoRn
         kYlH4nbud76AFE9Fb4MBgY4KxkUCjyiKoKoX5/Q5bKlnFTM9uvOH4UQZFc0/P2fk+NIn
         vJx78UPUZKkhjgTxcDvZuNzCq2HEBsNp/YNZfDF8j6TZmglvFtrYCOWB5IFLRxqICNRu
         FLairlM4qQUc35V4jWbMgBC95haNdT694vNWSCVaLZkbe2g9gDfcY+bl9y7jhKa27Xll
         l8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333296; x=1747938096;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/C1KpHBgALZXKW/azerT8WsdA1SRCuWfyvYCdkhgTU=;
        b=Laf7V4ffcAZejhszdzWK6LnpUgyOw7dz9FNAMFHo4q/DvRym17/BiP3s8oCO/bx3Av
         NwZeD6ot3z9469c5N2K1L3gkdJ4uNnUsOSEwCSr9jGklLGfSW7NS+6gHqj4XjRJp41mu
         eEZIAPwxCG8GfM1K/gpu6WtiABZ0OAKQhbjzhRqdhAX5YCa0lyX/giZ8lascMS6Yjqt5
         tMpbvBDMe9M/uopUgUPh/uHhGce18Jspf2sB0rjj0iXYdRak3DojDFYp5jn5UfObBgKg
         CSNhiODZ2XwjWpmzh/B+tykt3d/xRaQelFEKswnPmvqQqR4z3zsR8wAhGSbHEEvwl//n
         BSrg==
X-Forwarded-Encrypted: i=1; AJvYcCVj0ljdvEx97Hvz46e4Z0zJ6tutRYkjMGMceVC0aTvL0borzvK+SitqOt0++7kwCe/vLcwTqGFFZCSyfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdT1DFy32BrZjfQ9Od1ndRWNZRf9z6nqxeYZ8Tpr2FNl89xeU
	Ro+MLBDYF94w4OIEs1YuNbvY5QrLXlr7KikiVqv93oRec0fruc/2chUtbf3k0WDaWm0WSGWoIwX
	V0u91
X-Gm-Gg: ASbGncs5p5KvZsPItLqMK0xxcvUye6x00lLFZiz9h+ArDsvz6MZGR8VsrbxKMSEkuOl
	nBn5jcJcRH1Wyy4KkcXw5Illt69k/yWWtGcN2juoj4YQyYJ/G85XojttnUWHGS79/w6UDkJW3Gs
	5LzYuf4yP92r96WQk5EanWmTwPYK19mKYtsijpzc2+TuEVUpZcq1BUxq7orQNK/4rP8dosJiPBY
	iPNMiIHC97GJnqcPFChG9ry8DiNtew1gmJh1OG6FaVzzwt55iDQtK4eXqJ7MQu1ldRZC6q8gELO
	q+svC9z0U4vPAwiBx1zgu3q9kquKWHBbkrE52kqUpGv/t30=
X-Google-Smtp-Source: AGHT+IFpzCE8hu6atEYHjd6yneH4PqaIpUSAler+yg/h5WtSeiuEURnFGnyHBShaB+rR65b4K+RX6w==
X-Received: by 2002:a05:6602:4816:b0:86a:93b:32bd with SMTP id ca18e2360f4ac-86a23172932mr113585439f.2.1747333295734;
        Thu, 15 May 2025 11:21:35 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4af62dsm30041173.109.2025.05.15.11.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:21:35 -0700 (PDT)
Message-ID: <543ef493-a478-4e92-b384-f6ff299b11fb@kernel.dk>
Date: Thu, 15 May 2025 12:21:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] blktrace: use rbuf->stats.full as a drop indicator
 in relayfs
To: Jason Xing <kerneljasonxing@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
 Yushan Zhou <katrinzhou@tencent.com>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-4-kerneljasonxing@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250515061643.31472-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 12:16 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Replace internal subbuf_start in blktrace with the default policy
> in relayfs.
> 
> Remove dropped field from struct blktrace. Correspondingly, call the
> common helper in relay. Through incrementing full_count to keep track
> of how many times we encountered a full buffer issue, it aids the user
> space app in telling how many lost events appear.

Forgot, I'd rewrite this, "telling how many lost events appear" doesn't
make any sense at all, as these events obviously don't appears in the
first place.

By incrementing full_count to keep track of how many times we
encountered a full buffer issue, user space will know how many events
were lost.

-- 
Jens Axboe
