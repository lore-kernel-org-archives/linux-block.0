Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3925E81A
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827819; cv=none; b=Fj8v5ZmB6YTSNnooMMPDDhu7CDvwOcK+tuBiA0ngF633TPhdk0lR5QBEZM/izl+h/pO5ZZ4tkA5vAi9ARdf4k0GAjlRpWRI1y9kLqWyI5A7Qg1T2fEnMVoIvXrmJsHbb4ZJKlhp13nusgMu3exc66ULMaTroFy4fp+BdEx0EvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827819; c=relaxed/simple;
	bh=HleYglh6SNoemWJqyHcoVtw2MuympvSfAw3VGgl39t0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k2teBxnsW/DfzDUnU1Rqv8CWvQswxMGfBsacS6XfkzDNSmsQgcnn7pdhzNHDgcDY1KyjzQ1UMaOwuCcaELrquaAdIZIkuygAB+SbHMsIVOcq1zpmcXu/DoieLO2B1IIEeZwU9Lzz2zUkni23YqBVgHsbpNEejFO/g+VWWxcIdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g3OV34OM; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g3OV34OM"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c55500d08cso436960485a.0
        for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742827816; x=1743432616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WJpqac8FkfRl4dKUqOI+g7NBf1RZg0PdmYi66ba3tmk=;
        b=g3OV34OM4gDAq8FIporbLognyWvker+AuUPEyvF4Rv718DPIn5ccEPKLl5qmKsCoX/
         eEGQ5MJkVjkxMddyo7u9og6ydYBo5oOUXHAFQjJfGP4bT3szPXSuVRbNN9osYhhjABTd
         Y85rLTjQTLQcJMN/Lus4SOeKy8lswMQfm2tWqBjnYZ6TV2KJSqLA3uJtdiIyo6hUf8lX
         NqtKY/X2Mn5K0RiEfbQ0Z2r3Q3nAmINuW8nP6/ESeM94YtO4FYcN1G+AC6Qj9DEC5+LY
         N4pmvLZujSIw0ZvkZ4PI9uGxECqD9azY9RQk/y0+CT0I7eWr0/mDb3np6oPSi8D2mQYo
         FjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827816; x=1743432616;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJpqac8FkfRl4dKUqOI+g7NBf1RZg0PdmYi66ba3tmk=;
        b=dMNabwI5JqSmmpatgW9gN9XFkf1nX56EMJRuw1ql0nK1ov//YQw7LGCi2OnDOFsIcE
         47GmnX0K1nImXZNSdyvxu2r2E2bNK+ZaqnAS2HWbGdmXl9X/m561IiMWCP2jGmqNrvpO
         XTCyoaJ8Wui6cYur8rYwMpdvsxnKLiRg5QIKyGAwDmvMg2RxGzUqfoODczFUdSGU4oOB
         guAInTLKPcFrx4UtEBPW4AiPJj5K0jPrpuF/KqzUPhjTbQD8kTcoGuToc993QkFqTNhP
         T2nQX5ATl20cEhFST/kUUYMJevxgoF+AZFpiI9+4VeUzV3KnUUum9brphaUJbaL4XRML
         HHRw==
X-Gm-Message-State: AOJu0YwI5TXwY+42l8YIBNBo1haM+3HfjEMM6MkStleyPiMUKKzcjnbG
	Y+mve1/oC2CBhO1ivp1pBCyGTX2cwIWDyBAnpA1ACUrrB3OVuumNdQT0TX7VzBJ4NwaXyVpbtB6
	nCSo=
X-Gm-Gg: ASbGncszkJK7ebvHUweb+3eYppskIThFidTkWkor65D/taMsQPGM8keq+krd0DRYwcu
	AJvAQMsGCDGx2OaEhU3/NA0+7RcJRmWOqHxeRYJTVVG4PQ7fLnt2uJdSQrNYILQxHEXnhcWhYdN
	Bs099MqA+T9dIsF84JTcxQoGShrbWHADbOmE1j7DTs7vY1fRKtgBRQt1Sw61g9VBuRxxwkYSALd
	xh9aBMj3fgFwwWcwLZV/WYd7GJLaaUISnpH2WCvXCw8IDqhEqjdXe18eC17FAfMrLpsbymq755v
	/eQHU2s/EwJOu+CdO0RLDM93LPcbvwE+QceEvWLApelIlhOhEwZE
X-Google-Smtp-Source: AGHT+IFd6Qt3Tu+MlBCaaufmT6WIx1BbRwRxZfYtd4svimdm5Al9jd5KGVJUXvCyTu5MAy37bMvQKg==
X-Received: by 2002:a05:620a:3906:b0:7c5:4c44:db9a with SMTP id af79cd13be357-7c5ba1ee96emr1722409085a.37.1742827815673;
        Mon, 24 Mar 2025 07:50:15 -0700 (PDT)
Received: from [172.22.32.183] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b935f1c1sm516602285a.117.2025.03.24.07.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 07:50:15 -0700 (PDT)
Message-ID: <aed4f9cd-863b-44b8-bc24-68ac67eb75f2@kernel.dk>
Date: Mon, 24 Mar 2025 08:50:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/5] loop: improve loop aio perf by IOCB_NOWAIT
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jooyung Han <jooyung@google.com>,
 Mike Snitzer <snitzer@kernel.org>, zkabelac@redhat.com,
 dm-devel@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
 Mikulas Patocka <mpatocka@redhat.com>
References: <20250322012617.354222-1-ming.lei@redhat.com>
 <174266520675.800027.959344570613955585.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <174266520675.800027.959344570613955585.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/25 11:40 AM, Jens Axboe wrote:
> 
> On Sat, 22 Mar 2025 09:26:09 +0800, Ming Lei wrote:
>> This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to queue aio
>> command to workqueue context, meantime refactor lo_rw_aio() a bit.
>>
>> In my test VM, loop disk perf becomes very close to perf of the backing block
>> device(nvme/mq virtio-scsi).
>>
>> And Mikulas verified that this way can improve 12jobs sequential rw io by
>> ~5X, and basically solve the reported problem together with loop MQ change.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/5] loop: simplify do_req_filebacked()
>       commit: 04dcb8a909b5b68464ec5ccb123e9614f3ac333d
> [2/5] loop: cleanup lo_rw_aio()
>       commit: 832c9fec8e2314170c5451023565b94f05477aa7
> [3/5] loop: move command blkcg/memcg initialization into loop_queue_work
>       commit: a23d34a31758000b2b158288226bf24f96d8864d
> [4/5] loop: try to handle loop aio command via NOWAIT IO first
>       commit: dfc77a934a3acdb13dadf237b7417c6a31b19da8
> [5/5] loop: add hint for handling aio via IOCB_NOWAIT
>       commit: 4c3f4bad7a6e9022489a9f8392f7147ed3ce74b1

Just a heads-up that I had applied this for testing, not necessarily to
get included. To clear up that confusion, I have retained patches 1-3
for now, and then we can queue up 4-5/5 later when everybody is happy
with them.

-- 
Jens Axboe
