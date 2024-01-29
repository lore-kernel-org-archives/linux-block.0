Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A833F9E0
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551727; cv=none; b=ko7Fs7fdNG/UGnMUTqWPAuXzhwvI0BehFxejCerW9oIsWkf8Apyp0/ImeGsUI80zjIc/QgyWGzRQLD/Jw+8D7vmJyOUHL4Rf31aJKSdubiLY/iXbhMfvQwnPDuR42sr+EmswyEjuRU0CSSGxRkeg+T4EAN2In3mAh8F3wHtrnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551727; c=relaxed/simple;
	bh=RTsZO6M5NcQC5PSLsg7Lt9twSdXgN7IEDDrtjnJDfEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjcGGf5HOcSOCjJR4HM+UsJMACKdMINu2AjoiD3L95UU/ZazwuoUQEwCSTnAedO9HEI7ytMRq60jcBwEoEPVrHJdnDs0Pzc4FRrmtjIqB76nh/CGc9/7GR+EJ9r5+PSr6/nckdf7vjmLOaATPqewN8qVCHsJdF/9LfIg8D78tII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnztSMEp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnztSMEp"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33af2823edbso569705f8f.0
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706551724; x=1707156524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYAvQ7VsTVTnkYy4EIaJk+5ZEg4vidmMfkjz6PX3l1g=;
        b=AnztSMEpjdkMsyBtwA4/yknp3UIDGWk9CAB8IPcH7DClqdRNYdTbBzMaZdmUlf67aQ
         VCwFp13AW3wwV0Pl3gNhVFNds+VsItSkdnY5KHxWGpkk6iz47LWO/HE0YWEickbEIXOF
         AiDbm5dj+l8RTgHAEI+Hf260rKNowxJw0ax22ZWdRGlRdTovfhdMHuk+2RYa+xPcKy7a
         mSSmMtjkO6CV2F5/vSuL8Py18TobCWAaQdVhKtWvAPtKwnZbot1TzjcolkFO7g7ofCbo
         GuRjUTrr5Lzx3IUurtlcqK/t+POOVugafheExd8HFmcvTJ4RS64VZ3WIInrjiDcyyokI
         OFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551724; x=1707156524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYAvQ7VsTVTnkYy4EIaJk+5ZEg4vidmMfkjz6PX3l1g=;
        b=BgN9AcOrg3IQ2jw+G4c14ucDsIcNXcq6WZn6zzQmPEVBGsCeDp3zZqS/Iue49dNawe
         ATGYsQsKsNREetzOcJdth/8CZvdZKJZQJoY7LwyS51yKh/xKCA4UX2CFHYUTyvzfD9e+
         eTG/XMUy/n+Sg6KMDDAraQWRsC9z1RxdXsz+7DtTjiErvejf5tf6x2pJeFl4CE2Lj3gl
         KV8PRsKhZnmMe4VDsbZ6bK6589lT3SXFDJRrEz2um19DUJL8tX5dyhRIoGagKW1xYjPA
         AZLk+93IvjckZP9dq0FdS9UK8YGAt3vQc9AiI62IygojJGShu0w3v5roU24vbb39PmHx
         Yz/Q==
X-Gm-Message-State: AOJu0Yx48ftZ0ncQN9UYmERPrNLNWUbQdwQJ8zgcF8svBzyq25LYTeh7
	CLRq4lhfOq95geA9zXOUcFVGxhTsgazk+blXDCzj3vX6wbw/x8CP
X-Google-Smtp-Source: AGHT+IFswGN297cme87mCijJCItXEFQgR7CqZ0Nkjtsr1fhfCmJO8f/trDjX4MojirSp1lsSgX4SDQ==
X-Received: by 2002:a05:6000:1849:b0:33a:ee10:cb87 with SMTP id c9-20020a056000184900b0033aee10cb87mr3080112wri.53.1706551724210;
        Mon, 29 Jan 2024 10:08:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX3kEJL+KAfuCjgQa3ZljCqzNGOEEl+kXhQtLTDb437XLP9WSa24Pc6iIgwiPWeB8C+trQycPTJB5WUSUF6boY=
Received: from [192.168.8.100] ([148.252.128.211])
        by smtp.gmail.com with ESMTPSA id bw11-20020a0560001f8b00b00337af95c1d2sm1563900wrb.14.2024.01.29.10.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 10:08:44 -0800 (PST)
Message-ID: <5336cae7-05a6-40b6-b8c6-7586b741bea7@gmail.com>
Date: Mon, 29 Jan 2024 18:00:28 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: optimise in irq bio put caching
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <dc78cadc0a057509dfb0f7fb2ce31affaefeb0c7.1705627291.git.asml.silence@gmail.com>
 <ef594ed3-e9b2-46de-a729-b0de03b92c28@gmail.com>
 <ZbffN7htVJQvSsZI@infradead.org>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZbffN7htVJQvSsZI@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 17:24, Christoph Hellwig wrote:
> On Mon, Jan 29, 2024 at 02:36:57PM +0000, Pavel Begunkov wrote:
>> Let me know if there are any concerns with the patch
> 
> This seems to lose the case where non-polled bios are freed
> form process context, which can be true with threadead interrupts
> or various block remappers that defer I/O completions to workqueues,
> and also a lot of file systems (but currentl the alloc cache isn't
> used by file systems).

For the task context I can generalise the poll branch

if (in_task()) { // previously if (REQ_POLLED)
	// ->free_list;
} else if (in_hardirq()) {
	// ->free_list_irq;
} else {
	bio_free();
}

> Also jumping backward for non-loop code flow is a nasty pattern.

How come considering it's jumping to a return? I can switch
the bio_free() and goto blocks so it's a jump forward, if
that's a preference

-- 
Pavel Begunkov
