Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211427128F
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672291; cv=none; b=u518WWeGkPpd4aoPkrT3/lqBn1ZqFxeQxw/z7BU2dZgRPIEsejhc/2orvYE1j/CF83VdO4EeLOyrVTR+JXKCWFcb0Hkjx0qo/D14vFZXWNKW23jQbGDIFL0qAlIJUiRnFs3OjjAoYwzsvCGr5+oKWHbEIRTghKchjgbEeLqP++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672291; c=relaxed/simple;
	bh=bfjAz4eGekgH0B38MohH6kWk2SZ8Q7P2RJox4UBnf38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IS+V0QESqv5ZE6X8d0rzQjozrP2O+R5tfQlDCz371Esed4PBiLisCAb89PTM2zPl4G6d5SFPGvFT5pgUphJwemlm4b6xv1j2SErepE1WWBJo+UqUOE6Qaieu/L5+40vogLdm0cy30A+cHHlnM99FI/QH8OvuhFJ1DxjRadcAKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SIv2iEpG; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SIv2iEpG"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-855d73856f3so81870639f.1
        for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740672288; x=1741277088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lRiyrt8fVejqBJOeerAkOhbzZ3qu4Psgf4opFC293kE=;
        b=SIv2iEpGypcfr1tyxmiCQXrvIkIAFXLa62vuB0Dc5XdjBorVJLPHstO9xvOZ5JWG5I
         osb2ThLXPXF0Rg1EIsBU4nyQr7PokiXoIPU9o9wzTD01fuw1BVcV+WbDKRGna8rhWo9s
         Lcx1aEs8yHJeKHHZg/qLFo6kwV7XXfEZhrQdG+BkG+nKRy4FUUwz1SI2MBQm/Ie46pKm
         +HERWeoWZWUJPdH3mzaUr+1snvJ0LoAnDL4jePpwUkdin3kacQ+bDfUTj6QZWLjtUJXc
         xvRq0UW5E9EmJNVPkXbE2D9q04Gs3jFBKCnjqwV1YL+gF2r99UB0sLQwuQWqpi/mKO5X
         zkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672288; x=1741277088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRiyrt8fVejqBJOeerAkOhbzZ3qu4Psgf4opFC293kE=;
        b=k1L8Fgr9qpOuXX3raULzt/kcFsH0x62iKKmJon/Cb7A+kAXEVm4apHBr5c8l+8L4ur
         2IBLooodFphPt7oWL5+O7uijkQotyvNyCOJ4GzPNvPaZXoFzcEzWFzyoGaryf1s3dArP
         ak7s0S8+9OFvD3OEMlw8a3oUa1jkt8mp0kZU6aRYuO52DWcCIYryVjwh9aL+w40VWO2y
         lQ+8PZDLeUMy2kcKCYjqJW7oYqAlzgwAKUgDekWlBMF8Oe61sZjMCd072xO0YRKtJitu
         Xu3zhWwAgCUvPbQfNhV8Uj0DT0/R5BZUZARqpEQ7kynhMXZwhyQY0yd65uHCQFJA5RfJ
         D9qg==
X-Forwarded-Encrypted: i=1; AJvYcCXlnmRGZ82lB3qhEt8h2TmEXe9dlw/tEZWxHM7ttey55lFqG3MUr0CeeYLrOcZ+ccBN2a2M0k0b3M2suQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx3jOPhWo9+hG2txPsth/a+Nr7gj/WZJrndgTqbwM97GysKYdS
	tMi5NwXerk/f1oTdhsX5frzbKjHeJP4TgJ9oo0cl/7vL4wIWqwHy6lmHVH9QdVA=
X-Gm-Gg: ASbGncsxZ0w0rjohweBNGTCuhFKgYIVdIYV/XYzWGclBTHggL2klfvfQ7FEMM30vFXb
	lbe2X8G5GzWsFO1ZSqlMXhPKSMPxfcj2VshJHLkv56umDcf0N3BqfbW8F9et4EcxsRAoCHDBAKr
	xNdCh7dUZvqcHIyAEnadCX0bX93/KV6edyH5t25jsQdNvT4nMiN6f71CUxrsKK2i1vzyiui0crh
	wGYnWb5MUSrVNbCVkFf6ENipSsobkcAeu9TbgVWDFGHthkRo9wWyS7GOoJmSR0dPJ6m3uF7LK4j
	EZcpRFG7nvKVXaeCex1IVQ==
X-Google-Smtp-Source: AGHT+IGo6x2FH+vlfBxEZ8Tq3JIml3qv+EqIvWjt1EPR7qM5okR5+KJCsrTuyzBX355V5+1VbV5kNQ==
X-Received: by 2002:a05:6602:3cd:b0:855:c32e:7451 with SMTP id ca18e2360f4ac-856203d291bmr1454580939f.14.1740672288224;
        Thu, 27 Feb 2025 08:04:48 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-858753cc685sm35937239f.38.2025.02.27.08.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:04:47 -0800 (PST)
Message-ID: <01ed898e-eb6c-4ffd-8d32-f536a9f6e1bb@kernel.dk>
Date: Thu, 27 Feb 2025 09:04:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 2/6] io_uring: add support for kernel registered bvecs
To: Pavel Begunkov <asml.silence@gmail.com>, Keith Busch <kbusch@meta.com>,
 ming.lei@redhat.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-3-kbusch@meta.com>
 <844f45ac-e36e-4784-9f8d-528b022dff9c@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <844f45ac-e36e-4784-9f8d-528b022dff9c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/25 8:54 AM, Pavel Begunkov wrote:
> On 2/26/25 18:20, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Provide an interface for the kernel to leverage the existing
>> pre-registered buffers that io_uring provides. User space can reference
>> these later to achieve zero-copy IO.
>>
>> User space must register an empty fixed buffer table with io_uring in
>> order for the kernel to make use of it.
> 
> Can you also fail rw.c:loop_rw_iter()? Something like:
> 
> loop_rw_iter() {
>     if ((req->flags & REQ_F_BUF_NODE) &&
>         req->buf_node->buf->release)
>         return -EFAULT;
> }

Good point...


-- 
Jens Axboe

