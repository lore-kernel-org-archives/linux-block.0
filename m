Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5B311C15
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045641; cv=none; b=H01A69SZonaHrogDP4x1EALA4+u9p1CB9YxHW9aHkv6YnwmXrVTyraiav+mf/c4bxOmw6s/0BsgqeN53N6ONGAUtN964hABUrdEkjTMAo3g1gBXgMTJZh9EBxh4ud04s7p2BOdf1gN1wCl5AoC7PEE/5faqdSRCPEnGvSHkOnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045641; c=relaxed/simple;
	bh=0EdjIRLGhTkdAei/gnQzYeaoFufXtEGL6rx0ZE5SH/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1RPnG3MMckt7zifBdqmLw7vTCXLKExp3G0w+DtRH1WJg8T0bgOIl7DonLLivMvCZMRGEVDgiledcXYfCYcTrioZuoM6KPxmZlYgg+Q7ATI+c+jm9QE60xlPwVUwL+vnD/01bgIkdv75RQ5/fZJauGFNdzTlBL6cdA6+gXaPX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YqmThQg1; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YqmThQg1"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a6cf8242so57242541cf.1
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 10:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772045639; x=1772650439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDsHqNjqRnEeOBRwokyeLeJeShgGfiUeR1CRKm72F5E=;
        b=YqmThQg16capYuuL+Slz5xBulRnKnXGXysPMCR0cj9QiCeCcoyhSNvnbC3jju78Oj5
         YtNYridvH6sjeaK9WwMdNlA6br4fKipTQNGgPzcqDFYJvOQh+2otGFPQzG+6nQAXIiQS
         ItpPs/U5WQI62at0I8X8p846eiVA/euIM9R43Vr4bcVfgRw/99CKK/03Hcq6C7OoohVB
         lBf7zlIkDzz2YGuOA8gjpnbvbdnfbfWcxYfqFy2nV++O1E1By7hBS0Ao3sNO6mO/dOgA
         KNhTTHbrlTTB152+7p+3zg5UKTdljSnJkHrfEnxkFjpY9fFKt36h6onMVfyN9HBJIi9R
         GBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045639; x=1772650439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDsHqNjqRnEeOBRwokyeLeJeShgGfiUeR1CRKm72F5E=;
        b=dnVIohnRpXf7suY/1cKAoi7TRMb6GAA0N9nIWeJhSWI+LDjx6N8PyZsKAG5zgmOdec
         LkKhwgQt+JfVtYn2VpmakrirSFiBnv/i4h0uPwI+fCjqVexWMEUTbSvBZn7Tk2Lcc2UC
         CG18gVWtInDwdf5COojs5daYgrj6MSEkkYqPVSkwj0SOm8V2ucy/UNCAZ9/oRwc4ZRZX
         6euLaumozj7bH4yCoC0rAVR+nDR4fr3ehrm6IMD+9ry9r8o4l4J4zNkJk/F4+6DGFkad
         dYNEb4beDmAe4M5kwrZPm6k+wUYIXecLak/7LcWzN85nXs3Igi7LFQtVnBYsmmoVWmFa
         IKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQneGPzpLyQiZnZjyudL2mGRhYs1UW0BjpfcYoB33bTOLkkQ6eK5NrtQNlRJNJCZYBRDvbBbQqcZno4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6svvlqlE0UJ9DVYZ3nLT2AK7njy2Qygx+ah1n6y3CodikhEi
	HBEXoaYleE96h7VHaOhuwpl92I7B9S5hfcdsIHoybDd7JKXicJEyCe2SxKfMbhV9B+g=
X-Gm-Gg: ATEYQzyiKBRNf1sgGysM1wx+EUMBWiWvFlNSHblEcdV/+9sybiE9k0GjrbgHj2IDIkb
	Ac4K2wqz8bxvvvow1Qlu9bXaxRKKOvGvjMMNhoOnoVC1a4KN2qF4Iv7xmbo9CJWnp2NaKaSlS0H
	4Yoa/f3yAuHf2DZrsLatgTCFKl3KEhYsWvD3EGsByUR3THJ1LEOtA+sbrJcll5bTKBYqW92tGPg
	oPBziFLB1K8NTmWzwhlkegOeevBA62Z8F3+uhdxR/AY9K0gVIxpHfpGpznQ3fUdA8ds26SAooEd
	QYUlVogMxP9ljxezb83PnikWeHxBwJY/HvTeskGwwF8GrjjB4+t5Uq42GYzYhOevJ/gki/LjZ7g
	luvKEff+PeIerDLwD6L+WzhP/L4gyK2cUuNXqCZonCGzqoErwfqmTUoNEFC7A4hoYUtY57CVoQg
	yku2AU8m9BwDPJ3qLzj6fqpge5NDcrEEhID50dt+Cs1IRC+55FgUnvcKVEhCoZuNAXgIKcgy/kY
	WUuJfc7
X-Received: by 2002:ac8:7f13:0:b0:501:467d:17e8 with SMTP id d75a77b69052e-5070bcb310dmr236540001cf.61.1772045638664;
        Wed, 25 Feb 2026 10:53:58 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d50cc3fsm134782481cf.3.2026.02.25.10.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 10:53:58 -0800 (PST)
Message-ID: <43fedaa5-b5b5-4c65-8048-48ffe01e9b15@kernel.dk>
Date: Wed, 25 Feb 2026 11:53:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blkdev: Annotate struct request_queue with
 __counted_by_ptr
To: Bill Wendling <morbo@google.com>, Daniel Wagner <dwagner@suse.de>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
 Gogul Balakrishnan <bgogul@google.com>,
 Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
References: <20260219004940.2594201-1-morbo@google.com>
 <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
 <CAGG=3QXcA7et9LmZ+Cu8zn1yBXrPizL7BhYFvfFZpWA7aUR3xw@mail.gmail.com>
 <e3c0a209-56f7-4ac2-b089-e0600672cf25@flourine.local>
 <CAGG=3QVHKmZzL=C808qnigYDC1jiNSdwCODYdU6_2_yXSLAaSQ@mail.gmail.com>
 <466dd888-0910-4e39-8946-004ac7cd91d5@flourine.local>
 <CAGG=3QW22piyPN6ZCAEiNDHyrRg18OqqyYsy-2s6m2ois=Rorg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGG=3QW22piyPN6ZCAEiNDHyrRg18OqqyYsy-2s6m2ois=Rorg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/25/26 11:26 AM, Bill Wendling wrote:
> On Tue, Feb 24, 2026 at 12:55 AM Daniel Wagner <dwagner@suse.de> wrote:
>>
>> On Mon, Feb 23, 2026 at 02:47:47PM -0800, Bill Wendling wrote:
>>> Okay. I successfully ran the tests you indicated above and they passed.
>>
>> Ah great. Thanks a lot!
>>
>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 
> Daniel,
> 
> Could you please change "Gemini" to "CodeMender" in the patch commit
> message? If you like, I can send a v2.

Not sure how you think this works, but since Daniel isn't the one
applying the patch, not sure how he'd change your patch for you.
Just send a v2 if you want some random name change done in it.

-- 
Jens Axboe

