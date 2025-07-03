Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C019D8AC
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557383; cv=none; b=eSGh6DHgEpbDbMi1P2bOfqvomTLUK+owUr5xhw+8FIZhSUBrPvJeMx1ocrP01hI+BsgvU8b08Ex+C5rbO8Ni6YQVDaDHE58tmVVzbVGLqQoXvkFFQ3I8aiP89lihxZwI01arV8XnOI3dbHZ/M24fG9meRZQGkWB3lKT07p3U/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557383; c=relaxed/simple;
	bh=O8+ZwGnbF62T06Z6++cFMWlyMygPvK77YOYDM+ch8dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8HeveBFX4U73Rex7Hol1Col7a2LiRWvzWaP1b4mainHKQN2vEY7JGLvdnwUkoVyxkm2Z6FZlgWNsa59QuU6gAU9pI2QOJIBG6Ky5F4MsNYG/8rlVEe7dIVHFhmtgx3Cd5fjrKfySiobQ6zNPR5ce4QyWSpf8t7xSDU6HDn70J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mbX1/nSt; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mbX1/nSt"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso514345ab.0
        for <linux-block@vger.kernel.org>; Thu, 03 Jul 2025 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751557378; x=1752162178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUdIcOI06WIcUUhPkMpxJUvRFyK/KzBRoJLe1YIWZus=;
        b=mbX1/nSt+KgrKo1uRx3CI0nD/mS23x1Ks4+GWUi3kagBK6TVPZZADEU0drlh2DhK/N
         22AAhf54ho9s5H01L/egpBw5N/OsnlnGN/A3TCiSWe19V6JUxX3vzy0qC/Lu0cZjvfqS
         BeNG3MjLGMkjQJ6WHR9z3+CjsHEq1YU26krh4l9VNesUcTSnawLs89wD7imR4jaHbUHC
         R3YgAyVathH5Lg0Dzct31WjTmdrkjtdfkI54awa3LtgN8x9diwUWNlg0TVrXZpIkQD7h
         yRJ33BsOttxcXROJ22+huEJQ86rpvJqbDjB5WP0SJoUC1BpGz13rwyySOoW2poMHWByA
         ZqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751557378; x=1752162178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUdIcOI06WIcUUhPkMpxJUvRFyK/KzBRoJLe1YIWZus=;
        b=wS9quD30PQl3lePXZJKu7MVn6qnyRDGPlLowgii/lp2jtHJVs1LW7XlGYY0FeTrcjC
         rRaoBEa+G/PAj6mMjVm56duSj3PO/rYy9sPmBjn9eh/Ft6jcCUh2UwuXnhdmTbvScOuY
         mXrZGfglokYnptoTem0xCqgJcpY8aAc+bJf/jCdmDR99dGykJzYRYZFfvQ8gWXwke9Ib
         MJeJQOx1WswJdtUsUxkP2hvJZ3NndTVU5vYZ+ForhuziBJX5S3q1XaRwGga798eNnCzT
         GFECEBdTlNnH9uhAwtIIVnCb6xzu4+YQRRzLXRw8j+xqZ4j2N5BfUbRAU1idKnLYjg+K
         Ew0A==
X-Gm-Message-State: AOJu0YzjKe8PGr8SULJMIzRuxHjPa7blDpdr4v5xHdsOFciZxNc3QRgi
	ZfKGZxQuh0fbpWx6gLng0tWTbMr4SKRrQteT4rHta7sKf9e5GpG/q6e2usZkeHe71Zw=
X-Gm-Gg: ASbGncuth5hoIlxSglZBojmXCLlS2NwkCpnNFtSkbtWrHiZF4PEQv8IytDf1cAlKyTO
	oHwfZbf49BmTH7PlOXyYVUTJGMqfT5/QQj5BtzVpvMj9zJ+DisIgpyt6IIy5GWVwycYX9HpTcbl
	xr8xEPQto2R8J+IumkatdBMTR35tBqxk0XZFNpoqk7JDH7B6l3TLSmkPJSlNWDIqxAcS84/zMjl
	+cBAivF4yPGsy8Hx5nC03SQYxzBD1sClJmiFqrHU3WUGqPyiy8VMsKvmwKTl2fvJnXMFs3xUica
	K0SHFyMZGjZXomRXjl5N7pGZ7+BNibv4l71mhZdohWyS8m2WxTrpGB9i6g==
X-Google-Smtp-Source: AGHT+IH+T+gmi1h401kOm7Z/YrnSwqdLG8+PwSpem/9GQovNq7iXvi2qRBVRYbs/e9ZwB/RBQ6Nqow==
X-Received: by 2002:a05:6e02:1fe6:b0:3dd:b808:be68 with SMTP id e9e14a558f8ab-3e05c9b4c23mr39626035ab.16.1751557378080;
        Thu, 03 Jul 2025 08:42:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e0f9b7bf01sm307635ab.5.2025.07.03.08.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 08:42:57 -0700 (PDT)
Message-ID: <c88dede7-9654-43e6-bb04-47d948e7cfaf@kernel.dk>
Date: Thu, 3 Jul 2025 09:42:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.16
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aGZuyPbzY__Rb8Kz@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aGZuyPbzY__Rb8Kz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 5:51 AM, Christoph Hellwig wrote:
> The following changes since commit c007062188d8e402c294117db53a24b2bed2b83f:
> 
>   block: fix false warning in bdev_count_inflight_rw() (2025-06-26 07:34:11 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.16-2025-07-03
> 
> for you to fetch changes up to d6811074203b13f715ce2480ac64c5b1c773f2a5:
> 
>   nvme-multipath: fix suspicious RCU usage warning (2025-07-01 08:17:02 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.16
> 
>  - fix incorrect cdw15 value in passthru error logging (Alok Tiwari)
>  - fix memory leak of bio integrity in nvmet (Dmitry Bogdanov)
>  - refresh visible attrs after being checked (Eugen Hristev)
>  - fix suspicious RCU usage warning in the multipath code (Geliang Tang)
>  - correctly account for namespace head reference counter (Nilay Shroff)

Pulled, thanks.

-- 
Jens Axboe

