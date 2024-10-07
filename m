Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EBF1DE3DF
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332662; cv=none; b=bRuLApIcLex3i4xuoOPOTJ7O+TyhfgRs02kDadfnk8JP6gtSmMekl+fFO6eOV36IKq7XSV2LZR/qokAz6hbca3ZOJM4H1xkn+zKh2feJS4Ebju1+5w41vrvDBjYnOvWx0uvXKdWTtbem07f4EHHsIjo1q5Np9LxFwpIvZaSXfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332662; c=relaxed/simple;
	bh=eFrMJn+r7yAiwjP4GWar9qWSolN90tQJqv1zWOC0Hqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4W1nCvVGc/gsyklX2/zzJFG7P+z1vshe+TmrJxlpwuptLZNnHVtVhV/fQYpudWF2lqIAOFsng0zmLbkwX3foWFYuZgvGUlDwbjIW4UTw31u/bWYTyJ3p1VLya/02Mt2R+dW5JADm+oF0Vu1bPpgq2XTHEfhrfN8OlkO69IO0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GTl0fB5f; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GTl0fB5f"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aa6be8457so144254439f.0
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728332661; x=1728937461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4R0Q8Ynq9cXqNLTXGL/5WGAJZrmHnh1RhSna/kYwbMM=;
        b=GTl0fB5fmtyYEwUeAbdsHH2N42MA7ATTdVVacvPNIIwGKoFx1QqOSTWHIw/Z0UixDY
         n277MAdxGOQrZ5cm+n8MyfDf+Lv3jYvp8+BwaArqyY9Ko/qWyKScJKdHY4FtbI4QTnNU
         c96x1gLZNH57cHzc+WdZt7MkgmVJrvWCnkhnm7Lj+jn45bWc79GC6L1yQ7KN3XAjULGD
         KvzZJ5Enu/FVYYF6JmWeixBtrk1n3I4zFhnT8XruQ+cjXNag1pW18jVR3/FuQGKP8l1+
         9Jg82Jr+lG2+CxXE+Hv16V8ajnstgTLNQTcFgpjx37xxjUugBN1ICl7jsUUdlW8I51XX
         vTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332661; x=1728937461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4R0Q8Ynq9cXqNLTXGL/5WGAJZrmHnh1RhSna/kYwbMM=;
        b=Xf4EXOQ2VK9S84zF5pUaiV8jHsPQbEtAEGhpz6Y/SjaLJrUbzBW1DaFrn/iCDpBG/L
         acnOXCoH/tiDZk8u3ojeSl+huCC6kaP+tPrIGX/lYAR8kwOfchXlngb2zqmzkcA/nXnp
         LBOlxKsUwfVNisB1He9BwWxuUImP3beXgKzxB8rX/JPs/AJ0VsmqyZImA20js71Flljm
         7Y4tR2cdcYA/EJKx1gFPIs4Bn4uO5U6YEQ9AO7g7N8hgOGUuxzNU8+ErX2/xgexOqm0h
         3OdMKns9sWvIkgbD/grRXEmoLd2mO77T1MY/jz3S2gtv9CyrK7jBPDy7hIjqbKgpTyfn
         t7gw==
X-Gm-Message-State: AOJu0YycvOLr83tMYdf5umjntvCgZ10fJ/zldKyIoio9fUoXEQzJlwWO
	QdqzZ3sv2CGZR4awW92H0F9jQBtLV1Io4lWJrl8i5lDEitvrlhyj2X+1P86kP3g=
X-Google-Smtp-Source: AGHT+IFTl0KjXyZKmlEYggh1fWpAGTxmbvzWf6VhNC9Im+t89F1PTG+ih+zXKZ95AnSreaFzI8qpJg==
X-Received: by 2002:a5d:87d9:0:b0:831:e9eb:dea7 with SMTP id ca18e2360f4ac-8352cf7fdf7mr69497839f.8.1728332660762;
        Mon, 07 Oct 2024 13:24:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db93964253sm118966173.55.2024.10.07.13.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 13:24:20 -0700 (PDT)
Message-ID: <4c310f0e-b677-4731-b827-df14b197545a@kernel.dk>
Date: Mon, 7 Oct 2024 14:24:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: Fix elevator_get_default() to check for null
 q->tag_set
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 hch@infradead.org
References: <20241004123922.35834-1-surajsonawane0215@gmail.com>
 <20241007111416.13814-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007111416.13814-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 5:14 AM, SurajSonawane2415 wrote:
> Fix error "block/elevator.c:569 elevator_get_default() error:
> we previously assumed 'q->tag_set' could be null (see line 565)".
> Since 'q->tag_set' cannot be NULL for blk-mq queues,
> remove the unnecessary check in both `elevator_get_default`
> and `elv_support_iosched`. This simplifies the logic and
> ensures correct assumptions about 'q->tag_set' in blk-mq queues.

For future patches:

1) Wrap at 72 characters, your commit message is using shorter line
   lengths.

2) Don't both with file numbers, they change all of the time. Digging
   out an old commit with line numbers isn't very useful, you'd have to
   rewind your tree for them to make sense.

I'll commit this, but rewrite the commit message somewhat.

-- 
Jens Axboe
