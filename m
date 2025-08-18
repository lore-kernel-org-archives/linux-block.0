Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BE277036
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544065; cv=none; b=u4XdwQt3FlzKdOa7EAiJVJspPmeYNayHKSsccK4Z8ZxC1S7xfRbfXQ9cDcy4VqATyt/1UV6GXiDzFU4IuCxl1q9HfMU/ptWY96UPt/6ogz10WAGFZDwjzyITSBj9ADiRtZbJExrqoNNTArShD4IN0qnC0ir8JkUXnrtOM/UD/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544065; c=relaxed/simple;
	bh=Ski4TKxNewtrUZds8NDTJNTqJtmxfNhmPkAzaqLMFSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzVUnoSw/XUWddUkrvxpCrlyBeoD+lMcYHwFXyF9GranS7uxS/q2eofO4YqzeSM7SWwN2id0k0MDmHL/LerHqkrNdKC6MQRKi7oIYM+sd3wOq78U9PHhFdt5ooGsHeoIuR2vf/oDE7C6zeuuN/rS9bsi9RPMp1AcLybSOaGdI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s1Pr1IAl; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s1Pr1IAl"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e668360ec7so6216895ab.1
        for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755544062; x=1756148862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGRep3tF7KiNS0qSwtnPInQlsC4SL0Dlef048RIg/sI=;
        b=s1Pr1IAlsKfuNxrzLr/JrOjvJyTQzIJyLgPSPqYIx67L2cu1O8ws3nY3SZ5InU1etV
         J0wM5OK55+jnhxdnuRh7wAmYkGPJkXaFrnL2yw+aIsLY0MaCXRa59qS2HVFvOByMS8mK
         duPm6KoLbkQBUZqpiyB7x2K2SQamyZDqLlzEf8TLDiIwXAtey3IznEtc7jpo7BW07Cb4
         P1Hx1cSz63c4U1XlqeuvsV3JVR1ymt3say/FPNfPmAKwz/MwMOpKBG2Xf9YPYF7hII27
         SqO+KUBWay4uKiYIlK1Es4sl5e1jUpI+hEFR89S8k0WDWO1ZUxpFY8eViuVPxxwGDHQP
         qebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755544062; x=1756148862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGRep3tF7KiNS0qSwtnPInQlsC4SL0Dlef048RIg/sI=;
        b=n44s1Ps412gegbkv767an1G1/D5p/Ub39f/0d2AySyWkoyF8OgdyCvuIqJJdC28pDB
         a+PS/uTdC8q0+zUbckQWxkwzEWBTA7vOvnPFc90MoD5UqufSrqSjO5ZrqCf1a+vK8vae
         sRdgvSednPR+Qs89w3jmlLTb0MvdSCvZH7WoggJhcNmtNT0t+dOqwPA8TkFv6bQynIqL
         1cwc37bRHvNFvJrxBXRPge/+jd3iSpikr5IJ44yKG6AJ+x8u5w9TK3tylgcQc0NFq3GY
         N2VObJ2dmJ9ET6JhLFOhdpok/OQ10ZmtE5vSwQXA13T4U6C/kG/t5N8mkF7b0u46b6vm
         WdYg==
X-Gm-Message-State: AOJu0YySaLLu8A5osp7N7w7PwHex/crEEKS7U5zJKcdl156NoRJo/h8p
	ca5dAxiGg0AUnOj3Aq4MigLpjHylJz/sv5jvcBp4lUgnvSWj+22utHKVkTJhfolLYsusCl+vDlK
	QdRCI
X-Gm-Gg: ASbGncse+2C8BAoImUdrZFfwSSQbNJIlqrodW9WTDOXdb/wkneXfcXB8PrbSEC0jTOK
	r0i6Y3qYW/tDSS7I90MByi5jwHBlLtQ8v92nS9ZvV6z6dFMRLSr+ekzgPZiAgiabeSIFAbLeNWf
	FSAOrWCBb9kf+t/N75k17QIh1Ero/isibgHuQuAzsp1IS19D9nZilPRc2zujDM8rjQiC8ZdsV96
	0Fpg3jww7/0NP4rRjT1H8oLs9aZRzYmRRrsWxYg7xKmKybF0qWTxrW3s9H9ntwh2nWRtF3ILxcu
	W6kPrFEXh+r3VdUGzLJ6uAqkMsLc8htvtV6pV1M98TJVYpu4XuY4w++1/tff5FvpnKdbtoOChsB
	U+ktWyGBmETpw4JyTS4kkFUNji0w5Sg==
X-Google-Smtp-Source: AGHT+IE9tC9UJD6l6NoEtWg3LcOH74IqDydnHLY6xV/kxFHPSmv3CwLQR71mGVEOmsylQw71cEVvNQ==
X-Received: by 2002:a05:6e02:5e02:b0:3e5:42aa:4c37 with SMTP id e9e14a558f8ab-3e674fb039fmr13629545ab.2.1755544062442;
        Mon, 18 Aug 2025 12:07:42 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e6cef44sm36568985ab.48.2025.08.18.12.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 12:07:41 -0700 (PDT)
Message-ID: <a8097b4d-cbae-417b-9608-a3512d66f8d3@kernel.dk>
Date: Mon, 18 Aug 2025 13:07:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fixed commit message
To: Rajeev Mishra <rajeevm@hpe.com>, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818184821.115033-1-rajeevm@hpe.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250818184821.115033-1-rajeevm@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 12:48 PM, Rajeev Mishra wrote:
> fixed the commit message

Still leaves something to be desired - a nit is the line length,
but most in terms of why the change is necessary. At least the
comment in the code explains why this is a needed change, but
the commit message is pretty vague.

I'll fix them up and re-add Yu's review.

-- 
Jens Axboe

