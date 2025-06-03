Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD61F869F
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976849; cv=none; b=bf/uXQ3qh+Yocy4ZShIgmhaCcraBMqwTA7SlJcigx3magi+vMXU72PXzo+w2aQbompKUq0x7njCVpBLfKeGLhntCFYQnXvj1C9L8boXlbbvwF4biJ36xO7HIO0U+rzvzbSFkR/fP/7JT7+Cae4a5R5H1R0CBitWqBNqL2YJHWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976849; c=relaxed/simple;
	bh=pZ3ZwaLZ209JBKAyGGZ+1AMTMKq5tyl1JysOTnUaYwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M56AKt944GOYdN5X0RxNdrXlxznO3IBfA4jBkHACLawhFdrHbcYzQtM52zn17+s5HlKAoj3k4UEvjFby5l8TN6Db6kF7f1fsErTCG1FU5MruiP3TC6r1klzeeB0Z/MgKS5OzPpjf4xR3wvY1e651uHBiNrZ6vLr7ytT1T85AaOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L9JAeVXj; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L9JAeVXj"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86a52889f45so179160839f.3
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748976846; x=1749581646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFTVfpNUc7fS3zkyfU8Pw6SPmbXFsjp6P3bnLkggN8g=;
        b=L9JAeVXjn72EkRZnHXAuccZJ5KzvNJa0OEYbAG055vEeAeUtX77MbnTE8MYIzPany0
         VQXKC+mHJBlB+amJkyEp9+SkUs3gqRvjU3Bx+z6BBB6oe0eyq8LBhqLrio0xAg8uCLKv
         vpqywKUB7BTzLLPknXhL/A76OA7CrJa1gxG7JCnV8STLy8Kp53PM7vW4xYLbRSsmLvde
         hH2Bv5UEMf3+5N93Lk5QhyZgtxyPMcQJfDx5ZiO2IfAXDEhpVfxAEHhweGhTQOPyDZ1f
         xCBCburqaGgmBaW/5GmJ1z6Qrg4SC+QF8xJuEGczZSK7Yc7wGZH9YlpHmSI7QV5mMd/d
         kUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748976846; x=1749581646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFTVfpNUc7fS3zkyfU8Pw6SPmbXFsjp6P3bnLkggN8g=;
        b=lKlSoEfVQ5Hb0mZ5PO+L3CQvmX2sFy5wm6BP6JwB85+5rW9eR24kDJKcTyz7Cyptmt
         ZgyHCDMWo9M5laODf6Pzpg7i7PwjMXA+rRIh/o/NdAyEFeNtoR3M2/eMTxkXkZFB6FBf
         8N/G1at5iQFO9sQkdmuaLA0PXXaSPUK9WEmTNE/PaW0k/Nb3JJwD3gkd1DMwKUxWNiF7
         NEFJWMZpG3d+Kgbxrp26KHZJ2n4PcHceT3xr7QHYqQzJVp40IagAsTsDOE2MY/uBGiXU
         ESMgVhX2wl8AmVag4Thz5WPakFU+8T2g+E0aOe10yL4zv3gxlK3OHg/2i9NavK+W8qUe
         fMyw==
X-Gm-Message-State: AOJu0Yx7UbNM1zQAAJNdC1AaMRDRVmqmtrbF1g+yWwNKH/GFahTRgJcy
	iQ4hNjkE744+dFYeNecJGop4JTyymrq59qcNh+DMQrH9JmsRYizYs1tGMPUNsCrTIeo=
X-Gm-Gg: ASbGncvfL48P6Di/XdpRCxCKuM8krvRPwQJYyq2jbPOW+Vn21mmUCE5nvDU8zPBiQ5E
	Of6svuc1ufme8W0tR/JpzOus+HZGtZpgT+4AkLmXpXRaG0E5h2AgUPzK9uY667fiGS0Uy0bpZGM
	vjl4X+1jmkkMn6OdVAydrecE9lgi6KSVu+SJaRq6KLoE/vflKyz8uWrksQZztuj6ndHDDuGF20b
	dq5YqmsyiIitTKZrn7jwy2BrWkFRj6woc8Akrwr4M6eJbN/xklyiSr6JVTOMakucPeZ3XDxaXxb
	juOLIur4IFT8KYjhGZg17WNQe4vD10qry/oB0N8tkdvl0ictJ0LgjBhpgA==
X-Google-Smtp-Source: AGHT+IECn8DqhyeKaBwsMXGxtsp+ph0sLr9nbHhU6saT5C/qpcNRBwPNip1vQ6sSIT5fDLxqL4eJJA==
X-Received: by 2002:a05:6602:3787:b0:862:ba37:eb0e with SMTP id ca18e2360f4ac-8731c603be5mr9234739f.12.1748976846303;
        Tue, 03 Jun 2025 11:54:06 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdda4ddf96sm2257313173.95.2025.06.03.11.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 11:54:05 -0700 (PDT)
Message-ID: <e37d8707-8770-4f20-a04a-b77359c5bc32@kernel.dk>
Date: Tue, 3 Jun 2025 12:54:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: flip iter directions in
 blk_rq_integrity_map_user()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603184752.1185676-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250603184752.1185676-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 12:47 PM, Caleb Sander Mateos wrote:
> blk_rq_integrity_map_user() creates the ubuf iter with ITER_DEST for
> write-direction operations and ITER_SOURCE for read-direction ones.
> This is backwards; writes use the user buffer as a source for metadata
> and reads use it as a destination. Switch to the rq_data_dir() helper,
> which maps writes to ITER_SOURCE (WRITE) and reads to ITER_DEST(READ).

Was going to ask "how did this ever work without splats", but looks like
a fairly recent change AND it's for integrity which isn't widely used.
But it does show a gap in testing for sure.

-- 
Jens Axboe
