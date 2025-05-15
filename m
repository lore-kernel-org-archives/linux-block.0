Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43C229B17
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333049; cv=none; b=aPtXljlUGPSeH/5BxPTkQ8sO15nDkbstwrewo8jA5xTTci+VP+AYoS939j3K13rUX2HWL4JjbeG7FcwMMuey85fDg3FUyclt/jtWKpyYWujn7k+ptuf55jcdooNitWktOh2nlau2/NmLuxfiXsqiVU6qCz/OTD4pmMk8OnCOYJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333049; c=relaxed/simple;
	bh=s/QjyZzY/EnfUUvNKb7Q7l8bqIG7rG8gTYAL2oTY5W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeMDGb9HflcR69k+Q8wJfAcI3kGyXUQCgQLNnWNSixvhv8hmIdeu7DUZTZlcm/DWfheVrwT/cs1F+ve76brYNdC6FxJ9u1J/6Cbxe6vz9LtymTPDkG7aIf/qM8udqg1eX6OSMJWzr90AzgF4AGXIy3ZbzGcPZMLNrXwe5mdY3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Aj6gsl2a; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Aj6gsl2a"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3da785e3f90so5940935ab.2
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747333047; x=1747937847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96xY6/n/0fhqAkgNUIqk6HeWQCuRjQ3BV7nB9J6drQA=;
        b=Aj6gsl2aoiPVZ3ukygcyl5oN1kPU/CgVxCQo9MsXm46SK4pgfrHpRchelmqUUJS2Zz
         kSzZGDZq8jQBJ5Cx10wUWKqLU7LxxnR+pntOCs+gBNxKxgY19gRD66XpLG0BKKelZ2sN
         E4iuKrtB1YvtRYD2AoOPHoqEOq1ck0i0Zp9Tm6Lzszmd5NvuB5uERxcRxQ98+sxeGl+G
         byKH4QUUihJ6eDeuTpM38fFd/Kv+ti0IAGotbsMbRei0vk2N+TOPnzfPkjbX/nZd+2mK
         KjqCQRoVp5y6aLTDdUMkMP45ETiznVBNcgjRZrx488gfTKpP6GimDhEp0mzVqnCdbu5V
         NPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333047; x=1747937847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96xY6/n/0fhqAkgNUIqk6HeWQCuRjQ3BV7nB9J6drQA=;
        b=t05wUwxaoaJ7PpYazUhjxbsPGXxEEoMRDYsHvoULDDJYYxTgiZorUgZ9rIooJXlEKi
         rA6XS2990aCs47KcS0UPaUJ8LfIe8m3Dy1Bqp92/ityp76ko9YPB5F6swvGtmgUtX+7q
         BDS9XWTFGoG/+3mVJuZb7lZkb0wht34o1UlTdAsJ9u4EXDeCI5LaKABS0xLyXwlacCXN
         rz5Nm/4Ii7wQFItKp0wy/3I3Xc3N4Bm6IAb3h6RwezZCxDZe0DpgMB1yD/7iOMSoZA/M
         BY45nnLb293mPIKLcF/x8x4Of9Qlz3HQLXXX2K7kHkG9oNB3Ja08dJeHGcII5yPs8+Qn
         pezg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5LDdZlsVJjs9MZgh5+vN+Kbde0e3+SOPz4r5c+6ukVZenoWP5iB+7LF8LtQqcbVgBHxZoP6UD7NWVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/Lt6+qmhrhzkmnuJz0wNWkLyAG+8SJq+Q1o6Hc00UsYntmED
	IzKaqYDFHpojP4OhySYmRvq8K/SiPcsH3/HXBJDnp9T56QhKgBJY3mbnvzjgr02vs0k=
X-Gm-Gg: ASbGncvuehvGt/WCzGLlqyNMCqYuOJ9ny81bBEv7P2XIRJrlg1mb+YsloGIbCIFUrhF
	vbTxyYBzG7DRkx/VMYzNce7vE77iHJHU8tVGKvEygnv4CNSecYlaDVL9IQqZ/9mla+mjqoDe5we
	Wpk0oTieveUE330FUDqs3w5kGOobTpFaBqxYdBxcWydQ/uJKcCG6pvxsp0bTbYKPdvw+nlNl3HM
	0DYMk+QvdAUFD1b07C9KzzRWW5FNMY9tecfkm/zHJT2xpKmQzga02evklEIDcvxakOTOfbowNYF
	Xbh6SUuzskNRbN6gCGR/eZkT042Csvocs+N/UIemxJ0t3Qo=
X-Google-Smtp-Source: AGHT+IE/ytiwQTQqDjKBKn/luh+g5/cfEL1pQKdZeeJtRvFqy5JaffvCEnw/tVJaBrXBsyOabJJlEQ==
X-Received: by 2002:a05:6e02:17cc:b0:3d8:1f87:9431 with SMTP id e9e14a558f8ab-3db842e3820mr11103815ab.12.1747333046867;
        Thu, 15 May 2025 11:17:26 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db843cfa4asm722965ab.8.2025.05.15.11.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:17:25 -0700 (PDT)
Message-ID: <d5372cf5-ed0b-4db2-8b31-5fd4c7967377@kernel.dk>
Date: Thu, 15 May 2025 12:17:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] relayfs: support a counter tracking if per-cpu
 buffers is full
To: Jason Xing <kerneljasonxing@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
 Yushan Zhou <katrinzhou@tencent.com>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-2-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250515061643.31472-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks fine:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

