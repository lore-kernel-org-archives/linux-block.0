Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B12701C4
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745791405; cv=none; b=jFauAr9XJrI40qQOP6K0Duf/l8NB/dv/qkHvDBJBOEhYVDD+a+Hhhdt08W9aW+Xgm0ZOFq4qxDrXMDBVc8b8U8loBwmyAJ3w0+DzxJDKUu8bBjM7VtfwJgdqZuOSpZKKv+OSTIxYWT2QBlOZWbFtvpZCVyOSXSamEb43KC8BsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745791405; c=relaxed/simple;
	bh=wbWIQsG0TRi0Z69jTSR/6qQLHNml0VY3lWNXqp2lK74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZOf4838mED9SpygpD43KCF1ncRQkjbLaIm94em6mFDw5+WUo/EExfZEKSG8RGvMzoCiTkRJ48F7qa2BJk8nx6jabLjvRHZOanns0XsMk/L2CpJqfbLZ3DLKdRQNmtZXycMPFJVHyN8M3IVNPckTUtGrLtUdcZ2nK09MDS1cq1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sVwmnSMN; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sVwmnSMN"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-861525e9b0aso395594539f.3
        for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745791401; x=1746396201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iNCX7jQ7H/so529jI/n/le9Q7aHsjoCS5ZZgId6Z/yc=;
        b=sVwmnSMNmyED1KlmSA2O2DWYL8qBOCeqgKjDwG/OM9DL+OrHdi71+vlXzHK1nD5iOs
         drFkHPc1+rteWEpTwrr4PLAKeG5ZigLa0HlG0GFRqhK1KyJjDETw00+BBIb0EzEBLf/x
         Ki+11mHqM8UbB7jEoXU3bp34bqe8kXU7RVoKTC6gAKIEF+zpzj4k+lH/RxZhvXKqU2LI
         QVg49wGGroz/WJShJUKOXNJoF+NFLWI2JDc5DVEUofYoITUmRokB1NRzISFXZZcTRtO1
         Nnoc0nloexBbEO58XkkXjef00iOw/qVKoKiJdihFXCt3uBoiuyErOtYmJFdenGATURYn
         HqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745791401; x=1746396201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNCX7jQ7H/so529jI/n/le9Q7aHsjoCS5ZZgId6Z/yc=;
        b=LeG2SVqc2Sduba4g8w3HG1qbAp7DIYvNGocnObrSJgWd0qNaQ/gFsnk3Tjys7vvpWj
         nUerNZJykfWZAX1OWD/HuAmyTuf3vuudpAIn5YT1h3cZgy/pBO4n4n+SnxIE3fUbHQRr
         lIu9DEFCVqwwtEZFQK0Bo8T9Xkn/AFJwn0cTA/PCvuyrGSbQaLFeL+FkfZcbj90aGyzV
         by3Q1+W5gioaLkvIcrtbKQb+uW2Wbwz5mXMGxdVWWuURvqSUVflDK7koB5P82I2H+XDU
         xRW9Bu+dUiIDhCIIdHXkOEL4oqzpJVGj5BIPf9dSac7aqf11hSE8v1V4vguJoBnnZfij
         y2WA==
X-Forwarded-Encrypted: i=1; AJvYcCUy3VUeaTlnYKztg3sVHmjzC2tuNFm5xWmloj8los7cOBPaDx+tUbJpNFqHP/V9Q2fwV4X/UXhPFv+HeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/fCbpDwyg3/HRrbb5FEdwPgdEs7LnVL8UhI4F0Jcavbt7FWQ
	OaKl/8xVC/riJAB335OX3TBOCo7f00kE3i36WzjMxerX1brKRUy/5XgZN9ZLoUA=
X-Gm-Gg: ASbGncvwpuzYQPuM7mxchAuiUW/3CvJ2DYnWarvtbaNhgjSAWN9Qw7o9WjMmNZeHE7s
	RJGfzcnCFEbTPN6pwRGD+xo3OYW63/NqjiIBAJi8jzBRC3uZaRIn2wzosiWKgf/JKYYaD1FcsfW
	WKuVCr+dZ5FIbMozlvCWzhrdh1ZiaQ5Sm9ZmKvvJDsglDgtBzoovIlx5eFzqnXHlcwReCJrF9gM
	k1ioBAwPwcHZczM/q18EHviUzcjf5WetsV5AuljO86SCIJGvS3LaqoREd+v6ySt2l2iU3ldPgTr
	X+Sgiz+cNrKHckL44eRWZrilgHqRSW5TqHCWkw==
X-Google-Smtp-Source: AGHT+IH8E48JkKAwtfL07JN1fQUrwgYyFUebyUWasSyzEypQDtEo25xd4qLu7SAT4RR9O351jR9ePQ==
X-Received: by 2002:a05:6602:4915:b0:864:677e:ddae with SMTP id ca18e2360f4ac-864677f0f9fmr543606539f.6.1745791400964;
        Sun, 27 Apr 2025 15:03:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824b84a22sm1919686173.92.2025.04.27.15.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 15:03:20 -0700 (PDT)
Message-ID: <fb3add67-c469-483e-ac51-e53dea7df360@kernel.dk>
Date: Sun, 27 Apr 2025 16:03:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: rnbd: add .release to rnbd_dev_ktype
To: Salah Triki <salah.triki@gmail.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aA5Rzse_xM5JWjgg@pc>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aA5Rzse_xM5JWjgg@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/25 9:48 AM, Salah Triki wrote:
> Every ktype must provides a .release function that will be called after
> the last kobject_put.

This commit needs:

1) A description of the problem. There's just a vague statement in
   there.
2) A Fixes tag

-- 
Jens Axboe
