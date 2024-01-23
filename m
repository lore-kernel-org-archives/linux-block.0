Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DA481DC
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035447; cv=none; b=mOKZ21xDe1bagIsQS/lc1MWO7JBM1SzzWxUKc0/AErPkRsoNcxM+wZv+riDLx+VwHEF27KKv5btPSHrE+TGgW87FiUv4Lz0gnISlZQ2M4Zr4ef4KsnuZLFxJN6+/A1s1ERYe4aXjRHCx1wE0MRDuRlXhpf/wGfDiNdwIGj54xKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035447; c=relaxed/simple;
	bh=GwJoqlyJQLa5x8abZTPJHyjyJH/OXB1bP1ho4CURwOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a+5bxZi/qWveK13xcKeBOz2TSiJqxxrOwwrY26ulCQOe2799iI8e/gnB3+ffzWzRkKKbLhTizf+hOYHDA06EvFd/AUQlRVhmy+ehvlvJHWoPvMD23gwsi1WoXntLSWP1IkYi4fR1VO8jZjZ+oOLkiFSjsLl9M4ei6ltwfObvVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c66b093b86so4074417a12.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 10:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035445; x=1706640245;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xO/Hhan5++WEoUuHBQxmggI/2m3/N2m7MH+q1nwNmOE=;
        b=me3qEdQG9kMqWaWwtP3gZiAP+lZY7RcEm2TqEFJPw0VNd8GyF4e1XCy4Dx3Fx2qvHU
         7tqeB1+/CBaKvpeoV7aP8PeOdaL1sigyF0NEGryQhn81OS3OL1n+AeetoFSia6cA9qir
         N8Hp39jfJSt1em9UHfLGZfBhxB0Oe/JlWQET655Q8D9QukoBgP01GPNSJwBjbHAZhcTw
         bHmEiVEq7wpmkZr4DabqhVf8+unXkfYnEc/xKguP2ExeTRi79ZShMhnyw5W3dNth4nrP
         Ka+IPkWhCD3zbQ/Q/cmAoo1BleVBGiCuZRpoJLkE0RuWoKBO/7u5HI18ABo2F4l+PvV2
         FBBw==
X-Gm-Message-State: AOJu0Ywj4dAGGq9u7PO1ZJU8kFH9OjKQrTEk7owvLNZnqkUuS2w72FXB
	XZhj9/EEWYLVQQTtsTpVqzM7TZrdsg1QkvL3kY3VPbXBwDQXAeQ3qTCjh3ow
X-Google-Smtp-Source: AGHT+IFqcIvl0QYVGYnafCcUWdA6lT5/TBRVom9H4ACtHIteN2ADkWdSGAICXnJ5bmMX6zJOe9/vOA==
X-Received: by 2002:a05:6a20:8e0b:b0:19a:9973:2b22 with SMTP id y11-20020a056a208e0b00b0019a99732b22mr154pzj.40.1706035445467;
        Tue, 23 Jan 2024 10:44:05 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id f7-20020aa78b07000000b006dbd79596f3sm5255411pfd.160.2024.01.23.10.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:44:05 -0800 (PST)
Message-ID: <43b9a943-45f4-4001-a68c-a68a7364f995@acm.org>
Date: Tue, 23 Jan 2024 10:44:04 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] block/bfq: skip expensive merge lookups if contended
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-8-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240123174021.1967461-8-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:34, Jens Axboe wrote:
> where we almost tripple the lock contention (~32% -> ~87%) by attempting
                   ^^^^^^^
                   triple?

> +	/*
> +	 * bio merging is called for every bio queued, and it's very easy
> +	 * to run into contention because of that. If we fail getting
> +	 * the dd lock, just skip this merge attempt. For related IO, the
                ^^
               bfqd?
> +	 * plug will be the successful merging point. If we get here, we
> +	 * already failed doing the obvious merge. Chances of actually
> +	 * getting a merge off this path is a lot slimmer, so skipping an
> +	 * occassional lookup that will most likely not succeed anyway should
> +	 * not be a problem.
> +	 */

Otherwise this patch looks good to me.

Thanks,

Bart.

