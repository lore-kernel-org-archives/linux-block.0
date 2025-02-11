Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0F265610
	for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304293; cv=none; b=WhE1X5FmBa2cSSN9MEt6ymflgExYl6y/0+HoKFxd9MuZMiaorxBvlDe4XHHIY7sneG9U0XIYrA5QmssiXm2GM/3ehgv55E7ldHPTsE9Lw43na2Wj32mwKTh60KQTl4nMTE08+O61tABf6DnzuF6D+qvHLvDW37M0ma+X2JOcuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304293; c=relaxed/simple;
	bh=yQ5UQtPrJh6CDgDFQ5kOE10MbeESFXkLMTABKS+oBEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SrrEmJ5p1aEs2aCR8CPAw/0Rb38RFUtAjs5Q5IIo2lH9+/QfHc4moDptch+AOn5JLlH0l2ljnPXQCK4CrvKK9ylN1n900TU3PcOn013sce54eMrwOqoUpbwk7QsryOmxiz2CMRoNwRqj1LyLixSEVCT9Uuza/3H3UMwQkPOFlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0CUKWNxV; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0CUKWNxV"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d150512bd5so10822055ab.3
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739304291; x=1739909091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSafBjwhtkCgy84RqH/1n0KPcLrpwZEy3MZrJYm7NDg=;
        b=0CUKWNxVFt84yl6y1X6llOodW49UnhYhsA57+nG/nlt25WIUSbeT1gLfT4+eefnw2b
         8mOjWCZNrueD0DzrMj7l9FhdXrnFUDw2kixUU5iNInLG6XJHwnpiNaC1JDy/ZUL+Ffit
         RXBOubEiLP1uAnJ3SL42OwWKYQasc8fexdPM8eNEPTVnkzN3qXuMPmUjhXB4Nbq1Ocgn
         5+6b9S+mPJvlUtJyeu95OJXXMHQRdB6XlPRLU+ZNtF0yxmpOa42OUELA5xMe9ZdnxUQs
         KoW8O5Afs7waEjRNghwVhagBTBNbYL/kSf32hgjKpVcv6JdDkKCi05nCz8ugbMe9T8vw
         0Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739304291; x=1739909091;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSafBjwhtkCgy84RqH/1n0KPcLrpwZEy3MZrJYm7NDg=;
        b=VSpIPH1RZgrgO7hNtqN34Whit0FD+EzEOKe0IRde7rv9WiVsMBa/qQu6sWka9ELRmd
         DqMuzVGAwbYoFidXhJDZGqSGQTgUgyEFKlXsM6CafUGXiq6g5hhVlFPAPIJ5EnWVUxj/
         fThbPPuRGL3GXMLTl+UkwORAg+5pEWur3IdzSaZmDWIbkDz5oDHvxc34WKeG6LDnEDs8
         vt4pS/BMK8v+RXo8IG+iG7+pRTMD8zjjxusCyS3sCHJcuIjhRgGLmSgObWcH5nYYaXOj
         nRLFu8gw1NMLCJz36tWbx6TwVA1qxXmwn7n7z7cuT1cNcTZn155OGpYqxukyGHuZyKhy
         2zVA==
X-Forwarded-Encrypted: i=1; AJvYcCUDtfOCNAFJkMUvfeZatNV78OfApjSKrDTtgtkIV7kb4UOjTUUUZS0ZI+5bG3BA+YXNJ7Tzm899WfoIQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rjG5+NwOxl7VLmAHUdFcpaXiJ3XeZ4wBZkSLXzwQXfp7yekx
	Q4KDvtlQETRT8Drj06KnK7nUpT7uzLUSQ8eb10O+LJTV1ngjt60pUzjQIKgLaeQ=
X-Gm-Gg: ASbGncsl9NuGSYmdQK+fHpXZEj2W2ycURse+OJxeGUxs2FlKhNrIBDz4kkqFJPI0QUF
	qjuGChdpf/v/ns6tbF+I0Hxs2Ja0xeePdi3Zra2D67YI1Q8YxZmYAQ/Ol/lUC1JqUyf2//HJoEd
	7M33uvg08qr7uEdWKho/iRc0c7XhpKOjeGgt+ZAoN42RJN7DpSNjnvvAFbDrL/c3zoDcgKQyGnM
	VLzQc3C6RZmssEymilSERw3gq1OQPRtWoBXZooqNzUlw8cRSFLu1bgHLf+bNRYtoX4+8e/+fXrE
	v7MIog==
X-Google-Smtp-Source: AGHT+IF6ngVv4H+7ay1KS5AYnsWGnxP6t6rI34lhHdXcsNGwsA/2PiydcVTWSg7Ie4NNEWNk4JvMNA==
X-Received: by 2002:a05:6e02:3184:b0:3d0:4eaa:e480 with SMTP id e9e14a558f8ab-3d17be0cd74mr9013225ab.3.1739304290713;
        Tue, 11 Feb 2025 12:04:50 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d155e5caa1sm17430295ab.5.2025.02.11.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:04:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, yukuai1@huaweicloud.com, 
 Muchun Song <muchun.song@linux.dev>
Cc: chengming.zhou@linux.dev, muchun.song@linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20250208090416.38642-1-songmuchun@bytedance.com>
References: <20250208090416.38642-1-songmuchun@bytedance.com>
Subject: Re: [PATCH RESEND v2 1/2] block: introduce init_wait_func()
Message-Id: <173930428956.134224.12826732469038021617.b4-ty@kernel.dk>
Date: Tue, 11 Feb 2025 13:04:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Sat, 08 Feb 2025 17:04:15 +0800, Muchun Song wrote:
> There is already a macro DEFINE_WAIT_FUNC() to declare a wait_queue_entry
> with a specified waking function. But there is not a counterpart for
> initializing one wait_queue_entry with a specified waking function. So
> introducing init_wait_func() for this, which also could be used in iocost
> and rq-qos. Using default_wake_function() in rq_qos_wait() to wake up
> waiters, which could remove ->task field from rq_qos_wait_data.
> 
> [...]

Applied, thanks!

[1/2] block: introduce init_wait_func()
      commit: 36d03cb3277e29beedb87b8efb1e4da02b26e0c0
[2/2] block: refactor rq_qos_wait()
      commit: a052bfa636bb763786b9dc13a301a59afb03787a

Best regards,
-- 
Jens Axboe



