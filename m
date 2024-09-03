Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9A18FDBB
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385654; cv=none; b=G1kFmxZX9tqIJolB2rKFVu/EPgpa3ZJDr/dAhuZtwQ2Xf7k3526uM5qcn0lsV1JW7UkPBXTR6O4FzcMecwPUMSmz3/c0/zbG9vNK/6XpruzScNEGEjq6rtAxhrCBMsPa/YBMFHZ+djurkVCpRM6lJVEu7jhRuU+4oPxz4myzHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385654; c=relaxed/simple;
	bh=6iqACrulIDPx0oHo1Y7m/pm0NjD9MxvnwDPjd1qGBas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6UvodgDM06hmR3AAsoTSUkR48CjgoaZvp9FRcwpkNYwb8Joxvfgtdfd081Q+Fgn9xaOtSLK2uamzm5wJ2eUg4rCG2c7d2+lu63Q3NF00FP2vHFBUVw9vCddINjSDXSO1e7CLXUvFU5hhsSk54W+ghMzIJ1v73w5CLiO5MEjMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tF6Rg6I0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tF6Rg6I0"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4f6d8c1eeso551164a12.1
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725385651; x=1725990451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSvLVtVvXAit8yrBPbssxq/Tev/+3coamd9hB3yYjxk=;
        b=tF6Rg6I0Ws/lsNXZR4HEYxHwPqIjLVTLXGOsUzSOEvzJfETHRBRlhvPYW4KpnkZmwn
         0NakjX2K3bIjCPsLUjtdraDw91mrMyVzsYec35zNdo1fEUQLeVO3RRBJV2O0WSJ3QFBG
         rTlfPzaFz9Xdf1/bbszRiGC0iBsWr/MpuFnaK+R1q3TfqYDidikD3VVS6NeFucImTGeg
         zoPR44FozZd3O+GRGL4NBYhJu2y4OgzeJTLs863TVBCSXPoNin/xSw2qXVVIm2BD6hBI
         mdNoS013Mcfke1yl+3CQdcHWnJ9tjyVyAi3WfhA9yea5NKJaSI5hHPB5OekRaQBMU5Vl
         rPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385651; x=1725990451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSvLVtVvXAit8yrBPbssxq/Tev/+3coamd9hB3yYjxk=;
        b=aMywZJXUWkcqiMyBtpb9iV9aDxqCpZXzDh0m9MB13XaK8gyitoc3GwEKhaBwYyQ4f9
         YkQiDZ7euGdn6l9N7pwQR3wKN42UUj9pMRn+2pBjX8LK3ClD4usNzbWaRMI6pkm9/NOK
         tBTSVL/lr0lBlyfFGxJdSDHYFCiHY2xF7kJU12Aa8vyl/VLFCUA2EyBZCVzn6m6HnfR3
         l2bLkRAMcp7O4lIJ9vIW9nxz14mqeGyY8WoAY7zqn3XBJ1hCOudda6LGlAD35gBQue+8
         bkSTYh951RwiXaHzGyRZzdh+fJIH6/IxabqAQWjd6eZQaRNCo05wkZHTsaIsaXwV3S9q
         WRxg==
X-Gm-Message-State: AOJu0YyExTov5oqZjAjOsxLmLU4ssArVspoJpuhZu9VQMtCbjGeR2l4J
	Dlu8w1y0WKycmEmMdi/ppVCM3WItZ+d5KcL9ih9tGxCOQkunO5f5iopiNm5RV5w=
X-Google-Smtp-Source: AGHT+IGdqMAC3mxRQDuveSaKmVGC8Yifvymrjo78+1FD4kiNNhuwHQR98W1ae/UYNh6CYhKIrJAdRQ==
X-Received: by 2002:a05:6a21:3305:b0:1be:aaaf:d0fd with SMTP id adf61e73a8af0-1ced058aae8mr9671887637.49.1725385651298;
        Tue, 03 Sep 2024 10:47:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858bfc9sm134934b3a.124.2024.09.03.10.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 10:47:30 -0700 (PDT)
Message-ID: <174b83d9-e109-441c-867f-36d52687a660@kernel.dk>
Date: Tue, 3 Sep 2024 11:47:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: move non sync requests complete flow to softirq
To: Bart Van Assche <bvanassche@acm.org>, ZhangHui <zhanghui31@xiaomi.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <769fb0e4-6f55-4a2d-a0f2-e8836b790617@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <769fb0e4-6f55-4a2d-a0f2-e8836b790617@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 11:28 AM, Bart Van Assche wrote:
> On 9/3/24 4:54 AM, ZhangHui wrote:
>> Currently, for a controller that supports multiple queues, like UFS4.0,
>> the mq_ops->complete is executed in the interrupt top-half. Therefore,
>> the file system's end io is executed during the request completion process,
>> such as f2fs_write_end_io on smartphone.
>>
>> However, we found that the execution time of the file system end io
>> is strongly related to the size of the bio and the processing speed
>> of the CPU. Because the file system's end io will traverse every page
>> in bio, this is a very time-consuming operation.
>>
>> We measured that the 80M bio write operation on the little CPU will
>> cause the execution time of the top-half to be greater than 100ms.
>> The CPU tick on a smartphone is only 4ms, which will undoubtedly affect
>> scheduling efficiency.
>>
>> Let's fixed this issue by moved non sync request completion flow to
>> softirq, and keep the sync request completion in the top-half.
> 
> An explanation is missing from the patch description why this issue
> cannot be solved by changing rq_affinity to 2.

And what's also missing is a changelog - to the poster, always include
what's changed since the last version posted. Otherwise you just have
3 random patches posted and leave the discovery of why on earth there's
now a v3 to the reader in having to pull in all 3 versions and see if
the progression made sense.

-- 
Jens Axboe


