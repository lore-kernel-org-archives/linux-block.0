Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AA18624
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108643; cv=none; b=P75wTPLJrsLYJJ/Ov6TPvR1iDj8J/vBaKVFwpqmuR7VPg+ph0HQMtyuV/DwJ0kaLjYu4O3r506G00LcBU/omX+IS+VLQ/Q1yUHFqOp5a5C4sBIBeX9taenFMYUn5QR1XOA+UKcVqdBHR3AFshfZfO1o576eOLMWYx6Ea3hsIKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108643; c=relaxed/simple;
	bh=plg0Oqamdyq6LHk4NWiibmjhCo9fRB9rF5VFirgM9A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVXYI3NP8op0+p2UdGqbGe2BaaeTrS/jVj4MpJsDHfRIN6kJcYgzoNG5VoE44+EBvv/Jq6RkUAjht1mLQGpB1yI/NQaQPfZA0bhKZRL/suYjysgpQ1C9Gw8JlpVoDcqYLnzFzpB4FLa5ml+0BHvEs6KDU20nwVbX/3m/hKO6T08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IBFjI06G; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IBFjI06G"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bed82030faso73464539f.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 07:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706108641; x=1706713441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QosYFauF2ksuu2Ex5Kpe8kLZd38WjhGStS5b5dWBQYc=;
        b=IBFjI06Gj68KUaCYWTmRH/7ka9IbkQT5oNK1IUyg1nosqU0zD33o0qc0Y53culxxRQ
         WJ2epxEc1gam6CyB6leobxhpGtiExHGwJw4/QYE6dDaon3YtqFMmVuax+x/7DxXu+W+o
         6OqUeHi+D9a8/WS/ZnHfGRhYellSyhLXqUkqy1fjYNrcCvz5wn56zrYAc99pHHBWer6B
         p7bcRUrGGHxlnxIAJWSPzG8lhbE7odBa6WfCw6Um7BlTv+YeVm1VPLGF33QJ19R5C2hf
         zskKvX1tZresu78WGLwXhX2cWxWPhznOzDSIcF45LNDq3WPCP+pwDh6HN47RushoNwBY
         p+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108641; x=1706713441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QosYFauF2ksuu2Ex5Kpe8kLZd38WjhGStS5b5dWBQYc=;
        b=oqGMLYhLwRw7lry/WIJpc1RYDMQywfmmaZQ9HfSOQlHr3ogSlgv6Wnp7KwM30tHAk4
         uCoNeSfVPQ2TNkoeHt/1sroW60lKo4NCqPepGjBb0UmyDIMpUBntRF8hiTe0gvqr2i3Q
         +npFBi2jFNlRECHPilgUBpVvWpInMKKvxc2RQ8u9gGWLJixCgd4Lyn2zVeU3q7SSq+cu
         ZbrkdtwEj+Y8AUC3pnYwAdRbhGAC8QPodh4hGk8JzbwPsST6puCg8glkdmskBSx5f6KX
         E6tLiYPtdqLpYgBJFF+FibWJqVJH6XT9NrIVB4LlUTbNsRuZehBV+gdtyd3DzO030dEV
         FAjg==
X-Gm-Message-State: AOJu0YzpB4dF5QNnoB7FzjQg4sVE6U8kGROXSxyM/bXm4NqIBwoNVYqG
	H3rUnkRNRlqJPrna5JxGdC42CHBkULohfEEX9Ntg4DVeCtI2csdqNyf3sLoFHd1d/ThYE6mimho
	7iL8=
X-Google-Smtp-Source: AGHT+IHfWzHnPEd7Pzy0Bw5Tx8op+Xn+D8pFWK2b2vk+70Wk6/lNmh9xexfWZXK9XkKsOHuof3FeZw==
X-Received: by 2002:a5d:9b8d:0:b0:7bf:4758:2a12 with SMTP id r13-20020a5d9b8d000000b007bf47582a12mr2649849iom.0.1706108641105;
        Wed, 24 Jan 2024 07:04:01 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q20-20020a02a314000000b0046eef94b4dasm1297197jai.170.2024.01.24.07.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:04:00 -0800 (PST)
Message-ID: <ac42af94-5c53-4c03-a601-548bafb2e1da@kernel.dk>
Date: Wed, 24 Jan 2024 08:04:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] block: add blk_time_get_ns() and blk_time_get()
 helpers
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240123173310.1966157-1-axboe@kernel.dk>
 <20240123173310.1966157-3-axboe@kernel.dk> <ZbDYNPsbwQo11Fgv@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbDYNPsbwQo11Fgv@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 2:28 AM, Christoph Hellwig wrote:
> On Tue, Jan 23, 2024 at 10:30:34AM -0700, Jens Axboe wrote:
>> Convert any user of ktime_get_ns() to use blk_time_get_ns(), and
>> ktime_get() to blk_time_get(), so we have a unified API for querying the
>> current time in nanoseconds or as ktime.
>>
>> No functional changes intended, this patch just wraps ktime_get_ns()
>> and ktime_get() with a block helper.
> 
> Given that the helper only is (and only should be) used in the
> block layer code, any reason not to keep it private in block/ ?

I did originally put it in there, but you then run into dependency
issues with needing the struct definitions too, eg for struct blk_plug.
Hence not sure it makes sense, even if logically it'd fit better there.

-- 
Jens Axboe

