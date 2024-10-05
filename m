Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A472AD23
	for <linux-block@vger.kernel.org>; Sat,  5 Oct 2024 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728091349; cv=none; b=Je/ct6urqkRPp0G/P2o0aNUq162B+MmMVKTIWK8YtHiDK1/U6yF9uSFr8Ez5RBUOMi9vUld+mUyIYyQ7DkpXFLLPhwtM08354F8JP3HgAAl+X+UdrimQdsREPMoZRSNE0b4zQfGdgzbDBdzmk75dmL4TwSjPgjmc1Pf8ODdcW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728091349; c=relaxed/simple;
	bh=7HWjQznNYb08ZHhERH0pXjoZ10eAQNT8u4oZKb/GxHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBfKAJFt7aRSSyG1N9e2Eo8YpayZVg5s4lwudcEwc7xAkKRE85CUIBAqeO3rxyAVP4aKDt1qs331k2xMcM/UOdiI1ja5LuPu0I0tRRwX9aiKZPv3AeVGwujGmcFTYj0f5IpdvxWp42+wKfF2rQUPLSJ/4Modiv/7q4Mltj5qQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g/VGASgz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g/VGASgz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b6c311f62so24300565ad.0
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728091346; x=1728696146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwUOdcuwOOimjt9LDoWFqhrfU+jsI9408hnb1NpCV18=;
        b=g/VGASgztpVWh/Q34nB21H4XTjutCak8T2NPMILUOQNJJHuQ6POnyFzLWjwtMrbUOI
         auVn6dSXGuDKoCx+ox9eKIlnVQzbDKrMu4ymmPXS03LY94AGo3ni/DhEmu1IenLFvz3q
         QhLy/ek5baRgZjuwoojfsc7sLZKsEVTmQl/TxfGsGmkj+O6MoBLEcKmOopOLGICMwm5g
         BJxzTxrGW3t7MqCiEXMAop5UpPgaMTuZiTjruo1ij7+onIaYd73qXqxrwqud/seADRxX
         F/cGxPVpveWLriTiPpia5FtROIxUp0wLf0z+Aq8ZgRlTNzM7vVV9Uu6qb97p+9r0WkZI
         c7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728091346; x=1728696146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwUOdcuwOOimjt9LDoWFqhrfU+jsI9408hnb1NpCV18=;
        b=mewGTryqsa3NXG1o6netpvCGIFFSc5i57xWxmlHNH5Z+Ljb/+6f24Tj1dPaw9nakPa
         lEfGdnw78CbGlFiPDcOZjQuaOKh/e4alrULqJphLe/FJLJHdjQjtI7MwvypmmZQITNe2
         WuZ9dW332ZjwCen+bbJ2UXYVubH+s+BrV681fZhb1PZELDUI9vBUZFTJvvsNYqS2Kj3Q
         W8+IU4/qT5imeOaj6PetoRegdYV4mA1cIaYDqMCUD4U3HxBdyIOM8sK0y3wivKorWReH
         iqu8I9yMVmkpjeBE6RDYOVl5k+dfsBvA1BvNMiW5GwH0UmSiiUCCSR5R7ENvHdm6V3GM
         rdwg==
X-Forwarded-Encrypted: i=1; AJvYcCUUq6M/jay4mhZYhc6zKc7U1X3kw3zo/wBrFO575dVlGOS5dWyTqqaAT9hmJlTkuBeaZ1Z9s7wZ4E8JRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGeTEQQpOOz9sGQqqxRG1tB1HE091my35g+s9KXtArV15bIH/c
	VxXPyZj4dSWoO5c7WRKStoO8blzoh20H5d5ozjhES9OKMeqZTKfegPQL10CZi+U=
X-Google-Smtp-Source: AGHT+IGoA2zRhIDde1IwSrkk3aqJJokT9h8Mgql1pe2fjGK6eSANH0L734iLI27o7bzT3eXlzqcZ3A==
X-Received: by 2002:a17:902:e851:b0:207:1708:734c with SMTP id d9443c01a7336-20bfe022d08mr57774625ad.11.1728091346106;
        Fri, 04 Oct 2024 18:22:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13930715sm4447135ad.145.2024.10.04.18.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 18:22:25 -0700 (PDT)
Message-ID: <65e41cfb-ad68-440f-9e2b-8b3341ed3005@kernel.dk>
Date: Fri, 4 Oct 2024 19:22:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Stable backport request (was Re: read regression for dm-snapshot with
 loopback)
To: Leah Rumancik <leah.rumancik@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, bvanassche@acm.org, linux-block@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CACzhbgTFesCa-tpyCqunUoTw-1P2EJ83zDzrcB4fbMi6nNNwng@mail.gmail.com>
 <20241004055854.GA14489@lst.de>
 <CACzhbgT_o0B7x9=c10QpRVEm1FuNaAU3Lh0cUGQ3B_+4s21cLw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CACzhbgT_o0B7x9=c10QpRVEm1FuNaAU3Lh0cUGQ3B_+4s21cLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 6:41 PM, Leah Rumancik wrote:
> Cool, thanks. I'll poke around some more next week, but sounds good,
> let's go ahead with 667ea36378 for 6.6 and 6.1 then.

Greg, can you pickup 667ea36378cf for 6.1-stable and 6.6-stable?

-- 
Jens Axboe

