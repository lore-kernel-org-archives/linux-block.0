Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA031E862
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710726282; cv=none; b=SmbXW9sKXkr7SZzHlPgm/myZk4k4Os+qeIGzzQoasOiLUVi9MjU4sAt1g7w16mN9E9i61BcTHHFM3YeWhnPCjcNZ6hPbCZnl67mCCcJSipZS9JDAiACayDCS3u7lgy++PL7F9fou3YkdzdpMyAkSCGekzhvcX54a8Fr2/khhs7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710726282; c=relaxed/simple;
	bh=rtA8ZUTIJYaC6R1zalhcSpBER873U0eff7rcVHja1go=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dO8+Qlwy2eNueq+zwGKvhMCKb3uEGa0kNNAAuedsKGKgWlC9l7RuARcudMger6ZvPWViijmtnkpqtEh+K0PvUIgilAySWEmxo/33u3haJgzVyYjpHrZnxslkEeZMrDgDsacSys8ehA67fuHqLavsBcahvqR97pVCXU8RRnl9Zt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HizMpIAc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HizMpIAc"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so532370a12.0
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2024 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710726280; x=1711331080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erQIF4gtsdJ33BKlPp1h5bCJ8dKeX6YK7T5I6H13fWo=;
        b=HizMpIAcX8AZ1BmZ8K4mhVaWM8gKM/Md1cu5m5WgVQnleDgDwcNx1jhWzmmZkCoQPO
         4vlVQacFQsbtSSlgLrV22nC29UlRypE9bNAv1uY/4hNdDIpbMrlq1N0x3LPui3IJL2Kc
         0pK9E3TRwg0VZn0Fa0hCubbc+WE7PSJCNemC1sExHlDKF4RkXU1ZKiriBteLlGNk+uWs
         mHYK1PvBSjMeqboIxxGt3dBCYct2kuRAJqoPmxtYHPRrC92jiEJfqhUD/xOry1hDgIqQ
         Jzdr7JQH9AZArvgWZZFJX9wqDg/hjL4xuYm31tGDJXbaP/KAj3iGnr7XWcyfcz2dst8O
         ewkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710726280; x=1711331080;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erQIF4gtsdJ33BKlPp1h5bCJ8dKeX6YK7T5I6H13fWo=;
        b=vpR4PlyhAvkUL9P635+f81l50SlFH2Jt/yFzFyELDOX/7uP6cQGIxMQcUfaCflT7wZ
         uwP+Pb4kvGXLlcCBqFIPpbT55svj6DsrGOWqmcXoba3IqDx7yQxpfl8i/1B1rXZBZCNY
         3mg7NPYrQfP8LsHrdNSq8QyqFat8PY1wMJTAikMHjmnPw3eoIT9i63ZKrCDtE/JxKTOz
         E3Js2Dngb2XNd1pPG0tls/BbMgO+kBVdHpTBUL1mnIsw88w/UXnPcLw82/3g0uh6d0wv
         CF1VOPUV76qf1tfUsoHfQiRl3jrYC8jgCfGfKxr+66EjrUQdqaI4Sa/I9E1sMZ+Czx0r
         K6EA==
X-Forwarded-Encrypted: i=1; AJvYcCVrIyE3kqlCUgn/21I5LaybAk3j0DbZ+xJyjuxrtIbfuY1mvpiLpWUV888Fmb7cQP440ZjsNlSg2j4olBXXQ4jz8Sscwol1we/XP+g=
X-Gm-Message-State: AOJu0YzU3wnamutKbYRX0HQQcB9lv5Y6HwxN3ZV+CxHkOJ2nu8YCYL2a
	oPtyT9/c/aM5OMGbDT4zIkzREIJxhSosi9nmq/cTPHDVP5LNOEpGE4I2jYbXZ3M=
X-Google-Smtp-Source: AGHT+IGYtF/52nUBWbGRvZ/0/ZqpOO3sJ8L6+HBbH55XFAGEH8QGl6Ea3MxrgapKqWQj1qwB1Uo4Gg==
X-Received: by 2002:a17:902:d4d0:b0:1de:e8ce:9d7a with SMTP id o16-20020a170902d4d000b001dee8ce9d7amr11208296plg.5.1710726280019;
        Sun, 17 Mar 2024 18:44:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o19-20020a170902e29300b001dd8d298693sm7921870plc.23.2024.03.17.18.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 18:44:39 -0700 (PDT)
Message-ID: <6d0d7b97-e0cc-473b-b9ca-5cf5f2c52973@kernel.dk>
Date: Sun, 17 Mar 2024 19:44:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 00/11] remove aux CQE caches
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <ZfWk9Pp0zJ1i1JAE@fedora>
 <1132db8f-829f-4ea8-bdee-8f592b5e3c19@gmail.com>
 <e25412ba-916c-4de7-8ed2-18268f656731@kernel.dk>
 <d3beeb72-c4cf-4fad-80bc-10ca1f035fff@gmail.com>
 <4787bb12-bb89-490a-9d30-40b4f54a19ad@kernel.dk>
 <6dea0285-254d-4985-982b-39f3897bf064@gmail.com>
 <2091c056-d5ed-44e3-a163-b95680cece27@gmail.com>
 <d016a590-d7a9-405f-a2e4-d7c4ffa80fce@kernel.dk>
 <4c47f80f-df74-4b27-b1e7-ce30d5c959f9@kernel.dk>
 <4320d059-0308-42c3-b01f-18107885ffbd@kernel.dk> <ZfeHmNtoTo9nvTaV@fedora>
 <1e05aee5-4166-4e5d-9b76-94e1d833ab17@kernel.dk>
In-Reply-To: <1e05aee5-4166-4e5d-9b76-94e1d833ab17@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/24 7:34 PM, Jens Axboe wrote:
>>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>>> index a2cb8da3cc33..f1d3c5e065e9 100644
>>> --- a/io_uring/io_uring.c
>>> +++ b/io_uring/io_uring.c
>>> @@ -3242,6 +3242,8 @@ static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
>>>  	ret |= io_kill_timeouts(ctx, task, cancel_all);
>>>  	if (task)
>>>  		ret |= io_run_task_work() > 0;
>>> +	else if (ret)
>>> +		flush_delayed_work(&ctx->fallback_work);
>>>  	return ret;
>>>  }
>>
>> Still can trigger the warning with above patch:
>>
>> [  446.275975] ------------[ cut here ]------------
>> [  446.276340] WARNING: CPU: 8 PID: 731 at kernel/fork.c:969 __put_task_struct+0x10c/0x180
> 
> And this is running that test case you referenced? I'll take a look, as
> it seems related to the poll kill rather than the other patchset.

I can reproduce with that test too, and it triggers with v2 of the
patchset on top of io_uring-6.9, with and without that poll patch. Which
makes sense, as I doubt you're doing any poll or timeouts in there.

Pavel, passing that one to you then :)

-- 
Jens Axboe

