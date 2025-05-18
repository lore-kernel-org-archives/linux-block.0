Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BE1D5166
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747562507; cv=none; b=Ly7L+urwxkUMt1zTQ4I5iIcd7gjGHxM6UE9/GA3s6orsgnXryEH38U/A9xRzpuEmcHaMWNpTVmF4ZT/rgU8U1HHj4llvgF5Dsu18dOC74DFH7EUWjwxSX3iFxyEh2ylgXDnuugGkBO+Bd+b+2xQrNclH3Zp1KmUlyxbkizt1lSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747562507; c=relaxed/simple;
	bh=5Kt44Ao0x7UVYjrQkQm7U+HhMGBG8WB6X2pYVMdlUO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n0u8K8cL4/MxsOz01W1b6qnTTR7KvAF5aA2N60YeKavYvAkanBCLYLJhsnV3aOkDWOtDIzTtBp3Qy356TondYzI/aCSqwEF2wfTY/48bNirHwUzIBmYbAipZZ3GPW/I+9Kf6q7mlwoGtG7kTpsquhRUW58RA6x13cjS30ymJW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so35354215e9.1
        for <linux-block@vger.kernel.org>; Sun, 18 May 2025 03:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747562504; x=1748167304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kt44Ao0x7UVYjrQkQm7U+HhMGBG8WB6X2pYVMdlUO8=;
        b=sJ7pIv1e56P6ZJ40d6rD8i6BcDUPl8SiiarBIgIwjic6A0xtXAa0pWqQ6ebJncRJzR
         ma26oa90lzcytbnC+yXbFXC+l4q26U7yYSkruqsXsBIXlpkYvSpDya23AwO6GvCG6ldw
         FBDfe9zg7QYthDhMNCPEw7crhJhJmF3C4DK45HjgQJEJgHW3EVeGZ8Sg4ZqmAW72y0Dm
         4DidIKoKujUWQw3VLO1We84AZGWDbROueHn63dE7nUavcCBcypyaXrzvBs8X9Rk7r1tF
         yI7CU/6Dc3Po6R4H3GqPjsWKxsP5smPzumAHXgVsvp+NxdteNxK/mPtkcHZ01SmkJq10
         O6AA==
X-Forwarded-Encrypted: i=1; AJvYcCUVSn+3zTQMR8tXwhyvJ/IsaMd4MpZs4jnkUD5X8e04YfSNdrA0/Nr6/ZJh3gntHSB59y8/1TwnPUmwGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62/6SZA/YaKUHGH85jalKxc6tkScbP74x9ino8SbTQSip21+V
	S7GGYyoqZB3cO8+R9ASM2F0wig1+KN96nM4MvWCYmuX4S0OKllQbr0Ml
X-Gm-Gg: ASbGnctG2JNsLXlhZMcFI5JUn/1O9x/vvD2ISmsVeOEl7eiQ8zYZzAYyoiV6P8jvv6o
	sDFTQav+oISHScxQiQk7A+ZjpAm99i7YGzjomM+xnZiUtULlrcf3Icfm5mrqa6dk7G1lX3Jbj43
	Zkuqv9aXA5Web9bJVd9YUmz6789X+3QyWnThvh77oK4+6q5Va2iI7zsDTJ+Wl0ZQHj6mHVl2zpX
	x4FgU38HiRttgAS+cQp2Mj1vUM2NIhXmZW9hx0IXS2+lP9jyqJYF7IzvKGl+jsi447QrwVNBDIp
	BMuu+2IK2UYEsme0bQVFhQWuE6YQ6Tc5uLO0Mb6jLGTuL+9UO1tlXwh3/pHASyFwauZLKA6ji18
	ocSiGmm6vMBJY6lpc
X-Google-Smtp-Source: AGHT+IFuPuP9zPs8W6/sV4OcylbqHrpiozW41O70EnMznZq0UaihiSEaYqW4FvBIRH0yq/WVHcIhdA==
X-Received: by 2002:a05:600c:3554:b0:442:cd13:f15d with SMTP id 5b1f17b1804b1-442fd67197dmr87476655e9.29.1747562503735;
        Sun, 18 May 2025 03:01:43 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd59700asm102934655e9.34.2025.05.18.03.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 03:01:43 -0700 (PDT)
Message-ID: <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
Date: Sun, 18 May 2025 13:01:42 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme/063 failure (tcp transport)
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/05/2025 15:31, Shinichiro Kawasaki wrote:
> Hello all,
>
> Using the kernel v6.15-rc6 and the latest blktests (git hash 613b8377e4d3), I
> observe the test case nvme/063 fails with tcp transport. Kernel reported WARN in
> blk_mq_unquiesce_queue and KASAN sauf in blk_mq_queue_tag_busy_iter [1]. The
> failure is recreated in stable manner on my test nodes.
>
> The test case script had a bug then this failure was not found until the bug get
> fixed. I tried the kernel v6.15-rc1, and observed the same failure symptom. This
> test case cannot be run with the kernel v6.14, since it does not have secure
> concatenation feature.
>
> Actions for fix will be appreciated.

Hannes, did you encounter this?
