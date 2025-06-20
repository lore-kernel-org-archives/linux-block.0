Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB212144A2
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392945; cv=none; b=T5ho0ZsZDou+xbCWIVI4mbx0qAxOQAF/srbd67zx7R0akWTq8LclKiQT1BSxGDpOGBcD/ggUNxOa93haHC2S+gaMpwKibhxz8FLYk2FUNSOAj6y1xqiqC0luhIbA64QORn0ARPZmjzeq302QrlihtX/Q47urMloJJWwjjZYO2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392945; c=relaxed/simple;
	bh=YLWQMqNIvRlBfGk0BLWS3fV/fwt0ymSLhyYJlFptfh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuNkz0vGbTCEJZeJFCFHxMaYjjcE/qW7r7B9y4z/GVyag5LT9HfnQR1rZPIf9p0ea+TOShzcqvyXka08aoHsu8MlAZ4iGkSbgXApzmD2S/8uph5YuT92yjSux748JItcYzx6zJxIq8oxlLo/jSIWGYdT4qqhM/l9reVT5Xlj8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YEkFLov/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YEkFLov/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so1123570a91.1
        for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 21:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750392943; x=1750997743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cy3TvWpi+fL3vF5Ha79/V2lVstK62EgvNVGAMRApv8=;
        b=YEkFLov/WQIWuhLmZDWWJe2cWf4v8UBCgfy2YVFNsUYca32ARfcffuqURpNLlXa0P3
         a6yk3IgwFBh/SWOiuYN0sS2P6JX4EGS1MdNHw2yzkUv6MUT6nVGtUcSEXEsa8Y3hiWnB
         MT2uxk0evfU4HfPMKu0VFLvrMBUG/MrR+oeh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750392943; x=1750997743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cy3TvWpi+fL3vF5Ha79/V2lVstK62EgvNVGAMRApv8=;
        b=OfbEXnZFQpl7XabaMqu3j5TRwiSJ12sc6psiw/3SP2Ho03WHDkJR+TPGk6x6ETIJjF
         fONBpBfUykifDVrubs4thp8z6GtVLcXeXvwLUkxqmyYjqJvtvFrqosc8g+e8CECeEF47
         8nXjrC/ubeDqxB7huH2souyfDkOe/OrcszfqtnhxzE/yhcmw2V9htpSNI/FYIhOYBV/1
         NcMoueZdSg1nsV5Lu/AwBkkSMk3MsRJTzCYjV4HoCwNl5V15bJLVt2hveKcyAEvSqqdl
         75t/w+vPS8tuUDBArO7urHt7OAtMwn0TFlpcWm+FzAPBfpwx+2AcYmI4PpB/bwhnnIau
         IsqA==
X-Forwarded-Encrypted: i=1; AJvYcCVIsbsG5envjxwSxt+trhd2iedSpzImF4jSKp3BK4bqwRY2R80KaSTZCXyRM8mXyqWK00S73jVRA8F0gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MvjpPJE19e9giuLAMXsfMzXWZ69BqPiVoXr1PhBbASRvwq+d
	SwDFVbgDYOTceOI7oZLWKQSvBZrR0t2aH7US/7zB8ShRwDG6H6X1jtL+ZcpmC77AWBbe5WKTxqq
	wAuA=
X-Gm-Gg: ASbGnct9/I7Hl6/yKPmOqBFa1ira2lgc1ANWMc8RNO75xnu4IjOmNgFd3pgryQw6r/K
	zkZx8pmJ0iFb2fK7xLR4jQe2TKC+D9DTFZNHorkFk7gcmlHmVT+rVMt8wHoDYqJBni7EJh4GJYz
	BTXrJSBfBr0wv5Il+wJJ8Ty4ocgb0XeunAdRCM4wgNH9zAo5XecMMCqCgt+JItAHH2xUbqDcS5p
	UjxwQnaHK5r6brwp0edJH5IoQTZr0n8Hi7Wic0EoXCBvBQpEr0CDUbCWE2XUxmJIsS5WSgMNVwv
	gevdl1nTz4ofSAQmzY1QJ4l/9GdH9TdKJp86A5qU3F6n0tM5oqRAx7UB9ValaVdZ9g==
X-Google-Smtp-Source: AGHT+IHyRQSDJnGbDBeHS4nxGGY7VJhOz+gP/6YwMppzmVpF//i5uNQcMgRPidqOfnDokaVjIXIERA==
X-Received: by 2002:a17:90b:51c6:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-3159d628b88mr2709052a91.7.1750392943134;
        Thu, 19 Jun 2025 21:15:43 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e574:cc97:5a5d:2a87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df812e1sm755960a91.16.2025.06.19.21.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 21:15:42 -0700 (PDT)
Date: Fri, 20 Jun 2025 13:15:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Richard Chang <richardycc@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, bgeffon@google.com, 
	liumartin@google.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: support asynchronous writeback
Message-ID: <x54netqswex6fpv46nlmeea3ebnm32xnwask4zxw7nmcn7tqdz@4mu4hwsa7hsb>
References: <20250618132622.3730219-1-richardycc@google.com>
 <n6sls56srw265fmyuebz6ciqyxqshxyqb53th23kr5d64rwmub@ibdehcnedro6>
 <CALC_0q8-98y0v_jV6QOFTKRAGhJ4nCXZ=q9wutLZPCE0KnKymw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALC_0q8-98y0v_jV6QOFTKRAGhJ4nCXZ=q9wutLZPCE0KnKymw@mail.gmail.com>

Hi,

On (25/06/20 12:09), Richard Chang wrote:
> Hi Sergey,
> The main idea is to replace submit_bio_wait() to submit_bio(), remove
> the one-by-one IO, and rely on the underlying backing device to handle
> the asynchronous IO requests.
> From my testing results on Android, the idle writeback speed increased 27%.
>
> idle writeback for 185072 4k-pages (~723 MiB)
> $ echo all > /sys/block/zram0/idle
> $ time echo idle > /sys/block/zram0/writeback
> 
> Async writeback:
> 0m02.49s real     0m00.00s user     0m01.19s system
> 0m02.32s real     0m00.00s user     0m00.89s system
> 0m02.35s real     0m00.00s user     0m00.93s system
> 0m02.29s real     0m00.00s user     0m00.88s system
> 
> Sync writeback:
> 0m03.09s real     0m00.00s user     0m01.07s system
> 0m03.18s real     0m00.00s user     0m01.12s system
> 0m03.47s real     0m00.00s user     0m01.16s system
> 0m03.36s real     0m00.00s user     0m01.27s system

Has this been tested on exactly same data sets? page-to-page comparable?
We decompress before writeback, so if the data had different compression
ratios, different number of incompressible objects, etc. then the results
are not directly comparable.
