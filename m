Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC91F941
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439852; cv=none; b=r/JgTnmz60o2AEKwuO3HCUMqzzceOGcafNa89NnAveioMhhAaoVHDc6nPq4MfiFWIsOkY77L6tdXjJ0FoZmT9cw6SUA9ui+/3oZZGrhqLSjoj0GJkY3bN1s+sNLX0UaWXKQOeAWNRwPmTsJMjjTa/cAq2yNFB+pmMiOIU8SRKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439852; c=relaxed/simple;
	bh=R/SFmzKMQaClZ6ac3+FS1o2WSMthwJHwexFRGbXqiWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQG/oUdQxdcB6prpkjAlZv93f+a0AffSMNxmZknivSQwlwoqd/1AFwKIDpGU2/qio+Dq9wy0+GGAQnT6JQ0VS6LWjDrdHt4CIo5bpR6N4mk/bYPoWi2TN6lKdONKpGRuJ9YFwTz0lThkpqXSPO3GIw1QwUmlIu+R5mpjclXRuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0+OI89Zb; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0+OI89Zb"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso43934175ab.1
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 15:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740439850; x=1741044650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlabqSiF+gaIVSAaNLOzEjzZt+feYIrttInKlJG4jQc=;
        b=0+OI89ZbbGAb3C9EcwlVF3MMRZ1pR9/duTF3eWvS5TpJk+XumotaxIvfQ1mIRxT6L4
         RC7G6SdBgr+b2ukfMgCNyDsE5/K7CLL0naysH4TfaAL8Xm8pF+K39MlDwkQiRqjlZYpG
         NLSKsFOgv4YDX32uNCOdRH0hk4dk4Zpkx73sV+HSAB5fEaeV7V+tTGlV6rGdYksiALAI
         3PizLOB31ncnjDRIeY+buR3OXxGVLRoJAwCgKwzzFA+ZIolggsKAcSO9j3X5eHy33uch
         9tuz+mWHcPwib93Mu0bScUVx06o5B72FM1MQmOKgfUTeSlZudDzJU8+lHAXIxVCc7/Rb
         guDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439850; x=1741044650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlabqSiF+gaIVSAaNLOzEjzZt+feYIrttInKlJG4jQc=;
        b=m7F7eJdLriHn14K1B3UOME1miysrclIsXk/7ak1vgYQoK5ESbrsRrfZmU/LTUROUEB
         9Q5Myl0Lt6CcJTvbZyrpyky2CygAN8XyTWzUWb77eO1p3u4Wi2Qyp6JObcvLzZtA8BhJ
         eBoM2A3cE3bE9oSyqxWetAZgQnhzdz7xGmbG942UrObIzx9g6ud/CnKmaC8vl8fRAf7L
         i0f5FWZ/3JGWDEha3o2pNRTNFT5zkVNGOMzr5f6c/ibdzE33HZldkqfIvB9IIhDQTImy
         JU3kW8aix2TWXAj8sVh5P/j4Gop3dCP5Q26b+6JiObj1dBmPuKqtfrZ0WhDTaF/3KtVA
         Dshg==
X-Forwarded-Encrypted: i=1; AJvYcCXvQRALv/LpCT5+5ccNP2GcTTC4kz4SZkxp1S0Jh955gStre37f+292Utta6O1Rd75DMmCvQt+fohy+uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHa0ubPhCwfJdpMpoi4xZ3ocZ5lsSNfC6Zd56HKxfL2NYhoG4H
	+hP99bHFFHE+qEGgJfocU7XFe1MNv1wMc/vv+Opkgexqo2LtxKdReWh0XcdCZbU=
X-Gm-Gg: ASbGncsbMa1OuXQv1v3sCde8s5bowdScOXK3xNwxq8ffcv5w0DUrpBJRUeTCWkuwW4D
	SAaiXf9ssiT2X4fsmkwPVTKXcqN6Bowp42EaQ2TWQdL850WFeLp2yndy8rEYtgJ7b9F5GZ8anSN
	wSMBrEBJ0K41ISdLcZKGMf7GbmuusUkjAwejsopFZusw10uIjBp6xcGuBC5zhTU7oays3XcaMf3
	CA3w/EFr+gzNUnPFMQlwTOL2jtpA1evc/P5bzsk62NjDpwpkRDgqBGVC3AlAT9pXM8M1KMcy2P2
	HHa1hr5yCIrZlRFV7c2P24Q=
X-Google-Smtp-Source: AGHT+IHjAdmF70MFm5stdQrkzlR7rmei8bejitg9as7edXpa/8I6sFYvUuMceshIDQ3INEI+4auImg==
X-Received: by 2002:a05:6e02:194b:b0:3d0:10a6:99aa with SMTP id e9e14a558f8ab-3d2cae4e70dmr136608695ab.4.1740439849909;
        Mon, 24 Feb 2025 15:30:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f047530b3bsm125641173.132.2025.02.24.15.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 15:30:49 -0800 (PST)
Message-ID: <54284f45-b597-415a-a954-5ab282747704@kernel.dk>
Date: Mon, 24 Feb 2025 16:30:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 02/11] io_uring/nop: reuse req->buf_index
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 Keith Busch <kbusch@kernel.org>
References: <20250224213116.3509093-1-kbusch@meta.com>
 <20250224213116.3509093-3-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250224213116.3509093-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 2:31 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There is already a field in io_kiocb that can store a registered buffer
> index, use that instead of stashing the value into struct io_nop.

Only reason it was done this way is that ->buf_index is initially the
buffer group ID, and then the buffer ID when a buffer is selected. But I
_think_ we always restore that and hence we don't need to do this
anymore, should be checked. Maybe you already did?

-- 
Jens Axboe
