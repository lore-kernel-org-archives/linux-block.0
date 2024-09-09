Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEEE200B5
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896032; cv=none; b=OR1t0gC0Ugeqne8g5KYzUrbfXRsHOz2QOQV1JBSvOXDCHLptfok18uHyyyrwbRM5lT98fG4hb1elzWBIaKzWG3ghbtPOFaX1j215Q3YBH4dJSPF1tB4Z6BOi7IDhraHGgzR/EVLalByXd14cSvo6tYKy6GQ6JESIyFmO5hDSKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896032; c=relaxed/simple;
	bh=z4PC2NeO9BAn9bGPThiy2qIA0K48SBg5A7KskaxBkVY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IjksFwAm/eVvsby311ZO+sgtN7bNP7w1O7JKvyThO5EJKfmd9iyGzf1aISzFtepYnIq12WS07HiOl9lJa9B4B31Tp4w6ehHgJjMIaCsCXlNmCzZ/yGuL/D4lI3szj1dudGHfcEOLmaynasSU+LbSK1qQ6F/wIxZJV+k8l3QRye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IUF0B/Hi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IUF0B/Hi"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo2103166a12.1
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2024 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725896029; x=1726500829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jz+0OHvumrwbT49/ZLbJGnoGzf7RLRObyJvUXiont54=;
        b=IUF0B/HiWJv9POEpNe0hWut8r6Aj70jCDBmPV9e0d4BuB086RAWHfnPKsiTXwkM1zD
         z6cHd8XeEVP/hmhYixBzJ5/jVW7kYuVEfG6qJcLKFBSqEqIoB7Bz1ofqtxqHkcCj5y9d
         7m8NVR3jTD5/LwEh1Dt/S7eyA9mG7BQ8MowdcTadyOJksXYk/zhlPyp0nMkSsZR1W1ko
         L29poB647eORSZskPM0dCz1B1/tQXwJDoNw+TEZ5C8Lp/3O7vsezWpbXJH9wQSMm2Id+
         OPuOWbCYQMH6NgqVQaYxSNj/qmUlInkjaAKzfRDKy4yjNR4KUy6C67KnJnAyzqS9HVLz
         RXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725896029; x=1726500829;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jz+0OHvumrwbT49/ZLbJGnoGzf7RLRObyJvUXiont54=;
        b=BZwma9P8ZKgE4MfRe0SlI3IkIWEYQaRZJ50LyhxWstFyrQ5WY3WNWXAuS+UJKTlXe8
         TNEtL1f/k7zXuTxaeihsW3gXM4mLtbxAe20l6XjlV+ZUkaH4UbGaAI92uOGIYDNu4L9g
         U2nbNcuZgxwx0ahJDsYAYtVqn6FgYAseolnA/UqwpANMPIXHh0HghklpVQDE6cuGVEkf
         +0Df9E2NXEvMLK6SHJQG8C9LGw4qzciveX6YZGBM4TdMc+GMoc0fhIJa8Q/j1iF8XSBm
         lwcN8RGiFEkuzKh3sb+/Cri/jJuC6czlTs6Thq5RiBeQqY1Fn8Kz+WsqkvEbJ2iKDnii
         EYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8oncTUwOE1pk3j4LPeqj5kjOtCtYb6MejGJL4v9zKOVYZhxWMPrgUKmQnw23axKETeK5y9TRsgT5N2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YJDaqCDvj23AQgV7LXZ1c8HJFfb5zJe47HGbS8+JmqEi+K7E
	RfettwJ3KziCRUswn+1+1Oy5BsYpKqV+3QIboDwaH11WEzRNeVPlL43iUmTSV9Y=
X-Google-Smtp-Source: AGHT+IF5m99KU1sY/y43nzvWbYbkiNLlQQoKCC/b30rJ4NsSCugz4Kj7izv+FOPnC2J7LbiXlyDv2A==
X-Received: by 2002:a05:6a20:4909:b0:1c4:9f31:ac9e with SMTP id adf61e73a8af0-1cf2a0b7277mr5830465637.42.1725896029458;
        Mon, 09 Sep 2024 08:33:49 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58b2a88sm3638567b3a.46.2024.09.09.08.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 08:33:48 -0700 (PDT)
Message-ID: <14a6ec2f-dbb8-4372-bccd-8e91c9527ea3@kernel.dk>
Date: Mon, 9 Sep 2024 09:33:47 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] implement async block discards and other ops via
 io_uring
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>
References: <cover.1725621577.git.asml.silence@gmail.com>
 <29245c2e-d536-4a98-88ed-d1757795b3cd@kernel.dk>
Content-Language: en-US
In-Reply-To: <29245c2e-d536-4a98-88ed-d1757795b3cd@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/24 8:51 AM, Jens Axboe wrote:
> On 9/6/24 4:57 PM, Pavel Begunkov wrote:
>> There is an interest in having asynchronous block operations like
>> discard and write zeroes. The series implements that as io_uring commands,
>> which is an io_uring request type allowing to implement custom file
>> specific operations.
>>
>> First 4 are preparation patches. Patch 5 introduces the main chunk of
>> cmd infrastructure and discard commands. Patches 6-8 implement
>> write zeroes variants.
> 
> Sitting in for-6.12/io_uring-discard for now, as there's a hidden
> dependency with the end/len patch in for-6.12/block.
> 
> Ran a quick test - have 64 4k discards inflight. Here's the current
> performance, with 64 threads with sync discard:
> 
> qd64 sync discard: 21K IOPS, lat avg 3 msec (max 21 msec)
> 
> and using io_uring with async discard, otherwise same test case:
> 
> qd64 async discard: 76K IOPS, lat avg 845 usec (max 2.2 msec)
> 
> If we switch to doing 1M discards, then we get:
> 
> qd64 sync discard: 14K IOPS, lat avg 5 msec (max 25 msec)
> 
> and using io_uring with async discard, otherwise same test case:
> 
> qd64 async discard: 56K IOPS, lat avg 1153 usec (max 3.6 msec)
> 
> This is on a:
> 
> Samsung Electronics Co Ltd NVMe SSD Controller PM174X
> 
> nvme device. It doesn't have the fastest discard, but still nicely shows
> the improvement over a purely sync discard.

Did some basic testing with null_blk just to get a better idea of what
it'd look like on a faster devices. Same test cases as above (qd=64, 4k
and 1M random trims):

Type	Trim size	IOPS	Lat avg (usec)	Lat Max (usec)
==============================================================
sync	4k		 144K	    444		   20314
async	4k		1353K	     47		     595
sync	1M		  56K	   1136		   21031
async	1M		  94K	    680		     760			

-- 
Jens Axboe

