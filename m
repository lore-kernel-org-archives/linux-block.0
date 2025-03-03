Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10F213255
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025913; cv=none; b=N8IG1nAxY2yXr6bPhT93RFHjfGl+UV3jf99PD77ObJb6DoWRMZh0pPwgzWt2cHeo+yF80B1WeQ27gFqccKIpNuuBoiSSGVDb8VW5hcpg2nINtw0kc9C61O8MehlkxAkSQsN6HuSDuKC2rhnDFewVghWu8dzKkscfO9ihCwn5Lxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025913; c=relaxed/simple;
	bh=aqBu5lgaIjKfB79ewU8DMYZH9ogDFAvumeNR3vcP144=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJXXhXfg1xmvLF+TD83jaTsP6I+7nY/ASrATdIhAc2OmBt4M+c0IjJg77m0oUT7qZjwFd7yzpH7TEVcb6oOLqCNFosS6fBS/skIEkgY689/cm6xNYxFLnedGQa5qvGkSswAvYhkFLmlHugYkoqWxlodLMMwmt9dHxnINKQKvV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=td3wpqRy; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="td3wpqRy"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso439645439f.0
        for <linux-block@vger.kernel.org>; Mon, 03 Mar 2025 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741025910; x=1741630710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvjzyQGR5WjOCFzCpc4mCzksbIOnD4wTL60DVSWvoTc=;
        b=td3wpqRyJzanGMf1wlmlKklI/DI4ZOn7mHdZRYD2IW1n0lZg4wzr7hBG9YHz7jO30R
         8dv7+Y8yVISBqbLhKKffi+4j5pEnPqlP1Pa1Ob+P8wTceBq2u282BQ1rQylPxObO4IWK
         i7Isi0J92lZZhKiUcnwy5kwtRdGidCr081emNE24MS0Bisdnri7t3LXMC/AaQ8NeRP8o
         qvy6a3NhY0i+kvftjXW6LWOMKruyWia2x5KoF8y0eJSyrCEL0SYXhR3/QDgsJXtpDY9K
         IMY6S9jDuyuZCE8VhAEvDIksyn1uZfsNHe7VwZdfl7tKuBsohDJgrDCUeRCxt3dBdbit
         qd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741025910; x=1741630710;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvjzyQGR5WjOCFzCpc4mCzksbIOnD4wTL60DVSWvoTc=;
        b=oCd1Owz1klDQao4pTQTRXD/VDOf6SWp7ZnGSerGoTt313f96KFNRsHgg1q+jia73qX
         eaQwBEs8eFn4M6qGtwe94SHcMYqHEdgqjmXAlsgEQ+xuGfw99jZAIq3xrhcSL/wEPJ4P
         LoZzzlE2ea887Orzq2Jw5+fRpiPQawaFPNNsgxV6EFqiQ7yni/yJei8+jn6Xfz2DIQtK
         02kt5+mDHTlIPlsZ47OB2qVWJ0XYC9QSA7GYQ/IBn+F0ko9lbz0ugJD+A/zKMKitUdUT
         WGr/1XuWJCwoT9IWIRVvW6rrhGxWbgGSSiq1Ogvut3TyqFJFD2i+L3DQy4UUTp9hB2D0
         nhMg==
X-Forwarded-Encrypted: i=1; AJvYcCWDFRdzKqtjyhl/MX3d07R9oiDHFG0s6pw+dCEWhqGPWsVOriqiUU4n/Tig2eXVMsYOLW9GSx6991BRrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvwsbqYvhD1GAzXuKQn/HI+On2j9IhSfjrsZ7vpQOeSybiu3D9
	J8Rs0sROS8M7t4iC8gvGALFpEeokb+ptqBU5tWsqWycnjEgdNrEz5bauQSo1l3o=
X-Gm-Gg: ASbGncsxzqbTecRcYy5ORbYvY/Fj3OK2bWyBpTLfuszt3AjrBLsUkAUKFksU/O2zyvy
	dpc3Zscb1xI/ryix2cc0+SUz87ldxibIuU0TsrwLFwOaPExs8r4KGMOCQqttlKoZ9ob1pO4U1vl
	/KoKBzTs9xooJtPsOwxnJNGzlI7PesvGKLqfsvLanRu8/FsVwFiRxWVC7/oVg+cu5b/nBxk/ve0
	gTt8hKulwlS8aWxkAMPvvUb0IxGRr6Sh670IbUEZqp4rhtVbcV2TuxOcKekCliFqWh/FyBUiSOj
	kmJgNTnMpExv0Et7oyuDGYHS8QRF+b8nLJJkljZb
X-Google-Smtp-Source: AGHT+IFNdCaZ1XIhp2XJhaxfUE7ndUbdgMNH8GlVjblLMQhKUk1YKF0bz0OwoT+Q4yO5k2hF9QBXug==
X-Received: by 2002:a05:6e02:1:b0:3d3:e536:3096 with SMTP id e9e14a558f8ab-3d3e6e952damr141947255ab.13.1741025910102;
        Mon, 03 Mar 2025 10:18:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f09cac9f8asm527552173.39.2025.03.03.10.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:18:29 -0800 (PST)
Message-ID: <00cef2b0-5a33-4069-b0b7-96f65b6e13ec@kernel.dk>
Date: Mon, 3 Mar 2025 11:18:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] rbd: convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Alex Elder <elder@ieee.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Daniel Vacek <neelx@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Xiubo Li <xiubli@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250301-converge-secs-to-jiffies-part-two-v4-0-c9226df9e4ed@linux.microsoft.com>
 <20250301-converge-secs-to-jiffies-part-two-v4-1-c9226df9e4ed@linux.microsoft.com>
 <4c4b3d6f-64b7-4ba3-8d2e-d8b1f1a03a53@ieee.org>
 <d5035d88-f714-47c2-ace6-8bd609d84633@linux.microsoft.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <d5035d88-f714-47c2-ace6-8bd609d84633@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/25 11:13 AM, Easwar Hariharan wrote:
> @Jens, @Andrew, can you drop the rbd and libceph patches from your respective
> trees while I work this out?

Sure...

-- 
Jens Axboe
