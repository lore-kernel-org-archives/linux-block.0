Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CBB25D20B
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754586; cv=none; b=I8EmiQGrAPdfVU+jxPpJVXlTxoLPQqXHt6isYoGzeqAMvnMO22ifGvoBwzfJSBeqHTrUkVI5+9wQsOEPGmklmRYXtbEX7uWrrKucnK3F9Su7kj0LW5w2DbuuirGwbMP0/Mbra2qSo9qXbuiFuoJByFJh1Ai1sBhMiWsGtcUTk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754586; c=relaxed/simple;
	bh=vEbcuXQwEDRa0vNR50YOWWWtdFUeo4T8qpaWJJxDqHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NonZNREV+9pqinoGBWYyePtCltTon6p9ZUEE8LuNzyw9qPBA4q7RFF7QlCs0pYe69Tke0cmBM4ps+qT9YAp38bwhFAJ5evmUg6jwdZTLYPhsVz/jphL+RT/vhd8GM+hDT/uPOElReZWo/mjAxgLRmXI+khVf+LX68/EXm2uCRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m9dxw+Aq; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m9dxw+Aq"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3db87b9605bso37622665ab.3
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747754583; x=1748359383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psPdOjdWIgtZdlDW5hj2GFX8fZ81Dk7SDN2MaI3x7nw=;
        b=m9dxw+AqDQ+1rWgodAGFWnhuFaKSCIgi5ZydGaW52KKeWbLHBVKN5J79xHekkhN5uO
         WJei/NE5ldeBweYaP+bnT5llbDOj7a+pQPJTi+IgEbQ5Od+1/K2Dkmhm9dLz+HI/G7d2
         rkH/Fhzb/48Sh/2r5tFFoJo63I7Y9fV5z/y6gRXClhC1VZj4dLYYc96o9jduLxDM0D4c
         ZjxXt8Ty/oei0KrLVfQHFSEuZljFE7vrHD6gwkPc23UyLRZ9MWk9Vac67r7oQIn+x121
         TUi9xpLdBihCEhB2r3RJyfsQzO7U3wAw9EGRijgGbbnG5M6IYD5TOz53jUUymEflYwNu
         9nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754583; x=1748359383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psPdOjdWIgtZdlDW5hj2GFX8fZ81Dk7SDN2MaI3x7nw=;
        b=Jy5GijmWzGs/kkxC8mHz0Z1KG2axLaRZoxTv6vDgCZWdrBCp9DZGijd+DNONE5YhL3
         5Y/ddcvl+jI4Ii7al56uo7pxXDEjiRyBdm6J4rxqg9p6oLGEsqDlqchscnJuo3tYTQRv
         uirCFV1mWOslov0W+ogGVyjCJz/hzAierksaGWxBSEpzBk89UM+c7aeEAeMR671mX3A8
         JVS5eVi55t39Y4Vaf+/GoVE22x7oGQ9JZlogtBvkNXG+Kwsav5VxMa/6faw+exVY4Pqm
         MxYWqKCKjySz8Nm9vt1bI3wQ2opBD3YfDZtJmfxAOeEQ+q+lDapj5zSU+mExmSVkCdPH
         hwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ijwMvLzj5ZIXYskTK4IGCDmjdcjvVoAhYZvUoN8DxB5PxgRMeZz9tUcCmOeq5mEr7z4PQpNNjJf60Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVH4MRfZ0+cBjq60rPW8kzIr6O6NiQG2QQtqq/Ans25LuffaR
	IguQvjxb1AgH4OX4kEyqw1Cs4k5iNQ/NCHKD4zZ2vqF/ooSevu9ImYwmp23dbQUbnv4=
X-Gm-Gg: ASbGnctYYnLYiOdgx4DPLoabCDiY8cSOabzN6KqS9ejctWUH9fXaP3CyBmHsl2kVmy/
	JjyJ55y8fA8Q14Y+Bsjprs941dIdxSjsKaFiMKu4IGDHYGRkYKuL6nx+rI1WM/QU6yuY4SbpymW
	SnX2PP/kcXOBhWHPn+VcgUdW61uTf5Gz65taYeKg0firG8h17hIMQci7I/4dzuDa4i1R1wlXHbZ
	PnudhmTSPO8nMQ0mkFoj68vvaJSSM62H9W+hccsWeAzCD2MXpg5N3v2KtS3wYoCziMSUFVtQ16q
	O/zGiqHImSXeEGJeVdqUBGnh8lzdJjlSt5IjxtOE4JKFxz7OaJo7Ao3QqQ==
X-Google-Smtp-Source: AGHT+IH5FiH5hdeBYNYfGJRWZ52DOo6I2S1qMZg7FuTAuJBXr6A1ts8mPNDcFL0CI9GiyXU3YCIgRA==
X-Received: by 2002:a05:6e02:12cf:b0:3da:7cb7:79c with SMTP id e9e14a558f8ab-3db842dea53mr165651365ab.13.1747754583546;
        Tue, 20 May 2025 08:23:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a556sm2268664173.3.2025.05.20.08.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:23:02 -0700 (PDT)
Message-ID: <72139ccf-892d-40e3-8870-2dff0e30ecd9@kernel.dk>
Date: Tue, 20 May 2025 09:23:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.y regression] loosetup: failed to set up loop device:
 Invalid argument after 184b147b9f7f ("loop: Add sanity check for
 read/write_iter")
To: Salvatore Bonaccorso <carnil@debian.org>,
 Roland Clobus <rclobus@rclobus.nl>, Lizhi Xu <lizhi.xu@windriver.com>,
 Christoph Hellwig <hch@lst.de>
Cc: 1106070@bugs.debian.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <3a333f27-6810-4313-8910-485df652e897@rclobus.nl>
 <aCwZy6leWNvr7EMd@eldamar.lan>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aCwZy6leWNvr7EMd@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fixed here:

https://git.kernel.dk/cgit/linux/commit/?h=block-6.15&id=355341e4359b2d5edf0ed5e117f7e9e7a0a5dac0

and will land upstream this week.

-- 
Jens Axboe

