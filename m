Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12F2376FC
	for <linux-block@vger.kernel.org>; Thu,  2 Oct 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420713; cv=none; b=S+JfRa4Jl4M/d8gmOjVwy/PRTo5wruUPc/tjRN7bw6hXOgLyfc3O/zzJ6CKHKWjmExLw/FpJgryJofDPfMXhMRSzQBkcrbx1kJG/MiQceeWFF3LUijdiktcdPhPDz/K7of+v5JqHpxAUuGwWwYDDpvXWYi1YBlUmorVP+Da+mf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420713; c=relaxed/simple;
	bh=0AOCr6BPvIm1M5pnw2VjYpyLZxGSVwWCediy8evOiuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6CrbWoqjTmpYx+H99OXZcXNZdw4sLdnlZd0h1vP/QjyG93ZvdvHQw4MByr4uA0eOEaK1KuOnrvLTQgHnhUuGCyI3sj4KYTggQtpQKKW/gUPQXFc5WrT7AQh+duanOo1dZ4YhLhhBPEvUDGQoerB3YyVoI6DtRtTD+pYh/U5TMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rCUGi3+6; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rCUGi3+6"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42861442ec5so11391465ab.0
        for <linux-block@vger.kernel.org>; Thu, 02 Oct 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759420709; x=1760025509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNilpGtwunxhkKhtHuanByyeVgHiZ0tzBGIYdEYkGmA=;
        b=rCUGi3+6k/j40dTyvQH3OV2lP/wGRecIhNLRpRqpAjP3rTSbC6ZlZTqX/23Rv8OTxE
         lAXg3oAFeBwvEsOIiQAZ5bGrwIl5b9PKt1+HAnLnIkZOyUO0NAtf0qd7QcgRDnIAG9Q4
         4oYrC8qa5cqYfpGHXj9Xh0ABqZJ2K7sb6EWTmhBuzy9oUVH1FGlodlRuFTQ/Z9yjItBN
         azg05OJJK2OIj4gVRznFwJkjz0DxaOaRC/p7gjo3XOQpVWuSetBZxB8kIRN6LDviq03d
         TwjauBeTs3hITnB614ZKj1h3Kp/cftbcqKKRqWVRYMletv7t/QZz+mYSDU8+8F7fxr3v
         C0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420709; x=1760025509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNilpGtwunxhkKhtHuanByyeVgHiZ0tzBGIYdEYkGmA=;
        b=peHVQzEj+Q1/abWPhoyMYPekVEUqc1ZczUUhZHlEw06wapuGgNRx1msMg2+zEOr2N8
         dMPrRxVaTfsxaxLENeTqbNjK1evl+y7tKtQbQz2hwT8wNgyHkUJnStia9r9EZf9YknJO
         0RAG6gyeml5gKRjKoa5SPpPxi0T855EJMeavQ6tULdGSS9aDGXRH1HEZ7tC2pFJZdm3I
         VITm6bBl+MGquvZiJ2d1pSY/hvEdcdJy+gfjT9lpzEKGGrrkC7vmrkjMkWfrAu9ho9Z6
         Fw1RlNczVpaKZjKZnanV/5V7MUYo26OYmOtA/ffYxaurKtH3ozkyiWLzs+tGkSE7yIW/
         LWTw==
X-Forwarded-Encrypted: i=1; AJvYcCWAhCYL3/GogVQJmvoKs5ktDFIyQSQ4Be5Dn8hbg7fIae5jbZiBs5DEInVtsQ1ckSYjcOt9b2vIVQRrmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvPu4GFVOk0Bapco4TOq6/O4Zp3aS/rRaNjyL7dVg+woqESZKi
	/M7Y9USTymVEInNcnb34Che0u5h7hNVYOiaQGolrBnEv6Ha3Afgzz+EC50AYmygbW0E=
X-Gm-Gg: ASbGncuDnfrKVKR6M0n2AXWurl7X36iAfH81W5NV+m05uFZtpX08TBz02/bRPItwFuG
	4y3dRMvlS3kNrK/o/zKulweYTl/wHT+nOL6FoItb7+IixYR2ITkjT+rb19wZDNcPT7R+J4OI9U4
	FAvzwwZGL8lVAUG6BtVa7+I1THrc41+cLCszPCMfQzWA05x3YJw02dbCYgEgSx31JptFlcOlj5Y
	a+SlW2OC8AyZ8CyvxPTHqC0AWn0grq1BmMT62oZnMCpOaoVZZE8TMirTtyALQXYCHlkUENN7lqK
	Nsezzkq+9/tln3cv4uXjNxEL2IGrj6DMDWU9cO7g3d/M9TnxrgH7HuO5w/vs+KHfS72x0rbIXVy
	ZZ0f8nPc23jSa8Sd0gzF6ruqbuYSu5GFi72mzkNLhqhlL
X-Google-Smtp-Source: AGHT+IGEiHZSumtbEx41vubwodqOoT5aOYw9eNQC8MCndLsgVDLYkboIsl41CSo6vL17oHiISA8Lew==
X-Received: by 2002:a05:6e02:16ca:b0:42e:741f:b626 with SMTP id e9e14a558f8ab-42e7ad021eemr1269845ab.13.1759420708846;
        Thu, 02 Oct 2025 08:58:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4f0asm10924825ab.2.2025.10.02.08.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 08:58:28 -0700 (PDT)
Message-ID: <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
Date: Thu, 2 Oct 2025 09:58:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Nilay Shroff <nilay@linux.ibm.com>, Kyle Sanderson <kyle.leet@gmail.com>,
 linux-block@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com,
 gjoyce@ibm.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
 <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
 <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 9:30 AM, Nilay Shroff wrote:
>> Slept for a couple hours. This appears to be well known in block (the fix is in the 6.18 pull) that it is causing panics on stable, and didn't make it back to 6.17 past the initial merge window (as well as 6.16).
>>
>> Presumably adjusting the request depth isn't common (if this is indeed the problem)?
>>
>> I also have ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", ATTR{queue/nr_requests}="1024" as a udev rule.
>>
> So the above udev rule suggests that you're updating
> nr_requests which do update the queue depth. 
> 
>> Jens, is this the only patch from August that is needed to fix this panic?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=ba28afbd9eff2a6370f23ef4e6a036ab0cfda409
>>
> Greg, I think we should have the above commit ba28afbd9eff ("blk-mq: fix 
> blk_mq_tags double free while nr_requests grown") backported to the 6.16.x
> stable kernel, if it hasn't yet queued up. 

Sorry missed thit - yes that should be enough, and agree we should get
it into stable. Still waiting on Linus to actually pull my trees though,
so we'll have to wait for that to happen first.

-- 
Jens Axboe
