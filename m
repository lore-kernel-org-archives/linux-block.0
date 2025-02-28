Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44E26E63B
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753156; cv=none; b=rK48kATvMT62MR7LiIEqFFcpwy7RQvmp/WIXov6Ko0mWJ9t6pPF1Ix6TuD5UXcgXBosyZj+UUzU+uM9GAN+M+ggFygAVK5KhmXEwUK60GamEKPG8aPbGsJn7aWbPTN40OXSk5AoNfQh5O7G9g7NJj/bL3lVp3cxXm136ngf8cCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753156; c=relaxed/simple;
	bh=Aq2YEvROgO5wDWpNoNmRLhkF2AxDcSNTTaQ9f+/z944=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKdTN2x+8riJAnv7cwnNuOeOf/n7pqo1KdX4xkDrzjvnsoJq/NRRorttKf5nDQaH4T8eRcYGvNmDezXMCTdpx6wpyXxBZdmkkjaXzDo3vj/fw7qwtVRKMpKXSeZcShcxz/NA1VkWawrn/5vpeenZo9BfemUVSts3fo4ke+fdlXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iW3MAuGp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iW3MAuGp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740753154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R6l/UTEHr16aTvE/goZAsKRxku8bACld7IrFKN7albE=;
	b=iW3MAuGpApsMXWc4EtFTZgGw8f+1FLACjDs2Pru0sh+fcPPI7a9TQ9/D0G2s1WqDLSgy81
	gup0EtF85DbznRgB3LOuII4iSqfa2DuYH3s9bXrsmqoN2OuxSADBPbJq0PmLQyINobutCC
	p4Ub8HIf/ldxE+zwmYGInEcOTAVn/Ns=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-XImtLwu6PfGAwmK03fDohA-1; Fri, 28 Feb 2025 09:32:32 -0500
X-MC-Unique: XImtLwu6PfGAwmK03fDohA-1
X-Mimecast-MFC-AGG-ID: XImtLwu6PfGAwmK03fDohA_1740753151
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390e271517fso1249201f8f.1
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 06:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753151; x=1741357951;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6l/UTEHr16aTvE/goZAsKRxku8bACld7IrFKN7albE=;
        b=abaYS55Kz7lWBUFfkDwVQPcN3RCoHoZOsVXTLuLPpRIypU6T3J8MQu+3Os0UCcse7m
         /MxBRb5yxgGHhwn7IqRzLEkKprNWN/pOzhvLmC2rA556MmoMVBxdtkgwI7Qqm+RPGHaQ
         X9prBwK7omRsinSN/3b8NCOal9ToffxV526FAAK3vi0Y0s+fH+0de+01dYnuOEAqvTwq
         uPaCBrcA1tXd4qePbtqkY5GAO3iJ2X7mYidFBiIDsy/q6TBslV68dgzQAhMChoGiXraW
         71v3yf3EZIFDFLVPAi10v5T5USYGqZ4pMnEQgxaqf58zMZ5zUvAAKy+JpbEDQZuphejz
         GhOg==
X-Forwarded-Encrypted: i=1; AJvYcCW8U7ObL+lQt3lVWPtOS3WhmU0PZ3WWsnet7CGr4I5qGOzeEUU/lJ5WU+UVP4/tTi1A2plR9KTjPXI55g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwInDw40C9IoSBUxyVPBdeI26QalAb7Ju9o10VQIgl8JKGWKoR1
	U5ef5v1BNzaZKNkISQwZdp0pBr9F5+0YEqtdT73DEqeGgHiYHFPr58s9rVqE3AnYnCO4MOc/Zvk
	tiiVTqLKrs+XUxjm5qab63HVwH7CqAPNoLdnzmY+Ax/5EpAv76pdZ0eeg1po=
X-Gm-Gg: ASbGnctqibetOjVR+rs2M/chkumgtdCAQDz3JgKkj92xDIShdwa100IYa+heoWZEEa+
	5OXapHZcx1yUgXWqzrbgP9E2mJ+G++0SypWkv59Oi7s3Q80SvoWBmD+oD5prsVCJYcntetOSVla
	O+cevMJ6BW/6PuFgTVev7XB7DPZPL1qP8Hu1fRzAQr4lQ6ATtyp//QiRDWFXPb4iUc2N43e07nW
	QJnp8gtNLdVOoDH2Syzqe+5ZqQhGke9+J6KhBWdpedPvcQ5oON7iiwmdey3tfBP+/2mDZ72rbg7
	iVEAixBIihc63RHGLNOhKfSo1FsGLQh4Qho46VQ=
X-Received: by 2002:a5d:6d07:0:b0:38f:277a:4ec0 with SMTP id ffacd0b85a97d-390ec7c8061mr3212784f8f.6.1740753151051;
        Fri, 28 Feb 2025 06:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYV4b0bOoYY/5a9fYi8z+9WZINHyvTUSmcq4Js3mtwnSfnYAtqMRjm0Ic5w2XaJOh/Dcsj7Q==
X-Received: by 2002:a5d:6d07:0:b0:38f:277a:4ec0 with SMTP id ffacd0b85a97d-390ec7c8061mr3212759f8f.6.1740753150732;
        Fri, 28 Feb 2025 06:32:30 -0800 (PST)
Received: from [10.43.17.94] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796084sm5482288f8f.19.2025.02.28.06.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 06:32:30 -0800 (PST)
Message-ID: <535ff54b-5c49-42f0-af5f-020169b5da79@redhat.com>
Date: Fri, 28 Feb 2025 15:32:29 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: gmazyland@gmail.com, regressions@lists.linux.dev
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
 <459b9c3b-0d5e-4797-86f7-4237406608ff@kernel.dk>
Content-Language: en-US
From: Ondrej Kozina <okozina@redhat.com>
Autocrypt: addr=okozina@redhat.com; keydata=
 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
In-Reply-To: <459b9c3b-0d5e-4797-86f7-4237406608ff@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2025 15:08, Jens Axboe wrote:
> On 2/28/25 4:59 AM, Ondrej Kozina wrote:
>> Hi Jens,
>>
>> this patch introduced regression to locked SED OPAL2 devices. The locked region no longer returns -EIO upon IO. On read the caller receives block of zeroes, on write it does not report any error either. In both cases, previous to this patch, the caller would get IO error (expected) with locked device.
>>
>> It was discovered by cryptsetup testsuite specifically https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/tests/compat-test-opal
>>
>> I've attached a simple patch that changes the ioerror condition and it fixed the problem with SED OPAL2 devices for me.
>>
>> #regzbot introduced: 1f47ed294a2bd577d5ae43e6e28e1c9a3be4a833
> 
> Oops thanks - does someone want to send a "real" patch with commit message
> etc, or do you just want me to queue something up?
> 

To be honest, my patch was just a quick hack and I'm not sure if it is 
the correct one in general. But I will test (and report) a fix when it 
lands here.

