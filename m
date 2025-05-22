Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5728DB45
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927580; cv=none; b=oCwkqzSJlPqsyyMUXortYpP2XzWTiCdRrUwLoxpYlEM2BlcZuDXomqH8fy3wTBz4Ut62+SHeXLSebZuAncmw0jiHYlH7xDfjHv9+L1T0QGg6xF6St7SPlb9tzZtRLjgRp4PNKHlEXUayHDwQ1RgqUS7BALnMN7MrkZNPKf9eSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927580; c=relaxed/simple;
	bh=vGDZhZwllxe4VD983RCC2tiGN0K4ADXxO7QCHyFUze4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFaHd0umYphi6W+NnCGto84vPIOgm6nA/ibOlkvnPiQ0R6XTuDJluYaA3uUO7lOj/bBzai2Ria8vb/QywTLiKDkhJM8U0d/TvqjO/8qQA2Qxx5NitTNUZtnUNbqpVVFdB4F2y8ZlZRdSunmgQZ24HDmLvj+/UeerzIy20Qarvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TNbNmYbS; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TNbNmYbS"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so48470255ab.1
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747927577; x=1748532377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx0n5h1cqvuf4X6qJjMPK63d2ae4U83l+nIOQxouVe8=;
        b=TNbNmYbSlswL5vKrNkKRKLw5kPIhxNXgIbiFwiENJNZwfccd8KeY9rHyYR2AJTGbRU
         UtavaOTjk66sOflu+jnWVsHX1zXtEYlV4YlVnMJZQLg9nd2+YxC4qkYenIkkghyrPYob
         ZYMZ+OFGD/C9yVlQIxrmmqPCIA/6oU2VBEZ+k6/KJTJnnh7onjvLvvCYeqvBOU6EKKGP
         Xm10FSTDxuPKuKWZkCwLZ1H8x6SuDmeqSZcnoQ957hRGQYnz5wzTwqpx6chhZp+Y7hwb
         TQBBnNbh/602mOX9XsgthaqRBj0j8Odi8djNFeLa+XbzWMNp6Yz7wXpB/ANQlJudmHbi
         k+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747927577; x=1748532377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lx0n5h1cqvuf4X6qJjMPK63d2ae4U83l+nIOQxouVe8=;
        b=IPmv7lDj6uUcKBLeHSgy2ncAAsUrxCYJgFoPetSCiA+E1BO+opqk+Iy+kRCtsjhioq
         lNOJ7to8PM2YflBHylPiNoEHSZG85U1ZSDI6Q6nORfcuGirUsdZ8z3Tm+SpmVhijcNR/
         MKI6L5/RW1Tw8/ZgpWXOFpWbUKFxAgh9lpu5k8ebMcoL5Rz0234TZ45vhgnk1M/+1SsC
         B47ulilwsu284QcKoRCH44fdQ62LSKa/9ZbeteJQrLu7Hlwvy4nD5CJzRy5XGP/P6OpO
         L8chgmTG7mXX8H1JMOamo5iXCPe3zrTGFv+aLgwOfQtHwyNypMEoumINlhY17XMcq6aV
         KNxA==
X-Gm-Message-State: AOJu0YzwqM+BPP0vvpudNjY2Yu16EN0058K7aT6eh7IycZQteUL2197A
	j2wkseI9KBh2I2H6dmv0IX9l9NAqymD8x8Onpyx/1C/eaQqtHjrOfv1e0dbIcNsBqDg=
X-Gm-Gg: ASbGncvhhdiX59pkxDdCCdDIJqCVWt5B3/4KhvO0zt3Ah6C6u1UGTxk51hFUj9TQAyK
	1miohO+Yq/woJhniRiAK4uV0u0HbWn2k2kQE5sOhbwYJ2vHdvkYoLS/wQUKB9bTKu2rUOPWgfPx
	K9IOJ6ag98OQW+7fyJcAtOqRjjXD7nEhmRTQh+sqvZ0CCtZzPabHkXNMxEYPE3zWO5SZvVUEgTY
	97Wkg+ia/OFyyfIPV6Ge+BvcEvgAI65SroHApCUXer3nstjiIZeVD+aSsDFG+GaPGJ+f9m35tMr
	yPGa/c0xi8zIfn2U4lqrqGM8E2oKTpruYHBs1GwUMa0V8fo=
X-Google-Smtp-Source: AGHT+IGzhOWXribK1IbycI+KBAw+QEv9gxomT+pM+E+BLOeT4eMJipexX7wJd2Mj6jucYgz00SXFkw==
X-Received: by 2002:a05:6e02:188d:b0:3dc:7c5d:6372 with SMTP id e9e14a558f8ab-3dc7c5d6637mr117988265ab.7.1747927577052;
        Thu, 22 May 2025 08:26:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8ad89ecfsm5835255ab.26.2025.05.22.08.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 08:26:16 -0700 (PDT)
Message-ID: <cc3d3809-cb13-4800-8b67-2bb42587dca8@kernel.dk>
Date: Thu, 22 May 2025 09:26:15 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BGIT_PULL=5D_nvme_f=D1=96x_for_Linux_6=2E15?=
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aC8x5G4RUjgbAoAc@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aC8x5G4RUjgbAoAc@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 8:17 AM, Christoph Hellwig wrote:
> The following changes since commit 355341e4359b2d5edf0ed5e117f7e9e7a0a5dac0:
> 
>   loop: don't require ->write_iter for writable files in loop_configure (2025-05-20 09:16:23 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-22
> 
> for you to fetch changes up to 49b9f86a594a5403641e6e60508788a7310fd293:
> 
>   nvme: avoid creating multipath sysfs group under namespace path devices (2025-05-21 14:55:46 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.15
> 
>  - do not create the newly added multipath sysfs group for
>    non-multipath nodes (Nilay Shroff)

Pulled, thanks.

-- 
Jens Axboe

