Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC532038B1
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524720; cv=none; b=rCM6ZV3sv1Gw78DKqatWWrpo/gd5hi4qQgHbYSmpDpQXVnuxVr7CJejVPN67QeJ7dJNkZfmdSbFqeu1xNRs32Ke+U40m54+d0mN9AaUhMh0LxF62BIQUKRV6W8f8f2eVdlWC1uSezxa1nW780zVw2bOiPKSTGDMT/ugJbP6nMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524720; c=relaxed/simple;
	bh=vMd+aHFymQRaieFOgY6PI/o9FZajNVmFTMmwzzSIehg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW3KBOQBCF+THnpl0k+8vVF4UcqbhWvmP2tLwYBbJzkGXo14rNmlvu46UvbFD09eXVCrxIiEiiXtk3xcRVYaRdt5Twb5H0k68ZtDEIfkw4VbS8SSPlc4TJh3bEICvKV0s5rc4n24wAYZGRkkfs1cbnyRJ/l2foeUKC00GVsFc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mp4oeYeN; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mp4oeYeN"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288c7567f5dso3256044fac.1
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 11:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731524718; x=1732129518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d6zxdFkPsU+sD0oXkQof2KZyod3gas1uEecLduAVek=;
        b=mp4oeYeN7VufePwex6UCVzdxm2WamYYiFLWp1Ik/5Uu9oVdeqALH5M9z50Zs0ECFMS
         GfJF3rbgFflTygPtYcNgjwnE/iBGvK5hsPvMXnNqUhBrhLuoaskjwIQ9kppExJnm2Fva
         y6YPgPnoaDw2sKGfXpGNEyn3Cjg1ElZxLw4fnNX0bxd0IT1XlGx9ZjejLmpjntRTB8y6
         uEGJEPq4srvaXWxZL6Ln0pZw+FUjRr/lVtCSP6l4+5gZv2f8av87RH+TLXWuSokB9IfP
         pTXUu3JVQbwrQpdQYno1Ci0aYXhN/KabMwXy8KrGfLh8gb+VATjSKC4oUoqtACpBxu8p
         mL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524718; x=1732129518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5d6zxdFkPsU+sD0oXkQof2KZyod3gas1uEecLduAVek=;
        b=dd9yBm81TmsmqyqvXVv57SPTmA5wQoUz1YkRDWQY1hPmKnAZs7NYC0d5QglbSn4sLH
         YL9mOoUVXAEaqkL9pUb6v7rRtKIEuhAFYzjr3ddDHjWJK3VOp14rVl4us4LucGvBUDIJ
         lhYHkoNJ71xz7WQwUSV9/b1Lz2OJrm10U5Tz75a2Os1WYeJASaPDwqB3IuvGY7Y5z6R5
         q9goYvovxHDucmhq3twYbS5n1xw3kJ5XyydNY8pLhr1JNBkq0HAqjrK19a8d2qj1Riyn
         MDhCoqIKlgvspp4VV4picBE0c2nUk+hAGNEybeihQJ3h6l1ofI+eXCP7VqoDehQAxXQS
         izRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHhxa5L+3cn8exCWi/mj3XyQgv5l5A0ouD7ztSJfDN7iWwiAl/AQFoY0Rc+xye8Tr0JqWt/yKnJ8EEWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22tblT4ZfuDIjWofBYA615EnFSMwEtlJVK1ze1V8w1wiLHlBW
	01NJ/+rAU4zaLgHdQFOZ45rlPkoIX9iWpvv9VVw6elyphCFl+5LP7Js8ghMHvK4=
X-Google-Smtp-Source: AGHT+IEqEfISzu+U6ZtkcyQQ168T1b3zcTYcdZM+b6/RCKr3qC5Y1tU76M7H+wd+oi8YKkF3o4FBcw==
X-Received: by 2002:a05:6871:6c9a:b0:295:f651:da2e with SMTP id 586e51a60fabf-295f652881dmr2201325fac.21.1731524717878;
        Wed, 13 Nov 2024 11:05:17 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a5fe673a1sm865837a34.3.2024.11.13.11.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 11:05:17 -0800 (PST)
Message-ID: <c09728ae-1a53-4b6d-8407-07c18fc27e50@kernel.dk>
Date: Wed, 13 Nov 2024 12:05:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] virtio_blk: reverse request order in virtio_queue_rqs
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-3-hch@lst.de> <ZzT4CHjrmD5mW2we@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzT4CHjrmD5mW2we@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 12:03 PM, Keith Busch wrote:
> On Wed, Nov 13, 2024 at 04:20:42PM +0100, Christoph Hellwig wrote:
>> in rotational devices.  Fix this by rewriting nvme_queue_rqs so that it
> 
> You copied this commit message from the previous one for the nvme
> driver. This message should say "virtio_queue_rqs".

I fixed it up. As well as the annoying "two spaces after a period", that
should just go away.

-- 
Jens Axboe

