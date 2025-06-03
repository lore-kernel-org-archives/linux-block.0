Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1591B85C5
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994947; cv=none; b=rL0By8YCXa1lMGYy4sAV9j+2bYkIK4GqtSVWqJ0g4YyAhaxEW4PSGpnYCBQNH70mHlY771kAbwi8Aq4NEIQo25rdiejSpXpCu8K4J03pwU0VS3lDoa4F7gY5S4VFrf4lAqDB/rTRGi6xjvTugdQMI08jD23luaseXav0q/goYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994947; c=relaxed/simple;
	bh=PdPAtlQv5A9CwmTbNINwENGHvMxU12xV6f481PqLn1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gW4edJZ9KaHpPLdNfuinkpuGavewZfi4+1qZFcpnXSyj6ufaAjtQceuYTGPkZ4xdvkS75izznumFLlr+h23dDTwY7oWk/QxfkryLAcMkeU6XybNJWZRQbmgk1qyONCa0oDv0Qf2dFXx3VYpE2V1/4gFq+YDqp2nMUJOk0LRQDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GxgAR84C; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GxgAR84C"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86cdf8349ecso147970339f.2
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 16:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748994944; x=1749599744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0hfwFiTxGC9FvQWGx2emEBLXL8EUZXElvhCJdQUIYM=;
        b=GxgAR84Ce1TWdhkleqbWYNzNshntHnkt7+Fcoi9klK2VNOnrwNPuNa5AkIRZUT99jX
         fFrfvgaWi2kU149MJz8UcikGseLjBpaitsyirEsvpzUIbdWt11XvjS9icYpchN3zm6WH
         uV+V6Q5cfd6uqVkebMzhZ+9HlX8+qBHRH/WxatnfNxsLoBDxn13CNw1RcBW1nQUCXywO
         DBxPriH4I6x2j9XlrUn8pR+/6nsZLw6FFRce4b+kWDXRVE6lJ5Mekf+lXjOZbhepVjH5
         XNrKMvghxj7j0G1lSIBR3Hi0b5sUepuWSLcQ4cfCufUWogD6AwA0hglXx78F/SYzkHiy
         qGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748994944; x=1749599744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0hfwFiTxGC9FvQWGx2emEBLXL8EUZXElvhCJdQUIYM=;
        b=wi52/aqxZh/vkWtkvfKBnPzSsfjQwbcj619HqVJjfBVnBWgbxYquQLnc/gk4hxZSfz
         SPOkYqE6fcTyO4tj0P2gL5Sk9FfdtGoeU2QaT2rYmoVAQvlmGkRvirtIw5KQfPhQboeK
         3W2+SOAVskm+XaKHp8uMkqPh8V9F8FxCm9xFYASELAIo5dR/B9Qi3dIf46bXzGb1B8MW
         Z3T8AaJd7bSWkY0YP7VZocXCACc07pN4fNOBeiQ+W2wvZl7vUM7TXRkNcA8sSsnrObzG
         cYlI9mVSqHgOEdbvLMvSWSVIuUHIG3Fw2U958OXpNcgsz4yC5ChAEGJoNi+02VrkaKaL
         g0nw==
X-Forwarded-Encrypted: i=1; AJvYcCU2TiXHj71secOHcAJj0ol2vIlMm0q7NPYm+j8RTgwmeOWC2lnUEVp176BLibIZWXLnZKTiMznYIczb8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YydBUMqF3pWIw4x0r6Qg6m8hcsWxkX/XZ8Vja2MT9bkhl1UUJWZ
	YTxQwjLfdZ+/FWUbA2ESIrn2njH1ZG0wrrzYYSU3psZcYSrv6v5ITZygGwoUPNfyclc=
X-Gm-Gg: ASbGncvr1fTtmdyjguCqrTqr2xXemke3Vy/cgQuP8RNuw0KCjXyeFGUXx51+KgMlTLt
	jaOhpEKlT1pWOJac2tHKEur/MVsJ1Xj5FzXO0pCSCBCAKXipYuSUQAdNE+zNK8jdfTqwyo3hjEu
	T/C2c7U7K7XJQt/eKT04pFpUVQ4kaZTy1mPs/YkpOcXyxFQSYX2tXimtvBK6ejy8kVuuSXd5dYH
	yqhu+4TgCdCyRN+5O4sX5nV5hJ0XRFmX1bv8Hb9qme3M2bDl3KbyMdYJet4RyAE+eiHLB7TJKNk
	JiwVWaQsoY3z+xMfhrymiEiZu2srEinJAgeQqNhxUdo23479
X-Google-Smtp-Source: AGHT+IE6enUA3M4NjhT0Pw4L3o/qCazMTjOaTWGKxET/BY5Vf16s0wPirWMqfzr6RYL2VgBafuZeGg==
X-Received: by 2002:a05:6602:c8b:b0:873:1ad3:e353 with SMTP id ca18e2360f4ac-8731c5d244bmr101155939f.9.1748994944246;
        Tue, 03 Jun 2025 16:55:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7f22014sm2493485173.136.2025.06.03.16.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 16:55:43 -0700 (PDT)
Message-ID: <5fb5cd79-6744-4d9e-aac7-c0b363ec8cbc@kernel.dk>
Date: Tue, 3 Jun 2025 17:55:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: flip iter directions in
 blk_rq_integrity_map_user()
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603184752.1185676-1-csander@purestorage.com>
 <e37d8707-8770-4f20-a04a-b77359c5bc32@kernel.dk>
 <aD-J9mzq_bJe26rD@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aD-J9mzq_bJe26rD@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 5:49 PM, Keith Busch wrote:
> On Tue, Jun 03, 2025 at 12:54:05PM -0600, Jens Axboe wrote:
>> On 6/3/25 12:47 PM, Caleb Sander Mateos wrote:
>>> blk_rq_integrity_map_user() creates the ubuf iter with ITER_DEST for
>>> write-direction operations and ITER_SOURCE for read-direction ones.
>>> This is backwards; writes use the user buffer as a source for metadata
>>> and reads use it as a destination. Switch to the rq_data_dir() helper,
>>> which maps writes to ITER_SOURCE (WRITE) and reads to ITER_DEST(READ).
>>
>> Was going to ask "how did this ever work without splats", but looks like
>> a fairly recent change AND it's for integrity which isn't widely used.
>> But it does show a gap in testing for sure.
> 
> The change is good and correct, but it doesn't look like normal tests
> would find a problem here. The iter direction in this path only adds the
> FOLL_WRITE flag, which appears to just check for writable access. Unless
> you're specifically testing something using read-only PTE's, a test
> wouldn't have triggered an early error. ?

Ah I missed that - yeah no way we would've spotted this one other than
under really funky configurations/setups.

-- 
Jens Axboe

